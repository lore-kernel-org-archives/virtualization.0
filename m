From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC 0/4] Virtio uses DMA API for all devices
Date: Mon, 6 Aug 2018 02:42:43 -0700
Message-ID: <20180806094243.GA16032@infradead.org>
References: <20180802225738-mutt-send-email-mst@kernel.org>
	<de4888b6457e220776e16a9c8958ff0886ffc66c.camel@kernel.crashing.org>
	<20180803070507.GA1344@infradead.org>
	<eb1750e90e4bd45da297fa6f78f8ef93671b7c2f.camel@kernel.crashing.org>
	<20180803160246.GA13794@infradead.org>
	<22310f58605169fe9de83abf78b59f593ff7fbb7.camel@kernel.crashing.org>
	<20180804082120.GB4421@infradead.org>
	<a3ec0a454928e880dabc3782ea906e318634abf9.camel@kernel.crashing.org>
	<20180805072930.GB23288@infradead.org>
	<b7e8294e3e70d24072883a7e8e5375719d5af870.camel@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <b7e8294e3e70d24072883a7e8e5375719d5af870.camel@kernel.crashing.org>
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
Cc: robh@kernel.org, srikar@linux.vnet.ibm.com, "Michael S. Tsirkin" <mst@redhat.com>, mpe@ellerman.id.au, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, linuxram@us.ibm.com, virtualization@lists.linux-foundation.org, Christoph Hellwig <hch@infradead.org>, paulus@samba.org, marc.zyngier@arm.com, joe@perches.com, robin.murphy@arm.com, david@gibson.dropbear.id.au, linuxppc-dev@lists.ozlabs.org, elfring@users.sourceforge.net, haren@linux.vnet.ibm.com, Anshuman Khandual <khandual@linux.vnet.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Aug 06, 2018 at 07:16:47AM +1000, Benjamin Herrenschmidt wrote:
> Who would set this bit ? qemu ? Under what circumstances ?

I don't really care who sets what.  The implementation might not even
involved qemu.

It is your job to write a coherent interface specification that does
not depend on the used components.  The hypervisor might be PAPR,
Linux + qemu, VMware, Hyperv or something so secret that you'd have
to shoot me if you had to tell me.  The guest might be Linux, FreeBSD,
AIX, OS400 or a Hipster project of the day in Rust.  As long as we
properly specify the interface it simplify does not matter.

> What would be the effect of this bit while VIRTIO_F_IOMMU is NOT set,
> ie, what would qemu do and what would Linux do ? I'm not sure I fully
> understand your idea.

In a perfect would we'd just reuse VIRTIO_F_IOMMU and clarify the
description which currently is rather vague but basically captures
the use case.  Currently is is:

VIRTIO_F_IOMMU_PLATFORM(33)
    This feature indicates that the device is behind an IOMMU that
    translates bus addresses from the device into physical addresses in
    memory. If this feature bit is set to 0, then the device emits
    physical addresses which are not translated further, even though an
    IOMMU may be present.

And I'd change it to something like:

VIRTIO_F_PLATFORM_DMA(33)
    This feature indicates that the device emits platform specific
    bus addresses that might not be identical to physical address.
    The translation of physical to bus address is platform speific
    and defined by the plaform specification for the bus that the virtio
    device is attached to.
    If this feature bit is set to 0, then the device emits
    physical addresses which are not translated further, even if
    the platform would normally require translations for the bus that
    the virtio device is attached to.

If we can't change the defintion any more we should deprecate the
old VIRTIO_F_IOMMU_PLATFORM bit, and require the VIRTIO_F_IOMMU_PLATFORM
and VIRTIO_F_PLATFORM_DMA to be not set at the same time.

> I'm trying to understand because the limitation is not a device side
> limitation, it's not a qemu limitation, it's actually more of a VM
> limitation. It has most of its memory pages made inaccessible for
> security reasons. The platform from a qemu/KVM perspective is almost
> entirely normal.

Well, find a way to describe this either in the qemu specification using
new feature bits, or by using something like the above.
