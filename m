Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70E3CC7EE31
	for <virtualization@archiver.kernel.org>; Wed,  1 Mar 2023 01:19:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6694C400C8;
	Wed,  1 Mar 2023 01:19:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6694C400C8
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=XMolgVRf
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0pr3NGy7y16q; Wed,  1 Mar 2023 01:19:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id CFF684018E;
	Wed,  1 Mar 2023 01:19:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CFF684018E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9E91FC0033;
	Wed,  1 Mar 2023 01:19:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CD4FFC002B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Mar 2023 01:19:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9B8414027A
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Mar 2023 01:19:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9B8414027A
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YjH-s_Pl0fpT
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Mar 2023 01:19:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1FD2E4018E
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1FD2E4018E
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Mar 2023 01:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1677633542; x=1709169542;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=ZVaWKwbsgD+p7IQYEkRGQzQoEAFikHwsCb+688JuDPg=;
 b=XMolgVRfq9/+uxj6rwH1tEQOu73CRM/WBSyaQDlbBmnlDQIA76XIk0QJ
 8HBukzIOJzInzYi4+M8IbDEHn+9r7gyyKeW0TOs+IPVEHdY8OR0mzHuW6
 7REuuL03m4n/5Ido+u+dTNUsDIrVBbuow8qeiHLxLCTD9UBQuR5Tx2edl
 iht86bj6eTW9pHSqvvHBLG0RfCDNFye/cMpXnhAdirMczf7/wVP2YaDLi
 9h5aVwqkweKgaFNZ/Lyx54lxRV4lKyZ5QojQUmPvhOSelp31Wia+/Kf5X
 V1NK6MpnilgmVeKPVyUTPLxq+0FIIxSZkF/758gx6S9SbuSQe4ZnSDcXc A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="396859618"
X-IronPort-AV: E=Sophos;i="5.98,223,1673942400"; d="scan'208";a="396859618"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Feb 2023 17:19:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="784120925"
X-IronPort-AV: E=Sophos;i="5.98,223,1673942400"; d="scan'208";a="784120925"
Received: from lkp-server01.sh.intel.com (HELO 3895f5c55ead) ([10.239.97.150])
 by fmsmga002.fm.intel.com with ESMTP; 28 Feb 2023 17:18:59 -0800
Received: from kbuild by 3895f5c55ead with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1pXB7S-0005md-1l;
 Wed, 01 Mar 2023 01:18:58 +0000
Date: Wed, 1 Mar 2023 09:18:22 +0800
From: kernel test robot <lkp@intel.com>
To: Xie Yongji <xieyongji@bytedance.com>, mst@redhat.com,
 jasowang@redhat.com, tglx@linutronix.de, hch@lst.de
Subject: Re: [PATCH v3 05/11] vduse: Support automatic irq callback affinity
Message-ID: <202303010802.fyGx4T0d-lkp@intel.com>
References: <20230228094110.37-6-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230228094110.37-6-xieyongji@bytedance.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 oe-kbuild-all@lists.linux.dev
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

Hi Xie,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on tip/irq/core]
[also build test WARNING on linus/master next-20230228]
[cannot apply to mst-vhost/linux-next hch-configfs/for-next v6.2]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Xie-Yongji/lib-group_cpus-Export-group_cpus_evenly/20230228-174438
patch link:    https://lore.kernel.org/r/20230228094110.37-6-xieyongji%40bytedance.com
patch subject: [PATCH v3 05/11] vduse: Support automatic irq callback affinity
config: x86_64-randconfig-s021 (https://download.01.org/0day-ci/archive/20230301/202303010802.fyGx4T0d-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel-lab-lkp/linux/commit/6c15cc28cb814c0e6cb80955bc59517e80c15ae2
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Xie-Yongji/lib-group_cpus-Export-group_cpus_evenly/20230228-174438
        git checkout 6c15cc28cb814c0e6cb80955bc59517e80c15ae2
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 olddefconfig
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/vdpa/vdpa_user/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303010802.fyGx4T0d-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/vdpa/vdpa_user/vduse_dev.c:724:16: sparse: sparse: symbol 'create_affinity_masks' was not declared. Should it be static?

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
