From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 5/5] vdpasim: vDPA device simulator
Date: Wed, 5 Feb 2020 11:14:04 +0800
Message-ID: <920de1cf-a4ee-2d02-a30b-741bfed18ffb@redhat.com>
References: <20200116124231.20253-1-jasowang@redhat.com>
 <20200116124231.20253-6-jasowang@redhat.com>
 <1b86d188-0666-f6ab-e3b3-bec1cfbd0c76@linux.intel.com>
 <cca7901b-51dd-4f4b-5c30-c42577ad5194@redhat.com>
 <20200204125204.GS23346@mellanox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20200204125204.GS23346@mellanox.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
To: Jason Gunthorpe <jgg@mellanox.com>
Cc: Zhu Lingshan <lingshan.zhu@linux.intel.com>, mst@redhat.com, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, tiwei.bie@intel.com, maxime.coquelin@redhat.com, cunming.liang@intel.com, zhihong.wang@intel.com, rob.miller@broadcom.com, xiao.w.wang@intel.com, haotian.wang@sifive.com, lingshan.zhu@intel.com, eperezma@redhat.com, lulu@redhat.com, parav@mellanox.com, kevin.tian@intel.com, stefanha@redhat.com, rdunlap@infradead.org, hch@infradead.org, aadam@redhat.com, jakub.kicinski@netronome.com, jiri@mellanox.com, shahafs@mellanox.com, hanand@xilinx.com, mhabets@solarflare.com
List-Id: virtualization@lists.linuxfoundation.org


On 2020/2/4 =E4=B8=8B=E5=8D=888:52, Jason Gunthorpe wrote:
> On Tue, Feb 04, 2020 at 04:28:27PM +0800, Jason Wang wrote:
>> On 2020/2/4 =E4=B8=8B=E5=8D=884:21, Zhu Lingshan wrote:
>>>> +static const struct dma_map_ops vdpasim_dma_ops =3D {
>>>> +=C2=A0=C2=A0=C2=A0 .map_page =3D vdpasim_map_page,
>>>> +=C2=A0=C2=A0=C2=A0 .unmap_page =3D vdpasim_unmap_page,
>>>> +=C2=A0=C2=A0=C2=A0 .alloc =3D vdpasim_alloc_coherent,
>>>> +=C2=A0=C2=A0=C2=A0 .free =3D vdpasim_free_coherent,
>>>> +};
>>>> +
>>> Hey Jason,
>>>
>>> IMHO, it would be nice if dma_ops of the parent device could be re-us=
ed.
>>> vdpa_device is expecting to represent a physical device except this
>>> simulator, however, there are not enough information in vdpa_device.d=
ev
>>> to indicating which kind physical device it attached to. Namely
>>> get_arch_dma_ops(struct bus type) can not work on vdpa_device.dev. Th=
en
>>> it seems device drivers need to implement a wrap of dma_ops of parent
>>> devices. Can this work be done in the vdpa framework since it looks l=
ike
>>> a common task? Can "vd_dev->vdev.dev.parent =3D vdpa->dev->parent;" i=
n
>>> virtio_vdpa_probe() do the work?
>>>
>>> Thanks,
>>> BR
>>> Zhu Lingshan
>>
>> Good catch.
>>
>> I think we can.
> IMHO you need to specify some 'dma_device', not try and play tricks
> with dma_ops, or assuming the parent is always the device used for
> dma.
>
> Jason


Right, this is what in my mind and discussed in the vhost-vdpa thread.

Will go this way.

Thanks
