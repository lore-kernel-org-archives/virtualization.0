Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06E61C001DF
	for <virtualization@archiver.kernel.org>; Sat, 22 Jul 2023 15:16:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 74443400C5;
	Sat, 22 Jul 2023 15:16:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 74443400C5
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UqDizqP/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yrDw-WDyY0D8; Sat, 22 Jul 2023 15:16:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0B4C1400CC;
	Sat, 22 Jul 2023 15:16:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0B4C1400CC
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CBA05C0072;
	Sat, 22 Jul 2023 15:16:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E8364C0032
 for <virtualization@lists.linux-foundation.org>;
 Sat, 22 Jul 2023 15:16:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BAB5B4181C
 for <virtualization@lists.linux-foundation.org>;
 Sat, 22 Jul 2023 15:16:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BAB5B4181C
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=UqDizqP/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2R8O0kBeg4Pv
 for <virtualization@lists.linux-foundation.org>;
 Sat, 22 Jul 2023 15:16:29 +0000 (UTC)
X-Greylist: delayed 426 seconds by postgrey-1.37 at util1.osuosl.org;
 Sat, 22 Jul 2023 15:16:28 UTC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E0F3C415F5
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E0F3C415F5
 for <virtualization@lists.linux-foundation.org>;
 Sat, 22 Jul 2023 15:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1690038987; x=1721574987;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=tP0c6UT1JUEzDEMg01H9+yYjfoMtWTAGuC2DlrbRxOU=;
 b=UqDizqP/YV0k1c+YHXcv6DVvbTkV3LG8VKYd6P/sWCOPgCAskmvhXZCJ
 pZQOPCPRsoe8Yxm0RCFdjEh4l3+Q7flqp2oE0YQKEZ01CGNZKE80ipbhD
 p6fpigfFbSLC2+hzou6mkcHyeaLAwZN/NRrcNqg8LkRzZGav8S92Deidp
 86Gsi8pCKMSZVOr81OE1z/83i36bQMU+Vnneb8Tw1L3OHvkM2pnDgHapd
 To7ACLl9y2f9EyQgsxrNzt+m2YdVQ/yPme0pG3YFUcMe1jO+tSWRbCyw+
 DB8h/twOZFoUw9qJhG+rWfetgC61/cJapxAaCMqwZ4UwNws7J5LhVF/U8 A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10779"; a="357195987"
X-IronPort-AV: E=Sophos;i="6.01,224,1684825200"; d="scan'208";a="357195987"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jul 2023 08:09:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10779"; a="795301223"
X-IronPort-AV: E=Sophos;i="6.01,224,1684825200"; d="scan'208";a="795301223"
Received: from lkp-server02.sh.intel.com (HELO 36946fcf73d7) ([10.239.97.151])
 by fmsmga004.fm.intel.com with ESMTP; 22 Jul 2023 08:09:18 -0700
Received: from kbuild by 36946fcf73d7 with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1qNEE8-0008Om-33;
 Sat, 22 Jul 2023 15:09:13 +0000
Date: Sat, 22 Jul 2023 23:07:18 +0800
From: kernel test robot <lkp@intel.com>
To: Paul Cercueil <paul@crapouillou.net>,
 Wolfram Sang <wsa-dev@sang-engineering.com>
Subject: Re: [PATCH v2 21/22] i2c: virtio: Remove #ifdef guards for PM
 related functions
Message-ID: <202307222246.K1GYOGCB-lkp@intel.com>
References: <20230722115310.27681-5-paul@crapouillou.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230722115310.27681-5-paul@crapouillou.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, llvm@lists.linux.dev,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Paul Cercueil <paul@crapouillou.net>, oe-kbuild-all@lists.linux.dev,
 linux-i2c@vger.kernel.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Conghui Chen <conghui.chen@intel.com>
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

Hi Paul,

kernel test robot noticed the following build errors:

[auto build test ERROR on wsa/i2c/for-next]
[also build test ERROR on brgl/gpio/for-next krzk/for-next linus/master v6.5-rc2 next-20230721]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Paul-Cercueil/i2c-au1550-Remove-ifdef-guards-for-PM-related-functions/20230722-200209
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-next
patch link:    https://lore.kernel.org/r/20230722115310.27681-5-paul%40crapouillou.net
patch subject: [PATCH v2 21/22] i2c: virtio: Remove #ifdef guards for PM related functions
config: i386-randconfig-r015-20230722 (https://download.01.org/0day-ci/archive/20230722/202307222246.K1GYOGCB-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project.git 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce: (https://download.01.org/0day-ci/archive/20230722/202307222246.K1GYOGCB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307222246.K1GYOGCB-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/i2c/busses/i2c-virtio.c:270:3: error: field designator 'freeze' does not refer to any field in type 'struct virtio_driver'
           .freeze                 = pm_sleep_ptr(virtio_i2c_freeze),
            ^
>> drivers/i2c/busses/i2c-virtio.c:271:3: error: field designator 'restore' does not refer to any field in type 'struct virtio_driver'
           .restore                = pm_sleep_ptr(virtio_i2c_restore),
            ^
   2 errors generated.


vim +270 drivers/i2c/busses/i2c-virtio.c

   260	
   261	static struct virtio_driver virtio_i2c_driver = {
   262		.feature_table		= features,
   263		.feature_table_size	= ARRAY_SIZE(features),
   264		.id_table		= id_table,
   265		.probe			= virtio_i2c_probe,
   266		.remove			= virtio_i2c_remove,
   267		.driver			= {
   268			.name	= "i2c_virtio",
   269		},
 > 270		.freeze			= pm_sleep_ptr(virtio_i2c_freeze),
 > 271		.restore		= pm_sleep_ptr(virtio_i2c_restore),
   272	};
   273	module_virtio_driver(virtio_i2c_driver);
   274	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
