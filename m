From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] virtio-balloon spec: rework
	VIRTIO_BALLOON_F_MUST_TELL_HOST feature, support silent deflation
Date: Tue, 28 May 2013 14:44:02 +0300
Message-ID: <20130528114402.GA21107@redhat.com>
References: <1368007813-1264-1-git-send-email-pbonzini@redhat.com>
	<51A381D9.5010800@redhat.com> <20130527160437.GA18270@redhat.com>
	<51A38552.9050808@redhat.com> <20130527170259.GA18800@redhat.com>
	<51A46D0B.9080508@redhat.com> <20130528104503.GD5467@redhat.com>
	<51A4913F.5050206@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <51A4913F.5050206@redhat.com>
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

On Tue, May 28, 2013 at 01:13:03PM +0200, Paolo Bonzini wrote:
> Il 28/05/2013 12:45, Michael S. Tsirkin ha scritto:
> > On Tue, May 28, 2013 at 10:38:35AM +0200, Paolo Bonzini wrote:
> >> Il 27/05/2013 19:02, Michael S. Tsirkin ha scritto:
> >>>>> So if we don't want to require all guests to tell host
> >>>>> first, all we need to do is admit it's not a bug.
> >>>>
> >>>> I think we want the possibility for the host to require that.
> >>>
> >>> But why? TELL_HOST makes some optimizations possible, but if
> >>> guest won't cooperate, balloon is useless anyway.
> >>
> >> If the guest won't tell host and still propose the feature,
> > 
> > Ack feature but don't tell host? That would be a clear guest bug.
> > AFAIK that's not what windows drivers do.
> > Am I wrong?
> 
> Yes.  I think we are in agreement on this part.
> 
> >>>>> Please see
> >>>>> 	[PATCH] virtio-spec: balloon: MUST_TELL_HOST is optional
> >>>>> that does exactly this.
> >>>>
> >>>> That patch mandates a change in guest behavior that is not compatible
> >>>> with the existing Windows driver.  Mine doesn't.
> >>>
> >>> Hmm I don't see it.
> >>> In fact the goal was to document the Windows driver behaviour
> >>> as correct. Can you explain the incompatibility please?
> >>
> >> Whenever "If the X feature is (not) negotiated" is used in the spec, it
> >> means "in general you should be ready to implement both behaviors", or
> >> perhaps the guest should fail to initialize if the feature is not available.
> > 
> > "you" meaning host. Yes.
> 
> Even guest.  A virtio-net guest driver should be ready to use an older
> method if the host doesn't support merged rx buffers, for example.
> 
> In this case, a "tell host first" guest has to do nothing special if the
> host doesn't advertise the feature.  It is a bit different from other
> uses of "negotiated" in the spec.

If you just want to add this line
"It's legal for guest to tell host first even if
 it did not acknowledge the TELL_HOST feature"
then that's fine.

> > But here guest can tell host first *always if it wants to - it will
> > just be a bit slower when reusing pages from balloon.
> > If it acked the feature, it *must* tell host first.
> 
> Yes.
> 
> >> The way I read it yesterday I didn't see any change from the current
> >> specification, so the problem of having a "negative feature" remains.
> > 
> > This is standard behaviour:
> > 
> > - guest can ignore any feature that it does not ack
> > - host must implement both behaviours for guests that
> >   do and for guests that do not ack features
> > 
> > This is exactly what I'm proposing for TELL_HOST.
> 
> I know, but I think the use "negotiated" part is unclear.

negotiated in spec means "present and acked by guest".
We can try and replace "negotiated" by "present and acked by guest"
everywhere - think it will be clearer?

> >> Now rereading it, it may be correct, but it is not clear enough.
> >>
> >> Perhaps my patch is even too verbose, but it doesn't leave anything open
> >> for interpretation.
> > 
> > I'm fine with adding more clarifications but I don't yet see why
> > do we need a new bit.
> 
> There are three cases:
> 
> 1) the drivers is not able to tell the host first (or never tell the
> host at all), like the Windows driver or the Google fileballoon driver.
>  If the host always wants to be told first (e.g. a hypothetical
> virtio-balloon running on Xen) it should somehow prevent these drivers
> from running.

I don't think hosts that always want to be told first can exist.
Handling guests that don't tell first is super easy -
e.g. just don't do anything.

> 2) the driver will always tell the host first, like the Linux driver.
> The host can trust the guest to do the right thing.

It should not if guest did not ack the feature bit.
And no host we ever released thankfully does this.

> 3) the driver wants to optimize if the host can be told last (or not
> told altogether).  Again, the host can trust the guest to do the right
> thing, but there are two possible behaviors for the guest driver.
> 
> Case (3) would be a trivial optimization to implement on the Linux
> driver for example, but one could also imagine switching the
> implementation entirely: use something like Luiz's shrinker if the host
> needs to be told, use something like Google's fileballoon if it doesn't.
> 
> The existing bit lets the host distinguish 1 from 2+3.  The other bit is
> needed for the guest to pick the right behavior in case 3.
> 
> Paolo

1 does not exist.

And guests simply do not treat the existing bit as your spec patch says
they should. Instead they treat it as they would treat your new bit.  So
let's just make spec match driver behaviour.  Less work for everyone,
and no need for the new bit.

-- 
MST
