Return-Path: <SRS0=QAK1=BW=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD425C433DF
	for <virtualization@archiver.kernel.org>; Wed, 12 Aug 2020 08:57:43 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 829322076B
	for <virtualization@archiver.kernel.org>; Wed, 12 Aug 2020 08:57:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oA0RL+AU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 829322076B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id CF00687FD3;
	Wed, 12 Aug 2020 08:57:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3roMv14CVPlb; Wed, 12 Aug 2020 08:57:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 934EB87FB5;
	Wed, 12 Aug 2020 08:57:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6EB76C013C;
	Wed, 12 Aug 2020 08:57:41 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DC904C004D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Aug 2020 08:57:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id CB8A587D1D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Aug 2020 08:57:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wa-8svVJ6xoF
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Aug 2020 08:57:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
 by hemlock.osuosl.org (Postfix) with ESMTPS id B71D287D14
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Aug 2020 08:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=nuSjbKLmgFUpujyztO9pZIgg8RwXK/k205UIQiNkmjY=; b=oA0RL+AUZC/9NzFpw32e8YGbiG
 0VcMjRTkK6gzyi6LHeQnGMZedrE247e0AD0iS9PuK19STFCes37/7sZrX2+QhWxirH2ub40je4iSp
 eTVV6/KGsbaHq+ZjwBe0fSjKLulkT0uN3I1uNocq1V2rleacFT0UF1OA3jexfzOBZJuS/DI+oZDlq
 cke/wCMKg4rXrUcFiI0Vwu+4dhGJukasRcaQhlVemsjENOmzGa5wH1E/hJztIE2IqScefyAxnVEd0
 FHgbU+yagNuIlrDxAdcOW3YNd1gw/+VNhqX8mx0uvYlgj5jc1KnHHWYHoE5T0UnEnArqR0mQRo7p2
 RtNwIp6Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=noisy.programming.kicks-ass.net)
 by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k5mZT-0007yN-FP; Wed, 12 Aug 2020 08:57:19 +0000
Received: from hirez.programming.kicks-ass.net
 (hirez.programming.kicks-ass.net [192.168.1.225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3137830753E;
 Wed, 12 Aug 2020 10:57:17 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id 0F43625D0D543; Wed, 12 Aug 2020 10:57:17 +0200 (CEST)
Date: Wed, 12 Aug 2020 10:57:17 +0200
From: peterz@infradead.org
To: Marco Elver <elver@google.com>
Subject: Re: [PATCH] x86/paravirt: Add missing noinstr to arch_local*() helpers
Message-ID: <20200812085717.GJ35926@hirez.programming.kicks-ass.net>
References: <20200807151903.GA1263469@elver.google.com>
 <20200811074127.GR3982@worktop.programming.kicks-ass.net>
 <a2dffeeb-04f0-8042-b39a-b839c4800d6f@suse.com>
 <20200811081205.GV3982@worktop.programming.kicks-ass.net>
 <07f61573-fef1-e07c-03f2-a415c88dec6f@suse.com>
 <20200811092054.GB2674@hirez.programming.kicks-ass.net>
 <20200811094651.GH35926@hirez.programming.kicks-ass.net>
 <20200811201755.GI35926@hirez.programming.kicks-ass.net>
 <20200812080650.GA3894595@elver.google.com>
 <20200812081832.GK2674@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200812081832.GK2674@hirez.programming.kicks-ass.net>
Cc: =?iso-8859-1?Q?J=FCrgen_Gro=DF?= <jgross@suse.com>, fenghua.yu@intel.com,
 yu-cheng.yu@intel.com, "Luck, Tony" <tony.luck@intel.com>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
 LKML <linux-kernel@vger.kernel.org>, kasan-dev <kasan-dev@googlegroups.com>,
 virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Steven Rostedt <rostedt@goodmis.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>,
 syzbot <syzbot+8db9e1ecde74e590a657@syzkaller.appspotmail.com>,
 Wei Liu <wei.liu@kernel.org>, the arch/x86 maintainers <x86@kernel.org>
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

On Wed, Aug 12, 2020 at 10:18:32AM +0200, peterz@infradead.org wrote:
> > 	 trace_hardirqs_restore+0x59/0x80 kernel/trace/trace_preemptirq.c:106
> > 	 rcu_irq_enter_irqson+0x43/0x70 kernel/rcu/tree.c:1074
> > 	 trace_irq_enable_rcuidle+0x87/0x120 include/trace/events/preemptirq.h:40
> > 	 trace_hardirqs_restore+0x59/0x80 kernel/trace/trace_preemptirq.c:106
> > 	 rcu_irq_enter_irqson+0x43/0x70 kernel/rcu/tree.c:1074
> > 	 trace_irq_enable_rcuidle+0x87/0x120 include/trace/events/preemptirq.h:40
> > 	 trace_hardirqs_restore+0x59/0x80 kernel/trace/trace_preemptirq.c:106
> > 	 rcu_irq_enter_irqson+0x43/0x70 kernel/rcu/tree.c:1074
> > 	 trace_irq_enable_rcuidle+0x87/0x120 include/trace/events/preemptirq.h:40
> > 	 trace_hardirqs_restore+0x59/0x80 kernel/trace/trace_preemptirq.c:106
> > 	 rcu_irq_enter_irqson+0x43/0x70 kernel/rcu/tree.c:1074
> > 
> > 	<... repeated many many times ...>
> > 
> > 	 trace_irq_enable_rcuidle+0x87/0x120 include/trace/events/preemptirq.h:40
> > 	 trace_hardirqs_restore+0x59/0x80 kernel/trace/trace_preemptirq.c:106
> > 	 rcu_irq_enter_irqson+0x43/0x70 kernel/rcu/tree.c:1074
> > 	Lost 500 message(s)!
> > 	BUG: stack guard page was hit at 00000000cab483ba (stack is 00000000b1442365..00000000c26f9ad3)
> > 	BUG: stack guard page was hit at 00000000318ff8d8 (stack is 00000000fd87d656..0000000058100136)
> > 	---[ end trace 4157e0bb4a65941a ]---
> 
> Wheee... recursion! Let me try and see if I can make something of that.

All that's needed is enabling the preemptirq tracepoints. Lemme go fix.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
