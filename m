From: Will Deacon <will.deacon@arm.com>
Subject: Re: [RFC 0/4] Virtio uses DMA API for all devices
Date: Wed, 1 Aug 2018 09:16:38 +0100
Message-ID: <20180801081637.GA14438__9678.07798083431$1533111276$gmane$org@arm.com>
References: <20180720035941.6844-1-khandual@linux.vnet.ibm.com>
	<20180727095804.GA25592@arm.com>
	<20180730093414.GD26245@infradead.org>
	<20180730125100-mutt-send-email-mst@kernel.org>
	<20180730111802.GA9830@infradead.org>
	<20180730155633-mutt-send-email-mst@kernel.org>
	<20180731173052.GA17153@infradead.org>
	<3d6e81511571260de1c8047aaffa8ac4df093d2e.camel@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <3d6e81511571260de1c8047aaffa8ac4df093d2e.camel@kernel.crashing.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: robh@kernel.org, srikar@linux.vnet.ibm.com, "Michael S. Tsirkin" <mst@redhat.com>, mpe@ellerman.id.au, linuxram@us.ibm.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Christoph Hellwig <hch@infradead.org>, paulus@samba.org, marc.zyngier@arm.com, joe@perches.com, robin.murphy@arm.com, david@gibson.dropbear.id.au, linuxppc-dev@lists.ozlabs.org, elfring@users.sourceforge.net, haren@linux.vnet.ibm.com, Anshuman Khandual <khandual@linux.vnet.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jul 31, 2018 at 03:36:22PM -0500, Benjamin Herrenschmidt wrote:
> On Tue, 2018-07-31 at 10:30 -0700, Christoph Hellwig wrote:
> > > However the question people raise is that DMA API is already full of
> > > arch-specific tricks the likes of which are outlined in your post linked
> > > above. How is this one much worse?
> > 
> > None of these warts is visible to the driver, they are all handled in
> > the architecture (possibly on a per-bus basis).
> > 
> > So for virtio we really need to decide if it has one set of behavior
> > as specified in the virtio spec, or if it behaves exactly as if it
> > was on a PCI bus, or in fact probably both as you lined up.  But no
> > magic arch specific behavior inbetween.
> 
> The only arch specific behaviour is needed in the case where it doesn't
> behave like PCI. In this case, the PCI DMA ops are not suitable, but in
> our secure VMs, we still need to make it use swiotlb in order to bounce
> through non-secure pages.

On arm/arm64, the problem we have is that legacy virtio devices on the MMIO
transport (so definitely not PCI) have historically been advertised by qemu
as not being cache coherent, but because the virtio core has bypassed DMA
ops then everything has happened to work. If we blindly enable the arch DMA
ops, we'll plumb in the non-coherent ops and start getting data corruption,
so we do need a way to quirk virtio as being "always coherent" if we want to
use the DMA ops (which we do, because our emulation platforms have an IOMMU
for all virtio devices).

Will
