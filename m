From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v2 2/2] vring: Force use of DMA API for ARM-based systems
Date: Mon, 16 Jan 2017 14:21:03 +0000
Message-ID: <20170116142103.GF1510@arm.com>
References: <4833e705fb6841fbfdbee3b1a21a7bc917292410.1484070340.git.robin.murphy@arm.com>
	<20170111013046-mutt-send-email-mst@kernel.org>
	<20170111100139.GC12388@arm.com>
	<20170112232931-mutt-send-email-mst@kernel.org>
	<20170113092522.GB22538@arm.com>
	<20170113183222-mutt-send-email-mst@kernel.org>
	<20170113172154.GL3253@arm.com>
	<20170113201933-mutt-send-email-mst@kernel.org>
	<20170116104028.GA1510@arm.com>
	<20170116161639-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20170116161639-mutt-send-email-mst@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org, luto@kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Jan 16, 2017 at 04:18:03PM +0200, Michael S. Tsirkin wrote:
> On Mon, Jan 16, 2017 at 10:40:28AM +0000, Will Deacon wrote:
> > On Fri, Jan 13, 2017 at 08:23:35PM +0200, Michael S. Tsirkin wrote:
> > > On Fri, Jan 13, 2017 at 05:21:54PM +0000, Will Deacon wrote:
> > > > On Fri, Jan 13, 2017 at 06:46:32PM +0200, Michael S. Tsirkin wrote:
> > > > > On Fri, Jan 13, 2017 at 09:25:22AM +0000, Will Deacon wrote:
> > > > > > On Fri, Jan 13, 2017 at 12:12:56AM +0200, Michael S. Tsirkin wrote:
> > > > > > > I'd rather people didn't use SMMU with legacy devices.
> > > > > > 
> > > > > > I'm afraid we've been doing that for two years and the model already
> > > > > > exists in a mature state, being actively used for development and
> > > > > > validation by ARM and our partners. One of the big things its used for
> > > > > > is to develop SMMU and GIC (our interrupt controller) code with PCI, so
> > > > > > dropping the SMMU from the picture isn't an option.
> > > > > 
> > > > > Oh so this fixes a regression?  This is something I didn't realize.
> > > > 
> > > > Yes, thanks. The regression came about because we implemented SMMU-backed
> > > > DMA ops and only then was it apparent that the virtio stuff was bypassing
> > > > even with translation enabled (because it wasn't using the DMA API).
> > > 
> > > Could you point out a commit ID?
> > 
> > There has been a fair amount of work in this area recently, but you're
> > probably after something like 876945dbf649 ("arm64: Hook up IOMMU dma_ops")
> > as the culprit, which is the point at which we started to swizzle DMA
> > ops for devices upstream of an SMMU automatically.
> > 
> > > > > A "Fixes:" tag can't hurt here.  I then wonder
> > > > > might DMA ops ever use a DMA address which isn't a physical address
> > > > > from QEMU point of view? If that happens, this hack breaks
> > > > > because in legacy mode QEMU still uses the GPA.
> > > > 
> > > > If QEMU doesn't advertise an SMMU, then it will work fine with the GPA,
> > > > because we won't swizzle the DMA ops for the master device. If QEMU does
> > > > advertise an SMMU, then we'll allocate DMA addresses to fit within the
> > > > the intersection of the SMMU aperture and device's DMA mask.
> > > 
> > > 
> > > Right but doesn't just poking from qemu into phys addresses work
> > > anymore? It used to ...
> > 
> > Provided that there's no SMMU, then it will continue to work. and my
> > understanding (from talking to Peter Maydell) is that qemu doesn't model
> > an SMMU for ARM-based machines.
> > 
> 
> So how come people report failures due to presence of SMMU?
> Using some other hypervisor?

The failures are reported on the ARM fastmodel (a complete system
emulation that runs on an x86 box), where an SMMU *is* present
downstream of the virtio-pci masters. There's no qemu involved there.

Will
