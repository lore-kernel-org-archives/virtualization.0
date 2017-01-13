From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v2 2/2] vring: Force use of DMA API for ARM-based systems
Date: Fri, 13 Jan 2017 09:40:30 +0000
Message-ID: <20170113094029.GD22538@arm.com>
References: <85015f1653eb7e36f992708362b75d1f4391b783.1484070340.git.robin.murphy@arm.com>
	<4833e705fb6841fbfdbee3b1a21a7bc917292410.1484070340.git.robin.murphy@arm.com>
	<20170111013046-mutt-send-email-mst@kernel.org>
	<20170111100139.GC12388@arm.com>
	<CALCETrXYwp4BJbwFo4P1hEvubyDh1mN+W4L-tQVYjh3e7F-Q9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CALCETrXYwp4BJbwFo4P1hEvubyDh1mN+W4L-tQVYjh3e7F-Q9A@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andy Lutomirski <luto@amacapital.net>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Andrew Lutomirski <luto@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jan 11, 2017 at 10:12:36AM -0800, Andy Lutomirski wrote:
> On Wed, Jan 11, 2017 at 2:01 AM, Will Deacon <will.deacon@arm.com> wrote:
> > On Wed, Jan 11, 2017 at 01:33:31AM +0200, Michael S. Tsirkin wrote:
> >> On Tue, Jan 10, 2017 at 05:51:18PM +0000, Robin Murphy wrote:
> >> > From: Will Deacon <will.deacon@arm.com>
> >> >
> >> > Booting Linux on an ARM fastmodel containing an SMMU emulation results
> >> > in an unexpected I/O page fault from the legacy virtio-blk PCI device:
> >> >
> >> > [    1.211721] arm-smmu-v3 2b400000.smmu: event 0x10 received:
> >> > [    1.211800] arm-smmu-v3 2b400000.smmu:   0x00000000fffff010
> >> > [    1.211880] arm-smmu-v3 2b400000.smmu:   0x0000020800000000
> >> > [    1.211959] arm-smmu-v3 2b400000.smmu:   0x00000008fa081002
> >> > [    1.212075] arm-smmu-v3 2b400000.smmu:   0x0000000000000000
> >> > [    1.212155] arm-smmu-v3 2b400000.smmu: event 0x10 received:
> >> > [    1.212234] arm-smmu-v3 2b400000.smmu:   0x00000000fffff010
> >> > [    1.212314] arm-smmu-v3 2b400000.smmu:   0x0000020800000000
> >> > [    1.212394] arm-smmu-v3 2b400000.smmu:   0x00000008fa081000
> >> > [    1.212471] arm-smmu-v3 2b400000.smmu:   0x0000000000000000
> >> >
> >> > <system hangs failing to read partition table>
> >> >
> >> > This is because the virtio-blk is behind an SMMU, so we have consequently
> >> > swizzled its DMA ops and configured the SMMU to translate accesses. This
> >> > then requires the vring code to use the DMA API to establish translations,
> >> > otherwise all transactions will result in fatal faults and termination.
> >> >
> >> > Given that ARM-based systems only see an SMMU if one is really present
> >> > (the topology is all described by firmware tables such as device-tree or
> >> > IORT), then we can safely use the DMA API for all virtio devices.
> >> >
> >> > Cc: Andy Lutomirski <luto@kernel.org>
> >> > Cc: Michael S. Tsirkin <mst@redhat.com>
> >> > Signed-off-by: Will Deacon <will.deacon@arm.com>
> >>
> >> I'd like to better understand then need for this one.
> >> Can't the device in question just set VIRTIO_F_IOMMU_PLATFORM ?
> >>
> >> I'd rather we avoided need for more hacks and just
> >> have everyone switch to that.
> >
> > There are a couple of problems with VIRTIO_F_IOMMU_PLATFORM:
> >
> > 1. It doesn't exist for legacy devices, which are all we have on the
> >    platform in question.
> >
> > 2. It's not documented in the virtio sp^H^HSTOP PRESS. I see you applied
> >    my patch ;). Thanks.
> >
> > In which case, for non-legacy devices we should definitely be using
> > VIRTIO_F_IOMMU_PLATFORM, but since this platform hasn't yet moved to the
> > world of flying cars, could we unconditionally set the DMA ops on ARM
> > for legacy devices? The alternative is disabling the SMMU altogether,
> > but that's less than ideal because there are non-virtio devices on the
> > same PCI bus.
> 
> Also, on ARM, using the DMA API appears to *always* be the correct
> approach.  Why not do it all the time, then?  The non-DMA-API path is
> a legacy thing that is needed because a few platforms incorrectly
> enumerate their IOMMUs.  ARM gets it right, so I don't see why ARM
> should be subject to the legacy mess.

That's what my patch does, but since modern virtio has the
VIRTIO_F_IOMMU_PLATFORM flag (and the spec says if it's not present then
the driver must pass physical addresses), it feels to me like we should
just honour that so that different architectures all have the same
behaviour. For legacy devices, the horse has bolted and we need
arch-specific behaviours to keep things working.

Will
