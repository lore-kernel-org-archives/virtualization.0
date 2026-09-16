Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1824EBAFB;
	Wed, 16 Sep 2026 11:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789557298; cv=none; b=g+oyzcF9N3GScAaZ8t2sOEfx5A6+O/3pl/rnSfNNXiRCYmUVFUjsNSadr+Ls63jg69lfems1KmQNQNwMNyOILQGEzkKZAwUbA8a9qdD24NjgwQ+g9K5dvOOOpRpJ0An6vo8lfRPb7oOqt1dZNUoxMg1yB8uMSwjUp8WG4kJMA0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789557298; c=relaxed/simple;
	bh=yob98D+KfLoQVfrMwBowstHbsQyf89G7JrrLYNu6US0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CG5AdejYb7TJedCQQk+ePtgFraDxJy6UN1s7BG2PeG70rlpGeWC3oDXQ40N2DOLrjyDEY2jiwP3qDxCnDHW5Kw3KYRcX53f75RmhwgoZ9mPgVlxq8mcb3UBOrOOvTkpko2qzupkkLBxqzk2g6jPsXFfK9mavasP/72m2hRqS6/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XJVBTuuY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XJVBTuuY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B9C01F00899;
	Wed, 16 Sep 2026 11:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789557277;
	bh=JmNMzbrEv6yrDdkqLEFNGkwZbyvBDG+2DCzdYiaiGec=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XJVBTuuY5fxQgaNMqwXdW/8lMVnaanRpKX/ufNaN3rAml3SeqsA7gNP2Cte1203MW
	 1ifeIXo7/j4lidlX0ZIQGq8k7L9cOxeK9CuwH9j2b2BuEO6tMjccM1jt6Tr18u/QrY
	 hMWXD7FhhAKT4v23M7EQ51T0VzbNJpBAE2Teu3SqAKtwY28edU9Veq5nj0E/qarTsk
	 Y5MLlcGK2SgsAp44DSYDLgETx4QPJ72bYzom+6LNN9GvCCkJPDNgC6cb9Sp/IjmdZ1
	 G11bIHkhIvvp4phXYlQMyh0vsVmyIKKT0lcBst2yRskYsPJ27WW1UDuAZVqWw4KzGE
	 e+wnUSn+HPR6A==
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.ams.internal (Postfix) with ESMTP id 0CBB9198006E;
	Wed, 16 Sep 2026 07:14:30 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 16 Sep 2026 07:14:34 -0400
X-ME-Sender: <xms:FnqqamPaDD8QL2vYJf5rPY1guVD00XIkXlvtUp2kyTOR0mI5zavK8Q>
    <xme:FnqqaprVgAB0AbVW80dCO0gfst6mh3Q8bsTcIXNRVqeFmUcPdoQoq2P6wkUApTYgm
    9B-SJ7IRgbaoAy2gOP_hfTX6Lx0XAPM7EaxjvA--dUsKia2zykZz-vE>
X-ME-Received: <xmr:FnqqalIxLKjX1ys8z_hH0D0sbTbkXRBGQSo8vb8ioRKY7qOi1WQrN_P7kE8>
X-ME-Proxy-Cause: dmFkZTEHTPffs6tQZam3XMf5jo2JovVPU0EEMKVfKe73Lr74zoVZQHJyA8b0O/Fo6fSSgj
    xUKdMfiJbhpGK7MzbpLZ4vi1COv9k9i7YAq2TZMwFP23/ASP2WUMk4lChOX6I50KMKC6wT
    kMdp6iZDkSDR0NTSFIsVzIaBvzYEAhBfX6Vm03NOb64oYcKjhiFiVSbzNblFnd0RnuqjMv
    xLV9OVuRbiJ92LHLQj/Y7FEjUIFd43z4c+ENu1F36bTtNYO5pEza9N/P3dzK5PWtYJF5P9
    8J1lyhwhCU00lRtsdLhPl+viOUkwTU4PNcGtVVeqfBeJDGiiFqRC019XiGpsZdJHdjiyXq
    o0iCd1wtzdVEbX7S+cmcnjdn1ZweHEEmR/LlP+mMdVT+ApO+3GGyevETMKEToeDPaKYBnc
    x2SSwqjb7EpUPpfBe3HvtRCHf3MHx9rL5ePCYwci90styEDO14TzgdT0Eo1MVjRsLYRMbV
    bpFduV0xbXgPXoCE50cksswXfyYtgmC/Qz2FhyoDkRMb59z47vcMUe4nK/U+eJsOyjsltT
    GMeja+BaPdoCnmk7f9bLUEipmZtZp3LuiAesFXPF+Xk2+Y4c7HiHAQslOdqBahhqh0ggf1
    gvrZP5p41Mp8yGtSPmYtruSmi8La1nNE1GaMkkffF4ticgnB49i6liQcLNHQ
X-ME-Proxy: <xmx:FnqqaqfYaxX9AvJDNNWWTgMwm0YglJiWAA3ucUcH874sEbQpWmnE2w>
    <xmx:FnqqaseTAv4mVrFWWUTkENbjGMK2MZNABt-4yS-FhUGwildSpd4rcg>
    <xmx:FnqqahYGL0Pdm8P54UOoK7OTY6TInkKNP5WRtOs26wZwzpgM1808Zw>
    <xmx:Fnqqapp3HwaAb32SNLyBOPsLrtssDa0FAESEy5cuiOkrTdlqjNQ6rg>
    <xmx:FnqqasZMmjEJ6shM5jBiOxXn-Sz5yqPhqBen--r0kTpweTj6AIZlBiJD>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Sep 2026 07:14:29 -0400 (EDT)
Date: Wed, 16 Sep 2026 12:14:28 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: Zack Rusin <zack.rusin@broadcom.com>
Cc: Borislav Petkov <bp@alien8.de>, Ajay Kaher <ajay.kaher@broadcom.com>, 
	Alexey Makhalov <alexey.makhalov@broadcom.com>, x86@kernel.org, Dennis Zhou <dennis@kernel.org>, 
	Tejun Heo <tj@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H . Peter Anvin" <hpa@zytor.com>, virtualization@lists.linux.dev, 
	bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org, Christoph Lameter <cl@gentwo.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Bo Gan <bo.gan@broadcom.com>, linux-mm@kvack.org, linux-arch@vger.kernel.org, 
	linux-coco@lists.linux.dev, kvm@vger.kernel.org
Subject: Re: [PATCH v1 1/2] percpu: Use X86_MEM_ENCRYPT for decrypted per-CPU
 data
Message-ID: <aqp5yxa2qcsv-dvt@thinkstation>
References: <cover.1789488039.git.zack.rusin@broadcom.com>
 <07cdda86e2c60b27a18023e2e5fae339b78db0ab.1789488039.git.zack.rusin@broadcom.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07cdda86e2c60b27a18023e2e5fae339b78db0ab.1789488039.git.zack.rusin@broadcom.com>

On Wed, Sep 16, 2026 at 01:05:39AM -0400, Zack Rusin wrote:
> Decrypted per-CPU data is gated by AMD_MEM_ENCRYPT. With
> INTEL_TDX_GUEST=y and AMD_MEM_ENCRYPT=n it falls back to ordinary
> per-CPU storage, so converting a variable to shared memory can expose
> unrelated data on the same page.
> 
> Gate the declarations and linker section on X86_MEM_ENCRYPT, which both
> AMD_MEM_ENCRYPT and INTEL_TDX_GUEST select. Existing AMD configurations
> are unchanged.
> 
> Keep the decrypted subsection page-aligned at both ends. The per-CPU
> template and each allocated per-CPU unit are also page-aligned, so page
> conversion cannot expose ordinary per-CPU data. TDX-only configurations
> may need additional space for this alignment and isolation.
> 
> Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
> ---
>  include/asm-generic/vmlinux.lds.h | 2 +-
>  include/linux/percpu-defs.h       | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index b2988aa12f66..1448e791773e 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -1013,7 +1013,7 @@
>   * Note: We use a separate section so that only this section gets
>   * decrypted to avoid exposing more than we wish.
>   */
> -#ifdef CONFIG_AMD_MEM_ENCRYPT
> +#ifdef CONFIG_X86_MEM_ENCRYPT
>  #define PERCPU_DECRYPTED_SECTION					\
>  	. = ALIGN(PAGE_SIZE);						\
>  	*(.data..percpu..decrypted)					\
> diff --git a/include/linux/percpu-defs.h b/include/linux/percpu-defs.h
> index dbe3267a0a13..54ce1442d918 100644
> --- a/include/linux/percpu-defs.h
> +++ b/include/linux/percpu-defs.h
> @@ -172,7 +172,7 @@
>   * Declaration/definition used for per-CPU variables that should be accessed
>   * as decrypted when memory encryption is enabled in the guest.
>   */
> -#ifdef CONFIG_AMD_MEM_ENCRYPT
> +#ifdef CONFIG_X86_MEM_ENCRYPT
>  #define DECLARE_PER_CPU_DECRYPTED(type, name)				\
>  	DECLARE_PER_CPU_SECTION(type, name, "..decrypted")

DECLARE_PER_CPU_DECRYPTED() is not used anywhere. Do we want to drop it?

Otherwise:

Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
