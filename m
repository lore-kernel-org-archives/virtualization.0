From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V2 5/5] vdpasim: vDPA device simulator
Date: Wed, 12 Feb 2020 16:27:16 +0800
Message-ID: <3dbadf4e-c4c5-22cc-f970-f25fa42c13d8@redhat.com>
References: <20200210035608.10002-1-jasowang@redhat.com>
 <20200210035608.10002-6-jasowang@redhat.com>
 <20200211135254.GJ4271@mellanox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200211135254.GJ4271@mellanox.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jason Gunthorpe <jgg@mellanox.com>
Cc: mst@redhat.com, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, tiwei.bie@intel.com, maxime.coquelin@redhat.com, cunming.liang@intel.com, zhihong.wang@intel.com, rob.miller@broadcom.com, xiao.w.wang@intel.com, haotian.wang@sifive.com, lingshan.zhu@intel.com, eperezma@redhat.com, lulu@redhat.com, parav@mellanox.com, kevin.tian@intel.com, stefanha@redhat.com, rdunlap@infradead.org, hch@infradead.org, aadam@redhat.com, jiri@mellanox.com, shahafs@mellanox.com, hanand@xilinx.com, mhabets@solarflare.com
List-Id: virtualization@lists.linuxfoundation.org


On 2020/2/11 =E4=B8=8B=E5=8D=889:52, Jason Gunthorpe wrote:
> On Mon, Feb 10, 2020 at 11:56:08AM +0800, Jason Wang wrote:
>> +
>> +static struct vdpasim *vdpasim_create(void)
>> +{
>> +	struct vdpasim *vdpasim;
>> +	struct virtio_net_config *config;
>> +	struct vdpa_device *vdpa;
>> +	struct device *dev;
>> +	int ret =3D -ENOMEM;
>> +
>> +	vdpasim =3D kzalloc(sizeof(*vdpasim), GFP_KERNEL);
>> +	if (!vdpasim)
>> +		goto err_vdpa_alloc;
>> +
>> +	vdpasim->buffer =3D kmalloc(PAGE_SIZE, GFP_KERNEL);
>> +	if (!vdpasim->buffer)
>> +		goto err_buffer_alloc;
>> +
>> +	vdpasim->iommu =3D vhost_iotlb_alloc(2048, 0);
>> +	if (!vdpasim->iommu)
>> +		goto err_iotlb;
>> +
>> +	config =3D &vdpasim->config;
>> +	config->mtu =3D 1500;
>> +	config->status =3D VIRTIO_NET_S_LINK_UP;
>> +	eth_random_addr(config->mac);
>> +
>> +	INIT_WORK(&vdpasim->work, vdpasim_work);
>> +	spin_lock_init(&vdpasim->lock);
>> +
>> +	vdpa =3D &vdpasim->vdpa;
>> +	vdpa->dev.release =3D vdpasim_release_dev;
> The driver should not provide the release function.
>
> Again the safest model is 'vdpa_alloc_device' which combines the
> kzalloc and the vdpa_init_device() and returns something that is
> error unwound with put_device()
>
> The subsystem owns the release and does the kfree and other cleanup
> like releasing the IDA.


So I think if we agree bus instead of class is used. vDPA bus can=20
provide a release function in vdpa_alloc_device()?


>
>> +	vringh_set_iotlb(&vdpasim->vqs[0].vring, vdpasim->iommu);
>> +	vringh_set_iotlb(&vdpasim->vqs[1].vring, vdpasim->iommu);
>> +
>> +	dev =3D &vdpa->dev;
>> +	dev->coherent_dma_mask =3D DMA_BIT_MASK(64);
>> +	set_dma_ops(dev, &vdpasim_dma_ops);
>> +
>> +	ret =3D vdpa_init_device(vdpa, &vdpasim_dev->dev, dev,
>> +			       &vdpasim_net_config_ops);
>> +	if (ret)
>> +		goto err_init;
>> +
>> +	ret =3D vdpa_register_device(vdpa);
>> +	if (ret)
>> +		goto err_register;
> See? This error unwind is now all wrong:
>
>> +
>> +	return vdpasim;
>> +
>> +err_register:
>> +	put_device(&vdpa->dev);
> Double put_device


Yes.


>
>> +err_init:
>> +	vhost_iotlb_free(vdpasim->iommu);
>> +err_iotlb:
>> +	kfree(vdpasim->buffer);
>> +err_buffer_alloc:
>> +	kfree(vdpasim);
> kfree after vdpa_init_device() is incorrect, as the put_device now
> does kfree via release


Ok, will fix.


>
>> +static int __init vdpasim_dev_init(void)
>> +{
>> +	struct device *dev;
>> +	int ret =3D 0;
>> +
>> +	vdpasim_dev =3D kzalloc(sizeof(*vdpasim_dev), GFP_KERNEL);
>> +	if (!vdpasim_dev)
>> +		return -ENOMEM;
>> +
>> +	dev =3D &vdpasim_dev->dev;
>> +	dev->release =3D vdpasim_device_release;
>> +	dev_set_name(dev, "%s", VDPASIM_NAME);
>> +
>> +	ret =3D device_register(&vdpasim_dev->dev);
>> +	if (ret)
>> +		goto err_register;
>> +
>> +	if (!vdpasim_create())
>> +		goto err_register;
> Wrong error unwind here too


Will fix.

Thanks


>
>> +	return 0;
>> +
>> +err_register:
>> +	kfree(vdpasim_dev);
>> +	vdpasim_dev =3D NULL;
>> +	return ret;
>> +}
> Jason
>
