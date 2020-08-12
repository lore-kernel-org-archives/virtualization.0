Return-Path: <SRS0=QAK1=BW=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F27D6C433DF
	for <virtualization@archiver.kernel.org>; Wed, 12 Aug 2020 08:21:51 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE4EE20774
	for <virtualization@archiver.kernel.org>; Wed, 12 Aug 2020 08:21:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kTn2pnqI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE4EE20774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 7107B227A3;
	Wed, 12 Aug 2020 08:21:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KG1qF-lEOg50; Wed, 12 Aug 2020 08:21:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 46D75204B5;
	Wed, 12 Aug 2020 08:21:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 39751C07FF;
	Wed, 12 Aug 2020 08:21:49 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 16055C004D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Aug 2020 08:21:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id F1D7A860DE
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Aug 2020 08:21:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uDgww6Lfa5rC
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Aug 2020 08:21:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 914AE860B0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Aug 2020 08:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=JgBMrxFhpXh3xpWdoZXYK4da8LqJW1ikTR27jgesG/k=; b=kTn2pnqInJbU6VFHhlEzEJiFza
 iNeM2LqgEYKHtAhuLBQ2kSWOSGQz+7gJvBNPsixA/bLKhQMxkIyfRqQkdJFEKGO0BBCPcnytjTI1l
 21EQ6PoQdbshQxZB+vcLZicIrvMoGvJ1I/T4lHXqfqLjM32Xrj5BW+bkmvlc2ZzTkCvB4kiZTNm8D
 Aglia5uM4vHo2WZsz/txGeq/wZkOpZ/5VLg89D1RT9K2V+7fvR6HpuQjl4tnYqiHlqhnK5SyU7jDc
 wZZh5h5ubs1pb8xS7yAuFEQFVUBKb73IoTtIB4ovsCsnuSR5stZZJF335zM/wrE9Ub9AI8uUxltOX
 2AN1pmRg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=noisy.programming.kicks-ass.net)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k5lxz-0001nH-73; Wed, 12 Aug 2020 08:18:55 +0000
Received: from hirez.programming.kicks-ass.net
 (hirez.programming.kicks-ass.net [192.168.1.225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7D08D300238;
 Wed, 12 Aug 2020 10:18:32 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id 6679022281190; Wed, 12 Aug 2020 10:18:32 +0200 (CEST)
Date: Wed, 12 Aug 2020 10:18:32 +0200
From: peterz@infradead.org
To: Marco Elver <elver@google.com>
Subject: Re: [PATCH] x86/paravirt: Add missing noinstr to arch_local*() helpers
Message-ID: <20200812081832.GK2674@hirez.programming.kicks-ass.net>
References: <CANpmjNPau_DEYadey9OL+iFZKEaUTqnFnyFs1dU12o00mg7ofA@mail.gmail.com>
 <20200807151903.GA1263469@elver.google.com>
 <20200811074127.GR3982@worktop.programming.kicks-ass.net>
 <a2dffeeb-04f0-8042-b39a-b839c4800d6f@suse.com>
 <20200811081205.GV3982@worktop.programming.kicks-ass.net>
 <07f61573-fef1-e07c-03f2-a415c88dec6f@suse.com>
 <20200811092054.GB2674@hirez.programming.kicks-ass.net>
 <20200811094651.GH35926@hirez.programming.kicks-ass.net>
 <20200811201755.GI35926@hirez.programming.kicks-ass.net>
 <20200812080650.GA3894595@elver.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200812080650.GA3894595@elver.google.com>
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

On Wed, Aug 12, 2020 at 10:06:50AM +0200, Marco Elver wrote:
> On Tue, Aug 11, 2020 at 10:17PM +0200, peterz@infradead.org wrote:
> > On Tue, Aug 11, 2020 at 11:46:51AM +0200, peterz@infradead.org wrote:
> > 
> > > So let me once again see if I can't find a better solution for this all.
> > > Clearly it needs one :/
> > 
> > So the below boots without triggering the debug code from Marco -- it
> > should allow nesting local_irq_save/restore under raw_local_irq_*().
> > 
> > I tried unconditional counting, but there's some _reallly_ wonky /
> > asymmetric code that wrecks that and I've not been able to come up with
> > anything useful.
> > 
> > This one starts counting when local_irq_save() finds it didn't disable
> > IRQs while lockdep though it did. At that point, local_irq_restore()
> > will decrement and enable things again when it reaches 0.
> > 
> > This assumes local_irq_save()/local_irq_restore() are nested sane, which
> > is mostly true.
> > 
> > This leaves #PF, which I fixed in these other patches, but I realized it
> > needs fixing for all architectures :-( No bright ideas there yet.
> > 
> > ---
> >  arch/x86/entry/thunk_32.S       |  5 ----
> >  include/linux/irqflags.h        | 45 +++++++++++++++++++-------------
> >  init/main.c                     | 16 ++++++++++++
> >  kernel/locking/lockdep.c        | 58 +++++++++++++++++++++++++++++++++++++++++
> >  kernel/trace/trace_preemptirq.c | 33 +++++++++++++++++++++++
> >  5 files changed, 134 insertions(+), 23 deletions(-)
> 
> Testing this again with syzkaller produced some new reports:
> 
> 	BUG: stack guard page was hit in error_entry
> 	BUG: stack guard page was hit in exc_int3
> 	PANIC: double fault in error_entry
> 	PANIC: double fault in exc_int3
> 
> Most of them have corrupted reports, but this one might be useful:
> 
> 	BUG: stack guard page was hit at 000000001fab0982 (stack is 00000000063f33dc..00000000bf04b0d8)
> 	BUG: stack guard page was hit at 00000000ca97ac69 (stack is 00000000af3e6c84..000000001597e1bf)
> 	kernel stack overflow (double-fault): 0000 [#1] PREEMPT SMP
> 	CPU: 1 PID: 4709 Comm: kworker/1:1H Not tainted 5.8.0+ #5
> 	Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1 04/01/2014
> 	Workqueue: events_highpri snd_vmidi_output_work
> 	RIP: 0010:exc_int3+0x5/0xf0 arch/x86/kernel/traps.c:636
> 	Code: c9 85 4d 89 e8 31 c0 e8 a9 7d 68 fd e9 90 fe ff ff e8 0f 35 00 00 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 55 53 48 89 fb <e8> 76 0e 00 00 85 c0 74 03 5b 5d c3 f6 83 88 00 00 00 03 74 7e 48
> 	RSP: 0018:ffffc90008114000 EFLAGS: 00010083
> 	RAX: 0000000084e00e17 RBX: ffffc90008114018 RCX: ffffffff84e00e17
> 	RDX: 0000000000000000 RSI: ffffffff84e00a39 RDI: ffffc90008114018
> 	RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> 	R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> 	R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> 	FS:  0000000000000000(0000) GS:ffff88807dc80000(0000) knlGS:0000000000000000
> 	CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> 	CR2: ffffc90008113ff8 CR3: 000000002dae4006 CR4: 0000000000770ee0
> 	DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> 	DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> 	PKRU: 00000000
> 	Call Trace:
> 	 asm_exc_int3+0x31/0x40 arch/x86/include/asm/idtentry.h:537
> 	RIP: 0010:arch_static_branch include/trace/events/preemptirq.h:40 [inline]
> 	RIP: 0010:static_key_false include/linux/jump_label.h:200 [inline]
> 	RIP: 0010:trace_irq_enable_rcuidle+0xd/0x120 include/trace/events/preemptirq.h:40
> 	Code: 24 08 48 89 df e8 43 8d ef ff 48 89 df 5b e9 4a 2e 99 03 66 2e 0f 1f 84 00 00 00 00 00 55 41 56 53 48 89 fb e8 84 1a fd ff cc <1f> 44 00 00 5b 41 5e 5d c3 65 8b 05 ab 74 c3 7e 89 c0 31 f6 48 0f
> 	RSP: 0018:ffffc900081140f8 EFLAGS: 00000093
> 	RAX: ffffffff813d9e8c RBX: ffffffff81314dd3 RCX: ffff888076ce6000
> 	RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff81314dd3
> 	RBP: 0000000000000000 R08: ffffffff813da3d4 R09: 0000000000000001
> 	R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> 	R13: 0000000000000082 R14: 0000000000000000 R15: ffff888076ce6000
> 	 trace_hardirqs_restore+0x59/0x80 kernel/trace/trace_preemptirq.c:106
> 	 rcu_irq_enter_irqson+0x43/0x70 kernel/rcu/tree.c:1074
> 	 trace_irq_enable_rcuidle+0x87/0x120 include/trace/events/preemptirq.h:40
> 	 trace_hardirqs_restore+0x59/0x80 kernel/trace/trace_preemptirq.c:106
> 	 rcu_irq_enter_irqson+0x43/0x70 kernel/rcu/tree.c:1074
> 	 trace_irq_enable_rcuidle+0x87/0x120 include/trace/events/preemptirq.h:40
> 	 trace_hardirqs_restore+0x59/0x80 kernel/trace/trace_preemptirq.c:106
> 	 rcu_irq_enter_irqson+0x43/0x70 kernel/rcu/tree.c:1074
> 	 trace_irq_enable_rcuidle+0x87/0x120 include/trace/events/preemptirq.h:40
> 	 trace_hardirqs_restore+0x59/0x80 kernel/trace/trace_preemptirq.c:106
> 	 rcu_irq_enter_irqson+0x43/0x70 kernel/rcu/tree.c:1074
> 
> 	<... repeated many many times ...>
> 
> 	 trace_irq_enable_rcuidle+0x87/0x120 include/trace/events/preemptirq.h:40
> 	 trace_hardirqs_restore+0x59/0x80 kernel/trace/trace_preemptirq.c:106
> 	 rcu_irq_enter_irqson+0x43/0x70 kernel/rcu/tree.c:1074
> 	Lost 500 message(s)!
> 	BUG: stack guard page was hit at 00000000cab483ba (stack is 00000000b1442365..00000000c26f9ad3)
> 	BUG: stack guard page was hit at 00000000318ff8d8 (stack is 00000000fd87d656..0000000058100136)
> 	---[ end trace 4157e0bb4a65941a ]---

Wheee... recursion! Let me try and see if I can make something of that.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
