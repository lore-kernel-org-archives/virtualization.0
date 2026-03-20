Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961D32E54AA
	for <virtualization@lists.linux.dev>; Fri, 20 Mar 2026 19:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774033414; cv=none; b=qYWmYcSfykZO+gXv7MX/6/sOdidH0LV3tkvrozR1VfjSG2O22WnMcjw7Z/dSEB1vWFLBFljZew0jXJAyOuk1PNckSKANf6QhBZpSHeIwKfLC09Wu134CuWUM5DIA1aLbmqbBMNEbs+G+XjlyaF0fiGBFtxba1yrZvPtGarp3728=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774033414; c=relaxed/simple;
	bh=UFkiLxF9Zc3JS/WRCX9/gSz+zSlR0T60OhYjiAyMjAU=;
	h=Subject:To:Cc:From:Date:Message-Id; b=bB2FdK5OaRAEZ1VsFeyV9EqcLEcfsHgVbfn3VERM6zF5PbBiY33msXzVQYosg7rgM6uXZP9Mf1hjlbznpux0l4N/PQI1AGN1CcdDL4nZZLsiBux2A94H0txn9bAiUQzfuJGa3YOigFAIuhVsok/2ijMl5bLyZtEqzGT6HvjLhDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lxbCo6gM; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lxbCo6gM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774033412; x=1805569412;
  h=subject:to:cc:from:date:message-id;
  bh=UFkiLxF9Zc3JS/WRCX9/gSz+zSlR0T60OhYjiAyMjAU=;
  b=lxbCo6gM0IxHgZb5zvd7z2VFP6NKrOIxI0v6dgxjVrO4sGD1loiGpNjv
   AFkQIZc7vPyMUfPZuYpfQUnm/yOCQZC0SpWiHH+EKyNpdQwF0+SvzQ9Ey
   2WE0YCM6NzjJJmUCzkCgdXSEQLONeWiivrPoRfemJ0sL8ftGRn04d2gEn
   sRRD3hDVGtVZHG+noaXotx5in6Uugv8WJ9i3z8iNw5VPniW1wmAnXaMId
   ASQh34mZafE+2SnoCEH7UCoFq4gYZwCaHvcDgQVdHKPlha8H8siJFhNb9
   sQjXhoIIvCAXffNIOODnd1zi9DMveuvYbkgzPurWE0uKFz0MX31IRku7d
   w==;
X-CSE-ConnectionGUID: KAGMe3UORFO97G0pqyyBCg==
X-CSE-MsgGUID: kkNLlwIBTrSXiNhfbUvqQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11735"; a="86200613"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="86200613"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 12:03:32 -0700
X-CSE-ConnectionGUID: EyqGdRKzRrOVxlitzd3dbg==
X-CSE-MsgGUID: J5tEOTc8Q6ut07tQNj3z1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="222597391"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by orviesa010.jf.intel.com with ESMTP; 20 Mar 2026 12:03:31 -0700
Subject: [PATCH 0/8] x86/msr: Consolidate native/paravirt MSR functions
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, Juergen Gross <jgross@suse.com>, virtualization@lists.linux.dev, Dave Hansen <dave.hansen@linux.intel.com>
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Fri, 20 Mar 2026 12:03:30 -0700
Message-Id: <20260320190330.A97C443B@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

This is old cruft, but it appears that having two copies of these
MSR functions is enabling warnings to creep in[1].

I know there's also been some work to pare down the XXL code, but
it's obviously not merged yet and this is a good baby step.

Create helpers that both paravirt and native can use in common code
and remove the paravirt implementations of the helpers. This reduces
the amount of logic that is duplicated in the paravirt code.

The other thing I really like about this is that it puts the
raw=>{native,paravirt} switch in one compact place in the code.

Conceptually:
 -   native: The bare-metal implementation. Might not be usable under
	     paravirt XXL.
 -      raw: The lowest-level function that is always usable. Might
	     be native or paravirt under the hood.
 - paravirt: Always calls the paravirt code, but might end up
	     ultimately calling a native implementation version
	     through paravirt ops.

1. https://lore.kernel.org/all/20260319152210.210854-1-aldocontelk@gmail.com/

 msr.h      |  130 ++++++++++++++++++++++++++++++++-----------------------------
 paravirt.h |   44 --------------------
 2 files changed, 71 insertions(+), 103 deletions(-)
