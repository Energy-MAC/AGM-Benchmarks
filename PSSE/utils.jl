function get_rmse(base_line, new_result)
    total_error = 0.0
    val_count = 0
    for (gen, states) in new_result.global_index
        for (state, ix) in states
            t, val = get_state_series(new_result, (gen, state))
            for (jx, state_value) in enumerate(val)
                state_value = base_line.solution(t[jx]; idxs = ix)
                total_error += sum((val[jx] - state_value)^2)
                val_count += 1
            end
        end
    end
    return sqrt(total_error / val_count)
end
