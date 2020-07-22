From: Eli Cohen <eli@mellanox.com>
Subject: Re: [PATCH V2 vhost next 10/10] vdpa/mlx5: Add VDPA driver for
 supported mlx5 devices
Date: Wed, 22 Jul 2020 10:46:17 +0300
Message-ID: <20200722074617.GA210999@mtl-vdi-166.wap.labs.mlnx>
References: <20200720071416.32112-11-eli@mellanox.com>
 <202007202033.m3akyfrJ%lkp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <202007202033.m3akyfrJ%lkp@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: kernel test robot <lkp@intel.com>
Cc: mst@redhat.com, jasowang@redhat.com, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, kbuild-all@lists.01.org, shahafs@mellanox.com, saeedm@mellanox.com, parav@mellanox.com
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Jul 20, 2020 at 08:55:54PM +0800, kernel test robot wrote:
> Hi Eli,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on next-20200717]
> 
> url:    https://github.com/0day-ci/linux/commits/Eli-Cohen/VDPA-support-for-Mellanox-ConnectX-devices/20200720-160220
> base:    aab7ee9f8ff0110bfcd594b33dc33748dc1baf46
> config: arc-allyesconfig (attached as .config)
> compiler: arc-elf-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=arc 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
> >> drivers/vdpa/mlx5/net/main.c:7:10: fatal error: mlx5_vdpa_ifc.h: No such file or directory
>        7 | #include "mlx5_vdpa_ifc.h"
>          |          ^~~~~~~~~~~~~~~~~

Does anyone understand this error? The code compiles with no issues. I
think there may be an issue with the tool not interpreting the include
path in the makefile:

subdir-ccflags-y += -I$(src)/core

>    compilation terminated.
> --
>    In file included from drivers/vdpa/mlx5/net/mlx5_vnet.c:12:
> >> drivers/vdpa/mlx5/net/mlx5_vnet.h:13:10: fatal error: mlx5_vdpa.h: No such file or directory
>       13 | #include "mlx5_vdpa.h"
>          |          ^~~~~~~~~~~~~
>    compilation terminated.
> 
> vim +7 drivers/vdpa/mlx5/net/main.c
> 
>      3	
>      4	#include <linux/module.h>
>      5	#include <linux/mlx5/driver.h>
>      6	#include <linux/mlx5/device.h>
>    > 7	#include "mlx5_vdpa_ifc.h"
>      8	#include "mlx5_vnet.h"
>      9	
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
