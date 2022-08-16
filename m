Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5731AC25B0E
	for <virtualization@archiver.kernel.org>; Tue, 16 Aug 2022 22:18:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B40BC41591;
	Tue, 16 Aug 2022 22:18:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B40BC41591
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hXfkwJgw
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rDZY6C1z-wxF; Tue, 16 Aug 2022 22:18:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id AA30741570;
	Tue, 16 Aug 2022 22:18:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AA30741570
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 85D44C0032;
	Tue, 16 Aug 2022 22:18:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BCAF1C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 22:18:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8AE0282882
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 22:18:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8AE0282882
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=hXfkwJgw
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id W9IgbLgKNRhR
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 22:18:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5F4EB82893
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5F4EB82893
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 22:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1660688285; x=1692224285;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=5pHNRsmO3TscJoYhtn5ldO7gjZHTEK8owm0e2rym4/s=;
 b=hXfkwJgwMhCvgUm2WxgNjFktD8XFYlz6+U3rUJ9rs6YM9K41Wyezvcuj
 nFyx9oysx8zCYndfD5VLNpM1je0J+tIoLWvxB8WidEVFzeyhfy320qAg3
 /AhO47MMu3Ad67Se8IgW+KR1LlvcmIz96W/9/N/6CjyrQG/GLQ0u95tKZ
 A7OGKUyQX7M0pSe8l2sWQS21RAEZkZS/wIMs4KTz0os573IAHB02vIr7m
 giY51f/BSUU3+dvYAkt01AT/b2tBSRrcn/HGpDIfv7QJc56r8TkHEVArZ
 9ccuw4rNQecivgaK6mcklhU5ZqALSj+B4OxVofmty+LnvtnruqNLpf7hN Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10441"; a="272734388"
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; d="scan'208";a="272734388"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Aug 2022 15:18:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; d="scan'208";a="675395953"
Received: from lkp-server02.sh.intel.com (HELO 81d7e1ade3ba) ([10.239.97.151])
 by fmsmga004.fm.intel.com with ESMTP; 16 Aug 2022 15:18:02 -0700
Received: from kbuild by 81d7e1ade3ba with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1oO4ss-0000H2-12;
 Tue, 16 Aug 2022 22:18:02 +0000
Date: Wed, 17 Aug 2022 06:17:49 +0800
From: kernel test robot <lkp@intel.com>
To: Alexander Atanasov <alexander.atanasov@virtuozzo.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@redhat.com>, Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v2 4/4] drivers: virtio: balloon - update inflated memory
Message-ID: <202208170648.gcM3nXqB-lkp@intel.com>
References: <20220816094117.3144881-5-alexander.atanasov@virtuozzo.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220816094117.3144881-5-alexander.atanasov@virtuozzo.com>
Cc: Alexander Atanasov <alexander.atanasov@virtuozzo.com>, kernel@openvz.org,
 kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
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

Hi Alexander,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on powerpc/next]
[also build test ERROR on char-misc/char-misc-testing linus/master v6.0-rc1 next-20220816]
[cannot apply to soc/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Alexander-Atanasov/Make-place-for-common-balloon-code/20220816-184943
base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
config: i386-buildonly-randconfig-r004-20220815 (https://download.01.org/0day-ci/archive/20220817/202208170648.gcM3nXqB-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/d37f8ca37c57eb9e68b55ef33ecfce719f98bfe7
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Alexander-Atanasov/Make-place-for-common-balloon-code/20220816-184943
        git checkout d37f8ca37c57eb9e68b55ef33ecfce719f98bfe7
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "balloon_set_inflated_free" [drivers/virtio/virtio_balloon.ko] undefined!
>> ERROR: modpost: "balloon_set_inflated_total" [drivers/virtio/virtio_balloon.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
