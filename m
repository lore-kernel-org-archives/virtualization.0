From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V9 8/9] vdpasim: vDPA device simulator
Date: Fri, 10 Apr 2020 16:23:38 +0800
Message-ID: <108f65dd-f1b1-54ec-ae26-49842f3686b6@redhat.com>
References: <20200326140125.19794-1-jasowang@redhat.com>
 <20200326140125.19794-9-jasowang@redhat.com>
 <CAMuHMdUis3O_mJKOb2s=_=Zs61iHus5Aq74N3-xs7kmjN+egoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdUis3O_mJKOb2s=_=Zs61iHus5Aq74N3-xs7kmjN+egoQ@mail.gmail.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, KVM list <kvm@vger.kernel.org>, virtualization@lists.linux-foundation.org, netdev <netdev@vger.kernel.org>, Jason Gunthorpe <jgg@mellanox.com>, maxime.coquelin@redhat.com, cunming.liang@intel.com, zhihong.wang@intel.com, rob.miller@broadcom.com, xiao.w.wang@intel.com, lingshan.zhu@intel.com, eperezma@redhat.com, lulu@redhat.com, parav@mellanox.com, kevin.tian@intel.com, stefanha@redhat.com, Randy Dunlap <rdunlap@infradead.org>, Christoph Hellwig <hch@infradead.org>, aadam@redhat.com, Jiri Pirko <jiri@mellanox.com>, shahafs@mellanox.com, hanand@xilinx.com, Martin Habets <mhabets@solarflare.com>, gdawar@xilinx.com, saugatm@xilinx.com, vmireyno@marvell.com, zhangweining@rui
List-Id: virtualization@lists.linuxfoundation.org


On 2020/4/10 =E4=B8=8B=E5=8D=883:45, Geert Uytterhoeven wrote:
> Hi Jason,
>
> On Thu, Mar 26, 2020 at 3:07 PM Jason Wang <jasowang@redhat.com> wrote:
>> This patch implements a software vDPA networking device. The datapath
>> is implemented through vringh and workqueue. The device has an on-chip
>> IOMMU which translates IOVA to PA. For kernel virtio drivers, vDPA
>> simulator driver provides dma_ops. For vhost driers, set_map() methods
>> of vdpa_config_ops is implemented to accept mappings from vhost.
>>
>> Currently, vDPA device simulator will loopback TX traffic to RX. So
>> the main use case for the device is vDPA feature testing, prototyping
>> and development.
>>
>> Note, there's no management API implemented, a vDPA device will be
>> registered once the module is probed. We need to handle this in the
>> future development.
>>
>> Signed-off-by: Jason Wang <jasowang@redhat.com>
> This is now commit 2c53d0f64c06f458 ("vdpasim: vDPA device simulator").
>
>> --- a/drivers/virtio/vdpa/Kconfig
>> +++ b/drivers/virtio/vdpa/Kconfig
>> @@ -5,3 +5,22 @@ config VDPA
>>            Enable this module to support vDPA device that uses a
>>            datapath which complies with virtio specifications with
>>            vendor specific control path.
>> +
>> +menuconfig VDPA_MENU
>> +       bool "VDPA drivers"
>> +       default n
>      *
>      * VDPA drivers
>      *
>      VDPA drivers (VDPA_MENU) [N/y/?] (NEW) ?
>
>      There is no help available for this option.
>      Symbol: VDPA_MENU [=3Dn]
>      Type  : bool
>      Defined at drivers/vdpa/Kconfig:9
>       Prompt: VDPA drivers
>       Location:
>         -> Device Drivers
>
> I think this deserves a help text, so users know if they want to enable=
 this
> option or not.


Will add a help text for this.


>
> I had a quick look, but couldn't find the meaning of "vdpa" in the whol=
e kernel
> source tree.


The meaning was explained in the commit log of=20
961e9c84077f6c8579d7a628cbe94a675cb67ae4 and help text for CONFIG_VDPA.

Thanks


>
> Thanks!
>
>> +
>> +if VDPA_MENU
>> +
>> +config VDPA_SIM
>> +       tristate "vDPA device simulator"
>> +       depends on RUNTIME_TESTING_MENU
>> +       select VDPA
>> +       select VHOST_RING
>> +       default n
>> +       help
>> +         vDPA networking device simulator which loop TX traffic back
>> +         to RX. This device is used for testing, prototyping and
>> +         development of vDPA.
>> +
>> +endif # VDPA_MENU
> Gr{oetje,eeting}s,
>
>                          Geert
>
