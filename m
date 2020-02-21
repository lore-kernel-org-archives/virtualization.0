From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V4 4/5] virtio: introduce a vDPA based transport
Date: Fri, 21 Feb 2020 16:06:24 +0800
Message-ID: <d6d910bb-8431-7e95-8808-9ed2d6ec9211@redhat.com>
References: <20200220061141.29390-1-jasowang@redhat.com>
 <20200220061141.29390-5-jasowang@redhat.com>
 <20200220151914.GW23930@mellanox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20200220151914.GW23930@mellanox.com>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: Jason Gunthorpe <jgg@mellanox.com>
Cc: "mst@redhat.com" <mst@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "tiwei.bie@intel.com" <tiwei.bie@intel.com>, "maxime.coquelin@redhat.com" <maxime.coquelin@redhat.com>, "cunming.liang@intel.com" <cunming.liang@intel.com>, "zhihong.wang@intel.com" <zhihong.wang@intel.com>, "rob.miller@broadcom.com" <rob.miller@broadcom.com>, "xiao.w.wang@intel.com" <xiao.w.wang@intel.com>, "haotian.wang@sifive.com" <haotian.wang@sifive.com>, "lingshan.zhu@intel.com" <lingshan.zhu@intel.com>, "eperezma@redhat.com" <eperezma@redhat.com>, "lulu@redhat.com" <lulu@redhat.co>
List-Id: virtualization@lists.linuxfoundation.org


On 2020/2/20 =E4=B8=8B=E5=8D=8811:19, Jason Gunthorpe wrote:
> On Thu, Feb 20, 2020 at 02:11:40PM +0800, Jason Wang wrote:
>> +static int virtio_vdpa_probe(struct vdpa_device *vdpa)
>> +{
>> +	const struct vdpa_config_ops *ops =3D vdpa->config;
>> +	struct virtio_vdpa_device *vd_dev;
>> +	int ret =3D -EINVAL;
>> +
>> +	vd_dev =3D kzalloc(sizeof(*vd_dev), GFP_KERNEL);
>> +	if (!vd_dev)
>> +		return -ENOMEM;
>> +
>> +	vd_dev->vdev.dev.parent =3D vdpa_get_dma_dev(vdpa);
>> +	vd_dev->vdev.dev.release =3D virtio_vdpa_release_dev;
>> +	vd_dev->vdev.config =3D &virtio_vdpa_config_ops;
>> +	vd_dev->vdpa =3D vdpa;
>> +	INIT_LIST_HEAD(&vd_dev->virtqueues);
>> +	spin_lock_init(&vd_dev->lock);
>> +
>> +	vd_dev->vdev.id.device =3D ops->get_device_id(vdpa);
>> +	if (vd_dev->vdev.id.device =3D=3D 0)
>> +		goto err;
>> +
>> +	vd_dev->vdev.id.vendor =3D ops->get_vendor_id(vdpa);
>> +	ret =3D register_virtio_device(&vd_dev->vdev);
>> +	if (ret)
>> +		goto err;
> This error unwind is wrong. register_virtio_device() does
> device_initialize() as it's first action. After that point error
> unwind must be done with put_device() - particularly calling
> kfree(vd_dev) after doing dev_set_name() leaks memory.


Exactly.


>
> Looks like about half of the register_virtio_device() users did this
> right, the others not. Perhaps you should fix them too...
>
> Jason


Will do.

Thanks


>
