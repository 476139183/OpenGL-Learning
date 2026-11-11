import datetime,hashlib,json,os,pathlib,posixpath,re,subprocess,urllib.parse
root=pathlib.Path(os.environ['KNOWLEDGE_ROOT']);target='https://github.com/476139183/OpenGL-Learning'
inventory=json.loads(pathlib.Path('/tmp/opengl-sources-inventory.json').read_text());by_name={r['name']:r for r in inventory}
sources=json.loads(pathlib.Path('/tmp/opengl-import-manifest.json').read_text())
histories={r['name']:r['tags'] for r in json.loads(pathlib.Path('/tmp/opengl-history-manifest.json').read_text())}
labels={'books':'书籍配套代码','examples':'实践示例','notes':'学习笔记'};rewrites=[]
def blob(data):return hashlib.sha1(b'blob '+str(len(data)).encode()+b'\0'+data).hexdigest()
for s in sources:
 base=root/s['destination']
 for f in by_name[s['name']]['tree']:
  if f['type']!='blob' or f['mode']=='120000' or not f['path'].lower().endswith(('.md','.markdown')):continue
  p=base/f['path'];before=p.read_bytes()
  try:text=before.decode('utf-8')
  except UnicodeDecodeError:continue
  def repair(m):
   u=urllib.parse.urlsplit(m.group('url'));dest=base/urllib.parse.unquote(u.path.lstrip('/'))
   if not dest.resolve().is_relative_to(base.resolve()) or not dest.exists():return m.group(0)
   relative=posixpath.relpath(dest.relative_to(base).as_posix(),p.parent.relative_to(base).as_posix())
   return m.group('prefix')+urllib.parse.quote(relative,safe='/@-_.~')+('?' + u.query if u.query else '')+('#'+u.fragment if u.fragment else '')
  text=re.sub(r'''(?P<prefix>\]\(\s*|(?:src|href)=["'])(?P<url>/(?!/)[^\s<>"')]+)''',repair,text)
  for other in sources:
   for kind in ['blob','tree']:
    text=text.replace(other['source_url']+'/'+kind+'/'+other['branch']+'/',target+'/'+kind+'/master/'+other['destination']+'/')
   text=text.replace('https://raw.githubusercontent.com/476139183/'+other['name']+'/'+other['branch']+'/','https://raw.githubusercontent.com/476139183/OpenGL-Learning/master/'+other['destination']+'/')
  after=text.encode('utf-8')
  if before!=after:p.write_bytes(after);rewrites.append({'path':p.relative_to(root).as_posix(),'original_blob':blob(before),'imported_blob':blob(after)})
rewrite_map={r['path']:r['imported_blob'] for r in rewrites};catalog=root/'catalog';catalog.mkdir(exist_ok=True)
for s in sources:
 s['history_tags']=histories[s['name']];s['original_repository_status']='retained_pending_verification'
 s['tracked_files']=[{'path':f['path'],'mode':f['mode'],'source_blob':f['sha'],'imported_blob':rewrite_map.get(s['destination']+'/'+f['path'],f['sha'])} for f in by_name[s['name']]['tree'] if f['type']=='blob']
 text='# '+s['name']+'\n\n[打开归档目录](../'+s['destination']+'/) · [原 Fork]('+s['source_url']+')\n\n'
 text+='- 分类：'+labels[s['destination'].split('/')[1]]+'\n- 上游：https://github.com/'+s['parent']+'\n'
 text+='- 固定来源：`'+s['branch']+'` / `'+s['sha']+'`\n- 文件数：'+str(s['files'])+'\n'
 text+='- 许可证：`'+((s['license'] or {}).get('spdx_id') or '未识别')+'`；以原目录内的许可证与版权声明为准。\n'
 text+='- 原 Fork 状态：完成远端校验后删除。\n- 全部分支与标签历史：'+', '.join('`'+ref.removeprefix('refs/tags/')+'`' for ref in s['history_tags'])+'\n'
 text+='\n工程、资源和原始说明保留；Markdown 链接修复记录与文件校验值见 [manifest.json](manifest.json)。旧工程未宣称已适配当前 Xcode。\n'
 (catalog/(s['name']+'.md')).write_text(text)
manifest={'schema':1,'created_at':datetime.datetime.now(datetime.timezone.utc).isoformat(),'target':target,'original_target_commit':by_name['OpenGL-Learning']['sha'],'scope':'Default-branch snapshots plus all branch/tag histories of four OpenGL forks; original target files preserved. Original forks retained until verification.','sources':sources,'link_rewrites':rewrites}
(catalog/'manifest.json').write_text(json.dumps(manifest,ensure_ascii=False,indent=2)+'\n')
rows=[]
for group,label in labels.items():
 group_rows=[]
 for s in sources:
  if s['destination'].split('/')[1]!=group:continue
  group_rows.append('| ['+s['name']+']('+s['name']+'/) | '+(s['description'] or '').replace('|','／').replace('\n',' ')+' | [来源与版本](../../catalog/'+s['name']+'.md) |')
  rows.append('| ['+s['name']+']('+s['destination']+'/) | '+label+' | [来源、许可证及历史](catalog/'+s['name']+'.md) |')
 (root/'collections'/group/'README.md').write_text('# '+label+'\n\n[返回总目录](../../readme.md)\n\n| 项目 | 内容 | 来源 |\n|---|---|---|\n'+'\n'.join(group_rows)+'\n')
original=subprocess.check_output(['git','-C',str(root),'show',manifest['original_target_commit']+':readme.md']).decode('utf-8')
readme='''# OpenGL 学习与实践资料库

集中保存个人 OpenGL 工程、书籍配套代码、实践示例和学习笔记。各来源独立归档，保留工程内部目录及资源，避免同名文件覆盖。

## 原有个人工程

- [Mac OpenGL 工程](OPenGL-Mac/)
- [OpenGL ES 工程](OpenGL%20ES/)

## 归档分类

| 分类 | 内容 |
|---|---|
| [书籍配套代码](collections/books/) | 两份《OpenGL ES 应用开发实践指南》配套代码 |
| [实践示例](collections/examples/) | 摄像头、视频、滤镜、全景、光照等示例 |
| [学习笔记](collections/notes/) | OpenGL 学习资料及附带笔记 |

详见 [来源清单](SOURCES.md)。4 个 Fork 的默认分支文件已导入，各分支和标签的完整 Git 历史保存在 `legacy/项目名/branches/分支名`、`legacy/项目名/tags/标签名` 中。主仓库原有文件与历史保留。

原 Fork 待完成远端校验后删除。各来源继续适用自己的许可证和版权声明；本仓库不统一重新授权第三方内容。旧项目保留原始工程和依赖，未宣称已在当前 Xcode 编译通过。

运行 `python3 scripts/verify_collections.py` 可校验归档文件和历史标签。

## 原首页

'''
(root/'readme.md').write_text(readme+original)
(root/'SOURCES.md').write_text('# 来源清单\n\n[返回总目录](readme.md)\n\n| 项目 | 分类 | 来源记录 |\n|---|---|---|\n'+'\n'.join(rows)+'\n\n原 Fork 待完成远端校验后删除，具体状态记录在各项目来源页中。\n')
print('OpenGL catalog built; '+str(len(sources))+' sources and '+str(len(rewrites))+' Markdown link repairs.')
