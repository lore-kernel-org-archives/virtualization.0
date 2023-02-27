Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC309C64ED6
	for <virtualization@archiver.kernel.org>; Mon, 27 Feb 2023 22:10:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 39C4E81F68;
	Mon, 27 Feb 2023 22:10:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 39C4E81F68
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cj8S9gQj
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 19HNDUYo1ojO; Mon, 27 Feb 2023 22:10:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 97B4881F69;
	Mon, 27 Feb 2023 22:10:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 97B4881F69
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 661A5C0032;
	Mon, 27 Feb 2023 22:10:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 34251C002B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Feb 2023 22:10:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 08B8F417D2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Feb 2023 22:10:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 08B8F417D2
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=cj8S9gQj
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uch5YBuHFAJs
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Feb 2023 22:10:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9813A417CC
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9813A417CC
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Feb 2023 22:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1677535823; x=1709071823;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=P04NtkaiRm5S5kBVsea3jyY+3h4Cr03S9oHrE2g5Ds0=;
 b=cj8S9gQjqzmHDGIDgV6ayfRxCSb/bY2I09l5b54Fw2RgI8WBUvaqp978
 wxIkMHjnLAIewjUF5BJKpTNVh2LUkVIMsuogNtnumktkSvl1v+b9M6Cuh
 3mr8SQTDboBY+9hly2S5pS7aknNYYs+ivoNx8qKRqEuzp3OYOR11n7YZT
 pYK1ha/yGuMwUip1WmGxOSeBBBHYjwD6zww0Qdir7ALdI4TUAg45kUAjS
 dTbiWF9C+VgS6V3k3xbf1GyQ1SGGs8fO3rm4duKiWV5cN0B3ym3AuQbX9
 wqherSZwS/OjZ87Zcy1IWVP+mmhnSjsvwt69/3K2tFr6FMQeLtMpmtBe4 Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="317779465"
X-IronPort-AV: E=Sophos;i="5.98,220,1673942400"; d="scan'208";a="317779465"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Feb 2023 14:10:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="623782694"
X-IronPort-AV: E=Sophos;i="5.98,220,1673942400"; d="scan'208";a="623782694"
Received: from lkp-server01.sh.intel.com (HELO 3895f5c55ead) ([10.239.97.150])
 by orsmga003.jf.intel.com with ESMTP; 27 Feb 2023 14:10:03 -0800
Received: from kbuild by 3895f5c55ead with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1pWlh4-0004ox-2w;
 Mon, 27 Feb 2023 22:10:02 +0000
Date: Tue, 28 Feb 2023 06:09:15 +0800
From: kernel test robot <lkp@intel.com>
To: "Longpeng(Mike)" <longpeng2@huawei.com>, mst@redhat.com,
 jasowang@redhat.com
Subject: Re: [PATCH v4 2/2] vdpasim: support doorbell mapping
Message-ID: <202302280613.0lyqDCJr-lkp@intel.com>
References: <20230227091857.2406-3-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230227091857.2406-3-longpeng2@huawei.com>
Cc: linux-kernel@vger.kernel.org, yechuan@huawei.com, eperezma@redhat.com,
 huangzhichao@huawei.com, stefanha@redhat.com, oe-kbuild-all@lists.linux.dev,
 Longpeng <longpeng2@huawei.com>, virtualization@lists.linux-foundation.org
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
[cannot apply to mst-vhost/linux-next linus/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Longpeng-Mike/vdpa-support-specify-the-pgprot-of-vq-notification-area/20230227-172516
patch link:    https://lore.kernel.org/r/20230227091857.2406-3-longpeng2%40huawei.com
patch subject: [PATCH v4 2/2] vdpasim: support doorbell mapping
config: arm-allyesconfig (https://download.01.org/0day-ci/archive/20230228/202302280613.0lyqDCJr-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/a472c7ad92f68b5b596fd68e1936b2d47fe2ea0b
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Longpeng-Mike/vdpa-support-specify-the-pgprot-of-vq-notification-area/20230227-172516
        git checkout a472c7ad92f68b5b596fd68e1936b2d47fe2ea0b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302280613.0lyqDCJr-lkp@intel.com/

All errors (new ones prefixed by >>):

   arm-linux-gnueabi-ld: drivers/vdpa/vdpa_sim/vdpa_sim.o: in function `vdpasim_notify_work':
>> vdpa_sim.c:(.text+0x12d0): undefined reference to `__bad_xchg'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
