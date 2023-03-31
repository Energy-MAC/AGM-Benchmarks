function get_rmse(base_line, new_result)
    total_error = 0.0
    val_count = 0
    max_error = 0.0
    error_state = ("random", :random)
    for (gen, states) in new_result.global_index
        for (state, ix) in states
            t, val = get_state_series(new_result, (gen, state))
            for (jx, state_value) in enumerate(val)
                base_state_value = base_line.solution(t[jx]; idxs = ix)
                error = state_value - base_state_value
                if abs(error) > max_error
                    max_error = abs(error)
                    error_state = (gen, state)
                end
                total_error += (error)^2
                val_count += 1
            end
        end
    end
    return sqrt(total_error / val_count), max_error, error_state
end
