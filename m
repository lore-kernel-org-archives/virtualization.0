From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC V2] virtio: Add platform specific DMA API translation for
	virito devices
Date: Wed, 6 Jun 2018 22:23:06 -0700
Message-ID: <20180607052306.GA1532__14906.3419703909$1528348896$gmane$org@infradead.org>
References: <20180522063317.20956-1-khandual@linux.vnet.ibm.com>
	<20180523213703-mutt-send-email-mst@kernel.org>
	<20180524072104.GD6139@ram.oc3035372033.ibm.com>
	<0c508eb2-08df-3f76-c260-90cf7137af80@linux.vnet.ibm.com>
	<20180531204320-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20180531204320-mutt-send-email-mst@kernel.org>
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
Cc: robh@kernel.org, pawel.moll@arm.com, Tom Lendacky <thomas.lendacky@amd.com>, cohuck@redhat.com, Ram Pai <linuxram@us.ibm.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, hch@infradead.org, joe@perches.com, "Rustad, Mark D" <mark.d.rustad@intel.com>, david@gibson.dropbear.id.au, linuxppc-dev@lists.ozlabs.org, elfring@users.sourceforge.net, Anshuman Khandual <khandual@linux.vnet.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, May 31, 2018 at 08:43:58PM +0300, Michael S. Tsirkin wrote:
> Pls work on a long term solution. Short term needs can be served by
> enabling the iommu platform in qemu.

So, I spent some time looking at converting virtio to dma ops overrides,
and the current virtio spec, and the sad through I have to tell is that
both the spec and the Linux implementation are complete and utterly fucked
up.

Both in the flag naming and the implementation there is an implication
of DMA API == IOMMU, which is fundamentally wrong.

The DMA API does a few different things:

 a) address translation

	This does include IOMMUs.  But it also includes random offsets
	between PCI bars and system memory that we see on various
	platforms.  Worse so some of these offsets might be based on
	banks, e.g. on the broadcom bmips platform.  It also deals
	with bitmask in physical addresses related to memory encryption
	like AMD SEV.  I'd be really curious how for example the
	Intel virtio based NIC is going to work on any of those
	plaforms.

  b) coherency

	On many architectures DMA is not cache coherent, and we need
	to invalidate and/or write back cache lines before doing
	DMA.  Again, I wonder how this is every going to work with
	hardware based virtio implementations.  Even worse I think this
	is actually broken at least for VIVT event for virtualized
	implementations.  E.g. a KVM guest is going to access memory
	using different virtual addresses than qemu, vhost might throw
	in another different address space.

  c) bounce buffering

	Many DMA implementations can not address all physical memory
	due to addressing limitations.  In such cases we copy the
	DMA memory into a known addressable bounc buffer and DMA
	from there.

  d) flushing write combining buffers or similar

	On some hardware platforms we need workarounds to e.g. read
	from a certain mmio address to make sure DMA can actually
	see memory written by the host.

All of this is bypassed by virtio by default despite generally being
platform issues, not particular to a given device.
