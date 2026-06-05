Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C574B3BB118
	for <virtualization@lists.linux-foundation.org>; Fri,  5 Jun 2026 06:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780639280; cv=none; b=MbCZlmQX0W8qOObjPNd3AyxEPgubHHU0+7S/uKvhLGdW/mSfPjdCnSYLp/IwksDXBl4/zR/MsapnE9Gws782tGOC+zfP9IFx+aa9qSzagVtelZDEjb1CPIekDZf1jYdT+twLYTH/+inKzzvPwzDoXR1joCQAXXjbFvdZuUJSBzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780639280; c=relaxed/simple;
	bh=pwf0wZycWIB74FEdk6ZWRdAr2lkOkJJ4eHWOmuTLt90=;
	h=Date:From:To:Cc:Subject:Message-ID; b=klfn1ghPd+UPyJKnhynFj/gUfocn0lmYgbMRPP4Yu5vso/nRynBxXLjVPYqQnqw6xtHQmRLfblRX+hWMkIZOYy+IKzMtAkpKBhw6oQqfEbOHYWYE3uE5SXEikA7OlH+fGZx/dO1cv/6YmqdJxd86EJTnWdrEGPOnXDJDbIcViXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jeCFhNRL; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jeCFhNRL"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 77D576076C
	for <virtualization@lists.linux-foundation.org>; Fri,  5 Jun 2026 06:01:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -8.092
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GKXJY_RSn9MJ for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Jun 2026 06:01:18 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.19; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 57DF4606BB
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 57DF4606BB
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jeCFhNRL
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 57DF4606BB
	for <virtualization@lists.linux-foundation.org>; Fri,  5 Jun 2026 06:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780639278; x=1812175278;
  h=date:from:to:cc:subject:message-id;
  bh=pwf0wZycWIB74FEdk6ZWRdAr2lkOkJJ4eHWOmuTLt90=;
  b=jeCFhNRLPs3CZvlmDAiM6w1oqIqj8/ujK5y5Rh4ldwsOYGwRZ9xWL6Fd
   VaPzIitpF2gKml/Fujw5xYRbw/MhLBvp0m/kht98Z5bW9aG+Fmg5CtiEC
   PkBHZDuJFkrLOVMII3He96pS9eEs6gBBQ4gWSEVlB81uCNf/+ApyMwXRi
   1Cd7kH3EJTB9v4iLXrpCKw76u1CwE2TCfsXcNEqTvW2lzALlqkkVuwNI2
   KtGuebpNW3nHTIYOPcGUAYaSawCitsKmJG9Jn768QnL2OGfM4iD/TnJDK
   uog/9lW8YXlx199XUzQUSdt1SmwVkUKEXlPqCGSTucSUmdBDXMTABKXaK
   g==;
X-CSE-ConnectionGUID: 5dqMiEhGTv2cSkA7FT4Mjw==
X-CSE-MsgGUID: x3vmdZtdS2yRkzqgpDXXVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="80508288"
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; 
   d="scan'208";a="80508288"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 23:01:18 -0700
X-CSE-ConnectionGUID: FH3mjjDCQb6yF94GuzbviA==
X-CSE-MsgGUID: 3X7qmvnbQ8qRqa0ddK/Tuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; 
   d="scan'208";a="238401965"
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 04 Jun 2026 23:01:16 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wVNcH-00000000Faw-293F;
	Fri, 05 Jun 2026 06:01:13 +0000
Date: Fri, 05 Jun 2026 14:00:32 +0800
From: kernel test robot <lkp@intel.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: [mst-vhost:balloon 12/38] page_alloc.c:undefined reference
 to `folio_zero_user'
Message-ID: <202606051337.Pac8xsTQ-lkp@intel.com>
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
config: m68k-allnoconfig (https://download.01.org/0day-ci/archive/20260605/202606051337.Pac8xsTQ-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260605/202606051337.Pac8xsTQ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202606051337.Pac8xsTQ-lkp@intel.com/

All errors (new ones prefixed by >>):

   m68k-linux-ld: mm/page_alloc.o: in function `post_alloc_hook':
>> page_alloc.c:(.text+0x3b42): undefined reference to `folio_zero_user'
   m68k-linux-ld: mm/page_alloc.o: in function `get_page_from_freelist':
   page_alloc.c:(.text+0x546a): undefined reference to `folio_zero_user'
>> m68k-linux-ld: page_alloc.c:(.text+0x550c): undefined reference to `folio_zero_user'

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
