Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC6A421EF4
	for <virtualization@lists.linux.dev>; Wed, 29 Apr 2026 18:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777488324; cv=none; b=S/6Mj8Z+pY13pD37yJFyCEVwFCwISisBCePsBR23d3Q2EFWQLDfo8Qh1HTdgd/jbwcVHVDTQMXWTDppMP4gUvWRosLFYrq3hVN/b+XWE/xfRWbpHW16PbNsb5lfyFGjZESc8oTwgkSYAI8YgPbBA0qPhmoaWdFOaQn/j8VrjNuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777488324; c=relaxed/simple;
	bh=yfoPAlMWGvTLaKKgzYaykHL4yOH6EvBpOfxQ4tQ+Jmw=;
	h=Subject:To:Cc:From:Date:Message-Id; b=Z8gTlEazbyRNrkT2EorjgDyBW8apBc0s5sq7ie94FaCd5ONulS8AaDRoWeOSwHuVa5DkrL5VVBksy5LOUTRBwPkjZGZjO8pVAWq6l2Z5cH0cNyPTPbJsWcKSL5UIWqVLMSeIbYxgSZAT4m9rxpF5qPa6SKPktmWgLKnMXk2AYGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nm23u0CN; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nm23u0CN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777488320; x=1809024320;
  h=subject:to:cc:from:date:message-id;
  bh=yfoPAlMWGvTLaKKgzYaykHL4yOH6EvBpOfxQ4tQ+Jmw=;
  b=nm23u0CN+MceOecubOi5J41GstagXq1tOZhDjAwdVKez0yh4siAu942Q
   61MUKE+2V9sBE5BSHVBj5eO767NBPXIWVn1KscqDdyTsWnxJbxw6KZqzC
   h58hyykbwQ4A84QDJGHRfgIK0+KvS12NcvtP9q6/5gzQD8Pwpn0y34YES
   +AiJbFiI6Nc8cjqQFnPptAvR+G7OboCrhjwIDPk/UBADxa8pnwtXfuww7
   20RW9g5SqQkdscclPYibR+TieuEWButjrf7yg12aO0+UFzcowl/KDyaJU
   vhvCu5YqezNkJ2S+vYxjmFqvVDTii3losE1GOyTmBH2bsDBSCumfb1BYU
   Q==;
X-CSE-ConnectionGUID: yCgfZa9CSoalzHKxz22KqA==
X-CSE-MsgGUID: xrSCW0yEQwCBmQkEVcWyIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="78322255"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="78322255"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 11:45:18 -0700
X-CSE-ConnectionGUID: nAMkgiIwS52EGALqIzVdew==
X-CSE-MsgGUID: H8oUJwY1TyuxGhXWwiSPzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="229749543"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by fmviesa006.fm.intel.com with ESMTP; 29 Apr 2026 11:45:18 -0700
Subject: [PATCH v2 0/8] x86/msr: Consolidate native/paravirt MSR functions
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, Juergen Gross <jgross@suse.com>, virtualization@lists.linux.dev, Dave Hansen <dave.hansen@linux.intel.com>
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Wed, 29 Apr 2026 11:45:17 -0700
Message-Id: <20260429184517.7E078510@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

Changes from v1:
 - Remove "raw_" names. Just use "paravirt_" in the generic code.

I'm thinking I'll just apply this in the coming days if nobody
screams too loudly.

--

This is old cruft, but it appears that having two copies of these
MSR functions is enabling warnings to creep in[1].

I know there's also been some work to pare down the XXL code, but
it's obviously not merged yet and this is a good baby step.

Create helpers that both paravirt and native can use in common code
and remove the paravirt implementations of the helpers. This reduces
the amount of logic that is duplicated in the paravirt code.

The wonky thing about this solution is that it has the common code
always make literal "paravirt_" calls, even when paravirt is not in
use for MSRs. In that case, the calls just go directly to the
"native_" functions via #defines.

Conceptually:
 -   native: The bare-metal implementation. Might not be usable under
	     paravirt XXL.
 - paravirt: Call the native version directly if paravirt is compiled
 	     out. Call into paravirt ops when available, which might
	     ultimately call a native implementation.

1. https://lore.kernel.org/all/20260319152210.210854-1-aldocontelk@gmail.com/

 msr.h      |  124 +++++++++++++++++++++++++++++++------------------------------
 paravirt.h |   44 ---------------------
 2 files changed, 65 insertions(+), 103 deletions(-)
