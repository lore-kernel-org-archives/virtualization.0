From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC 0/4] Virtio uses DMA API for all devices
Date: Mon, 6 Aug 2018 23:16:37 -0700
Message-ID: <20180807061637.GB32709@infradead.org>
References: <20180803070507.GA1344@infradead.org>
	<eb1750e90e4bd45da297fa6f78f8ef93671b7c2f.camel@kernel.crashing.org>
	<20180803220443-mutt-send-email-mst@kernel.org>
	<051fd78e15595b414839fa8f9d445b9f4d7576c6.camel@kernel.crashing.org>
	<20180805031046-mutt-send-email-mst@kernel.org>
	<fd8fee94cf42e436878f179c7895de3a4dab3355.camel@kernel.crashing.org>
	<20180806164106-mutt-send-email-mst@kernel.org>
	<ef6d5d7c7b812bd797a1c3fd6bc7a26d0074020f.camel@kernel.crashing.org>
	<20180806233024-mutt-send-email-mst@kernel.org>
	<0967fc30001323e6e38ed12c8dba8ee3d1aa13f5.camel@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <0967fc30001323e6e38ed12c8dba8ee3d1aa13f5.camel@kernel.crashing.org>
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
Cc: robh@kernel.org, srikar@linux.vnet.ibm.com, "Michael S. Tsirkin" <mst@redhat.com>, mpe@ellerman.id.au, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, linuxram@us.ibm.com, virtualization@lists.linux-foundation.org, Christoph Hellwig <hch@infradead.org>, jean-philippe.brucker@arm.com, paulus@samba.org, marc.zyngier@arm.com, joe@perches.com, robin.murphy@arm.com, david@gibson.dropbear.id.au, linuxppc-dev@lists.ozlabs.org, elfring@users.sourceforge.net, haren@linux.vnet.ibm.com, Anshuman Khandual <khandual@linux.vnet.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Aug 07, 2018 at 07:26:35AM +1000, Benjamin Herrenschmidt wrote:
> > I think Christoph merely objects to the specific implementation.  If
> > instead you do something like tweak dev->bus_dma_mask for the virtio
> > device I think he won't object.
> 
> Well, we don't have "bus_dma_mask" yet ..or you mean dma_mask ?

It will be new in 4.19:

http://git.infradead.org/users/hch/dma-mapping.git/commitdiff/f07d141fe9430cdf9f8a65a87c41

> So, something like that would be a possibility, but the problem is that
> the current virtio (guest side) implementation doesn't honor this when
> not using dma ops and will not use dma ops if not using iommu, so back
> to square one.
> 
> Christoph seems to be wanting to use a flag in the interface to make
> the guest use dma_ops which is what I don't understand.

As-is virtio devices are very clearly and explcitly defined to use
physical addresses in the spec.  dma ops will often do platform
based translations (iommu, offsets), so we can't just use the plaform
default dma ops and will need to opt into them.

> What would be needed then would be something along the lines of virtio
> noticing that dma_mask isn't big enough to cover all of memory (which
> isn't something generic code can easily do here for various reasons I
> can elaborate if you want, but that specific test more/less has to be
> arch specific), and in that case, force itself to use DMA ops routed to
> swiotlb.
> 
> I'd rather have arch code do the bulk of that work, don't you think ?

There is nothing architecture specific about that.  I've been working
hard to remove all the bullshit architectures have done in their DMA
ops and consolidating them into common code based on rules.  The last
thing I want is another vector for weird underspecified arch
interfaction with DMA ops, which is exactly what your patch below
does.
