From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 3/5] vDPA: introduce vDPA bus
Date: Fri, 17 Jan 2020 11:03:12 +0800
Message-ID: <03cfbcc2-fef0-c9d8-0b08-798b2a293b8c@redhat.com>
References: <20200116124231.20253-1-jasowang@redhat.com>
 <20200116124231.20253-4-jasowang@redhat.com>
 <20200116152209.GH20978@mellanox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200116152209.GH20978@mellanox.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jason Gunthorpe <jgg@mellanox.com>
Cc: "mst@redhat.com" <mst@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "tiwei.bie@intel.com" <tiwei.bie@intel.com>, "maxime.coquelin@redhat.com" <maxime.coquelin@redhat.com>, "cunming.liang@intel.com" <cunming.liang@intel.com>, "zhihong.wang@intel.com" <zhihong.wang@intel.com>, "rob.miller@broadcom.com" <rob.miller@broadcom.com>, "xiao.w.wang@intel.com" <xiao.w.wang@intel.com>, "haotian.wang@sifive.com" <haotian.wang@sifive.com>, "lingshan.zhu@intel.com" <lingshan.zhu@intel.com>, "eperezma@redhat.com" <eperezma@redhat.com>, "lulu@redhat.com" <lulu@redhat.co>
List-Id: virtualization@lists.linuxfoundation.org


On 2020/1/16 =E4=B8=8B=E5=8D=8811:22, Jason Gunthorpe wrote:
> On Thu, Jan 16, 2020 at 08:42:29PM +0800, Jason Wang wrote:
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
>> - VDEV (Virtual Device) - With technologies such as Intel Scalable
>>    IOV, a virtual device composed by host OS utilizing one or more
>>    ADIs.
>> - SF (Sub function) - Vendor specific interface to slice the Physical
>>    Function to multiple sub functions that can be assigned to differen=
t
>>    partitions as virtual devices.
> I really hope we don't end up with two different ways to spell this
> same thing.


I think you meant ADI vs SF. It looks to me that ADI is limited to the=20
scope of scalable IOV but SF not.


>
>> @@ -0,0 +1,2 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +obj-$(CONFIG_VDPA) +=3D vdpa.o
>> diff --git a/drivers/virtio/vdpa/vdpa.c b/drivers/virtio/vdpa/vdpa.c
>> new file mode 100644
>> index 000000000000..2b0e4a9f105d
>> +++ b/drivers/virtio/vdpa/vdpa.c
>> @@ -0,0 +1,141 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * vDPA bus.
>> + *
>> + * Copyright (c) 2019, Red Hat. All rights reserved.
>> + *     Author: Jason Wang <jasowang@redhat.com>
> 2020 tests days


Will fix.


>
>> + *
>> + */
>> +
>> +#include <linux/module.h>
>> +#include <linux/idr.h>
>> +#include <linux/vdpa.h>
>> +
>> +#define MOD_VERSION  "0.1"
> I think module versions are discouraged these days


Will remove.


>
>> +#define MOD_DESC     "vDPA bus"
>> +#define MOD_AUTHOR   "Jason Wang <jasowang@redhat.com>"
>> +#define MOD_LICENSE  "GPL v2"
>> +
>> +static DEFINE_IDA(vdpa_index_ida);
>> +
>> +struct device *vdpa_get_parent(struct vdpa_device *vdpa)
>> +{
>> +	return vdpa->dev.parent;
>> +}
>> +EXPORT_SYMBOL(vdpa_get_parent);
>> +
>> +void vdpa_set_parent(struct vdpa_device *vdpa, struct device *parent)
>> +{
>> +	vdpa->dev.parent =3D parent;
>> +}
>> +EXPORT_SYMBOL(vdpa_set_parent);
>> +
>> +struct vdpa_device *dev_to_vdpa(struct device *_dev)
>> +{
>> +	return container_of(_dev, struct vdpa_device, dev);
>> +}
>> +EXPORT_SYMBOL_GPL(dev_to_vdpa);
>> +
>> +struct device *vdpa_to_dev(struct vdpa_device *vdpa)
>> +{
>> +	return &vdpa->dev;
>> +}
>> +EXPORT_SYMBOL_GPL(vdpa_to_dev);
> Why these trivial assessors? Seems unnecessary, or should at least be
> static inlines in a header


Will fix.


>
>> +int register_vdpa_device(struct vdpa_device *vdpa)
>> +{
> Usually we want to see symbols consistently prefixed with vdpa_*, is
> there a reason why register/unregister are swapped?


I follow the name from virtio. I will switch to vdpa_*.


>
>> +	int err;
>> +
>> +	if (!vdpa_get_parent(vdpa))
>> +		return -EINVAL;
>> +
>> +	if (!vdpa->config)
>> +		return -EINVAL;
>> +
>> +	err =3D ida_simple_get(&vdpa_index_ida, 0, 0, GFP_KERNEL);
>> +	if (err < 0)
>> +		return -EFAULT;
>> +
>> +	vdpa->dev.bus =3D &vdpa_bus;
>> +	device_initialize(&vdpa->dev);
> IMHO device_initialize should not be called inside something called
> register, toooften we find out that the caller drivers need the device
> to be initialized earlier, ie to use the kref, or something.
>
> I find the best flow is to have some init function that does the
> device_initialize and sets the device_name that the driver can call
> early.


Ok, will do.


>
> Shouldn't there be a device/driver matching process of some kind?


The question is what do we want do match here.

1) "virtio" vs "vhost", I implemented matching method for this in mdev=20
series, but it looks unnecessary for vDPA device driver to know about=20
this. Anyway we can use sysfs driver bind/unbind to switch drivers
2) virtio device id and vendor id. I'm not sure we need this consider=20
the two drivers so far (virtio/vhost) are all bus drivers.

Thanks


>
> Jason
>
