Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C80E33F590
	for <virtualization@lists.linux.dev>; Fri, 20 Mar 2026 19:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774033421; cv=none; b=p18jm0tzSUtD0UAF9DLp916ZwNaYae/IocK2AmPh7Vtz/bYmOeiVdd+nNzfI48yBEo1OfRzw+zKf4Cszb0oVk+RM67YxvXWZ22zP9I5W8sEmo2X+i3E1CIYlI1VzUDfUYcqKByq9v2/mrVzcwLz6nEzmG9xO1QjngI/0asbPHyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774033421; c=relaxed/simple;
	bh=84E0UY4jkKImWdSo0I51/er2PpbEgpUpg0A5J241qJ4=;
	h=Subject:To:Cc:From:Date:References:In-Reply-To:Message-Id; b=n1+8ytkIbijPkpaEIY+PTc3PJfvrpSpfhUHWTCSN2jy06C6TsmhGQKKzqgT/+5KsSEW7GigZeaSJoy+jxG3y/ptD90GWOjaKE3WSygr3xksj11zL33owD7UrourAvE5jaivyCBGorvy/UStuWCKAk5sdaO1rC8wwai0c1GiiUcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MjZdROqK; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MjZdROqK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774033421; x=1805569421;
  h=subject:to:cc:from:date:references:in-reply-to:
   message-id;
  bh=84E0UY4jkKImWdSo0I51/er2PpbEgpUpg0A5J241qJ4=;
  b=MjZdROqK/oUuY4TXh/ORMbwZIEOxXHjs2PVab4fTMceCz0ebJgiTPzvj
   ZdF/Iqj8jhfGJnWWBN1TQPp2q2WeN1g7EFGHsVlP7zGvTH5gQgsbyXV5B
   wYKUfx25WiqaXVoZNLJa9JaXdj53Z6czNTn0Tq//wNkA89qH2tdzk9opg
   Ajv3e/ibWYon2ua13GYYpCjVIfpR3SRf8C/2vW9JZOB0UyL2vRn5VMASs
   NfMrZUIfHaI4IiZET6VEazEQ0DxlLkC8Ost+EmK8i/QvWsSxrjpkZ5Vm3
   EfIrokeXevICaS8Ldx0uOCFdKMcaafn34BbbTtyfxC6CtHZESe5AqwGbt
   g==;
X-CSE-ConnectionGUID: ca2YUyIoTiKfNKnZ1Mcw2Q==
X-CSE-MsgGUID: Gc0a7dhaSteBY8Yoh0pMcw==
X-IronPort-AV: E=McAfee;i="6800,10657,11735"; a="86200687"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="86200687"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 12:03:41 -0700
X-CSE-ConnectionGUID: PI2QS9tqRR+7BUqmu5h2zQ==
X-CSE-MsgGUID: NOAeyKsrSaKonmf0v4pk5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="222597407"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by orviesa010.jf.intel.com with ESMTP; 20 Mar 2026 12:03:40 -0700
Subject: [PATCH 7/8] x86/msr: Remove old crusty comment
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, Juergen Gross <jgross@suse.com>, virtualization@lists.linux.dev, Dave Hansen <dave.hansen@linux.intel.com>
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Fri, 20 Mar 2026 12:03:40 -0700
References: <20260320190330.A97C443B@davehans-spike.ostc.intel.com>
In-Reply-To: <20260320190330.A97C443B@davehans-spike.ostc.intel.com>
Message-Id: <20260320190340.0C7B7CA5@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>


From: Dave Hansen <dave.hansen@linux.intel.com>

I'm not sure any of this makes sense any more. The kernel only
runs on "586 and better". The comment about gcc optimization is
hopefully decades out of date too.

Really, the only reason to keep the wonky semantics where the
parameters get modified is to avoid all the churn to make them sane.
Not gcc. gcc was probably a bad reason, even back in the day because
MSRs are mostly very slow and have always been very slow. A few
extra bytes of register shuffling was probably never measurable.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
---

 b/arch/x86/include/asm/msr.h |    6 ------
 1 file changed, 6 deletions(-)

diff -puN arch/x86/include/asm/msr.h~rdmsr-dups-10 arch/x86/include/asm/msr.h
--- a/arch/x86/include/asm/msr.h~rdmsr-dups-10	2026-03-20 11:24:21.571905418 -0700
+++ b/arch/x86/include/asm/msr.h	2026-03-20 11:24:21.574905551 -0700
@@ -187,12 +187,6 @@ static inline u64 native_read_pmc(int co
 #define raw_write_msr_safe	native_write_msr_safe
 #define raw_read_pmc		native_read_pmc
 
-/*
- * Access to machine-specific registers (available on 586 and better only)
- * Note: the rd* operations modify the parameters directly (without using
- * pointer indirection), this allows gcc to optimize better
- */
-
 #endif	/* !CONFIG_PARAVIRT_XXL */
 
 /*
_
