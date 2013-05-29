From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 1/2] virtio-balloon spec: rewrite description of
	VIRTIO_BALLOON_F_MUST_TELL_HOST
Date: Wed, 29 May 2013 10:45:22 +0300
Message-ID: <20130529074522.GB4472@redhat.com>
References: <1369762818-8787-1-git-send-email-pbonzini@redhat.com>
	<1369762818-8787-2-git-send-email-pbonzini@redhat.com>
	<20130528181510.GC30968@redhat.com> <51A59F0A.80805@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <51A59F0A.80805@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, May 29, 2013 at 08:24:10AM +0200, Paolo Bonzini wrote:
> Il 28/05/2013 20:15, Michael S. Tsirkin ha scritto:
> > What you write in spec below and what you write above seems to
> > contradict.
> > 
> > Look, how about the simpler patch that I sent:
> > "[PATCH] virtio-spec: balloon: MUST_TELL_HOST is optional"
> > 
> > does it functionally do everything you want in this patch?
> 
> No, though it is a step forward.
> 
> But let's take a step back instead; here are the requirements:
> 
> 1) old drivers work unmodified on new hosts
> 
> 2) new drivers work unmodified on old guests, though it is okay if they
> do not use silent deflation
> 
> 3) if both the balloon and the driver supports silent deflation, it
> should be used

I don't agree with this one.  We used to have this:
bf50e69f63d21091e525185c3ae761412be0ba72
and we dropped this patch.

> 4) if the balloon has to enter a "degraded" mode of operation when
> guests do not "tell first", this has to happen only for old guests

I don't agree with this either.
I think if we make tell host optional, it's up to the guest whether
to tell host.

> 
> Once SILENT_DEFLATE is added, your patch prevents fulfilling
> requirements (3) and (4) together, at least in a Linux driver.

Let's keep adding new bits out of it, we'll discuss patch 2
when we are done with patch 1.

> Basically, you're saying that the driver should set MUST_TELL_HOST to
> !SILENT_DEFLATE.

No, I am saying if you don't want to tell host do not ack
MUST_TELL_HOST.

>  However, in the Linux virtio implementation, features
> are independent,

Not just in the implementation. We try to keep it like this in the spec
too. One feature overriding another is messy.

> and the feature list is told beforehand by the driver
> to the virtio layer; with your proposal, the driver would have to
> "retract" support for MUST_TELL_HOST after it has negotiated it.

And that's planned by design - we just never had the need to
do this before.

You are confused by the implementation. Look at the spec.
Also look at commit logs for c45a6816c19dee67b8f725e6646d428901a6dc24
and c624896e488ba2bff5ae497782cfb265c8b00646.
Specifically:
    Drivers can still remove feature bits in their probe routine if they
    really have to.


> This is why I'm making SILENT_DEFLATE=1 override MUST_TELL_HOST=1.

And that's messy I think. It is cleaner if features are independent.


> > If yes maybe you could pick that up, and add
> > a patch with renames and text clarifications on top?
> > 
> > More comments below.
> > 
> >> ---
> >>  virtio-spec.lyx | 62 ++++++++++++++++++++++++++++++++++++++++++++++++++++-----
> >>  1 file changed, 57 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/virtio-spec.lyx b/virtio-spec.lyx
> >> index adec0a5..5c76a87 100644
> >> --- a/virtio-spec.lyx
> >> +++ b/virtio-spec.lyx
> >> @@ -7219,11 +7219,46 @@ bits
> >>  
> >>  \begin_deeper
> >>  \begin_layout Description
> >> -VIRTIO_BALLOON_F_MUST_TELL_HOST
> >> +VIRTIO_BALLOON_F_
> >> +\change_deleted 1531152142 1347020601
> >> +MUST
> >> +\change_inserted 1531152142 1347020602
> >> +CAN
> >> +\change_unchanged
> >> +_TELL_HOST
> >>  \begin_inset space ~
> >>  \end_inset
> >>  
> >> -(0) Host must be told before pages from the balloon are used.
> >> +(0) 
> >> +\change_deleted 1531152142 1347020625
> >> +Host must be told
> >> +\change_inserted 1531152142 1347020617
> >> +Guest is able to tell host
> >> +\change_unchanged
> >> + before pages from the balloon are used.
> >> +
> > 
> > This "can" and "is able" is IMO more confusing than clarifying.
> > Let's be definite. If feature is negotiated, guest must tell host.
> > If it's not, it does not.
> > 
> > That's why it's MUST not CAN.
> 
> No, that won't fly.  First of all, it's not how other features work.  A
> guest that asks for offloading can still do all the segmentation and
> checksumming itself, a guest that knows about the virtio-net control
> queue can still not use it, etc.

Check out VIRTIO_NET_F_MRG_RXBUF as an example.
Same for VIRTIO_NET_F_GUEST_ANNOUNCE.
I'm sure there are other examples.

Basically a feature that's acked can change behaviour
in any way.

> Second, this prevents fulfilling requirements (3) and (4) together as I
> wrote above.

But where do these requirements come from?

> > And text should be
> > 
> > "When negotiated, guest tells host
> > before pages from the balloon are used.
> > "
> > 
> > 
> >> +\change_inserted 1531152142 1368005603
> >> + The host must propose this feature
> > 
> > We don't say "propose feature" anyway in the spec.
> > You really mean "set this feature bit" ?
> 
> Yes.
> 
> >> if it has to be told
> >> + before pages from the balloon are used.
> > 
> > Has to?  Not at all. It can't assume anything
> > until guest has negotiated the feature.
> > So it should be
> > "if it wants to be told before pages from the balloon are used".
> 
> There can be implementations where the only choice is providing a fake
> balloon.  For example if the page is removed from the IOMMU page tables,
> you have to tell the host before a DMA access.

Well this means that if guest did not ack TELL_HOST, host can't unmap
the page from IOMMU. Thus, such a host should probably set TELL_HOST,
and hope that guest acks it. But it's still up to the guest.

> In this case, saying "has to be told" is not entirely precise, but
> "wants to be told" does not say that the operation is degraded.  Any
> improvements on the wording are welcome.

Well I think if host "wants" something then that's exactly because
it can optimize it better.
If you like, add "host should set this feature bit if
being notified before page reuse allows some host-side
optimizations, for example conserving memory".

> In the previous version I just said that all hosts should set this
> feature bit (and commented that old hosts can still be
> upwards-compatible).
>  I changed it because you didn't like it, but I
> think the change is for the worse.  I still really prefer the version I
> sent on May 8th.

Then you get into a mess with yet another feature bit
which overrides an old feature bit.

Stop thinking about your new SILENT_DEFLATE for a moment,
that's what confuses I think. Look at this change in isolation.

> 
> >> +\begin_inset Foot
> >> +status open
> >> +
> >> +\begin_layout Plain Layout
> >> +
> >> +\change_inserted 1531152142 1347022389
> >> +This feature used to be named VIRTIO_BALLOON_F_\SpecialChar \-
> >> +MUST_TELL_HOST.
> >> + However, after a few years it was observed that drivers were not using
> >> + it as specified.
> >> + The virtio-balloon spec was then adjusted to what the drivers had been
> >> + doing.
> > 
> > I'm not sure what good does this historical note do us.
> > I would say:
> > 	Historically the spec required all drivers
> > 	to acknowledge this feature bit.
> > 	However, no known hypervisor relies on this
> > 	feature bit being acknowledged unconditionally.
> > 	Thus, it's safe for drivers to ignore the TELL_HOST
> > 	feature.
> 
> Ok.
> 
> > 
> > 
> >> +\end_layout
> >> +
> >> +\end_inset
> >> +
> >> +
> >> +\change_unchanged
> >> +
> >>  \end_layout
> >>  
> >>  \begin_layout Description
> >> @@ -7382,9 +7417,15 @@ The driver constructs an array of addresses of memory pages it has previously
> >>  \end_layout
> >>  
> >>  \begin_layout Enumerate
> >> -If the VIRTIO_BALLOON_F_MUST_TELL_HOST feature is set, the guest may not
> >> - use these requested pages until that descriptor in the deflateq has been
> >> - used by the device.
> >> +If the VIRTIO_BALLOON_F_
> >> +\change_deleted 1531152142 1369761770
> >> +MUST
> >> +\change_inserted 1531152142 1369761770
> >> +CAN
> >> +\change_unchanged
> >> +_TELL_HOST feature is set, the guest may not use these requested pages until
> >> + that descriptor in the deflateq has been used by the device.
> > 
> > Not if it is set. If it's *negotiated*.
> 
> Right.
> 
> >> +
> >>  \end_layout
> >>  
> >>  \begin_layout Enumerate
> >> @@ -7396,10 +7437,21 @@ status open
> >>  
> >>  \begin_layout Plain Layout
> >>  In this case, deflation advice is merely a courtesy
> >> +\change_inserted 1531152142 1369761798
> >> +.
> >> + The guest need not use the deflateq at all.
> >> +\change_unchanged
> >> +
> >>  \end_layout
> >>  
> >>  \end_inset
> >>  
> >> +
> >> +\change_inserted 1531152142 1369761801
> >> + If the host does not support this, it should not do anything when the balloon
> >> + is inflated or deflated, except put the descriptors on the used ring.
> > 
> > Not true. It simply can't rely on balloon to tell it
> > before pages are used. But, just as an example,
> > we can make kvm exit to qemu when guest
> > attempts to use such a page, and then we'll
> > know it is used without an explicit notification.
> 
> Nice, but this is not always possible (I gave an example above).
> 
> Paolo

Some hosts *might* not do anything when the balloon
is inflated or deflated. But should above is still wrong.

> >> +
> >> +\change_unchanged
> >>   
> >>  \end_layout
> >>  
> >> -- 
> >> 1.8.2.1
> >>
