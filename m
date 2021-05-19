Return-Path: <SRS0=KlxN=KO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 641DCC433B4
	for <virtualization@archiver.kernel.org>; Wed, 19 May 2021 17:56:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7A436124C
	for <virtualization@archiver.kernel.org>; Wed, 19 May 2021 17:56:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7A436124C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9A1E06063F;
	Wed, 19 May 2021 17:56:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id r3By0FDeMedF; Wed, 19 May 2021 17:56:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 52709605BB;
	Wed, 19 May 2021 17:56:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 330F5C000E;
	Wed, 19 May 2021 17:56:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CEBF8C0001
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 May 2021 17:56:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A66A64043F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 May 2021 17:56:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qEoY0SjcPAa3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 May 2021 17:56:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C38C3403ED
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 May 2021 17:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=0VusAJZ3GsBzVSdLTEAGWr7rdRHdzn/JtH42moT3IVU=; b=RF8RFvqQuOtdFP/lCsk93yjuz9
 LTOSQBYY2k6m3umvaeS2K30f9je5U14s6FuCQezx+ml8LwzduT3682kYN72e7kAXxlFkaLpCEkALU
 u9NL1h1C4e/riHeHEUZfm16LDlc3uHlsIRFrZPWeixuho32kANI9e+dZzxJNM9siit0/n4Jmxmcli
 5kONPHTxaJ+tC/1VAo5uRnYbKWhHetXqeNRAzaShstYsNAvCqs+n7znoLP1qSotPo+nM0EN3S7Mgq
 Gz/lXNIqTq6iNQCjCe/BNG6yKXdM2Kr0aOI7y0Z+cWo2vI4JH67DZTB/1qxgdQ87QkyaDvmBMEUjR
 XP02rlpA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=worktop.programming.kicks-ass.net)
 by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1ljQPD-00FB8B-O6; Wed, 19 May 2021 17:55:03 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
 id 336EF986465; Wed, 19 May 2021 19:54:50 +0200 (CEST)
Date: Wed, 19 May 2021 19:54:50 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v2 5/8] x86/sev-es: Leave NMI-mode before sending signals
Message-ID: <20210519175450.GF21560@worktop.programming.kicks-ass.net>
References: <20210519135251.30093-1-joro@8bytes.org>
 <20210519135251.30093-6-joro@8bytes.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210519135251.30093-6-joro@8bytes.org>
Cc: kvm@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
 virtualization@lists.linux-foundation.org,
 Arvind Sankar <nivedita@alum.mit.edu>, hpa@zytor.com,
 Jiri Slaby <jslaby@suse.cz>, x86@kernel.org,
 David Rientjes <rientjes@google.com>, Martin Radev <martin.b.radev@gmail.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, Joerg Roedel <jroedel@suse.de>,
 Kees Cook <keescook@chromium.org>, Cfir Cohen <cfir@google.com>,
 Hyunwook Baek <baekhw@google.com>, linux-coco@lists.linux.dev,
 Andy Lutomirski <luto@kernel.org>, Dan Williams <dan.j.williams@intel.com>,
 Juergen Gross <jgross@suse.com>, Mike Stunes <mstunes@vmware.com>,
 Sean Christopherson <seanjc@google.com>, linux-kernel@vger.kernel.org,
 Masami Hiramatsu <mhiramat@kernel.org>, Erdem Aktas <erdemaktas@google.com>
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

On Wed, May 19, 2021 at 03:52:48PM +0200, Joerg Roedel wrote:
> --- a/arch/x86/kernel/sev.c
> +++ b/arch/x86/kernel/sev.c
> @@ -1343,9 +1343,10 @@ DEFINE_IDTENTRY_VC_SAFE_STACK(exc_vmm_communication)
>  		return;
>  	}
>  
> +	instrumentation_begin();
> +
>  	irq_state = irqentry_nmi_enter(regs);
>  	lockdep_assert_irqs_disabled();
> -	instrumentation_begin();
>  
>  	/*
>  	 * This is invoked through an interrupt gate, so IRQs are disabled. The

That's just plain wrong. No instrumentation is allowed before you enter
the exception context.

> @@ -1395,13 +1396,19 @@ DEFINE_IDTENTRY_VC_SAFE_STACK(exc_vmm_communication)
>  		BUG();
>  	}
>  
> -out:
> -	instrumentation_end();
>  	irqentry_nmi_exit(regs, irq_state);
> +	instrumentation_end();

And this can't be right either, same issue, no instrumentation is
allowed after you leave the exception context.

>  
>  	return;
>  
>  fail:
> +	/*
> +	 * Leave NMI mode - the GHCB is not busy anymore and depending on where
> +	 * the #VC came from this code is about to either kill the task (when in
> +	 * task context) or kill the machine.
> +	 */
> +	irqentry_nmi_exit(regs, irq_state);
> +

And this is wrong too; because at this point the handler doesn't run in
_any_ context anymore, certainly not one you can call regular C code
from.

>  	if (user_mode(regs)) {
>  		/*
>  		 * Do not kill the machine if user-space triggered the
> @@ -1423,7 +1430,9 @@ DEFINE_IDTENTRY_VC_SAFE_STACK(exc_vmm_communication)
>  		panic("Returned from Terminate-Request to Hypervisor\n");
>  	}
>  
> -	goto out;
> +	instrumentation_end();
> +
> +	return;
>  }


You either get to do what MCE does, or what MCE does. That is, either
use task_work or MCE_USER and have the _user() handler use
irqentry_enter_from_user_mode().

The above is an absolute no-go.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
