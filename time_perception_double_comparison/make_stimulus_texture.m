% FUNCTION: Builds the texture for a stimulus. stimulus is either
% "gaussian" (a dark Gaussian blob that fades into the background) or the
% name of an image file ("default" is shorthand for "default.jpg").
function texture = make_stimulus_texture(window, directory_link, stimulus, screenYpixels)
    if stimulus == "gaussian"
        % Blob is drawn out to 3.5 standard deviations, so the visible
        % extent is about 70% of the screen height. The blob is black with
        % an alpha channel set by the Gaussian profile, so the edges blend
        % into whatever background colour is used.
        sigma = 0.1 * screenYpixels;
        half_width = ceil(3.5 * sigma);
        [x, y] = meshgrid(-half_width:half_width, -half_width:half_width);
        blob = zeros(size(x, 1), size(x, 2), 4, 'uint8');
        blob(:, :, 4) = uint8(255 * exp(-(x.^2 + y.^2) / (2 * sigma^2)));
        texture = Screen('MakeTexture', window, blob);
    else
        if stimulus == "default"
            stimulus = "default.jpg";
        end
        stimulus_link = fullfile(directory_link, stimulus);
        texture = Screen('MakeTexture', window, resize_image(imread(stimulus_link), screenYpixels));
    end
end
