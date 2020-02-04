From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 5/5] vdpasim: vDPA device simulator
Date: Tue, 4 Feb 2020 16:28:27 +0800
Message-ID: <cca7901b-51dd-4f4b-5c30-c42577ad5194@redhat.com>
References: <20200116124231.20253-1-jasowang@redhat.com>
 <20200116124231.20253-6-jasowang@redhat.com>
 <1b86d188-0666-f6ab-e3b3-bec1cfbd0c76@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1b86d188-0666-f6ab-e3b3-bec1cfbd0c76@linux.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Zhu Lingshan <lingshan.zhu@linux.intel.com>, mst@redhat.com, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Cc: tiwei.bie@intel.com, jgg@mellanox.com, maxime.coquelin@redhat.com, cunming.liang@intel.com, zhihong.wang@intel.com, rob.miller@broadcom.com, xiao.w.wang@intel.com, haotian.wang@sifive.com, lingshan.zhu@intel.com, eperezma@redhat.com, lulu@redhat.com, parav@mellanox.com, kevin.tian@intel.com, stefanha@redhat.com, rdunlap@infradead.org, hch@infradead.org, aadam@redhat.com, jakub.kicinski@netronome.com, jiri@mellanox.com, shahafs@mellanox.com, hanand@xilinx.com, mhabets@solarflare.com
List-Id: virtualization@lists.linuxfoundation.org


On 2020/2/4 =E4=B8=8B=E5=8D=884:21, Zhu Lingshan wrote:
>> +static const struct dma_map_ops vdpasim_dma_ops =3D {
>> +=C2=A0=C2=A0=C2=A0 .map_page =3D vdpasim_map_page,
>> +=C2=A0=C2=A0=C2=A0 .unmap_page =3D vdpasim_unmap_page,
>> +=C2=A0=C2=A0=C2=A0 .alloc =3D vdpasim_alloc_coherent,
>> +=C2=A0=C2=A0=C2=A0 .free =3D vdpasim_free_coherent,
>> +};
>> +
>
> Hey Jason,
>
> IMHO, it would be nice if dma_ops of the parent device could be=20
> re-used. vdpa_device is expecting to represent a physical device=20
> except this simulator, however, there are not enough information in=20
> vdpa_device.dev to indicating which kind physical device it attached=20
> to. Namely get_arch_dma_ops(struct bus type) can not work on=20
> vdpa_device.dev. Then it seems device drivers need to implement a wrap=20
> of dma_ops of parent devices. Can this work be done in the vdpa=20
> framework since it looks like a common task? Can=20
> "vd_dev->vdev.dev.parent =3D vdpa->dev->parent;" in virtio_vdpa_probe()=
=20
> do the work?
>
> Thanks,
> BR
> Zhu Lingshan=20


Good catch.

I think we can.

Thanks
