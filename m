From: Jason Wang <jasowang@redhat.com>
Subject: Re: [vhost:linux-next 8/13] include/linux/vringh.h:18:10: fatal
 error: linux/vhost_iotlb.h: No such file or directory
Date: Mon, 30 Mar 2020 10:46:35 +0800
Message-ID: <f1270de5-7a2c-76d2-431c-34364def851a@redhat.com>
References: <202003292026.dP7OOeCi%lkp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <202003292026.dP7OOeCi%lkp@intel.com>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@lists.01.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org


On 2020/3/29 =E4=B8=8B=E5=8D=888:08, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git l=
inux-next
> head:   f44a63f9ebf66a450c101084a35a3ef158ead209
> commit: c43908b0b9a900bd51f861f4c57b83cfd932f4d2 [8/13] vringh: IOTLB s=
upport
> config: arm-em_x270_defconfig (attached as .config)
> compiler: arm-linux-gnueabi-gcc (GCC) 9.3.0
> reproduce:
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/=
sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          git checkout c43908b0b9a900bd51f861f4c57b83cfd932f4d2


I could not find this commit in the above branch.


>          # save the attached .config to linux build tree
>          GCC_VERSION=3D9.3.0 make.cross ARCH=3Darm


Try to use commit dc3b0673ae5efb73edab66ec5c2f074272e9a4df.

But this command does not work (I remember it used to work):

# GCC_VERSION=3D9.3.0 make.cross ARCH=3Darm
cd: received redirection to=20
`https://download.01.org/0day-ci/cross-package/'
lftpget -c=20
https://download.01.org/0day-ci/cross-package/./gcc-9.3.0-nolibc/x86_64-g=
cc-9.3.0-nolibc_arm-linux-gnueabihf.tar.xz
tar Jxf=20
gcc-9.3.0-nolibc/x86_64-gcc-9.3.0-nolibc_arm-linux-gnueabihf.tar.xz -C=20
/root/0day
No cross compiler for arm
setup_crosstool failed


>
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>     In file included from include/linux/virtio.h:12,
>                      from include/linux/virtio_config.h:7,
>                      from include/uapi/linux/virtio_net.h:30,
>                      from include/linux/virtio_net.h:6,
>                      from net//packet/af_packet.c:82:
>>> include/linux/vringh.h:18:10: fatal error: linux/vhost_iotlb.h: No su=
ch file or directory
>        18 | #include <linux/vhost_iotlb.h>
>           |          ^~~~~~~~~~~~~~~~~~~~~
>     compilation terminated.
>
> vim +18 include/linux/vringh.h
>
>    > 18	#include <linux/vhost_iotlb.h>
>      19	#include <asm/barrier.h>
>      20=09


I can hardly believe it can't work.

I get

# file include/linux/vringh.h
include/linux/vringh.h: C source, ASCII text

So this looks like a false positive to me?

Thanks


>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
