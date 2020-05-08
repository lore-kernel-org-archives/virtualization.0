From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH -next] vdpasim: remove unused variable 'ret'
Date: Fri, 8 May 2020 14:57:27 +0800
Message-ID: <f832450b-03f8-b5b6-76ae-c5c0fe5f2fdb@redhat.com>
References: <20200410115422.42308-1-yuehaibing@huawei.com>
 <20200505203544-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200505203544-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>, YueHaibing <yuehaibing@huawei.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org


On 2020/5/6 上午8:35, Michael S. Tsirkin wrote:
> On Fri, Apr 10, 2020 at 07:54:22PM +0800, YueHaibing wrote:
>> drivers/vdpa/vdpa_sim/vdpa_sim.c:92:6: warning:
>>   variable ‘ret’ set but not used [-Wunused-but-set-variable]
>>
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>> ---
> Either this, or BUG_ON.  Jason?


BUG_ON seems too aggressive. So I prefer this patch.

Acked-by: Jason Wang <jasowang@redhat.com>


>
>>   drivers/vdpa/vdpa_sim/vdpa_sim.c | 15 +++++++--------
>>   1 file changed, 7 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>> index 7957d2d41fc4..01c456f7c1f7 100644
>> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
>> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>> @@ -89,15 +89,14 @@ static struct vdpasim *dev_to_sim(struct device *dev)
>>   static void vdpasim_queue_ready(struct vdpasim *vdpasim, unsigned int idx)
>>   {
>>   	struct vdpasim_virtqueue *vq = &vdpasim->vqs[idx];
>> -	int ret;
>>   
>> -	ret = vringh_init_iotlb(&vq->vring, vdpasim_features,
>> -				VDPASIM_QUEUE_MAX, false,
>> -				(struct vring_desc *)(uintptr_t)vq->desc_addr,
>> -				(struct vring_avail *)
>> -				(uintptr_t)vq->driver_addr,
>> -				(struct vring_used *)
>> -				(uintptr_t)vq->device_addr);
>> +	vringh_init_iotlb(&vq->vring, vdpasim_features,
>> +			  VDPASIM_QUEUE_MAX, false,
>> +			  (struct vring_desc *)(uintptr_t)vq->desc_addr,
>> +			  (struct vring_avail *)
>> +			  (uintptr_t)vq->driver_addr,
>> +			  (struct vring_used *)
>> +			  (uintptr_t)vq->device_addr);
>>   }
>>   
>>   static void vdpasim_vq_reset(struct vdpasim_virtqueue *vq)
>> -- 
>> 2.17.1
>>
