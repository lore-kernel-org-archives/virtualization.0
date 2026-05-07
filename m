Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC28334572F
	for <virtualization@lists.linux-foundation.org>; Thu,  7 May 2026 21:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778189204; cv=none; b=b7QW4MLOZrcW97+MN1GuYtMXU6qiQwOV01euDFOr4ehekpptjnbcIXXNoA9T5bH2d9fNDXQKcNASX/+B4B6BZ4KNiHCu3Y6wKMDMI5ECrlkPmldeHEmxniC4tfAoqD/fSIzOIEk2c5JuIDfxTLX/QP81bHdOxxqV5Wlo/IG4HmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778189204; c=relaxed/simple;
	bh=rVWiIO8GAMs4uV1pDYNtDWy1Here0ynutD/CS72c9WA=;
	h=Date:From:To:Cc:Subject:Message-ID; b=p33ltvtZCqsMlKQIH8B1LwK21GmyZDXlgIr/EDnxxsKsDS9odPpE0HDIkDA0m5WCyJ2UZ98UZBLX2ki61bI7cJfOxE59xodAS/8qSmTuoqwdlH4M4nzamXmiTZ7aAt2JQD0lD7BeQ8pypLHdd8TQNZAQCIFG9ZDzMe4fL9mzHKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sm9OB44X; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sm9OB44X"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A2DF140869
	for <virtualization@lists.linux-foundation.org>; Thu,  7 May 2026 21:26:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -8.092
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id i6d-BR2pZvW7 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 May 2026 21:26:42 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.12; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 8C99640874
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8C99640874
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Sm9OB44X
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8C99640874
	for <virtualization@lists.linux-foundation.org>; Thu,  7 May 2026 21:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778189202; x=1809725202;
  h=date:from:to:cc:subject:message-id;
  bh=rVWiIO8GAMs4uV1pDYNtDWy1Here0ynutD/CS72c9WA=;
  b=Sm9OB44XJ/sM1QkQqs/4cRNg96A083WYc8tOy1YfyKcDuGiqz81u9LBt
   Dhw1kJOkPi6DKQV/tPi6wsQGvX5Tb/VcGWzn/9JOTJdphvZLMC5lCE5BN
   vYOIba91gj4DQAdNQWOv4AsZ6fQxGTVxIFxFGkwtPkRmH71xHu3x2NFXG
   AFvDke6qYZpT8G2/01tYPfqm8jkbtZ5QwxFGEIvHNezfWBzC/Mr4+8Gcd
   ZiZkev4N78QroGPQv/XNrCz/l4sUHVCKU+f3rQJZr56acuAqu29gTyQ9W
   EVaEyY9r0e1XM3jzREcnAwn/p1KvkN6/dDr4hEkczFiuqPxdsEgvgdXsY
   g==;
X-CSE-ConnectionGUID: GM75RzepR7mE3n4t9LqCVQ==
X-CSE-MsgGUID: dx3xeCmSR3GcLDVoiatC7Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="90613775"
X-IronPort-AV: E=Sophos;i="6.23,222,1770624000"; 
   d="scan'208";a="90613775"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 14:26:41 -0700
X-CSE-ConnectionGUID: HAElt25yRx6Li1dwiHrElw==
X-CSE-MsgGUID: hOQETuFEQCuChI65WnJS2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,222,1770624000"; 
   d="scan'208";a="232033842"
Received: from lkp-server01.sh.intel.com (HELO d6e19f2f5857) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 07 May 2026 14:26:39 -0700
Received: from kbuild by d6e19f2f5857 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wL6Ev-000000000SH-0PAu;
	Thu, 07 May 2026 21:26:37 +0000
Date: Fri, 08 May 2026 05:26:30 +0800
From: kernel test robot <lkp@intel.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: [mst-vhost:balloon 6/30] Warning: mm/mempolicy.c:2444
 function parameter 'user_addr' not described in '__alloc_pages_mpol'
Message-ID: <202605080515.6jRN5wN7-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git balloon
head:   9f56ee36fbf6a6d336dc6a9eaeb4f8a67cb42a31
commit: c4289f5a4e563611a468b4b5379025a4aa4a7c12 [6/30] mm: thread user_addr through page allocator for cache-friendly zeroing
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20260508/202605080515.6jRN5wN7-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260508/202605080515.6jRN5wN7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605080515.6jRN5wN7-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: mm/mempolicy.c:2444 function parameter 'user_addr' not described in '__alloc_pages_mpol'
>> Warning: mm/mempolicy.c:2444 expecting prototype for alloc_pages_mpol(). Prototype was for __alloc_pages_mpol() instead
   Warning: mm/mempolicy.c:2547 expecting prototype for vma_alloc_folio(). Prototype was for alloc_frozen_pages() instead

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
