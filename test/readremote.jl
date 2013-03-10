urlbase = "http://www.imagemagick.org/Usage/images/"

const savedir = joinpath(tempdir(), "Images")
const writedir = joinpath(savedir, "write")

function getfile(name)
    file = joinpath(savedir, name)
    if !isfile(file)
        file = download(urlbase*name, file)
    end
    file
end

if !isdir(savedir)
    mkdir(savedir)
end
if !isdir(writedir)
    mkdir(writedir)
end

# Gray
file = getfile("pencil_tile.gif")
img = Images.imread(file)
@assert Images.colorspace(img) == "Gray"
@assert ndims(img) == 2
@assert Images.colordim(img) == 0
@assert eltype(img) == Uint8
outname = joinpath(writedir, "pencil_tile.tif")
Images.imwrite(img, outname)
imgc = Images.imread(outname)
@assert img.data == imgc.data


# Gray with alpha channel
file = getfile("gamma_rules.png")
img = Images.imread(file)
@assert Images.colorspace(img) == "GrayAlpha"
@assert ndims(img) == 3
@assert Images.colordim(img) == 3
@assert eltype(img) == Uint8
# outname = joinpath(writedir, "gamma_rules.png")
# Images.imwrite(img, outname)
# imgc = Images.imread(outname)
# @assert img.data == imgc.data

# RGB
file = getfile("rose.png")
img = Images.imread(file)
@assert Images.colorspace(img) == "RGB"
@assert ndims(img) == 3
@assert Images.colordim(img) == 1
@assert size(img, 1) == 3
@assert eltype(img) == Uint8
outname = joinpath(writedir, "rose.ppm")
Images.imwrite(img, outname)
imgc = Images.imread(outname)
@assert img.data == imgc.data

# RGBA with 16 bit depth
file = getfile("autumn_leaves.png")
img = Images.imread(file)
@assert Images.colorspace(img) == "RGBA"
@assert ndims(img) == 3
@assert Images.colordim(img) == 1
@assert size(img, 1) == 4
@assert eltype(img) == Uint16
# outname = joinpath(writedir, "autumn_leaves.png")
# Images.imwrite(img, outname)
# imgc = Images.imread(outname)
# @assert img.data == imgc.data

# Indexed
file = getfile("present.gif")
img = Images.imread(file)