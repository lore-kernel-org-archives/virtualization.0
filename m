From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] vhost: introduce vDPA based backend
Date: Thu, 6 Feb 2020 11:04:41 +0800
Message-ID: <8af7b9b1-f721-8d1c-dd1c-403424ee20b9@redhat.com>
References: <20200131033651.103534-1-tiwei.bie@intel.com>
 <7aab2892-bb19-a06a-a6d3-9c28bc4c3400@redhat.com>
 <20200205020247.GA368700@___>
 <AM0PR0502MB37952015716C1D5E07E390B6C3020@AM0PR0502MB3795.eurprd05.prod.outlook.com>
 <112858a4-1a01-f4d7-e41a-1afaaa1cad45@redhat.com>
 <AM0PR0502MB3795AD42233D69F350402A8AC3020@AM0PR0502MB3795.eurprd05.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AM0PR0502MB3795AD42233D69F350402A8AC3020@AM0PR0502MB3795.eurprd05.prod.outlook.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Shahaf Shuler <shahafs@mellanox.com>, Tiwei Bie <tiwei.bie@intel.com>
Cc: "mst@redhat.com" <mst@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Jason Gunthorpe <jgg@mellanox.com>, "rob.miller@broadcom.com" <rob.miller@broadcom.com>, "haotian.wang@sifive.com" <haotian.wang@sifive.com>, "eperezma@redhat.com" <eperezma@redhat.com>, "lulu@redhat.com" <lulu@redhat.com>, Parav Pandit <parav@mellanox.com>, "rdunlap@infradead.org" <rdunlap@infradead.org>, "hch@infradead.org" <hch@infradead.org>, Jiri Pirko <jiri@mellanox.com>, "hanand@xilinx.com" <hanand@xilinx.com>, "mhabets@solarflare.com" <mhabets@solarflare.com>ma
List-Id: virtualization@lists.linuxfoundation.org


On 2020/2/5 =E4=B8=8B=E5=8D=885:30, Shahaf Shuler wrote:
> Wednesday, February 5, 2020 9:50 AM, Jason Wang:
>> Subject: Re: [PATCH] vhost: introduce vDPA based backend
>> On 2020/2/5 =E4=B8=8B=E5=8D=883:15, Shahaf Shuler wrote:
>>> Wednesday, February 5, 2020 4:03 AM, Tiwei Bie:
>>>> Subject: Re: [PATCH] vhost: introduce vDPA based backend
>>>>
>>>> On Tue, Feb 04, 2020 at 11:30:11AM +0800, Jason Wang wrote:
>>>>> On 2020/1/31 =E4=B8=8A=E5=8D=8811:36, Tiwei Bie wrote:
>>>>>> This patch introduces a vDPA based vhost backend. This backend is
>>>>>> built on top of the same interface defined in virtio-vDPA and
>>>>>> provides a generic vhost interface for userspace to accelerate the
>>>>>> virtio devices in guest.
>>>>>>
>>>>>> This backend is implemented as a vDPA device driver on top of the
>>>>>> same ops used in virtio-vDPA. It will create char device entry
>>>>>> named vhost-vdpa/$vdpa_device_index for userspace to use.
>> Userspace
>>>>>> can use vhost ioctls on top of this char device to setup the backe=
nd.
>>>>>>
>>>>>> Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
>>> [...]
>>>
>>>>>> +static long vhost_vdpa_do_dma_mapping(struct vhost_vdpa *v) {
>>>>>> +	/* TODO: fix this */
>>>>> Before trying to do this it looks to me we need the following durin=
g
>>>>> the probe
>>>>>
>>>>> 1) if set_map() is not supported by the vDPA device probe the IOMMU
>>>>> that is supported by the vDPA device
>>>>> 2) allocate IOMMU domain
>>>>>
>>>>> And then:
>>>>>
>>>>> 3) pin pages through GUP and do proper accounting
>>>>> 4) store GPA->HPA mapping in the umem
>>>>> 5) generate diffs of memory table and using IOMMU API to setup the
>>>>> dma mapping in this method
>>>>>
>>>>> For 1), I'm not sure parent is sufficient for to doing this or need
>>>>> to introduce new API like iommu_device in mdev.
>>>> Agree. We may also need to introduce something like the iommu_device=
.
>>>>
>>> Would it be better for the map/umnap logic to happen inside each devi=
ce ?
>>> Devices that needs the IOMMU will call iommu APIs from inside the dri=
ver
>> callback.
>>
>>
>> Technically, this can work. But if it can be done by vhost-vpda it wil=
l make the
>> vDPA driver more compact and easier to be implemented.
> Need to see the layering of such proposal but am not sure.
> Vhost-vdpa is generic framework, while the DMA mapping is vendor specif=
ic.
> Maybe vhost-vdpa can have some shared code needed to operate on iommu, =
so drivers can re-use it.  to me it seems simpler than exposing a new iom=
mu device.


I think you mean on-chip IOMMU here. For shared code, I guess this only=20
thing that could be shared is the mapping (rbtree) and some helpers. Or=20
is there any other in your mind?


>>
>>> Devices that has other ways to do the DMA mapping will call the
>> proprietary APIs.
>>
>>
>> To confirm, do you prefer:
>>
>> 1) map/unmap
> It is not only that. AFAIR there also flush and invalidate calls, right=
?


unmap will accept a range so it it can do flush and invalidate.


>
>> or
>>
>> 2) pass all maps at one time?
> To me this seems more straight forward.
> It is correct that under hotplug and large number of memory segments th=
e driver will need to understand the diff (or not and just reload the new=
 configuration). However, my assumption here is that memory hotplug is he=
avy flow anyway, and the driver extra cycles will not be that visible


Yes, and vhost can provide helpers to generate the diffs.

Thanks


>
>> Thanks
>>
>>
