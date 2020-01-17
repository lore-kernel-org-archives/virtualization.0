From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 5/5] vdpasim: vDPA device simulator
Date: Fri, 17 Jan 2020 17:35:00 +0800
Message-ID: <8d6ef81e-b42a-9a89-0857-f2732526a1af@redhat.com>
References: <20200116124231.20253-1-jasowang@redhat.com>
 <20200116124231.20253-6-jasowang@redhat.com>
 <55d84df0-803a-a81f-b49f-2d6fe8f78b96@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <55d84df0-803a-a81f-b49f-2d6fe8f78b96@infradead.org>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
To: Randy Dunlap <rdunlap@infradead.org>, mst@redhat.com, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Cc: tiwei.bie@intel.com, jgg@mellanox.com, maxime.coquelin@redhat.com, cunming.liang@intel.com, zhihong.wang@intel.com, rob.miller@broadcom.com, xiao.w.wang@intel.com, haotian.wang@sifive.com, lingshan.zhu@intel.com, eperezma@redhat.com, lulu@redhat.com, parav@mellanox.com, kevin.tian@intel.com, stefanha@redhat.com, hch@infradead.org, aadam@redhat.com, jakub.kicinski@netronome.com, jiri@mellanox.com, shahafs@mellanox.com, hanand@xilinx.com, mhabets@solarflare.com
List-Id: virtualization@lists.linuxfoundation.org


On 2020/1/17 =E4=B8=8B=E5=8D=8812:12, Randy Dunlap wrote:
> On 1/16/20 4:42 AM, Jason Wang wrote:
>> diff --git a/drivers/virtio/vdpa/Kconfig b/drivers/virtio/vdpa/Kconfig
>> index 3032727b4d98..12ec25d48423 100644
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
> 	                                            loops
>
>> +          to RX. This device is used for testing, prototyping and
>> +          development of vDPA.
>> +
>> +endif # VDPA_MENU
> Most lines above use spaces for indentation, while they should use
> tab + 2 spaces.


Right, will fix.

Thanks
