 # Enforce Push-Down of Filters

Filters are generally pushed down during query execution if this does not change the semantics of the query.

Pushdown in this context means that a filter that is defined on a node or in a query becomes effective in lower nodes. Figuratively, the filter is "pushed down" to lower nodes. A pushdown of filters is normally desired because it reduces at an earlier stage the number of records that need to be processed. 

Reducing the number of records early on helps to save resources like memory and CPU and leads to shorter runtimes. Therefore, the pushdown of filters typically happens automatically provided the semantics and thus the results of the query are not affected by it.

Filter pushdown does not occur per default for rank nodes, window function nodes, and nodes that feed into two other nodes. The reason for this is that the level at which the filter is applied (before the node or after the node) has different semantic implications. However, you can force a pushdown even in these situations by using one of the following options:

- allow Filter Push Down – for rank nodes and window function nodes

- ignore Multiple Outputs for Filter – when a node is consumed by two nodes

To benefit from the performance improvements enforced filter pushdown can bring, it is important to have a good understanding of how the options work to avoid unintended semantic implications.

