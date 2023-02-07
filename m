Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 977B6C05027
	for <virtualization@archiver.kernel.org>; Tue,  7 Feb 2023 03:06:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 068FD4035D;
	Tue,  7 Feb 2023 03:06:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 068FD4035D
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=djtwViO0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hlIcWTXAbGIo; Tue,  7 Feb 2023 03:06:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id AC45240322;
	Tue,  7 Feb 2023 03:06:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AC45240322
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7220DC0033;
	Tue,  7 Feb 2023 03:06:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9E89BC002B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Feb 2023 03:06:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 644554030A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Feb 2023 03:06:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 644554030A
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Cn6kqH17cjX1
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Feb 2023 03:06:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D8439402B5
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D8439402B5
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Feb 2023 03:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1675739193; x=1707275193;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=YigXQ2LSr3ITNvRgdHDzSl8lcf5xe5hJv8rmEHqLs7c=;
 b=djtwViO0AClI2M79KGYsTYgWqiGs6fieUTjNaovOE++B8RoZHPNuRLVJ
 KyiOzsKmwXRkmSvqszKqVab998IeLmDK7Zmd/E1+E67WRP50bFJOGMCdX
 BggCTO8PQbBm0TgOIxOGiOhNFb9rRK7YX1AjJBW5nL7nS7AXbRsattKqa
 W7AD8BvSWZL3je2anUc09IuY7dm0qIw+pWok0ChQwuigiAccK4o/Etjx+
 Pb75M/ZqN2xhEVlR2hc6vmIV9/MRt2WXfcIT6VekWqndIJk048rxxcE0b
 8NeMUcInqaWcPDcGZPcPFmdhnPl4CtvaOmBH1lD+1DIxz26lH01KVdrNB w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="327075189"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; d="scan'208";a="327075189"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Feb 2023 19:06:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="730238373"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; d="scan'208";a="730238373"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
 by fmsmga008.fm.intel.com with ESMTP; 06 Feb 2023 19:06:29 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1pPEJQ-0002zW-17;
 Tue, 07 Feb 2023 03:06:28 +0000
Date: Tue, 7 Feb 2023 11:05:49 +0800
From: kernel test robot <lkp@intel.com>
To: Saurabh Sengar <ssengar@linux.microsoft.com>, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, kys@microsoft.com,
 haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 daniel.lezcano@linaro.org, tglx@linutronix.de,
 virtualization@lists.linux-foundation.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hyperv@vger.kernel.org, mikelley@microsoft.com,
 ssengar@microsoft.com, dphadke@linux.microsoft.com
Subject: Re: [PATCH v3 6/6] Driver: VMBus: Add device tree support
Message-ID: <202302071011.XjQOfXVK-lkp@intel.com>
References: <1675706060-22361-7-git-send-email-ssengar@linux.microsoft.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1675706060-22361-7-git-send-email-ssengar@linux.microsoft.com>
Cc: oe-kbuild-all@lists.linux.dev
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

Hi Saurabh,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on next-20230206]
[cannot apply to robh/for-next tip/timers/core brgl/gpio/for-next wsa/i2c/for-next linus/master v6.2-rc7 v6.2-rc6 v6.2-rc5 v6.2-rc7]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Saurabh-Sengar/drivers-clocksource-hyper-v-non-ACPI-support-in-hyperv-clock/20230207-015625
patch link:    https://lore.kernel.org/r/1675706060-22361-7-git-send-email-ssengar%40linux.microsoft.com
patch subject: [PATCH v3 6/6] Driver: VMBus: Add device tree support
config: i386-randconfig-a014-20230206 (https://download.01.org/0day-ci/archive/20230207/202302071011.XjQOfXVK-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/121473f34bab66918912399f1cfe9e06a9ea0294
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Saurabh-Sengar/drivers-clocksource-hyper-v-non-ACPI-support-in-hyperv-clock/20230207-015625
        git checkout 121473f34bab66918912399f1cfe9e06a9ea0294
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 olddefconfig
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/hv/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/hv/vmbus_drv.c: In function 'vmbus_mmio_remove':
   drivers/hv/vmbus_drv.c:2285:1: error: no return statement in function returning non-void [-Werror=return-type]
    2285 | }
         | ^
   At top level:
>> drivers/hv/vmbus_drv.c:2691:34: warning: 'vmbus_of_match' defined but not used [-Wunused-const-variable=]
    2691 | static const struct of_device_id vmbus_of_match[] = {
         |                                  ^~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/vmbus_of_match +2691 drivers/hv/vmbus_drv.c

  2690	
> 2691	static const struct of_device_id vmbus_of_match[] = {
  2692		{
  2693			.compatible = "microsoft,vmbus",
  2694		},
  2695		{
  2696			/* sentinel */
  2697		},
  2698	};
  2699	MODULE_DEVICE_TABLE(of, vmbus_of_match);
  2700	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
