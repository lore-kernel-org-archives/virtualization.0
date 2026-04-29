Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5685142314D
	for <virtualization@lists.linux.dev>; Wed, 29 Apr 2026 18:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777488334; cv=none; b=YvKAK49jIXhgSENHsc8vLD5TODMfF2ehEveB3RFXBuHwe0Nw1/a/iK4ijo2YTlY1ISV+8cZAjvSjr729ZZmpKYnLJ1mn87TZttmhwBlzbrMdpU113yjO2UeHPIyaVOvCWZDD7rGlJqh5cOJ1uptPDxYzGPc83zrVsCqSeAJETEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777488334; c=relaxed/simple;
	bh=dhcNJDDi3zQS9Nk/E4umfgiUZ3RFntrTQSozkeTfCIs=;
	h=Subject:To:Cc:From:Date:References:In-Reply-To:Message-Id; b=lJGdFQDu5e7mz8fC8mmQw21b9QUgst5/ZxEamL442fxoikQB7IBz4AHNQ3riLLWcZ+EwN01g65+7PCvapKbajh3DTKoY9KtvWnERQ8Qo7LTF4XmViA9zB0qeO/EfOXPEHeVC86dgyIlc7Sv3qRKovdiH831miFDxnkN93JSaQHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HuxxFfrE; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HuxxFfrE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777488331; x=1809024331;
  h=subject:to:cc:from:date:references:in-reply-to:
   message-id;
  bh=dhcNJDDi3zQS9Nk/E4umfgiUZ3RFntrTQSozkeTfCIs=;
  b=HuxxFfrEikC8BLKaTjeMOc6wfz1Sj3ow2gQ2RRoTGUhmLaW1xsrYo28U
   /m2xV8CXkOH3CnA5N5G1mLKEsFr3+trOzy2s1Ys7tDd+0APXarJihIpkD
   x5HPXu4Sf89lYHQVt+/CYaukzezTktjyph8PTjDg+S5HuZJvBmWh2k2wS
   3UQseFb9bJjtTpsfWR845eKiZOhWPoobcQcXIF5wekrBm/tXlTlyDjXO7
   UuJDO0TfWL0cvlUEE2pMl4PAoAHKfJQisozU040Q2AM7KnfeL5uDiKw0P
   7r0O7yk3kJp8UmNcOE9SCk682HDRnJQbC9p3JGhbePPAvbeGH8o0Pfqad
   A==;
X-CSE-ConnectionGUID: P324TwlARuuztn9CHOGw6w==
X-CSE-MsgGUID: AJNQrg9lQHWQv4PEusvYbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="78322309"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="78322309"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 11:45:31 -0700
X-CSE-ConnectionGUID: jDYROiRVRFS1dReNxcCN5w==
X-CSE-MsgGUID: +liPkOrQRZe+A4sdhMUsfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="229749686"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by fmviesa006.fm.intel.com with ESMTP; 29 Apr 2026 11:45:31 -0700
Subject: [PATCH v2 8/8] x86/msr: Remove duplicate #include
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, Juergen Gross <jgross@suse.com>, virtualization@lists.linux.dev, Dave Hansen <dave.hansen@linux.intel.com>
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Wed, 29 Apr 2026 11:45:30 -0700
References: <20260429184517.7E078510@davehans-spike.ostc.intel.com>
In-Reply-To: <20260429184517.7E078510@davehans-spike.ostc.intel.com>
Message-Id: <20260429184530.9FE585E8@davehans-spike.ostc.intel.com>
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
--- a/arch/x86/include/asm/msr.h~rdmsr-dups-11	2026-04-29 11:38:57.838732405 -0700
+++ b/arch/x86/include/asm/msr.h	2026-04-29 11:38:57.841732519 -0700
@@ -172,7 +172,6 @@ static inline u64 native_read_pmc(int co
 #ifdef CONFIG_PARAVIRT_XXL
 #include <asm/paravirt.h>
 #else
-#include <linux/errno.h>
 
 /* Short-circuit the paravirt MSR infrastructure when it is disabled: */
 #define paravirt_read_msr	native_read_msr
_
