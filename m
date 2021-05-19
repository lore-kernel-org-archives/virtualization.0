Return-Path: <SRS0=KlxN=KO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 304ADC433ED
	for <virtualization@archiver.kernel.org>; Wed, 19 May 2021 19:34:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6269611BD
	for <virtualization@archiver.kernel.org>; Wed, 19 May 2021 19:34:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6269611BD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6D4114024C;
	Wed, 19 May 2021 19:34:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lhlt-CPKzTkR; Wed, 19 May 2021 19:34:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id BB23C4022E;
	Wed, 19 May 2021 19:33:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7752BC000E;
	Wed, 19 May 2021 19:33:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 914FAC0001
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 May 2021 19:33:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 771116063D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 May 2021 19:33:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3akbVQJAaGzG
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 May 2021 19:33:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B5CBC60636
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 May 2021 19:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=Wm6Fg6hPEXzb07sPLpGnEeLDWpfOMrauzZEfAlcYzmM=; b=YmoOqAur2JknC74gPCU8jGvugp
 P88XBQSr2WV4USjdKsyTqVsgFLp9ogTq6CoyV9QmGmhOkRFRSH3OhA1Gk3od5PQ/k6IZ1Hg8LP6hE
 7e9XrO7uoMSxt3qWDgWa1kpNE2v+ksyiq1GD6PBLx9gLjWBri/dtPcGYBapdd8F0t/oqD88Wp1rHF
 cPWt5ZzNKurWzPdQrIaF5JmBLwEA7+dixraZw4EC7r3xNq4XFkH6CWVLR720EWcYK3U2dv/vKO7pB
 4WRNJMV+rsawx3qRiA4q1YRO4uIgJStawTWIEsweO9LksGnPfrFH3CyY3ftNEmem07is3KL5U/TSt
 F0CD3LEg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=worktop.programming.kicks-ass.net)
 by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1ljRvD-00FFAb-4q; Wed, 19 May 2021 19:32:15 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
 id 4F1D1986465; Wed, 19 May 2021 21:31:58 +0200 (CEST)
Date: Wed, 19 May 2021 21:31:58 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH v2 5/8] x86/sev-es: Leave NMI-mode before sending signals
Message-ID: <20210519193158.GJ21560@worktop.programming.kicks-ass.net>
References: <20210519135251.30093-1-joro@8bytes.org>
 <20210519135251.30093-6-joro@8bytes.org>
 <20210519175450.GF21560@worktop.programming.kicks-ass.net>
 <YKVjRJmva/Y2EHPZ@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YKVjRJmva/Y2EHPZ@suse.de>
Cc: kvm@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
 virtualization@lists.linux-foundation.org,
 Arvind Sankar <nivedita@alum.mit.edu>, hpa@zytor.com,
 Jiri Slaby <jslaby@suse.cz>, Joerg Roedel <joro@8bytes.org>, x86@kernel.org,
 David Rientjes <rientjes@google.com>, Martin Radev <martin.b.radev@gmail.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, Kees Cook <keescook@chromium.org>,
 Cfir Cohen <cfir@google.com>, Hyunwook Baek <baekhw@google.com>,
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

On Wed, May 19, 2021 at 09:13:08PM +0200, Joerg Roedel wrote:
> Hi Peter,
> 
> thanks for your review.
> 
> On Wed, May 19, 2021 at 07:54:50PM +0200, Peter Zijlstra wrote:
> > On Wed, May 19, 2021 at 03:52:48PM +0200, Joerg Roedel wrote:
> > > --- a/arch/x86/kernel/sev.c
> > > +++ b/arch/x86/kernel/sev.c
> > > @@ -1343,9 +1343,10 @@ DEFINE_IDTENTRY_VC_SAFE_STACK(exc_vmm_communication)
> > >  		return;
> > >  	}
> > >  
> > > +	instrumentation_begin();
> > > +
> > >  	irq_state = irqentry_nmi_enter(regs);
> > >  	lockdep_assert_irqs_disabled();
> > > -	instrumentation_begin();
> > >  
> > >  	/*
> > >  	 * This is invoked through an interrupt gate, so IRQs are disabled. The
> > 
> > That's just plain wrong. No instrumentation is allowed before you enter
> > the exception context.
> 
> Okay.
> 
> > > +	irqentry_nmi_exit(regs, irq_state);
> > > +
> > 
> > And this is wrong too; because at this point the handler doesn't run in
> > _any_ context anymore, certainly not one you can call regular C code
> > from.
> 
> The #VC handler is at this point not running on the IST stack anymore,
> but on the stack it came from or on the task stack. So my believe was
> that at this point it inherits the context it came from (just like the
> page-fault handler). But I also don't fully understand the context
> tracking, so is my assumption wrong?

Being on the right stack is only part of the issue; you also need to
make sure your runtime environment is set up.

Regular kernel C expects a whole lot of things to be present; esp. so
with all the debug options on. The irqentry_*_enter() family of
functions very carefully sets up this environment and the
irqentry_*_exit() undoes it again. Before and after you really cannot
run normal code.

Just an example, RCU might not be watching, it might think the CPU is in
userspace and advance the GP while you're relying on it not doing so.

Similarly lockdep is in some undefined state and any lock used can
trigger random 'funny' things.

Just because this is 'C', doesn't immediately mean you can go call any
random function. Up until recently most of this was in ASM. There's a
reason for the noinstr annotations.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
