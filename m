Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBB67EB64D9
	for <virtualization@archiver.kernel.org>; Wed, 28 Jun 2023 02:00:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3A199418FF;
	Wed, 28 Jun 2023 02:00:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3A199418FF
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=H72jGYaR
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gPgr8j7rkgbQ; Wed, 28 Jun 2023 02:00:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2F57A408A8;
	Wed, 28 Jun 2023 02:00:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2F57A408A8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 101ADC007C;
	Wed, 28 Jun 2023 02:00:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1CB19C0037
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Jun 2023 02:00:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D77A060B30
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Jun 2023 02:00:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D77A060B30
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=H72jGYaR
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uDs-jwqDcsIi
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Jun 2023 02:00:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B358560B25
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B358560B25
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Jun 2023 02:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1687917636; x=1719453636;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=eAtorlL9hKbOWTYbIFentcep4Cr94YB9cjfXVwCiIj8=;
 b=H72jGYaRVSMf/RBdFVdgRm33QcUpSW9asBFokfceIL3nb25+3SIFcLue
 evoGEUSAr+X4i9W6XCmwwCUfqvoQUUdcPea02KWmvEQPCvKgFH1gBGjpV
 oJWf00Ez2t18CG9N8jF+byxFFTOtcXcwzyZBGHqvfCdM1WxuOfdQrnkdx
 Ku7VqIPQa1Mq1gAslaCqEPKhcLcw7BFo8xV2NewytjZrvpPkGQwcrPghh
 bd/VVaFLpe5UUjUoevgDtDlYMXUALl4uDonGPTTtdq/ArDH9lZJYSSuXz
 YNpca0nk3WPtsi8M5YKZyU3OT4Ou6RNgPp5p+dkjt9T+/+ELFVs0A+Um+ w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="361768853"
X-IronPort-AV: E=Sophos;i="6.01,164,1684825200"; d="scan'208";a="361768853"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jun 2023 19:00:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="694106856"
X-IronPort-AV: E=Sophos;i="6.01,164,1684825200"; d="scan'208";a="694106856"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
 by orsmga006.jf.intel.com with ESMTP; 27 Jun 2023 19:00:31 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1qEKTu-000CSr-2O;
 Wed, 28 Jun 2023 02:00:30 +0000
Date: Wed, 28 Jun 2023 10:00:17 +0800
From: kernel test robot <lkp@intel.com>
To: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/5] mm/memory_hotplug: make
 offline_and_remove_memory() timeout instead of failing on fatal signals
Message-ID: <202306280935.dKTWlHFD-lkp@intel.com>
References: <20230627112220.229240-4-david@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230627112220.229240-4-david@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Michal Hocko <mhocko@suse.com>,
 John Hubbard <jhubbard@nvidia.com>, llvm@lists.linux.dev,
 virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
 "Michael S. Tsirkin" <mst@redhat.com>, oe-kbuild-all@lists.linux.dev,
 Andrew Morton <akpm@linux-foundation.org>, Oscar Salvador <osalvador@suse.de>
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

Hi David,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 6995e2de6891c724bfeb2db33d7b87775f913ad1]

url:    https://github.com/intel-lab-lkp/linux/commits/David-Hildenbrand/mm-memory_hotplug-check-for-fatal-signals-only-in-offline_pages/20230627-192444
base:   6995e2de6891c724bfeb2db33d7b87775f913ad1
patch link:    https://lore.kernel.org/r/20230627112220.229240-4-david%40redhat.com
patch subject: [PATCH v1 3/5] mm/memory_hotplug: make offline_and_remove_memory() timeout instead of failing on fatal signals
config: x86_64-randconfig-x006-20230627 (https://download.01.org/0day-ci/archive/20230628/202306280935.dKTWlHFD-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project.git 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce: (https://download.01.org/0day-ci/archive/20230628/202306280935.dKTWlHFD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306280935.dKTWlHFD-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> mm/memory_hotplug.c:163:13: warning: unused variable 'mhp_offlining_timer_active' [-Wunused-variable]
   static bool mhp_offlining_timer_active;
               ^
   mm/memory_hotplug.c:166:13: warning: unused function 'mhp_offline_timer_fn' [-Wunused-function]
   static void mhp_offline_timer_fn(struct timer_list *unused)
               ^
   2 warnings generated.


vim +/mhp_offlining_timer_active +163 mm/memory_hotplug.c

   154	
   155	/*
   156	 * Protected by the device hotplug lock: offline_and_remove_memory()
   157	 * will activate a timer such that offlining cannot be stuck forever.
   158	 *
   159	 * With an active timer, fatal signals will be ignored, because they can be
   160	 * counter-productive when dying user space triggers device unplug/driver
   161	 * unloading that ends up offlining+removing device memory.
   162	 */
 > 163	static bool mhp_offlining_timer_active;
   164	static atomic_t mhp_offlining_timer_expired;
   165	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
