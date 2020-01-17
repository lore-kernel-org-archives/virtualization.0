From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 3/5] vDPA: introduce vDPA bus
Date: Fri, 17 Jan 2020 17:34:34 +0800
Message-ID: <6388c5ca-0b42-29ec-0fcd-e720651972d1@redhat.com>
References: <20200116124231.20253-1-jasowang@redhat.com>
 <20200116124231.20253-4-jasowang@redhat.com>
 <3d0951af-a854-3b4a-99e4-d501a7fa7a9c@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <3d0951af-a854-3b4a-99e4-d501a7fa7a9c@infradead.org>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: Randy Dunlap <rdunlap@infradead.org>, mst@redhat.com, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Cc: tiwei.bie@intel.com, jgg@mellanox.com, maxime.coquelin@redhat.com, cunming.liang@intel.com, zhihong.wang@intel.com, rob.miller@broadcom.com, xiao.w.wang@intel.com, haotian.wang@sifive.com, lingshan.zhu@intel.com, eperezma@redhat.com, lulu@redhat.com, parav@mellanox.com, kevin.tian@intel.com, stefanha@redhat.com, hch@infradead.org, aadam@redhat.com, jakub.kicinski@netronome.com, jiri@mellanox.com, shahafs@mellanox.com, hanand@xilinx.com, mhabets@solarflare.com
List-Id: virtualization@lists.linuxfoundation.org


On 2020/1/17 =E4=B8=8B=E5=8D=8812:16, Randy Dunlap wrote:
> On 1/16/20 4:42 AM, Jason Wang wrote:
>> diff --git a/drivers/virtio/vdpa/Kconfig b/drivers/virtio/vdpa/Kconfig
>> new file mode 100644
>> index 000000000000..3032727b4d98
>> --- /dev/null
>> +++ b/drivers/virtio/vdpa/Kconfig
>> @@ -0,0 +1,9 @@
>> +# SPDX-License-Identifier: GPL-2.0-only
>> +config VDPA
>> +	tristate
>> +        default n
>> +        help
>> +          Enable this module to support vDPA device that uses a
> 	                                        devices
>
>> +          datapath which complies with virtio specifications with
>> +          vendor specific control path.
>> +
> Use tab + 2 spaces for Kconfig indentation.


Will fix.

Thanks

>
