From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] vhost: introduce vDPA based backend
Date: Wed, 5 Feb 2020 15:50:14 +0800
Message-ID: <112858a4-1a01-f4d7-e41a-1afaaa1cad45@redhat.com>
References: <20200131033651.103534-1-tiwei.bie@intel.com>
 <7aab2892-bb19-a06a-a6d3-9c28bc4c3400@redhat.com>
 <20200205020247.GA368700@___>
 <AM0PR0502MB37952015716C1D5E07E390B6C3020@AM0PR0502MB3795.eurprd05.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AM0PR0502MB37952015716C1D5E07E390B6C3020@AM0PR0502MB3795.eurprd05.prod.outlook.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Shahaf Shuler <shahafs@mellanox.com>, Tiwei Bie <tiwei.bie@intel.com>
Cc: "mst@redhat.com" <mst@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Jason Gunthorpe <jgg@mellanox.com>, "rob.miller@broadcom.com" <rob.miller@broadcom.com>, "haotian.wang@sifive.com" <haotian.wang@sifive.com>, "eperezma@redhat.com" <eperezma@redhat.com>, "lulu@redhat.com" <lulu@redhat.com>, Parav Pandit <parav@mellanox.com>, "rdunlap@infradead.org" <rdunlap@infradead.org>, "hch@infradead.org" <hch@infradead.org>, Jiri Pirko <jiri@mellanox.com>, "hanand@xilinx.com" <hanand@xilinx.com>, "mhabets@solarflare.com" <mhabets@solarflare.com>ma
List-Id: virtualization@lists.linuxfoundation.org


On 2020/2/5 =E4=B8=8B=E5=8D=883:15, Shahaf Shuler wrote:
> Wednesday, February 5, 2020 4:03 AM, Tiwei Bie:
>> Subject: Re: [PATCH] vhost: introduce vDPA based backend
>>
>> On Tue, Feb 04, 2020 at 11:30:11AM +0800, Jason Wang wrote:
>>> On 2020/1/31 =E4=B8=8A=E5=8D=8811:36, Tiwei Bie wrote:
>>>> This patch introduces a vDPA based vhost backend. This backend is
>>>> built on top of the same interface defined in virtio-vDPA and
>>>> provides a generic vhost interface for userspace to accelerate the
>>>> virtio devices in guest.
>>>>
>>>> This backend is implemented as a vDPA device driver on top of the
>>>> same ops used in virtio-vDPA. It will create char device entry named
>>>> vhost-vdpa/$vdpa_device_index for userspace to use. Userspace can
>>>> use vhost ioctls on top of this char device to setup the backend.
>>>>
>>>> Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
> [...]
>
>>>> +static long vhost_vdpa_do_dma_mapping(struct vhost_vdpa *v) {
>>>> +	/* TODO: fix this */
>>>
>>> Before trying to do this it looks to me we need the following during
>>> the probe
>>>
>>> 1) if set_map() is not supported by the vDPA device probe the IOMMU
>>> that is supported by the vDPA device
>>> 2) allocate IOMMU domain
>>>
>>> And then:
>>>
>>> 3) pin pages through GUP and do proper accounting
>>> 4) store GPA->HPA mapping in the umem
>>> 5) generate diffs of memory table and using IOMMU API to setup the dm=
a
>>> mapping in this method
>>>
>>> For 1), I'm not sure parent is sufficient for to doing this or need t=
o
>>> introduce new API like iommu_device in mdev.
>> Agree. We may also need to introduce something like the iommu_device.
>>
> Would it be better for the map/umnap logic to happen inside each device=
 ?
> Devices that needs the IOMMU will call iommu APIs from inside the drive=
r callback.


Technically, this can work. But if it can be done by vhost-vpda it will=20
make the vDPA driver more compact and easier to be implemented.


> Devices that has other ways to do the DMA mapping will call the proprie=
tary APIs.


To confirm, do you prefer:

1) map/unmap

or

2) pass all maps at one time?

Thanks


>
