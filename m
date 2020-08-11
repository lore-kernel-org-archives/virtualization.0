Return-Path: <SRS0=ofWe=BV=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29534C433E0
	for <virtualization@archiver.kernel.org>; Tue, 11 Aug 2020 08:12:26 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D77CB2065C
	for <virtualization@archiver.kernel.org>; Tue, 11 Aug 2020 08:12:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="X5W5zo0+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D77CB2065C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 41AF12040C;
	Tue, 11 Aug 2020 08:12:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3IlgTjhuHEoG; Tue, 11 Aug 2020 08:12:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id E1B2520117;
	Tue, 11 Aug 2020 08:12:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B658EC07FF;
	Tue, 11 Aug 2020 08:12:22 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 61F95C004D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Aug 2020 08:12:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 4A35085F4D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Aug 2020 08:12:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NmxCs83Y3Jg7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Aug 2020 08:12:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 9327484E7C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Aug 2020 08:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
 Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
 Sender:Reply-To:Content-ID:Content-Description;
 bh=Dh9BiEVz6epUQSvBxpIbJVz7h5uxpAes5kiPqWr2N0U=; b=X5W5zo0+0m8POb2sgcLnXP4bPg
 mk0vObilIOFyEj+A5HaEz+W1jDJt1wcG62Ovyz2EWSieVA+fS3grO2WfYNFeND3dKw6EA3l8YsF9t
 qtohHGWUKY5eaHpmYO7ANKECXrOSwRjyckhuDD4FrDcdAI5M5WICMmSlc20ps9Pg3BTFcaS1Ap98g
 WnN/ysi9XMStwYB8MxYQYf7J/65n0WMSp2+R1EkCxxztnL9XqMef/tUN8xKszVgPGRvxeeA4Pyi3l
 xuO3Td1khhxEdMkLFaeXx0ZRmriZCAYURHYuyRwZBCjAc0NFw0vAiWpEl+fYUHPhntl5sMGpQSrfT
 EJ7FWlYA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=worktop.programming.kicks-ass.net)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k5POA-00074x-1J; Tue, 11 Aug 2020 08:12:06 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
 id A3665980C9D; Tue, 11 Aug 2020 10:12:05 +0200 (CEST)
Date: Tue, 11 Aug 2020 10:12:05 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: =?iso-8859-1?Q?J=FCrgen_Gro=DF?= <jgross@suse.com>
Subject: Re: [PATCH] x86/paravirt: Add missing noinstr to arch_local*() helpers
Message-ID: <20200811081205.GV3982@worktop.programming.kicks-ass.net>
References: <CANpmjNO860SHpNve+vaoAOgarU1SWy8o--tUWCqNhn82OLCiew@mail.gmail.com>
 <fe2bfa7f-132f-7581-a967-d01d58be1588@suse.com>
 <20200807095032.GA3528289@elver.google.com>
 <16671cf3-3885-eb06-79ff-4cbfaeeaea79@suse.com>
 <20200807113838.GA3547125@elver.google.com>
 <e5bf3e6a-efff-7170-5ee6-1798008393a2@suse.com>
 <CANpmjNPau_DEYadey9OL+iFZKEaUTqnFnyFs1dU12o00mg7ofA@mail.gmail.com>
 <20200807151903.GA1263469@elver.google.com>
 <20200811074127.GR3982@worktop.programming.kicks-ass.net>
 <a2dffeeb-04f0-8042-b39a-b839c4800d6f@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a2dffeeb-04f0-8042-b39a-b839c4800d6f@suse.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: syzbot <syzbot+8db9e1ecde74e590a657@syzkaller.appspotmail.com>,
 fenghua.yu@intel.com, Marco Elver <elver@google.com>, "Luck,
 Tony" <tony.luck@intel.com>, "Paul E. McKenney" <paulmck@kernel.org>,
 yu-cheng.yu@intel.com, Dave Hansen <dave.hansen@linux.intel.com>,
 syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
 LKML <linux-kernel@vger.kernel.org>, kasan-dev <kasan-dev@googlegroups.com>,
 virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
 Thomas Gleixner <tglx@linutronix.de>, Wei Liu <wei.liu@kernel.org>,
 the arch/x86 maintainers <x86@kernel.org>
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

On Tue, Aug 11, 2020 at 09:57:55AM +0200, J=FCrgen Gro=DF wrote:
> On 11.08.20 09:41, Peter Zijlstra wrote:
> > On Fri, Aug 07, 2020 at 05:19:03PM +0200, Marco Elver wrote:
> > =

> > > My hypothesis here is simply that kvm_wait() may be called in a place
> > > where we get the same case I mentioned to Peter,
> > > =

> > > 	raw_local_irq_save(); /* or other IRQs off without tracing */
> > > 	...
> > > 	kvm_wait() /* IRQ state tracing gets confused */
> > > 	...
> > > 	raw_local_irq_restore();
> > > =

> > > and therefore, using raw variants in kvm_wait() works. It's also safe
> > > because it doesn't call any other libraries that would result in corr=
upt
> > =

> > Yes, this is definitely an issue.
> > =

> > Tracing, we also musn't call into tracing when using raw_local_irq_*().
> > Because then we re-intoduce this same issue all over again.
> > =

> > Both halt() and safe_halt() are more paravirt calls, but given we're in
> > a KVM paravirt call already, I suppose we can directly use native_*()
> > here.
> > =

> > Something like so then... I suppose, but then the Xen variants need TLC
> > too.
> =

> Just to be sure I understand you correct:
> =

> You mean that xen_qlock_kick() and xen_qlock_wait() and all functions
> called by those should gain the "notrace" attribute, right?
> =

> I am not sure why the kick variants need it, though. IMO those are
> called only after the lock has been released, so they should be fine
> without notrace.

The issue happens when someone uses arch_spinlock_t under
raw_local_irq_*().

> And again: we shouldn't forget the Hyper-V variants.

Bah, my grep failed :/ Also *groan*, that's calling apic->send_IPI().


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
