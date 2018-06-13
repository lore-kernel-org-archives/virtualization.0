From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC V2] virtio: Add platform specific DMA API translation for
	virito devices
Date: Wed, 13 Jun 2018 17:03:03 +0300
Message-ID: <20180613170050-mutt-send-email-mst@kernel.org>
References: <20180522063317.20956-1-khandual@linux.vnet.ibm.com>
	<20180523213703-mutt-send-email-mst@kernel.org>
	<20180524072104.GD6139@ram.oc3035372033.ibm.com>
	<0c508eb2-08df-3f76-c260-90cf7137af80@linux.vnet.ibm.com>
	<20180531204320-mutt-send-email-mst@kernel.org>
	<20180607052306.GA1532@infradead.org>
	<20180607185234-mutt-send-email-mst@kernel.org>
	<20180611023909.GA5726@ram.oc3035372033.ibm.com>
	<07b804fccd7373c650be79ac9fa77ae7f2375ced.camel@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <07b804fccd7373c650be79ac9fa77ae7f2375ced.camel@kernel.crashing.org>
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
Cc: robh@kernel.org, pawel.moll@arm.com, Tom Lendacky <thomas.lendacky@amd.com>, cohuck@redhat.com, Ram Pai <linuxram@us.ibm.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Christoph Hellwig <hch@infradead.org>, joe@perches.com, "Rustad,
	Mark D" <mark.d.rustad@intel.com>, Anshuman Khandual <khandual@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org, elfring@users.sourceforge.net, david@gibson.dropbear.id.au
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Jun 11, 2018 at 01:29:18PM +1000, Benjamin Herrenschmidt wrote:
> On Sun, 2018-06-10 at 19:39 -0700, Ram Pai wrote:
> > 
> > However if the administrator
> > ignores/forgets/deliberatey-decides/is-constrained to NOT enable the
> > flag, virtio will not be able to pass control to the DMA ops associated
> > with the virtio devices. Which means, we have no opportunity to share
> > the I/O buffers with the hypervisor/qemu.
> > 
> > How do you suggest, we handle this case?
> 
> At the risk of repeating myself, let's just do the first pass which is
> to switch virtio over to always using the DMA API in the actual data
> flow code, with a hook at initialization time that replaces the DMA ops
> with some home cooked "direct" ops in the case where the IOMMU flag
> isn't set.

I'm not sure I understand all of the details, will have to
see the patch, but superficially it sounds good to me.

> This will be equivalent to what we have today but avoids having 2
> separate code path all over the driver.
> 
> Then a second stage, I think, is to replace this "hook" so that the
> architecture gets a say in the matter.
> 
> Basically, something like:
> 
> 	arch_virtio_update_dma_ops(pci_dev, qemu_direct_mode).
> 
> IE, virtio would tell the arch whether the "other side" is in fact QEMU
> in a mode that bypasses the IOMMU and is cache coherent with the guest.
> This is our legacy "qemu special" mode. If the performance is
> sufficient we may want to deprecate it over time and have qemu enable
> the iommu by default but we still need it.
> 
> A weak implementation of the above will be provied that just puts in
> the direct ops when qemu_direct_mode is set, and thus provides today's
> behaviour on any arch that doesn't override it. If the flag is not set,
> the ops are left to whatever the arch PCI layer already set.
> 
> This will provide the opportunity for architectures that want to do
> something special, such as in our case, when we want to force even the
> "qemu_direct_mode" to go via bounce buffers, to put our own ops in
> there, while retaining the legacy behaviour otherwise.
> 
> It also means that the "gunk" is entirely localized in that one
> function, the rest of virtio just uses the DMA API normally.
> 
> Christoph, are you actually hacking "stage 1" above already or should
> we produce patches ?
> 
> Cheers,
> Ben.
