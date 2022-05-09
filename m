Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 430ACC433F5
	for <virtualization@archiver.kernel.org>; Mon,  9 May 2022 12:29:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C9E1160B83;
	Mon,  9 May 2022 12:29:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id W6nU4Q8bFemH; Mon,  9 May 2022 12:29:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 6B5BD6079E;
	Mon,  9 May 2022 12:29:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 35528C0039;
	Mon,  9 May 2022 12:29:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C7C10C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 May 2022 12:29:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AF1BC8142A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 May 2022 12:29:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kfHxtxyjhSmR
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 May 2022 12:29:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CCB80813D9
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 May 2022 12:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1652099372; x=1683635372;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=qMvEPRtoB+d3/whBmM3c2zEnnc5nXdnRsTyVqxph14o=;
 b=TA8YVtT1JOtH2CI2mC+rIioR3CjIJudsOFymdIPMqpKn8xm0PPRovlBK
 cAv6q1FFbzMwDvdD8PU7U3e2SAA7KDNXx7CVV3tUtHTxWcHMu6ayYOyZt
 2ndsaVmOqgWLtduyX6v9vdbLmvjLRmSYacuDNDGB4jhasX8mnqN8BPisA
 U+VOL6D+sQAGxOTuXcZUpe/L1Wx8avinrDq+hSGTXABolOBMPw0lKUwfp
 DUkhdrlbcu0Nq2XqjhQYwGrhymbR299KeQNXJc+vIw9cnWpy79tysbq6K
 KayxfvvtlLJP0buXAuDJreHIHamRLOp0fSzwySrXu7CmbAVbAzVdXqxp+ g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10341"; a="268698449"
X-IronPort-AV: E=Sophos;i="5.91,211,1647327600"; d="scan'208";a="268698449"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 May 2022 05:29:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,211,1647327600"; d="scan'208";a="738142548"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
 by orsmga005.jf.intel.com with ESMTP; 09 May 2022 05:29:11 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
 (envelope-from <lkp@intel.com>) id 1no2Vi-000GVC-Dp;
 Mon, 09 May 2022 12:29:10 +0000
Date: Mon, 9 May 2022 20:28:43 +0800
From: kernel test robot <lkp@intel.com>
To: Cindy Lu <lulu@redhat.com>, jasowang@redhat.com, mst@redhat.com,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [PATCH v1] vdpa: Do not count the pages that were already pinned
 in the vhost-vDPA
Message-ID: <202205092058.if9wModg-lkp@intel.com>
References: <20220509071426.155941-1-lulu@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220509071426.155941-1-lulu@redhat.com>
Cc: kbuild-all@lists.01.org
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

Hi Cindy,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on mst-vhost/linux-next]
[also build test ERROR on linux/master linus/master v5.18-rc6]
[cannot apply to next-20220506]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Cindy-Lu/vdpa-Do-not-count-the-pages-that-were-already-pinned-in-the-vhost-vDPA/20220509-152644
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git linux-next
config: x86_64-randconfig-a014-20220509 (https://download.01.org/0day-ci/archive/20220509/202205092058.if9wModg-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/4225cc2a756b75d1e0ff7ca2a593bada42def380
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Cindy-Lu/vdpa-Do-not-count-the-pages-that-were-already-pinned-in-the-vhost-vDPA/20220509-152644
        git checkout 4225cc2a756b75d1e0ff7ca2a593bada42def380
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "interval_tree_remove" [drivers/vhost/vhost_vdpa.ko] undefined!
>> ERROR: modpost: "interval_tree_insert" [drivers/vhost/vhost_vdpa.ko] undefined!
>> ERROR: modpost: "interval_tree_iter_first" [drivers/vhost/vhost_vdpa.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
