From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V2 5/5] vdpasim: vDPA device simulator
Date: Tue, 11 Feb 2020 11:12:19 +0800
Message-ID: <d738e251-d03b-c2a0-bf0a-045ea0b1871c@redhat.com>
References: <20200210035608.10002-1-jasowang@redhat.com>
 <20200210035608.10002-6-jasowang@redhat.com>
 <20200210062219-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20200210062219-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, tiwei.bie@intel.com, jgg@mellanox.com, maxime.coquelin@redhat.com, cunming.liang@intel.com, zhihong.wang@intel.com, rob.miller@broadcom.com, xiao.w.wang@intel.com, haotian.wang@sifive.com, lingshan.zhu@intel.com, eperezma@redhat.com, lulu@redhat.com, parav@mellanox.com, kevin.tian@intel.com, stefanha@redhat.com, rdunlap@infradead.org, hch@infradead.org, aadam@redhat.com, jiri@mellanox.com, shahafs@mellanox.com, hanand@xilinx.com, mhabets@solarflare.com
List-Id: virtualization@lists.linuxfoundation.org


On 2020/2/10 =E4=B8=8B=E5=8D=887:23, Michael S. Tsirkin wrote:
> On Mon, Feb 10, 2020 at 11:56:08AM +0800, Jason Wang wrote:
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
>> Signed-off-by: Jason Wang<jasowang@redhat.com>
>> ---
>>   drivers/virtio/vdpa/Kconfig    |  17 +
>>   drivers/virtio/vdpa/Makefile   |   1 +
>>   drivers/virtio/vdpa/vdpa_sim.c | 678 +++++++++++++++++++++++++++++++=
++
>>   3 files changed, 696 insertions(+)
>>   create mode 100644 drivers/virtio/vdpa/vdpa_sim.c
>>
>> diff --git a/drivers/virtio/vdpa/Kconfig b/drivers/virtio/vdpa/Kconfig
>> index 7a99170e6c30..a7888974dda8 100644
>> --- a/drivers/virtio/vdpa/Kconfig
>> +++ b/drivers/virtio/vdpa/Kconfig
>> @@ -7,3 +7,20 @@ config VDPA
>>             datapath which complies with virtio specifications with
>>             vendor specific control path.
>>  =20
>> +menuconfig VDPA_MENU
>> +	bool "VDPA drivers"
>> +	default n
>> +
>> +if VDPA_MENU
>> +
>> +config VDPA_SIM
>> +	tristate "vDPA device simulator"
>> +        select VDPA
>> +        default n
>> +        help
>> +          vDPA networking device simulator which loop TX traffic back
>> +          to RX. This device is used for testing, prototyping and
>> +          development of vDPA.
> So how about we make this depend on RUNTIME_TESTING_MENU?
>
>

I'm not sure how much it can help but I can do that in next version.

Thanks

RUNTIME_TESTING_MENU
