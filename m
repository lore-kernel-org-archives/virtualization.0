From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] virtio-balloon spec: rework
	VIRTIO_BALLOON_F_MUST_TELL_HOST feature, support silent deflation
Date: Tue, 28 May 2013 18:09:56 +0300
Message-ID: <20130528150956.GA28874@redhat.com>
References: <20130527170259.GA18800@redhat.com> <51A46D0B.9080508@redhat.com>
	<20130528104503.GD5467@redhat.com> <51A4913F.5050206@redhat.com>
	<20130528114402.GA21107@redhat.com> <51A49D33.8090008@redhat.com>
	<20130528133256.GC4889@redhat.com> <51A4B9CA.50506@redhat.com>
	<20130528142908.GA28422@redhat.com> <51A4C00C.6020707@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <51A4C00C.6020707@redhat.com>
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

On Tue, May 28, 2013 at 04:32:44PM +0200, Paolo Bonzini wrote:
> Il 28/05/2013 16:29, Michael S. Tsirkin ha scritto:
> > On Tue, May 28, 2013 at 04:06:02PM +0200, Paolo Bonzini wrote:
> >> Il 28/05/2013 15:32, Michael S. Tsirkin ha scritto:
> >>> At this point I am confused. I think there are two changes in your patch:
> >>>
> >>> 1. Handling of VIRTIO_F_GUEST_MUST_TELL_HOST
> >>>  Is this functionally identical to what I proposed?
> >>>  If yes, I am fine with either change being applied.
> >>
> >> Yes.
> >>
> >>> 2. New SILENT_DEFLATE feature
> >>>  Since guest can get same functionality by not acking
> >>>  TELL_HOST, I still don't see what good it does:
> >>>  Historically a host with no features supports silent
> >>>  deflate and guest with no features can do silent deflate.
> >>>  I conclude silent deflate is the default behaviour for
> >>>  both host and guest, and we can't change default without
> >>>  breaking compatibility.
> >>
> >> You're right that for correctness the existing feature is enough:
> >> if it is not negotiated by the guest, the host ensures correctness by
> >> only giving the guest a fake balloon.
> >>
> >> However, the new feature is about optimization, not correctness.
> >> In fact, VIRTIO_BALLOON_F_SILENT_DEFLATE is the optimization
> >> feature that VIRTIO_BALLOON_F_MUST_TELL_HOST was meant to be.
> >>
> >> What I'm interested in, is drivers that can _optionally_ use silent 
> >> deflation (as an optimization).  These should not get a fake balloon!
> >>
> >> With the new feature bit, these drivers should propose both
> >> VIRTIO_BALLOON_F_GUEST_TELLS_HOST and VIRTIO_BALLOON_F_SILENT_DEFLATE.
> >> The driver can then use silent  deflation if and only if the host
> >> has negotiated  VIRTIO_BALLOON_F_SILENT_DEFLATE too.  Like this:
> >>
> >> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> >> index bd3ae32..05fe948 100644
> >> --- a/drivers/virtio/virtio_balloon.c
> >> +++ b/drivers/virtio/virtio_balloon.c
> >> @@ -186,12 +186,8 @@ static void leak_balloon(struct virtio_balloon *vb, size_t num)
> >>  		vb->num_pages -= VIRTIO_BALLOON_PAGES_PER_PAGE;
> >>  	}
> >>  
> >> -	/*
> >> -	 * Note that if
> >> -	 * virtio_has_feature(vdev, VIRTIO_BALLOON_F_MUST_TELL_HOST);
> >> -	 * is true, we *have* to do it in this order
> >> -	 */
> >> -	tell_host(vb, vb->deflate_vq);
> >> +	if (virtio_has_feature(vdev, VIRTIO_BALLOON_F_SILENT_DEFLATE)
> >> +		tell_host(vb, vb->deflate_vq);
> >>  	mutex_unlock(&vb->balloon_lock);
> >>  	release_pages_by_pfn(vb->pfns, vb->num_pfns);
> >>  }
> >> @@ -543,6 +539,7 @@ static int virtballoon_restore(struct virtio_device *vdev)
> >>  static unsigned int features[] = {
> >>  	VIRTIO_BALLOON_F_MUST_TELL_HOST,
> >>  	VIRTIO_BALLOON_F_STATS_VQ,
> >> +	VIRTIO_BALLOON_F_SILENT_DEFLATE,
> >>  };
> >>  
> >>  static struct virtio_driver virtio_balloon_driver = {
> >>
> >>
> >> Of course with the current implementation of the balloon it does not
> >> matter much.  But for example, with Luiz's work, releasing pages as soon
> >> as the shrinker is called will increase effectiveness of the shrinker.
> >> At the same time, not all is lost if the guest prefers not to allow
> >> silent deflation (e.g. because there is an assigned device).
> >>
> >> On old hosts, a guest that can optionally use silent deflation will
> >> not use it.  That's the same as for any other feature bit.
> >>
> >>> How about splitting the patches so we can discuss them separately?
> >>
> >> I can do that, but I hope the above clarifies it.
> > 
> > Maybe I'm just dense.
> > Let's see the split spec patchset?
> 
> What's unclear exactly?  I'm not sure the spec patchset improves things
> that much, I can split it in two or three (change old feature, add new
> feature, add explanation) but it's not like changing logic in a program.
> 
> Paolo

Both your code and what you say here about the new bit seem to break
compatibility with old hosts and guests.
Again, could be just me seeing things.
If it's in spec, I think it would be clearer what are we trying to
achieve, and how.

-- 
MST
