Return-Path: <SRS0=agY8=IG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA559C433E0
	for <virtualization@archiver.kernel.org>; Mon,  8 Mar 2021 12:28:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B52F651D1
	for <virtualization@archiver.kernel.org>; Mon,  8 Mar 2021 12:28:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B52F651D1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9E8E783A59;
	Mon,  8 Mar 2021 12:28:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id j39TqQADCebO; Mon,  8 Mar 2021 12:28:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 428E983918;
	Mon,  8 Mar 2021 12:28:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 089C3C0001;
	Mon,  8 Mar 2021 12:28:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6D21FC0001
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Mar 2021 12:28:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 535B3606F4
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Mar 2021 12:28:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=suse.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dvfdW4CzFYdV
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Mar 2021 12:28:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 59806605D9
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Mar 2021 12:28:53 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1615206531; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u3YnMSkFlUp/21QNZ1kMggcxHe1yXHAkDy5ICMJL1QU=;
 b=YNXv3uCm5+P4OF8r75Pj3qvw5a/bZfGdICaugMYT2001NNP0vgy+3Yvt/g6oITt+sQcCfJ
 bRWOBUQq9sw0blJ3Qd7GZKfWo8CXn9ZBVyCjfOf1W58pXx3+q/llcvf1E3Q81iLbwVmnW4
 5yJkt0s0avbsqJu9zRlFR0ThlVQ9xoo=
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id C3CDDADE3;
 Mon,  8 Mar 2021 12:28:51 +0000 (UTC)
To: xen-devel@lists.xenproject.org, x86@kernel.org,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 clang-built-linux@googlegroups.com
Subject: [PATCH v5 08/12] x86/paravirt: simplify paravirt macros
Date: Mon,  8 Mar 2021 13:28:40 +0100
Message-Id: <20210308122844.30488-9-jgross@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210308122844.30488-1-jgross@suse.com>
References: <20210308122844.30488-1-jgross@suse.com>
MIME-Version: 1.0
Cc: Juergen Gross <jgross@suse.com>, "VMware, Inc." <pv-drivers@vmware.com>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Nathan Chancellor <nathan@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
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
From: Juergen Gross via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: Juergen Gross <jgross@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

The central pvops call macros ____PVOP_CALL() and ____PVOP_VCALL() are
looking very similar now.

The main differences are using PVOP_VCALL_ARGS or PVOP_CALL_ARGS, which
are identical, and the return value handling.

So drop PVOP_VCALL_ARGS and instead of ____PVOP_VCALL() just use
(void)____PVOP_CALL(long, ...).

Note that it isn't easily possible to just redefine ____PVOP_VCALL()
to use ____PVOP_CALL() instead, as this would require further hiding of
commas in macro parameters.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
V3:
- new patch
V4:
- fix build warnings with clang (kernel test robot)
---
 arch/x86/include/asm/paravirt_types.h | 41 ++++++++-------------------
 1 file changed, 12 insertions(+), 29 deletions(-)

diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index 42f9eef84131..45bd21647dd8 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -408,11 +408,9 @@ int paravirt_disable_iospace(void);
  * makes sure the incoming and outgoing types are always correct.
  */
 #ifdef CONFIG_X86_32
-#define PVOP_VCALL_ARGS							\
+#define PVOP_CALL_ARGS							\
 	unsigned long __eax = __eax, __edx = __edx, __ecx = __ecx;
 
-#define PVOP_CALL_ARGS			PVOP_VCALL_ARGS
-
 #define PVOP_CALL_ARG1(x)		"a" ((unsigned long)(x))
 #define PVOP_CALL_ARG2(x)		"d" ((unsigned long)(x))
 #define PVOP_CALL_ARG3(x)		"c" ((unsigned long)(x))
@@ -428,12 +426,10 @@ int paravirt_disable_iospace(void);
 #define VEXTRA_CLOBBERS
 #else  /* CONFIG_X86_64 */
 /* [re]ax isn't an arg, but the return val */
-#define PVOP_VCALL_ARGS						\
+#define PVOP_CALL_ARGS						\
 	unsigned long __edi = __edi, __esi = __esi,		\
 		__edx = __edx, __ecx = __ecx, __eax = __eax;
 
-#define PVOP_CALL_ARGS		PVOP_VCALL_ARGS
-
 #define PVOP_CALL_ARG1(x)		"D" ((unsigned long)(x))
 #define PVOP_CALL_ARG2(x)		"S" ((unsigned long)(x))
 #define PVOP_CALL_ARG3(x)		"d" ((unsigned long)(x))
@@ -458,59 +454,46 @@ int paravirt_disable_iospace(void);
 #define PVOP_TEST_NULL(op)	((void)pv_ops.op)
 #endif
 
-#define PVOP_RETMASK(rettype)						\
+#define PVOP_RETVAL(rettype)						\
 	({	unsigned long __mask = ~0UL;				\
+		BUILD_BUG_ON(sizeof(rettype) > sizeof(unsigned long));	\
 		switch (sizeof(rettype)) {				\
 		case 1: __mask =       0xffUL; break;			\
 		case 2: __mask =     0xffffUL; break;			\
 		case 4: __mask = 0xffffffffUL; break;			\
 		default: break;						\
 		}							\
-		__mask;							\
+		__mask & __eax;						\
 	})
 
 
-#define ____PVOP_CALL(rettype, op, clbr, call_clbr, extra_clbr, ...)	\
+#define ____PVOP_CALL(ret, op, clbr, call_clbr, extra_clbr, ...)	\
 	({								\
 		PVOP_CALL_ARGS;						\
 		PVOP_TEST_NULL(op);					\
-		BUILD_BUG_ON(sizeof(rettype) > sizeof(unsigned long));	\
 		asm volatile(paravirt_alt(PARAVIRT_CALL)		\
 			     : call_clbr, ASM_CALL_CONSTRAINT		\
 			     : paravirt_type(op),			\
 			       paravirt_clobber(clbr),			\
 			       ##__VA_ARGS__				\
 			     : "memory", "cc" extra_clbr);		\
-		(rettype)(__eax & PVOP_RETMASK(rettype));		\
+		ret;							\
 	})
 
 #define __PVOP_CALL(rettype, op, ...)					\
-	____PVOP_CALL(rettype, op, CLBR_ANY, PVOP_CALL_CLOBBERS,	\
-		      EXTRA_CLOBBERS, ##__VA_ARGS__)
+	____PVOP_CALL(PVOP_RETVAL(rettype), op, CLBR_ANY,		\
+		      PVOP_CALL_CLOBBERS, EXTRA_CLOBBERS, ##__VA_ARGS__)
 
 #define __PVOP_CALLEESAVE(rettype, op, ...)				\
-	____PVOP_CALL(rettype, op.func, CLBR_RET_REG,			\
+	____PVOP_CALL(PVOP_RETVAL(rettype), op.func, CLBR_RET_REG,	\
 		      PVOP_CALLEE_CLOBBERS, , ##__VA_ARGS__)
 
-
-#define ____PVOP_VCALL(op, clbr, call_clbr, extra_clbr, ...)		\
-	({								\
-		PVOP_VCALL_ARGS;					\
-		PVOP_TEST_NULL(op);					\
-		asm volatile(paravirt_alt(PARAVIRT_CALL)		\
-			     : call_clbr, ASM_CALL_CONSTRAINT		\
-			     : paravirt_type(op),			\
-			       paravirt_clobber(clbr),			\
-			       ##__VA_ARGS__				\
-			     : "memory", "cc" extra_clbr);		\
-	})
-
 #define __PVOP_VCALL(op, ...)						\
-	____PVOP_VCALL(op, CLBR_ANY, PVOP_VCALL_CLOBBERS,		\
+	(void)____PVOP_CALL(, op, CLBR_ANY, PVOP_VCALL_CLOBBERS,	\
 		       VEXTRA_CLOBBERS, ##__VA_ARGS__)
 
 #define __PVOP_VCALLEESAVE(op, ...)					\
-	____PVOP_VCALL(op.func, CLBR_RET_REG,				\
+	(void)____PVOP_CALL(, op.func, CLBR_RET_REG,			\
 		      PVOP_VCALLEE_CLOBBERS, , ##__VA_ARGS__)
 
 
-- 
2.26.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
