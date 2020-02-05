From: Tyler Sanderson via Virtualization
 <virtualization@lists.linux-foundation.org>
Subject: Re: Balloon pressuring page cache
Date: Wed, 5 Feb 2020 11:01:15 -0800
Message-ID: <CAJuQAmrAbkd+VNRVzC+J5wPyoyuWCavfE07ANvkFwufyz58=Xg@mail.gmail.com>
References: <CAJuQAmqcayaNuG19fKCuux=YVO3+VcN-qrXvobgKMykogeMkzA@mail.gmail.com>
 <20200203080520-mutt-send-email-mst@kernel.org>
 <5ac131de8e3b7fc1fafd05a61feb5f6889aeb917.camel@linux.intel.com>
 <c836a8d1-c5cc-eb8b-84ed-027070b77bf8@redhat.com>
 <20200203120225-mutt-send-email-mst@kernel.org>
 <CAJuQAmqGA9mhzR5AQeMDtovJAh7y8khC3qUtLKx_e9RdL0wFJQ@mail.gmail.com>
 <74cc25a6-cefb-c580-8e59-5b76fb680bf4@redhat.com>
 <CAJuQAmpiVqnNt-vSkQh5Gg63QZ49_nuz4+VW2Jfwn51gWVdtfA@mail.gmail.com>
 <b809340d-7e86-caf6-bf12-db7bb8265045@redhat.com>
 <CAJuQAmqeKvc_k7pmDuC1b+w6yezzHoSxZJ8WW5sHVo1yMsRPfg@mail.gmail.com>
 <20200205015057-mutt-send-email-mst@kernel.org>
Reply-To: Tyler Sanderson <tysand@google.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6952645948082930302=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200205015057-mutt-send-email-mst@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, namit@vmware.com, David Rientjes <rientjes@google.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, Michal Hocko <mhocko@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

--===============6952645948082930302==
Content-Type: multipart/alternative; boundary="000000000000a36cc8059dd8c819"

--000000000000a36cc8059dd8c819
Content-Type: text/plain; charset="UTF-8"

On Tue, Feb 4, 2020 at 10:57 PM Michael S. Tsirkin <mst@redhat.com> wrote:

> On Tue, Feb 04, 2020 at 03:58:51PM -0800, Tyler Sanderson wrote:
> >     >     >
> >     >     >  1. It is last-resort, which means the system has already
> gone     through
> >     >     >     heroics to prevent OOM. Those heroic reclaim efforts
> are     expensive
> >     >     >     and impact application performance.
> >     >
> >     >     That's *exactly* what "deflate on OOM" suggests.
> >     >
> >     >
> >     > It seems there are some use cases where "deflate on OOM" is
> desired and
> >     > others where "deflate on pressure" is desired.
> >     > This suggests adding a new feature bit "DEFLATE_ON_PRESSURE" that
> >     > registers the shrinker, and reverting DEFLATE_ON_OOM to use the OOM
> >     > notifier callback.
> >     >
> >     > This lets users configure the balloon for their use case.
> >
> >     You want the old behavior back, so why should we introduce a new
> one? Or
> >     am I missing something? (you did want us to revert to old handling,
> no?)
> >
> > Reverting actually doesn't help me because this has been the behavior
> since
> > Linux 4.19 which is already widely in use. So my device implementation
> needs to
> > handle the shrinker behavior anyways. I started this conversation to ask
> what
> > the intended device implementation was.
> >
> > I think there are reasonable device implementations that would prefer the
> > shrinker behavior (it turns out that mine doesn't).
> > For example, an implementation that slowly inflates the balloon for the
> purpose
> > of memory overcommit. It might leave the balloon inflated and expect any
> memory
> > pressure (including page cache usage) to deflate the balloon as a way to
> > dynamically right-size the balloon.
>
> So just to make sure we understand, what exactly does your
> implementation do?
>
My implementation is for the purposes of opportunistic memory overcommit.
We always want to give balloon memory back to the guest rather than causing
an OOM, so we use DEFLATE_ON_OOM.
We leave the balloon at size 0 while monitoring memory statistics reported
on the stats queue. When we see there is an opportunity for significant
savings then we inflate the balloon to a desired size (possibly including
pressuring the page cache), and then immediately deflate back to size 0.
The host pages backing the guest pages are unbacked during the inflation
process, so the memory footprint of the guest is smaller after this
inflate/deflate cycle.


>
> > Two reasons I didn't go with the above implementation:
> > 1. I need to support guests before Linux 4.19 which don't have the
> shrinker
> > behavior.
> > 2. Memory in the balloon does not appear as "available" in /proc/meminfo
> even
> > though it is freeable. This is confusing to users, but isn't a deal
> breaker.
> >
> > If we added a DEFLATE_ON_PRESSURE feature bit that indicated shrinker API
> > support then that would resolve reason #1 (ideally we would backport the
> bit to
> > 4.19).
>
> We could declare lack of pagecache pressure with DEFLATE_ON_OOM a
> regression and backport the revert but not I think the new
> DEFLATE_ON_PRESSURE.
>
To be clear, the page cache can still be pressured. When the balloon driver
allocates memory and causes reclaim, some of that memory comes from the
balloon (bad) but some of that comes from the page cache (good).


>
>
> > In any case, the shrinker behavior when pressuring page cache is more of
> an
> > inefficiency than a bug. It's not clear to me that it necessitates
> reverting.
> > If there were/are reasons to be on the shrinker interface then I think
> those
> > carry similar weight as the problem itself.
> >
> >
> >
> >     I consider virtio-balloon to this very day a big hack. And I don't
> see
> >     it getting better with new config knobs. Having that said, the
> >     technologies that are candidates to replace it (free page reporting,
> >     taming the guest page cache, etc.) are still not ready - so we'll
> have
> >     to stick with it for now :( .
> >
> >     >
> >     > I'm actually not sure how you would safely do memory overcommit
> without
> >     > DEFLATE_ON_OOM. So I think it unlocks a huge use case.
> >
> >     Using better suited technologies that are not ready yet (well, some
> form
> >     of free page reporting is available under IBM z already but in a
> >     proprietary form) ;) Anyhow, I remember that DEFLATE_ON_OOM only
> makes
> >     it less likely to crash your guest, but not that you are safe to
> squeeze
> >     the last bit out of your guest VM.
> >
> > Can you elaborate on the danger of DEFLATE_ON_OOM? I haven't seen any
> problems
> > in testing but I'd really like to know about the dangers.
> > Is there a difference in safety between the OOM notifier callback and the
> > shrinker API?
>
> It's not about dangers as such. It's just that when linux hits OOM
> all kind of error paths are being hit, latent bugs start triggering,
> latency goes up drastically.

Doesn't this suggest that the shrinker is preferable to the OOM notifier in
the case that we're actually OOMing (with DEFLATE_ON_OOM)?


>
> >
> >
> >     --
> >     Thanks,
> >
> >     David / dhildenb
> >
> >
>
>

--000000000000a36cc8059dd8c819
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Feb 4, 2020 at 10:57 PM Micha=
el S. Tsirkin &lt;<a href=3D"mailto:mst@redhat.com">mst@redhat.com</a>&gt; =
wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Tue, F=
eb 04, 2020 at 03:58:51PM -0800, Tyler Sanderson wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 1. It is last-re=
sort, which means the system has already gone=C2=A0 =C2=A0 =C2=A0through<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0her=
oics to prevent OOM. Those heroic reclaim efforts are=C2=A0 =C2=A0 =C2=A0ex=
pensive<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0and=
 impact application performance.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0That&#39;s *exactly* what &=
quot;deflate on OOM&quot; suggests.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; It seems there are some use cases where &quot;=
deflate on OOM&quot; is desired and<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; others where &quot;deflate on pressure&quot; i=
s desired.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; This suggests adding a new feature bit &quot;D=
EFLATE_ON_PRESSURE&quot; that<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; registers the shrinker, and reverting DEFLATE_=
ON_OOM to use the OOM<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; notifier callback.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; This lets users configure the balloon for thei=
r use case.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0You want the old behavior back, so why should we in=
troduce a new one? Or<br>
&gt;=C2=A0 =C2=A0 =C2=A0am I missing something? (you did want us to revert =
to old handling, no?)<br>
&gt; <br>
&gt; Reverting actually doesn&#39;t help me because this has been the behav=
ior since<br>
&gt; Linux 4.19 which is already widely in use. So my device implementation=
 needs to<br>
&gt; handle the shrinker behavior anyways. I started this conversation to a=
sk what<br>
&gt; the intended device implementation was.<br>
&gt; <br>
&gt; I think there are reasonable device implementations that would prefer =
the<br>
&gt; shrinker=C2=A0behavior (it turns out that mine doesn&#39;t).<br>
&gt; For example, an implementation that slowly inflates the balloon for th=
e purpose<br>
&gt; of memory overcommit. It might leave the balloon inflated and expect a=
ny memory<br>
&gt; pressure (including page cache usage) to deflate the balloon as a way =
to<br>
&gt; dynamically right-size the balloon.<br>
<br>
So just to make sure we understand, what exactly does your<br>
implementation do?<br></blockquote><div>My implementation is for the purpos=
es of opportunistic memory overcommit. We always want to give balloon memor=
y back to the guest rather than causing an OOM, so we use DEFLATE_ON_OOM.</=
div><div>We leave the balloon at size 0 while monitoring memory statistics =
reported on the stats queue. When we see there is an opportunity for signif=
icant savings then we inflate the balloon to a desired size (possibly inclu=
ding pressuring the page cache), and then immediately deflate back to size =
0.</div><div>The host pages backing the guest pages are unbacked during the=
 inflation process, so the memory footprint of the guest is smaller after t=
his inflate/deflate cycle.</div><div><br></div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex">
<br>
<br>
&gt; Two reasons I didn&#39;t go with the above implementation:<br>
&gt; 1. I need to support guests before Linux 4.19 which don&#39;t have the=
 shrinker<br>
&gt; behavior.<br>
&gt; 2. Memory in the balloon does not appear as &quot;available&quot; in /=
proc/meminfo even<br>
&gt; though it is freeable. This is confusing to users, but isn&#39;t a dea=
l breaker.<br>
&gt; <br>
&gt; If we added a DEFLATE_ON_PRESSURE feature bit that indicated shrinker =
API<br>
&gt; support then that would resolve reason=C2=A0#1 (ideally we would backp=
ort the bit to<br>
&gt; 4.19).<br>
<br>
We could declare lack of pagecache pressure with DEFLATE_ON_OOM a<br>
regression and backport the revert but not I think the new<br>
DEFLATE_ON_PRESSURE.<br></blockquote><div>To be clear, the page cache can s=
till be pressured. When the balloon driver allocates memory and causes recl=
aim, some of that memory comes from the balloon (bad) but some of that come=
s from the page cache (good).</div><div>=C2=A0</div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex">
<br>
<br>
&gt; In any case, the shrinker=C2=A0behavior when pressuring page cache is =
more of an<br>
&gt; inefficiency than a bug. It&#39;s not clear to me that it necessitates=
 reverting.<br>
&gt; If there were/are reasons to be on the shrinker=C2=A0interface then I =
think those<br>
&gt; carry similar weight as the problem itself.<br>
&gt; =C2=A0<br>
&gt; <br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0I consider virtio-balloon to this very day a big ha=
ck. And I don&#39;t see<br>
&gt;=C2=A0 =C2=A0 =C2=A0it getting better with new config knobs. Having tha=
t said, the<br>
&gt;=C2=A0 =C2=A0 =C2=A0technologies that are candidates to replace it (fre=
e page reporting,<br>
&gt;=C2=A0 =C2=A0 =C2=A0taming the guest page cache, etc.) are still not re=
ady - so we&#39;ll have<br>
&gt;=C2=A0 =C2=A0 =C2=A0to stick with it for now :( .<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; I&#39;m actually not sure how you would safely=
 do memory overcommit without<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; DEFLATE_ON_OOM. So I think it unlocks a huge u=
se case.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Using better suited technologies that are not ready=
 yet (well, some form<br>
&gt;=C2=A0 =C2=A0 =C2=A0of free page reporting is available under IBM z alr=
eady but in a<br>
&gt;=C2=A0 =C2=A0 =C2=A0proprietary form) ;) Anyhow, I remember that DEFLAT=
E_ON_OOM only makes<br>
&gt;=C2=A0 =C2=A0 =C2=A0it less likely to crash your guest, but not that yo=
u are safe to squeeze<br>
&gt;=C2=A0 =C2=A0 =C2=A0the last bit out of your guest VM.<br>
&gt; <br>
&gt; Can you elaborate on the danger of DEFLATE_ON_OOM? I haven&#39;t seen =
any problems<br>
&gt; in testing but I&#39;d really like to know about the dangers.<br>
&gt; Is there a difference in safety between the OOM notifier callback and =
the<br>
&gt; shrinker API?<br>
<br>
It&#39;s not about dangers as such. It&#39;s just that when linux hits OOM<=
br>
all kind of error paths are being hit, latent bugs start triggering,<br>
latency goes up drastically.</blockquote><div>Doesn&#39;t this suggest that=
 the shrinker is preferable to the OOM notifier in the case that we&#39;re =
actually OOMing (with DEFLATE_ON_OOM)?</div><div><br></div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex">
<br>
<br>
&gt; <br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0--<br>
&gt;=C2=A0 =C2=A0 =C2=A0Thanks,<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0David / dhildenb<br>
&gt; <br>
&gt; <br>
<br>
</blockquote></div></div>

--000000000000a36cc8059dd8c819--

--===============6952645948082930302==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============6952645948082930302==--
