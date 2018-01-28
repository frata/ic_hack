%% 27 January 2018 Miroslav Gasparek
% EpidemicaL recommendation function
% Function that gives patient the recommended course of action

function risk_func(adjacency,p_s,p_d,t_in,t_rec,n_it,n_runs,user_pos,unhealthy)

ill_time = time_to_ill_func(adjacency,p_s,p_d,t_in,t_rec,n_it,n_runs,user_pos,unhealthy);
if (ill_time < input_time)
    risk = (p_s+p_d);
    if (risk < 0.2)
        disp('You are probably ill, but do not worry. Hang around the library.')
    elseif (0.2 <= risk < 0.5)
        disp('You are probably ill, it is nasty one. Hide in the toilets.')
    elseif(0.5 <= risk < 0.8)
        disp('This is more nasty one. Tell your teaching office you are taking day off.')
    elseif(0.8 <= risk < 1.0)
        disp('Consider College health centre. Make them deserve their money.')
    elseif(1 <= risk < 1.5)
        disp('This is urgent. Consider School of medicine, but nothing is guaranteed.')
    elseif(1.5 <= risk < 2)
        disp('Dude, you are done. But no more exam stress... ever')
    end
else
    risk = p_s*p_d;
    if (risk < 0.2)
        disp('You are healthy. Do not panic and read Felix.')
    elseif (0.2 <= risk < 0.5)
        disp('Yourare healthy, but get some preventive visit of Union bar.')
    elseif(0.5 <= risk < 0.8)
        disp('Yo are healthy... but consider hiding in the library.')
    elseif(0.8 <= risk < 1.0)
        disp('You are healthy, but College is dangerous... STAY AT HOME!!')
    end
end