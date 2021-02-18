Return-Path: <SRS0=I+ly=HU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E046AC433E0
	for <virtualization@archiver.kernel.org>; Thu, 18 Feb 2021 19:21:27 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 213C564E6F
	for <virtualization@archiver.kernel.org>; Thu, 18 Feb 2021 19:21:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 213C564E6F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 64A648693C;
	Thu, 18 Feb 2021 19:21:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NoFxJs76IS0H; Thu, 18 Feb 2021 19:21:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C16148688C;
	Thu, 18 Feb 2021 19:21:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 89474C000E;
	Thu, 18 Feb 2021 19:21:25 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6BD54C000D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Feb 2021 19:21:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 527FB8691E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Feb 2021 19:21:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OxH4lj6sD5DK
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Feb 2021 19:21:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 172908688C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Feb 2021 19:21:22 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id AC386AED2;
 Thu, 18 Feb 2021 19:21:19 +0000 (UTC)
Date: Thu, 18 Feb 2021 20:21:17 +0100
From: Joerg Roedel <jroedel@suse.de>
To: Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH 2/3] x86/sev-es: Check if regs->sp is trusted before
 adjusting #VC IST stack
Message-ID: <20210218192117.GL12716@suse.de>
References: <20210217120143.6106-1-joro@8bytes.org>
 <20210217120143.6106-3-joro@8bytes.org>
 <CALCETrWw-we3O4_upDoXJ4NzZHsBqNO69ht6nBp3y+QFhwPgKw@mail.gmail.com>
 <20210218112500.GH7302@8bytes.org>
 <CALCETrUohqQPVTBJZZKh-pj=4aZrwDAu5UFSetj3k5pGLDPbkA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CALCETrUohqQPVTBJZZKh-pj=4aZrwDAu5UFSetj3k5pGLDPbkA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: kvm list <kvm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Linux Virtualization <virtualization@lists.linux-foundation.org>,
 Arvind Sankar <nivedita@alum.mit.edu>, "H. Peter Anvin" <hpa@zytor.com>,
 Jiri Slaby <jslaby@suse.cz>, Joerg Roedel <joro@8bytes.org>,
 X86 ML <x86@kernel.org>, David Rientjes <rientjes@google.com>,
 Martin Radev <martin.b.radev@gmail.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, Kees Cook <keescook@chromium.org>,
 Cfir Cohen <cfir@google.com>, Dan Williams <dan.j.williams@intel.com>,
 Juergen Gross <jgross@suse.com>, Mike Stunes <mstunes@vmware.com>,
 Sean Christopherson <seanjc@google.com>, LKML <linux-kernel@vger.kernel.org>,
 stable <stable@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
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

On Thu, Feb 18, 2021 at 09:49:06AM -0800, Andy Lutomirski wrote:
> I don't understand what this means.  The whole entry mechanism on x86
> is structured so that we call a C function *and return from that C
> function without longjmp-like magic* with the sole exception of
> unwind_stack_do_exit().  This means that you can match up enters and
> exits, and that unwind_stack_do_exit() needs to unwind correctly.  In
> the former case, it's normal C and we can use normal local variables.
> In the latter case, we know exactly what state we're trying to restore
> and we can restore it directly without any linked lists or similar.

Okay, the unwinder will likely get confused by this logic.

> What do you have in mind that requires a linked list?

Cases when there are multiple IST vectors besides NMI that can hit while
the #VC handler is still on its own IST stack. #MCE comes to mind, but
that is broken anyway. At some point #VC itself will be one of them, but
when that happens the code will kill the machine.
This leaves #HV in the list, and I am not sure how that is going to be
handled yet. I think the goal is that the #HV handler is not allowed to
cause any #VC exception. In that case the linked-list logic will not be
needed.

> > I don't see how this would break, can you elaborate?
> >
> > What I think happens is:
> >
> > SYSCALL gap (RSP is from userspace and untrusted)
> >
> >         -> #VC - Handler on #VC IST stack detects that it interrupted
> >            the SYSCALL gap and switches to the task stack.
> >
> 
> Can you point me to exactly what code you're referring to?  I spent a
> while digging through the code and macro tangle and I can't find this.

See the entry code in arch/x86/entry/entry_64.S, macro idtentry_vc. It
creates the assembly code for the handler. At some point it calls
vc_switch_off_ist(), which is a C function in arch/x86/kernel/traps.c.
This function tries to find a new stack for the #VC handler.

The first thing it does is checking whether the exception came from the
SYSCALL gap and just uses the task stack in that case.

Then it will check for other kernel stacks which are safe to switch
to. If that fails it uses the fall-back stack (VC2), which will direct
the handler to a separate function which, for now, just calls panic().
Not safe are the entry or unknown stacks.

The function then copies pt_regs and returns the new stack pointer to
assembly code, which then writes it to %RSP.

> Unless AMD is more magic than I realize, the MOV SS bug^Wfeature means
> that #DB is *not* always called in safe places.

You are right, forgot about this. The MOV SS bug can very well
trigger a #VC(#DB) exception from the syscall gap.

> > And with SNP we need to be able to at least detect a malicious HV so we
> > can reliably kill the guest. Otherwise the HV could potentially take
> > control over the guest's execution flow and make it reveal its secrets.
> 
> True.  But is the rest of the machinery to be secure against EFLAGS.IF
> violations and such in place yet?

Not sure what you mean by EFLAGS.IF violations, probably enabling IRQs
while in the #VC handler? The #VC handler _must_ _not_ enable IRQs
anywhere in its call-path. If that ever happens it is a bug.

Regards,

	Joerg
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
