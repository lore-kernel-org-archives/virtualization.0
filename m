From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 3/5] vDPA: introduce vDPA bus
Date: Mon, 20 Jan 2020 16:19:10 +0800
Message-ID: <a4573aa4-f0d6-bb7d-763a-96352fc2c86e@redhat.com>
References: <20200116124231.20253-1-jasowang@redhat.com>
 <20200116124231.20253-4-jasowang@redhat.com>
 <20200117070324-mutt-send-email-mst@kernel.org>
 <239b042c-2d9e-0eec-a1ef-b03b7e2c5419@redhat.com>
 <CAJPjb1+fG9L3=iKbV4Vn13VwaeDZZdcfBPvarogF_Nzhk+FnKg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <CAJPjb1+fG9L3=iKbV4Vn13VwaeDZZdcfBPvarogF_Nzhk+FnKg@mail.gmail.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
To: Rob Miller <rob.miller@broadcom.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, Netdev <netdev@vger.kernel.org>, "Bie, Tiwei" <tiwei.bie@intel.com>, Jason Gunthorpe <jgg@mellanox.com>, maxime.coquelin@redhat.com, "Liang, Cunming" <cunming.liang@intel.com>, "Wang, Zhihong" <zhihong.wang@intel.com>, "Wang, Xiao W" <xiao.w.wang@intel.com>, haotian.wang@sifive.com, "Zhu, Lingshan" <lingshan.zhu@intel.com>, eperezma@redhat.com, lulu@redhat.com, Parav Pandit <parav@mellanox.com>, "Tian, Kevin" <kevin.tian@intel.com>, stefanha@redhat.com, rdunlap@infradead.org, hch@infradead.org, Ariel Adam <aadam@redhat.com>, jakub.kicinski@netronome.com, Jiri Pirko <jiri@mellanox.com>, shahafs@mellanox.com, hanand@xilinx.com, mhabets@s
List-Id: virtualization@lists.linuxfoundation.org


On 2020/1/17 =E4=B8=8B=E5=8D=8810:12, Rob Miller wrote:
>
>
>     >> + * @get_vendor_id:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Get id for=
 the vendor that
>     provides this device
>     >> + *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 @vdev: vdpa device
>     >> + *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Returns u32: virtio vendor id
>     > what's the idea behind this? userspace normally doesn't interact
>     with
>     > this ... debugging?
>
>
>     This allows some vendor specific driver on top of vDPA bus. If
>     this is
>     not interested, I can drop this.
>
> RJM>] wouldn't=C2=A0 usage of get_device_id & get_vendor_id, beyond=20
> reporting, tend to possibly leading to vendor specific code in the=20
> framework instead of leaving the framework=C2=A0agnostic and leave the=20
> vendor specific stuff to the vendor's vDPA device driver?


For virtio device id, I think it is needed for kernel/userspace to know=20
which driver to load (e.g loading virtio-net for networking devic).

For virtio vendor id, it was needed by kernel virtio driver, and virtio=20
bus can match driver based on virtio vendor id. So it doesn't prevent=20
3rd vendor specific driver for virtio device.

Maybe we can report VIRTIO_DEV_ANY_ID as vendor id to forbid vendor=20
specific stuffs.

Thanks
