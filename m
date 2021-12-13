Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53D51C433F5
	for <virtualization@archiver.kernel.org>; Mon, 13 Dec 2021 18:47:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F143880B4A;
	Mon, 13 Dec 2021 18:47:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XJ-oR_Nw5A8k; Mon, 13 Dec 2021 18:47:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7123E80B38;
	Mon, 13 Dec 2021 18:46:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 395EDC002F;
	Mon, 13 Dec 2021 18:46:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 988C2C0012
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Dec 2021 18:46:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9361F40196
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Dec 2021 18:46:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yWxqnIp6Pgb3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Dec 2021 18:46:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 618B740022
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Dec 2021 18:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1639421216; x=1670957216;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=9skCXa1vdiokT9qe33jgpxewyeQKLLapHhl+dO0PgvI=;
 b=WuTHeIY+KjezZNlakPC7FQq11z1qkrPAH8lF59cNACjqfFAeyrrQj7vr
 qGle+bUvqLFqWNRgpg4ZIeChPdG25wBjBnEzq6OtwDzh7pC7wxTfIk3kW
 Z4/nXhW5fHyHQluv5p0rKRtZGFRk720YGYZFgZTPKYobvqG+1XLCYNDab
 cLusSTHAAC1IwhY6d8PVfUsg0PBG/qkwnD4tGhbIE4wlWbcczAj9woujK
 F/AyKL2urlofhmbMzTXZQIhDNUVFzbu3mS7Nip/rd0MZQPnT1VcHYeVJW
 UjIssl3W/ROYlXeoMap4xy8DYsrDLhcoOTdKwOt/zp9JFnw5mqYkgjVBZ w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="219485599"
X-IronPort-AV: E=Sophos;i="5.88,203,1635231600"; d="scan'208";a="219485599"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Dec 2021 10:46:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,203,1635231600"; d="scan'208";a="681739065"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
 by orsmga005.jf.intel.com with ESMTP; 13 Dec 2021 10:46:53 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1mwqLc-0006wc-Gj; Mon, 13 Dec 2021 18:46:52 +0000
Date: Tue, 14 Dec 2021 02:46:08 +0800
From: kernel test robot <lkp@intel.com>
To: Mikhail Golubev <Mikhail.Golubev@opensynergy.com>,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio_mmio: pm: Add notification handlers for restore
 and freeze
Message-ID: <202112140201.xeCfVzym-lkp@intel.com>
References: <20211213160002.GA202134@opensynergy.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211213160002.GA202134@opensynergy.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: kbuild-all@lists.01.org, Mikhail Golubev <Mikhail.Golubev@opensynergy.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
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

Hi Mikhail,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linux/master]
[also build test ERROR on linus/master v5.16-rc5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Mikhail-Golubev/virtio_mmio-pm-Add-notification-handlers-for-restore-and-freeze/20211214-001636
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 136057256686de39cc3a07c2e39ef6bc43003ff6
config: m68k-randconfig-r033-20211213 (https://download.01.org/0day-ci/archive/20211214/202112140201.xeCfVzym-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/86cd610f19003c4d848c13e5e00e38e9bc41f54e
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Mikhail-Golubev/virtio_mmio-pm-Add-notification-handlers-for-restore-and-freeze/20211214-001636
        git checkout 86cd610f19003c4d848c13e5e00e38e9bc41f54e
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=m68k SHELL=/bin/bash drivers/virtio/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/virtio/virtio_mmio.c: In function 'virtio_mmio_freeze':
>> drivers/virtio/virtio_mmio.c:770:16: error: implicit declaration of function 'virtio_device_freeze'; did you mean 'virtio_device_ready'? [-Werror=implicit-function-declaration]
     770 |         return virtio_device_freeze(&vm_dev->vdev);
         |                ^~~~~~~~~~~~~~~~~~~~
         |                virtio_device_ready
   drivers/virtio/virtio_mmio.c: In function 'virtio_mmio_restore':
>> drivers/virtio/virtio_mmio.c:778:16: error: implicit declaration of function 'virtio_device_restore'; did you mean 'virtio_mmio_restore'? [-Werror=implicit-function-declaration]
     778 |         return virtio_device_restore(&vm_dev->vdev);
         |                ^~~~~~~~~~~~~~~~~~~~~
         |                virtio_mmio_restore
   cc1: some warnings being treated as errors


vim +770 drivers/virtio/virtio_mmio.c

   764	
   765	static int __maybe_unused virtio_mmio_freeze(struct device *dev)
   766	{
   767		struct platform_device *pdev = to_platform_device(dev);
   768		struct virtio_mmio_device *vm_dev = platform_get_drvdata(pdev);
   769	
 > 770		return virtio_device_freeze(&vm_dev->vdev);
   771	}
   772	
   773	static int __maybe_unused virtio_mmio_restore(struct device *dev)
   774	{
   775		struct platform_device *pdev = to_platform_device(dev);
   776		struct virtio_mmio_device *vm_dev = platform_get_drvdata(pdev);
   777	
 > 778		return virtio_device_restore(&vm_dev->vdev);
   779	}
   780	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
