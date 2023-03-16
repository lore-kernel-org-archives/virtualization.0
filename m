Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BC11C6FD1F
	for <virtualization@archiver.kernel.org>; Thu, 16 Mar 2023 16:50:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 97CE942284;
	Thu, 16 Mar 2023 16:50:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 97CE942284
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=dkim header.b=c6WU9pCF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8TeXlTDWeG_4; Thu, 16 Mar 2023 16:50:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id CE4DA400E2;
	Thu, 16 Mar 2023 16:50:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CE4DA400E2
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 82EEBC0071;
	Thu, 16 Mar 2023 16:50:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7BE3AC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Mar 2023 16:50:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 502DF6132A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Mar 2023 16:50:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 502DF6132A
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de
 header.a=rsa-sha256 header.s=dkim header.b=c6WU9pCF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id keEClZLY_Ukt
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Mar 2023 16:50:26 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F06F661329
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F06F661329
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Mar 2023 16:50:25 +0000 (UTC)
Received: from zn.tnic (p5de8e687.dip0.t-ipconnect.de [93.232.230.135])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4E29D1EC069C;
 Thu, 16 Mar 2023 17:50:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1678985422;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
 bh=pvZfB3xEnFcv+kVn5Kmi9T4R22mO6xRhrZ8tN35T6bI=;
 b=c6WU9pCFsaHPMrROvxfoSDtYYbTTdTt+tEDbv37vsvdKXCfFvyrLk8l9rUjm93Hi9CJk4U
 JXe1OfjoIhYKtJaBPE6FKs0bL+3+wYRyY2MOVZGXZQ4fzci2yYKrtUFNsbce26+jqi+b6H
 GquPvLw+ksxPAyeddaaOabOcNvDasp4=
Date: Thu, 16 Mar 2023 17:50:17 +0100
From: Borislav Petkov <bp@alien8.de>
To: Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH] x86/paravirt: convert simple paravirt functions to asm
Message-ID: <20230316165017.GAZBNIyTYanBKqe0ip@fat_crate.local>
References: <20230308154210.18454-1-jgross@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230308154210.18454-1-jgross@suse.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 VMware PV-Drivers Reviewers <pv-drivers@vmware.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Ingo Molnar <mingo@redhat.com>, Alexey Makhalov <amakhalov@vmware.com>,
 Thomas Gleixner <tglx@linutronix.de>
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

On Wed, Mar 08, 2023 at 04:42:10PM +0100, Juergen Gross wrote:
> All functions referenced via __PV_IS_CALLEE_SAVE() need to be assembler
> functions, as those functions calls are hidden from gcc. In case the
> kernel is compiled with "-fzero-call-used-regs" the compiler will
> clobber caller-saved registers at the end of C functions, which will
> result in unexpectedly zeroed registers at the call site of the
> related paravirt functions.
> 
> Replace the C functions with DEFINE_PARAVIRT_ASM() constructs using
> the same instructions as the related paravirt calls in the
> PVOP_ALT_[V]CALLEE*() macros.
> 
> Signed-off-by: Juergen Gross <jgross@suse.com>
> ---
>  arch/x86/include/asm/paravirt_types.h |  8 +++++++-
>  arch/x86/kernel/paravirt.c            | 27 ++++++---------------------
>  2 files changed, 13 insertions(+), 22 deletions(-)

objtool's not happy with this for whatever reason. I'll look later as to
why. .config is allmodconfig with this patch ontop of tip:x86/paravirt:

vmlinux.o: warning: objtool: pv_ops[31]: pv_native_irq_disable
vmlinux.o: warning: objtool: default_idle+0x1e: call to {dynamic}() leaves .noinstr.text section
vmlinux.o: warning: objtool: pv_ops[31]: pv_native_irq_disable
vmlinux.o: warning: objtool: mwait_idle+0x5d: call to {dynamic}() leaves .noinstr.text section
vmlinux.o: warning: objtool: pv_ops[31]: pv_native_irq_disable
vmlinux.o: warning: objtool: cpu_idle_poll.isra.0+0x94: call to {dynamic}() leaves .noinstr.text section
vmlinux.o: warning: objtool: pv_ops[31]: pv_native_irq_disable
vmlinux.o: warning: objtool: intel_idle_irq+0xab: call to {dynamic}() leaves .noinstr.text section
vmlinux.o: warning: objtool: pv_ops[31]: pv_native_irq_disable
vmlinux.o: warning: objtool: acpi_safe_halt+0x2a: call to {dynamic}() leaves .noinstr.text section
vmlinux.o: warning: objtool: pv_ops[31]: pv_native_irq_disable
vmlinux.o: warning: objtool: poll_idle+0x86: call to {dynamic}() leaves .noinstr.text section
vmlinux.o: warning: objtool: pv_ops[42]: pv_native_read_cr2
vmlinux.o: warning: objtool: exc_double_fault+0x3b: call to {dynamic}() leaves .noinstr.text section
vmlinux.o: warning: objtool: pv_ops[42]: pv_native_read_cr2
vmlinux.o: warning: objtool: exc_nmi+0x188: call to {dynamic}() leaves .noinstr.text section
vmlinux.o: warning: objtool: pv_ops[30]: pv_native_save_fl
vmlinux.o: warning: objtool: __sev_put_ghcb+0x11: call to {dynamic}() leaves .noinstr.text section
vmlinux.o: warning: objtool: pv_ops[30]: pv_native_save_fl
vmlinux.o: warning: objtool: __sev_get_ghcb+0x13: call to {dynamic}() leaves .noinstr.text section
vmlinux.o: warning: objtool: pv_ops[42]: pv_native_read_cr2
vmlinux.o: warning: objtool: exc_page_fault+0x1e: call to {dynamic}() leaves .noinstr.text section
vmlinux.o: warning: objtool: pv_ops[30]: pv_native_save_fl
vmlinux.o: warning: objtool: lockdep_hardirqs_on+0xd0: call to {dynamic}() leaves .noinstr.text section
vmlinux.o: warning: objtool: pv_ops[30]: pv_native_save_fl
vmlinux.o: warning: objtool: lockdep_hardirqs_off+0xe7: call to {dynamic}() leaves .noinstr.text section
vmlinux.o: warning: objtool: pv_ops[30]: pv_native_save_fl
vmlinux.o: warning: objtool: look_up_lock_class+0x52: call to {dynamic}() leaves .noinstr.text section
vmlinux.o: warning: objtool: pv_ops[32]: pv_native_irq_enable
vmlinux.o: warning: objtool: lock_is_held_type+0x143: call to {dynamic}() leaves .noinstr.text section
vmlinux.o: warning: objtool: pv_ops[30]: pv_native_save_fl
vmlinux.o: warning: objtool: ct_kernel_enter.constprop.0+0x37: call to {dynamic}() leaves .noinstr.text section
vmlinux.o: warning: objtool: pv_ops[32]: pv_native_irq_enable
vmlinux.o: warning: objtool: ct_idle_exit+0x51: call to {dynamic}() leaves .noinstr.text section
vmlinux.o: warning: objtool: pv_ops[30]: pv_native_save_fl
vmlinux.o: warning: objtool: ct_idle_enter+0xe: call to {dynamic}() leaves .noinstr.text section
vmlinux.o: warning: objtool: pv_ops[30]: pv_native_save_fl
vmlinux.o: warning: objtool: check_preemption_disabled+0x4c: call to {dynamic}() leaves .noinstr.text section

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
