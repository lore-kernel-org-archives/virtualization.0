From: "Zhu, Lingshan" <lingshan.zhu@intel.com>
Subject: Re: [PATCH] vdpa: allow a 32 bit vq alignment
Date: Fri, 10 Apr 2020 14:24:37 +0800
Message-ID: <1c164046-cc4c-f5fb-bed1-a650b5078b6f@intel.com>
References: <20200409202825.10115-1-mst@redhat.com>
 <bed03b3a-ebc0-2a93-7e6b-8f884eab747b@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <bed03b3a-ebc0-2a93-7e6b-8f884eab747b@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org


On 4/10/2020 2:21 PM, Jason Wang wrote:
> Cc Ling Shan.
>
> On 2020/4/10 上午4:28, Michael S. Tsirkin wrote:
>> get_vq_align returns u16 now, but that's not enough for
>> systems/devices with 64K pages. All callers assign it to
>> a u32 variable anyway, so let's just change the return
>> value type to u32.
>>
>> Cc: "Zhu, Lingshan" <lingshan.zhu@intel.com>
>> Reported-by: Arnd Bergmann <arnd@arndb.de>
>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>> ---
>>   drivers/vdpa/ifcvf/ifcvf_main.c  | 2 +-
>>   drivers/vdpa/vdpa_sim/vdpa_sim.c | 2 +-
>>   include/linux/vdpa.h             | 2 +-
>>   3 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c 
>> b/drivers/vdpa/ifcvf/ifcvf_main.c
>> index 28d9e5de5675..abf6a061cab6 100644
>> --- a/drivers/vdpa/ifcvf/ifcvf_main.c
>> +++ b/drivers/vdpa/ifcvf/ifcvf_main.c
>> @@ -226,7 +226,7 @@ static u32 ifcvf_vdpa_get_vendor_id(struct 
>> vdpa_device *vdpa_dev)
>>       return IFCVF_SUBSYS_VENDOR_ID;
>>   }
>>   -static u16 ifcvf_vdpa_get_vq_align(struct vdpa_device *vdpa_dev)
>> +static u32 ifcvf_vdpa_get_vq_align(struct vdpa_device *vdpa_dev)
>>   {
>>       return IFCVF_QUEUE_ALIGNMENT;
>>   }
>> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c 
>> b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>> index 72863d01a12a..7957d2d41fc4 100644
>> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
>> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>> @@ -435,7 +435,7 @@ static u64 vdpasim_get_vq_state(struct 
>> vdpa_device *vdpa, u16 idx)
>>       return vrh->last_avail_idx;
>>   }
>>   -static u16 vdpasim_get_vq_align(struct vdpa_device *vdpa)
>> +static u32 vdpasim_get_vq_align(struct vdpa_device *vdpa)
>>   {
>>       return VDPASIM_QUEUE_ALIGN;
>>   }
>> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
>> index 733acfb7ef84..5453af87a33e 100644
>> --- a/include/linux/vdpa.h
>> +++ b/include/linux/vdpa.h
>> @@ -164,7 +164,7 @@ struct vdpa_config_ops {
>>       u64 (*get_vq_state)(struct vdpa_device *vdev, u16 idx);
>>         /* Device ops */
>> -    u16 (*get_vq_align)(struct vdpa_device *vdev);
>> +    u32 (*get_vq_align)(struct vdpa_device *vdev);
>>       u64 (*get_features)(struct vdpa_device *vdev);
>>       int (*set_features)(struct vdpa_device *vdev, u64 features);
>>       void (*set_config_cb)(struct vdpa_device *vdev,
>
looks good to me

Thanks,
BR
Zhu Lingshan
