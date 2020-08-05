Return-Path: <SRS0=Keeg=BP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86635C433DF
	for <virtualization@archiver.kernel.org>; Wed,  5 Aug 2020 13:42:51 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FBD42065C
	for <virtualization@archiver.kernel.org>; Wed,  5 Aug 2020 13:42:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DxVHatqg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FBD42065C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 3A07086644;
	Wed,  5 Aug 2020 13:42:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NJQHlyOdQkht; Wed,  5 Aug 2020 13:42:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 97FEF86559;
	Wed,  5 Aug 2020 13:42:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8BA9AC0051;
	Wed,  5 Aug 2020 13:42:50 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0FBEFC004C
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 13:42:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id E60A72036E
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 13:42:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HhP9mQtIJud7
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 13:42:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by silver.osuosl.org (Postfix) with ESMTPS id C57112034F
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 13:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=+g3sbWo8Ja9JxjGyq6mVY0ZEJVqeXUqG7DKAaCqdzBs=; b=DxVHatqgIQwBZ9FahPp33QYiaL
 JbNRhIZx5Otc3laDLk3mLlio8sKrClfiK3w6vfg8u/tcF+CsHN4mmwJX24Bvyq9gY/PRmRm1u1slB
 9ejtKcqY8ZCJXw1thk0kKk64siUhx+DnaTaqBajAHqkVT1HrqFCMfTtpvu3WeZ3gKSYvjpEfcFnIk
 wpawZvrPIG1AHJSRuXQfe99zAXxoQ5PCuvWzPgVhrj0HEfSPGtLFS/AXi5m/ep7C5WxXRtVMFI/29
 mG8qdeu/pQIoWeTQJUcYY3sG0PfCvQk/m7owy3dyLHE4PFN0y9i9k1u4w1om/1Cp74XO9XPsY0+9d
 r4m56qwQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=noisy.programming.kicks-ass.net)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k3Jgf-0005Ka-Cp; Wed, 05 Aug 2020 13:42:33 +0000
Received: from hirez.programming.kicks-ass.net
 (hirez.programming.kicks-ass.net [192.168.1.225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 846953012DC;
 Wed,  5 Aug 2020 15:42:32 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id 71A9A22B957CE; Wed,  5 Aug 2020 15:42:32 +0200 (CEST)
Date: Wed, 5 Aug 2020 15:42:32 +0200
From: peterz@infradead.org
To: Marco Elver <elver@google.com>
Subject: Re: [PATCH] x86/paravirt: Add missing noinstr to arch_local*() helpers
Message-ID: <20200805134232.GR2674@hirez.programming.kicks-ass.net>
References: <0000000000007d3b2d05ac1c303e@google.com>
 <20200805132629.GA87338@elver.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200805132629.GA87338@elver.google.com>
Cc: jgross@suse.com, fenghua.yu@intel.com, yu-cheng.yu@intel.com,
 tony.luck@intel.com, dave.hansen@linux.intel.com,
 syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org,
 kasan-dev@googlegroups.com, virtualization@lists.linux-foundation.org,
 mingo@redhat.com, bp@alien8.de, hpa@zytor.com, tglx@linutronix.de,
 syzbot <syzbot+8db9e1ecde74e590a657@syzkaller.appspotmail.com>, x86@kernel.org
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

On Wed, Aug 05, 2020 at 03:26:29PM +0200, Marco Elver wrote:
> Add missing noinstr to arch_local*() helpers, as they may be called from
> noinstr code.
> 
> On a KCSAN config with CONFIG_PARAVIRT=y, syzbot stumbled across corrupt

Cute, so I've been working on adding objtool support for this a little:

  https://lkml.kernel.org/r/20200803143231.GE2674@hirez.programming.kicks-ass.net

> diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
> index 3d2afecde50c..a606f2ba2b5e 100644
> --- a/arch/x86/include/asm/paravirt.h
> +++ b/arch/x86/include/asm/paravirt.h
> @@ -760,27 +760,27 @@ bool __raw_callee_save___native_vcpu_is_preempted(long cpu);
>  	((struct paravirt_callee_save) { func })
>  
>  #ifdef CONFIG_PARAVIRT_XXL
> -static inline notrace unsigned long arch_local_save_flags(void)
> +static inline noinstr unsigned long arch_local_save_flags(void)
>  {
>  	return PVOP_CALLEE0(unsigned long, irq.save_fl);
>  }
>  
> -static inline notrace void arch_local_irq_restore(unsigned long f)
> +static inline noinstr void arch_local_irq_restore(unsigned long f)
>  {
>  	PVOP_VCALLEE1(irq.restore_fl, f);
>  }
>  
> -static inline notrace void arch_local_irq_disable(void)
> +static inline noinstr void arch_local_irq_disable(void)
>  {
>  	PVOP_VCALLEE0(irq.irq_disable);
>  }
>  
> -static inline notrace void arch_local_irq_enable(void)
> +static inline noinstr void arch_local_irq_enable(void)
>  {
>  	PVOP_VCALLEE0(irq.irq_enable);
>  }
>  
> -static inline notrace unsigned long arch_local_irq_save(void)
> +static inline noinstr unsigned long arch_local_irq_save(void)
>  {
>  	unsigned long f;
>  

Shouldn't we __always_inline those? They're going to be really small.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
