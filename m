Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41F38C05027
	for <virtualization@archiver.kernel.org>; Wed,  8 Feb 2023 08:23:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AC86481F15;
	Wed,  8 Feb 2023 08:23:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AC86481F15
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HJ14VCM0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Wzh0naA7d-T7; Wed,  8 Feb 2023 08:23:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 232EE81F04;
	Wed,  8 Feb 2023 08:23:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 232EE81F04
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E4D4AC0032;
	Wed,  8 Feb 2023 08:23:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0BB56C002B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Feb 2023 08:23:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CC64B81F07
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Feb 2023 08:23:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CC64B81F07
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6rrtP2OMkbKl
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Feb 2023 08:23:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CFB2881F04
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CFB2881F04
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Feb 2023 08:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1675844594; x=1707380594;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=eT7LyT1k1N1zT8h2h1TIVWuk3jB5eyl3BSlItLElxuw=;
 b=HJ14VCM0zredp/n7fuOPjtYpGJrlMAFRk1KgQnUFhdFp4rS7BeldkBma
 8mNacA7qDZxNLRhrMumroJzi5DYxlcfTXUhOHmA/VqxgpM+jVEgPGfK3a
 HT3kMW+kRov5UmjpNwmFeb1O4lz96EDfE3aJq/YFC6KidrNH0NTinw86S
 8S5050G5/75LdROh6Yi6j7f4eRrOQr8K9RACHhklAZdIB7MMAhFBNzqPg
 1EmOHwJdIME2N41OtfwvAfZSZmbDYNTl09k57LK47efR/rW/O6iKNjeQM
 EjG2YGoYq/0CHHZARWfX5gDMaNLhp+62IuPRexG0LCgIuN4PQq/DAh+Oj g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="331874270"
X-IronPort-AV: E=Sophos;i="5.97,280,1669104000"; d="scan'208";a="331874270"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Feb 2023 00:23:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="996049097"
X-IronPort-AV: E=Sophos;i="5.97,280,1669104000"; d="scan'208";a="996049097"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
 by fmsmga005.fm.intel.com with ESMTP; 08 Feb 2023 00:22:57 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1pPfjE-0004JC-1f;
 Wed, 08 Feb 2023 08:22:56 +0000
Date: Wed, 8 Feb 2023 16:22:01 +0800
From: kernel test robot <lkp@intel.com>
To: Saurabh Sengar <ssengar@linux.microsoft.com>, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, kys@microsoft.com,
 haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 daniel.lezcano@linaro.org, tglx@linutronix.de,
 virtualization@lists.linux-foundation.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hyperv@vger.kernel.org, mikelley@microsoft.com,
 ssengar@microsoft.com, dphadke@linux.microsoft.com
Subject: Re: [PATCH v4 6/6] Driver: VMBus: Add device tree support
Message-ID: <202302081621.odizDzHG-lkp@intel.com>
References: <1675756199-5917-7-git-send-email-ssengar@linux.microsoft.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1675756199-5917-7-git-send-email-ssengar@linux.microsoft.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
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

[auto build test WARNING on next-20230207]
[cannot apply to robh/for-next tip/timers/core brgl/gpio/for-next wsa/i2c/for-next linus/master v6.2-rc7 v6.2-rc6 v6.2-rc5 v6.2-rc7]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Saurabh-Sengar/drivers-clocksource-hyper-v-non-ACPI-support-in-hyperv-clock/20230207-155113
patch link:    https://lore.kernel.org/r/1675756199-5917-7-git-send-email-ssengar%40linux.microsoft.com
patch subject: [PATCH v4 6/6] Driver: VMBus: Add device tree support
config: i386-randconfig-a015 (https://download.01.org/0day-ci/archive/20230208/202302081621.odizDzHG-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/b3cd029f78e9c1f5cd1633e1ffc7c5a09deae98f
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Saurabh-Sengar/drivers-clocksource-hyper-v-non-ACPI-support-in-hyperv-clock/20230207-155113
        git checkout b3cd029f78e9c1f5cd1633e1ffc7c5a09deae98f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/hv/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/hv/vmbus_drv.c:2691:21: warning: attribute declaration must precede definition [-Wignored-attributes]
   static const struct __maybe_unused of_device_id vmbus_of_match[] = {
                       ^
   include/linux/compiler_attributes.h:355:56: note: expanded from macro '__maybe_unused'
   #define __maybe_unused                  __attribute__((__unused__))
                                                          ^
   include/linux/mod_devicetable.h:268:8: note: previous definition is here
   struct of_device_id {
          ^
   1 warning generated.


vim +2691 drivers/hv/vmbus_drv.c

  2690	
> 2691	static const struct __maybe_unused of_device_id vmbus_of_match[] = {
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
