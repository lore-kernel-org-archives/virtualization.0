Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F3C9C43217
	for <virtualization@archiver.kernel.org>; Sun, 27 Nov 2022 17:58:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DC3CB4089A;
	Sun, 27 Nov 2022 17:58:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DC3CB4089A
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=zytor.com header.i=@zytor.com header.a=rsa-sha256 header.s=2022110601 header.b=NHYCvpXs
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Fr7FIM-oRQur; Sun, 27 Nov 2022 17:58:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C0063403C5;
	Sun, 27 Nov 2022 17:58:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C0063403C5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 942BBC0033;
	Sun, 27 Nov 2022 17:58:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6FF34C002D
 for <virtualization@lists.linux-foundation.org>;
 Sun, 27 Nov 2022 17:58:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4A00640761
 for <virtualization@lists.linux-foundation.org>;
 Sun, 27 Nov 2022 17:58:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4A00640761
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FwwL3xV_LCVY
 for <virtualization@lists.linux-foundation.org>;
 Sun, 27 Nov 2022 17:58:45 +0000 (UTC)
X-Greylist: delayed 00:33:14 by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1263F403C5
Received: from mail.zytor.com (unknown [IPv6:2607:7c80:54:3::138])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1263F403C5
 for <virtualization@lists.linux-foundation.org>;
 Sun, 27 Nov 2022 17:58:43 +0000 (UTC)
Received: from [IPv6:::1] ([172.58.89.136]) (authenticated bits=0)
 by mail.zytor.com (8.17.1/8.17.1) with ESMTPSA id 2ARHOi1Z2093772
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
 Sun, 27 Nov 2022 09:24:45 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 2ARHOi1Z2093772
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
 s=2022110601; t=1669569889;
 bh=onPExFmU8kkDJicwNe4UEJNsfvddfveagmwBV0peyQU=;
 h=Date:From:To:CC:Subject:In-Reply-To:References:From;
 b=NHYCvpXsp/ej6cChBHv4IZey+MpDNtOP153kT6q+1lkUcddgqbCQctt7ZJavPuKow
 wM+C8IDe4rN/2IwkfmDL4Ooqh2xRUhJyyaspcqB3B8x7sxdBeKYE4jJUQHBhEorK/d
 J45x8wLVIgjVz/f47R7056grkkrSONeUo/b/trUNNbW4xF1bDQwk/U0J30lmSCwpIH
 afmtjY/2TE4KkC7XQfF1PbyTl3IfecaW8QY4tow83uxl9rvU4HlwaKDZUjhlJErD8W
 jEhZbaX9w+h1rOijCQxgKpzpF0S+ymspT0uqQKrhFCzNJg04H2ToHX7VofGVIiL531
 tyHdqpzK4XK7w==
Date: Sun, 27 Nov 2022 09:24:34 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: Hou Wenlong <houwenlong.hwl@antgroup.com>, linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2=5D_x86/paravirt=3A_Use_relat?=
 =?US-ASCII?Q?ive_reference_for_original_instruction?=
User-Agent: K-9 Mail for Android
In-Reply-To: <73c9ffac157087da78af9fca59cf7d8db7f17226.1669290510.git.houwenlong.hwl@antgroup.com>
References: <73c9ffac157087da78af9fca59cf7d8db7f17226.1669290510.git.houwenlong.hwl@antgroup.com>
Message-ID: <DD7871BE-B969-4E2E-BDF0-C5D730F0B0AE@zytor.com>
MIME-Version: 1.0
Cc: Juergen Gross <jgross@suse.com>, x86@kernel.org,
 Kees Cook <keescook@chromium.org>, Song Liu <song@kernel.org>,
 VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Alexey Makhalov <amakhalov@vmware.com>, Nadav Amit <namit@vmware.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 virtualization@lists.linux-foundation.org
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

On November 24, 2022 3:51:53 AM PST, Hou Wenlong <houwenlong.hwl@antgroup.com> wrote:
>Similar to the alternative patching, use relative reference for original
>instruction rather than absolute one, which saves 8 bytes for one entry
>on x86_64.  And it could generate R_X86_64_PC32 relocation instead of
>R_X86_64_64 relocation, which also reduces relocation metadata on
>relocatable builds. And the alignment could be hard coded to be 4 now.
>
>Signed-off-by: Hou Wenlong <houwenlong.hwl@antgroup.com>
>---
> arch/x86/include/asm/paravirt.h       | 10 +++++-----
> arch/x86/include/asm/paravirt_types.h |  8 ++++----
> arch/x86/kernel/alternative.c         |  8 +++++---
> 3 files changed, 14 insertions(+), 12 deletions(-)
>
>diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
>index 2851bc2339d5..e56065ea73f2 100644
>--- a/arch/x86/include/asm/paravirt.h
>+++ b/arch/x86/include/asm/paravirt.h
>@@ -735,16 +735,16 @@ extern void default_banner(void);
> 
> #else  /* __ASSEMBLY__ */
> 
>-#define _PVSITE(ptype, ops, word, algn)		\
>+#define _PVSITE(ptype, ops)			\
> 771:;						\
> 	ops;					\
> 772:;						\
> 	.pushsection .parainstructions,"a";	\
>-	 .align	algn;				\
>-	 word 771b;				\
>+	 .align	4;				\
>+	 .long 771b-.;				\
> 	 .byte ptype;				\
> 	 .byte 772b-771b;			\
>-	 _ASM_ALIGN;				\
>+	 .align 4;				\
> 	.popsection
> 
> 
>@@ -752,7 +752,7 @@ extern void default_banner(void);
> #ifdef CONFIG_PARAVIRT_XXL
> 
> #define PARA_PATCH(off)		((off) / 8)
>-#define PARA_SITE(ptype, ops)	_PVSITE(ptype, ops, .quad, 8)
>+#define PARA_SITE(ptype, ops)	_PVSITE(ptype, ops)
> #define PARA_INDIRECT(addr)	*addr(%rip)
> 
> #ifdef CONFIG_DEBUG_ENTRY
>diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
>index 8c1da419260f..68952ae07a3f 100644
>--- a/arch/x86/include/asm/paravirt_types.h
>+++ b/arch/x86/include/asm/paravirt_types.h
>@@ -5,7 +5,7 @@
> #ifndef __ASSEMBLY__
> /* These all sit in the .parainstructions section to tell us what to patch. */
> struct paravirt_patch_site {
>-	u8 *instr;		/* original instructions */
>+	s32 instr_offset;	/* original instructions */
> 	u8 type;		/* type of this instruction */
> 	u8 len;			/* length of original instruction */
> };
>@@ -273,11 +273,11 @@ extern struct paravirt_patch_template pv_ops;
> #define _paravirt_alt(insn_string, type)		\
> 	"771:\n\t" insn_string "\n" "772:\n"		\
> 	".pushsection .parainstructions,\"a\"\n"	\
>-	_ASM_ALIGN "\n"					\
>-	_ASM_PTR " 771b\n"				\
>+	"  .align 4\n"					\
>+	"  .long 771b-.\n"				\
> 	"  .byte " type "\n"				\
> 	"  .byte 772b-771b\n"				\
>-	_ASM_ALIGN "\n"					\
>+	"  .align 4\n"					\
> 	".popsection\n"
> 
> /* Generate patchable code, with the default asm parameters. */
>diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
>index 111b809f0ac2..6eea563a098d 100644
>--- a/arch/x86/kernel/alternative.c
>+++ b/arch/x86/kernel/alternative.c
>@@ -1232,20 +1232,22 @@ void __init_or_module apply_paravirt(struct paravirt_patch_site *start,
> {
> 	struct paravirt_patch_site *p;
> 	char insn_buff[MAX_PATCH_LEN];
>+	u8 *instr;
> 
> 	for (p = start; p < end; p++) {
> 		unsigned int used;
> 
>+		instr = (u8 *)&p->instr_offset + p->instr_offset;
> 		BUG_ON(p->len > MAX_PATCH_LEN);
> 		/* prep the buffer with the original instructions */
>-		memcpy(insn_buff, p->instr, p->len);
>-		used = paravirt_patch(p->type, insn_buff, (unsigned long)p->instr, p->len);
>+		memcpy(insn_buff, instr, p->len);
>+		used = paravirt_patch(p->type, insn_buff, (unsigned long)instr, p->len);
> 
> 		BUG_ON(used > p->len);
> 
> 		/* Pad the rest with nops */
> 		add_nops(insn_buff + used, p->len - used);
>-		text_poke_early(p->instr, insn_buff, p->len);
>+		text_poke_early(instr, insn_buff, p->len);
> 	}
> }
> extern struct paravirt_patch_site __start_parainstructions[],

Any reason that you couldn't use the same patching code?
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
