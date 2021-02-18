Return-Path: <SRS0=I+ly=HU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E499C433E0
	for <virtualization@archiver.kernel.org>; Thu, 18 Feb 2021 11:25:13 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA48064E4B
	for <virtualization@archiver.kernel.org>; Thu, 18 Feb 2021 11:25:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA48064E4B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 620D386432;
	Thu, 18 Feb 2021 11:25:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yhClLuBSJZ4c; Thu, 18 Feb 2021 11:25:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 9B8BB862D4;
	Thu, 18 Feb 2021 11:25:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 89DD2C000F;
	Thu, 18 Feb 2021 11:25:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 32089C000D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Feb 2021 11:25:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 239FC605D9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Feb 2021 11:25:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YxQaUaBlvHgH
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Feb 2021 11:25:09 +0000 (UTC)
Received: by smtp3.osuosl.org (Postfix, from userid 1001)
 id 3DCFD605F7; Thu, 18 Feb 2021 11:25:09 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A0A1E605F2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Feb 2021 11:25:07 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 017B6247; Thu, 18 Feb 2021 12:25:03 +0100 (CET)
Date: Thu, 18 Feb 2021 12:25:00 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH 2/3] x86/sev-es: Check if regs->sp is trusted before
 adjusting #VC IST stack
Message-ID: <20210218112500.GH7302@8bytes.org>
References: <20210217120143.6106-1-joro@8bytes.org>
 <20210217120143.6106-3-joro@8bytes.org>
 <CALCETrWw-we3O4_upDoXJ4NzZHsBqNO69ht6nBp3y+QFhwPgKw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CALCETrWw-we3O4_upDoXJ4NzZHsBqNO69ht6nBp3y+QFhwPgKw@mail.gmail.com>
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

Hi Andy,

On Wed, Feb 17, 2021 at 10:09:46AM -0800, Andy Lutomirski wrote:
> Can you get rid of the linked list hack while you're at it?  This code
> is unnecessarily convoluted right now, and it seems to be just asking
> for weird bugs.  Just stash the old value in a local variable, please.

Yeah, the linked list is not really necessary right now, because of the
way nested NMI handling works and given that these functions are only
used in the NMI handler right now.
The whole #VC handling code was written with future requirements in
mind, like what is needed when debugging registers get virtualized and
#HV gets enabled.
Until its clear whether __sev_es_ist_enter/exit() is needed in any of
these paths, I'd like to keep the linked list for now. It is more
complicated but allows nesting.

> Meanwhile, I'm pretty sure I can break this whole scheme if the
> hypervisor is messing with us.  As a trivial example, the sequence
> SYSCALL gap -> #VC -> NMI -> #VC will go quite poorly.

I don't see how this would break, can you elaborate?

What I think happens is:

SYSCALL gap (RSP is from userspace and untrusted)

	-> #VC - Handler on #VC IST stack detects that it interrupted
	   the SYSCALL gap and switches to the task stack.


	-> NMI - Now running on NMI IST stack. Depending on whether the
	   stack switch in the #VC handler already happened, the #VC IST
	   entry is adjusted so that a subsequent #VC will not overwrite
	   the interrupted handlers stack frame.

	-> #VC - Handler runs on the adjusted #VC IST stack and switches
	   itself back to the NMI IST stack. This is safe wrt. nested
	   NMIs as long as nested NMIs itself are safe.

As a rule of thumb, think of the #VC handler as trying to be a non-IST
handler by switching itself to the interrupted stack or the task stack.
If it detects that this is not possible (which can't happen right now,
but with SNP), it will kill the guest.

Also #VC is currently not safe against #MC, but this is the same as with
NMI and #MC. And more care is needed when SNP gets enabled and #VCs can
happen in the stack switching/stack adjustment code itself. I will
probably just add a check then to kill the guest if an SNP related #VC
comes from noinstr code.

> Is this really better than just turning IST off for #VC and
> documenting that we are not secure against a malicious hypervisor yet?

It needs to be IST, even without SNP, because #DB is IST too. When the
hypervisor intercepts #DB then any #DB exception will be turned into
#VC, so #VC needs to be handled anywhere a #DB can happen.

And with SNP we need to be able to at least detect a malicious HV so we
can reliably kill the guest. Otherwise the HV could potentially take
control over the guest's execution flow and make it reveal its secrets.

Regards,

	Joerg
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
