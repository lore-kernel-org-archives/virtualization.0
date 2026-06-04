Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5B24279F9
	for <virtualization@lists.linux-foundation.org>; Thu,  4 Jun 2026 16:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780591926; cv=none; b=csuBJdfDHr5PTSN0+MSty2YJhAOPFw4+XI8Z90SUjzBHRENRd84xfFbGy+EZHFxfPkElKxM7ohFQmsEcT6IqQawhorwmOXTosKg768ZKPCEjCtdqWXDXAXOa+jlqp4Z9z2QLIrf08g7Q5eyZBGZS8sxEjGdAl8Oq8YGgBJCJ240=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780591926; c=relaxed/simple;
	bh=bGekkKMrvCJEuovAEAIlT2J2j0aiywvMyBg8Z6i9Vzs=;
	h=Date:From:To:Cc:Subject:Message-ID; b=mRCNQlc9+vffJEFiR1QieJFj1HaUy6r8TFjkQNBbCetgRL0eAKN3bjk0ifrzLFTE0Ng5C7FcHh3m9R1uBaHw/kjLYCeR0l7dnCB0Y5sWe4OcfmJhhvTQAWtobNae8xSAWO7MxTv3WiEjsU61ZoTMREfW8imv3WA2vXwyJFVaS+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C3OtQ6xv; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C3OtQ6xv"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 478894ADD2
	for <virtualization@lists.linux-foundation.org>; Thu,  4 Jun 2026 16:52:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -8.092
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fxCG-zBFo65T for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Jun 2026 16:52:04 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.9; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 1CCAE4AD3F
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1CCAE4AD3F
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=C3OtQ6xv
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1CCAE4AD3F
	for <virtualization@lists.linux-foundation.org>; Thu,  4 Jun 2026 16:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780591924; x=1812127924;
  h=date:from:to:cc:subject:message-id;
  bh=bGekkKMrvCJEuovAEAIlT2J2j0aiywvMyBg8Z6i9Vzs=;
  b=C3OtQ6xvwJxSrkD5FqhXd+ADpBtHUm0h3E6bdB5QhYK9aFcwrIEosKX3
   d+eh4ro4SYyW70IRRzXDGpd/FwuDiePK0RNLMFIp4wK9O2d/K25fW6khk
   eXZO6D4xQBmWkmPLTEB2R5g4nzyyFjK7wPclI6czMYty/Oy6bsRWgim2x
   LRzSlCJISHXkq76CKR1TszLMjKYvcsdSYYZKLSSOmZ/9DKP1pIBf7bKws
   6eETe4N4mny2g8zHPvaKi1LgCuBdxT+71bh8nj5j91eyC1Z2Hfu88UFQx
   QzeHKtt1e7ARFv0XEYakK4ZIvD/qkxsTOSoN96oKv76qW0H0xnZ1XHD0H
   g==;
X-CSE-ConnectionGUID: VDayEgNoTPKQ1NYUWknwDg==
X-CSE-MsgGUID: tVsBzIfnTf2LY6vMCwt0Ig==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="92106472"
X-IronPort-AV: E=Sophos;i="6.24,187,1774335600"; 
   d="scan'208";a="92106472"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 09:52:03 -0700
X-CSE-ConnectionGUID: BEgr8ZQkSpu+xFIcKwRHeA==
X-CSE-MsgGUID: /48/aHS1TOy2K90wato3CA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,187,1774335600"; 
   d="scan'208";a="238251939"
Received: from igk-lkp-server01.igk.intel.com (HELO 892db79562d4) ([10.211.93.152])
  by fmviesa009.fm.intel.com with ESMTP; 04 Jun 2026 09:52:01 -0700
Received: from kbuild by 892db79562d4 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wVBIV-000000002MH-2epl;
	Thu, 04 Jun 2026 16:51:59 +0000
Date: Thu, 04 Jun 2026 18:51:45 +0200
From: kernel test robot <lkp@intel.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
 netdev@vger.kernel.org
Subject: [mst-vhost:balloon 8/38] Warning: mm/page_alloc.c:7002
 function parameter 'user_addr' not described in '__alloc_contig_frozen_range'
Message-ID: <202606041824.6UhiUn3N-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

Hi Michael,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git balloon
head:   ffd91da19b20a15bbcff7438ef1ad0031c110395
commit: c2b251ca61f1a3911a1c9ea9d1a5511a4da1aa1c [8/38] mm: add alloc_contig_frozen_pages_user for cache-friendly zeroing
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20260604/202606041824.6UhiUn3N-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project f43d6834093b19baf79beda8c0337ab020ac5f17)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260604/202606041824.6UhiUn3N-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202606041824.6UhiUn3N-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: mm/page_alloc.c:7002 function parameter 'user_addr' not described in '__alloc_contig_frozen_range'
>> Warning: mm/page_alloc.c:7002 expecting prototype for alloc_contig_frozen_range(). Prototype was for __alloc_contig_frozen_range() instead
>> Warning: mm/page_alloc.c:7266 function parameter 'user_addr' not described in 'alloc_contig_frozen_pages_user'
>> Warning: mm/page_alloc.c:7266 expecting prototype for alloc_contig_frozen_pages(). Prototype was for alloc_contig_frozen_pages_user() instead

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
