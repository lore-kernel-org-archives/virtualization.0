From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: Re: [RFC 2/4] virtio: Override device's DMA OPS with
	virtio_direct_dma_ops selectively
Date: Tue, 31 Jul 2018 12:09:45 +0530
Message-ID: <52dcdcf5-971f-a53d-6cee-603668033596__25055.7953179397$1533019077$gmane$org@linux.vnet.ibm.com>
References: <20180720035941.6844-1-khandual@linux.vnet.ibm.com>
	<20180720035941.6844-3-khandual@linux.vnet.ibm.com>
	<c443ad8c-fb81-302d-edb2-5521831d38da@linux.vnet.ibm.com>
	<20180729001344-mutt-send-email-mst@kernel.org>
	<20180730093027.GC26245@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180730093027.GC26245@infradead.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Christoph Hellwig <hch@infradead.org>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: robh@kernel.org, srikar@linux.vnet.ibm.com, benh@kernel.crashing.org, linuxram@us.ibm.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, paulus@samba.org, mpe@ellerman.id.au, joe@perches.com, linuxppc-dev@lists.ozlabs.org, elfring@users.sourceforge.net, haren@linux.vnet.ibm.com, david@gibson.dropbear.id.au
List-Id: virtualization@lists.linuxfoundation.org

On 07/30/2018 03:00 PM, Christoph Hellwig wrote:
>>> +
>>> +	if (xen_domain())
>>> +		goto skip_override;
>>> +
>>> +	if (virtio_has_iommu_quirk(dev))
>>> +		set_dma_ops(dev->dev.parent, &virtio_direct_dma_ops);
>>> +
>>> + skip_override:
>>> +
>>
>> I prefer normal if scoping as opposed to goto spaghetti pls.
>> Better yet move vring_use_dma_api here and use it.
>> Less of a chance something will break.
> 
> I agree about avoid pointless gotos here, but we can do things
> perfectly well without either gotos or a confusing helper here
> if we structure it right. E.g.:
> 
> 	// suitably detailed comment here
> 	if (!xen_domain() &&
> 	    !virtio_has_feature(vdev, VIRTIO_F_IOMMU_PLATFORM))
> 		set_dma_ops(dev->dev.parent, &virtio_direct_dma_ops);

I had updated this patch calling vring_use_dma_api() as a helper
as suggested by Michael but yes we can have the above condition
with a comment block. I will change this patch accordingly.

> 
> and while we're at it - modifying dma ops for the parent looks very
> dangerous.  I don't think we can do that, as it could break iommu
> setup interactions.  IFF we set a specific dma map ops it has to be
> on the virtio device itself, of which we have full control.

I understand your concern. At present virtio core calls parent's DMA
ops callbacks when device has VIRTIO_F_IOMMU_PLATFORM flag set. Most
likely those DMA OPS are architecture specific ones which can really
configure IOMMU. Most probably all devices and their parents share
the same DMA ops callback. IIUC as long as the entire system has a
single DMA ops structure, it should be okay. But I may be missing
other implications. I tried changing virtio core so that it always
calls device's DMA ops instead of it's parent DMA ops, it hit the
following WARN_ON for devices without IOMMU flag and hit both the
WARN_ON and BUG_ON for devices with the IOMMU flag.

static inline void *dma_alloc_attrs(struct device *dev, size_t size,
                                       dma_addr_t *dma_handle, gfp_t flag,
                                       unsigned long attrs)
{
        const struct dma_map_ops *ops = get_dma_ops(dev);
        void *cpu_addr;

        BUG_ON(!ops);
        WARN_ON_ONCE(dev && !dev->coherent_dma_mask);

--------

Seems like virtio device's DMA ops and coherent_dma_mask was never
set correctly assuming that virtio core always called parent's DMA
OPS all the time. We may have to change virtio device init to fix
this. Any thoughts ?
