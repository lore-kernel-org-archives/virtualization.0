From: Tyler Sanderson via Virtualization
 <virtualization@lists.linux-foundation.org>
Subject: Re: Balloon pressuring page cache
Date: Tue, 4 Feb 2020 10:52:42 -0800
Message-ID: <CAJuQAmpiVqnNt-vSkQh5Gg63QZ49_nuz4+VW2Jfwn51gWVdtfA@mail.gmail.com>
References: <CAJuQAmpDUyve2S+oxp9tLUhuRcnddXnNztC5PmYOOCpY6c68xg@mail.gmail.com>
 <91270a68-ff48-88b0-219c-69801f0c252f@redhat.com>
 <CAJuQAmoaK0Swytu2Os_SQRfG5_LqiCPaDa9yatatm9MtfncNTQ@mail.gmail.com>
 <75d4594f-0864-5172-a0f8-f97affedb366@redhat.com>
 <286AC319A985734F985F78AFA26841F73E3F8A02@shsmsx102.ccr.corp.intel.com>
 <CAJuQAmqcayaNuG19fKCuux=YVO3+VcN-qrXvobgKMykogeMkzA@mail.gmail.com>
 <20200203080520-mutt-send-email-mst@kernel.org>
 <5ac131de8e3b7fc1fafd05a61feb5f6889aeb917.camel@linux.intel.com>
 <c836a8d1-c5cc-eb8b-84ed-027070b77bf8@redhat.com>
 <20200203120225-mutt-send-email-mst@kernel.org>
 <CAJuQAmqGA9mhzR5AQeMDtovJAh7y8khC3qUtLKx_e9RdL0wFJQ@mail.gmail.com>
 <74cc25a6-cefb-c580-8e59-5b76fb680bf4@redhat.com>
Reply-To: Tyler Sanderson <tysand@google.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3259729004362866944=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <74cc25a6-cefb-c580-8e59-5b76fb680bf4@redhat.com>
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, namit@vmware.com, David Rientjes <rientjes@google.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, Michal Hocko <mhocko@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

--===============3259729004362866944==
Content-Type: multipart/alternative; boundary="00000000000024c073059dc48c52"

--00000000000024c073059dc48c52
Content-Type: text/plain; charset="UTF-8"

On Tue, Feb 4, 2020 at 12:29 AM David Hildenbrand <david@redhat.com> wrote:

> On 03.02.20 21:32, Tyler Sanderson wrote:
> > There were apparently good reasons for moving away from OOM notifier
> > callback:
> > https://lkml.org/lkml/2018/7/12/314
> > https://lkml.org/lkml/2018/8/2/322
> >
> > In particular the OOM notifier is worse than the shrinker because:
>
> The issue is that DEFLATE_ON_OOM is under-specified.
>
> >
> >  1. It is last-resort, which means the system has already gone through
> >     heroics to prevent OOM. Those heroic reclaim efforts are expensive
> >     and impact application performance.
>
> That's *exactly* what "deflate on OOM" suggests.
>

It seems there are some use cases where "deflate on OOM" is desired and
others where "deflate on pressure" is desired.
This suggests adding a new feature bit "DEFLATE_ON_PRESSURE" that registers
the shrinker, and reverting DEFLATE_ON_OOM to use the OOM notifier callback.

This lets users configure the balloon for their use case.


>
> Assume you are using virtio-balloon for some weird way of memory
> hotunplug (which is what some people do) and you want to minimize the
> footprint of your guest. Then you really only want to give the guest
> more memory (or rather, let it take back memory automatically in this
> case) in case it really needs more memory. It should try to reclaim first.
>
> Under-specified.
>
>
> >  2. It lacks understanding of NUMA or other OOM constraints.
>
> Ballooning in general lacks the understanding of NUMA.
>
> >  3. It has a higher potential for bugs due to the subtlety of the
> >     callback context.
>
> While that is a valid point, it doesn't explain why existing
> functionality is changed.
>
> Personally, I think DEFLATE_ON_OOM should never have been introduced (at
> least not in this form).
>
I'm actually not sure how you would safely do memory overcommit without
DEFLATE_ON_OOM. So I think it unlocks a huge use case.


>
>
> --
> Thanks,
>
> David / dhildenb
>
>

--00000000000024c073059dc48c52
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Feb 4, 2020 at 12:29 AM David=
 Hildenbrand &lt;<a href=3D"mailto:david@redhat.com">david@redhat.com</a>&g=
t; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On 03.=
02.20 21:32, Tyler Sanderson wrote:<br>
&gt; There were apparently good reasons for moving away from OOM notifier<b=
r>
&gt; callback:<br>
&gt; <a href=3D"https://lkml.org/lkml/2018/7/12/314" rel=3D"noreferrer" tar=
get=3D"_blank">https://lkml.org/lkml/2018/7/12/314</a><br>
&gt; <a href=3D"https://lkml.org/lkml/2018/8/2/322" rel=3D"noreferrer" targ=
et=3D"_blank">https://lkml.org/lkml/2018/8/2/322</a><br>
&gt; <br>
&gt; In particular the OOM notifier is worse than the shrinker because:<br>
<br>
The issue is that DEFLATE_ON_OOM is under-specified.<br>
<br>
&gt; <br>
&gt;=C2=A0 1. It is last-resort, which means the system has already gone th=
rough<br>
&gt;=C2=A0 =C2=A0 =C2=A0heroics to prevent OOM. Those heroic reclaim effort=
s are expensive<br>
&gt;=C2=A0 =C2=A0 =C2=A0and impact application performance.<br>
<br>
That&#39;s *exactly* what &quot;deflate on OOM&quot; suggests.<br></blockqu=
ote><div><br></div><div>It seems there are some use cases where &quot;defla=
te on OOM&quot; is desired and others where &quot;deflate on pressure&quot;=
 is desired.</div><div>This suggests adding a new feature bit &quot;DEFLATE=
_ON_PRESSURE&quot; that registers the shrinker, and reverting DEFLATE_ON_OO=
M to use the OOM notifier callback.</div><div><br></div><div>This lets user=
s configure the balloon for their use case.</div><div>=C2=A0</div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">
<br>
Assume you are using virtio-balloon for some weird way of memory<br>
hotunplug (which is what some people do) and you want to minimize the<br>
footprint of your guest. Then you really only want to give the guest<br>
more memory (or rather, let it take back memory automatically in this<br>
case) in case it really needs more memory. It should try to reclaim first.<=
br>
<br>
Under-specified.<br>
<br>
<br>
&gt;=C2=A0 2. It lacks understanding of NUMA or other OOM constraints.<br>
<br>
Ballooning in general lacks the understanding of NUMA.<br>
<br>
&gt;=C2=A0 3. It has a higher potential for bugs due to the subtlety=C2=A0o=
f the<br>
&gt;=C2=A0 =C2=A0 =C2=A0callback context.<br>
<br>
While that is a valid point, it doesn&#39;t explain why existing<br>
functionality is changed.<br>
<br>
Personally, I think DEFLATE_ON_OOM should never have been introduced (at<br=
>
least not in this form).<br></blockquote><div>I&#39;m actually not sure how=
 you would safely do memory overcommit without DEFLATE_ON_OOM. So I think i=
t unlocks a huge use case.</div><div>=C2=A0</div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex">
<br>
<br>
-- <br>
Thanks,<br>
<br>
David / dhildenb<br>
<br>
</blockquote></div></div>

--00000000000024c073059dc48c52--

--===============3259729004362866944==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============3259729004362866944==--
