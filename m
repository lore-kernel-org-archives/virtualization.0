Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8AF14BF85;
	Tue, 23 Jul 2024 09:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721725865; cv=none; b=EfY/GyINJ6hZCl07osuby2FCi+mzL5OfEmCyjp+kZNmxENDUAoQcX4b/QnGrc1fgA7Tei7CPmzY5AQBUkMiMePYklCH1DZ49yYG2ZkAYnLvXyEF1JhA3KiP4EM7Xm7Lz7kFSLHA6vkg8NPeVs7ypzJeYtnrknoqObJi2v/aBjmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721725865; c=relaxed/simple;
	bh=jdqjGOItlSHafyWCFvP9qk4uY7IydPMlo1p2nmTx/oE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gfpgYeRavwy5Z/5AUCowDfe410cgOJ/yelSn5NQdsNwgLvxe7Z2D+zQVYnDnG10/+atbJdFNLJGgpLwUCp2pQNV6+JpfnIgQP/RQAFNdtOKTuj9hkAixZo+kfnGlhjU7Cx9sSK1W+p604wGAeHwZyz437kJ4R41IDDyEB2S8ZQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZB+f4cmk; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZB+f4cmk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721725864; x=1753261864;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jdqjGOItlSHafyWCFvP9qk4uY7IydPMlo1p2nmTx/oE=;
  b=ZB+f4cmkuWikK6BobkP4So67uEiv5iw0M7KdeORWKjEmNNY/WI4K0C5Z
   52f5HsQYW8256raDL91XOaHdGJ/ukxkB7SF0kGgbVMtXXUtrqR/ksA+Nt
   a2LCTVjhn2wsyZp1NaRhoYki3VXaHxFpuQHoQP+ZwFRAoFoF4mkt0P7hB
   RZRVvMHGEu1yCSf5aO1L0JsAttWwNUBne7n8GMdBdNxdgebmsVVjrwNFy
   KoFKyWvBarW8rvP1YgjXqFS92HWwSk42+wmKyK66w+8FUO+zeSLCieHbW
   HvSxruS6HHhpS9KDTzigvfSGYzKlh9N/N/oLcikreq4Ua/z5KXWCt27gd
   g==;
X-CSE-ConnectionGUID: r9E/l8T/SyaVQhsed8ePwg==
X-CSE-MsgGUID: VnP1n9AUTQGRPET87JuhiA==
X-IronPort-AV: E=McAfee;i="6700,10204,11141"; a="19488153"
X-IronPort-AV: E=Sophos;i="6.09,230,1716274800"; 
   d="scan'208";a="19488153"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2024 02:11:03 -0700
X-CSE-ConnectionGUID: 5YmBeVQZRzG6jisbnUMdfw==
X-CSE-MsgGUID: A0EqHtZOSRy7qnvAPp9Nww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,230,1716274800"; 
   d="scan'208";a="52173029"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa009.jf.intel.com with ESMTP; 23 Jul 2024 02:10:57 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 1393F178; Tue, 23 Jul 2024 12:10:55 +0300 (EEST)
Date: Tue, 23 Jul 2024 12:10:55 +0300
From: "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
To: Tim Merrifield <tim.merrifield@broadcom.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>, Xin Li <xin3.li@intel.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Kai Huang <kai.huang@intel.com>, 
	Kevin Loughlin <kevinloughlin@google.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Kees Cook <kees@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Brian Gerst <brgerst@gmail.com>, linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, virtualization@lists.linux.dev, alex.james@broadcom.com, 
	doug.covelli@broadcom.com, jeffrey.sheldon@broadcom.com
Subject: Re: [PATCH 1/2] x86/tdx: Add prctl to allow userlevel TDX hypercalls
Message-ID: <wnd5rlqcus3tnmlaybbxq7v4fkdf2xyv7zhqk4euhbylecff72@evzweah55jis>
References: <cover.1720046911.git.tim.merrifield@broadcom.com>
 <90bf00599189c34e77aa77986674be2d5fc19f9c.1720046911.git.tim.merrifield@broadcom.com>
 <wufxrry6smwk25qmsajabx6vgx4vgsrbvtmun2zw4fxz3lo4b4@nfpkscueapt6>
 <20240723050431.GA10164@prme-hs2-i1009>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240723050431.GA10164@prme-hs2-i1009>

On Mon, Jul 22, 2024 at 10:04:40PM -0700, Tim Merrifield wrote:
> 
> Thanks for the review, Kirill.
> 
> On Mon, Jul 08, 2024 at 03:19:54PM +0300, Kirill A . Shutemov wrote:
> > Hm. Per-thread flag is odd. I think it should be per-process.
> 
> This is the only point I might need some clarification on. I agree
> there doesn't seem to be much value in allowing per-thread control,
> but I don't see any precedence for setting per-process flags through
> arch_prctl or similar interfaces. Am I missing something?

LAM is per-process. But it can only be enabled while the process has only
one thread and locks on second thread spawn. See MM_CONTEXT_LOCK_LAM.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
