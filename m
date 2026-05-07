Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF752481664
	for <virtualization@lists.linux-foundation.org>; Thu,  7 May 2026 19:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778183862; cv=none; b=qqgOGXzTCfyBvYeCUqkgf4RuYED0KE0gc1bf6zdVKTpBQbDfmBwvP8sKk7N28Gt9ln23Kn4v4o9fv1JYCFNvsBRYqnwLVi8fM+udsmjKfwnyHwejBzhFiynYNCn83brHNNKh9Si0RxZLqGS3HA8c5ssT9viVHWIJ8NES+bdyY1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778183862; c=relaxed/simple;
	bh=FM3JyjULX1lnlZXdQ5PBZlEcLXNCfI0RfxPxmmxvNMg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=JKorwBKaHchwhpjBqTTuCZcjn/wCLUrhVH1L6WH9uJGAFrSLYqO7g6kEHC/p6BuDFCfFtgs5DzaqT5rF5mSSB2QiPgzYuLn+PQE7dO6V8zNm9jHlQwXXjx17NsAOCZzrpUWeXw5whkK7NJDfDspinaHVIzVUenX0vKAoFFU/jnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D8LIwPDG; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D8LIwPDG"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AC72441211
	for <virtualization@lists.linux-foundation.org>; Thu,  7 May 2026 19:57:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -8.092
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tOq5GQviruAF for <virtualization@lists.linux-foundation.org>;
 Thu,  7 May 2026 19:57:41 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.9; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org D2E8E4120F
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D2E8E4120F
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=D8LIwPDG
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D2E8E4120F
	for <virtualization@lists.linux-foundation.org>; Thu,  7 May 2026 19:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778183861; x=1809719861;
  h=date:from:to:cc:subject:message-id;
  bh=FM3JyjULX1lnlZXdQ5PBZlEcLXNCfI0RfxPxmmxvNMg=;
  b=D8LIwPDGQTu5KObbo2/SXPEQzHbNYDcW4KeF5LPFO8kmYmm0xuapfdd6
   4Ue68QR0Mlv0e2lxzKmiAul3t616nW7/TX1HMTXn8AbH4HHnMwBiFf7L/
   9IPXWokSHzwZ2RTm+TyaH4VEGZDKcr860zfl3RkrxVpS9pBFAAlc82ZjC
   23408aEz1S9R9jZYXa6ZN6/nlutH1VXhJgtAXlYqaSjJxm9shoUhYighw
   uIqPA8b+du2qjzWiauV4EUNbkJUusKb6ejr3zlrKmtGi56LiAwV7YYtcG
   pH8EiCOx/bdoGxkAshbNKr6ZevNf8nQzMV7MAhs6hSAevHaq1qM0cJXmR
   Q==;
X-CSE-ConnectionGUID: jrNDxYuCRXueAyH4sEWDLw==
X-CSE-MsgGUID: K8Xe1SS+SdOGmb75Wj1ydA==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="89843717"
X-IronPort-AV: E=Sophos;i="6.23,222,1770624000"; 
   d="scan'208";a="89843717"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 12:57:39 -0700
X-CSE-ConnectionGUID: I+tRP0nlSeq5mV0tNF4FlQ==
X-CSE-MsgGUID: 217bik8QQIKLZ+7A8FhSDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,222,1770624000"; 
   d="scan'208";a="240549811"
Received: from lkp-server01.sh.intel.com (HELO d6e19f2f5857) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 07 May 2026 12:57:37 -0700
Received: from kbuild by d6e19f2f5857 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wL4ql-000000000Pd-0Exh;
	Thu, 07 May 2026 19:57:35 +0000
Date: Fri, 08 May 2026 03:56:56 +0800
From: kernel test robot <lkp@intel.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: [mst-vhost:balloon 4/30] Warning: mm/mempolicy.c:2527
 expecting prototype for vma_alloc_folio(). Prototype was for
 alloc_frozen_pages() instead
Message-ID: <202605080331.y1eIdVUC-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git balloon
head:   9f56ee36fbf6a6d336dc6a9eaeb4f8a67cb42a31
commit: 95744e0e9c4df79c6bc8ec96306b29c7a8e8984e [4/30] mm: move vma_alloc_folio to page_alloc.c
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20260508/202605080331.y1eIdVUC-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260508/202605080331.y1eIdVUC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605080331.y1eIdVUC-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: mm/mempolicy.c:2527 expecting prototype for vma_alloc_folio(). Prototype was for alloc_frozen_pages() instead

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
