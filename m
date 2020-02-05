From: Tyler Sanderson via Virtualization
 <virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH v1 3/3] virtio-balloon: Switch back to OOM handler for
 VIRTIO_BALLOON_F_DEFLATE_ON_OOM
Date: Wed, 5 Feb 2020 15:06:27 -0800
Message-ID: <CAJuQAmp8i31stBTLiKK0KhhrChutwKadR9=7s_4K+rnKmsfBoA@mail.gmail.com>
References: <CAJuQAmrzQmSJ64ufkA0vOug=HiCikAxJB7O-j8aJCKuNTUnAKQ@mail.gmail.com>
 <7C577D41-AC5C-4094-A280-CBA6ED05C9FB@redhat.com>
Reply-To: Tyler Sanderson <tysand@google.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2708172818746933992=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <7C577D41-AC5C-4094-A280-CBA6ED05C9FB@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: David Hildenbrand <david@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, Nadav Amit <namit@vmware.com>, David Rientjes <rientjes@google.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, Michal Hocko <mhocko@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

--===============2708172818746933992==
Content-Type: multipart/alternative; boundary="0000000000006c8e4b059ddc3552"

--0000000000006c8e4b059ddc3552
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 5, 2020 at 2:52 PM David Hildenbrand <david@redhat.com> wrote:

>
>
> Am 05.02.2020 um 23:37 schrieb Tyler Sanderson <tysand@google.com>:
>
> =EF=BB=BF
>
>
> On Wed, Feb 5, 2020 at 8:34 AM David Hildenbrand <david@redhat.com> wrote=
:
>
>> Commit 71994620bb25 ("virtio_balloon: replace oom notifier with shrinker=
")
>> changed the behavior when deflation happens automatically. Instead of
>> deflating when called by the OOM handler, the shrinker is used.
>>
>> However, the balloon is not simply some slab cache that should be
>> shrunk when under memory pressure. The shrinker does not have a concept =
of
>> priorities, so this behavior cannot be configured.
>>
>> There was a report that this results in undesired side effects when
>> inflating the balloon to shrink the page cache. [1]
>>         "When inflating the balloon against page cache (i.e. no free
>> memory
>>          remains) vmscan.c will both shrink page cache, but also invoke
>> the
>>          shrinkers -- including the balloon's shrinker. So the balloon
>>          driver allocates memory which requires reclaim, vmscan gets thi=
s
>>          memory by shrinking the balloon, and then the driver adds the
>>          memory back to the balloon. Basically a busy no-op."
>>
>> The name "deflate on OOM" makes it pretty clear when deflation should
>> happen - after other approaches to reclaim memory failed, not while
>> reclaiming. This allows to minimize the footprint of a guest - memory
>> will only be taken out of the balloon when really needed.
>>
>> Especially, a drop_slab() will result in the whole balloon getting
>> deflated - undesired. While handling it via the OOM handler might not be
>> perfect, it keeps existing behavior. If we want a different behavior, th=
en
>> we need a new feature bit and document it properly (although, there shou=
ld
>> be a clear use case and the intended effects should be well described).
>>
>> Keep using the shrinker for VIRTIO_BALLOON_F_FREE_PAGE_HINT, because
>> this has no such side effects. Always register the shrinker with
>> VIRTIO_BALLOON_F_FREE_PAGE_HINT now. We are always allowed to reuse free
>> pages that are still to be processed by the guest. The hypervisor takes
>> care of identifying and resolving possible races between processing a
>> hinting request and the guest reusing a page.
>>
>> In contrast to pre commit 71994620bb25 ("virtio_balloon: replace oom
>> notifier with shrinker"), don't add a moodule parameter to configure the
>> number of pages to deflate on OOM. Can be re-added if really needed.
>> Also, pay attention that leak_balloon() returns the number of 4k pages -
>> convert it properly in virtio_balloon_oom_notify().
>>
>> Note1: using the OOM handler is frowned upon, but it really is what we
>>        need for this feature.
>>
>> Note2: without VIRTIO_BALLOON_F_MUST_TELL_HOST (iow, always with QEMU) w=
e
>>        could actually skip sending deflation requests to our hypervisor,
>>        making the OOM path *very* simple. Besically freeing pages and
>>        updating the balloon. If the communication with the host ever
>>        becomes a problem on this call path.
>>
>> [1] https://www.spinics.net/lists/linux-virtualization/msg40863.html
>>
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
>>
>> diff --git a/drivers/virtio/virtio_balloon.c
>> b/drivers/virtio/virtio_balloon.c
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
>>  #define VIRTIO_BALLOON_PAGES_PER_PAGE (unsigned)(PAGE_SIZE >>
>> VIRTIO_BALLOON_PFN_SHIFT)
>>  #define VIRTIO_BALLOON_ARRAY_PFNS_MAX 256
>> -#define VIRTBALLOON_OOM_NOTIFY_PRIORITY 80
>> +/* Maximum number of (4k) pages to deflate on OOM notifications. */
>> +#define VIRTIO_BALLOON_OOM_NR_PAGES 256
>> +#define VIRTIO_BALLOON_OOM_NOTIFY_PRIORITY 80
>>
>>  #define VIRTIO_BALLOON_FREE_PAGE_ALLOC_FLAG (__GFP_NORETRY |
>> __GFP_NOWARN | \
>>                                              __GFP_NOMEMALLOC)
>> @@ -112,8 +115,11 @@ struct virtio_balloon {
>>         /* Memory statistics */
>>         struct virtio_balloon_stat stats[VIRTIO_BALLOON_S_NR];
>>
>> -       /* To register a shrinker to shrink memory upon memory pressure =
*/
>> +       /* Shrinker to return free pages -
>> VIRTIO_BALLOON_F_FREE_PAGE_HINT */
>>         struct shrinker shrinker;
>> +
>> +       /* OOM notifier to deflate on OOM -
>> VIRTIO_BALLOON_F_DEFLATE_ON_OOM */
>> +       struct notifier_block oom_nb;
>>  };
>>
>>  static struct virtio_device_id id_table[] =3D {
>> @@ -786,50 +792,13 @@ static unsigned long shrink_free_pages(struct
>> virtio_balloon *vb,
>>         return blocks_freed * VIRTIO_BALLOON_HINT_BLOCK_PAGES;
>>  }
>>
>> -static unsigned long leak_balloon_pages(struct virtio_balloon *vb,
>> -                                          unsigned long pages_to_free)
>> -{
>> -       return leak_balloon(vb, pages_to_free *
>> VIRTIO_BALLOON_PAGES_PER_PAGE) /
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
>> -                                                 pages_to_free -
>> pages_freed);
>> -
>> -       update_balloon_size(vb);
>> -
>> -       return pages_freed;
>> -}
>> -
>>  static unsigned long virtio_balloon_shrinker_scan(struct shrinker
>> *shrinker,
>>                                                   struct shrink_control
>> *sc)
>>  {
>> -       unsigned long pages_to_free, pages_freed =3D 0;
>>         struct virtio_balloon *vb =3D container_of(shrinker,
>>                                         struct virtio_balloon, shrinker)=
;
>>
>> -       pages_to_free =3D sc->nr_to_scan;
>> -
>> -       if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT=
))
>> -               pages_freed =3D shrink_free_pages(vb, pages_to_free);
>> -
>> -       if (pages_freed >=3D pages_to_free)
>> -               return pages_freed;
>> -
>> -       pages_freed +=3D shrink_balloon_pages(vb, pages_to_free -
>> pages_freed);
>> -
>> -       return pages_freed;
>> +       return shrink_free_pages(vb, sc->nr_to_scan);
>>  }
>>
>>  static unsigned long virtio_balloon_shrinker_count(struct shrinker
>> *shrinker,
>> @@ -837,26 +806,22 @@ static unsigned long
>> virtio_balloon_shrinker_count(struct shrinker *shrinker,
>>  {
>>         struct virtio_balloon *vb =3D container_of(shrinker,
>>                                         struct virtio_balloon, shrinker)=
;
>> -       unsigned long count;
>> -
>> -       count =3D vb->num_pages / VIRTIO_BALLOON_PAGES_PER_PAGE;
>> -       count +=3D vb->num_free_page_blocks *
>> VIRTIO_BALLOON_HINT_BLOCK_PAGES;
>>
>> -       return count;
>> +       return vb->num_free_page_blocks * VIRTIO_BALLOON_HINT_BLOCK_PAGE=
S;
>>  }
>>
>> -static void virtio_balloon_unregister_shrinker(struct virtio_balloon *v=
b)
>> +static int virtio_balloon_oom_notify(struct notifier_block *nb,
>> +                                    unsigned long dummy, void *parm)
>>  {
>> -       unregister_shrinker(&vb->shrinker);
>> -}
>> +       struct virtio_balloon *vb =3D container_of(nb,
>> +                                                struct virtio_balloon,
>> oom_nb);
>> +       unsigned long *freed =3D parm;
>>
>> -static int virtio_balloon_register_shrinker(struct virtio_balloon *vb)
>> -{
>> -       vb->shrinker.scan_objects =3D virtio_balloon_shrinker_scan;
>> -       vb->shrinker.count_objects =3D virtio_balloon_shrinker_count;
>> -       vb->shrinker.seeks =3D DEFAULT_SEEKS;
>> +       *freed +=3D leak_balloon(vb, VIRTIO_BALLOON_OOM_NR_PAGES) /
>> +                 VIRTIO_BALLOON_PAGES_PER_PAGE;
>> +       update_balloon_size(vb);
>>
>> -       return register_shrinker(&vb->shrinker);
>> +       return NOTIFY_OK;
>>  }
>>
>>  static int virtballoon_probe(struct virtio_device *vdev)
>> @@ -933,22 +898,35 @@ static int virtballoon_probe(struct virtio_device
>> *vdev)
>>                         virtio_cwrite(vb->vdev, struct
>> virtio_balloon_config,
>>                                       poison_val, &poison_val);
>>                 }
>> -       }
>> -       /*
>> -        * We continue to use VIRTIO_BALLOON_F_DEFLATE_ON_OOM to decide
>> if a
>> -        * shrinker needs to be registered to relieve memory pressure.
>> -        */
>> -       if (virtio_has_feature(vb->vdev,
>> VIRTIO_BALLOON_F_DEFLATE_ON_OOM)) {
>> -               err =3D virtio_balloon_register_shrinker(vb);
>> +
>> +               /*
>> +                * We're allowed to reuse any free pages, even if they a=
re
>> +                * still to be processed by the host.
>>
> It is important to clarify that pages that are on the inflate queue but
> not ACKed by the host (the queue entry has not been returned) are _not_
> okay to reuse.
> If the host is going to do something destructive to the page (like deback
> it) then that needs to happen before the entry is returned.
>
>
> While you are correct, this comment is in the =E2=80=9Efree page hinting=
=E2=80=9C
> section/if (not obvious by looking at the diff only), so it does not appl=
y
> to inflate/deflate queues - but only free pages that are getting hinted. =
Or
> am I misreading your suggestion/missing something?
>
Ah you are right. Thanks!

>
> Thanks!
>
>
>

--0000000000006c8e4b059ddc3552
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, Feb 5, 2020 at 2:52 PM David =
Hildenbrand &lt;<a href=3D"mailto:david@redhat.com">david@redhat.com</a>&gt=
; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div di=
r=3D"auto"><div dir=3D"ltr"><br></div><div dir=3D"ltr"><br><blockquote type=
=3D"cite">Am 05.02.2020 um 23:37 schrieb Tyler Sanderson &lt;<a href=3D"mai=
lto:tysand@google.com" target=3D"_blank">tysand@google.com</a>&gt;:<br><br>=
</blockquote></div><blockquote type=3D"cite"><div dir=3D"ltr">=EF=BB=BF<div=
 dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote"><div=
 dir=3D"ltr" class=3D"gmail_attr">On Wed, Feb 5, 2020 at 8:34 AM David Hild=
enbrand &lt;<a href=3D"mailto:david@redhat.com" target=3D"_blank">david@red=
hat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex">Commit 71994620bb25 (&quot;virtio_balloon: replace oom notifier with=
 shrinker&quot;)<br>
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
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;When inflating the balloon against page c=
ache (i.e. no free memory<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0remains) vmscan.c will both shrink page c=
ache, but also invoke the<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0shrinkers -- including the balloon&#39;s =
shrinker. So the balloon<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0driver allocates memory which requires re=
claim, vmscan gets this<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0memory by shrinking the balloon, and then=
 the driver adds the<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0memory back to the balloon. Basically a b=
usy no-op.&quot;<br>
<br>
The name &quot;deflate on OOM&quot; makes it pretty clear when deflation sh=
ould<br>
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
In contrast to pre commit 71994620bb25 (&quot;virtio_balloon: replace oom<b=
r>
notifier with shrinker&quot;), don&#39;t add a moodule parameter to configu=
re the<br>
number of pages to deflate on OOM. Can be re-added if really needed.<br>
Also, pay attention that leak_balloon() returns the number of 4k pages -<br=
>
convert it properly in virtio_balloon_oom_notify().<br>
<br>
Note1: using the OOM handler is frowned upon, but it really is what we<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0need for this feature.<br>
<br>
Note2: without VIRTIO_BALLOON_F_MUST_TELL_HOST (iow, always with QEMU) we<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0could actually skip sending deflation requests t=
o our hypervisor,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0making the OOM path *very* simple. Besically fre=
eing pages and<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0updating the balloon. If the communication with =
the host ever<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0becomes a problem on this call path.<br>
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
=C2=A0drivers/virtio/virtio_balloon.c | 107 +++++++++++++------------------=
-<br>
=C2=A01 file changed, 44 insertions(+), 63 deletions(-)<br>
<br>
diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloo=
n.c<br>
index 7e5d84caeb94..e7b18f556c5e 100644<br>
--- a/drivers/virtio/virtio_balloon.c<br>
+++ b/drivers/virtio/virtio_balloon.c<br>
@@ -14,6 +14,7 @@<br>
=C2=A0#include &lt;linux/slab.h&gt;<br>
=C2=A0#include &lt;linux/module.h&gt;<br>
=C2=A0#include &lt;linux/balloon_compaction.h&gt;<br>
+#include &lt;linux/oom.h&gt;<br>
=C2=A0#include &lt;linux/wait.h&gt;<br>
=C2=A0#include &lt;linux/mm.h&gt;<br>
=C2=A0#include &lt;linux/mount.h&gt;<br>
@@ -27,7 +28,9 @@<br>
=C2=A0 */<br>
=C2=A0#define VIRTIO_BALLOON_PAGES_PER_PAGE (unsigned)(PAGE_SIZE &gt;&gt; V=
IRTIO_BALLOON_PFN_SHIFT)<br>
=C2=A0#define VIRTIO_BALLOON_ARRAY_PFNS_MAX 256<br>
-#define VIRTBALLOON_OOM_NOTIFY_PRIORITY 80<br>
+/* Maximum number of (4k) pages to deflate on OOM notifications. */<br>
+#define VIRTIO_BALLOON_OOM_NR_PAGES 256<br>
+#define VIRTIO_BALLOON_OOM_NOTIFY_PRIORITY 80<br>
<br>
=C2=A0#define VIRTIO_BALLOON_FREE_PAGE_ALLOC_FLAG (__GFP_NORETRY | __GFP_NO=
WARN | \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0__GFP_NOMEMALLOC)<br>
@@ -112,8 +115,11 @@ struct virtio_balloon {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Memory statistics */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct virtio_balloon_stat stats[VIRTIO_BALLOON=
_S_NR];<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0/* To register a shrinker to shrink memory upon=
 memory pressure */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Shrinker to return free pages - VIRTIO_BALLO=
ON_F_FREE_PAGE_HINT */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct shrinker shrinker;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* OOM notifier to deflate on OOM - VIRTIO_BALL=
OON_F_DEFLATE_ON_OOM */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct notifier_block oom_nb;<br>
=C2=A0};<br>
<br>
=C2=A0static struct virtio_device_id id_table[] =3D {<br>
@@ -786,50 +792,13 @@ static unsigned long shrink_free_pages(struct virtio_=
balloon *vb,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return blocks_freed * VIRTIO_BALLOON_HINT_BLOCK=
_PAGES;<br>
=C2=A0}<br>
<br>
-static unsigned long leak_balloon_pages(struct virtio_balloon *vb,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u=
nsigned long pages_to_free)<br>
-{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0return leak_balloon(vb, pages_to_free * VIRTIO_=
BALLOON_PAGES_PER_PAGE) /<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VIRTIO_BALLOON_PAGE=
S_PER_PAGE;<br>
-}<br>
-<br>
-static unsigned long shrink_balloon_pages(struct virtio_balloon *vb,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0un=
signed long pages_to_free)<br>
-{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long pages_freed =3D 0;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * One invocation of leak_balloon can deflate a=
t most<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * VIRTIO_BALLOON_ARRAY_PFNS_MAX balloon pages,=
 so we call it<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * multiple times to deflate pages till reachin=
g pages_to_free.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0while (vb-&gt;num_pages &amp;&amp; pages_freed =
&lt; pages_to_free)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pages_freed +=3D le=
ak_balloon_pages(vb,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0pages_to_free - pages_freed);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0update_balloon_size(vb);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0return pages_freed;<br>
-}<br>
-<br>
=C2=A0static unsigned long virtio_balloon_shrinker_scan(struct shrinker *sh=
rinker,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct shrink_control *sc)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long pages_to_free, pages_freed =3D 0;=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct virtio_balloon *vb =3D container_of(shri=
nker,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct v=
irtio_balloon, shrinker);<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0pages_to_free =3D sc-&gt;nr_to_scan;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (virtio_has_feature(vb-&gt;vdev, VIRTIO_BALL=
OON_F_FREE_PAGE_HINT))<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pages_freed =3D shr=
ink_free_pages(vb, pages_to_free);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (pages_freed &gt;=3D pages_to_free)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return pages_freed;=
<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0pages_freed +=3D shrink_balloon_pages(vb, pages=
_to_free - pages_freed);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0return pages_freed;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return shrink_free_pages(vb, sc-&gt;nr_to_scan)=
;<br>
=C2=A0}<br>
<br>
=C2=A0static unsigned long virtio_balloon_shrinker_count(struct shrinker *s=
hrinker,<br>
@@ -837,26 +806,22 @@ static unsigned long virtio_balloon_shrinker_count(st=
ruct shrinker *shrinker,<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct virtio_balloon *vb =3D container_of(shri=
nker,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct v=
irtio_balloon, shrinker);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long count;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0count =3D vb-&gt;num_pages / VIRTIO_BALLOON_PAG=
ES_PER_PAGE;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0count +=3D vb-&gt;num_free_page_blocks * VIRTIO=
_BALLOON_HINT_BLOCK_PAGES;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0return count;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return vb-&gt;num_free_page_blocks * VIRTIO_BAL=
LOON_HINT_BLOCK_PAGES;<br>
=C2=A0}<br>
<br>
-static void virtio_balloon_unregister_shrinker(struct virtio_balloon *vb)<=
br>
+static int virtio_balloon_oom_notify(struct notifier_block *nb,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned long dummy, v=
oid *parm)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0unregister_shrinker(&amp;vb-&gt;shrinker);<br>
-}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct virtio_balloon *vb =3D container_of(nb,<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 struct virtio_balloon, oom_nb);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long *freed =3D parm;<br>
<br>
-static int virtio_balloon_register_shrinker(struct virtio_balloon *vb)<br>
-{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0vb-&gt;shrinker.scan_objects =3D virtio_balloon=
_shrinker_scan;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0vb-&gt;shrinker.count_objects =3D virtio_balloo=
n_shrinker_count;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0vb-&gt;shrinker.seeks =3D DEFAULT_SEEKS;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0*freed +=3D leak_balloon(vb, VIRTIO_BALLOON_OOM=
_NR_PAGES) /<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VIRTIO_BALLO=
ON_PAGES_PER_PAGE;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0update_balloon_size(vb);<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0return register_shrinker(&amp;vb-&gt;shrinker);=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return NOTIFY_OK;<br>
=C2=A0}<br>
<br>
=C2=A0static int virtballoon_probe(struct virtio_device *vdev)<br>
@@ -933,22 +898,35 @@ static int virtballoon_probe(struct virtio_device *vd=
ev)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 virtio_cwrite(vb-&gt;vdev, struct virtio_balloon_config,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 poison_val, &am=
p;poison_val);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * We continue to use VIRTIO_BALLOON_F_DEFLATE_=
ON_OOM to decide if a<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * shrinker needs to be registered to relieve m=
emory pressure.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (virtio_has_feature(vb-&gt;vdev, VIRTIO_BALL=
OON_F_DEFLATE_ON_OOM)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0err =3D virtio_ball=
oon_register_shrinker(vb);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * We&#39;re allowe=
d to reuse any free pages, even if they are<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * still to be proc=
essed by the host.<br></blockquote><div>It is important to clarify that pag=
es that are on the inflate queue but not ACKed by the host (the queue entry=
 has not been returned) are _not_ okay to reuse.</div><div>If the host is g=
oing to do something destructive to the page (like deback it) then that nee=
ds to happen before the entry is returned.</div></div></div>
</div></blockquote><br><div>While you are correct, this comment is in the =
=E2=80=9Efree page hinting=E2=80=9C section/if (not obvious by looking at t=
he diff only), so it does not apply to inflate/deflate queues - but only fr=
ee pages that are getting hinted. Or am I misreading your suggestion/missin=
g something?</div></div></blockquote><div>Ah you are right. Thanks!=C2=A0</=
div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bor=
der-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"auto"><di=
v><br></div><div>Thanks!</div><div><br></div><div><br></div></div></blockqu=
ote></div></div>

--0000000000006c8e4b059ddc3552--

--===============2708172818746933992==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============2708172818746933992==--
