From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V3 1/5] vhost: factor out IOTLB
Date: Thu, 20 Feb 2020 13:39:39 +0800
Message-ID: <b348cb04-3b5b-1a11-a4c5-4b05d31e88c0@redhat.com>
References: <20200220035650.7986-1-jasowang@redhat.com>
 <20200220035650.7986-2-jasowang@redhat.com>
 <61d64892-ce77-3e86-acb8-a49679fc0047@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <61d64892-ce77-3e86-acb8-a49679fc0047@infradead.org>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
To: Randy Dunlap <rdunlap@infradead.org>, mst@redhat.com, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Cc: tiwei.bie@intel.com, jgg@mellanox.com, maxime.coquelin@redhat.com, cunming.liang@intel.com, zhihong.wang@intel.com, rob.miller@broadcom.com, xiao.w.wang@intel.com, haotian.wang@sifive.com, lingshan.zhu@intel.com, eperezma@redhat.com, lulu@redhat.com, parav@mellanox.com, kevin.tian@intel.com, stefanha@redhat.com, hch@infradead.org, aadam@redhat.com, jiri@mellanox.com, shahafs@mellanox.com, hanand@xilinx.com, mhabets@solarflare.com
List-Id: virtualization@lists.linuxfoundation.org


On 2020/2/20 =E4=B8=8B=E5=8D=8812:04, Randy Dunlap wrote:
> On 2/19/20 7:56 PM, Jason Wang wrote:
>> This patch factors out IOTLB into a dedicated module in order to be
>> reused by other modules like vringh. User may choose to enable the
>> automatic retiring by specifying VHOST_IOTLB_FLAG_RETIRE flag to fit
>> for the case of vhost device IOTLB implementation.
>>
>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>> ---
>>   MAINTAINERS                 |   1 +
>>   drivers/vhost/Kconfig       |   7 ++
>>   drivers/vhost/Makefile      |   2 +
>>   drivers/vhost/net.c         |   2 +-
>>   drivers/vhost/vhost.c       | 221 +++++++++++-----------------------=
--
>>   drivers/vhost/vhost.h       |  36 ++----
>>   drivers/vhost/vhost_iotlb.c | 171 ++++++++++++++++++++++++++++
>>   include/linux/vhost_iotlb.h |  45 ++++++++
>>   8 files changed, 304 insertions(+), 181 deletions(-)
>>   create mode 100644 drivers/vhost/vhost_iotlb.c
>>   create mode 100644 include/linux/vhost_iotlb.h
>>
> Hi,
> Sorry if you have gone over this previously:


Thanks for the review, it's really helpful.


>
>> diff --git a/drivers/vhost/Kconfig b/drivers/vhost/Kconfig
>> index 3d03ccbd1adc..eef634ff9a6e 100644
>> --- a/drivers/vhost/Kconfig
>> +++ b/drivers/vhost/Kconfig
>> @@ -36,6 +36,7 @@ config VHOST_VSOCK
>>  =20
>>   config VHOST
>>   	tristate
>> +	select VHOST_IOTLB
>>   	---help---
>>   	  This option is selected by any driver which needs to access
>>   	  the core of vhost.
>> @@ -54,3 +55,9 @@ config VHOST_CROSS_ENDIAN_LEGACY
>>   	  adds some overhead, it is disabled by default.
>>  =20
>>   	  If unsure, say "N".
>> +
>> +config VHOST_IOTLB
>> +	tristate
>> +	default m
> "default m" should not be needed. Just make whatever needs it select it=
.


Yes, will fix.

Thanks


>
>> +	help
>> +	  Generic IOTLB implementation for vhost and vringh.
>
