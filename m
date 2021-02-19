Return-Path: <SRS0=x/cL=HV=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7FFFC433DB
	for <virtualization@archiver.kernel.org>; Fri, 19 Feb 2021 11:06:02 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAB5D64E77
	for <virtualization@archiver.kernel.org>; Fri, 19 Feb 2021 11:06:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAB5D64E77
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 958FA86BA0;
	Fri, 19 Feb 2021 11:06:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TWaeFeBfWm2J; Fri, 19 Feb 2021 11:06:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 88CC286B33;
	Fri, 19 Feb 2021 11:06:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 510C5C000E;
	Fri, 19 Feb 2021 11:06:00 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E6B18C000D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Feb 2021 11:05:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id D913787484
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Feb 2021 11:05:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id D9VCWQJQEwfM
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Feb 2021 11:05:57 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 46EC187480
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Feb 2021 11:05:57 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id AAE9A295; Fri, 19 Feb 2021 12:05:54 +0100 (CET)
Date: Fri, 19 Feb 2021 12:05:49 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH 2/3] x86/sev-es: Check if regs->sp is trusted before
 adjusting #VC IST stack
Message-ID: <20210219110549.GI7302@8bytes.org>
References: <20210217120143.6106-1-joro@8bytes.org>
 <20210217120143.6106-3-joro@8bytes.org>
 <CALCETrWw-we3O4_upDoXJ4NzZHsBqNO69ht6nBp3y+QFhwPgKw@mail.gmail.com>
 <20210218112500.GH7302@8bytes.org>
 <CALCETrUohqQPVTBJZZKh-pj=4aZrwDAu5UFSetj3k5pGLDPbkA@mail.gmail.com>
 <20210218192117.GL12716@suse.de>
 <CALCETrUaOLwO51Js+OGNY03aep8BHoncZKTMr8sG1guUhLk40A@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CALCETrUaOLwO51Js+OGNY03aep8BHoncZKTMr8sG1guUhLk40A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: kvm list <kvm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Linux Virtualization <virtualization@lists.linux-foundation.org>,
 Arvind Sankar <nivedita@alum.mit.edu>, "H. Peter Anvin" <hpa@zytor.com>,
 Jiri Slaby <jslaby@suse.cz>, X86 ML <x86@kernel.org>,
 David Rientjes <rientjes@google.com>, Martin Radev <martin.b.radev@gmail.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, Joerg Roedel <jroedel@suse.de>,
 Kees Cook <keescook@chromium.org>, Cfir Cohen <cfir@google.com>,
 Dan Williams <dan.j.williams@intel.com>, Juergen Gross <jgross@suse.com>,
 Mike Stunes <mstunes@vmware.com>, Sean Christopherson <seanjc@google.com>,
 LKML <linux-kernel@vger.kernel.org>, stable <stable@vger.kernel.org>,
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

On Thu, Feb 18, 2021 at 04:28:36PM -0800, Andy Lutomirski wrote:
> On Thu, Feb 18, 2021 at 11:21 AM Joerg Roedel <jroedel@suse.de> wrote:
> Can you give me an example, even artificial, in which the linked-list
> logic is useful?

So here we go, its of course artificial, but still:

	1. #VC happens, not important where
	2. NMI in the #VC prologue before it moved off its IST stack
	   - first VC IST adjustment happening here
	3. #VC in the NMI handler
	4. #HV in the #VC prologue again
	   - second VC IST adjustment happening here, so the #HV handler
	     can cause its own #VC exceptions.

Can only happen if the #HV handler is allowed to cause #VC exceptions.
But even if its not allowed, it can happen with SNP and a malicious
Hypervisor. But in this case the only option is to reliably panic.

> Can you explain your reasoning in considering the entry stack unsafe?
> It's 4k bytes these days.

I wasn't aware that it is 4k in size now. I still thought it was just
these 64 words large and one can not simply execute C code on it.

> You forgot about entry_SYSCALL_compat.

Right, thanks for pointing this out.

> Your 8-byte alignment is confusing to me.  In valid kernel code, SP
> should be 8-byte-aligned already, and, if you're trying to match
> architectural behavior, the CPU aligns to 16 bytes.

Yeah, I was just being cautious. The explicit alignment can be removed,
Boris also pointed this out.

> We're not robust against #VC, NMI in the #VC prologue before the magic
> stack switch, and a new #VC in the NMI prologue.  Nor do we appear to
> have any detection of the case where #VC nests directly inside its own
> prologue.  Or did I miss something else here?

No, you don't miss anything here. At the moment #VC can't happen at
those places, so this is not handled yet. With SNP it can happen and
needs to be handled in a way to at least allow a reliable panic (because
if it really happens the Hypervisor is messing with us).

> If we get NMI and get #VC in the NMI *asm*, the #VC magic stack switch
> looks like it will merrily run itself in the NMI special-stack-layout
> section, and that sounds really quite bad.

Yes, I havn't looked at the details yet, but if a #VC happens there it
probably better not returns.


> I mean that, IIRC, a malicious hypervisor can inject inappropriate
> vectors at inappropriate times if the #HV mechanism isn't enabled.
> For example, it could inject a page fault or an interrupt in a context
> in which we have the wrong GSBASE loaded.

Yes, a malicious Hypervisor can do that, and without #HV there is no
real protection against this besides turning all vectors (even IRQs)
into paranoid entries. Maybe even more care is needed, but I think its
not worth to care about this. 

> But the #DB issue makes this moot.  We have to use IST unless we turn
> off SCE.  But I admit I'm leaning toward turning off SCE until we have
> a solution that seems convincingly robust.

Turning off SCE might be tempting, but I guess doing so would break a
quite some user-space code, no?

Regards,

	Joerg
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
