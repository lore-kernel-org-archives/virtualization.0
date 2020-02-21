From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V4 3/5] vDPA: introduce vDPA bus
Date: Fri, 21 Feb 2020 15:54:50 +0800
Message-ID: <5d7de10a-dcce-7aa7-c033-2394718aa56b@redhat.com>
References: <20200220061141.29390-1-jasowang@redhat.com>
 <20200220061141.29390-4-jasowang@redhat.com>
 <20200220151412.GV23930@mellanox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20200220151412.GV23930@mellanox.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
To: Jason Gunthorpe <jgg@mellanox.com>
Cc: "mst@redhat.com" <mst@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "tiwei.bie@intel.com" <tiwei.bie@intel.com>, "maxime.coquelin@redhat.com" <maxime.coquelin@redhat.com>, "cunming.liang@intel.com" <cunming.liang@intel.com>, "zhihong.wang@intel.com" <zhihong.wang@intel.com>, "rob.miller@broadcom.com" <rob.miller@broadcom.com>, "xiao.w.wang@intel.com" <xiao.w.wang@intel.com>, "haotian.wang@sifive.com" <haotian.wang@sifive.com>, "lingshan.zhu@intel.com" <lingshan.zhu@intel.com>, "eperezma@redhat.com" <eperezma@redhat.com>, "lulu@redhat.com" <lulu@redhat.co>
List-Id: virtualization@lists.linuxfoundation.org


On 2020/2/20 =E4=B8=8B=E5=8D=8811:14, Jason Gunthorpe wrote:
> On Thu, Feb 20, 2020 at 02:11:39PM +0800, Jason Wang wrote:
>> vDPA device is a device that uses a datapath which complies with the
>> virtio specifications with vendor specific control path. vDPA devices
>> can be both physically located on the hardware or emulated by
>> software. vDPA hardware devices are usually implemented through PCIE
>> with the following types:
>>
>> - PF (Physical Function) - A single Physical Function
>> - VF (Virtual Function) - Device that supports single root I/O
>>    virtualization (SR-IOV). Its Virtual Function (VF) represents a
>>    virtualized instance of the device that can be assigned to differen=
t
>>    partitions
>> - ADI (Assignable Device Interface) and its equivalents - With
>>    technologies such as Intel Scalable IOV, a virtual device (VDEV)
>>    composed by host OS utilizing one or more ADIs. Or its equivalent
>>    like SF (Sub function) from Mellanox.
>>
>>  From a driver's perspective, depends on how and where the DMA
>> translation is done, vDPA devices are split into two types:
>>
>> - Platform specific DMA translation - From the driver's perspective,
>>    the device can be used on a platform where device access to data in
>>    memory is limited and/or translated. An example is a PCIE vDPA whos=
e
>>    DMA request was tagged via a bus (e.g PCIE) specific way. DMA
>>    translation and protection are done at PCIE bus IOMMU level.
>> - Device specific DMA translation - The device implements DMA
>>    isolation and protection through its own logic. An example is a vDP=
A
>>    device which uses on-chip IOMMU.
>>
>> To hide the differences and complexity of the above types for a vDPA
>> device/IOMMU options and in order to present a generic virtio device
>> to the upper layer, a device agnostic framework is required.
>>
>> This patch introduces a software vDPA bus which abstracts the
>> common attributes of vDPA device, vDPA bus driver and the
>> communication method (vdpa_config_ops) between the vDPA device
>> abstraction and the vDPA bus driver. This allows multiple types of
>> drivers to be used for vDPA device like the virtio_vdpa and vhost_vdpa
>> driver to operate on the bus and allow vDPA device could be used by
>> either kernel virtio driver or userspace vhost drivers as:
>>
>>     virtio drivers  vhost drivers
>>            |             |
>>      [virtio bus]   [vhost uAPI]
>>            |             |
>>     virtio device   vhost device
>>     virtio_vdpa drv vhost_vdpa drv
>>               \       /
>>              [vDPA bus]
>>                   |
>>              vDPA device
>>              hardware drv
>>                   |
>>              [hardware bus]
>>                   |
>>              vDPA hardware
> I still don't like this strange complexity, vhost should have been
> layered on top of the virtio device instead of adding an extra bus
> just for vdpa.


We've considered such method and I think why we choose a bus is:

- vDPA device was originally named as "vhost Datapath Acceleration"=20
which means the datapath complies virtio specification but not control=20
path. This means the device should behave like vhost. And in order to=20
support vhost, vDPA device requires more function than virtio. E.g the=20
ability to query the device state (virtqueue indices, counters etc) and=20
track dirty pages. This mean even a pure virtio hardware may not work=20
for vhost. That's why a multi inheritance is used for a new type of vDPA=20
device.

- As we've already discussed, virtio bus is designed for kernel driver=20
and a brunches of devices, drivers or even buses have been implemented=20
around that. It requires a major refactoring not only with the virtio=20
bus but also with the drivers and devices to make it behave more like a=20
vhost. Abstract vDPA as a kind of transport for virtio greatly simplify=20
the work and have almost zero impact on the exist virtio core. VOP=20
(vop_bus) use similar design.


>
> However, I don't see any technical problems with this patch now.


Thanks, your review is greatly appreciated.


>
> Thanks,
> Jason
>
