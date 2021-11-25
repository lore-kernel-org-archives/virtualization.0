Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97396C433EF
	for <virtualization@archiver.kernel.org>; Thu, 25 Nov 2021 11:25:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 144CC60716;
	Thu, 25 Nov 2021 11:25:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DtZRdyE1Al9y; Thu, 25 Nov 2021 11:25:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9FFEA60613;
	Thu, 25 Nov 2021 11:25:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 71F19C0012;
	Thu, 25 Nov 2021 11:25:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D954EC000A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 11:25:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CED5C405B2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 11:25:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sgN0uEBng9mH
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 11:25:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D33084059B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 11:25:39 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10178"; a="235741383"
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; d="scan'208";a="235741383"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2021 03:25:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; d="scan'208";a="607540446"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
 by orsmga004.jf.intel.com with ESMTP; 25 Nov 2021 03:25:34 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1mqCsf-0006HN-KU; Thu, 25 Nov 2021 11:25:33 +0000
Date: Thu, 25 Nov 2021 19:25:08 +0800
From: kernel test robot <lkp@intel.com>
To: Jason Wang <jasowang@redhat.com>, mst@redhat.com,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio-mmio: harden interrupt
Message-ID: <202111251934.ybhaqyh7-lkp@intel.com>
References: <20211125063034.12347-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211125063034.12347-1-jasowang@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: kbuild-all@lists.01.org
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Hi Jason,

I love your patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v5.16-rc2 next-20211125]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Jason-Wang/virtio-mmio-harden-interrupt/20211125-143334
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 5f53fa508db098c9d372423a6dac31c8a5679cdf
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20211125/202111251934.ybhaqyh7-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/e19a8a1a95bd891090863b2d6828b8dc55d3633f
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Jason-Wang/virtio-mmio-harden-interrupt/20211125-143334
        git checkout e19a8a1a95bd891090863b2d6828b8dc55d3633f
        # save the config file to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross ARCH=m68k 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/virtio/virtio_mmio.c:105:6: warning: no previous prototype for 'vm_disable_cbs' [-Wmissing-prototypes]
     105 | void vm_disable_cbs(struct virtio_device *vdev)
         |      ^~~~~~~~~~~~~~
>> drivers/virtio/virtio_mmio.c:121:6: warning: no previous prototype for 'vm_enable_cbs' [-Wmissing-prototypes]
     121 | void vm_enable_cbs(struct virtio_device *vdev)
         |      ^~~~~~~~~~~~~


vim +/vm_disable_cbs +105 drivers/virtio/virtio_mmio.c

   103	
   104	/* disable irq handlers */
 > 105	void vm_disable_cbs(struct virtio_device *vdev)
   106	{
   107		struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
   108		int irq = platform_get_irq(vm_dev->pdev, 0);
   109	
   110		/*
   111		 * The below synchronize() guarantees that any
   112		 * interrupt for this line arriving after
   113		 * synchronize_irq() has completed is guaranteed to see
   114		 * intx_soft_enabled == false.
   115		 */
   116		WRITE_ONCE(vm_dev->intr_soft_enabled, false);
   117		synchronize_irq(irq);
   118	}
   119	
   120	/* enable irq handlers */
 > 121	void vm_enable_cbs(struct virtio_device *vdev)
   122	{
   123		struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
   124		int irq = platform_get_irq(vm_dev->pdev, 0);
   125	
   126		disable_irq(irq);
   127		/*
   128		 * The above disable_irq() provides TSO ordering and
   129		 * as such promotes the below store to store-release.
   130		 */
   131		WRITE_ONCE(vm_dev->intr_soft_enabled, true);
   132		enable_irq(irq);
   133		return;
   134	}
   135	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
