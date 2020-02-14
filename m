From: Tyler Sanderson via Virtualization
 <virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH v1 3/3] virtio-balloon: Switch back to OOM handler for
 VIRTIO_BALLOON_F_DEFLATE_ON_OOM
Date: Fri, 14 Feb 2020 12:48:42 -0800
Message-ID: <CAJuQAmpGKcyWo8Ojnia_pXZAaOt98u0c_Sk-8ieCO218hutW1g@mail.gmail.com>
References: <20200205163402.42627-1-david@redhat.com>
 <20200205163402.42627-4-david@redhat.com>
 <20200214140641.GB31689@dhcp22.suse.cz>
 <802f93b1-1588-bd2c-8238-c12ec7f7ae9e@redhat.com>
Reply-To: Tyler Sanderson <tysand@google.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5193468567358900890=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <802f93b1-1588-bd2c-8238-c12ec7f7ae9e@redhat.com>
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

--===============5193468567358900890==
Content-Type: multipart/alternative; boundary="000000000000685d73059e8f55b9"

--000000000000685d73059e8f55b9
Content-Type: text/plain; charset="UTF-8"

Regarding Wei's patch that modifies the shrinker implementation, versus
this patch which reverts to OOM notifier:
I am in favor of both patches. But I do want to make sure a fix gets back
ported to 4.19 where the performance regression was first introduced.
My concern with reverting to the OOM notifier is, as mst@ put it (in the
other thread):
"when linux hits OOM all kind of error paths are being hit, latent bugs
start triggering, latency goes up drastically."
The guest could be in a lot of pain before the OOM notifier is invoked, and
it seems like the shrinker API might allow more fine grained control of
when we deflate.

On the other hand, I'm not totally convinced that Wei's patch is an
expected use of the shrinker/page-cache APIs, and maybe it is fragile.
Needs more testing and scrutiny.

It seems to me like the shrinker API is the right API in the long run,
perhaps with some fixes and modifications. But maybe reverting to OOM
notifier is the best patch to back port?

On Fri, Feb 14, 2020 at 6:19 AM David Hildenbrand <david@redhat.com> wrote:

> >> There was a report that this results in undesired side effects when
> >> inflating the balloon to shrink the page cache. [1]
> >>      "When inflating the balloon against page cache (i.e. no free memory
> >>       remains) vmscan.c will both shrink page cache, but also invoke the
> >>       shrinkers -- including the balloon's shrinker. So the balloon
> >>       driver allocates memory which requires reclaim, vmscan gets this
> >>       memory by shrinking the balloon, and then the driver adds the
> >>       memory back to the balloon. Basically a busy no-op."
> >>
> >> The name "deflate on OOM" makes it pretty clear when deflation should
> >> happen - after other approaches to reclaim memory failed, not while
> >> reclaiming. This allows to minimize the footprint of a guest - memory
> >> will only be taken out of the balloon when really needed.
> >>
> >> Especially, a drop_slab() will result in the whole balloon getting
> >> deflated - undesired.
> >
> > Could you explain why some more? drop_caches shouldn't be really used in
> > any production workloads and if somebody really wants all the cache to
> > be dropped then why is balloon any different?
> >
>
> Deflation should happen when the guest is out of memory, not when
> somebody thinks it's time to reclaim some memory. That's what the
> feature promised from the beginning: Only give the guest more memory in
> case it *really* needs more memory.
>
> Deflate on oom, not deflate on reclaim/memory pressure. (that's what the
> report was all about)
>
> A priority for shrinkers might be a step into the right direction.
>
> --
> Thanks,
>
> David / dhildenb
>
>

--000000000000685d73059e8f55b9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Regarding Wei&#39;s patch that modifies the shrinker =
implementation, versus this patch which reverts to OOM notifier:</div><div>=
I am in favor of both patches. But I do want to make sure a fix gets back p=
orted to 4.19 where the performance regression was first introduced.</div><=
div>My concern with reverting to the OOM notifier is, as mst@ put it (in th=
e other thread):<br><span style=3D"color:rgb(80,0,80)">&quot;when linux hit=
s OOM=C2=A0</span><span style=3D"color:rgb(80,0,80)">all kind of error path=
s are being hit, latent bugs start triggering,=C2=A0</span><span style=3D"c=
olor:rgb(80,0,80)">latency goes up drastically.&quot;</span><br></div><div>=
The guest could be in a lot of pain before the OOM notifier is invoked, and=
 it seems like the shrinker API might allow more fine grained control of wh=
en we deflate.</div><div><br></div><div>On the other hand, I&#39;m not tota=
lly convinced that Wei&#39;s patch is an expected use of the shrinker/page-=
cache APIs, and maybe it is fragile. Needs more testing=C2=A0and scrutiny.<=
/div><div><br></div><div>It seems to me like the shrinker API is the right =
API in the long run, perhaps with some fixes and modifications. But maybe r=
everting to OOM notifier is the best patch to back port?</div><br><div clas=
s=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Feb 14, 202=
0 at 6:19 AM David Hildenbrand &lt;<a href=3D"mailto:david@redhat.com" targ=
et=3D"_blank">david@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex">&gt;&gt; There was a report that this results=
 in undesired side effects when<br>
&gt;&gt; inflating the balloon to shrink the page cache. [1]<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &quot;When inflating the balloon against page =
cache (i.e. no free memory<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0remains) vmscan.c will both shrink page =
cache, but also invoke the<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0shrinkers -- including the balloon&#39;s=
 shrinker. So the balloon<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0driver allocates memory which requires r=
eclaim, vmscan gets this<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0memory by shrinking the balloon, and the=
n the driver adds the<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0memory back to the balloon. Basically a =
busy no-op.&quot;<br>
&gt;&gt;<br>
&gt;&gt; The name &quot;deflate on OOM&quot; makes it pretty clear when def=
lation should<br>
&gt;&gt; happen - after other approaches to reclaim memory failed, not whil=
e<br>
&gt;&gt; reclaiming. This allows to minimize the footprint of a guest - mem=
ory<br>
&gt;&gt; will only be taken out of the balloon when really needed.<br>
&gt;&gt;<br>
&gt;&gt; Especially, a drop_slab() will result in the whole balloon getting=
<br>
&gt;&gt; deflated - undesired.<br>
&gt; <br>
&gt; Could you explain why some more? drop_caches shouldn&#39;t be really u=
sed in<br>
&gt; any production workloads and if somebody really wants all the cache to=
<br>
&gt; be dropped then why is balloon any different?<br>
&gt; <br>
<br>
Deflation should happen when the guest is out of memory, not when<br>
somebody thinks it&#39;s time to reclaim some memory. That&#39;s what the<b=
r>
feature promised from the beginning: Only give the guest more memory in<br>
case it *really* needs more memory.<br>
<br>
Deflate on oom, not deflate on reclaim/memory pressure. (that&#39;s what th=
e<br>
report was all about)<br>
<br>
A priority for shrinkers might be a step into the right direction.<br>
<br>
-- <br>
Thanks,<br>
<br>
David / dhildenb<br>
<br>
</blockquote></div></div>

--000000000000685d73059e8f55b9--

--===============5193468567358900890==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============5193468567358900890==--
