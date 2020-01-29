From: Tyler Sanderson via Virtualization
 <virtualization@lists.linux-foundation.org>
Subject: Re: Balloon pressuring page cache
Date: Wed, 29 Jan 2020 11:11:17 -0800
Message-ID: <CAJuQAmoaK0Swytu2Os_SQRfG5_LqiCPaDa9yatatm9MtfncNTQ@mail.gmail.com>
References: <CAJuQAmpDUyve2S+oxp9tLUhuRcnddXnNztC5PmYOOCpY6c68xg@mail.gmail.com>
 <91270a68-ff48-88b0-219c-69801f0c252f@redhat.com>
Reply-To: Tyler Sanderson <tysand@google.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5989323806528501526=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <91270a68-ff48-88b0-219c-69801f0c252f@redhat.com>
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
Cc: David Rientjes <rientjes@google.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

--===============5989323806528501526==
Content-Type: multipart/alternative; boundary="0000000000008b7786059d4c1b63"

--0000000000008b7786059d4c1b63
Content-Type: text/plain; charset="UTF-8"

On Wed, Jan 29, 2020 at 2:31 AM David Hildenbrand <david@redhat.com> wrote:

> On 29.01.20 01:22, Tyler Sanderson via Virtualization wrote:
> > A primary advantage of virtio balloon over other memory reclaim
> > mechanisms is that it can pressure the guest's page cache into shrinking.
> >
> > However, since the balloon driver changed to using the shrinker API
> > <
> https://github.com/torvalds/linux/commit/71994620bb25a8b109388fefa9e99a28e355255a#diff-fd202acf694d9eba19c8c64da3e480c9
> > this
> > use case has become a bit more tricky. I'm wondering what the intended
> > device implementation is.
> >
> > When inflating the balloon against page cache (i.e. no free memory
> > remains) vmscan.c will both shrink page cache, but also invoke the
> > shrinkers -- including the balloon's shrinker. So the balloon driver
> > allocates memory which requires reclaim, vmscan gets this memory by
> > shrinking the balloon, and then the driver adds the memory back to the
> > balloon. Basically a busy no-op.
> >
> > If file IO is ongoing during this balloon inflation then the page cache
> > could be growing which further puts "back pressure" on the balloon
> > trying to inflate. In testing I've seen periods of > 45 seconds where
> > balloon inflation makes no net forward progress.
> >
> > This wasn't a problem before the change to the shrinker API since forced
> > balloon deflation only occurred via the OOM notifier callback which was
> > invoked only after the page cache had depleted.
> >
> > Is this new busy behavior working as intended?
>
> Please note that the shrinker will only be registered in case we have
> VIRTIO_BALLOON_F_DEFLATE_ON_OOM - (which is AFAIK very rare) - to
> implement automatic balloon deflation when the guest is under memory
> pressure.


> Are you actually experiencing issues with that or did you just stumble
> over the code?
>

We have a use case that is encountering this (and that registers
DEFLATE_ON_OOM). We can work around this, but it does seem inefficient.
I understand there were good reasons for moving away from the OOM notifier
callback, but I'm wondering if the balloon driver could specify a "nice"
level to the shrinker API that would cause it to be reclaimed from only as
a last resort?


>
> --
> Thanks,
>
> David / dhildenb
>
>

--0000000000008b7786059d4c1b63
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jan 29, 2020 at 2:31 AM David=
 Hildenbrand &lt;<a href=3D"mailto:david@redhat.com">david@redhat.com</a>&g=
t; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On 29.=
01.20 01:22, Tyler Sanderson via Virtualization wrote:<br>
&gt; A primary advantage of virtio balloon over other=C2=A0memory reclaim<b=
r>
&gt; mechanisms is that it can=C2=A0pressure the guest&#39;s page cache int=
o shrinking.<br>
&gt; <br>
&gt; However, since the balloon driver changed to using the shrinker API<br=
>
&gt; &lt;<a href=3D"https://github.com/torvalds/linux/commit/71994620bb25a8=
b109388fefa9e99a28e355255a#diff-fd202acf694d9eba19c8c64da3e480c9" rel=3D"no=
referrer" target=3D"_blank">https://github.com/torvalds/linux/commit/719946=
20bb25a8b109388fefa9e99a28e355255a#diff-fd202acf694d9eba19c8c64da3e480c9</a=
>&gt;=C2=A0this<br>
&gt; use case has become a bit more tricky. I&#39;m wondering what the inte=
nded<br>
&gt; device implementation is.<br>
&gt; <br>
&gt; When inflating the balloon against page cache (i.e. no free memory<br>
&gt; remains) vmscan.c will both shrink page cache, but also invoke the<br>
&gt; shrinkers -- including the balloon&#39;s shrinker. So the balloon driv=
er<br>
&gt; allocates memory which requires reclaim, vmscan gets this memory by<br=
>
&gt; shrinking the balloon, and then the driver adds the memory back to the=
<br>
&gt; balloon. Basically a busy no-op.<br>
&gt; <br>
&gt; If file IO is ongoing during this balloon inflation then the page cach=
e<br>
&gt; could be growing which further puts &quot;back pressure&quot; on the b=
alloon<br>
&gt; trying to inflate. In testing I&#39;ve seen periods of &gt; 45 seconds=
 where<br>
&gt; balloon inflation makes no net forward progress.<br>
&gt; <br>
&gt; This wasn&#39;t a problem before the change to the shrinker API since =
forced<br>
&gt; balloon deflation only occurred via the OOM notifier callback which wa=
s<br>
&gt; invoked only after the page cache had depleted.<br>
&gt; <br>
&gt; Is this new busy behavior working as intended?<br>
<br>
Please note that the shrinker will only be registered in case we have<br>
VIRTIO_BALLOON_F_DEFLATE_ON_OOM - (which is AFAIK very rare) - to<br>
implement automatic balloon deflation when the guest is under memory<br>
pressure.</blockquote><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Are you actually experiencing issues with that or did you just stumble<br>
over the code?<br></blockquote><div><br></div><div>We have a use case that =
is encountering this (and that registers DEFLATE_ON_OOM). We can work aroun=
d this, but it does seem inefficient.</div><div>I understand there were goo=
d reasons for moving away from the OOM notifier callback, but I&#39;m wonde=
ring if the balloon driver could specify a &quot;nice&quot; level to the sh=
rinker API that would cause it to be reclaimed from only as a last resort?<=
/div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
-- <br>
Thanks,<br>
<br>
David / dhildenb<br>
<br>
</blockquote></div></div>

--0000000000008b7786059d4c1b63--

--===============5989323806528501526==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============5989323806528501526==--
