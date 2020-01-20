From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 5/5] vdpasim: vDPA device simulator
Date: Mon, 20 Jan 2020 16:01:10 +0800
Message-ID: <cd5477b1-7e41-aeeb-c592-09b2ec81566a@redhat.com>
References: <20200116124231.20253-1-jasowang@redhat.com>
 <20200116124231.20253-6-jasowang@redhat.com>
 <20200116154658.GJ20978@mellanox.com>
 <aea2bff8-82c8-2c0f-19ee-e86db73e199f@redhat.com>
 <20200117141021.GW20978@mellanox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200117141021.GW20978@mellanox.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jason Gunthorpe <jgg@mellanox.com>
Cc: "mst@redhat.com" <mst@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "tiwei.bie@intel.com" <tiwei.bie@intel.com>, "maxime.coquelin@redhat.com" <maxime.coquelin@redhat.com>, "cunming.liang@intel.com" <cunming.liang@intel.com>, "zhihong.wang@intel.com" <zhihong.wang@intel.com>, "rob.miller@broadcom.com" <rob.miller@broadcom.com>, "xiao.w.wang@intel.com" <xiao.w.wang@intel.com>, "haotian.wang@sifive.com" <haotian.wang@sifive.com>, "lingshan.zhu@intel.com" <lingshan.zhu@intel.com>, "eperezma@redhat.com" <eperezma@redhat.com>, "lulu@redhat.com" <lulu@redhat.co>
List-Id: virtualization@lists.linuxfoundation.org


On 2020/1/17 =E4=B8=8B=E5=8D=8810:10, Jason Gunthorpe wrote:
> On Fri, Jan 17, 2020 at 05:32:39PM +0800, Jason Wang wrote:
>> On 2020/1/16 =E4=B8=8B=E5=8D=8811:47, Jason Gunthorpe wrote:
>>> On Thu, Jan 16, 2020 at 08:42:31PM +0800, Jason Wang wrote:
>>>> This patch implements a software vDPA networking device. The datapat=
h
>>>> is implemented through vringh and workqueue. The device has an on-ch=
ip
>>>> IOMMU which translates IOVA to PA. For kernel virtio drivers, vDPA
>>>> simulator driver provides dma_ops. For vhost driers, set_map() metho=
ds
>>>> of vdpa_config_ops is implemented to accept mappings from vhost.
>>>>
>>>> A sysfs based management interface is implemented, devices are
>>>> created and removed through:
>>>>
>>>> /sys/devices/virtual/vdpa_simulator/netdev/{create|remove}
>>> This is very gross, creating a class just to get a create/remove and
>>> then not using the class for anything else? Yuk.
>>
>> It includes more information, e.g the devices and the link from vdpa_s=
im
>> device and vdpa device.
> I feel like regardless of how the device is created there should be a
> consistent virtio centric management for post-creation tasks, such as
> introspection and destruction


Right, actually, this is something that could be done by sysfs as well.=20
Having an intermediate steps as "activate" and introducing attributes=20
for post-creation tasks.


>
> A virto struct device should already have back pointers to it's parent
> device, which should be enough to discover the vdpa_sim, none of the
> extra sysfs munging should be needed.
>
>>>> Netlink based lifecycle management could be implemented for vDPA
>>>> simulator as well.
>>> This is just begging for a netlink based approach.
>>>
>>> Certainly netlink driven removal should be an agreeable standard for
>>> all devices, I think.
>>
>> Well, I think Parav had some proposals during the discussion of mdev
>> approach. But I'm not sure if he had any RFC codes for me to integrate=
 it
>> into vdpasim.
>>
>> Or do you want me to propose the netlink API? If yes, would you prefer=
 to a
>> new virtio dedicated one or be a subset of devlink?
> Well, lets see what feed back Parav has
>
> Jason


Ok.

Thanks
