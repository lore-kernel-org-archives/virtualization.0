From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC 0/4] Virtio uses DMA API for all devices
Date: Thu, 09 Aug 2018 12:00:47 +1000
Message-ID: <7995ee537c416e30d0aac57042cb36f84c6edef9.camel@kernel.crashing.org>
References: <20180806094243.GA16032@infradead.org>
	<6c707d6d33ac25a42265c2e9b521c2416d72c739.camel@kernel.crashing.org>
	<20180807062117.GD32709@infradead.org>
	<aa59c7f8556bd4b332394a1dcf2d4a8faf3dc4a2.camel@kernel.crashing.org>
	<20180807135505.GA29034@infradead.org>
	<2103ecfe52d23cec03f185d08a87bfad9c9d82b5.camel@kernel.crashing.org>
	<20180808063158.GA2474@infradead.org>
	<4b596883892b5cb5560bef26fcd249e7107173ac.camel@kernel.crashing.org>
	<20180808123036.GA2525@infradead.org>
	<b8b9150a747453c070ad3b0e4c92d2b1b052ad06.camel@kernel.crashing.org>
	<20180808232210-mutt-send-email-mst@kernel.org>
	<98eb367ce322ad84baa31e3c7beffc4a42be8458.camel@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <98eb367ce322ad84baa31e3c7beffc4a42be8458.camel@kernel.crashing.org>
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
Cc: robh@kernel.org, srikar@linux.vnet.ibm.com, mpe@ellerman.id.au, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, linuxram@us.ibm.com, virtualization@lists.linux-foundation.org, Christoph Hellwig <hch@infradead.org>, jean-philippe.brucker@arm.com, paulus@samba.org, marc.zyngier@arm.com, joe@perches.com, robin.murphy@arm.com, david@gibson.dropbear.id.au, linuxppc-dev@lists.ozlabs.org, elfring@users.sourceforge.net, haren@linux.vnet.ibm.com, Anshuman Khandual <khandual@linux.vnet.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 2018-08-09 at 08:13 +1000, Benjamin Herrenschmidt wrote:
> > For completeness, virtio could also have its own bounce buffer
> > outside of DMA API one. I don't see lots of benefits to this
> > though.
> 
> Not fan of that either...

To elaborate a bit ...

For our secure VMs, we will need bounce buffering for everything
anyway. virtio, emulated PCI, or vfio.

By ensuring that we create an identity mapping in the IOMMU for
the bounce buffering pool, we enable virtio "legacy/direct" to
use the same mapping ops as things using the iommu.

That said, we still need somewhere in arch/powerpc a set of dma
ops which we'll attach to all PCI devices of a secure VM to force
bouncing always, rather than just based on address (which is what
the standard swiotlb ones do)... Unless we can tweak the swiotlb
"threshold" for example by using an empty mask.

We'll need the same set of DMA ops for VIO devices too, not just PCI.

Cheers,
Ben.
