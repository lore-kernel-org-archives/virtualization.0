From: Tyler Sanderson via Virtualization
 <virtualization@lists.linux-foundation.org>
Subject: Re: Balloon pressuring page cache
Date: Thu, 30 Jan 2020 11:59:46 -0800
Message-ID: <CAJuQAmqcayaNuG19fKCuux=YVO3+VcN-qrXvobgKMykogeMkzA@mail.gmail.com>
References: <CAJuQAmpDUyve2S+oxp9tLUhuRcnddXnNztC5PmYOOCpY6c68xg@mail.gmail.com>
 <91270a68-ff48-88b0-219c-69801f0c252f@redhat.com>
 <CAJuQAmoaK0Swytu2Os_SQRfG5_LqiCPaDa9yatatm9MtfncNTQ@mail.gmail.com>
 <75d4594f-0864-5172-a0f8-f97affedb366@redhat.com>
 <286AC319A985734F985F78AFA26841F73E3F8A02@shsmsx102.ccr.corp.intel.com>
Reply-To: Tyler Sanderson <tysand@google.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1314407213910193270=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <286AC319A985734F985F78AFA26841F73E3F8A02@shsmsx102.ccr.corp.intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: "Wang, Wei W" <wei.w.wang@intel.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, David Rientjes <rientjes@google.com>, Michal Hocko <mhocko@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

--===============1314407213910193270==
Content-Type: multipart/alternative; boundary="000000000000c75619059d60e67e"

--000000000000c75619059d60e67e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 30, 2020 at 7:31 AM Wang, Wei W <wei.w.wang@intel.com> wrote:

> On Thursday, January 30, 2020 11:03 PM, David Hildenbrand wrote:
> > On 29.01.20 20:11, Tyler Sanderson wrote:
> > >
> > >
> > > On Wed, Jan 29, 2020 at 2:31 AM David Hildenbrand <david@redhat.com
> > > <mailto:david@redhat.com>> wrote:
> > >
> > >     On 29.01.20 01:22, Tyler Sanderson via Virtualization wrote:
> > >     > A primary advantage of virtio balloon over other memory reclaim
> > >     > mechanisms is that it can pressure the guest's page cache into
> > >     shrinking.
> > >     >
> > >     > However, since the balloon driver changed to using the shrinker
> API
> > >     >
> > >
> > <https://github.com/torvalds/linux/commit/71994620bb25a8b109388fefa9
> > e99a28e355255a#diff-fd202acf694d9eba19c8c64da3e480c9> this
> > >     > use case has become a bit more tricky. I'm wondering what the
> > intended
> > >     > device implementation is.
> > >     >
> > >     > When inflating the balloon against page cache (i.e. no free
> memory
> > >     > remains) vmscan.c will both shrink page cache, but also invoke
> the
> > >     > shrinkers -- including the balloon's shrinker. So the balloon
> driver
> > >     > allocates memory which requires reclaim, vmscan gets this memor=
y
> > by
> > >     > shrinking the balloon, and then the driver adds the memory back
> to
> > the
> > >     > balloon. Basically a busy no-op.
>
> Per my understanding, the balloon allocation won=E2=80=99t invoke shrinke=
r as
> __GFP_DIRECT_RECLAIM isn't set, no?
>
I could be wrong about the mechanism, but the device sees lots of activity
on the deflate queue. The balloon is being shrunk. And this only starts
once all free memory is depleted and we're inflating into page cache.

>
>
> > >     >
> > >     > If file IO is ongoing during this balloon inflation then the pa=
ge
> > >     cache
> > >     > could be growing which further puts "back pressure" on the
> balloon
> > >     > trying to inflate. In testing I've seen periods of > 45 seconds
> where
> > >     > balloon inflation makes no net forward progress.
>
> I think this is intentional (but could be improved). As inflation does no=
t
> stop when the allocation fails (it simply sleeps for a while and resumes.=
.
> repeat till there are memory to inflate)
> That's why you see no inflation progress for long time under memory
> pressure.
>
As noted above the deflate queue is active, so it's not just memory
allocation failures.


>
>
> Best,
> Wei
>

--000000000000c75619059d60e67e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jan 30, 2020 at 7:31 AM Wang,=
 Wei W &lt;<a href=3D"mailto:wei.w.wang@intel.com">wei.w.wang@intel.com</a>=
&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On T=
hursday, January 30, 2020 11:03 PM, David Hildenbrand wrote:<br>
&gt; On 29.01.20 20:11, Tyler Sanderson wrote:<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; On Wed, Jan 29, 2020 at 2:31 AM David Hildenbrand &lt;<a href=3D"=
mailto:david@redhat.com" target=3D"_blank">david@redhat.com</a><br>
&gt; &gt; &lt;mailto:<a href=3D"mailto:david@redhat.com" target=3D"_blank">=
david@redhat.com</a>&gt;&gt; wrote:<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0On 29.01.20 01:22, Tyler Sanderson via Virtual=
ization wrote:<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt; A primary advantage of virtio balloon ove=
r other=C2=A0memory reclaim<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt; mechanisms is that it can=C2=A0pressure t=
he guest&#39;s page cache into<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0shrinking.<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt; However, since the balloon driver changed=
 to using the shrinker API<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt; &gt;<br>
&gt; &lt;<a href=3D"https://github.com/torvalds/linux/commit/71994620bb25a8=
b109388fefa9" rel=3D"noreferrer" target=3D"_blank">https://github.com/torva=
lds/linux/commit/71994620bb25a8b109388fefa9</a><br>
&gt; e99a28e355255a#diff-fd202acf694d9eba19c8c64da3e480c9&gt;=C2=A0this<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt; use case has become a bit more tricky. I&=
#39;m wondering what the<br>
&gt; intended<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt; device implementation is.<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt; When inflating the balloon against page c=
ache (i.e. no free memory<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt; remains) vmscan.c will both shrink page c=
ache, but also invoke the<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt; shrinkers -- including the balloon&#39;s =
shrinker. So the balloon driver<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt; allocates memory which requires reclaim, =
vmscan gets this memory<br>
&gt; by<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt; shrinking the balloon, and then the drive=
r adds the memory back to<br>
&gt; the<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt; balloon. Basically a busy no-op.<br>
<br>
Per my understanding, the balloon allocation won=E2=80=99t invoke shrinker =
as __GFP_DIRECT_RECLAIM isn&#39;t set, no?<br></blockquote><div>I could be =
wrong about the mechanism, but the device sees lots of activity on the defl=
ate queue. The balloon is being shrunk. And this only starts once all free =
memory is depleted and we&#39;re inflating into page cache.</div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex">
<br>
<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt; If file IO is ongoing during this balloon=
 inflation then the page<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0cache<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt; could be growing which further puts &quot=
;back pressure&quot; on the balloon<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt; trying to inflate. In testing I&#39;ve se=
en periods of &gt; 45 seconds where<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt; balloon inflation makes no net forward pr=
ogress.<br>
<br>
I think this is intentional (but could be improved). As inflation does not =
stop when the allocation fails (it simply sleeps for a while and resumes.. =
repeat till there are memory to inflate)<br>
That&#39;s why you see no inflation progress for long time under memory pre=
ssure.<br></blockquote><div>As noted above the deflate queue is active, so =
it&#39;s not just memory allocation failures.</div><div>=C2=A0</div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex">
<br>
<br>
Best,<br>
Wei<br>
</blockquote></div></div>

--000000000000c75619059d60e67e--

--===============1314407213910193270==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============1314407213910193270==--
