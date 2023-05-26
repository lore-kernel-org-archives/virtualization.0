Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61821C77B73
	for <virtualization@archiver.kernel.org>; Fri, 26 May 2023 16:16:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C2BAC82F57;
	Fri, 26 May 2023 16:16:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C2BAC82F57
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VCu1WMMA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id C9ziQPRO9Vex; Fri, 26 May 2023 16:16:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 58C9982F77;
	Fri, 26 May 2023 16:16:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 58C9982F77
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 30A51C0036;
	Fri, 26 May 2023 16:16:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 273FCC002A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 May 2023 16:16:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0858960E84
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 May 2023 16:16:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0858960E84
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=VCu1WMMA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id x6Lpvf1OVJAf
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 May 2023 16:16:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C9C7660E7C
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C9C7660E7C
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 May 2023 16:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1685117811; x=1716653811;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=tFle62zzOw130eAw0UDs1o1U+rbjQMuBYyQ/MfXYpg0=;
 b=VCu1WMMA6skKYPwsxaNpw7jflC1BcclZtiHxbBpsBeIxrVRYefMFyzst
 hMUK6KJoT/tNkwjomkz6lH0LjXcpnbV8GvVWF+kjyBEeZXRKagx5Ys7pS
 Vuq3h48ZwsGHek+IRvcR4OSsA5EOHGNZXZP8hQXpVtrIj3+gBxuuKLb51
 ggJQIyswJ0WX7+UgKjXuyY1VsHd6n0GkWlvuqTWCbyV1HIDTAGkBySocc
 Mbh/KaYriOkBNNVDbYaZeSav4hGJC+IM8VwYqEp/4Uc93+nqXxUYxhsB8
 D6vQkbFzbWK6+0P9yYW14bzJ/ab4kckYGez6HRjl1/fIdFqqUE+2wGHn7 w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10722"; a="334593846"
X-IronPort-AV: E=Sophos;i="6.00,194,1681196400"; d="scan'208";a="334593846"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2023 09:11:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10722"; a="770387608"
X-IronPort-AV: E=Sophos;i="6.00,194,1681196400"; d="scan'208";a="770387608"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
 by fmsmga008.fm.intel.com with ESMTP; 26 May 2023 09:11:36 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1q2a2S-000JRq-0F;
 Fri, 26 May 2023 16:11:36 +0000
Date: Sat, 27 May 2023 00:11:25 +0800
From: kernel test robot <lkp@intel.com>
To: Liang Chen <liangchen.linux@gmail.com>, jasowang@redhat.com, mst@redhat.com
Subject: Re: [PATCH net-next 2/5] virtio_net: Add page_pool support to
 improve performance
Message-ID: <202305262334.GiFQ3wpG-lkp@intel.com>
References: <20230526054621.18371-2-liangchen.linux@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230526054621.18371-2-liangchen.linux@gmail.com>
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
patch link:    https://lore.kernel.org/r/20230526054621.18371-2-liangchen.linux%40gmail.com
patch subject: [PATCH net-next 2/5] virtio_net: Add page_pool support to improve performance
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20230526/202305262334.GiFQ3wpG-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/bfba563f43bba37181d8502cb2e566c32f96ec9e
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Liang-Chen/virtio_net-Add-page_pool-support-to-improve-performance/20230526-135805
        git checkout bfba563f43bba37181d8502cb2e566c32f96ec9e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 olddefconfig
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202305262334.GiFQ3wpG-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: vmlinux.o: in function `virtnet_find_vqs':
>> virtio_net.c:(.text+0x901fb5): undefined reference to `page_pool_create'
   ld: vmlinux.o: in function `add_recvbuf_mergeable.isra.0':
>> virtio_net.c:(.text+0x905618): undefined reference to `page_pool_alloc_pages'
   ld: vmlinux.o: in function `xdp_linearize_page':
   virtio_net.c:(.text+0x906b6b): undefined reference to `page_pool_alloc_pages'
   ld: vmlinux.o: in function `mergeable_xdp_get_buf.isra.0':
   virtio_net.c:(.text+0x90728f): undefined reference to `page_pool_alloc_pages'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
