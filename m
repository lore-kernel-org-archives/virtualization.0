Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E966C77B7A
	for <virtualization@archiver.kernel.org>; Fri, 26 May 2023 17:44:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id AFBB242EE3;
	Fri, 26 May 2023 17:44:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AFBB242EE3
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=iumDFVZi
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id w2vxdSvxfqLo; Fri, 26 May 2023 17:44:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3622A42EE6;
	Fri, 26 May 2023 17:44:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3622A42EE6
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0825BC0035;
	Fri, 26 May 2023 17:44:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8EC22C002A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 May 2023 17:44:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 557BA42EE3
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 May 2023 17:44:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 557BA42EE3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VLkcjaxA321x
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 May 2023 17:44:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5E9BE42EDB
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5E9BE42EDB
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 May 2023 17:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1685123084; x=1716659084;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=x5pHN9VZUDdP2TLxPCWhN/t1BZUONMIrFg5l5cvTays=;
 b=iumDFVZi7C80j6evW6iF0RKqad73FursD70v3leNkSM9R/swmRsZtacA
 GI59VxuTAHyVoKzWWueAiltYGwmSooOapOedX4iDqdBMmb9KlgyVIfi86
 AuxWod5EHeZkaL+lyVM4AkAWEssL2tiZS1zm7SNTRpRvTdGn83q91fvWO
 bmqBp+Mf3uVsZVdGbWo2KH4kC32ei3BtUAqMrYg8libwgRpQ+1eBpsc4j
 r91k5ksf1SK9myYf6v3iOIsGasbpfx2ORxTJKP7adTp5CBdfcm6h3n7lK
 511WjJFydYB/XIMHCCnR/yaROsSn/A3Tjw0ZMVwL67TGC7pdZ4K8k+UlX Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10722"; a="417745388"
X-IronPort-AV: E=Sophos;i="6.00,194,1681196400"; d="scan'208";a="417745388"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2023 10:44:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10722"; a="775163669"
X-IronPort-AV: E=Sophos;i="6.00,194,1681196400"; d="scan'208";a="775163669"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
 by fmsmga004.fm.intel.com with ESMTP; 26 May 2023 10:44:40 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1q2bUV-000JVq-2o;
 Fri, 26 May 2023 17:44:39 +0000
Date: Sat, 27 May 2023 01:44:27 +0800
From: kernel test robot <lkp@intel.com>
To: Liang Chen <liangchen.linux@gmail.com>, jasowang@redhat.com, mst@redhat.com
Subject: Re: [PATCH net-next 3/5] virtio_net: Add page pool fragmentation
 support
Message-ID: <202305270116.TJ31IjNL-lkp@intel.com>
References: <20230526054621.18371-3-liangchen.linux@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230526054621.18371-3-liangchen.linux@gmail.com>
Cc: xuanzhuo@linux.alibaba.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, alexander.duyck@gmail.com,
 virtualization@lists.linux-foundation.org, edumazet@google.com,
 oe-kbuild-all@lists.linux.dev, kuba@kernel.org, pabeni@redhat.com,
 davem@davemloft.net
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

Hi Liang,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Liang-Chen/virtio_net-Add-page_pool-support-to-improve-performance/20230526-135805
base:   net-next/main
patch link:    https://lore.kernel.org/r/20230526054621.18371-3-liangchen.linux%40gmail.com
patch subject: [PATCH net-next 3/5] virtio_net: Add page pool fragmentation support
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20230527/202305270116.TJ31IjNL-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/dda0469e059354b61192e1d25b77c57351346282
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Liang-Chen/virtio_net-Add-page_pool-support-to-improve-performance/20230526-135805
        git checkout dda0469e059354b61192e1d25b77c57351346282
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 olddefconfig
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202305270116.TJ31IjNL-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: vmlinux.o: in function `virtnet_find_vqs':
   virtio_net.c:(.text+0x901fd2): undefined reference to `page_pool_create'
   ld: vmlinux.o: in function `add_recvbuf_mergeable.isra.0':
   virtio_net.c:(.text+0x905662): undefined reference to `page_pool_alloc_pages'
>> ld: virtio_net.c:(.text+0x905715): undefined reference to `page_pool_alloc_frag'
   ld: vmlinux.o: in function `xdp_linearize_page':
   virtio_net.c:(.text+0x906c50): undefined reference to `page_pool_alloc_pages'
   ld: virtio_net.c:(.text+0x906e33): undefined reference to `page_pool_alloc_frag'
   ld: vmlinux.o: in function `mergeable_xdp_get_buf.isra.0':
>> virtio_net.c:(.text+0x90740e): undefined reference to `page_pool_alloc_frag'
>> ld: virtio_net.c:(.text+0x90750b): undefined reference to `page_pool_alloc_pages'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
