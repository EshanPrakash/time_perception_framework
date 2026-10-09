% FUNCTION: Writes the completed trials to a file unique to this session in
% <directory_link>/results. Each session gets its own file, so earlier data is
% never overwritten. Only the first num_completed rows are written.
function filepath = save_results(results, num_completed, directory_link, participant_number, session_id, session_start)
    filepath = "";
    if num_completed < 1
        return
    end
    results_dir = fullfile(directory_link, "results");
    if ~isfolder(results_dir)
        mkdir(results_dir);
    end
    meta = table(repmat(string(session_id), num_completed, 1), ...
        repmat(participant_number, num_completed, 1), ...
        repmat(string(session_start), num_completed, 1), ...
        (1:num_completed)', ...
        'VariableNames', ["Session_ID", "Participant", "Session_Start", "Trial"]);
    filepath = fullfile(results_dir, "dataP" + participant_number + "_" + session_id + ".txt");
    writetable([meta results(1:num_completed, :)], filepath, 'Delimiter', ',');
end
