Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69AC6C433F5
	for <virtualization@archiver.kernel.org>; Wed,  2 Feb 2022 21:18:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EDC76408D8;
	Wed,  2 Feb 2022 21:18:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id m-s7A_nSxkS8; Wed,  2 Feb 2022 21:18:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 6D3904035D;
	Wed,  2 Feb 2022 21:18:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4DA09C0011;
	Wed,  2 Feb 2022 21:18:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 66F87C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Feb 2022 21:18:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 559B680E17
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Feb 2022 21:18:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CKm6g7qHR52O
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Feb 2022 21:18:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 74B7880DB9
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Feb 2022 21:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1643836710; x=1675372710;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=pKbwTf351WMGvUo20IwzPN+wwoLePreHupAdfPbGkZg=;
 b=MKVEKW6d2efySN3DmWA1qGSvI2QboQmadlr+WtQHZJxhsopKIFhwHZL9
 oO5dWw1PXPgWRFK19c1wCpif5qplYAA9QOSjBSkPYfwM9+FBXZrz+ilrq
 CXcY7KdEg9lUYoDvmgyWsu9JHbJJsnVOauI5cwXIr3FqNraiAcFYJr17o
 xrJ6HmzxVldWIrpFhkGBSLmIMmLcr+ZtzHL7YOHSUmnLF/uveZgVRCOq3
 1qCFfowAfDFpnUvayXCKwb9Cjh1ovx7pIazNCygmxuJVNM6cXam7fNW4b
 W/r0ygmCnMNp4KWry+qMbvUgavDbryNmh4y2mojAGgEhrGfKLnZT9PMk8 Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10246"; a="245618641"
X-IronPort-AV: E=Sophos;i="5.88,337,1635231600"; d="scan'208";a="245618641"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Feb 2022 13:18:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,337,1635231600"; d="scan'208";a="699059022"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
 by orsmga005.jf.intel.com with ESMTP; 02 Feb 2022 13:18:27 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1nFN1H-000V8n-0Q; Wed, 02 Feb 2022 21:18:27 +0000
Date: Thu, 3 Feb 2022 05:18:19 +0800
From: kernel test robot <lkp@intel.com>
To: Jorgen Hansen <jhansen@vmware.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org
Subject: Re: [PATCH 2/8] VMCI: dma dg: add MMIO access to registers
Message-ID: <202202030509.ZJep87ms-lkp@intel.com>
References: <20220202144910.10349-3-jhansen@vmware.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220202144910.10349-3-jhansen@vmware.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: pv-drivers@vmware.com, gregkh@linuxfoundation.org, kbuild-all@lists.01.org,
 Vishnu Dasa <vdasa@vmware.com>, Jorgen Hansen <jhansen@vmware.com>
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

Hi Jorgen,

I love your patch! Perhaps something to improve:

[auto build test WARNING on char-misc/char-misc-testing]
[also build test WARNING on linux/master linus/master v5.17-rc2 next-20220202]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Jorgen-Hansen/VMCI-dma-dg-Add-support-for-DMA-datagrams/20220202-230034
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git 7ab004dbcbee38b8a70798835d3ffcd97a985a5e
config: i386-randconfig-s002 (https://download.01.org/0day-ci/archive/20220203/202202030509.ZJep87ms-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/0day-ci/linux/commit/f2afd39bab80c2e42ac789f6d949d779411df928
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Jorgen-Hansen/VMCI-dma-dg-Add-support-for-DMA-datagrams/20220202-230034
        git checkout f2afd39bab80c2e42ac789f6d949d779411df928
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash drivers/misc/vmw_vmci/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/misc/vmw_vmci/vmci_guest.c:96:45: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got char * @@
   drivers/misc/vmw_vmci/vmci_guest.c:96:45: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/misc/vmw_vmci/vmci_guest.c:96:45: sparse:     got char *
>> drivers/misc/vmw_vmci/vmci_guest.c:93:14: sparse: sparse: symbol 'vmci_read_reg' was not declared. Should it be static?
>> drivers/misc/vmw_vmci/vmci_guest.c:103:44: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got char * @@
   drivers/misc/vmw_vmci/vmci_guest.c:103:44: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/misc/vmw_vmci/vmci_guest.c:103:44: sparse:     got char *
>> drivers/misc/vmw_vmci/vmci_guest.c:100:6: sparse: sparse: symbol 'vmci_write_reg' was not declared. Should it be static?
>> drivers/misc/vmw_vmci/vmci_guest.c:473:27: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char *mmio_base @@     got void [noderef] __iomem * @@
   drivers/misc/vmw_vmci/vmci_guest.c:473:27: sparse:     expected char *mmio_base
   drivers/misc/vmw_vmci/vmci_guest.c:473:27: sparse:     got void [noderef] __iomem *

Please review and possibly fold the followup patch.

vim +96 drivers/misc/vmw_vmci/vmci_guest.c

    92	
  > 93	unsigned int vmci_read_reg(struct vmci_guest_device *dev, u32 reg)
    94	{
    95		if (dev->mmio_base != NULL)
  > 96			return readl(dev->mmio_base + reg);
    97		return ioread32(dev->iobase + reg);
    98	}
    99	
 > 100	void vmci_write_reg(struct vmci_guest_device *dev, u32 val, u32 reg)
   101	{
   102		if (dev->mmio_base != NULL)
 > 103			writel(val, dev->mmio_base + reg);
   104		else
   105			iowrite32(val, dev->iobase + reg);
   106	}
   107	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
