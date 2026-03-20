Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F633D525E
	for <virtualization@lists.linux.dev>; Fri, 20 Mar 2026 23:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774049620; cv=none; b=meqnAisPMD+eG513Xok79lLIGPvLUod2+lwL6eMc7LGGWKCKSramzBiM6LuKyiqDuKqFrTtFlNbrpPn3sx4OS66sEkx8qM//PGEtoJ1sC/54Ju1x/VyBHeYXArlwpb0vz3knuBA6dto5K0SbKKIkgBovCKKE47uPtERmbZdt2hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774049620; c=relaxed/simple;
	bh=rqhZThSAvANi8Wzpr/tlg28LWuU7yQ6pWGFw2wVgZng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PR8dz9mie9Y80jftc+0SiR168PKvrfZwjkl0P/eDH5umPASWisdfyPLxpOK+0VDAeZFlxCkBZZh0gWl2frMFRWi3V5aRwfpPkJwRwmwdAUT98joAW4B2g6kSd4iNHp1ghJPegSmhVyY7aIA2w3bwNCX0vuaMwH5SXdNJfLUyX1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=hbpPSGXY; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="hbpPSGXY"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id EAF6240E024F;
	Fri, 20 Mar 2026 23:33:35 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Z9RCNSCaR3VI; Fri, 20 Mar 2026 23:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1774049612; bh=Lm59eDhBHTh0aZIGi00wWM5W6hHWXDijAWIjPsnWC6w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hbpPSGXYTmFp43N/CRisT8wzMRlrV7ejtukLtdVOwy4Y07Xhc9iqdlOYwB0OWyNfK
	 t0UEp8hY/OEUfSw9dUTpdSFwYhCyi7lCJ13P5v4X3CciVH9k4Qhz7GRKpRvEFukIDG
	 ELh8rkEn9SuCPE+R4bwx/dN9lBwdKGz0NQsGfxKYh6S+S2r/gZj2xvpHDrDHVlfAvD
	 kIkUAVjPYk1vxwe9bpv6rOx876It/rYt0ro2KT2GxDOPh9LvBl+Q9B7MdAE5gZSDnk
	 ofMIrLkAF7mYvm1VbO8SzPRU2uBvvAoQM2416KcFlOzMV6gv8oFuf5PD2gykCNdzcE
	 Qlv0WHxPnXg9bBX6ElEKs3XTQ3lgiq5858I23dYT0V6Jjp1TOlU4fmK62mYUkhW+mb
	 CMuLpy6tNnKa+lmz7ZSCTR3XzhellgWNmU1Mdneqk9z4YqoHXd1j4X7CyA4VZ4CoSh
	 3YgCLIZf71GinZkPbGcXylG7k9O3JzaNv+JF5kDqFuGtlxKOfsuXRbNp3y0eAMHtdI
	 tVnrDfmRuzZ8qRBWyNoc62ZV8wW/d3RnUuLLNzZOQ2t3m4JnS/ultzryXoKl+hKrnN
	 ZDWJVPEZesuxrmB3ZDZpDYt28i10qxVLOQ8FNLNUGgursI4M5fA/jKNkPeA+KenCxG
	 L74qOqBfD7uTPe4aRkuz3vYw=
Received: from zn.tnic (p5de8e020.dip0.t-ipconnect.de [93.232.224.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 691E240E019D;
	Fri, 20 Mar 2026 23:33:25 +0000 (UTC)
Date: Sat, 21 Mar 2026 00:33:19 +0100
From: Borislav Petkov <bp@alien8.de>
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
	Juergen Gross <jgross@suse.com>, virtualization@lists.linux.dev
Subject: Re: [PATCH 0/8] x86/msr: Consolidate native/paravirt MSR functions
Message-ID: <20260320233319.GZab3ZP1lTfxOmQ4YF@fat_crate.local>
References: <20260320190330.A97C443B@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260320190330.A97C443B@davehans-spike.ostc.intel.com>

On Fri, Mar 20, 2026 at 12:03:30PM -0700, Dave Hansen wrote:
> This is old cruft, but it appears that having two copies of these
> MSR functions is enabling warnings to creep in[1].
> 
> I know there's also been some work to pare down the XXL code, but
> it's obviously not merged yet and this is a good baby step.
> 
> Create helpers that both paravirt and native can use in common code
> and remove the paravirt implementations of the helpers. This reduces
> the amount of logic that is duplicated in the paravirt code.
> 
> The other thing I really like about this is that it puts the
> raw=>{native,paravirt} switch in one compact place in the code.
> 
> Conceptually:
>  -   native: The bare-metal implementation. Might not be usable under
> 	     paravirt XXL.
>  -      raw: The lowest-level function that is always usable. Might
> 	     be native or paravirt under the hood.

I went through the patchset twice and I kinda get what you're trying to do but
the "raw" thing is confusing as hell.

To me "raw" means, the lowest level of the functionality - something like
__<function_name> with the two underscores. Or three, depending on the
indirection levels.

And those do *only* *raw* instructions - no more indirections.

But then how can "raw" be the lowest level and then still have something else
underneath - native_ and paravirt_?

I *think* this is only a naming issue and with "raw_" you probably wanna say
"native_or_paravirt_" depending on the ifdeffery... but shorter...

If so, I wouldn't call it "raw". I'd say

xx_read_msr()
xx_write_msr()

to denote that the "xx" resolves to either of the two types. But a better
name. I can't think of a good one now but I know that "raw" isn't it...

Hmmm.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
