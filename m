From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V7 7/8] vdpasim: vDPA device simulator
Date: Wed, 25 Mar 2020 16:15:18 +0800
Message-ID: <26bc89b3-8e29-db25-18fc-64e309951a94@redhat.com>
References: <20200324041458.27384-8-jasowang@redhat.com>
 <202003251045.ncVINn70%lkp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <202003251045.ncVINn70%lkp@intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@lists.01.org, mst@redhat.com, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org


On 2020/3/25 =E4=B8=8A=E5=8D=8810:25, kbuild test robot wrote:
> I love your patch! Yet something to improve:
>
> [auto build test ERROR on vhost/linux-next]
> [also build test ERROR on linux/master linus/master v5.6-rc7 next-20200=
324]
> [if your patch is applied to the wrong git tree, please drop us a note =
to help
> improve the system. BTW, we also suggest to use '--base' option to spec=
ify the
> base tree in git format-patch, please seehttps://stackoverflow.com/a/37=
406982]
>
> url:https://github.com/0day-ci/linux/commits/Jason-Wang/vDPA-support/20=
200324-142634
> base:https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git  lin=
ux-next
> config: m68k-allyesconfig (attached as .config)
> compiler: m68k-linux-gcc (GCC) 9.2.0
> reproduce:
>          wgethttps://raw.githubusercontent.com/intel/lkp-tests/master/s=
bin/make.cross  -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # save the attached .config to linux build tree
>          GCC_VERSION=3D9.2.0 make.cross ARCH=3Dm68k
>
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot<lkp@intel.com>
>
> All errors (new ones prefixed by >>):


This is because VDPA_SIM selects VHOST_RING which selects VHOST_IOTLB=20
which depends on VIRTULAIZATION but not defined in m68k.

I think we should refine the vhost Kconfig and decouple it out of=20
VIRTUALIZATION.

Will send a new series with this shortly.

Thanks
