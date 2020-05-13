From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V2] ifcvf: move IRQ request/free to status change handlers
Date: Wed, 13 May 2020 15:18:21 +0800
Message-ID: <572ed6af-7a04-730e-c803-a41868091e88@redhat.com>
References: <1589270444-3669-1-git-send-email-lingshan.zhu@intel.com>
 <8aca85c3-3bf6-a1ec-7009-cd9a635647d7@redhat.com>
 <5bbe0c21-8638-45e4-04e8-02ad0df44b38@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <5bbe0c21-8638-45e4-04e8-02ad0df44b38@intel.com>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>, mst@redhat.com, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: lulu@redhat.com, dan.daly@intel.com, cunming.liang@intel.com
List-Id: virtualization@lists.linuxfoundation.org


On 2020/5/13 下午12:42, Zhu, Lingshan wrote:
>
>
> On 5/13/2020 12:12 PM, Jason Wang wrote:
>>
>> On 2020/5/12 下午4:00, Zhu Lingshan wrote:
>>> This commit move IRQ request and free operations from probe()
>>> to VIRTIO status change handler to comply with VIRTIO spec.
>>>
>>> VIRTIO spec 1.1, section 2.1.2 Device Requirements: Device Status Field
>>> The device MUST NOT consume buffers or send any used buffer
>>> notifications to the driver before DRIVER_OK.
>>
>>
>> This comment needs to be checked as I said previously. It's only 
>> needed if we're sure ifcvf can generate interrupt before DRIVER_OK.
>>
>>
>>>
>>> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
>>> ---
>>> changes from V1:
>>> remove ifcvf_stop_datapath() in status == 0 handler, we don't need 
>>> to do this
>>> twice; handle status == 0 after DRIVER_OK -> !DRIVER_OK handler 
>>> (Jason Wang)
>>
>>
>> Patch looks good to me, but with this patch ping cannot work on my 
>> machine. (It works without this patch).
>>
>> Thanks
> This is strange, it works on my machines, let's have a check offline.
>
> Thanks,
> BR
> Zhu Lingshan


I give it a try with virito-vpda and a tiny userspace. Either works.

So it could be an issue of qemu codes.

Let's wait for Cindy to test if it really works.

Thanks
