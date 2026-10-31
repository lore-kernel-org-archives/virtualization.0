Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=65.109.113.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793416844;
	b=I4Juv6dakkoJCFuDE5yYWdXKoHhtIgt6BvPJEv6rCIbECBy3xsFio7/uLp3p4T/7LBmy
	 BLfs7YONMdkEa9rz+nFVW3UoybVzrAwf+zD1WPxZVJp50A8j5EHkBvrTkKyW9mEVpg/xV
	 2yMA9Y8Fpzo3NcHvp2kinAp6AWwKfQls9F6JkQyJRjEOCMqKHrNEruJer0FQkkV1mRy+t
	 kzry346uiHhxvNqQ/TfoAjHzmMfbVrecQ0WCpb5/QOCXR1dOwob4EB3uQlkzFsQgoQzGj
	 Pm0FTQ+RfJuFuwP9dHKXw0hG1pTa3PaeF3YQnWQ3s534O0BtdcSBTpEw28YFrkWHHTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793416844;
	h=DMARC-Filter:Received:X-Virus-Scanned:Received:DKIM-Signature:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=Klm3BPKegCJLOq8Ks12UtrTpT08D/JxDFOWEzcnuIcA=;
	b=dZYwgRVjP3r4nkOHO2GLVG4eR8XOn2RTQbNjeYnM2uL3ql5gOdz2lxa1D5hC2XWS/Ipo
	 0gGlEqYskf9WsKAes/4vXSqy0EC1HfJ+7XdWnsoZc2fc6IKMa/l26ATcwqUbgCxFQrFrO
	 LwcNCutozKH3KTRZ0Msw5fak6Q3R36KQp/WOAAYTAbWDKJpBUEgVycsJDVAN2ld4WsW2R
	 sJ6yil7OtClWKKDrDxjBR6R+NBhWKItDXajx6Onty0g8zAyOsxLPNBk7Y2PrAxViUO46T
	 xoncGjnSrZdhFRDSTZ/wua/GrOFW/FbzSqJ0k8v2Uf9BKVR+vHu/dHX8ijkZu8jcSYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=alien8.de;
	spf=pass smtp.mailfrom=alien8.de;
	dkim=pass header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=jyPzJuiB;
	arc=none smtp.remote-ip=65.109.113.108
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C51F606A31A
	for <virtualization@lists.linux.dev>; Sat, 31 Oct 2026 03:20:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1C51F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key, unprotected) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=jyPzJuiB
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 17F2740E02B7;
	Sat, 31 Oct 2026 03:20:37 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id PLd-mWRMhp0Y; Sat, 31 Oct 2026 03:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1793416834; bh=Klm3BPKegCJLOq8Ks12UtrTpT08D/JxDFOWEzcnuIcA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jyPzJuiBOC2jtFU5He9dgn18qRO9UVk6fLepmpXLRJQxU7rYKKtv2llp/tKzckA2F
	 t7I46KhCAPpwMey1QZ053NtyuecFfTeLBFZAKvIdXftaMJkAbc8cU2inPO260+M7bG
	 5sWeQSqH84YMxJzmnL1epY6A/IXfJFtkxEmD/R4UtEPs82RVSbyjE988Q7nKIl3XFe
	 Jvd7Ob6ArF2kPpNGDvM0f3Xn9mlzTieC9RN/LfmvyBFbgN/Mza13r2+yKjVB/jym8c
	 +zG5SkVTQj5WuSthqdhXOTeqkIIGsPbgo20e7ATjZFFZsJTm91atu5E3LQiufQ6guY
	 jQo3IUvjFRMUjrslP3/FU3l5L0uAj6lmcmH2+X44VJbd1mh6XaVXX/t1LZWulvHOCM
	 zWtucKc4CwOLM84WKnvK0lIsnyXPq+6R4XCKyS+zH5rdIQdB2B4W8exD0s2ylDpB5B
	 ZmT+RDUVVKXX9XNJtXhdctDXxDFam4iyKCOkcrstDsOtiYwneJy+1Jg3w2zhkxjO0N
	 A49UV7WYEnT9I8xFVMbICyEfmHg9Zh7bGkv0MEHfaOwhCWYt6OtHYo9wH5kd14yqPV
	 RjBXouR2RTFygk5l63/E9l8d6hPPbPcm6tgXqiFoxIZNOQWneG1nBNA8zIe0nYYUMy
	 0OmRJUzw0B96jcoPxQWaMtSA=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3AD0340E016C;
	Sat, 31 Oct 2026 03:20:13 +0000 (UTC)
Date: Fri, 30 Oct 2026 20:20:09 -0700
From: Borislav Petkov <bp@alien8.de>
To: Jason Andryuk <jason.andryuk@amd.com>
Cc: Juergen Gross <jgross@suse.com>, Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	Ingo Molnar <mingo@kernel.org>, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Subject: Re: [PATCH] x86/paravirt: Add ioremap_verify_range hook and
 implement it for Xen PV
Message-ID: <20261031032009.GIauVeaXTMNHgjYEiM@fat_crate.local>
References: <20261031003309.3751-1-jason.andryuk@amd.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261031003309.3751-1-jason.andryuk@amd.com>

On Fri, Oct 30, 2026 at 08:33:08PM -0400, Jason Andryuk wrote:
> Xen PV guests update page tables via hypercalls, and Xen refuses to let a
> domain map machine frames it does not own, such as chipset MMIO in a domU.
> The set_pte() paths ignore the hypercall result, so ioremap() returns a
> mapping whose PTEs are not present.  Accessing the virtual address then
> faults.  This was seen in print_s5_reset_status_mmio() on Xen PV domUs
> on AMD Zen hosts.  The machine address is not accessible by the domU and
> faults on access.
> 
> Add a pv_mmu_ops hook, ioremap_verify_range, which __ioremap_caller()
> calls after ioremap_page_range().  It defaults to returning success.
> Xen PV implements it by walking the range with lookup_address() and
> failing if any entry is not present, making ioremap() return NULL.
> 
> This also affects a Xen PV dom0: an ioremap() of a range containing any
> page Xen refuses to map (e.g. MMIO Xen reserves for itself) now fails as
> a whole, rather than succeeding and faulting only when the refused page
> is accessed.  Pages Xen forces read-only are still mapped present and
> are unaffected.
> 
> Fixes: ab8131028710 ("x86/CPU/AMD: Print the reason for the last reset")

That patch is an innocent bystander, if anything - nothing it can do about Xen
being weird about not mapping host physical addresses not owned by the domain.

And TBH, all that gymnastics just to prevent this from running on Xen, is not
something that makes me all happy and so on.

What is more, we try to get rid of PV ops, not add more.

I'm sorry if I've misled you with my comment on the previous thread - I didn't
think someone would even act on it.

And I know Sean doesn't like X86_FEATURE_HYPERVISOR but sorry, nothing beats
a oneliner at the beginning of print_s5_reset_status_mmio() vs this overkill.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
