% FUNCTION: Collects participant response on which image they felt like was
% longer: first or second presented.      
function response = collect_comparison_response(comp_type)
    keylist=zeros(1, 256);
    if comp_type == "shorter/equal/longer"
        keys = [KbName('ESCAPE'), KbName('1!'), KbName('2@'), KbName('3#')];
    else
        keys = [KbName('ESCAPE'), KbName('1!'), KbName('2@')];
    end
    keylist(keys)=1;     
    KbQueueCreate(6, keylist);
    KbQueueStart(6);
    [~, first_press, ~, ~, ~] = KbQueueCheck(6);
    while first_press == 0
        [~, first_press, ~, ~, ~] = KbQueueCheck(6);
    end   
    % Leaves experiment if participant clicks escape key. 
    if KbName(first_press) == "ESCAPE"  
        response = "escape";                                                                                                   
        return  
    % Encodes participant's choice only if it's one of these three. 
    % They can mean different things depending on the experiment.
    elseif comp_type == "shorter/longer"
        if KbName(first_press) == "1!"
            response = "shorter"; 
        elseif KbName(first_press) == "2@"
            response = "longer";
        end
    elseif comp_type == "equal/not equal"
         if KbName(first_press) == "1!"
             response = "equal";
         elseif KbName(first_press) == "2@"
            response = "not equal";
         end
    elseif comp_type == "shorter/equal/longer"
        if KbName(first_press) == "1!"
             response = "shorter";
         elseif KbName(first_press) == "2@"
            response = "equal";
         elseif KbName(first_press) == "3#"
            response = "longer";
        end
    end   
end