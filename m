Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F0A3B71D5
	for <virtualization@lists.linux-foundation.org>; Fri,  5 Jun 2026 09:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780652257; cv=none; b=tKGypi/MUIlaHBOhTtRYTFBWheYa/fBH7nctj46ApIABfrHzuHbf1vzVpRIJwzdXlGAqCFOg6qP3HkMkvRtqNicmXLC8DjvR4EXnCTZXPvHTF9gzWxtQajCsMYTxlZQnfKCo6o5k9lNSUVcnZjFwpa0ELiFkqBH1Wrr96pxQAcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780652257; c=relaxed/simple;
	bh=KbOhqR/e8XwQiy3HYYMOtHP0SENwQ+y2ZWdAmV6kBpM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=dl7S7erb7jopNh8BA+E2X4ergy0AvcKsltfldLJh2rgYyrKbVgTbPuW3StpLJJBpxn7Izqmyf2BcdDgT3IodpLQZqbA/31yQ8tHK2w3v6GxZklfbWIyHjJieEsZbe/VszRYxJWc6WR5dmxzbH6GaLpx+i03iOdMpdhO25bTvf7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZYzWzVVd; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZYzWzVVd"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3996840E1D
	for <virtualization@lists.linux-foundation.org>; Fri,  5 Jun 2026 09:37:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -8.092
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sPu0USlqlU9a for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Jun 2026 09:37:35 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.18; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 2839340D55
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2839340D55
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZYzWzVVd
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2839340D55
	for <virtualization@lists.linux-foundation.org>; Fri,  5 Jun 2026 09:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780652255; x=1812188255;
  h=date:from:to:cc:subject:message-id;
  bh=KbOhqR/e8XwQiy3HYYMOtHP0SENwQ+y2ZWdAmV6kBpM=;
  b=ZYzWzVVdlGsDq/zTX4Ngv6buKYTqU/bek/vESyRc+b0CjSae0HWE3bUY
   rJw1n4s2hIW6+/Py0JWjHrwg0NGotY0s4OBd5cIi3TvzEH2YXm+ALkVbG
   bmF6qtPdWAsUnZZfs0huSpT6EQ21t3KTPBdWrZxb02scUB+GuQ5fn7e1J
   49SBMI8E5IdWChx18CJHwUtN4Qlp24mDOpoXpkB6B6Zr9FJZBuB9mkAqI
   OTbjIqVvBvXzpVCkt6AP5ImExWroixGqtlGdFe5IZ7E/2y1dwz67SuovK
   W9gFK7emCwUj2TME2zZXfE5ZdTynhTksgkRw2x6l2ylTETU5s3o9klNyZ
   g==;
X-CSE-ConnectionGUID: Oaskz2M/QOeVfiHsJPmOQA==
X-CSE-MsgGUID: FbEzaHdKQN2X1UBwC4rjow==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="81545551"
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; 
   d="scan'208";a="81545551"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2026 02:37:33 -0700
X-CSE-ConnectionGUID: kDaLCwSsSWWTZdKddjVREQ==
X-CSE-MsgGUID: UWCzhlejQfOC5W+S3DAacg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; 
   d="scan'208";a="275038652"
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 05 Jun 2026 02:37:32 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wVQzY-00000000FoQ-3KhM;
	Fri, 05 Jun 2026 09:37:28 +0000
Date: Fri, 05 Jun 2026 17:36:52 +0800
From: kernel test robot <lkp@intel.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: [mst-vhost:balloon 8/39] Warning: mm/page_alloc.c:7270
 expecting prototype for alloc_contig_frozen_pages_user_noprof(). Prototype
 was for alloc_contig_frozen_pages_user() instead
Message-ID: <202606051752.lZNueWoo-lkp@intel.com>
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
config: nios2-allnoconfig (https://download.01.org/0day-ci/archive/20260605/202606051752.lZNueWoo-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260605/202606051752.lZNueWoo-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202606051752.lZNueWoo-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: mm/page_alloc.c:7270 expecting prototype for alloc_contig_frozen_pages_user_noprof(). Prototype was for alloc_contig_frozen_pages_user() instead

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
