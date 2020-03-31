From: Jason Wang <jasowang@redhat.com>
Subject: Re: [vhost:linux-next 8/13] include/linux/vringh.h:18:10: fatal
 error: linux/vhost_iotlb.h: No such file or directory
Date: Tue, 31 Mar 2020 16:10:26 +0800
Message-ID: <ba85a677-85a8-b7d3-1401-4ac7674c8f3c@redhat.com>
References: <202003292026.dP7OOeCi%lkp@intel.com>
 <f1270de5-7a2c-76d2-431c-34364def851a@redhat.com>
 <2A5F4C9150EECB4DAA6291810D6D61B9745B7754@shsmsx102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <2A5F4C9150EECB4DAA6291810D6D61B9745B7754@shsmsx102.ccr.corp.intel.com>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: "Xia, Hui" <hui.xia@intel.com>, lkp <lkp@intel.com>
Cc: "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org


On 2020/3/31 =E4=B8=8B=E5=8D=883:31, Xia, Hui wrote:
>> -----Original Message-----
>> From: Jason Wang<jasowang@redhat.com>
>> Sent: 2020=E5=B9=B43=E6=9C=8830=E6=97=A5 10:47
>> To: lkp<lkp@intel.com>
>> Cc:kbuild-all@lists.01.org;kvm@vger.kernel.org;virtualization@lists.li=
nux-
>> foundation.org;netdev@vger.kernel.org; Michael S. Tsirkin<mst@redhat.c=
om>
>> Subject: Re: [vhost:linux-next 8/13] include/linux/vringh.h:18:10: fat=
al error:
>> linux/vhost_iotlb.h: No such file or directory
>>
>>
>> On 2020/3/29 =E4=B8=8B=E5=8D=888:08, kbuild test robot wrote:
>>> tree:https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git  l=
inux-next
>>> head:   f44a63f9ebf66a450c101084a35a3ef158ead209
>>> commit: c43908b0b9a900bd51f861f4c57b83cfd932f4d2 [8/13] vringh: IOTLB
>>> support
>>> config: arm-em_x270_defconfig (attached as .config)
>>> compiler: arm-linux-gnueabi-gcc (GCC) 9.3.0
>>> reproduce:
>>>           wgethttps://raw.githubusercontent.com/intel/lkp-
>> tests/master/sbin/make.cross -O ~/bin/make.cross
>>>           chmod +x ~/bin/make.cross
>>>           git checkout c43908b0b9a900bd51f861f4c57b83cfd932f4d2
>> I could not find this commit in the above branch.
>>
>>
>>>           # save the attached .config to linux build tree
>>>           GCC_VERSION=3D9.3.0 make.cross ARCH=3Darm
>> Try to use commit dc3b0673ae5efb73edab66ec5c2f074272e9a4df.
>>
>> But this command does not work (I remember it used to work):
>>
>> # GCC_VERSION=3D9.3.0 make.cross ARCH=3Darm
>> cd: received redirection to
>> `https://download.01.org/0day-ci/cross-package/'
>> lftpget -c
>> https://download.01.org/0day-ci/cross-package/./gcc-9.3.0-nolibc/x86_6=
4-gcc-
>> 9.3.0-nolibc_arm-linux-gnueabihf.tar.xz
>> tar Jxf
>> gcc-9.3.0-nolibc/x86_64-gcc-9.3.0-nolibc_arm-linux-gnueabihf.tar.xz -C
>> /root/0day No cross compiler for arm setup_crosstool failed
> Hi Jason, thanks for report this issue. It is caused by wrong finding i=
n 2 cross tools for arm. And has been fixed. Thanks.
> Regarding to the vhost build issue itself, it has gone in latest vhost/=
linux-next. The cause is the code kbuild captured didn't have  patch " vh=
ost: factor out IOTLB " which introduce linux/vhost_iotlb.h at that momen=
t. So just ignore this issue since the missed patch has been added in lat=
est vhost/linux-next.


Good to know this.

Thanks for the updating.


>
