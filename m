Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62071C7EE2E
	for <virtualization@archiver.kernel.org>; Mon, 27 Feb 2023 15:48:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EA4C8813E3;
	Mon, 27 Feb 2023 15:48:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EA4C8813E3
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VSg0w7k0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oigmRzxHZ3q0; Mon, 27 Feb 2023 15:48:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4464C813DC;
	Mon, 27 Feb 2023 15:48:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4464C813DC
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B2764C0032;
	Mon, 27 Feb 2023 15:48:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5C543C002B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Feb 2023 15:48:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 37D974086E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Feb 2023 15:48:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 37D974086E
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=VSg0w7k0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5BWn9n-L8dmj
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Feb 2023 15:48:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CC578408A6
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CC578408A6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Feb 2023 15:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1677512885; x=1709048885;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=4cs4e88M3T6bD2HjjcA0Xw1dtM6aKTcupBirC2netkU=;
 b=VSg0w7k0HRAmK9VfRozeAd5u/vfq6pkSboKLQe/4rUSD6hPCsE5gAnnb
 eFDdquC4ukdD9VW+7mqcaTAfbQGKFUc3+SgHY9L1m5rWMHHTFKXTTfN+x
 JbSylLdaAwS2f0it1NFgg58EF3qsNb9eOHd4R4PK7onLktYiJ9/GtEjg5
 XE4HHMDM0p4hjeXYn0PqxuEVJ1vepitVFbf52HdJkkVyhLAW8FDl8Ap2B
 CylEyz3ft2p9jpz2JGNFPheq1hwQhzSPsbrkPounDHuBVIGqF6vDlHFMF
 mYygaM+Theqb0PdzONywDtfDcjECOzoyQng7fKFLzy83harJkoGFDdQQj g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="332609573"
X-IronPort-AV: E=Sophos;i="5.98,219,1673942400"; d="scan'208";a="332609573"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Feb 2023 07:47:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="623621426"
X-IronPort-AV: E=Sophos;i="5.98,219,1673942400"; d="scan'208";a="623621426"
Received: from lkp-server01.sh.intel.com (HELO 3895f5c55ead) ([10.239.97.150])
 by orsmga003.jf.intel.com with ESMTP; 27 Feb 2023 07:47:47 -0800
Received: from kbuild by 3895f5c55ead with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1pWfj8-0004Xh-2Q;
 Mon, 27 Feb 2023 15:47:46 +0000
Date: Mon, 27 Feb 2023 23:47:06 +0800
From: kernel test robot <lkp@intel.com>
To: "Longpeng(Mike)" <longpeng2@huawei.com>, mst@redhat.com,
 jasowang@redhat.com
Subject: Re: [PATCH v4 2/2] vdpasim: support doorbell mapping
Message-ID: <202302272333.Jioo8IEs-lkp@intel.com>
References: <20230227091857.2406-3-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230227091857.2406-3-longpeng2@huawei.com>
Cc: llvm@lists.linux.dev, linux-kernel@vger.kernel.org, yechuan@huawei.com,
 eperezma@redhat.com, huangzhichao@huawei.com, stefanha@redhat.com,
 oe-kbuild-all@lists.linux.dev, Longpeng <longpeng2@huawei.com>,
 virtualization@lists.linux-foundation.org
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

Hi Longpeng(Mike),

Thank you for the patch! Yet something to improve:

[auto build test ERROR on v6.2]
[also build test ERROR on next-20230227]
[cannot apply to mst-vhost/linux-next linus/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Longpeng-Mike/vdpa-support-specify-the-pgprot-of-vq-notification-area/20230227-172516
patch link:    https://lore.kernel.org/r/20230227091857.2406-3-longpeng2%40huawei.com
patch subject: [PATCH v4 2/2] vdpasim: support doorbell mapping
config: arm-randconfig-r046-20230227 (https://download.01.org/0day-ci/archive/20230227/202302272333.Jioo8IEs-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project db89896bbbd2251fff457699635acbbedeead27f)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/intel-lab-lkp/linux/commit/a472c7ad92f68b5b596fd68e1936b2d47fe2ea0b
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Longpeng-Mike/vdpa-support-specify-the-pgprot-of-vq-notification-area/20230227-172516
        git checkout a472c7ad92f68b5b596fd68e1936b2d47fe2ea0b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302272333.Jioo8IEs-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: __bad_xchg
   >>> referenced by cmpxchg.h:110 (arch/arm/include/asm/cmpxchg.h:110)
   >>>               drivers/vdpa/vdpa_sim/vdpa_sim.o:(vdpasim_notify_work) in archive vmlinux.a

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
