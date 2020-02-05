From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v1 3/3] virtio-balloon: Switch back to OOM handler for
 VIRTIO_BALLOON_F_DEFLATE_ON_OOM
Date: Wed, 5 Feb 2020 23:52:05 +0100
Message-ID: <7C577D41-AC5C-4094-A280-CBA6ED05C9FB@redhat.com>
References: <CAJuQAmrzQmSJ64ufkA0vOug=HiCikAxJB7O-j8aJCKuNTUnAKQ@mail.gmail.com>
Mime-Version: 1.0 (1.0)
Content-Type: multipart/mixed; boundary="===============9120355971494198680=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAJuQAmrzQmSJ64ufkA0vOug=HiCikAxJB7O-j8aJCKuNTUnAKQ@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Tyler Sanderson <tysand@google.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, Nadav Amit <namit@vmware.com>, David Rientjes <rientjes@google.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, Michal Hocko <mhocko@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

--===============9120355971494198680==
Content-Type: multipart/alternative; boundary=Apple-Mail-F9A6D605-018C-4510-9EDF-244179F93224

--Apple-Mail-F9A6D605-018C-4510-9EDF-244179F93224
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable



> Am 05.02.2020 um 23:37 schrieb Tyler Sanderson <tysand@google.com>:
>=20
> =EF=BB=BF
>=20
>=20
>> On Wed, Feb 5, 2020 at 8:34 AM David Hildenbrand <david@redhat.com> wrot=
e:
>> Commit 71994620bb25 ("virtio_balloon: replace oom notifier with shrinker=
")
>> changed the behavior when deflation happens automatically. Instead of
>> deflating when called by the OOM handler, the shrinker is used.
>>=20
>> However, the balloon is not simply some slab cache that should be
>> shrunk when under memory pressure. The shrinker does not have a concept =
of
>> priorities, so this behavior cannot be configured.
>>=20
>> There was a report that this results in undesired side effects when
>> inflating the balloon to shrink the page cache. [1]
>>         "When inflating the balloon against page cache (i.e. no free mem=
ory
>>          remains) vmscan.c will both shrink page cache, but also invoke =
the
>>          shrinkers -- including the balloon's shrinker. So the balloon
>>          driver allocates memory which requires reclaim, vmscan gets thi=
s
>>          memory by shrinking the balloon, and then the driver adds the
>>          memory back to the balloon. Basically a busy no-op."
>>=20
>> The name "deflate on OOM" makes it pretty clear when deflation should
>> happen - after other approaches to reclaim memory failed, not while
>> reclaiming. This allows to minimize the footprint of a guest - memory
>> will only be taken out of the balloon when really needed.
>>=20
>> Especially, a drop_slab() will result in the whole balloon getting
>> deflated - undesired. While handling it via the OOM handler might not be
>> perfect, it keeps existing behavior. If we want a different behavior, th=
en
>> we need a new feature bit and document it properly (although, there shou=
ld
>> be a clear use case and the intended effects should be well described).
>>=20
>> Keep using the shrinker for VIRTIO_BALLOON_F_FREE_PAGE_HINT, because
>> this has no such side effects. Always register the shrinker with
>> VIRTIO_BALLOON_F_FREE_PAGE_HINT now. We are always allowed to reuse free
>> pages that are still to be processed by the guest. The hypervisor takes
>> care of identifying and resolving possible races between processing a
>> hinting request and the guest reusing a page.
>>=20
>> In contrast to pre commit 71994620bb25 ("virtio_balloon: replace oom
>> notifier with shrinker"), don't add a moodule parameter to configure the
>> number of pages to deflate on OOM. Can be re-added if really needed.
>> Also, pay attention that leak_balloon() returns the number of 4k pages -
>> convert it properly in virtio_balloon_oom_notify().
>>=20
>> Note1: using the OOM handler is frowned upon, but it really is what we
>>        need for this feature.
>>=20
>> Note2: without VIRTIO_BALLOON_F_MUST_TELL_HOST (iow, always with QEMU) w=
e
>>        could actually skip sending deflation requests to our hypervisor,
>>        making the OOM path *very* simple. Besically freeing pages and
>>        updating the balloon. If the communication with the host ever
>>        becomes a problem on this call path.
>>=20
>> [1] https://www.spinics.net/lists/linux-virtualization/msg40863.html
>>=20
>> Reported-by: Tyler Sanderson <tysand@google.com>
>> Cc: Michael S. Tsirkin <mst@redhat.com>
>> Cc: Wei Wang <wei.w.wang@intel.com>
>> Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
>> Cc: David Rientjes <rientjes@google.com>
>> Cc: Nadav Amit <namit@vmware.com>
>> Cc: Michal Hocko <mhocko@kernel.org>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  drivers/virtio/virtio_balloon.c | 107 +++++++++++++-------------------
>>  1 file changed, 44 insertions(+), 63 deletions(-)
>>=20
>> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_bal=
loon.c
>> index 7e5d84caeb94..e7b18f556c5e 100644
>> --- a/drivers/virtio/virtio_balloon.c
>> +++ b/drivers/virtio/virtio_balloon.c
>> @@ -14,6 +14,7 @@
>>  #include <linux/slab.h>
>>  #include <linux/module.h>
>>  #include <linux/balloon_compaction.h>
>> +#include <linux/oom.h>
>>  #include <linux/wait.h>
>>  #include <linux/mm.h>
>>  #include <linux/mount.h>
>> @@ -27,7 +28,9 @@
>>   */
>>  #define VIRTIO_BALLOON_PAGES_PER_PAGE (unsigned)(PAGE_SIZE >> VIRTIO_BA=
LLOON_PFN_SHIFT)
>>  #define VIRTIO_BALLOON_ARRAY_PFNS_MAX 256
>> -#define VIRTBALLOON_OOM_NOTIFY_PRIORITY 80
>> +/* Maximum number of (4k) pages to deflate on OOM notifications. */
>> +#define VIRTIO_BALLOON_OOM_NR_PAGES 256
>> +#define VIRTIO_BALLOON_OOM_NOTIFY_PRIORITY 80
>>=20
>>  #define VIRTIO_BALLOON_FREE_PAGE_ALLOC_FLAG (__GFP_NORETRY | __GFP_NOWA=
RN | \
>>                                              __GFP_NOMEMALLOC)
>> @@ -112,8 +115,11 @@ struct virtio_balloon {
>>         /* Memory statistics */
>>         struct virtio_balloon_stat stats[VIRTIO_BALLOON_S_NR];
>>=20
>> -       /* To register a shrinker to shrink memory upon memory pressure =
*/
>> +       /* Shrinker to return free pages - VIRTIO_BALLOON_F_FREE_PAGE_HI=
NT */
>>         struct shrinker shrinker;
>> +
>> +       /* OOM notifier to deflate on OOM - VIRTIO_BALLOON_F_DEFLATE_ON_=
OOM */
>> +       struct notifier_block oom_nb;
>>  };
>>=20
>>  static struct virtio_device_id id_table[] =3D {
>> @@ -786,50 +792,13 @@ static unsigned long shrink_free_pages(struct virt=
io_balloon *vb,
>>         return blocks_freed * VIRTIO_BALLOON_HINT_BLOCK_PAGES;
>>  }
>>=20
>> -static unsigned long leak_balloon_pages(struct virtio_balloon *vb,
>> -                                          unsigned long pages_to_free)
>> -{
>> -       return leak_balloon(vb, pages_to_free * VIRTIO_BALLOON_PAGES_PER=
_PAGE) /
>> -               VIRTIO_BALLOON_PAGES_PER_PAGE;
>> -}
>> -
>> -static unsigned long shrink_balloon_pages(struct virtio_balloon *vb,
>> -                                         unsigned long pages_to_free)
>> -{
>> -       unsigned long pages_freed =3D 0;
>> -
>> -       /*
>> -        * One invocation of leak_balloon can deflate at most
>> -        * VIRTIO_BALLOON_ARRAY_PFNS_MAX balloon pages, so we call it
>> -        * multiple times to deflate pages till reaching pages_to_free.
>> -        */
>> -       while (vb->num_pages && pages_freed < pages_to_free)
>> -               pages_freed +=3D leak_balloon_pages(vb,
>> -                                                 pages_to_free - pages_=
freed);
>> -
>> -       update_balloon_size(vb);
>> -
>> -       return pages_freed;
>> -}
>> -
>>  static unsigned long virtio_balloon_shrinker_scan(struct shrinker *shri=
nker,
>>                                                   struct shrink_control =
*sc)
>>  {
>> -       unsigned long pages_to_free, pages_freed =3D 0;
>>         struct virtio_balloon *vb =3D container_of(shrinker,
>>                                         struct virtio_balloon, shrinker)=
;
>>=20
>> -       pages_to_free =3D sc->nr_to_scan;
>> -
>> -       if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT=
))
>> -               pages_freed =3D shrink_free_pages(vb, pages_to_free);
>> -
>> -       if (pages_freed >=3D pages_to_free)
>> -               return pages_freed;
>> -
>> -       pages_freed +=3D shrink_balloon_pages(vb, pages_to_free - pages_=
freed);
>> -
>> -       return pages_freed;
>> +       return shrink_free_pages(vb, sc->nr_to_scan);
>>  }
>>=20
>>  static unsigned long virtio_balloon_shrinker_count(struct shrinker *shr=
inker,
>> @@ -837,26 +806,22 @@ static unsigned long virtio_balloon_shrinker_count=
(struct shrinker *shrinker,
>>  {
>>         struct virtio_balloon *vb =3D container_of(shrinker,
>>                                         struct virtio_balloon, shrinker)=
;
>> -       unsigned long count;
>> -
>> -       count =3D vb->num_pages / VIRTIO_BALLOON_PAGES_PER_PAGE;
>> -       count +=3D vb->num_free_page_blocks * VIRTIO_BALLOON_HINT_BLOCK_=
PAGES;
>>=20
>> -       return count;
>> +       return vb->num_free_page_blocks * VIRTIO_BALLOON_HINT_BLOCK_PAGE=
S;
>>  }
>>=20
>> -static void virtio_balloon_unregister_shrinker(struct virtio_balloon *v=
b)
>> +static int virtio_balloon_oom_notify(struct notifier_block *nb,
>> +                                    unsigned long dummy, void *parm)
>>  {
>> -       unregister_shrinker(&vb->shrinker);
>> -}
>> +       struct virtio_balloon *vb =3D container_of(nb,
>> +                                                struct virtio_balloon, =
oom_nb);
>> +       unsigned long *freed =3D parm;
>>=20
>> -static int virtio_balloon_register_shrinker(struct virtio_balloon *vb)
>> -{
>> -       vb->shrinker.scan_objects =3D virtio_balloon_shrinker_scan;
>> -       vb->shrinker.count_objects =3D virtio_balloon_shrinker_count;
>> -       vb->shrinker.seeks =3D DEFAULT_SEEKS;
>> +       *freed +=3D leak_balloon(vb, VIRTIO_BALLOON_OOM_NR_PAGES) /
>> +                 VIRTIO_BALLOON_PAGES_PER_PAGE;
>> +       update_balloon_size(vb);
>>=20
>> -       return register_shrinker(&vb->shrinker);
>> +       return NOTIFY_OK;
>>  }
>>=20
>>  static int virtballoon_probe(struct virtio_device *vdev)
>> @@ -933,22 +898,35 @@ static int virtballoon_probe(struct virtio_device =
*vdev)
>>                         virtio_cwrite(vb->vdev, struct virtio_balloon_co=
nfig,
>>                                       poison_val, &poison_val);
>>                 }
>> -       }
>> -       /*
>> -        * We continue to use VIRTIO_BALLOON_F_DEFLATE_ON_OOM to decide =
if a
>> -        * shrinker needs to be registered to relieve memory pressure.
>> -        */
>> -       if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_DEFLATE_ON_OOM=
)) {
>> -               err =3D virtio_balloon_register_shrinker(vb);
>> +
>> +               /*
>> +                * We're allowed to reuse any free pages, even if they a=
re
>> +                * still to be processed by the host.
> It is important to clarify that pages that are on the inflate queue but n=
ot ACKed by the host (the queue entry has not been returned) are _not_ okay=
 to reuse.
> If the host is going to do something destructive to the page (like deback=
 it) then that needs to happen before the entry is returned.

While you are correct, this comment is in the =E2=80=9Efree page hinting=E2=
=80=9C section/if (not obvious by looking at the diff only), so it does not=
 apply to inflate/deflate queues - but only free pages that are getting hin=
ted. Or am I misreading your suggestion/missing something?

Thanks!



--Apple-Mail-F9A6D605-018C-4510-9EDF-244179F93224
Content-Type: text/html;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><meta http-equiv=3D"content-type" content=3D"text/html; charset=
=3Dutf-8"></head><body dir=3D"auto"><div dir=3D"ltr"><br></div><div dir=3D"=
ltr"><br><blockquote type=3D"cite">Am 05.02.2020 um 23:37 schrieb Tyler San=
derson &lt;tysand@google.com&gt;:<br><br></blockquote></div><blockquote typ=
e=3D"cite"><div dir=3D"ltr">=EF=BB=BF<div dir=3D"ltr"><div dir=3D"ltr"><br>=
</div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">=
On Wed, Feb 5, 2020 at 8:34 AM David Hildenbrand &lt;<a href=3D"mailto:davi=
d@redhat.com">david@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex">Commit 71994620bb25 ("virtio_balloon: replace=
 oom notifier with shrinker")<br>
changed the behavior when deflation happens automatically. Instead of<br>
deflating when called by the OOM handler, the shrinker is used.<br>
<br>
However, the balloon is not simply some slab cache that should be<br>
shrunk when under memory pressure. The shrinker does not have a concept of<=
br>
priorities, so this behavior cannot be configured.<br>
<br>
There was a report that this results in undesired side effects when<br>
inflating the balloon to shrink the page cache. [1]<br>
&nbsp; &nbsp; &nbsp; &nbsp; "When inflating the balloon against page cache =
(i.e. no free memory<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;remains) vmscan.c will both shrink page c=
ache, but also invoke the<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;shrinkers -- including the balloon's shri=
nker. So the balloon<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;driver allocates memory which requires re=
claim, vmscan gets this<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;memory by shrinking the balloon, and then=
 the driver adds the<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;memory back to the balloon. Basically a b=
usy no-op."<br>
<br>
The name "deflate on OOM" makes it pretty clear when deflation should<br>
happen - after other approaches to reclaim memory failed, not while<br>
reclaiming. This allows to minimize the footprint of a guest - memory<br>
will only be taken out of the balloon when really needed.<br>
<br>
Especially, a drop_slab() will result in the whole balloon getting<br>
deflated - undesired. While handling it via the OOM handler might not be<br=
>
perfect, it keeps existing behavior. If we want a different behavior, then<=
br>
we need a new feature bit and document it properly (although, there should<=
br>
be a clear use case and the intended effects should be well described).<br>
<br>
Keep using the shrinker for VIRTIO_BALLOON_F_FREE_PAGE_HINT, because<br>
this has no such side effects. Always register the shrinker with<br>
VIRTIO_BALLOON_F_FREE_PAGE_HINT now. We are always allowed to reuse free<br=
>
pages that are still to be processed by the guest. The hypervisor takes<br>
care of identifying and resolving possible races between processing a<br>
hinting request and the guest reusing a page.<br>
<br>
In contrast to pre commit 71994620bb25 ("virtio_balloon: replace oom<br>
notifier with shrinker"), don't add a moodule parameter to configure the<br=
>
number of pages to deflate on OOM. Can be re-added if really needed.<br>
Also, pay attention that leak_balloon() returns the number of 4k pages -<br=
>
convert it properly in virtio_balloon_oom_notify().<br>
<br>
Note1: using the OOM handler is frowned upon, but it really is what we<br>
&nbsp; &nbsp; &nbsp; &nbsp;need for this feature.<br>
<br>
Note2: without VIRTIO_BALLOON_F_MUST_TELL_HOST (iow, always with QEMU) we<b=
r>
&nbsp; &nbsp; &nbsp; &nbsp;could actually skip sending deflation requests t=
o our hypervisor,<br>
&nbsp; &nbsp; &nbsp; &nbsp;making the OOM path *very* simple. Besically fre=
eing pages and<br>
&nbsp; &nbsp; &nbsp; &nbsp;updating the balloon. If the communication with =
the host ever<br>
&nbsp; &nbsp; &nbsp; &nbsp;becomes a problem on this call path.<br>
<br>
[1] <a href=3D"https://www.spinics.net/lists/linux-virtualization/msg40863.=
html" rel=3D"noreferrer" target=3D"_blank">https://www.spinics.net/lists/li=
nux-virtualization/msg40863.html</a><br>
<br>
Reported-by: Tyler Sanderson &lt;<a href=3D"mailto:tysand@google.com" targe=
t=3D"_blank">tysand@google.com</a>&gt;<br>
Cc: Michael S. Tsirkin &lt;<a href=3D"mailto:mst@redhat.com" target=3D"_bla=
nk">mst@redhat.com</a>&gt;<br>
Cc: Wei Wang &lt;<a href=3D"mailto:wei.w.wang@intel.com" target=3D"_blank">=
wei.w.wang@intel.com</a>&gt;<br>
Cc: Alexander Duyck &lt;<a href=3D"mailto:alexander.h.duyck@linux.intel.com=
" target=3D"_blank">alexander.h.duyck@linux.intel.com</a>&gt;<br>
Cc: David Rientjes &lt;<a href=3D"mailto:rientjes@google.com" target=3D"_bl=
ank">rientjes@google.com</a>&gt;<br>
Cc: Nadav Amit &lt;<a href=3D"mailto:namit@vmware.com" target=3D"_blank">na=
mit@vmware.com</a>&gt;<br>
Cc: Michal Hocko &lt;<a href=3D"mailto:mhocko@kernel.org" target=3D"_blank"=
>mhocko@kernel.org</a>&gt;<br>
Signed-off-by: David Hildenbrand &lt;<a href=3D"mailto:david@redhat.com" ta=
rget=3D"_blank">david@redhat.com</a>&gt;<br>
---<br>
&nbsp;drivers/virtio/virtio_balloon.c | 107 +++++++++++++------------------=
-<br>
&nbsp;1 file changed, 44 insertions(+), 63 deletions(-)<br>
<br>
diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloo=
n.c<br>
index 7e5d84caeb94..e7b18f556c5e 100644<br>
--- a/drivers/virtio/virtio_balloon.c<br>
+++ b/drivers/virtio/virtio_balloon.c<br>
@@ -14,6 +14,7 @@<br>
&nbsp;#include &lt;linux/slab.h&gt;<br>
&nbsp;#include &lt;linux/module.h&gt;<br>
&nbsp;#include &lt;linux/balloon_compaction.h&gt;<br>
+#include &lt;linux/oom.h&gt;<br>
&nbsp;#include &lt;linux/wait.h&gt;<br>
&nbsp;#include &lt;linux/mm.h&gt;<br>
&nbsp;#include &lt;linux/mount.h&gt;<br>
@@ -27,7 +28,9 @@<br>
&nbsp; */<br>
&nbsp;#define VIRTIO_BALLOON_PAGES_PER_PAGE (unsigned)(PAGE_SIZE &gt;&gt; V=
IRTIO_BALLOON_PFN_SHIFT)<br>
&nbsp;#define VIRTIO_BALLOON_ARRAY_PFNS_MAX 256<br>
-#define VIRTBALLOON_OOM_NOTIFY_PRIORITY 80<br>
+/* Maximum number of (4k) pages to deflate on OOM notifications. */<br>
+#define VIRTIO_BALLOON_OOM_NR_PAGES 256<br>
+#define VIRTIO_BALLOON_OOM_NOTIFY_PRIORITY 80<br>
<br>
&nbsp;#define VIRTIO_BALLOON_FREE_PAGE_ALLOC_FLAG (__GFP_NORETRY | __GFP_NO=
WARN | \<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp;__GFP_NOMEMALLOC)<br>
@@ -112,8 +115,11 @@ struct virtio_balloon {<br>
&nbsp; &nbsp; &nbsp; &nbsp; /* Memory statistics */<br>
&nbsp; &nbsp; &nbsp; &nbsp; struct virtio_balloon_stat stats[VIRTIO_BALLOON=
_S_NR];<br>
<br>
-&nbsp; &nbsp; &nbsp; &nbsp;/* To register a shrinker to shrink memory upon=
 memory pressure */<br>
+&nbsp; &nbsp; &nbsp; &nbsp;/* Shrinker to return free pages - VIRTIO_BALLO=
ON_F_FREE_PAGE_HINT */<br>
&nbsp; &nbsp; &nbsp; &nbsp; struct shrinker shrinker;<br>
+<br>
+&nbsp; &nbsp; &nbsp; &nbsp;/* OOM notifier to deflate on OOM - VIRTIO_BALL=
OON_F_DEFLATE_ON_OOM */<br>
+&nbsp; &nbsp; &nbsp; &nbsp;struct notifier_block oom_nb;<br>
&nbsp;};<br>
<br>
&nbsp;static struct virtio_device_id id_table[] =3D {<br>
@@ -786,50 +792,13 @@ static unsigned long shrink_free_pages(struct virtio_=
balloon *vb,<br>
&nbsp; &nbsp; &nbsp; &nbsp; return blocks_freed * VIRTIO_BALLOON_HINT_BLOCK=
_PAGES;<br>
&nbsp;}<br>
<br>
-static unsigned long leak_balloon_pages(struct virtio_balloon *vb,<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; un=
signed long pages_to_free)<br>
-{<br>
-&nbsp; &nbsp; &nbsp; &nbsp;return leak_balloon(vb, pages_to_free * VIRTIO_=
BALLOON_PAGES_PER_PAGE) /<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;VIRTIO_BALLOON_PAGE=
S_PER_PAGE;<br>
-}<br>
-<br>
-static unsigned long shrink_balloon_pages(struct virtio_balloon *vb,<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;uns=
igned long pages_to_free)<br>
-{<br>
-&nbsp; &nbsp; &nbsp; &nbsp;unsigned long pages_freed =3D 0;<br>
-<br>
-&nbsp; &nbsp; &nbsp; &nbsp;/*<br>
-&nbsp; &nbsp; &nbsp; &nbsp; * One invocation of leak_balloon can deflate a=
t most<br>
-&nbsp; &nbsp; &nbsp; &nbsp; * VIRTIO_BALLOON_ARRAY_PFNS_MAX balloon pages,=
 so we call it<br>
-&nbsp; &nbsp; &nbsp; &nbsp; * multiple times to deflate pages till reachin=
g pages_to_free.<br>
-&nbsp; &nbsp; &nbsp; &nbsp; */<br>
-&nbsp; &nbsp; &nbsp; &nbsp;while (vb-&gt;num_pages &amp;&amp; pages_freed =
&lt; pages_to_free)<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;pages_freed +=3D le=
ak_balloon_pages(vb,<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp;pages_to_free - pages_freed);<br>
-<br>
-&nbsp; &nbsp; &nbsp; &nbsp;update_balloon_size(vb);<br>
-<br>
-&nbsp; &nbsp; &nbsp; &nbsp;return pages_freed;<br>
-}<br>
-<br>
&nbsp;static unsigned long virtio_balloon_shrinker_scan(struct shrinker *sh=
rinker,<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; struct shrink_control *sc)<br>
&nbsp;{<br>
-&nbsp; &nbsp; &nbsp; &nbsp;unsigned long pages_to_free, pages_freed =3D 0;=
<br>
&nbsp; &nbsp; &nbsp; &nbsp; struct virtio_balloon *vb =3D container_of(shri=
nker,<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; struct vir=
tio_balloon, shrinker);<br>
<br>
-&nbsp; &nbsp; &nbsp; &nbsp;pages_to_free =3D sc-&gt;nr_to_scan;<br>
-<br>
-&nbsp; &nbsp; &nbsp; &nbsp;if (virtio_has_feature(vb-&gt;vdev, VIRTIO_BALL=
OON_F_FREE_PAGE_HINT))<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;pages_freed =3D shr=
ink_free_pages(vb, pages_to_free);<br>
-<br>
-&nbsp; &nbsp; &nbsp; &nbsp;if (pages_freed &gt;=3D pages_to_free)<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;return pages_freed;=
<br>
-<br>
-&nbsp; &nbsp; &nbsp; &nbsp;pages_freed +=3D shrink_balloon_pages(vb, pages=
_to_free - pages_freed);<br>
-<br>
-&nbsp; &nbsp; &nbsp; &nbsp;return pages_freed;<br>
+&nbsp; &nbsp; &nbsp; &nbsp;return shrink_free_pages(vb, sc-&gt;nr_to_scan)=
;<br>
&nbsp;}<br>
<br>
&nbsp;static unsigned long virtio_balloon_shrinker_count(struct shrinker *s=
hrinker,<br>
@@ -837,26 +806,22 @@ static unsigned long virtio_balloon_shrinker_count(st=
ruct shrinker *shrinker,<br>
&nbsp;{<br>
&nbsp; &nbsp; &nbsp; &nbsp; struct virtio_balloon *vb =3D container_of(shri=
nker,<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; struct vir=
tio_balloon, shrinker);<br>
-&nbsp; &nbsp; &nbsp; &nbsp;unsigned long count;<br>
-<br>
-&nbsp; &nbsp; &nbsp; &nbsp;count =3D vb-&gt;num_pages / VIRTIO_BALLOON_PAG=
ES_PER_PAGE;<br>
-&nbsp; &nbsp; &nbsp; &nbsp;count +=3D vb-&gt;num_free_page_blocks * VIRTIO=
_BALLOON_HINT_BLOCK_PAGES;<br>
<br>
-&nbsp; &nbsp; &nbsp; &nbsp;return count;<br>
+&nbsp; &nbsp; &nbsp; &nbsp;return vb-&gt;num_free_page_blocks * VIRTIO_BAL=
LOON_HINT_BLOCK_PAGES;<br>
&nbsp;}<br>
<br>
-static void virtio_balloon_unregister_shrinker(struct virtio_balloon *vb)<=
br>
+static int virtio_balloon_oom_notify(struct notifier_block *nb,<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; unsigned long dummy, vo=
id *parm)<br>
&nbsp;{<br>
-&nbsp; &nbsp; &nbsp; &nbsp;unregister_shrinker(&amp;vb-&gt;shrinker);<br>
-}<br>
+&nbsp; &nbsp; &nbsp; &nbsp;struct virtio_balloon *vb =3D container_of(nb,<=
br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; struct virtio_balloon, oom_nb);<br>
+&nbsp; &nbsp; &nbsp; &nbsp;unsigned long *freed =3D parm;<br>
<br>
-static int virtio_balloon_register_shrinker(struct virtio_balloon *vb)<br>
-{<br>
-&nbsp; &nbsp; &nbsp; &nbsp;vb-&gt;shrinker.scan_objects =3D virtio_balloon=
_shrinker_scan;<br>
-&nbsp; &nbsp; &nbsp; &nbsp;vb-&gt;shrinker.count_objects =3D virtio_balloo=
n_shrinker_count;<br>
-&nbsp; &nbsp; &nbsp; &nbsp;vb-&gt;shrinker.seeks =3D DEFAULT_SEEKS;<br>
+&nbsp; &nbsp; &nbsp; &nbsp;*freed +=3D leak_balloon(vb, VIRTIO_BALLOON_OOM=
_NR_PAGES) /<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;VIRTIO_BALLO=
ON_PAGES_PER_PAGE;<br>
+&nbsp; &nbsp; &nbsp; &nbsp;update_balloon_size(vb);<br>
<br>
-&nbsp; &nbsp; &nbsp; &nbsp;return register_shrinker(&amp;vb-&gt;shrinker);=
<br>
+&nbsp; &nbsp; &nbsp; &nbsp;return NOTIFY_OK;<br>
&nbsp;}<br>
<br>
&nbsp;static int virtballoon_probe(struct virtio_device *vdev)<br>
@@ -933,22 +898,35 @@ static int virtballoon_probe(struct virtio_device *vd=
ev)<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; virtio_cwrite(vb-&gt;vdev, struct virtio_balloon_config,<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; poison_val, &amp;=
poison_val);<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; }<br>
-&nbsp; &nbsp; &nbsp; &nbsp;}<br>
-&nbsp; &nbsp; &nbsp; &nbsp;/*<br>
-&nbsp; &nbsp; &nbsp; &nbsp; * We continue to use VIRTIO_BALLOON_F_DEFLATE_=
ON_OOM to decide if a<br>
-&nbsp; &nbsp; &nbsp; &nbsp; * shrinker needs to be registered to relieve m=
emory pressure.<br>
-&nbsp; &nbsp; &nbsp; &nbsp; */<br>
-&nbsp; &nbsp; &nbsp; &nbsp;if (virtio_has_feature(vb-&gt;vdev, VIRTIO_BALL=
OON_F_DEFLATE_ON_OOM)) {<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;err =3D virtio_ball=
oon_register_shrinker(vb);<br>
+<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;/*<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; * We're allowed to=
 reuse any free pages, even if they are<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; * still to be proc=
essed by the host.<br></blockquote><div>It is important to clarify that pag=
es that are on the inflate queue but not ACKed by the host (the queue entry=
 has not been returned) are _not_ okay to reuse.</div><div>If the host is g=
oing to do something destructive to the page (like deback it) then that nee=
ds to happen before the entry is returned.</div></div></div>
</div></blockquote><br><div>While you are correct, this comment is in the =
=E2=80=9Efree page hinting=E2=80=9C section/if (not obvious by looking at t=
he diff only), so it does not apply to inflate/deflate queues - but only fr=
ee pages that are getting hinted. Or am I misreading your suggestion/missin=
g something?</div><div><br></div><div>Thanks!</div><div><br></div><div><br>=
</div></body></html>
--Apple-Mail-F9A6D605-018C-4510-9EDF-244179F93224--


--===============9120355971494198680==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============9120355971494198680==--
