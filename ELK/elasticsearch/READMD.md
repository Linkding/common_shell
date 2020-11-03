### 解决[FORBIDDEN/12/index read-only / allow delete (api)];
```
PUT /twitter/_settings
{
  "index.blocks.read_only_allow_delete": null
}
```
[官网对应解决办法](https://www.elastic.co/guide/en/elasticsearch/reference/current/disk-allocator.html)