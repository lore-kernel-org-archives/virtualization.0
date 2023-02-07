Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37D46C636CD
	for <virtualization@archiver.kernel.org>; Tue,  7 Feb 2023 05:51:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A15EF60B26;
	Tue,  7 Feb 2023 05:51:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A15EF60B26
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CagP7/27
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ohxVdhiBk6Cy; Tue,  7 Feb 2023 05:51:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 052EC60BDF;
	Tue,  7 Feb 2023 05:51:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 052EC60BDF
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C5CCBC0032;
	Tue,  7 Feb 2023 05:51:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C894DC002B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Feb 2023 05:51:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A39D14049E
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Feb 2023 05:51:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A39D14049E
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=CagP7/27
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IPsS8mQILJ_V
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Feb 2023 05:51:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 589854040D
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 589854040D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Feb 2023 05:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1675749066; x=1707285066;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=yF4PX+2z9gDccoVYuykfNbSYoITJYxsw4/QbUOFEFXg=;
 b=CagP7/27vI9qdQc8wy/03z1n4b27KFJf2PP8BfnBFsleXrKzsbqjLgUc
 N3bJXLWltGRO18FC1rxh0QWc7PR5A3A5z2JL2U9Dm9oViU71Ob0VGpjt9
 K7mKDmYsPbulEugw1IWq2oEHG6Q426ZaKERLeNajC1koMLG+LifiAoK+c
 JgOelGknRQ04RzbScyHItK0r3Emxux5ri8FZ3fX6NjPAvlVvPVUz0HxXM
 nxoNHN6CVqAzK49iP6o6xw2BSpm2TS58YvNubxGAVnASwA6RpVIASRbdn
 C7f9Gy+EI4EJruhCK48KhzImc9X2sYm4jpzuvq0ZODWFyhm7GFODJs9Op A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="415633725"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; d="scan'208";a="415633725"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Feb 2023 21:50:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="775409281"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; d="scan'208";a="775409281"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
 by fmsmga002.fm.intel.com with ESMTP; 06 Feb 2023 21:50:39 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1pPGsI-00038r-19;
 Tue, 07 Feb 2023 05:50:38 +0000
Date: Tue, 7 Feb 2023 13:50:01 +0800
From: kernel test robot <lkp@intel.com>
To: Saurabh Sengar <ssengar@linux.microsoft.com>, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, kys@microsoft.com,
 haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 daniel.lezcano@linaro.org, tglx@linutronix.de,
 virtualization@lists.linux-foundation.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hyperv@vger.kernel.org, mikelley@microsoft.com,
 ssengar@microsoft.com, dphadke@linux.microsoft.com
Subject: Re: [PATCH v3 3/6] Drivers: hv: vmbus: Convert acpi_device to more
 generic platform_device
Message-ID: <202302071303.dB30Hu98-lkp@intel.com>
References: <1675706060-22361-4-git-send-email-ssengar@linux.microsoft.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1675706060-22361-4-git-send-email-ssengar@linux.microsoft.com>
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

Thank you for the patch! Yet something to improve:

[auto build test ERROR on next-20230206]
[also build test ERROR on v6.2-rc7]
[cannot apply to robh/for-next tip/timers/core brgl/gpio/for-next wsa/i2c/for-next linus/master v6.2-rc7 v6.2-rc6 v6.2-rc5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Saurabh-Sengar/drivers-clocksource-hyper-v-non-ACPI-support-in-hyperv-clock/20230207-015625
patch link:    https://lore.kernel.org/r/1675706060-22361-4-git-send-email-ssengar%40linux.microsoft.com
patch subject: [PATCH v3 3/6] Drivers: hv: vmbus: Convert acpi_device to more generic platform_device
config: i386-randconfig-a006-20230206 (https://download.01.org/0day-ci/archive/20230207/202302071303.dB30Hu98-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/e6c8ebd27cac165137702f5ff85b14d6d0b8e820
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Saurabh-Sengar/drivers-clocksource-hyper-v-non-ACPI-support-in-hyperv-clock/20230207-015625
        git checkout e6c8ebd27cac165137702f5ff85b14d6d0b8e820
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/hv/vmbus_drv.c:2283:1: error: non-void function does not return a value [-Werror,-Wreturn-type]
   }
   ^
   1 error generated.


vim +2283 drivers/hv/vmbus_drv.c

b0069f43fc6bc9 drivers/staging/hv/vmbus_drv.c K. Y. Srinivasan 2011-04-29  2265  
e6c8ebd27cac16 drivers/hv/vmbus_drv.c         Saurabh Sengar   2023-02-06  2266  static int vmbus_mmio_remove(void)
7f163a6fd957a8 drivers/hv/vmbus_drv.c         Jake Oshins      2015-08-05  2267  {
7f163a6fd957a8 drivers/hv/vmbus_drv.c         Jake Oshins      2015-08-05  2268  	struct resource *cur_res;
7f163a6fd957a8 drivers/hv/vmbus_drv.c         Jake Oshins      2015-08-05  2269  	struct resource *next_res;
7f163a6fd957a8 drivers/hv/vmbus_drv.c         Jake Oshins      2015-08-05  2270  
7f163a6fd957a8 drivers/hv/vmbus_drv.c         Jake Oshins      2015-08-05  2271  	if (hyperv_mmio) {
6d146aefbaa5c5 drivers/hv/vmbus_drv.c         Jake Oshins      2016-04-05  2272  		if (fb_mmio) {
6d146aefbaa5c5 drivers/hv/vmbus_drv.c         Jake Oshins      2016-04-05  2273  			__release_region(hyperv_mmio, fb_mmio->start,
6d146aefbaa5c5 drivers/hv/vmbus_drv.c         Jake Oshins      2016-04-05  2274  					 resource_size(fb_mmio));
6d146aefbaa5c5 drivers/hv/vmbus_drv.c         Jake Oshins      2016-04-05  2275  			fb_mmio = NULL;
6d146aefbaa5c5 drivers/hv/vmbus_drv.c         Jake Oshins      2016-04-05  2276  		}
6d146aefbaa5c5 drivers/hv/vmbus_drv.c         Jake Oshins      2016-04-05  2277  
7f163a6fd957a8 drivers/hv/vmbus_drv.c         Jake Oshins      2015-08-05  2278  		for (cur_res = hyperv_mmio; cur_res; cur_res = next_res) {
7f163a6fd957a8 drivers/hv/vmbus_drv.c         Jake Oshins      2015-08-05  2279  			next_res = cur_res->sibling;
7f163a6fd957a8 drivers/hv/vmbus_drv.c         Jake Oshins      2015-08-05  2280  			kfree(cur_res);
7f163a6fd957a8 drivers/hv/vmbus_drv.c         Jake Oshins      2015-08-05  2281  		}
7f163a6fd957a8 drivers/hv/vmbus_drv.c         Jake Oshins      2015-08-05  2282  	}
7f163a6fd957a8 drivers/hv/vmbus_drv.c         Jake Oshins      2015-08-05 @2283  }
7f163a6fd957a8 drivers/hv/vmbus_drv.c         Jake Oshins      2015-08-05  2284  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
