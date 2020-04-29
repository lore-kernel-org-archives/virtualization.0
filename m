From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH 5/5] virtio: Add bounce DMA ops
Date: Thu, 30 Apr 2020 05:06:40 +0800
Message-ID: <202004300425.BWcRAuHD%lkp@intel.com>
References: <1588073958-1793-6-git-send-email-vatsa@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1588073958-1793-6-git-send-email-vatsa@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: konrad.wilk@oracle.com, mst@redhat.com, jasowang@redhat.com, jan.kiszka@siemens.com, will@kernel.org, stefano.stabellini@xilinx.com
Cc: kbuild-all@lists.01.org, iommu@lists.linux-foundation.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, tsoni@codeaurora.org, pratikp@codeaurora.org, vatsa@codeaurora.org, christoffer.dall@arm.com, alex.bennee@linaro.org, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Hi Srivatsa,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on vhost/linux-next]
[also build test WARNING on xen-tip/linux-next linus/master v5.7-rc3 next-20200428]
[cannot apply to swiotlb/linux-next]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Srivatsa-Vaddagiri/virtio-on-Type-1-hypervisor/20200429-032334
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git linux-next
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-191-gc51a0382-dirty
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag as appropriate
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> drivers/virtio/virtio_bounce.c:22:21: sparse: sparse: symbol 'virtio_pool' was not declared. Should it be static?
>> drivers/virtio/virtio_bounce.c:79:8: sparse: sparse: symbol 'virtio_max_mapping_size' was not declared. Should it be static?

Please review and possibly fold the followup patch.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
