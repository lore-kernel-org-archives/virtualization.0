Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19CFDC4321E
	for <virtualization@archiver.kernel.org>; Mon, 28 Nov 2022 03:35:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 89DDA408BC;
	Mon, 28 Nov 2022 03:35:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 89DDA408BC
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=zytor.com header.i=@zytor.com header.a=rsa-sha256 header.s=2022110601 header.b=cU7V1Hgw
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QNHL3xmvAje3; Mon, 28 Nov 2022 03:35:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id BADA6408B0;
	Mon, 28 Nov 2022 03:35:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BADA6408B0
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8321EC0033;
	Mon, 28 Nov 2022 03:35:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 53C3DC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Nov 2022 03:35:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1A12741503
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Nov 2022 03:35:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1A12741503
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com
 header.a=rsa-sha256 header.s=2022110601 header.b=cU7V1Hgw
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hRKnjNVy4RSe
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Nov 2022 03:35:18 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 15346414C0
Received: from mail.zytor.com (unknown [IPv6:2607:7c80:54:3::138])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 15346414C0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Nov 2022 03:35:17 +0000 (UTC)
Received: from [127.0.0.1] ([73.223.250.219]) (authenticated bits=0)
 by mail.zytor.com (8.17.1/8.17.1) with ESMTPSA id 2AS3YgFa2228734
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
 Sun, 27 Nov 2022 19:34:43 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 2AS3YgFa2228734
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
 s=2022110601; t=1669606485;
 bh=pyo7Px7PpQM2HufyWL1vMcwAPfvOwNDGVJHyx4pR0Eo=;
 h=Date:From:To:CC:Subject:In-Reply-To:References:From;
 b=cU7V1Hgw40yLX8VxRwQFYAeaAkAtFA9OKt0fQ+q5LZ3VAitRxt5Rqk+OK1Zo0YUYN
 sIW/WfDBgyRt/GCwJAozxfDXpHEYtLxHvq65lJMLHPyTd+6/GgsKP8Sjo7zBtXvfhj
 0cs8ZGKS8WIpZsbQUr6nS5c4x1tXQbE27ZyBLpcMq43aO7jmrBAwJMH0mQjEDyP7T9
 kyp+u70AKyLhCztSMIeH4BL3AmDdy/a463T4vIpIZlJ5cQ4V6W3s+a+w1AhilTzusn
 1pDRgvNbmDKHyzpS6xS8rD8535TyXZhizQDweXYaZ3Sl9OmAHVS9FjXkrP3DUx3+PV
 trhAjHytoqEqw==
Date: Sun, 27 Nov 2022 19:34:39 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: Hou Wenlong <houwenlong.hwl@antgroup.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2=5D_x86/paravirt=3A_Use_relat?=
 =?US-ASCII?Q?ive_reference_for_original_instruction?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20221128030320.GA101008@k08j02272.eu95sqa>
References: <73c9ffac157087da78af9fca59cf7d8db7f17226.1669290510.git.houwenlong.hwl@antgroup.com>
 <DD7871BE-B969-4E2E-BDF0-C5D730F0B0AE@zytor.com>
 <20221128030320.GA101008@k08j02272.eu95sqa>
Message-ID: <169A82BE-E5A9-4DB6-9CBE-055699F00213@zytor.com>
MIME-Version: 1.0
Cc: Juergen Gross <jgross@suse.com>, x86@kernel.org,
 Kees Cook <keescook@chromium.org>, Song Liu <song@kernel.org>,
 VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, linux-kernel@vger.kernel.org,
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

On November 27, 2022 7:03:20 PM PST, Hou Wenlong <houwenlong.hwl@antgroup.com> wrote:
>On Sun, Nov 27, 2022 at 09:24:34AM -0800, H. Peter Anvin wrote:
>> On November 24, 2022 3:51:53 AM PST, Hou Wenlong <houwenlong.hwl@antgroup.com> wrote:
>> >Similar to the alternative patching, use relative reference for original
>> >instruction rather than absolute one, which saves 8 bytes for one entry
>> >on x86_64.  And it could generate R_X86_64_PC32 relocation instead of
>> >R_X86_64_64 relocation, which also reduces relocation metadata on
>> >relocatable builds. And the alignment could be hard coded to be 4 now.
>> >
>> >Signed-off-by: Hou Wenlong <houwenlong.hwl@antgroup.com>
>> >---
>> > arch/x86/include/asm/paravirt.h       | 10 +++++-----
>> > arch/x86/include/asm/paravirt_types.h |  8 ++++----
>> > arch/x86/kernel/alternative.c         |  8 +++++---
>> > 3 files changed, 14 insertions(+), 12 deletions(-)
>> >
>> >diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
>> >index 2851bc2339d5..e56065ea73f2 100644
>> >--- a/arch/x86/include/asm/paravirt.h
>> >+++ b/arch/x86/include/asm/paravirt.h
>> >@@ -735,16 +735,16 @@ extern void default_banner(void);
>> > 
>> > #else  /* __ASSEMBLY__ */
>> > 
>> >-#define _PVSITE(ptype, ops, word, algn)		\
>> >+#define _PVSITE(ptype, ops)			\
>> > 771:;						\
>> > 	ops;					\
>> > 772:;						\
>> > 	.pushsection .parainstructions,"a";	\
>> >-	 .align	algn;				\
>> >-	 word 771b;				\
>> >+	 .align	4;				\
>> >+	 .long 771b-.;				\
>> > 	 .byte ptype;				\
>> > 	 .byte 772b-771b;			\
>> >-	 _ASM_ALIGN;				\
>> >+	 .align 4;				\
>> > 	.popsection
>> > 
>> > 
>> >@@ -752,7 +752,7 @@ extern void default_banner(void);
>> > #ifdef CONFIG_PARAVIRT_XXL
>> > 
>> > #define PARA_PATCH(off)		((off) / 8)
>> >-#define PARA_SITE(ptype, ops)	_PVSITE(ptype, ops, .quad, 8)
>> >+#define PARA_SITE(ptype, ops)	_PVSITE(ptype, ops)
>> > #define PARA_INDIRECT(addr)	*addr(%rip)
>> > 
>> > #ifdef CONFIG_DEBUG_ENTRY
>> >diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
>> >index 8c1da419260f..68952ae07a3f 100644
>> >--- a/arch/x86/include/asm/paravirt_types.h
>> >+++ b/arch/x86/include/asm/paravirt_types.h
>> >@@ -5,7 +5,7 @@
>> > #ifndef __ASSEMBLY__
>> > /* These all sit in the .parainstructions section to tell us what to patch. */
>> > struct paravirt_patch_site {
>> >-	u8 *instr;		/* original instructions */
>> >+	s32 instr_offset;	/* original instructions */
>> > 	u8 type;		/* type of this instruction */
>> > 	u8 len;			/* length of original instruction */
>> > };
>> >@@ -273,11 +273,11 @@ extern struct paravirt_patch_template pv_ops;
>> > #define _paravirt_alt(insn_string, type)		\
>> > 	"771:\n\t" insn_string "\n" "772:\n"		\
>> > 	".pushsection .parainstructions,\"a\"\n"	\
>> >-	_ASM_ALIGN "\n"					\
>> >-	_ASM_PTR " 771b\n"				\
>> >+	"  .align 4\n"					\
>> >+	"  .long 771b-.\n"				\
>> > 	"  .byte " type "\n"				\
>> > 	"  .byte 772b-771b\n"				\
>> >-	_ASM_ALIGN "\n"					\
>> >+	"  .align 4\n"					\
>> > 	".popsection\n"
>> > 
>> > /* Generate patchable code, with the default asm parameters. */
>> >diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
>> >index 111b809f0ac2..6eea563a098d 100644
>> >--- a/arch/x86/kernel/alternative.c
>> >+++ b/arch/x86/kernel/alternative.c
>> >@@ -1232,20 +1232,22 @@ void __init_or_module apply_paravirt(struct paravirt_patch_site *start,
>> > {
>> > 	struct paravirt_patch_site *p;
>> > 	char insn_buff[MAX_PATCH_LEN];
>> >+	u8 *instr;
>> > 
>> > 	for (p = start; p < end; p++) {
>> > 		unsigned int used;
>> > 
>> >+		instr = (u8 *)&p->instr_offset + p->instr_offset;
>> > 		BUG_ON(p->len > MAX_PATCH_LEN);
>> > 		/* prep the buffer with the original instructions */
>> >-		memcpy(insn_buff, p->instr, p->len);
>> >-		used = paravirt_patch(p->type, insn_buff, (unsigned long)p->instr, p->len);
>> >+		memcpy(insn_buff, instr, p->len);
>> >+		used = paravirt_patch(p->type, insn_buff, (unsigned long)instr, p->len);
>> > 
>> > 		BUG_ON(used > p->len);
>> > 
>> > 		/* Pad the rest with nops */
>> > 		add_nops(insn_buff + used, p->len - used);
>> >-		text_poke_early(p->instr, insn_buff, p->len);
>> >+		text_poke_early(instr, insn_buff, p->len);
>> > 	}
>> > }
>> > extern struct paravirt_patch_site __start_parainstructions[],
>> 
>> Any reason that you couldn't use the same patching code?
>
>Sorry, what do you mean using the same patching code? Do you
>mean that share some code between apply_alternatives() and
>apply_paravirt()?

Yes. Abstract the facility rather than duplicate.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
