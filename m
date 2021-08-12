Return-Path: <SRS0=F+q/=ND=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DB94C4338F
	for <virtualization@archiver.kernel.org>; Thu, 12 Aug 2021 19:46:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA49460F57
	for <virtualization@archiver.kernel.org>; Thu, 12 Aug 2021 19:46:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EA49460F57
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id AD19140112;
	Thu, 12 Aug 2021 19:46:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3xR7uuD8CsY9; Thu, 12 Aug 2021 19:46:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id EC37E400DE;
	Thu, 12 Aug 2021 19:46:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BBB00C001A;
	Thu, 12 Aug 2021 19:46:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 80539C000E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Aug 2021 19:46:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5CB2980DFA
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Aug 2021 19:46:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GsPTgiNEylcQ
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Aug 2021 19:46:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B747E80DAF
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Aug 2021 19:46:41 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id BD59560FBF;
 Thu, 12 Aug 2021 19:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1628797601;
 bh=FB/3JXubUJqc+EUesD4OCWgL312JeTESVV+Ra/v4hdw=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=MJA8LHF5KUCiP0sTl4iurA3fDS7AgIYzwMkVRxQd6P+Zzc8ZakNgX4P3asf1FKDNB
 UbXBHwUJdCJ6kdN6CbXHKvkkwoSlyh/19gNstxaAXvsIoYR37CipfOmHFcW7w/8zrJ
 BlU1dv71mF+AmDc7QlexVfXwJMtQgVkPVu9vlnl+FQmMbbVQ8lV7z22x6q0rZbKh2q
 TnrSVTKXCNgJs2nrqsXem3Iby46GXQTdXgicmdrfSsM1euQN+HrZ/l6Tb6ZFlyQT8E
 iyRV/bO+EVrfGZgIcLVddiSAVDvWhB3qv7lUAWv4x86HaLDNshBdsr3l63+uODvXS2
 mVdS96JaUFIDQ==
Date: Thu, 12 Aug 2021 14:46:39 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: Re: [PATCH v4 10/15] asm/io.h: Add ioremap_shared fallback
Message-ID: <20210812194639.GA2502520@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210805005218.2912076-11-sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 linux-pci@vger.kernel.org, linux-mips@vger.kernel.org,
 James E J Bottomley <James.Bottomley@HansenPartnership.com>,
 Dave Hansen <dave.hansen@intel.com>, Peter H Anvin <hpa@zytor.com>,
 sparclinux@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 linux-arch@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
 Jonathan Corbet <corbet@lwn.net>, Helge Deller <deller@gmx.de>, x86@kernel.org,
 Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
 Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Dan Williams <dan.j.williams@intel.com>,
 virtualization@lists.linux-foundation.org, Richard Henderson <rth@twiddle.net>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-parisc@vger.kernel.org,
 Sean Christopherson <seanjc@google.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
 "David S . Miller" <davem@davemloft.net>,
 Kirill Shutemov <kirill.shutemov@linux.intel.com>
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Wed, Aug 04, 2021 at 05:52:13PM -0700, Kuppuswamy Sathyanarayanan wrote:
> From: Andi Kleen <ak@linux.intel.com>
> 
> This function is for declaring memory that should be shared with
> a hypervisor in a confidential guest. If the architecture doesn't
> implement it it's just ioremap.

I would assume ioremap_shared() would "map" something, not "declare"
it.

> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
>  arch/alpha/include/asm/io.h    | 1 +
>  arch/mips/include/asm/io.h     | 1 +
>  arch/parisc/include/asm/io.h   | 1 +
>  arch/sparc/include/asm/io_64.h | 1 +
>  include/asm-generic/io.h       | 4 ++++
>  5 files changed, 8 insertions(+)
> 
> diff --git a/arch/alpha/include/asm/io.h b/arch/alpha/include/asm/io.h
> index 0fab5ac90775..701b44909b94 100644
> --- a/arch/alpha/include/asm/io.h
> +++ b/arch/alpha/include/asm/io.h
> @@ -283,6 +283,7 @@ static inline void __iomem *ioremap(unsigned long port, unsigned long size)
>  }
>  
>  #define ioremap_wc ioremap
> +#define ioremap_shared ioremap
>  #define ioremap_uc ioremap
>  
>  static inline void iounmap(volatile void __iomem *addr)
> diff --git a/arch/mips/include/asm/io.h b/arch/mips/include/asm/io.h
> index 6f5c86d2bab4..3713ff624632 100644
> --- a/arch/mips/include/asm/io.h
> +++ b/arch/mips/include/asm/io.h
> @@ -179,6 +179,7 @@ void iounmap(const volatile void __iomem *addr);
>  #define ioremap(offset, size)						\
>  	ioremap_prot((offset), (size), _CACHE_UNCACHED)
>  #define ioremap_uc		ioremap
> +#define ioremap_shared		ioremap
>  
>  /*
>   * ioremap_cache -	map bus memory into CPU space
> diff --git a/arch/parisc/include/asm/io.h b/arch/parisc/include/asm/io.h
> index 0b5259102319..73064e152df7 100644
> --- a/arch/parisc/include/asm/io.h
> +++ b/arch/parisc/include/asm/io.h
> @@ -129,6 +129,7 @@ static inline void gsc_writeq(unsigned long long val, unsigned long addr)
>   */
>  void __iomem *ioremap(unsigned long offset, unsigned long size);
>  #define ioremap_wc			ioremap
> +#define ioremap_shared			ioremap
>  #define ioremap_uc			ioremap
>  
>  extern void iounmap(const volatile void __iomem *addr);
> diff --git a/arch/sparc/include/asm/io_64.h b/arch/sparc/include/asm/io_64.h
> index 5ffa820dcd4d..18cc656eb712 100644
> --- a/arch/sparc/include/asm/io_64.h
> +++ b/arch/sparc/include/asm/io_64.h
> @@ -409,6 +409,7 @@ static inline void __iomem *ioremap(unsigned long offset, unsigned long size)
>  #define ioremap_uc(X,Y)			ioremap((X),(Y))
>  #define ioremap_wc(X,Y)			ioremap((X),(Y))
>  #define ioremap_wt(X,Y)			ioremap((X),(Y))
> +#define ioremap_shared(X, Y)		ioremap((X), (Y))
>  static inline void __iomem *ioremap_np(unsigned long offset, unsigned long size)
>  {
>  	return NULL;
> diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
> index e93375c710b9..bfcaee1691c8 100644
> --- a/include/asm-generic/io.h
> +++ b/include/asm-generic/io.h
> @@ -982,6 +982,10 @@ static inline void __iomem *ioremap(phys_addr_t addr, size_t size)
>  #define ioremap_wt ioremap
>  #endif
>  
> +#ifndef ioremap_shared
> +#define ioremap_shared ioremap
> +#endif

"ioremap_shared" is a very generic term for a pretty specific thing:
"memory shared with a hypervisor in a confidential guest".

Maybe deserves a comment with at least a hint here.  "Hypervisors in a
confidential guest" isn't the first thing that comes to mind when I
read "shared".

>  /*
>   * ioremap_uc is special in that we do require an explicit architecture
>   * implementation.  In general you do not want to use this function in a
> -- 
> 2.25.1
> 
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
