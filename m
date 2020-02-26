From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V4 5/5] vdpasim: vDPA device simulator
Date: Wed, 26 Feb 2020 14:12:26 +0800
Message-ID: <793a1b81-4f78-c405-4aae-f32a2bf67d87@redhat.com>
References: <20200220061141.29390-1-jasowang@redhat.com>
 <20200220061141.29390-6-jasowang@redhat.com>
 <20200220151215.GU23930@mellanox.com>
 <6c341a77-a297-b7c7-dea5-b3f7b920b1f3@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <6c341a77-a297-b7c7-dea5-b3f7b920b1f3@redhat.com>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: Jason Gunthorpe <jgg@mellanox.com>
Cc: "mst@redhat.com" <mst@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "tiwei.bie@intel.com" <tiwei.bie@intel.com>, "maxime.coquelin@redhat.com" <maxime.coquelin@redhat.com>, "cunming.liang@intel.com" <cunming.liang@intel.com>, "zhihong.wang@intel.com" <zhihong.wang@intel.com>, "rob.miller@broadcom.com" <rob.miller@broadcom.com>, "xiao.w.wang@intel.com" <xiao.w.wang@intel.com>, "haotian.wang@sifive.com" <haotian.wang@sifive.com>, "lingshan.zhu@intel.com" <lingshan.zhu@intel.com>, "eperezma@redhat.com" <eperezma@redhat.com>, "lulu@redhat.com" <lulu@redhat.co>
List-Id: virtualization@lists.linuxfoundation.org


On 2020/2/21 =E4=B8=8B=E5=8D=883:57, Jason Wang wrote:
>
> On 2020/2/20 =E4=B8=8B=E5=8D=8811:12, Jason Gunthorpe wrote:
>> On Thu, Feb 20, 2020 at 02:11:41PM +0800, Jason Wang wrote:
>>> +static void vdpasim_device_release(struct device *dev)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 struct vdpasim *vdpasim =3D dev_to_sim(dev);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 cancel_work_sync(&vdpasim->work);
>>> +=C2=A0=C2=A0=C2=A0 kfree(vdpasim->buffer);
>>> +=C2=A0=C2=A0=C2=A0 vhost_iotlb_free(vdpasim->iommu);
>>> +=C2=A0=C2=A0=C2=A0 kfree(vdpasim);
>>> +}
>>> +
>>> +static struct vdpasim *vdpasim_create(void)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 struct virtio_net_config *config;
>>> +=C2=A0=C2=A0=C2=A0 struct vhost_iotlb *iommu;
>>> +=C2=A0=C2=A0=C2=A0 struct vdpasim *vdpasim;
>>> +=C2=A0=C2=A0=C2=A0 struct device *dev;
>>> +=C2=A0=C2=A0=C2=A0 void *buffer;
>>> +=C2=A0=C2=A0=C2=A0 int ret =3D -ENOMEM;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 iommu =3D vhost_iotlb_alloc(2048, 0);
>>> +=C2=A0=C2=A0=C2=A0 if (!iommu)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto err;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 buffer =3D kmalloc(PAGE_SIZE, GFP_KERNEL);
>>> +=C2=A0=C2=A0=C2=A0 if (!buffer)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto err_buffer;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 vdpasim =3D kzalloc(sizeof(*vdpasim), GFP_KERNEL)=
;
>>> +=C2=A0=C2=A0=C2=A0 if (!vdpasim)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto err_alloc;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 vdpasim->buffer =3D buffer;
>>> +=C2=A0=C2=A0=C2=A0 vdpasim->iommu =3D iommu;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 config =3D &vdpasim->config;
>>> +=C2=A0=C2=A0=C2=A0 config->mtu =3D 1500;
>>> +=C2=A0=C2=A0=C2=A0 config->status =3D VIRTIO_NET_S_LINK_UP;
>>> +=C2=A0=C2=A0=C2=A0 eth_random_addr(config->mac);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 INIT_WORK(&vdpasim->work, vdpasim_work);
>>> +=C2=A0=C2=A0=C2=A0 spin_lock_init(&vdpasim->lock);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 vringh_set_iotlb(&vdpasim->vqs[0].vring, vdpasim-=
>iommu);
>>> +=C2=A0=C2=A0=C2=A0 vringh_set_iotlb(&vdpasim->vqs[1].vring, vdpasim-=
>iommu);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 dev =3D &vdpasim->dev;
>>> +=C2=A0=C2=A0=C2=A0 dev->release =3D vdpasim_device_release;
>>> +=C2=A0=C2=A0=C2=A0 dev->coherent_dma_mask =3D DMA_BIT_MASK(64);
>>> +=C2=A0=C2=A0=C2=A0 set_dma_ops(dev, &vdpasim_dma_ops);
>>> +=C2=A0=C2=A0=C2=A0 dev_set_name(dev, "%s", VDPASIM_NAME);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 ret =3D device_register(&vdpasim->dev);
>>> +=C2=A0=C2=A0=C2=A0 if (ret)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto err_init;
>> It is a bit weird to be creating this dummy parent, couldn't this be
>> done by just passing a NULL parent to vdpa_alloc_device, doing
>> set_dma_ops() on the vdpasim->vdpa->dev and setting dma_device to
>> vdpasim->vdpa->dev ?
>
>
> I think it works.


Rethink about this, since most hardware vDPA driver will have a parent=20
and will use it to find the parent structure e.g

dev_get_drvdata(vdpa->dev->parent)

So I keep this dummy parent in V5.

Thanks
