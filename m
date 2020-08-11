Return-Path: <SRS0=ofWe=BV=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 157DDC433E0
	for <virtualization@archiver.kernel.org>; Tue, 11 Aug 2020 07:58:02 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFEE6206B2
	for <virtualization@archiver.kernel.org>; Tue, 11 Aug 2020 07:58:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFEE6206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 56941203E5;
	Tue, 11 Aug 2020 07:58:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5PmTwo9xMgFJ; Tue, 11 Aug 2020 07:58:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 33E3720398;
	Tue, 11 Aug 2020 07:58:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 141ACC07FF;
	Tue, 11 Aug 2020 07:58:00 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 20786C004D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Aug 2020 07:57:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 154A187B3D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Aug 2020 07:57:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AFKmHwbE8-er
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Aug 2020 07:57:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 3ECA587B0E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Aug 2020 07:57:58 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 66B9BAB9F;
 Tue, 11 Aug 2020 07:58:17 +0000 (UTC)
Subject: Re: [PATCH] x86/paravirt: Add missing noinstr to arch_local*() helpers
To: Peter Zijlstra <peterz@infradead.org>, Marco Elver <elver@google.com>
References: <20200806131702.GA3029162@elver.google.com>
 <CANpmjNNqt8YrCad4WqgCoXvH47pRXtSLpnTKhD8W8+UpoYJ+jQ@mail.gmail.com>
 <CANpmjNO860SHpNve+vaoAOgarU1SWy8o--tUWCqNhn82OLCiew@mail.gmail.com>
 <fe2bfa7f-132f-7581-a967-d01d58be1588@suse.com>
 <20200807095032.GA3528289@elver.google.com>
 <16671cf3-3885-eb06-79ff-4cbfaeeaea79@suse.com>
 <20200807113838.GA3547125@elver.google.com>
 <e5bf3e6a-efff-7170-5ee6-1798008393a2@suse.com>
 <CANpmjNPau_DEYadey9OL+iFZKEaUTqnFnyFs1dU12o00mg7ofA@mail.gmail.com>
 <20200807151903.GA1263469@elver.google.com>
 <20200811074127.GR3982@worktop.programming.kicks-ass.net>
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <a2dffeeb-04f0-8042-b39a-b839c4800d6f@suse.com>
Date: Tue, 11 Aug 2020 09:57:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200811074127.GR3982@worktop.programming.kicks-ass.net>
Content-Language: en-US
Cc: syzbot <syzbot+8db9e1ecde74e590a657@syzkaller.appspotmail.com>,
 fenghua.yu@intel.com, yu-cheng.yu@intel.com, "Luck,
 Tony" <tony.luck@intel.com>, "Paul E. McKenney" <paulmck@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On 11.08.20 09:41, Peter Zijlstra wrote:
> On Fri, Aug 07, 2020 at 05:19:03PM +0200, Marco Elver wrote:
> 
>> My hypothesis here is simply that kvm_wait() may be called in a place
>> where we get the same case I mentioned to Peter,
>>
>> 	raw_local_irq_save(); /* or other IRQs off without tracing */
>> 	...
>> 	kvm_wait() /* IRQ state tracing gets confused */
>> 	...
>> 	raw_local_irq_restore();
>>
>> and therefore, using raw variants in kvm_wait() works. It's also safe
>> because it doesn't call any other libraries that would result in corrupt
> 
> Yes, this is definitely an issue.
> 
> Tracing, we also musn't call into tracing when using raw_local_irq_*().
> Because then we re-intoduce this same issue all over again.
> 
> Both halt() and safe_halt() are more paravirt calls, but given we're in
> a KVM paravirt call already, I suppose we can directly use native_*()
> here.
> 
> Something like so then... I suppose, but then the Xen variants need TLC
> too.

Just to be sure I understand you correct:

You mean that xen_qlock_kick() and xen_qlock_wait() and all functions
called by those should gain the "notrace" attribute, right?

I am not sure why the kick variants need it, though. IMO those are
called only after the lock has been released, so they should be fine
without notrace.

And again: we shouldn't forget the Hyper-V variants.


Juergen
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
