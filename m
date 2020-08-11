Return-Path: <SRS0=ofWe=BV=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 267B7C433E0
	for <virtualization@archiver.kernel.org>; Tue, 11 Aug 2020 09:47:21 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC92A20658
	for <virtualization@archiver.kernel.org>; Tue, 11 Aug 2020 09:47:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OsyDm2Ek"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC92A20658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 3F2A0204ED;
	Tue, 11 Aug 2020 09:47:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Seq1ThCQLJz4; Tue, 11 Aug 2020 09:47:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 6C954204A8;
	Tue, 11 Aug 2020 09:47:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4B25AC013C;
	Tue, 11 Aug 2020 09:47:17 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F1AF7C004D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Aug 2020 09:47:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id E763787B0E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Aug 2020 09:47:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HPHqbQpPQz1F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Aug 2020 09:47:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 07BF487A6B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Aug 2020 09:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
 Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
 Sender:Reply-To:Content-ID:Content-Description;
 bh=hSl2P/kJe9MOyfzAv0UR68V5yutSEkdzNefSktLECT8=; b=OsyDm2Ekl0cDY46XG1Trr/nZIv
 T0IQ5JaztHBdVxL5XXH9DNINH/MIrXlxMEkrgKJl0T60oJZZQhUs5NUpsePlamimQZh40oU92tdjZ
 SflhU2YmExOJNnt4tTSi1xbqYtNY9Wkifuntj7WDW/3P4j1wp67Pby/4Mgn5sxsk7ndEahdJzsHt6
 IJbDVrVJ72dQU84e72kiFYEnkFUf8ELU6T09P4eI8cyDlJMKNGfMS8mzedzS59IBlRjBQz8O1BT6+
 dJwHN3W7SYhWZQAXCvRa7++KDXUwQUgvGa/bRKI5lcDfJx2lBUgZ82vp/tFZFpVx+/YKlaIYuKAR7
 tWOrTqew==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=noisy.programming.kicks-ass.net)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k5Qrs-000387-KS; Tue, 11 Aug 2020 09:46:53 +0000
Received: from hirez.programming.kicks-ass.net
 (hirez.programming.kicks-ass.net [192.168.1.225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 660523003E5;
 Tue, 11 Aug 2020 11:46:51 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id 4D3E423FF6C69; Tue, 11 Aug 2020 11:46:51 +0200 (CEST)
Date: Tue, 11 Aug 2020 11:46:51 +0200
From: peterz@infradead.org
To: =?iso-8859-1?Q?J=FCrgen_Gro=DF?= <jgross@suse.com>
Subject: Re: [PATCH] x86/paravirt: Add missing noinstr to arch_local*() helpers
Message-ID: <20200811094651.GH35926@hirez.programming.kicks-ass.net>
References: <16671cf3-3885-eb06-79ff-4cbfaeeaea79@suse.com>
 <20200807113838.GA3547125@elver.google.com>
 <e5bf3e6a-efff-7170-5ee6-1798008393a2@suse.com>
 <CANpmjNPau_DEYadey9OL+iFZKEaUTqnFnyFs1dU12o00mg7ofA@mail.gmail.com>
 <20200807151903.GA1263469@elver.google.com>
 <20200811074127.GR3982@worktop.programming.kicks-ass.net>
 <a2dffeeb-04f0-8042-b39a-b839c4800d6f@suse.com>
 <20200811081205.GV3982@worktop.programming.kicks-ass.net>
 <07f61573-fef1-e07c-03f2-a415c88dec6f@suse.com>
 <20200811092054.GB2674@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200811092054.GB2674@hirez.programming.kicks-ass.net>
Cc: syzbot <syzbot+8db9e1ecde74e590a657@syzkaller.appspotmail.com>,
 fenghua.yu@intel.com, Marco Elver <elver@google.com>, "Luck,
 Tony" <tony.luck@intel.com>, "Paul E. McKenney" <paulmck@kernel.org>,
 yu-cheng.yu@intel.com, Dave Hansen <dave.hansen@linux.intel.com>,
 syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
 LKML <linux-kernel@vger.kernel.org>, kasan-dev <kasan-dev@googlegroups.com>,
 virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Steven Rostedt <rostedt@goodmis.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>,
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Tue, Aug 11, 2020 at 11:20:54AM +0200, peterz@infradead.org wrote:
> On Tue, Aug 11, 2020 at 10:38:50AM +0200, J=FCrgen Gro=DF wrote:
> > In case you don't want to do it I can send the patch for the Xen
> > variants.
> =

> I might've opened a whole new can of worms here. I'm not sure we
> can/want to fix the entire fallout this release :/
> =

> Let me ponder this a little, because the more I look at things, the more
> problems I keep finding... bah bah bah.

That is, most of these irq-tracking problem are new because commit:

  859d069ee1dd ("lockdep: Prepare for NMI IRQ state tracking")

changed irq-tracking to ignore the lockdep recursion count.

This then allows:

	lock_acquire()
	  raw_local_irq_save();
	  current->lockdep_recursion++;
	  trace_lock_acquire()
	   ... tracing ...
	     #PF under raw_local_irq_*()

	  __lock_acquire()
	    arch_spin_lock(&graph_lock)
	      pv-spinlock-wait()
	        local_irq_save() under raw_local_irq_*()

However afaict that just made a bad situation worse. There already were
issues, take for example:

  trace_clock_global()
    raw_local_irq_save();
    arch_spin_lock()
      pv-spinlock-wait
        local_irq_save()

And that has no lockdep_recursion to 'save' the say.

The tracing recursion does however avoid some of the obvious fails
there, like trace_clock calling into paravirt which then calls back into
tracing. But still, that would've caused IRQ tracking problems even with
the old code.

And in that respect, this is all the exact same problem as that other
set of patches has ( 20200807192336.405068898@infradead.org ).

Now, on the flip side, it does find actual problems, the trace_lock_*()
things were using RCU in RCU-disabled code, and here I found that
trace_clock_global() thinkg (and I suspect there's more of that).

But at this point I'm not entirelty sure how best to proceed... tracing
uses arch_spinlock_t, which means all spinlock implementations should be
notrace, but then that drops into paravirt and all hell breaks loose
because Hyper-V then calls into the APIC code etc.. etc..

At that rate we'll have the entire kernel marked notrace, and I'm fairly
sure that's not a solution either.

So let me once again see if I can't find a better solution for this all.
Clearly it needs one :/
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
