From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC PATCH] virtio_ring: Use DMA API if guest memory is encrypted
Date: Mon, 1 Jul 2019 10:17:11 -0400
Message-ID: <20190701092212-mutt-send-email-mst__4796.40404680453$1561991075$gmane$org@kernel.org>
References: <20190204144048-mutt-send-email-mst@kernel.org>
	<87ef71seve.fsf@morokweng.localdomain>
	<20190320171027-mutt-send-email-mst@kernel.org>
	<87tvfvbwpb.fsf@morokweng.localdomain>
	<20190323165456-mutt-send-email-mst@kernel.org>
	<87a7go71hz.fsf@morokweng.localdomain>
	<20190520090939-mutt-send-email-mst@kernel.org>
	<877ea26tk8.fsf@morokweng.localdomain>
	<20190603211528-mutt-send-email-mst@kernel.org>
	<877e96qxm7.fsf@morokweng.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <877e96qxm7.fsf@morokweng.localdomain>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Cc: Mike Anderson <andmike@linux.ibm.com>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Alexey Kardashevskiy <aik@linux.ibm.com>, Ram Pai <linuxram@us.ibm.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Paul Mackerras <paulus@ozlabs.org>, iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>, David Gibson <david@gibson.dropbear.id.au>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Jun 27, 2019 at 10:58:40PM -0300, Thiago Jung Bauermann wrote:
> 
> Michael S. Tsirkin <mst@redhat.com> writes:
> 
> > On Mon, Jun 03, 2019 at 10:13:59PM -0300, Thiago Jung Bauermann wrote:
> >>
> >>
> >> Michael S. Tsirkin <mst@redhat.com> writes:
> >>
> >> > On Wed, Apr 17, 2019 at 06:42:00PM -0300, Thiago Jung Bauermann wrote:
> >> >> I rephrased it in terms of address translation. What do you think of
> >> >> this version? The flag name is slightly different too:
> >> >>
> >> >>
> >> >> VIRTIO_F_ACCESS_PLATFORM_NO_TRANSLATION This feature has the same
> >> >>     meaning as VIRTIO_F_ACCESS_PLATFORM both when set and when not set,
> >> >>     with the exception that address translation is guaranteed to be
> >> >>     unnecessary when accessing memory addresses supplied to the device
> >> >>     by the driver. Which is to say, the device will always use physical
> >> >>     addresses matching addresses used by the driver (typically meaning
> >> >>     physical addresses used by the CPU) and not translated further. This
> >> >>     flag should be set by the guest if offered, but to allow for
> >> >>     backward-compatibility device implementations allow for it to be
> >> >>     left unset by the guest. It is an error to set both this flag and
> >> >>     VIRTIO_F_ACCESS_PLATFORM.
> >> >
> >> >
> >> >
> >> >
> >> > OK so VIRTIO_F_ACCESS_PLATFORM is designed to allow unpriveledged
> >> > drivers. This is why devices fail when it's not negotiated.
> >>
> >> Just to clarify, what do you mean by unprivileged drivers? Is it drivers
> >> implemented in guest userspace such as with VFIO? Or unprivileged in
> >> some other sense such as needing to use bounce buffers for some reason?
> >
> > I had drivers in guest userspace in mind.
> 
> Great. Thanks for clarifying.
> 
> I don't think this flag would work for guest userspace drivers. Should I
> add a note about that in the flag definition?

I think you need to clarify access protection rules. Is it only
translation that is bypassed or is any platform-specific
protection mechanism bypassed too?

> >> > This confuses me.
> >> > If driver is unpriveledged then what happens with this flag?
> >> > It can supply any address it wants. Will that corrupt kernel
> >> > memory?
> >>
> >> Not needing address translation doesn't necessarily mean that there's no
> >> IOMMU. On powerpc we don't use VIRTIO_F_ACCESS_PLATFORM but there's
> >> always an IOMMU present. And we also support VFIO drivers. The VFIO API
> >> for pseries (sPAPR section in Documentation/vfio.txt) has extra ioctls
> >> to program the IOMMU.
> >>
> >> For our use case, we don't need address translation because we set up an
> >> identity mapping in the IOMMU so that the device can use guest physical
> >> addresses.

OK so I think I am beginning to see it in a different light.  Right now the specific
platform creates an identity mapping. That in turn means DMA API can be
fast - it does not need to do anything.  What you are looking for is a
way to tell host it's an identity mapping - just as an optimization.

Is that right?  So this is what I would call this option:

VIRTIO_F_ACCESS_PLATFORM_IDENTITY_ADDRESS

and the explanation should state that all device
addresses are translated by the platform to identical
addresses.

In fact this option then becomes more, not less restrictive
than VIRTIO_F_ACCESS_PLATFORM - it's a promise
by guest to only create identity mappings,
and only before driver_ok is set.
This option then would always be negotiated together with
VIRTIO_F_ACCESS_PLATFORM.

Host then must verify that
1. full 1:1 mappings are created before driver_ok
    or can we make sure this happens before features_ok?
    that would be ideal as we could require that features_ok fails
2. mappings are not modified between driver_ok and reset
    i guess attempts to change them will fail -
    possibly by causing a guest crash
    or some other kind of platform-specific error

So far so good, but now a question:

how are we handling guest address width limitations?
Is VIRTIO_F_ACCESS_PLATFORM_IDENTITY_ADDRESS subject to
guest address width limitations?
I am guessing we can make them so ...
This needs to be documented.




> >
> > And can it access any guest physical address?
> 
> Sorry, I was mistaken. We do support VFIO in guests but not for virtio
> devices, only for regular PCI devices. In which case they will use
> address translation.

Not sure how this answers the question.


> >> If the guest kernel is concerned that an unprivileged driver could
> >> jeopardize its integrity it should not negotiate this feature flag.
> >
> > Unfortunately flag negotiation is done through config space
> > and so can be overwritten by the driver.
> 
> Ok, so the guest kernel has to forbid VFIO access on devices where this
> flag is advertised.

That's possible in theory but in practice we did not yet teach VFIO not
to attach to legacy devices without VIRTIO_F_ACCESS_PLATFORM.  So all
security relies on host denying driver_ok without
VIRTIO_F_ACCESS_PLATFORM.  New options that bypass guest security are
thus tricky as they can create security holes for existing guests.
I'm open to ideas about how to do this in a safe way,


> >> Perhaps there should be a note about this in the flag definition? This
> >> concern is platform-dependant though. I don't believe it's an issue in
> >> pseries.
> >
> > Again ACCESS_PLATFORM has a pretty open definition. It does actually
> > say it's all up to the platform.
> >
> > Specifically how will VIRTIO_F_ACCESS_PLATFORM_NO_TRANSLATION be
> > implemented portably? virtio has no portable way to know
> > whether DMA API bypasses translation.
> 
> The fact that VIRTIO_F_ACCESS_PLATFORM_NO_TRANSLATION is set
> communicates that knowledge to virtio. There is a shared understanding
> between the guest and the host about what this flag being set means.

Right but I wonder how are you going to *actually* implement it on Linux?
Are you adding a new set of DMA APIs that do everything except
translation?

> --
> Thiago Jung Bauermann
> IBM Linux Technology Center
