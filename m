Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC095344052
	for <virtualization@lists.linux.dev>; Fri, 20 Mar 2026 19:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774033424; cv=none; b=CwmkEcJUNVOAUUGCCLhRjZ7PJvNaDko+16HNfHvtQKuoDQ9zoG/0snTnMCt0HmGZqwKkwEAmetbHObEeD8rtvFB68V27qaq7tLC73EQxyg3MtEbsngK7dh4g6EXtlG30PyNCLXyx+CCaGgVTiD00iFZNVaWimKv+1djmAy+xWr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774033424; c=relaxed/simple;
	bh=NrSJpQJoTzw1s8yl9H+BJteNaannQhhSlX63g3qpHWQ=;
	h=Subject:To:Cc:From:Date:References:In-Reply-To:Message-Id; b=YA9/fNNNm9Wu5cpN2M6AXWgl6TYytLFp8WUJbuZgdwh4WoKHdaHht8uUUSgA1eGBt9MiGw+XZrF07zVvWjz8P91CcoeaUTMqZFyoW/jZySIyaclrAdGMgjPIYSCWoOkQb9/BifrkauWVJHj9+qy6hB0tj3hMuzudnRy7jkywq9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QD3nWB4E; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QD3nWB4E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774033422; x=1805569422;
  h=subject:to:cc:from:date:references:in-reply-to:
   message-id;
  bh=NrSJpQJoTzw1s8yl9H+BJteNaannQhhSlX63g3qpHWQ=;
  b=QD3nWB4Ed/D6uxsnYJ5US+VD/0TAibAoKmdQGHI8YVZalraoSVWjGeY5
   vHx06e0ixABFSeXwUfZa12BCLzEJp1c2CgXJGdnsxnuH5qeLGWhTInemR
   7BIQe1I39EIBW+GXlw/aqhtPZiku0PWh5yrPEurc5WY/Lu38ERKACt6Zb
   vfkwnkjrbEp8Wu/uD3vLhi0cae2nHyKeIE7cow16md7gyxEEK6kO62tkZ
   OtVjr4+bd6QHLSf1b8YI1Q+fg8GdXVJSz7u6eoSt8mumakiqZBO4lsjxp
   RVZYCU7YqEyoXyMrubmKkr1RJmfETAiuegPVeETfRXeMhJht+K9UkRPvL
   Q==;
X-CSE-ConnectionGUID: GuQaK/mbRvOeEoeoane0Cw==
X-CSE-MsgGUID: IJeQ99evQZeC0O8R53joDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11735"; a="86200694"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="86200694"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 12:03:42 -0700
X-CSE-ConnectionGUID: C9K867gyQh2EUYbC2QWzlw==
X-CSE-MsgGUID: qCVwS6m7StaL7Z76Rw9Amg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="222597408"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by orviesa010.jf.intel.com with ESMTP; 20 Mar 2026 12:03:41 -0700
Subject: [PATCH 8/8] x86/msr: Remove duplicate #include
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, Juergen Gross <jgross@suse.com>, virtualization@lists.linux.dev, Dave Hansen <dave.hansen@linux.intel.com>
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Fri, 20 Mar 2026 12:03:41 -0700
References: <20260320190330.A97C443B@davehans-spike.ostc.intel.com>
In-Reply-To: <20260320190330.A97C443B@davehans-spike.ostc.intel.com>
Message-Id: <20260320190341.CB01C4CB@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>


From: Dave Hansen <dave.hansen@linux.intel.com>

errno.h is already included for C code at the top of the header.
Zap the duplicate.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
---

 b/arch/x86/include/asm/msr.h |    1 -
 1 file changed, 1 deletion(-)

diff -puN arch/x86/include/asm/msr.h~rdmsr-dups-11 arch/x86/include/asm/msr.h
--- a/arch/x86/include/asm/msr.h~rdmsr-dups-11	2026-03-20 11:24:22.113929469 -0700
+++ b/arch/x86/include/asm/msr.h	2026-03-20 11:24:22.116929602 -0700
@@ -179,7 +179,6 @@ static inline u64 native_read_pmc(int co
 #define raw_read_pmc		paravirt_read_pmc
 
 #else
-#include <linux/errno.h>
 
 #define raw_read_msr		native_read_msr
 #define raw_read_msr_safe	native_read_msr_safe
_
