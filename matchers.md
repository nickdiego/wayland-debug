# Matchers

Matchers are used throughout wayland-debug to filter messages and set breakpoints. Matchers can leave components of messages unspecified, and use wildcards.

| Matcher               | Description |
| ---                   | --- |
| `wl_surface`          | All events and requests on `wl_surface`s |
| `xdg_*`               | Messages on any XDG type (using a wildcard) |
| `5`                   | Messages on all objects with ID `5` |
| `4b`                  | Messages on object `4b` |
| `.commit`             | `commit` messages on any object |
| `wl_surface.commit`   | `commit` messages on `wl_surface`s |

When objects are destroyed the `wl_display` gets a `.delete_id` message with the object ID of the destroyed object. To make matching these easier, you can also match to `object.destroyed`.

| Matcher                   | Description |
| ---                       | --- |
| `.destroyed`              | Any object being destroyed |
| `wl_surface.destroyed`    | `wl_surface`s being destroyed |

A matcher can be a comma-separated list of patterns, in which case a message that matches any of the cases will match. A list or pattern can be followed by `!` and one or more patterns, in which case any message that matches those is excluded.

| Matcher                           | Description |
| ---                               | --- |
| `wl_pointer, .commit`             | Matches any message on a `wl_surface`, and a `.commit` message on any type |
| `wl_pointer, wl_touch ! .motion ` | all `wl_pointer` and `wl_touch` messages except `.motion` |
| `xdg_* ! xdg_popup, .get_popup`   | matches all messages on XDG types except those relating to popups |

Components of a pattern can be surrounded by braces and use the `positive ! negative` syntax as described above.

| Matcher                           | Description |
| ---                               | --- |
| `55a.[motion, axis]`              | Matches `.motion` and `.axis` events on object `55a` |
| `[wl_pointer ! 55, 62].motion`    | Matches `.motion` events on `wl_pointer`s that do not have object ID `55` or `62` |

The special matchers `*` and `!` match anything and nothing respectively.
