From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V3 5/5] vdpasim: vDPA device simulator
Date: Thu, 20 Feb 2020 13:41:29 +0800
Message-ID: <c1d82c5c-11f8-1bfc-ecc9-71093d0bec91@redhat.com>
References: <20200220035650.7986-1-jasowang@redhat.com>
 <20200220035650.7986-6-jasowang@redhat.com>
 <ee917060-da84-e94d-df99-208100345b14@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <ee917060-da84-e94d-df99-208100345b14@infradead.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Randy Dunlap <rdunlap@infradead.org>, mst@redhat.com, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Cc: tiwei.bie@intel.com, jgg@mellanox.com, maxime.coquelin@redhat.com, cunming.liang@intel.com, zhihong.wang@intel.com, rob.miller@broadcom.com, xiao.w.wang@intel.com, haotian.wang@sifive.com, lingshan.zhu@intel.com, eperezma@redhat.com, lulu@redhat.com, parav@mellanox.com, kevin.tian@intel.com, stefanha@redhat.com, hch@infradead.org, aadam@redhat.com, jiri@mellanox.com, shahafs@mellanox.com, hanand@xilinx.com, mhabets@solarflare.com
List-Id: virtualization@lists.linuxfoundation.org


On 2020/2/20 =E4=B8=8B=E5=8D=8812:09, Randy Dunlap wrote:
> On 2/19/20 7:56 PM, Jason Wang wrote:
>> diff --git a/drivers/virtio/vdpa/Kconfig b/drivers/virtio/vdpa/Kconfig
>> index 7a99170e6c30..e3656b722654 100644
>> --- a/drivers/virtio/vdpa/Kconfig
>> +++ b/drivers/virtio/vdpa/Kconfig
>> @@ -7,3 +7,21 @@ config VDPA
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
>> +        depends on RUNTIME_TESTING_MENU
>> +        default n
>> +        help
>> +          vDPA networking device simulator which loop TX traffic back
>> +          to RX. This device is used for testing, prototyping and
>> +          development of vDPA.
>> +
>> +endif # VDPA_MENU
>> +
> Use 1 tab for indentation for tristate/select/depends/default/help,
> and then 1 tab + 2 spaces for help text.


Yes.

Thanks


>
