

function feature_for_voiced_frames = compute_feature_speech (audio_file, feature_number)
       

    % set up dataset path
    dataset_path = 'C:\Users\Mi Zhang\Desktop\VoiceDetection\Datasets\labeledData_selected\';
    label_path = 'C:\Users\Mi Zhang\Desktop\VoiceDetection\Datasets\labeledData_selected_labels\';    

    % load raw audio data
    file_name = strcat(dataset_path, audio_file, '.wav');
    raw_audio_data = wavread(file_name);
       
    % load global parameters
    load global_parameters.mat;
    
    % get frame-level feature values
    features = audio_feature_extraction(raw_audio_data, framesize, framestep, noise_level, num_of_framestep_for_RSE);
    
    % select the feature
    feature = features(:, feature_number);
    
    % load true labels
    label_name = strcat(label_path, audio_file, '_final_label_array.txt');
    final_label_array = csvread(label_name);
    % Fix the BUG: 
    % The number of framesteps of final_label_array is equal to the number of
    % framesteps of inference_result.
    % So I just remove the last framestep of final_label_array
    final_label_array = final_label_array(1:size(features, 1),:);
    
    % only look at the feature of voiced frames
    feature_for_voiced_frames = [];
    for i = 1:length(final_label_array)
        if (final_label_array(i) == 1)        
            feature_for_voiced_frames = [feature_for_voiced_frames; feature(i)];     
        end    
    end
       


    
        

    
    
    

    




