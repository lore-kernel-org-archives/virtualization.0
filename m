Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A91E477E28
	for <virtualization@lists.linux-foundation.org>; Fri,  5 Jun 2026 07:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780643716; cv=none; b=WOor9DvDbS/wMc0rmNPOmuOe47qXDeP+mwGVy3OjdmlxqUoln6Tn3nn3yKJwTZxqWcpVJx4OH7cKpfZRYpYp0mVMxZm2H5HX0py5omOffMkKIObY2gGBEbC2XmPc+tYTWZc93O2hfEbRUwE8SAXuXy6HAFDhs9E+Uaxx6V1vamk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780643716; c=relaxed/simple;
	bh=qwyPU7ax3kVXIchgtoYzveweTq4OWKz4g0yAXFqtEr4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=nla1rXqjztrvvkue+f9ZmPQAGAkEGMf9vbCAPbnmX7XWuOKVK59KJSz7vdBMVc5kHBt+mDgthvN3yIV1hqnf6Zz/Ki9e5D6wppoxFeyUXiSIZzuVqok1lUrQbrsjigfuQ/ItTxaGJ5LepQ/A2ERPhYGi7GzLnBMWGfHmCtCjod4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GoEuc793; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GoEuc793"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4FBFF4026D
	for <virtualization@lists.linux-foundation.org>; Fri,  5 Jun 2026 07:15:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -8.092
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id c4PI2N3sKOl6 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Jun 2026 07:15:14 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.12; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 096504024B
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 096504024B
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GoEuc793
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 096504024B
	for <virtualization@lists.linux-foundation.org>; Fri,  5 Jun 2026 07:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780643714; x=1812179714;
  h=date:from:to:cc:subject:message-id;
  bh=qwyPU7ax3kVXIchgtoYzveweTq4OWKz4g0yAXFqtEr4=;
  b=GoEuc793dlmFpyRIOw6zvJ8lunWSJFDfQk2JMCkhFIOi/T2uTjjEUx7I
   gBq55i3S3T32ZX99zWbsS5ZghlQf1aZWtiUSDJxQ2/HOsgRfnwLJlfLoa
   ZiQ4yiHfZomT+zo/i6FVbZPDkSiSaVl7LM5WiP/65wXiiNU5m9ip3chvC
   MqbxZddSWRwUhJG4R6doBxXp0v3hfa+lwe8PmXnIW1xWNNRsRtCxJV8St
   eDqzGQgvEMUEn47/UuBwlz1/XQXaeHSttqTEapnWPc9zra9I9BqgWPzQD
   c1hhTcphpwxsYIhgcnykU2zQj0QQUuFsYB2p90Ryq7p/GefFZXdB86eBI
   Q==;
X-CSE-ConnectionGUID: Xpl2kbAxTvCycx2PmuZ1Og==
X-CSE-MsgGUID: Qn4NA3XRQKGVif86qSLqWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="85328556"
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; 
   d="scan'208";a="85328556"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2026 00:15:12 -0700
X-CSE-ConnectionGUID: NORpfU9wT4OGYOVtU5E0Zg==
X-CSE-MsgGUID: qI/sYgenQku/vn1+JNgt5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; 
   d="scan'208";a="249880727"
Received: from igk-lkp-server01.igk.intel.com (HELO 892db79562d4) ([10.211.93.152])
  by fmviesa005.fm.intel.com with ESMTP; 05 Jun 2026 00:15:10 -0700
Received: from kbuild by 892db79562d4 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wVOlo-000000002VH-2SH1;
	Fri, 05 Jun 2026 07:15:08 +0000
Date: Fri, 05 Jun 2026 09:15:06 +0200
From: kernel test robot <lkp@intel.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
 netdev@vger.kernel.org
Subject: [mst-vhost:balloon 8/39] Warning: mm/page_alloc.c:7270
 expecting prototype for alloc_contig_frozen_pages_user_noprof(). Prototype
 was for alloc_contig_frozen_pages_user() instead
Message-ID: <202606050959.Rsoiib9n-lkp@intel.com>
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
commit: 2edc4a8a3ed54fe5fd742e60ff3cba3b7dbd8316 [8/39] mm: add alloc_contig_frozen_pages_user for cache-friendly zeroing
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20260605/202606050959.Rsoiib9n-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project f43d6834093b19baf79beda8c0337ab020ac5f17)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260605/202606050959.Rsoiib9n-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202606050959.Rsoiib9n-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: mm/page_alloc.c:7270 expecting prototype for alloc_contig_frozen_pages_user_noprof(). Prototype was for alloc_contig_frozen_pages_user() instead

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
