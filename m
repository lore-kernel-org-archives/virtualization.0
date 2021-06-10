Return-Path: <SRS0=uiEo=LE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61909C47094
	for <virtualization@archiver.kernel.org>; Thu, 10 Jun 2021 10:21:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F343D613C6
	for <virtualization@archiver.kernel.org>; Thu, 10 Jun 2021 10:21:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F343D613C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B745A60892;
	Thu, 10 Jun 2021 10:21:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HKC7JPeaUav5; Thu, 10 Jun 2021 10:21:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 608E6607D6;
	Thu, 10 Jun 2021 10:21:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 38098C000E;
	Thu, 10 Jun 2021 10:21:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 97ED5C000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 10:21:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7835C405E4
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 10:21:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EYA0aWpVGR1H
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 10:21:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D1162405E3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 10:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=h/muEhpxVB/fiLZzxDtNWLmprGe33vvGrnl4EIsyiME=; b=C9711rfL7VWAOpk6sJJ9J7J/I1
 zaCKOfBhOnlG98lP2S47uOkx7vj7XIY74Syna8t0J7A1iYuJdd5jZhyvArBg8tCPqpHoWNsbbwVGt
 6mpY4+CRaLfOMN2C51RUHQPX7MV8AdfqjOf65GQVVg5gXj1lgemfVVOS86BOXJvFafieSbfH8S/bu
 uU96SaHMvaBDL5GEwfMIpu6IuPe2p6GPGLwwriTEo/pobY5OPGk0ZcuPxTcePBSm1p+CeuSgqS2k9
 lGVGbKGFQ34etlCs0UaYdXjTcacWG1COJwp9YBMrI9vNveIAm78LmGJGideBbJIcU/37qrHKKYLp6
 GoVRv4AQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=noisy.programming.kicks-ass.net)
 by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1lrHmr-001UFJ-SK; Thu, 10 Jun 2021 10:19:49 +0000
Received: from hirez.programming.kicks-ass.net
 (hirez.programming.kicks-ass.net [192.168.1.225])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (Client did not present a certificate)
 by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BC91B300258;
 Thu, 10 Jun 2021 12:19:43 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id AB1BB20811810; Thu, 10 Jun 2021 12:19:43 +0200 (CEST)
Date: Thu, 10 Jun 2021 12:19:43 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v4 3/6] x86/sev-es: Split up runtime #VC handler for
 correct state tracking
Message-ID: <YMHnP1qgvznyYazv@hirez.programming.kicks-ass.net>
References: <20210610091141.30322-1-joro@8bytes.org>
 <20210610091141.30322-4-joro@8bytes.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210610091141.30322-4-joro@8bytes.org>
Cc: kvm@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
 virtualization@lists.linux-foundation.org,
 Arvind Sankar <nivedita@alum.mit.edu>, hpa@zytor.com,
 Jiri Slaby <jslaby@suse.cz>, x86@kernel.org,
 David Rientjes <rientjes@google.com>, Martin Radev <martin.b.radev@gmail.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, Joerg Roedel <jroedel@suse.de>,
 Kees Cook <keescook@chromium.org>, Cfir Cohen <cfir@google.com>,
 linux-coco@lists.linux.dev, Andy Lutomirski <luto@kernel.org>,
 Dan Williams <dan.j.williams@intel.com>, Juergen Gross <jgross@suse.com>,
 Mike Stunes <mstunes@vmware.com>, Sean Christopherson <seanjc@google.com>,
 linux-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Erdem Aktas <erdemaktas@google.com>
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


Bah, I suppose the trouble is that this SEV crap requires PARAVIRT?

I should really get around to fixing noinstr validation with PARAVIRT on
:-(

On Thu, Jun 10, 2021 at 11:11:38AM +0200, Joerg Roedel wrote:

> +static void vc_handle_from_kernel(struct pt_regs *regs, unsigned long error_code)

static noinstr ...

> +{
> +	irqentry_state_t irq_state = irqentry_nmi_enter(regs);
>  
> +	instrumentation_begin();
>  
> +	if (!vc_raw_handle_exception(regs, error_code)) {
>  		/* Show some debug info */
>  		show_regs(regs);
>  
> @@ -1434,7 +1400,59 @@ DEFINE_IDTENTRY_VC_SAFE_STACK(exc_vmm_communication)
>  		panic("Returned from Terminate-Request to Hypervisor\n");
>  	}
>  
> +	instrumentation_end();
> +	irqentry_nmi_exit(regs, irq_state);
> +}
> +
> +static void vc_handle_from_user(struct pt_regs *regs, unsigned long error_code)

static noinstr ...

> +{
> +	irqentry_state_t irq_state = irqentry_enter(regs);
> +
> +	instrumentation_begin();
> +
> +	if (!vc_raw_handle_exception(regs, error_code)) {
> +		/*
> +		 * Do not kill the machine if user-space triggered the
> +		 * exception. Send SIGBUS instead and let user-space deal with
> +		 * it.
> +		 */
> +		force_sig_fault(SIGBUS, BUS_OBJERR, (void __user *)0);
> +	}
> +
> +	instrumentation_end();
> +	irqentry_exit(regs, irq_state);
> +}

+ linebreak

> +/*
> + * Main #VC exception handler. It is called when the entry code was able to
> + * switch off the IST to a safe kernel stack.
> + *
> + * With the current implementation it is always possible to switch to a safe
> + * stack because #VC exceptions only happen at known places, like intercepted
> + * instructions or accesses to MMIO areas/IO ports. They can also happen with
> + * code instrumentation when the hypervisor intercepts #DB, but the critical
> + * paths are forbidden to be instrumented, so #DB exceptions currently also
> + * only happen in safe places.
> + */
> +DEFINE_IDTENTRY_VC_SAFE_STACK(exc_vmm_communication)
> +{
> +	/*
> +	 * Handle #DB before calling into !noinstr code to avoid recursive #DB.
> +	 */
> +	if (error_code == SVM_EXIT_EXCP_BASE + X86_TRAP_DB) {
> +		vc_handle_trap_db(regs);
> +		return;
> +	}
> +
> +	/*
> +	 * This is invoked through an interrupt gate, so IRQs are disabled. The
> +	 * code below might walk page-tables for user or kernel addresses, so
> +	 * keep the IRQs disabled to protect us against concurrent TLB flushes.
> +	 */
> +
> +	if (user_mode(regs))
> +		vc_handle_from_user(regs, error_code);
> +	else
> +		vc_handle_from_kernel(regs, error_code);
>  }

#DB and MCE use idtentry_mce_db and split out in asm. When I look at
idtentry_vc, it appears to me that VC_SAFE_STACK already implies
from-user, or am I reading that wrong?

Ah, it appears you're muddling things up again by then also calling
safe_stack_ from exc_.

How about you don't do that and have exc_ call your new from_kernel
function, then we know that safe_stack_ is always from-user. Then also
maybe do:

	s/VS_SAFE_STACK/VC_USER/
	s/safe_stack_/noist_/

to match all the others (#DB/MCE).

Also, AFAICT, you don't actually need DEFINE_IDTENTRY_VC_IST, it doesn't
have an ASM counterpart.

So then you end up with something like:

DEFINE_IDTENTRY_VC(exc_vc)
{
	if (unlikely(on_vc_fallback_stack(regs))) {
		instrumentation_begin();
		panic("boohooo\n");
		instrumentation_end();
	}

	vc_from_kernel();
}

DEFINE_IDTENTRY_VC_USER(exc_vc)
{
	vc_from_user();
}

Which is, I'm thinking, much simpler, no?
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
