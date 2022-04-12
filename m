Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B27F5C433F5
	for <virtualization@archiver.kernel.org>; Tue, 12 Apr 2022 16:37:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5A7CD40B18;
	Tue, 12 Apr 2022 16:37:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6zow_4A-R4XA; Tue, 12 Apr 2022 16:37:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D223A40B15;
	Tue, 12 Apr 2022 16:37:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A3E21C0033;
	Tue, 12 Apr 2022 16:37:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 414CCC002C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 16:37:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 207DA41728
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 16:37:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qD-fjrNXMEso
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 16:37:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F139141727
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 16:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1649781448; x=1681317448;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=8zmapAeyFTtKr42ftB7igvZstrLdaQa5K0dOWyaPelI=;
 b=fFkG/+2vlJEKxDFkjQmF7+XMSAQhS/oW8qank07N75rbLNiHyaywDgQd
 9WV1ByRB2v47+eIAnHn4eR/es2aZt5RGjRzaXkl6S+yw5bM7cTnFA59gq
 SgvkF3Fu/IjYWGeKWWNbuu0sMMntwZ8VKxdxLcQw0i/2WQxND4y81UYt5
 arWWjEqNBjzj4LeNodN1ZqeAaSnWONqDbnlVThbYvU0ICFCIrkFZr6nKE
 oNAX8jMvMg90v5ztdarlPrNLK5hzu+6iqHOsRUKay8JoHfW/XhMrjOkFC
 ZtO9yXqv1JnSEiwN5nzrbmWcK5iLZ7UiDC8yrp8rruBhOwIRZDzA6UFYd g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10315"; a="325340343"
X-IronPort-AV: E=Sophos;i="5.90,254,1643702400"; d="scan'208";a="325340343"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Apr 2022 09:29:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,254,1643702400"; d="scan'208";a="590393310"
Received: from lkp-server02.sh.intel.com (HELO d3fc50ef50de) ([10.239.97.151])
 by orsmga001.jf.intel.com with ESMTP; 12 Apr 2022 09:29:27 -0700
Received: from kbuild by d3fc50ef50de with local (Exim 4.95)
 (envelope-from <lkp@intel.com>) id 1neJOQ-0002zk-UN;
 Tue, 12 Apr 2022 16:29:26 +0000
Date: Wed, 13 Apr 2022 00:28:42 +0800
From: kernel test robot <lkp@intel.com>
To: Eli Cohen <elic@nvidia.com>, mst@redhat.com, jasowang@redhat.com
Subject: Re: [PATCH v2 1/2] vdpa: Add support for querying vendor statistics
Message-ID: <202204130003.fROyiuxA-lkp@intel.com>
References: <20220412130402.46945-2-elic@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220412130402.46945-2-elic@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: kbuild-all@lists.01.org, llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, si-wei.liu@oracle.com,
 Eli Cohen <elic@nvidia.com>
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

Hi Eli,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v5.18-rc2 next-20220412]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Eli-Cohen/Show-statistics-for-a-vdpa-device/20220412-212129
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git ce522ba9ef7e2d9fb22a39eb3371c0c64e2a433e
config: i386-randconfig-a004-20220411 (https://download.01.org/0day-ci/archive/20220413/202204130003.fROyiuxA-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project fe2478d44e4f7f191c43fef629ac7a23d0251e72)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/813a1bf827634a8d7e148b133e2849fac37819cd
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Eli-Cohen/Show-statistics-for-a-vdpa-device/20220412-212129
        git checkout 813a1bf827634a8d7e148b133e2849fac37819cd
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/usb/typec/ drivers/vdpa/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/vdpa/vdpa.c:1122:61: warning: implicit conversion from 'int' to 's16' (aka 'short') changes value from 65535 to -1 [-Wconstant-conversion]
           [VDPA_ATTR_DEV_QUEUE_INDEX] = NLA_POLICY_RANGE(NLA_U32, 0, 65535),
                                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~
   include/net/netlink.h:396:9: note: expanded from macro 'NLA_POLICY_RANGE'
           .max = _max                                     \
                  ^~~~
   1 warning generated.


vim +1122 drivers/vdpa/vdpa.c

  1114	
  1115	static const struct nla_policy vdpa_nl_policy[VDPA_ATTR_MAX + 1] = {
  1116		[VDPA_ATTR_MGMTDEV_BUS_NAME] = { .type = NLA_NUL_STRING },
  1117		[VDPA_ATTR_MGMTDEV_DEV_NAME] = { .type = NLA_STRING },
  1118		[VDPA_ATTR_DEV_NAME] = { .type = NLA_STRING },
  1119		[VDPA_ATTR_DEV_NET_CFG_MACADDR] = NLA_POLICY_ETH_ADDR,
  1120		/* virtio spec 1.1 section 5.1.4.1 for valid MTU range */
  1121		[VDPA_ATTR_DEV_NET_CFG_MTU] = NLA_POLICY_MIN(NLA_U16, 68),
> 1122		[VDPA_ATTR_DEV_QUEUE_INDEX] = NLA_POLICY_RANGE(NLA_U32, 0, 65535),
  1123	};
  1124	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
