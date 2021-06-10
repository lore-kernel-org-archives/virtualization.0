Return-Path: <SRS0=uiEo=LE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B69C48BE0
	for <virtualization@archiver.kernel.org>; Thu, 10 Jun 2021 11:30:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CB4D613FF
	for <virtualization@archiver.kernel.org>; Thu, 10 Jun 2021 11:30:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CB4D613FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F01B260861;
	Thu, 10 Jun 2021 11:30:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XzejqzOObWGc; Thu, 10 Jun 2021 11:30:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A07FB6084B;
	Thu, 10 Jun 2021 11:30:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 72BDEC000D;
	Thu, 10 Jun 2021 11:30:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 367E1C000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 11:30:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 12CBE403FA
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 11:30:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id or1quuY5m8R7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 11:30:32 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from theia.8bytes.org (8bytes.org
 [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0E12A403F8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 11:30:31 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 87206329; Thu, 10 Jun 2021 13:30:28 +0200 (CEST)
Date: Thu, 10 Jun 2021 13:30:27 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v4 3/6] x86/sev-es: Split up runtime #VC handler for
 correct state tracking
Message-ID: <YMH30/wFyE1JkKZg@8bytes.org>
References: <20210610091141.30322-1-joro@8bytes.org>
 <20210610091141.30322-4-joro@8bytes.org>
 <YMHnP1qgvznyYazv@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YMHnP1qgvznyYazv@hirez.programming.kicks-ass.net>
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

Hi Peter,

On Thu, Jun 10, 2021 at 12:19:43PM +0200, Peter Zijlstra wrote:
> On Thu, Jun 10, 2021 at 11:11:38AM +0200, Joerg Roedel wrote:
> 
> > +static void vc_handle_from_kernel(struct pt_regs *regs, unsigned long error_code)
> 
> static noinstr ...

Right, I forgot that, will update the patch and add the correct noinstr
annotations.

> > +	if (user_mode(regs))
> > +		vc_handle_from_user(regs, error_code);
> > +	else
> > +		vc_handle_from_kernel(regs, error_code);
> >  }
> 
> #DB and MCE use idtentry_mce_db and split out in asm. When I look at
> idtentry_vc, it appears to me that VC_SAFE_STACK already implies
> from-user, or am I reading that wrong?

VC_SAFE_STACK does not imply from-user. It means that the #VC handler
asm code was able to switch away from the IST stack to either the
task-stack (if from-user or syscall gap) or to the previous kernel
stack. There is a check in vc_switch_off_ist() that shows which stacks
are considered safe.

If it can not switch to a safe stack the VC entry code switches to the
fall-back stack and a special handler function is called, which for now
just panics the system.

> How about you don't do that and have exc_ call your new from_kernel
> function, then we know that safe_stack_ is always from-user. Then also
> maybe do:
> 
> 	s/VS_SAFE_STACK/VC_USER/
> 	s/safe_stack_/noist_/
> 
> to match all the others (#DB/MCE).

So #VC is different from #DB and #MCE in that it switches stacks even
when coming from kernel mode, so that the #VC handler can be nested.
What I can do is to call the from_user function directly from asm in
the .Lfrom_user_mode_switch_stack path. That will avoid having another
from_user check in C code.

> DEFINE_IDTENTRY_VC(exc_vc)
> {
> 	if (unlikely(on_vc_fallback_stack(regs))) {
> 		instrumentation_begin();
> 		panic("boohooo\n");
> 		instrumentation_end();

The on_vc_fallback_stack() path is for now only calling panic(), because
it can't be hit when the hypervisor is behaving correctly. In the future
it is not clear yet if that path needs to be extended for SNP page
validation exceptions, which can basically happen anywhere.

The implementation of SNP should make sure that all memory touched
during entry (while on unsafe stacks) is always validated, but not sure
yet if that holds when live-migration of SNP guests is added to the
picture.

There is the possibility that this doesn't fit in the above branch, but
it can also be moved to a separate function if needed.

> 	}
> 
> 	vc_from_kernel();
> }
> 
> DEFINE_IDTENTRY_VC_USER(exc_vc)
> {
> 	vc_from_user();
> }
> 
> Which is, I'm thinking, much simpler, no?

Okay, I am going to try this out. Thanks for your feedback.

Regards,

	Joerg
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
