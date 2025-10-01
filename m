Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892321E51D;
	Wed,  1 Oct 2025 06:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759301155; cv=none; b=DgBRyw+Wxg73WHirzDGoACLyXsbfALyZ7ZxdQi8X5Me0yelJFfVT/dmWztpFs2M4OPc5Hp1WF3zj/7O9XQhukIJ9bGnm/GSYmt6HScbcb+nBi8Lek1EZ+VcyzRlMN1Z8SwIH1YZy6KS6No3tQvXMFWA/u7Ep16p2Mb43nn9BOhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759301155; c=relaxed/simple;
	bh=Y/Pb3ZsXpGtWxgMb4jYwafxc5+5/erePtqreRVuB9X0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jK6syxzQE4YgCM+7aRMjlVSUt5+ytPANNF5f9BNJsb019uoR150UT50yzveVZhlaA6SYVPbay2RO2263tpH9W+jY2KE9Y/N+a8nI94Oa8jrYDuZ2wa5M9wNtpVQr5W293BYSJCYrYmVEVQYTkmuIUw7RFeTSgsnGhB01y0trVdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RJ+2xvWr; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RJ+2xvWr"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=QjlhTp+r7CWvr2hwonpt0lAiAd5bdRhkMYmYsK0uFOs=; b=RJ+2xvWrMWoKdKQyz+zpdd5gfJ
	YhYsbT3i08QHxLvo48Rr7myLVjUOOcBD0uqkDLR8AAvzaG5juY/1D7D752Eyw8kA/N8kopAu3n5CR
	ujm3jRymFuWLt33m+r7DxTLCq58ekiTe2UIxiI7y2W1SaHQD9ZuQEMFf9aHwfFDXc47s2BLcC5nma
	pfLAVKbtc2Qfsh9BIh1e5F+mgm9+o+c833EZEsxQ1DjCeFJdqus4Hqx9Ds+q53OB95vT0OKpbQLM6
	wHa/o0EWQB721aW+vrNB4Ge/7KkrVae9TNO4Q+xzCFTEUygqtIEWUkL0+Bt39q8GIPfyqrViFxvE4
	5br3cvjg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3qat-00000008K4b-0YaL;
	Wed, 01 Oct 2025 06:45:44 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 552DC300212; Wed, 01 Oct 2025 08:45:43 +0200 (CEST)
Date: Wed, 1 Oct 2025 08:45:43 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: =?iso-8859-1?Q?J=FCrgen_Gro=DF?= <jgross@suse.com>,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	virtualization@lists.linux.dev, xin@zytor.com,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	xen-devel@lists.xenproject.org
Subject: Re: [PATCH v2 11/12] x86/paravirt: Don't use pv_ops vector for MSR
 access functions
Message-ID: <20251001064543.GM4067720@noisy.programming.kicks-ass.net>
References: <20250930070356.30695-1-jgross@suse.com>
 <20250930070356.30695-12-jgross@suse.com>
 <20250930083827.GI3245006@noisy.programming.kicks-ass.net>
 <1541b670-8b29-42a5-a58d-34d85197751d@suse.com>
 <20250930100404.GK4067720@noisy.programming.kicks-ass.net>
 <fefbd1ee-ab8c-465e-89bf-39cd2601fc60@suse.com>
 <d2c68cbe-2e92-4801-b1a3-af4645e9ba78@zytor.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2c68cbe-2e92-4801-b1a3-af4645e9ba78@zytor.com>

On Tue, Sep 30, 2025 at 12:49:21PM -0700, H. Peter Anvin wrote:

> /* Xen code, stub sets CF = 1 on failure */
> 
>    0:   e8 xx xx xx xx          call   asm_xen_pv_wrmsr
>    5:   73 03                   jnc    0xa
>    7:   0f 0b                   ud2
>    9:   90                      nop
>    a:
> 
> The trap point even ends up in the same place! UD2 can be any 1-, 2-, or
> 3-byte trapping instruction.

Please don't rely on flags to be retained by RET. The various
mitigations have trouble with that.
