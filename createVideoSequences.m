%% Script used to extract regularly spaced frames from running videos.
%  The script reads in the videos, taking the first frame as heel strike
%  and then progressing to the next heel strike (see notes below) and then
%  extracting the images every X frames.
%
%  The next heel strike for each of the videos is identified in the first
%  step. Then, images are extracted and put into a sequence.

%% Identify the frames for the next heel strike in each video

%Grounded running
GRvid = VideoReader('GR.mp4');
GRnumFrames = GRvid.NumFrames;
%Set condition for while loop
cont = true;
%Start 175 frames in to save time
ii = 175;
while cont
    %Get and show current frame
    frame = read(GRvid,ii);
    imshow(frame); title(['Frame No. ',num2str(ii)]);
    %Allow pause to view
    pause; close all
    %Identify if next heel strike frame
    heelStrike = input('Next heel strike frame? [Y]es or [N]o: ','s');
    if strcmpi(heelStrike,'y')
        GRstopFrame = ii;
        cont = false;
    else
        %Progress through 5 frames at a time
        ii = ii + 5;
    end    
end

%Preferred aerial running
PARvid = VideoReader('PAR.mp4');
PARnumFrames = PARvid.NumFrames;
%Set condition for while loop
cont = true;
%Start 175 frames in to save time
ii = 175;
while cont
    %Get and show current frame
    frame = read(PARvid,ii);
    imshow(frame); title(['Frame No. ',num2str(ii)]);
    %Allow pause to view
    pause; close all
    %Identify if next heel strike frame
    heelStrike = input('Next heel strike frame? [Y]es or [N]o: ','s');
    if strcmpi(heelStrike,'y')
        PARstopFrame = ii;
        cont = false;
    else
        %Progress through 5 frames at a time
        ii = ii + 5;
    end    
end

%Slow aerial running
SARvid = VideoReader('SAR.mp4');
SARnumFrames = SARvid.NumFrames;
%Set condition for while loop
cont = true;
%Start 175 frames in to save time
ii = 175;
while cont
    %Get and show current frame
    frame = read(SARvid,ii);
    imshow(frame); title(['Frame No. ',num2str(ii)]);
    %Allow pause to view
    pause; close all
    %Identify if next heel strike frame
    heelStrike = input('Next heel strike frame? [Y]es or [N]o: ','s');
    if strcmpi(heelStrike,'y')
        SARstopFrame = ii;
        cont = false;
    else
        %Progress through 5 frames at a time
        ii = ii + 5;
    end    
end

%% Identify cropping boundaries for more portrait style images

%Grounded running

%Get the middle frame between heel strikes and show
%This frame should give a good boundary for both limbs
frame = read(GRvid,round(GRstopFrame/2));
imshow(frame);
%Select the bottom left corner
title('Select BOTTOM LEFT corner for cropping');
GRbottomLeft = ginput(1);
%Select top right corner
title('Select TOP RIGHT corner for cropping');
GRtopRight = ginput(1);
%Close
close all

%Slow aerial running

%Get the middle frame between heel strikes and show
%This frame should give a good boundary for both limbs
frame = read(SARvid,round(SARstopFrame/2));
imshow(frame);
%Select the bottom left corner
title('Select BOTTOM LEFT corner for cropping');
SARbottomLeft = ginput(1);
%Select top right corner
title('Select TOP RIGHT corner for cropping');
SARtopRight = ginput(1);
%Close
close all

%Preferred aerial running

%Get the middle frame between heel strikes and show
%This frame should give a good boundary for both limbs
frame = read(PARvid,round(PARstopFrame/2));
imshow(frame);
%Select the bottom left corner
title('Select BOTTOM LEFT corner for cropping');
PARbottomLeft = ginput(1);
%Select top right corner
title('Select TOP RIGHT corner for cropping');
PARtopRight = ginput(1);
%Close
close all

%% Identify the set of frames to use for each running video
%  This is currently set at n = 10

%Set number of frames in sequences
nFramesSequence = 10;

%Grounded running
%Identify frames to grab from video, evenly spaced
GRgrabFrames = round(linspace(1,GRstopFrame,nFramesSequence));
%Display in loop to check
for ii = 1:length(GRgrabFrames)
    frame = read(GRvid,GRgrabFrames(ii));
    imshow(frame); title('Grounded Running Sequence');
    pause
end
clear ii
close all

%Slow aerial running
%Identify frames to grab from video, evenly spaced
SARgrabFrames = round(linspace(1,SARstopFrame,nFramesSequence));
%Display in loop to check
for ii = 1:length(SARgrabFrames)
    frame = read(SARvid,SARgrabFrames(ii));
    imshow(frame); title('Slow Aerial Running Sequence');
    pause
end
clear ii
close all

%Preferred aerial running
%Identify frames to grab from video, evenly spaced
PARgrabFrames = round(linspace(1,PARstopFrame,nFramesSequence));
%Display in loop to check
for ii = 1:length(PARgrabFrames)
    frame = read(PARvid,PARgrabFrames(ii));
    imshow(frame); title('Preferred Aerial Running Sequence');
    pause
end
clear ii
close all

%% Extract and crop the images

%Grounded running
%Loop through frames to grab
for ii = 1:length(GRgrabFrames)
    %Get the original frame
    frame = read(GRvid,GRgrabFrames(ii));
    %Crop image
    cropFrame = imcrop(frame,...
        [round(GRbottomLeft(1)) ...
        round(GRtopRight(2)) ...
        round(GRtopRight(1))-round(GRbottomLeft(1)) ...
        round(GRbottomLeft(2))-round(GRtopRight(2))]);
    %Store image
    if ii == 1
        GRimages = cropFrame;
    else
        GRimages = [GRimages cropFrame];
    end
end
clear ii

%Slow aerial running
%Loop through frames to grab
for ii = 1:length(SARgrabFrames)
    %Get the original frame
    frame = read(SARvid,SARgrabFrames(ii));
    %Crop image
    cropFrame = imcrop(frame,...
        [round(SARbottomLeft(1)) ...
        round(SARtopRight(2)) ...
        round(SARtopRight(1))-round(SARbottomLeft(1)) ...
        round(SARbottomLeft(2))-round(SARtopRight(2))]);
    %Store image
    if ii == 1
        SARimages = cropFrame;
    else
        SARimages = [SARimages cropFrame];
    end
end
clear ii

%Preferred aerial running
%Loop through frames to grab
for ii = 1:length(PARgrabFrames)
    %Get the original frame
    frame = read(PARvid,PARgrabFrames(ii));
    %Crop image
    cropFrame = imcrop(frame,...
        [round(PARbottomLeft(1)) ...
        round(PARtopRight(2)) ...
        round(PARtopRight(1))-round(PARbottomLeft(1)) ...
        round(PARbottomLeft(2))-round(PARtopRight(2))]);
    %Store image
    if ii == 1
        PARimages = cropFrame;
    else
        PARimages = [PARimages cropFrame];
    end
end
clear ii

%% Display and save the image sequences

%Grounded running
%Plot image
imshow(GRimages)
%Adjust figure size
h = gcf; h.Units = 'inches';
%Get the factor to adjust the width and height to A4 width (i.e. 11.7 inches for landscape width)
scaleFac = 11.7 / h.Position(3);
%Adjust figure size based on scale factor
h.Position = [h.Position(1) h.Position(2) ...
    h.Position(3)*scaleFac h.Position(4)*scaleFac];
%Output figure as 600dpi tif
print(gcf,'GroundedRunningSequence','-dtiff','-r600');
close all

%Slow aerial running
%Plot image
imshow(SARimages)
%Adjust figure size
h = gcf; h.Units = 'inches';
%Get the factor to adjust the width and height to A4 width (i.e. 11.7 inches for landscape width)
scaleFac = 11.7 / h.Position(3);
%Adjust figure size based on scale factor
h.Position = [h.Position(1) h.Position(2) ...
    h.Position(3)*scaleFac h.Position(4)*scaleFac];
%Output figure as 600dpi tif
print(gcf,'SlowAerialRunningSequence','-dtiff','-r600');
close all

%Preferred aerial running
%Plot image
imshow(PARimages)
%Adjust figure size
h = gcf; h.Units = 'inches';
%Get the factor to adjust the width and height to A4 width (i.e. 11.7 inches for landscape width)
scaleFac = 11.7 / h.Position(3);
%Adjust figure size based on scale factor
h.Position = [h.Position(1) h.Position(2) ...
    h.Position(3)*scaleFac h.Position(4)*scaleFac];
%Output figure as 600dpi tif
print(gcf,'PreferredAerialRunningSequence','-dtiff','-r600');
close all
