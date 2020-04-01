From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V9 1/9] vhost: refine vhost and vringh kconfig
Date: Wed, 1 Apr 2020 20:50:36 +0800
Message-ID: <41ee1f6a-3124-d44b-bf34-0f26604f9514@redhat.com>
References: <20200326140125.19794-1-jasowang@redhat.com>
 <20200326140125.19794-2-jasowang@redhat.com>
 <fde312a4-56bd-f11f-799f-8aa952008012@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <fde312a4-56bd-f11f-799f-8aa952008012@de.ibm.com>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: Christian Borntraeger <borntraeger@de.ibm.com>, mst@redhat.com, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Cc: jgg@mellanox.com, maxime.coquelin@redhat.com, cunming.liang@intel.com, zhihong.wang@intel.com, rob.miller@broadcom.com, xiao.w.wang@intel.com, lingshan.zhu@intel.com, eperezma@redhat.com, lulu@redhat.com, parav@mellanox.com, kevin.tian@intel.com, stefanha@redhat.com, rdunlap@infradead.org, hch@infradead.org, aadam@redhat.com, jiri@mellanox.com, shahafs@mellanox.com, hanand@xilinx.com, mhabets@solarflare.com, gdawar@xilinx.com, saugatm@xilinx.com, vmireyno@marvell.com, zhangweining@ruijie.com.cn
List-Id: virtualization@lists.linuxfoundation.org


On 2020/4/1 =E4=B8=8B=E5=8D=887:21, Christian Borntraeger wrote:
> On 26.03.20 15:01, Jason Wang wrote:
>> Currently, CONFIG_VHOST depends on CONFIG_VIRTUALIZATION. But vhost is
>> not necessarily for VM since it's a generic userspace and kernel
>> communication protocol. Such dependency may prevent archs without
>> virtualization support from using vhost.
>>
>> To solve this, a dedicated vhost menu is created under drivers so
>> CONIFG_VHOST can be decoupled out of CONFIG_VIRTUALIZATION.
> FWIW, this now results in vhost not being build with defconfig kernels =
(in todays
> linux-next).
>

Hi Christian:

Did you meet it even with this=20
commit=C2=A0https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-ne=
xt.git/commit/?id=3Da4be40cbcedba9b5b714f3c95182e8a45176e42d?

If yes, what's your build config looks like?

Thanks
