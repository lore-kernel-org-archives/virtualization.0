Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD41F257458;
	Tue, 30 Sep 2025 08:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759221517; cv=none; b=siLv5DIZ3VO5hK5uOeX76vM9F8ec1wlxRumuvJITzkuGncIQORnyOyAqoOcpOydtSgkGfJlbFzXDT6V8cqHPobTq88NijntK9oaLZLwg4XG4VL2TrUk0winl9HC0T62KHAZTugbprN73i2UkxgtvdWU9IGpU7wG7TYI7ysi/2Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759221517; c=relaxed/simple;
	bh=fRtYOw6L4IOBcmJIpTxkJDXXzNe+WXKXx9rvPi3pXus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aRv2DEJ6r9DPZeg/PY/8I7E/EL7fj8EcwEqlgq1/7J04b63lafeioJMhnZzfb0TeOySnas1MUTFpDlXlTAlMD2RbjKRt4kR3qnJWZCwHqh7TZViLT0hdkiRWVA2qvE4s9zOJsJj4QLHpFaNbOxJmnLl2H46WQAUwPM0dgZzHMkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=C8bP7++u; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="C8bP7++u"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3jlHGCv3KKfepny4/+8UDRH2Uchjm+ncAKZLjXBzPQE=; b=C8bP7++u/b5qMJnayCP05rlwX6
	siikOCS3dkib6Z13ktiKs0qkiKKxo2bs+qW2uD3E8MRuWp0Z0O4yRe2q3dJLi4I+/62oKlQOFt6JN
	esxZ861tBA7iWNxDXxOMa/7XA5jCPzTltJyqgGOSJC+5yvI90tXMXShLvSZIWZxHilpv9ZLOj6yvu
	FeknuqLFJe3UINMVdw17fYcqyoQLLavUTX4++UMaXmTpPptEmPfIe34/71CY0kDQhWW0eHM/zmqE+
	8FjOPvfqXZJ4BLRL7ZhjGC3PpCaXO//hmkJfr/x1YOeswxG0IQYA27jtiDzRwAC535u0407ggWCUC
	1+cRSFkA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3VsR-00000007vQP-2C9S;
	Tue, 30 Sep 2025 08:38:29 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id AAEA6300328; Tue, 30 Sep 2025 10:38:27 +0200 (CEST)
Date: Tue, 30 Sep 2025 10:38:27 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Juergen Gross <jgross@suse.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	virtualization@lists.linux.dev, xin@zytor.com,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	xen-devel@lists.xenproject.org
Subject: Re: [PATCH v2 11/12] x86/paravirt: Don't use pv_ops vector for MSR
 access functions
Message-ID: <20250930083827.GI3245006@noisy.programming.kicks-ass.net>
References: <20250930070356.30695-1-jgross@suse.com>
 <20250930070356.30695-12-jgross@suse.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250930070356.30695-12-jgross@suse.com>

On Tue, Sep 30, 2025 at 09:03:55AM +0200, Juergen Gross wrote:

> +static __always_inline u64 read_msr(u32 msr)
> +{
> +	if (cpu_feature_enabled(X86_FEATURE_XENPV))
> +		return xen_read_msr(msr);
> +
> +	return native_rdmsrq(msr);
> +}
> +
> +static __always_inline int read_msr_safe(u32 msr, u64 *p)
> +{
> +	if (cpu_feature_enabled(X86_FEATURE_XENPV))
> +		return xen_read_msr_safe(msr, p);
> +
> +	return native_read_msr_safe(msr, p);
> +}
> +
> +static __always_inline void write_msr(u32 msr, u64 val)
> +{
> +	if (cpu_feature_enabled(X86_FEATURE_XENPV))
> +		xen_write_msr(msr, val);
> +	else
> +		native_wrmsrq(msr, val);
> +}
> +
> +static __always_inline int write_msr_safe(u32 msr, u64 val)
> +{
> +	if (cpu_feature_enabled(X86_FEATURE_XENPV))
> +		return xen_write_msr_safe(msr, val);
> +
> +	return native_write_msr_safe(msr, val);
> +}
> +
> +static __always_inline u64 rdpmc(int counter)
> +{
> +	if (cpu_feature_enabled(X86_FEATURE_XENPV))
> +		return xen_read_pmc(counter);
> +
> +	return native_read_pmc(counter);
> +}

Egads, didn't we just construct giant ALTERNATIVE()s for the native_
things? Why wrap that in a cpu_feature_enabled() instead of just adding
one more case to the ALTERNATIVE() ?
