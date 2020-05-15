From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] vdpa_sim: do not reset IOTLB during device reset
Date: Fri, 15 May 2020 11:02:00 +0800
Message-ID: <c0353f0c-e60e-3fcd-6452-38eefca18a03@redhat.com>
References: <20200514072549.29694-1-jasowang@redhat.com>
 <20200514053233-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200514053233-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org


On 2020/5/14 下午5:35, Michael S. Tsirkin wrote:
> On Thu, May 14, 2020 at 03:25:49PM +0800, Jason Wang wrote:
>> We reset IOTLB during device reset this breaks the assumption that the
>> mapping needs to be controlled via vDPA DMA ops explicitly in a
>> incremental way. So the networking will be broken after e.g a guest
>> reset.
>>
>> Fix this by not resetting the IOTLB during device reset.
>>
>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>
> That's a bit weird, and can be a security risk if state
> leaks between security domains through this.


I'm not sure I get this. Note that:

1) For devices that depend on platform IOMMU, the mappings are valid 
across device reset
2) vhost_vdpa will reset IOTLB during release, so I think there's no 
security leak in this case

If we reset IOTLB during device reset, there will be an inconsistency 
between on-chip IOMMU devices and platform IOMMU devices. We can fix 
this inconsistency in another way, e.g unmap during vhost_vdpa_reset. 
This means userspace need to replay the mapping before DRIVER_OK, which 
seems a burden to userspace.


> And there's 0 chance any hardware implementation can
> keep the translations around across resets - there
> is simply nowhere to keep them.


It depends on the hardware implementation, e.g the IOMMU does not belong 
to VF but PF.

Thanks


>
> IMHO we need a different way to make this work, simulator
> needs to look like a hardware device as much as possible.
>
>
>> ---
>>   drivers/vdpa/vdpa_sim/vdpa_sim.c | 2 --
>>   1 file changed, 2 deletions(-)
>>
>> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>> index 7957d2d41fc4..cc5525743a25 100644
>> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
>> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>> @@ -119,8 +119,6 @@ static void vdpasim_reset(struct vdpasim *vdpasim)
>>   	for (i = 0; i < VDPASIM_VQ_NUM; i++)
>>   		vdpasim_vq_reset(&vdpasim->vqs[i]);
>>   
>> -	vhost_iotlb_reset(vdpasim->iommu);
>> -
>>   	vdpasim->features = 0;
>>   	vdpasim->status = 0;
>>   	++vdpasim->generation;
>> -- 
>> 2.20.1
