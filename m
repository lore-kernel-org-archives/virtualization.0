Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A78F3BB117
	for <virtualization@lists.linux-foundation.org>; Fri,  5 Jun 2026 01:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780622653; cv=none; b=jTR401DEZcoBagKiUX2vQlo5dh7nL0fcRYtOJtmVWq4ikYAJxZSSZlt00kwLXHiz3GHCDyBudDbPq0G/esRXCKszWM1GVK0SCFu+UJBNJ5WV20Sg/r6OJkxLvb+CgzMv5rx539pSVHwhgBaKpx0gbf/fK9uS1/rXfluZZonJ66w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780622653; c=relaxed/simple;
	bh=wUXquFQuBDYMZICYnLQmQNv1jv/HaB9bdKctPiDDt8E=;
	h=Date:From:To:Cc:Subject:Message-ID; b=LhZtzuU14cFtgoi4fJmd9HeFrj6jNc25PLgU7+DWNDfb6vDKaOrlOqgcF0srsJWWIVvzCfNyofRMuEinEOsRJpl3DB8EdlStjZvBHTiR1lrHO7TaXhrEyL+UkgydRdtp2Nfr8gl1+LtREW1fsCc7VNCkwg+xUK7TxHL0CMFa1YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=idbV6Klq; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="idbV6Klq"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C175A40142
	for <virtualization@lists.linux-foundation.org>; Fri,  5 Jun 2026 01:24:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -8.092
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id z0RNIYLVFlAx for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Jun 2026 01:24:07 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.9; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org E894F4013E
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E894F4013E
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=idbV6Klq
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E894F4013E
	for <virtualization@lists.linux-foundation.org>; Fri,  5 Jun 2026 01:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780622647; x=1812158647;
  h=date:from:to:cc:subject:message-id;
  bh=wUXquFQuBDYMZICYnLQmQNv1jv/HaB9bdKctPiDDt8E=;
  b=idbV6KlqF9+ORg7u2ad7AwLsPOJGs/cre1PEBzg9jL501NKWh41XcfpQ
   7W4mEe520sWbE+EPsSHYVLS2I28vXr5PU3RzKW9jFlbEEsircN7eG+wEH
   r5+XqrRbghK9GeGZ5u6ClIQBzR/u3IlglGCrO2nK9djyi96NvrqSpKfE5
   wngupn1hqT374YdujATmxbEBSz9U7ySnWPBPHagiKHgdyBoKLzaetZIgc
   MzmHh6O5c10Ohsh/s8/EoCUJgVVRl34CiiNPdOoeT+YCeBLpvzvuOFM0x
   vGtAATcjrhcnZCpdlV3fatkKeqJ3koZWEnmM2dpyS8jK/jdmnDQ+TvkmI
   Q==;
X-CSE-ConnectionGUID: A85UuJ9JQ7+zH5FRM95Utg==
X-CSE-MsgGUID: OsPBN1ySQA+QwsjBHRhcNQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="92142077"
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; 
   d="scan'208";a="92142077"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 18:24:05 -0700
X-CSE-ConnectionGUID: uF5IaECnRIOofeg8SgIBIg==
X-CSE-MsgGUID: SZZHOVVQTCOmJU6YGz8JJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; 
   d="scan'208";a="240516094"
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 04 Jun 2026 18:24:03 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wVJI0-00000000FQW-1P2q;
	Fri, 05 Jun 2026 01:24:00 +0000
Date: Fri, 05 Jun 2026 09:23:40 +0800
From: kernel test robot <lkp@intel.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
 netdev@vger.kernel.org
Subject: [mst-vhost:balloon 12/38] ld.lld: error: undefined symbol:
 folio_zero_user
Message-ID: <202606050942.HHhnHpHF-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

Hi Michael,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git balloon
head:   b145636d693114d343a0a47a4400f5b31e211fec
commit: c4af912c65bc897b31264a3403f18b0cf52fa10c [12/38] mm: use folio_zero_user for user pages in post_alloc_hook
config: arm-allnoconfig (https://download.01.org/0day-ci/archive/20260605/202606050942.HHhnHpHF-lkp@intel.com/config)
compiler: clang version 23.0.0git (https://github.com/llvm/llvm-project 7917772d7d61384696c61102c08c2ea158e610fa)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260605/202606050942.HHhnHpHF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202606050942.HHhnHpHF-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: folio_zero_user
   >>> referenced by page_alloc.c
   >>>               mm/page_alloc.o:(post_alloc_hook) in archive vmlinux.a
   >>> referenced by page_alloc.c
   >>>               mm/page_alloc.o:(get_page_from_freelist) in archive vmlinux.a

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
