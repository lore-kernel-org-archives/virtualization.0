Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C71FC433F5
	for <virtualization@archiver.kernel.org>; Wed,  2 Feb 2022 16:24:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D98D8405B4;
	Wed,  2 Feb 2022 16:24:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7TYkD5kstsSR; Wed,  2 Feb 2022 16:24:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 29E6A4010F;
	Wed,  2 Feb 2022 16:24:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F41CFC001A;
	Wed,  2 Feb 2022 16:24:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3628BC000B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Feb 2022 16:24:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3095F4057C
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Feb 2022 16:24:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dCUQEYUCZ0HW
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Feb 2022 16:24:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1DAD24010F
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Feb 2022 16:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1643819071; x=1675355071;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=crIMANMLKBvQD5aO8/SbvlEbfgJkAqaDfeDT9EokKZE=;
 b=W6PbrRls82RyKfNrTj8/Wy+r3Sc5PPRnHodV8lS4mQoF+/zcXPYQiBpB
 vitSNo+DLvzbLWLPZPaiX59FXjkEASaFRnFv5CxGPLnvXwD4prskNg2fY
 9GUnHTGP9i5vbz1vaobc52JJQppeFQK0zY7QomZh2uI+eQ0mgmcf+S3zF
 Z2FPQzZA3qMD2QYoWiKJvSz8en/qEY4ROILfb7d/vbSVUv3c6JQNvrkyJ
 xr4S3tiHAnMevvCItD2cjCpb5tIGS3l0L/wztnypbeKFUARXXt1yRdnki
 7rmfsaYssA5usMydX4+tLa+HbPxNbGhrzbfAXBXrq4wvnnu7AZvyMTmpQ Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10246"; a="227923535"
X-IronPort-AV: E=Sophos;i="5.88,337,1635231600"; d="scan'208";a="227923535"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Feb 2022 08:24:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,337,1635231600"; d="scan'208";a="771489431"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
 by fmsmga005.fm.intel.com with ESMTP; 02 Feb 2022 08:24:08 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1nFIQR-000Uom-R8; Wed, 02 Feb 2022 16:24:07 +0000
Date: Thu, 3 Feb 2022 00:23:08 +0800
From: kernel test robot <lkp@intel.com>
To: Jorgen Hansen <jhansen@vmware.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org
Subject: Re: [PATCH 2/8] VMCI: dma dg: add MMIO access to registers
Message-ID: <202202030055.O6CyDujA-lkp@intel.com>
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
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20220203/202202030055.O6CyDujA-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/0day-ci/linux/commit/f2afd39bab80c2e42ac789f6d949d779411df928
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Jorgen-Hansen/VMCI-dma-dg-Add-support-for-DMA-datagrams/20220202-230034
        git checkout f2afd39bab80c2e42ac789f6d949d779411df928
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/misc/vmw_vmci/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/misc/vmw_vmci/vmci_guest.c:93:14: warning: no previous prototype for 'vmci_read_reg' [-Wmissing-prototypes]
      93 | unsigned int vmci_read_reg(struct vmci_guest_device *dev, u32 reg)
         |              ^~~~~~~~~~~~~
>> drivers/misc/vmw_vmci/vmci_guest.c:100:6: warning: no previous prototype for 'vmci_write_reg' [-Wmissing-prototypes]
     100 | void vmci_write_reg(struct vmci_guest_device *dev, u32 val, u32 reg)
         |      ^~~~~~~~~~~~~~


vim +/vmci_read_reg +93 drivers/misc/vmw_vmci/vmci_guest.c

    92	
  > 93	unsigned int vmci_read_reg(struct vmci_guest_device *dev, u32 reg)
    94	{
    95		if (dev->mmio_base != NULL)
    96			return readl(dev->mmio_base + reg);
    97		return ioread32(dev->iobase + reg);
    98	}
    99	
 > 100	void vmci_write_reg(struct vmci_guest_device *dev, u32 val, u32 reg)
   101	{
   102		if (dev->mmio_base != NULL)
   103			writel(val, dev->mmio_base + reg);
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
