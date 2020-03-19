From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V6 8/8] virtio: Intel IFC VF driver for VDPA
Date: Thu, 19 Mar 2020 16:14:37 +0800
Message-ID: <30359bae-d66a-0311-0028-d7d33b8295f2@redhat.com>
References: <20200318080327.21958-1-jasowang@redhat.com>
 <20200318080327.21958-9-jasowang@redhat.com>
 <20200318122255.GG13183@mellanox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200318122255.GG13183@mellanox.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jason Gunthorpe <jgg@mellanox.com>
Cc: mst@redhat.com, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, maxime.coquelin@redhat.com, cunming.liang@intel.com, zhihong.wang@intel.com, rob.miller@broadcom.com, xiao.w.wang@intel.com, lingshan.zhu@intel.com, eperezma@redhat.com, lulu@redhat.com, parav@mellanox.com, kevin.tian@intel.com, stefanha@redhat.com, rdunlap@infradead.org, hch@infradead.org, aadam@redhat.com, jiri@mellanox.com, shahafs@mellanox.com, hanand@xilinx.com, mhabets@solarflare.com, gdawar@xilinx.com, saugatm@xilinx.com, vmireyno@marvell.com, Bie Tiwei <tiwei.bie@intel.com>
List-Id: virtualization@lists.linuxfoundation.org


On 2020/3/18 =E4=B8=8B=E5=8D=888:22, Jason Gunthorpe wrote:
> On Wed, Mar 18, 2020 at 04:03:27PM +0800, Jason Wang wrote:
>> From: Zhu Lingshan <lingshan.zhu@intel.com>
>> +
>> +static int ifcvf_vdpa_attach(struct ifcvf_adapter *adapter)
>> +{
>> +	int ret;
>> +
>> +	adapter->vdpa_dev  =3D vdpa_alloc_device(adapter->dev, adapter->dev,
>> +					       &ifc_vdpa_ops);
>> +	if (IS_ERR(adapter->vdpa_dev)) {
>> +		IFCVF_ERR(adapter->dev, "Failed to init ifcvf on vdpa bus");
>> +		put_device(&adapter->vdpa_dev->dev);
>> +		return -ENODEV;
>> +	}
> The point of having an alloc call is so that the drivers
> ifcvf_adaptor memory could be placed in the same struct - eg use
> container_of to flip between them, and have a kref for both memories.
>
> It seem really weird to have an alloc followed immediately by
> register.


I admit the ifcvf_adapter is not correctly ref-counted. What you suggest=20
should work. But it looks to me the following is more cleaner since the=20
members of ifcvf_adapter are all related to PCI device not vDPA itself.

- keep the current layout of ifcvf_adapter
- merge vdpa_alloc_device() and vdpa_register_device()
- use devres to bind ifcvf_adapter refcnt/lifcycle to the under PCI devic=
e

If we go for the container_of method, we probably need

- accept a size of parent parent structure in vdpa_alloc_device() and=20
mandate vdpa_device to be the first member of ifcvf_adapter
- we need provide a way to free resources of parent structure when we=20
destroy vDPA device

What's your thought?


>> diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa=
.c
>> index c30eb55030be..de64b88ee7e4 100644
>> +++ b/drivers/virtio/virtio_vdpa.c
>> @@ -362,6 +362,7 @@ static int virtio_vdpa_probe(struct vdpa_device *v=
dpa)
>>   		goto err;
>>  =20
>>   	vdpa_set_drvdata(vdpa, vd_dev);
>> +	dev_info(vd_dev->vdev.dev.parent, "device attached to VDPA bus\n");
>>  =20
>>   	return 0;
> This hunk seems out of place
>
> Jason


Right, will fix.

Thanks
