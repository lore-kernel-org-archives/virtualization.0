From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] vhost: do not enable VHOST_MENU by default
Date: Tue, 14 Apr 2020 17:48:04 +0800
Message-ID: <802e6da9-4827-a9a4-b409-f08a5de4e750@redhat.com>
References: <20200414024438.19103-1-jasowang@redhat.com>
 <375181ee-08ec-77a6-2dfc-f3c9c26705a1@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mips-owner@vger.kernel.org>
In-Reply-To: <375181ee-08ec-77a6-2dfc-f3c9c26705a1@de.ibm.com>
Content-Language: en-US
Sender: linux-mips-owner@vger.kernel.org
To: Christian Borntraeger <borntraeger@de.ibm.com>, mst@redhat.com
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, geert@linux-m68k.org, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org


On 2020/4/14 =E4=B8=8B=E5=8D=883:26, Christian Borntraeger wrote:
> On 14.04.20 04:44, Jason Wang wrote:
>> We try to keep the defconfig untouched after decoupling CONFIG_VHOST
>> out of CONFIG_VIRTUALIZATION in commit 20c384f1ea1a
>> ("vhost: refine vhost and vringh kconfig") by enabling VHOST_MENU by
>> default. Then the defconfigs can keep enabling CONFIG_VHOST_NET
>> without the caring of CONFIG_VHOST.
>>
>> But this will leave a "CONFIG_VHOST_MENU=3Dy" in all defconfigs and ev=
en
>> for the ones that doesn't want vhost. So it actually shifts the
>> burdens to the maintainers of all other to add "CONFIG_VHOST_MENU is
>> not set". So this patch tries to enable CONFIG_VHOST explicitly in
>> defconfigs that enables CONFIG_VHOST_NET and CONFIG_VHOST_VSOCK.
>>
>> Cc: Thomas Bogendoerfer<tsbogend@alpha.franken.de>
>> Cc: Benjamin Herrenschmidt<benh@kernel.crashing.org>
>> Cc: Paul Mackerras<paulus@samba.org>
>> Cc: Michael Ellerman<mpe@ellerman.id.au>
>> Cc: Heiko Carstens<heiko.carstens@de.ibm.com>
>> Cc: Vasily Gorbik<gor@linux.ibm.com>
>> Cc: Christian Borntraeger<borntraeger@de.ibm.com>
> Fine with me.
> s390 part
>
> Acked-by: Christian Borntraeger<borntraeger@de.ibm.com>
>
>   That was my first approach to get things fixed before I reported
> this to you.


Exactly.

Thanks

>
