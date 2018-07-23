From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: Re: [RFC 4/4] virtio: Add platform specific DMA API translation for
	virito devices
Date: Mon, 23 Jul 2018 07:46:09 +0530
Message-ID: <3dd36d8e-3bc8-91ba-cf6d-939495439d2c@linux.vnet.ibm.com>
References: <20180720035941.6844-1-khandual@linux.vnet.ibm.com>
	<20180720035941.6844-5-khandual@linux.vnet.ibm.com>
	<20180720160550-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180720160550-mutt-send-email-mst@kernel.org>
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
Cc: robh@kernel.org, srikar@linux.vnet.ibm.com, benh@kernel.crashing.org, linuxram@us.ibm.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, hch@infradead.org, paulus@samba.org, mpe@ellerman.id.au, joe@perches.com, linuxppc-dev@lists.ozlabs.org, elfring@users.sourceforge.net, haren@linux.vnet.ibm.com, david@gibson.dropbear.id.au
List-Id: virtualization@lists.linuxfoundation.org

On 07/20/2018 06:45 PM, Michael S. Tsirkin wrote:
> On Fri, Jul 20, 2018 at 09:29:41AM +0530, Anshuman Khandual wrote:
>> Subject: Re: [RFC 4/4] virtio: Add platform specific DMA API translation for
>> virito devices
> 
> s/virito/virtio/

Oops, will fix it. Thanks for pointing out.

> 
>> This adds a hook which a platform can define in order to allow it to
>> override virtio device's DMA OPS irrespective of whether it has the
>> flag VIRTIO_F_IOMMU_PLATFORM set or not. We want to use this to do
>> bounce-buffering of data on the new secure pSeries platform, currently
>> under development, where a KVM host cannot access all of the memory
>> space of a secure KVM guest.  The host can only access the pages which
>> the guest has explicitly requested to be shared with the host, thus
>> the virtio implementation in the guest has to copy data to and from
>> shared pages.
>>
>> With this hook, the platform code in the secure guest can force the
>> use of swiotlb for virtio buffers, with a back-end for swiotlb which
>> will use a pool of pre-allocated shared pages.  Thus all data being
>> sent or received by virtio devices will be copied through pages which
>> the host has access to.
>>
>> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/include/asm/dma-mapping.h | 6 ++++++
>>  arch/powerpc/platforms/pseries/iommu.c | 6 ++++++
>>  drivers/virtio/virtio.c                | 7 +++++++
>>  3 files changed, 19 insertions(+)
>>
>> diff --git a/arch/powerpc/include/asm/dma-mapping.h b/arch/powerpc/include/asm/dma-mapping.h
>> index 8fa3945..bc5a9d3 100644
>> --- a/arch/powerpc/include/asm/dma-mapping.h
>> +++ b/arch/powerpc/include/asm/dma-mapping.h
>> @@ -116,3 +116,9 @@ extern u64 __dma_get_required_mask(struct device *dev);
>>  
>>  #endif /* __KERNEL__ */
>>  #endif	/* _ASM_DMA_MAPPING_H */
>> +
>> +#define platform_override_dma_ops platform_override_dma_ops
>> +
>> +struct virtio_device;
>> +
>> +extern void platform_override_dma_ops(struct virtio_device *vdev);
>> diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
>> index 06f0296..5773bc7 100644
>> --- a/arch/powerpc/platforms/pseries/iommu.c
>> +++ b/arch/powerpc/platforms/pseries/iommu.c
>> @@ -38,6 +38,7 @@
>>  #include <linux/of.h>
>>  #include <linux/iommu.h>
>>  #include <linux/rculist.h>
>> +#include <linux/virtio.h>
>>  #include <asm/io.h>
>>  #include <asm/prom.h>
>>  #include <asm/rtas.h>
>> @@ -1396,3 +1397,8 @@ static int __init disable_multitce(char *str)
>>  __setup("multitce=", disable_multitce);
>>  
>>  machine_subsys_initcall_sync(pseries, tce_iommu_bus_notifier_init);
>> +
>> +void platform_override_dma_ops(struct virtio_device *vdev)
>> +{
>> +	/* Override vdev->parent.dma_ops if required */
>> +}
>> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
>> index 6b13987..432c332 100644
>> --- a/drivers/virtio/virtio.c
>> +++ b/drivers/virtio/virtio.c
>> @@ -168,6 +168,12 @@ EXPORT_SYMBOL_GPL(virtio_add_status);
>>  
>>  const struct dma_map_ops virtio_direct_dma_ops;
>>  
>> +#ifndef platform_override_dma_ops
>> +static inline void platform_override_dma_ops(struct virtio_device *vdev)
>> +{
>> +}
>> +#endif
>> +
>>  int virtio_finalize_features(struct virtio_device *dev)
>>  {
>>  	int ret = dev->config->finalize_features(dev);
>> @@ -179,6 +185,7 @@ int virtio_finalize_features(struct virtio_device *dev)
>>  	if (virtio_has_iommu_quirk(dev))
>>  		set_dma_ops(dev->dev.parent, &virtio_direct_dma_ops);
>>  
>> +	platform_override_dma_ops(dev);
> 
> Is there a single place where virtio_has_iommu_quirk is called now?

Not other than this one. But in the proposed implementation of
platform_override_dma_ops on powerpc, we will again check on
virtio_has_iommu_quirk before overriding it with SWIOTLB.

void platform_override_dma_ops(struct virtio_device *vdev)
{
        if (is_ultravisor_platform() && virtio_has_iommu_quirk(vdev))
                set_dma_ops(vdev->dev.parent, &swiotlb_dma_ops);
}

> If so, we could put this into virtio_has_iommu_quirk then.

Did you mean platform_override_dma_ops instead ? If so, yes that
is possible. Default implementation of platform_override_dma_ops
should just check on VIRTIO_F_IOMMU_PLATFORM feature and override
with virtio_direct_dma_ops but arch implementation can check on
what ever else they would like and override appropriately.

Default platform_override_dma_ops will be like this

#ifndef platform_override_dma_ops
static inline void platform_override_dma_ops(struct virtio_device *vdev)
{
	if(!virtio_has_feature(vdev, VIRTIO_F_IOMMU_PLATFORM))
		set_dma_ops(dev->dev.parent, &virtio_direct_dma_ops);
}
#endif

Proposed powerpc implementation will be like this instead

void platform_override_dma_ops(struct virtio_device *vdev)
{
	if (virtio_has_feature(vdev, VIRTIO_F_IOMMU_PLATFORM))
		return;

        if (is_ultravisor_platform())
                set_dma_ops(vdev->dev.parent, &swiotlb_dma_ops);
	else
		set_dma_ops(dev->dev.parent, &virtio_direct_dma_ops);
	
}

There is a redundant definition of virtio_has_iommu_quirk in the tools
directory (tools/virtio/linux/virtio_config.h) which does not seem to
be used any where. I guess that can be removed without problem.
