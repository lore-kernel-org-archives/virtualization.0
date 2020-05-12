From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] ifcvf: move IRQ request/free to status change handlers
Date: Tue, 12 May 2020 13:51:25 +0800
Message-ID: <47713210-e9d9-d185-6e2e-433e2c436de9@redhat.com>
References: <1589181563-38400-1-git-send-email-lingshan.zhu@intel.com>
 <22d9dcdb-e790-0a68-ba41-b9530b2bf9fd@redhat.com>
 <0f822630-14ad-e0cd-4171-6213c30f0799@intel.com>
 <24d5875e-6f44-ce43-74f0-e641e02f8f42@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <24d5875e-6f44-ce43-74f0-e641e02f8f42@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>, mst@redhat.com, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: lulu@redhat.com, dan.daly@intel.com, cunming.liang@intel.com
List-Id: virtualization@lists.linuxfoundation.org


On 2020/5/12 上午11:38, Jason Wang wrote:
>>>>
>>>>   static int ifcvf_start_datapath(void *private)
>>>>   {
>>>>       struct ifcvf_hw *vf = ifcvf_private_to_vf(private);
>>>> @@ -118,9 +172,12 @@ static void ifcvf_vdpa_set_status(struct 
>>>> vdpa_device *vdpa_dev, u8 status)
>>>>   {
>>>>       struct ifcvf_adapter *adapter;
>>>>       struct ifcvf_hw *vf;
>>>> +    u8 status_old;
>>>> +    int ret;
>>>>         vf  = vdpa_to_vf(vdpa_dev);
>>>>       adapter = dev_get_drvdata(vdpa_dev->dev.parent);
>>>> +    status_old = ifcvf_get_status(vf);
>>>>         if (status == 0) {
>>>>           ifcvf_stop_datapath(adapter);
>>>> @@ -128,7 +185,22 @@ static void ifcvf_vdpa_set_status(struct 
>>>> vdpa_device *vdpa_dev, u8 status)
>>>>           return;
>>>>       }
>>>>   -    if (status & VIRTIO_CONFIG_S_DRIVER_OK) {
>>>> +    if ((status_old & VIRTIO_CONFIG_S_DRIVER_OK) &&
>>>> +        !(status & VIRTIO_CONFIG_S_DRIVER_OK)) {
>>>> +        ifcvf_stop_datapath(adapter);
>>>> +        ifcvf_free_irq(adapter, IFCVF_MAX_QUEUE_PAIRS * 2);
>>>> +    }
>>>> +
>>>> +    if ((status & VIRTIO_CONFIG_S_DRIVER_OK) &&
>>>> +        !(status_old & VIRTIO_CONFIG_S_DRIVER_OK)) {
>>>> +        ret = ifcvf_request_irq(adapter);
>>>> +        if (ret) {
>>>> +            status = ifcvf_get_status(vf);
>>>> +            status |= VIRTIO_CONFIG_S_FAILED;
>>>> +            ifcvf_set_status(vf, status);
>>>> +            return;
>>>> +        }
>>>> +
>>>
>>>
>>> Have a hard though on the logic here.
>>>
>>> This depends on the status setting from guest or userspace. Which 
>>> means it can not deal with e.g when qemu or userspace is crashed? Do 
>>> we need to care this or it's a over engineering?
>>>
>>> Thanks
>> If qemu crash, I guess users may re-run qmeu / re-initialize the 
>> device, according to the spec, there should be a reset routine.
>> This code piece handles status change on DRIVER_OK flipping. I am not 
>> sure I get your point, mind to give more hints?
>
>
> The problem is if we don't launch new qemu instance, the interrupt 
> will be still there?


Ok, we reset on vhost_vdpa_release() so the following is suspicious:

With the patch, we do:

static void ifcvf_vdpa_set_status(struct vdpa_device *vdpa_dev, u8 status)
{
         struct ifcvf_adapter *adapter;
         struct ifcvf_hw *vf;
         u8 status_old;
         int ret;

         vf  = vdpa_to_vf(vdpa_dev);
         adapter = dev_get_drvdata(vdpa_dev->dev.parent);
         status_old = ifcvf_get_status(vf);

         if (status == 0) {
                 ifcvf_stop_datapath(adapter);
                 ifcvf_reset_vring(adapter);
                 return;
         }

         if ((status_old & VIRTIO_CONFIG_S_DRIVER_OK) &&
             !(status & VIRTIO_CONFIG_S_DRIVER_OK)) {
                 ifcvf_stop_datapath(adapter);
                 ifcvf_free_irq(adapter, IFCVF_MAX_QUEUE_PAIRS * 2);
         }

...

So the handling of status == 0 looks wrong.

The OK -> !OK check should already cover the datapath stopping and irq 
stuffs.

We only need to deal with vring reset and only need to do it after we 
stop the datapath/irq stuffs.

Thanks



>
> Thanks 
