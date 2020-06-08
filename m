From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH] virtio_mem: prevent overflow with subblock size
Date: Mon, 8 Jun 2020 09:34:51 +0200
Message-ID: <201e8ab5-ec50-af86-0ffc-d25befdba14e@redhat.com>
References: <20200608061406.709211-1-mst@redhat.com>
 <0930c9d0-0708-c079-29bd-b80d4e3ce446@redhat.com>
 <2D9A07BA-6FDC-48FF-9A1F-62272695B3EF@linux.alibaba.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2D9A07BA-6FDC-48FF-9A1F-62272695B3EF@linux.alibaba.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: teawater <teawaterz@linux.alibaba.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, LKML <linux-kernel@vger.kernel.org>, Jason Wang <jasowang@redhat.com>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 08.06.20 09:12, teawater wrote:
> 
> 
>> 2020年6月8日 14:58，David Hildenbrand <david@redhat.com> 写道：
>>
>> On 08.06.20 08:14, Michael S. Tsirkin wrote:
>>> If subblock size is large (e.g. 1G) 32 bit math involving it
>>> can overflow. Rather than try to catch all instances of that,
>>> let's tweak block size to 64 bit.
>>
>> I fail to see where we could actually trigger an overflow. The reported
>> warning looked like a false positive to me.
>>
>>>
>>> It ripples through UAPI which is an ABI change, but it's not too late to
>>> make it, and it will allow supporting >4Gbyte blocks while might
>>> become necessary down the road.
>>>
>>
>> This might break cloud-hypervisor, who's already implementing this
>> protocol upstream (ccing Hui).
>> https://github.com/cloud-hypervisor/cloud-hypervisor/blob/master/vm-virtio/src/mem.rs
>>
>> (blocks in the gigabyte range were never the original intention of
>> virtio-mem, but I am not completely opposed to that)
> 
> If you think virtio_mem need this patch, I think cloud-hypervisor should follow this update (I will post PR for it).

Thanks Hui. So we can still do last-minute changes if we all agree it
makes sense.

@MST can you rephrase the patch description to highlight that this is a
preparation for the future only and not actually currently broken?
"virtio-mem: convert device block size into 64bit" ...

With that

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb
