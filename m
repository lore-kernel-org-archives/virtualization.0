From: Pierre Morel <pmorel@linux.ibm.com>
Subject: Re: [PATCH v3 1/1] s390: virtio: let arch accept devices without
 IOMMU feature
Date: Mon, 29 Jun 2020 18:09:53 +0200
Message-ID: <a94443a3-1aff-8cf5-bc1c-9271f260e930@linux.ibm.com>
References: <1592390637-17441-1-git-send-email-pmorel@linux.ibm.com>
 <1592390637-17441-2-git-send-email-pmorel@linux.ibm.com>
 <20200629115651-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200629115651-mutt-send-email-mst@kernel.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: gor@linux.ibm.com, linux-s390@vger.kernel.org, frankja@linux.ibm.com, kvm@vger.kernel.org, thomas.lendacky@amd.com, heiko.carstens@de.ibm.com, cohuck@redhat.com, linuxram@us.ibm.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, pasic@linux.ibm.com, borntraeger@de.ibm.com, david@gibson.dropbear.id.au
List-Id: virtualization@lists.linuxfoundation.org



On 2020-06-29 17:57, Michael S. Tsirkin wrote:
> On Wed, Jun 17, 2020 at 12:43:57PM +0200, Pierre Morel wrote:
>> An architecture protecting the guest memory against unauthorized host
>> access may want to enforce VIRTIO I/O device protection through the
>> use of VIRTIO_F_IOMMU_PLATFORM.
>>
>> Let's give a chance to the architecture to accept or not devices
>> without VIRTIO_F_IOMMU_PLATFORM.
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> Acked-by: Jason Wang <jasowang@redhat.com>
>> Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
>>   arch/s390/mm/init.c     |  6 ++++++
>>   drivers/virtio/virtio.c | 22 ++++++++++++++++++++++
>>   include/linux/virtio.h  |  2 ++
>>   3 files changed, 30 insertions(+)
>>
>> diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
>> index 6dc7c3b60ef6..215070c03226 100644
>> --- a/arch/s390/mm/init.c
>> +++ b/arch/s390/mm/init.c
>> @@ -45,6 +45,7 @@
>>   #include <asm/kasan.h>
>>   #include <asm/dma-mapping.h>
>>   #include <asm/uv.h>
>> +#include <linux/virtio.h>
>>   
>>   pgd_t swapper_pg_dir[PTRS_PER_PGD] __section(.bss..swapper_pg_dir);
>>   
>> @@ -161,6 +162,11 @@ bool force_dma_unencrypted(struct device *dev)
>>   	return is_prot_virt_guest();
>>   }
>>   
>> +int arch_needs_virtio_iommu_platform(struct virtio_device *dev)
>> +{
>> +	return is_prot_virt_guest();
>> +}
>> +
>>   /* protected virtualization */
>>   static void pv_init(void)
>>   {
>> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
>> index a977e32a88f2..aa8e01104f86 100644
>> --- a/drivers/virtio/virtio.c
>> +++ b/drivers/virtio/virtio.c
>> @@ -167,6 +167,21 @@ void virtio_add_status(struct virtio_device *dev, unsigned int status)
>>   }
>>   EXPORT_SYMBOL_GPL(virtio_add_status);
>>   
>> +/*
>> + * arch_needs_virtio_iommu_platform - provide arch specific hook when finalizing
>> + *				      features for VIRTIO device dev
>> + * @dev: the VIRTIO device being added
>> + *
>> + * Permits the platform to provide architecture specific functionality when
>> + * devices features are finalized. This is the default implementation.
>> + * Architecture implementations can override this.
>> + */
>> +
>> +int __weak arch_needs_virtio_iommu_platform(struct virtio_device *dev)
>> +{
>> +	return 0;
>> +}
>> +
>>   int virtio_finalize_features(struct virtio_device *dev)
>>   {
>>   	int ret = dev->config->finalize_features(dev);
>> @@ -179,6 +194,13 @@ int virtio_finalize_features(struct virtio_device *dev)
>>   	if (!virtio_has_feature(dev, VIRTIO_F_VERSION_1))
>>   		return 0;
>>   
>> +	if (arch_needs_virtio_iommu_platform(dev) &&
>> +		!virtio_has_feature(dev, VIRTIO_F_IOMMU_PLATFORM)) {
>> +		dev_warn(&dev->dev,
>> +			 "virtio: device must provide VIRTIO_F_IOMMU_PLATFORM\n");
>> +		return -ENODEV;
>> +	}
>> +
>>   	virtio_add_status(dev, VIRTIO_CONFIG_S_FEATURES_OK);
>>   	status = dev->config->get_status(dev);
>>   	if (!(status & VIRTIO_CONFIG_S_FEATURES_OK)) {
> 
> Well don't you need to check it *before* VIRTIO_F_VERSION_1, not after?

Yes, you are right,

Thanks,

Pierre

-- 
Pierre Morel
IBM Lab Boeblingen
