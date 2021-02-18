Return-Path: <SRS0=I+ly=HU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 064E0C433DB
	for <virtualization@archiver.kernel.org>; Thu, 18 Feb 2021 17:49:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E9CB64EAF
	for <virtualization@archiver.kernel.org>; Thu, 18 Feb 2021 17:49:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E9CB64EAF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E167D60664
	for <virtualization@archiver.kernel.org>; Thu, 18 Feb 2021 17:49:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id esBO0AXS9qzo for <virtualization@archiver.kernel.org>;
	Thu, 18 Feb 2021 17:49:31 +0000 (UTC)
Received: by smtp3.osuosl.org (Postfix, from userid 1001)
	id E98666067B; Thu, 18 Feb 2021 17:49:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id D807F60628;
	Thu, 18 Feb 2021 17:49:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A96C2C000E;
	Thu, 18 Feb 2021 17:49:23 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E2E90C000D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Feb 2021 17:49:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id D193086EA3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Feb 2021 17:49:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id acuzTH7w5YOR
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Feb 2021 17:49:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 063C886E9E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Feb 2021 17:49:22 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1ED3964EC0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Feb 2021 17:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1613670561;
 bh=S9HE1UIVHUZqDSOtYFkGj6UL4dBAx+REIzCSaf9/6jc=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=s7bhIMQZdYrG115ebgBKzwl67Mff9DzrFYN7FBNnFvbaYIpVQsBRPRLjt5la2sqql
 HofxG61fNGWR5NSXUJAVA3F24wHCq2KZWx2NfTdppplelzOyi9oZFIW+xAAJ7Z9CYo
 qQD5ZelrwNt0dE8TsJSPnzQ2RY6z80va1NYTrIqaebkWdWIQhZSDTMmh4HWzXUTAc1
 WqQx0UgPovE8pAUPgG0jZSluzgLarSDOT1M2KgSUu1ZIzKVaf2BG+Cmu+Q783dEdMc
 n/dIDW/5TxMrn4rMqcWawfXKKkxttuwxbiAw4yblW9egVcdvq+nU3J2n9Q6up3qBc6
 xSV1GYkvB9Irw==
Received: by mail-lj1-f175.google.com with SMTP id j6so6734863ljo.5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Feb 2021 09:49:21 -0800 (PST)
X-Gm-Message-State: AOAM531uK6rIihQDex7/aYwBNHYYgtEcymofzWdvLGvvLwgTPBs2qlvw
 1HloHTTwNZPaax4/7J9qeOx/CUEYSPuKlYvF6SR7PA==
X-Google-Smtp-Source: ABdhPJwj3aEDXoeyomFpvPGRsKjYAWGF9foiPbsnT1S5rrYJDU4WAyOZvJVqaV0lfVp5BLdNddsftppBTtCUMQqxZB4=
X-Received: by 2002:a17:906:d10d:: with SMTP id
 b13mr4988544ejz.204.1613670557791; 
 Thu, 18 Feb 2021 09:49:17 -0800 (PST)
MIME-Version: 1.0
References: <20210217120143.6106-1-joro@8bytes.org>
 <20210217120143.6106-3-joro@8bytes.org>
 <CALCETrWw-we3O4_upDoXJ4NzZHsBqNO69ht6nBp3y+QFhwPgKw@mail.gmail.com>
 <20210218112500.GH7302@8bytes.org>
In-Reply-To: <20210218112500.GH7302@8bytes.org>
From: Andy Lutomirski <luto@kernel.org>
Date: Thu, 18 Feb 2021 09:49:06 -0800
X-Gmail-Original-Message-ID: <CALCETrUohqQPVTBJZZKh-pj=4aZrwDAu5UFSetj3k5pGLDPbkA@mail.gmail.com>
Message-ID: <CALCETrUohqQPVTBJZZKh-pj=4aZrwDAu5UFSetj3k5pGLDPbkA@mail.gmail.com>
Subject: Re: [PATCH 2/3] x86/sev-es: Check if regs->sp is trusted before
 adjusting #VC IST stack
To: Joerg Roedel <joro@8bytes.org>
Cc: kvm list <kvm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Linux Virtualization <virtualization@lists.linux-foundation.org>,
 Arvind Sankar <nivedita@alum.mit.edu>, "H. Peter Anvin" <hpa@zytor.com>,
 Jiri Slaby <jslaby@suse.cz>, X86 ML <x86@kernel.org>,
 David Rientjes <rientjes@google.com>, Martin Radev <martin.b.radev@gmail.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, Joerg Roedel <jroedel@suse.de>,
 Kees Cook <keescook@chromium.org>, Cfir Cohen <cfir@google.com>,
 Andy Lutomirski <luto@kernel.org>, Dan Williams <dan.j.williams@intel.com>,
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

On Thu, Feb 18, 2021 at 3:25 AM Joerg Roedel <joro@8bytes.org> wrote:
>
> Hi Andy,
>
> On Wed, Feb 17, 2021 at 10:09:46AM -0800, Andy Lutomirski wrote:
> > Can you get rid of the linked list hack while you're at it?  This code
> > is unnecessarily convoluted right now, and it seems to be just asking
> > for weird bugs.  Just stash the old value in a local variable, please.
>
> Yeah, the linked list is not really necessary right now, because of the
> way nested NMI handling works and given that these functions are only
> used in the NMI handler right now.
> The whole #VC handling code was written with future requirements in
> mind, like what is needed when debugging registers get virtualized and
> #HV gets enabled.
> Until its clear whether __sev_es_ist_enter/exit() is needed in any of
> these paths, I'd like to keep the linked list for now. It is more
> complicated but allows nesting.

I don't understand what this means.  The whole entry mechanism on x86
is structured so that we call a C function *and return from that C
function without longjmp-like magic* with the sole exception of
unwind_stack_do_exit().  This means that you can match up enters and
exits, and that unwind_stack_do_exit() needs to unwind correctly.  In
the former case, it's normal C and we can use normal local variables.
In the latter case, we know exactly what state we're trying to restore
and we can restore it directly without any linked lists or similar.

What do you have in mind that requires a linked list?

>
> > Meanwhile, I'm pretty sure I can break this whole scheme if the
> > hypervisor is messing with us.  As a trivial example, the sequence
> > SYSCALL gap -> #VC -> NMI -> #VC will go quite poorly.
>
> I don't see how this would break, can you elaborate?
>
> What I think happens is:
>
> SYSCALL gap (RSP is from userspace and untrusted)
>
>         -> #VC - Handler on #VC IST stack detects that it interrupted
>            the SYSCALL gap and switches to the task stack.
>

Can you point me to exactly what code you're referring to?  I spent a
while digging through the code and macro tangle and I can't find this.

>
>         -> NMI - Now running on NMI IST stack. Depending on whether the
>            stack switch in the #VC handler already happened, the #VC IST
>            entry is adjusted so that a subsequent #VC will not overwrite
>            the interrupted handlers stack frame.
>
>         -> #VC - Handler runs on the adjusted #VC IST stack and switches
>            itself back to the NMI IST stack. This is safe wrt. nested
>            NMIs as long as nested NMIs itself are safe.
>
> As a rule of thumb, think of the #VC handler as trying to be a non-IST
> handler by switching itself to the interrupted stack or the task stack.
> If it detects that this is not possible (which can't happen right now,
> but with SNP), it will kill the guest.

I will try to think of this, but it's hard, since I can't find the code :)

I found this comment:

 * With the current implementation it is always possible to switch to a safe
 * stack because #VC exceptions only happen at known places, like intercepted
 * instructions or accesses to MMIO areas/IO ports. They can also happen with
 * code instrumentation when the hypervisor intercepts #DB, but the critical
 * paths are forbidden to be instrumented, so #DB exceptions currently also
 * only happen in safe places.

Unless AMD is more magic than I realize, the MOV SS bug^Wfeature means
that #DB is *not* always called in safe places.

But I *thnk* the code you're talking about is this:

    /*
     * If the entry is from userspace, switch stacks and treat it as
     * a normal entry.
     */
    testb    $3, CS-ORIG_RAX(%rsp)
    jnz    .Lfrom_usermode_switch_stack_\@

which does not run on #VC from kernel code.

> It needs to be IST, even without SNP, because #DB is IST too. When the
> hypervisor intercepts #DB then any #DB exception will be turned into
> #VC, so #VC needs to be handled anywhere a #DB can happen.

Eww.

>
> And with SNP we need to be able to at least detect a malicious HV so we
> can reliably kill the guest. Otherwise the HV could potentially take
> control over the guest's execution flow and make it reveal its secrets.

True.  But is the rest of the machinery to be secure against EFLAGS.IF
violations and such in place yet?

>
> Regards,
>
>         Joerg
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
