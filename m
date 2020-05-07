From: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH v5] iommu/virtio: Use page size bitmap supported by
 endpoint
Date: Thu, 7 May 2020 14:52:21 +0200
Message-ID: <fc391eed-18e2-3f0b-41aa-2352e1967750@redhat.com>
References: <20200505093004.1935-1-bbhushan2@marvell.com>
 <20200505200659-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200505200659-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>, Bharat Bhushan <bbhushan2@marvell.com>
Cc: jean-philippe@linaro.org, joro@8bytes.org, jasowang@redhat.com, virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, eric.auger.pro@gmail.com
List-Id: virtualization@lists.linuxfoundation.org

Hi,

On 5/6/20 2:22 AM, Michael S. Tsirkin wrote:
> On Tue, May 05, 2020 at 03:00:04PM +0530, Bharat Bhushan wrote:
>> Different endpoint can support different page size, probe
>> endpoint if it supports specific page size otherwise use
>> global page sizes.
>>
>> Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
>> ---
>> v4->v5:
>>  - Rebase to Linux v5.7-rc4
>>
>> v3->v4:
>>  - Fix whitespace error
>>
>> v2->v3:
>>  - Fixed error return for incompatible endpoint
>>  - __u64 changed to __le64 in header file
>>
>>  drivers/iommu/virtio-iommu.c      | 48 ++++++++++++++++++++++++++++---
>>  include/uapi/linux/virtio_iommu.h |  7 +++++
>>  2 files changed, 51 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
>> index d5cac4f46ca5..9513d2ab819e 100644
>> --- a/drivers/iommu/virtio-iommu.c
>> +++ b/drivers/iommu/virtio-iommu.c
>> @@ -78,6 +78,7 @@ struct viommu_endpoint {
>>  	struct viommu_dev		*viommu;
>>  	struct viommu_domain		*vdomain;
>>  	struct list_head		resv_regions;
>> +	u64				pgsize_bitmap;
>>  };
>>  
>>  struct viommu_request {
>> @@ -415,6 +416,19 @@ static int viommu_replay_mappings(struct viommu_domain *vdomain)
>>  	return ret;
>>  }
>>  
>> +static int viommu_set_pgsize_bitmap(struct viommu_endpoint *vdev,
>> +				    struct virtio_iommu_probe_pgsize_mask *mask,
>> +				    size_t len)
>> +{
>> +	u64 pgsize_bitmap = le64_to_cpu(mask->pgsize_bitmap);
>> +
>> +	if (len < sizeof(*mask))
> 
> This is too late to validate length, you have dereferenced it already.
> do it before the read pls.
> 
>> +		return -EINVAL;
> 
> OK but note that guest will then just proceed to ignore the
> property. Is that really OK? Wouldn't host want to know?
> 
> 
>> +
>> +	vdev->pgsize_bitmap = pgsize_bitmap;
> 
> what if bitmap is 0? Is that a valid size? I see a bunch of
> BUG_ON with that value ...
Indeed [PATCH v2] virtio-iommu: Add PAGE_SIZE_MASK property states
"The device MUST set at least one bit in page_size_mask, describing
the page granularity".

atm if the device returns a null mask the guest hits such BUG_ON()

[    1.841434] kernel BUG at drivers/iommu/iommu.c:653!
[    1.842868] Internal error: Oops - BUG: 0 [#1] SMP
[    1.844261] Modules linked in:
[    1.845161] CPU: 6 PID: 325 Comm: kworker/6:1 Not tainted
5.7.0-rc4-aarch64-guest-bharat-v5+ #196
[    1.847474] Hardware name: linux,dummy-virt (DT)
[    1.848329] Workqueue: events deferred_probe_work_func
[    1.849229] pstate: 60400005 (nZCv daif +PAN -UAO)
[    1.850116] pc : iommu_group_create_direct_mappings.isra.24+0x210/0x228
[    1.851351] lr : iommu_group_add_device+0x108/0x2d0
[    1.852270] sp : ffff800015bef880
[    1.852901] x29: ffff800015bef880 x28: ffff0003cc3dab98
[    1.853897] x27: 0000000000000000 x26: ffff0003cc3dab80
[    1.854894] x25: ffff800011033480 x24: ffff0003cc080948
[    1.855891] x23: ffff8000113f49c8 x22: 0000000000000000
[    1.856887] x21: ffff0003cc3dac00 x20: ffff0003cc080a00
[    1.858440] x19: 0000000000000000 x18: 0000000000000010
[    1.860029] x17: 000000009a468e4c x16: 0000000000300604
[    1.861616] x15: ffffffffffffffff x14: 0720072007200720
[    1.863200] x13: 0720072007200720 x12: 0000000000000020
[    1.864787] x11: 0101010101010101 x10: 7f7f7f7f7f7f7f7f
[    1.866373] x9 : ffff8000107de0d8 x8 : 7f7f7f7f7f7f7f7f
[    1.868048] x7 : 39322f392f2f2f2f x6 : 0000000080808080
[    1.869634] x5 : ffff0003cc171000 x4 : ffff0003cc171000
[    1.871218] x3 : ffff8000114aff28 x2 : 0000000000000000
[    1.872802] x1 : ffff0003cb3c60b0 x0 : 0000000000000003
[    1.874383] Call trace:
[    1.875133]  iommu_group_create_direct_mappings.isra.24+0x210/0x228
[    1.876996]  iommu_group_add_device+0x108/0x2d0
[    1.878359]  iommu_group_get_for_dev+0xa0/0x210
[    1.879714]  viommu_add_device+0x128/0x480
[    1.880942]  iommu_probe_device+0x5c/0xd8
[    1.882144]  of_iommu_configure+0x160/0x208
[    1.883535]  of_dma_configure+0xec/0x2b8
[    1.884732]  pci_dma_configure+0x48/0xd0
[    1.885911]  really_probe+0xa0/0x448
[    1.886985]  driver_probe_device+0xe8/0x140
[    1.888253]  __device_attach_driver+0x94/0x120
[    1.889581]  bus_for_each_drv+0x84/0xd8
[    1.890730]  __device_attach+0xe4/0x168
[    1.891879]  device_initial_probe+0x1c/0x28
[    1.893164]  bus_probe_device+0xa4/0xb0
[    1.894311]  deferred_probe_work_func+0xa0/0xf0
[    1.895663]  process_one_work+0x1bc/0x458
[    1.896864]  worker_thread+0x150/0x4f8
[    1.898003]  kthread+0x114/0x118
[    1.898977]  ret_from_fork+0x10/0x18
[    1.900056] Code: d63f0020 b9406be2 17ffffe4 a90573fb (d4210000)
[    1.901872] ---[ end trace 47e5fb5111a3e69b ]---
[    1.903251] Kernel panic - not syncing: Fatal exception
[    1.904809] SMP: stopping secondary CPUs
[    1.906024] Kernel Offset: disabled
[    1.907079] CPU features: 0x084002,22000438
[    1.908332] Memory Limit: none
[    1.909255] ---[ end Kernel panic - not syncing: Fatal exception ]---
Connection closed by foreign host.

Thanks

Eric


> 
> I also see a bunch of code like e.g. this:
> 
>         pg_size = 1UL << __ffs(pgsize_bitmap);
> 
> which probably won't DTRT on a 32 bit guest if the bitmap has bits
> set in the high word.
> 
> 
> 
>> +	return 0;
>> +}
>> +
>>  static int viommu_add_resv_mem(struct viommu_endpoint *vdev,
>>  			       struct virtio_iommu_probe_resv_mem *mem,
>>  			       size_t len)
>> @@ -499,6 +513,9 @@ static int viommu_probe_endpoint(struct viommu_dev *viommu, struct device *dev)
>>  		case VIRTIO_IOMMU_PROBE_T_RESV_MEM:
>>  			ret = viommu_add_resv_mem(vdev, (void *)prop, len);
>>  			break;
>> +		case VIRTIO_IOMMU_PROBE_T_PAGE_SIZE_MASK:
>> +			ret = viommu_set_pgsize_bitmap(vdev, (void *)prop, len);
>> +			break;
>>  		default:
>>  			dev_err(dev, "unknown viommu prop 0x%x\n", type);
>>  		}
>> @@ -630,7 +647,7 @@ static int viommu_domain_finalise(struct viommu_endpoint *vdev,
>>  
>>  	vdomain->id		= (unsigned int)ret;
>>  
>> -	domain->pgsize_bitmap	= viommu->pgsize_bitmap;
>> +	domain->pgsize_bitmap	= vdev->pgsize_bitmap;
>>  	domain->geometry	= viommu->geometry;
>>  
>>  	vdomain->map_flags	= viommu->map_flags;
>> @@ -654,6 +671,29 @@ static void viommu_domain_free(struct iommu_domain *domain)
>>  	kfree(vdomain);
>>  }
>>  
>> +/*
>> + * Check whether the endpoint's capabilities are compatible with other
>> + * endpoints in the domain. Report any inconsistency.
>> + */
>> +static bool viommu_endpoint_is_compatible(struct viommu_endpoint *vdev,
>> +					  struct viommu_domain *vdomain)
>> +{
>> +	struct device *dev = vdev->dev;
>> +
>> +	if (vdomain->viommu != vdev->viommu) {
>> +		dev_err(dev, "cannot attach to foreign vIOMMU\n");
>> +		return false;
>> +	}
>> +
>> +	if (vdomain->domain.pgsize_bitmap != vdev->pgsize_bitmap) {
>> +		dev_err(dev, "incompatible domain bitmap 0x%lx != 0x%llx\n",
>> +			vdomain->domain.pgsize_bitmap, vdev->pgsize_bitmap);
>> +		return false;
>> +	}
> 
> I'm confused by this. So let's assume host supports pages sizes
> of 4k, 2M, 1G. It signals this in the properties. Nice.
> Now domain supports 4k, 2M and that's all. Why is that a problem?
> Just don't use 1G ..>
> 
>> +
>> +	return true;
>> +}
>> +
>>  static int viommu_attach_dev(struct iommu_domain *domain, struct device *dev)
>>  {
>>  	int i;
>> @@ -670,9 +710,8 @@ static int viommu_attach_dev(struct iommu_domain *domain, struct device *dev)
>>  		 * owns it.
>>  		 */
>>  		ret = viommu_domain_finalise(vdev, domain);
>> -	} else if (vdomain->viommu != vdev->viommu) {
>> -		dev_err(dev, "cannot attach to foreign vIOMMU\n");
>> -		ret = -EXDEV;
>> +	} else if (!viommu_endpoint_is_compatible(vdev, vdomain)) {
>> +		ret = -EINVAL;
>>  	}
>>  	mutex_unlock(&vdomain->mutex);
>>  
>> @@ -886,6 +925,7 @@ static int viommu_add_device(struct device *dev)
>>  
>>  	vdev->dev = dev;
>>  	vdev->viommu = viommu;
>> +	vdev->pgsize_bitmap = viommu->pgsize_bitmap;
>>  	INIT_LIST_HEAD(&vdev->resv_regions);
>>  	dev_iommu_priv_set(dev, vdev);
>>  
>> diff --git a/include/uapi/linux/virtio_iommu.h b/include/uapi/linux/virtio_iommu.h
>> index 48e3c29223b5..2cced7accc99 100644
>> --- a/include/uapi/linux/virtio_iommu.h
>> +++ b/include/uapi/linux/virtio_iommu.h
> 
> As any virtio UAPI change, you need to copy virtio TC at some point
> before this is merged ...
> 
>> @@ -111,6 +111,7 @@ struct virtio_iommu_req_unmap {
>>  
>>  #define VIRTIO_IOMMU_PROBE_T_NONE		0
>>  #define VIRTIO_IOMMU_PROBE_T_RESV_MEM		1
>> +#define VIRTIO_IOMMU_PROBE_T_PAGE_SIZE_MASK	2
>>  
>>  #define VIRTIO_IOMMU_PROBE_T_MASK		0xfff
>>
> 
> Does host need to know that guest will ignore the page size mask?
> Maybe we need a feature bit.
>   
>> @@ -119,6 +120,12 @@ struct virtio_iommu_probe_property {
>>  	__le16					length;
>>  };
>>  
>> +struct virtio_iommu_probe_pgsize_mask {
>> +	struct virtio_iommu_probe_property	head;
>> +	__u8					reserved[4];
>> +	__le64					pgsize_bitmap;
>> +};
>> +
> 
> This is UAPI. Document the format of pgsize_bitmap please.
> 
> 
>>  #define VIRTIO_IOMMU_RESV_MEM_T_RESERVED	0
>>  #define VIRTIO_IOMMU_RESV_MEM_T_MSI		1
>>  
>> -- 
>> 2.17.1
> 
