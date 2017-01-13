From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 2/2] vring: Force use of DMA API for ARM-based systems
Date: Fri, 13 Jan 2017 20:23:35 +0200
Message-ID: <20170113201933-mutt-send-email-mst@kernel.org>
References: <85015f1653eb7e36f992708362b75d1f4391b783.1484070340.git.robin.murphy@arm.com>
	<4833e705fb6841fbfdbee3b1a21a7bc917292410.1484070340.git.robin.murphy@arm.com>
	<20170111013046-mutt-send-email-mst@kernel.org>
	<20170111100139.GC12388@arm.com>
	<20170112232931-mutt-send-email-mst@kernel.org>
	<20170113092522.GB22538@arm.com>
	<20170113183222-mutt-send-email-mst@kernel.org>
	<20170113172154.GL3253@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20170113172154.GL3253@arm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Will Deacon <will.deacon@arm.com>
Cc: Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org, luto@kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Jan 13, 2017 at 05:21:54PM +0000, Will Deacon wrote:
> On Fri, Jan 13, 2017 at 06:46:32PM +0200, Michael S. Tsirkin wrote:
> > On Fri, Jan 13, 2017 at 09:25:22AM +0000, Will Deacon wrote:
> > > On Fri, Jan 13, 2017 at 12:12:56AM +0200, Michael S. Tsirkin wrote:
> > > > On Wed, Jan 11, 2017 at 10:01:39AM +0000, Will Deacon wrote:
> > > > > On Wed, Jan 11, 2017 at 01:33:31AM +0200, Michael S. Tsirkin wrote:
> > > > > > On Tue, Jan 10, 2017 at 05:51:18PM +0000, Robin Murphy wrote:
> > > > > > > From: Will Deacon <will.deacon@arm.com>
> > > > > > > 
> > > > > > > Booting Linux on an ARM fastmodel containing an SMMU emulation results
> > > > > > > in an unexpected I/O page fault from the legacy virtio-blk PCI device:
> > > > > > > 
> > > > > > > [    1.211721] arm-smmu-v3 2b400000.smmu: event 0x10 received:
> > > > > > > [    1.211800] arm-smmu-v3 2b400000.smmu:	0x00000000fffff010
> > > > > > > [    1.211880] arm-smmu-v3 2b400000.smmu:	0x0000020800000000
> > > > > > > [    1.211959] arm-smmu-v3 2b400000.smmu:	0x00000008fa081002
> > > > > > > [    1.212075] arm-smmu-v3 2b400000.smmu:	0x0000000000000000
> > > > > > > [    1.212155] arm-smmu-v3 2b400000.smmu: event 0x10 received:
> > > > > > > [    1.212234] arm-smmu-v3 2b400000.smmu:	0x00000000fffff010
> > > > > > > [    1.212314] arm-smmu-v3 2b400000.smmu:	0x0000020800000000
> > > > > > > [    1.212394] arm-smmu-v3 2b400000.smmu:	0x00000008fa081000
> > > > > > > [    1.212471] arm-smmu-v3 2b400000.smmu:	0x0000000000000000
> > > > > > > 
> > > > > > > <system hangs failing to read partition table>
> > > > > > > 
> > > > > > > This is because the virtio-blk is behind an SMMU, so we have consequently
> > > > > > > swizzled its DMA ops and configured the SMMU to translate accesses. This
> > > > > > > then requires the vring code to use the DMA API to establish translations,
> > > > > > > otherwise all transactions will result in fatal faults and termination.
> > > > > > > 
> > > > > > > Given that ARM-based systems only see an SMMU if one is really present
> > > > > > > (the topology is all described by firmware tables such as device-tree or
> > > > > > > IORT), then we can safely use the DMA API for all virtio devices.
> > > > > > > 
> > > > > > > Cc: Andy Lutomirski <luto@kernel.org>
> > > > > > > Cc: Michael S. Tsirkin <mst@redhat.com>
> > > > > > > Signed-off-by: Will Deacon <will.deacon@arm.com>
> > > > > > 
> > > > > > I'd like to better understand then need for this one.
> > > > > > Can't the device in question just set VIRTIO_F_IOMMU_PLATFORM ?
> > > > > > 
> > > > > > I'd rather we avoided need for more hacks and just
> > > > > > have everyone switch to that.
> > > > > 
> > > > > There are a couple of problems with VIRTIO_F_IOMMU_PLATFORM:
> > > > > 
> > > > > 1. It doesn't exist for legacy devices, which are all we have on the
> > > > >    platform in question.
> > > > > 
> > > > > 2. It's not documented in the virtio sp^H^HSTOP PRESS. I see you applied
> > > > >    my patch ;). Thanks.
> > > > > 
> > > > > In which case, for non-legacy devices we should definitely be using
> > > > > VIRTIO_F_IOMMU_PLATFORM, but since this platform hasn't yet moved to the
> > > > > world of flying cars, could we unconditionally set the DMA ops on ARM
> > > > > for legacy devices? The alternative is disabling the SMMU altogether,
> > > > > but that's less than ideal because there are non-virtio devices on the
> > > > > same PCI bus.
> > > > > 
> > > > 
> > > > I'd rather people didn't use SMMU with legacy devices.
> > > 
> > > I'm afraid we've been doing that for two years and the model already
> > > exists in a mature state, being actively used for development and
> > > validation by ARM and our partners. One of the big things its used for
> > > is to develop SMMU and GIC (our interrupt controller) code with PCI, so
> > > dropping the SMMU from the picture isn't an option.
> > 
> > Oh so this fixes a regression?  This is something I didn't realize.
> 
> Yes, thanks. The regression came about because we implemented SMMU-backed
> DMA ops and only then was it apparent that the virtio stuff was bypassing
> even with translation enabled (because it wasn't using the DMA API).

Could you point out a commit ID?


> > A "Fixes:" tag can't hurt here.  I then wonder
> > might DMA ops ever use a DMA address which isn't a physical address
> > from QEMU point of view? If that happens, this hack breaks
> > because in legacy mode QEMU still uses the GPA.
> 
> If QEMU doesn't advertise an SMMU, then it will work fine with the GPA,
> because we won't swizzle the DMA ops for the master device. If QEMU does
> advertise an SMMU, then we'll allocate DMA addresses to fit within the
> the intersection of the SMMU aperture and device's DMA mask.


Right but doesn't just poking from qemu into phys addresses work
anymore? It used to ...

> > > > Can't you guys just code up the virtio 1 layout in QEMU?
> > > > I took a look and it's not a big deal now that two other
> > > > transports converted, except mmio code in QEMU doesn't
> > > > use linux header to it's a bit messy.
> > > > I'll send a patch to clean that up.
> > > 
> > > If the model ever changes in this area (which isn't planned atm), the
> > > right thing to do would be to move to modern virtio. However, we're stuck
> > > with what we have for the forseeable future and it works just fine if we
> > > use the DMA API. If we don't use it, Linux no longer boots because it
> > > installs the SMMU-backed DMA ops for the virtio devices and everything
> > > faults.
> > > 
> > > I really don't understand why this is controversial.
> > > 
> > I agree we need to keep working things working. I just don't yet
> > understand what change broke things and how did it happen - legacy
> > devices used to just poke at guest PA from QEMU, what does it matter
> > that there are changes in DMA ops if neither host nor guest use them for
> > legacy setups?
> 
> The problem is that platforms which advertise an SMMU downstream of the
> (virtual) PCI-RC now automatically have their PCI devices attached to the
> SMMU, so if they don't use the DMA ops then they will fault.
> 
> > I guess that's just me now knowing about how DMA ops work on SMMU
> > or missing some other basic point about SMMU.
> > 
> > I take your word that it's the right thing to do, but I'd like to figure
> > it out before merging this.  I'll read up in the coming days to make
> > sure I understand what the patch does, any pointers welcome.
> 
> Ok, thanks. Just shout if you have more questions. I'm also happy with
> only doing this for legacy devices, given that modern virtio has the
> IOMMU flag.
> 
> Will
