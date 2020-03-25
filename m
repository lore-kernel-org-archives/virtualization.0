From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V7 3/8] vringh: IOTLB support
Date: Wed, 25 Mar 2020 11:13:54 +0800
Message-ID: <4032c9a2-a6c1-a041-fd59-81a8bf2fca46@redhat.com>
References: <20200324041458.27384-4-jasowang@redhat.com>
 <202003250217.stptJTnJ%lkp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <202003250217.stptJTnJ%lkp@intel.com>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@lists.01.org, mst@redhat.com, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org


On 2020/3/25 =E4=B8=8A=E5=8D=882:19, kbuild test robot wrote:
> Hi Jason,
>
> I love your patch! Yet something to improve:
>
> [auto build test ERROR on vhost/linux-next]
> [also build test ERROR on linux/master linus/master v5.6-rc7 next-20200=
324]
> [if your patch is applied to the wrong git tree, please drop us a note =
to help
> improve the system. BTW, we also suggest to use '--base' option to spec=
ify the
> base tree in git format-patch, please see https://stackoverflow.com/a/3=
7406982]
>
> url:    https://github.com/0day-ci/linux/commits/Jason-Wang/vDPA-suppor=
t/20200324-142634
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git l=
inux-next
> config: alpha-randconfig-a001-20200324 (attached as .config)
> compiler: alpha-linux-gcc (GCC) 9.2.0
> reproduce:
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/=
sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # save the attached .config to linux build tree
>          GCC_VERSION=3D9.2.0 make.cross ARCH=3Dalpha
>
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>     alpha-linux-ld: drivers/vhost/vringh.o: in function `iotlb_translat=
e':
>     drivers/vhost/vringh.c:1079: undefined reference to `vhost_iotlb_it=
ree_first'


This is because VHOST now depends on VHOST_IOTLB, but it was still=20
selected by MIC or VOP.

Will fix this by switching to use "depends on" fro MIC and VOP

Thanks.


>>> alpha-linux-ld: drivers/vhost/vringh.c:1079: undefined reference to `=
vhost_iotlb_itree_first'
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
