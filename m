Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624F33C088
	for <virtualization@lists.linux-foundation.org>; Thu, 14 Dec 2023 10:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="FmE3pU8D"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 026B783BD5
	for <virtualization@lists.linux-foundation.org>; Thu, 14 Dec 2023 10:16:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 026B783BD5
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.a=rsa-sha256 header.s=google header.b=FmE3pU8D
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id i_Tlx8nP6NJD
	for <virtualization@lists.linux-foundation.org>;
	Thu, 14 Dec 2023 10:16:10 +0000 (UTC)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 25E4883BC5
	for <virtualization@lists.linux-foundation.org>; Thu, 14 Dec 2023 10:16:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 25E4883BC5
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-3364ab04eb8so154433f8f.2
        for <virtualization@lists.linux-foundation.org>; Thu, 14 Dec 2023 02:16:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1702548968; x=1703153768; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tHgnsxYfxbVMyX3m0HtccyvAeuvvFGofY8I7vS+QRNk=;
        b=FmE3pU8DOt+aZXaqXsasTwqHk8wyxbWhA5ruLm7jcT4M3Vit53NlD6SwTAc/i0ugQv
         aY0rysm90/YdTP+l1ptvqkPSdj+HMAB313B5gFVzgtiRe5BZxdzydj3EEinR4kfJnpMS
         K/XqQanUBDjQJkjJMf1yxJE3kge/+ZqwKt1Gs+fWu2Z6MbamlJh8k7yYiqMplZVfYBwo
         GsdR8kD0D7GHfo7Ey3lWXbLuotvaL4kSPAOQoboCUav4r1Aq/2IBxEUCgIdJsqTGtme0
         IBHOPeecJ0EN+uwwD4XQ3pgxSWJ0gkSv4ILBet24z0ZLBkOmKHaB2epxrgOMwG6HWEah
         H+5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702548968; x=1703153768;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tHgnsxYfxbVMyX3m0HtccyvAeuvvFGofY8I7vS+QRNk=;
        b=v3KmW/jzx1kNGQcxiGTJrqTl6eGJeZI0tpcZc2jXcR5QAM+d3k35J6wJyS0ziMArBC
         bweZm62zcylW5eps9SiWIQ+lkfFapSLELY/Bm+bZQV8jce3AdA6X+STnjymQDkCSeium
         EBTCDjXk0ENeDxT8IeiQJs+94by54L1Ip8qyt30igrapL3WLIm1ZPi0lHTVXeGzovKRt
         BEvrVtqZFK76R5sXyS/PIBCJmNTSl3kZpwha3K4l9bzPvHhVOb3FXfQ56XZLyFCaHMcF
         xu/j0kkejjCE2f2lNF1m97Dta/yP8sv6mTy0byzvt8RNlOjzYVsoXA39Ob85t9NRFB+f
         h8vA==
X-Gm-Message-State: AOJu0YzP4CSaLPKi+DLuRENZTUJz3BC71A2KeIc+KkTnbKJcYab/1CPE
	qmmFi75LCznbg5QyHe2KGvpax3B1veteEFU66hU=
X-Google-Smtp-Source: AGHT+IFK7EzLkSeVAeCsSbYgg462lJQa7nX7hRuOXjYRawScJxweAERIujFIU30qoQ/mOIpaXLOMxw==
X-Received: by 2002:a5d:464e:0:b0:336:3572:a1a8 with SMTP id j14-20020a5d464e000000b003363572a1a8mr1519890wrs.114.1702548968253;
        Thu, 14 Dec 2023 02:16:08 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id k12-20020adfb34c000000b003333b67f58csm195794wrd.48.2023.12.14.02.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 02:16:07 -0800 (PST)
From: Andrew Jones <ajones@ventanamicro.com>
To: kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	virtualization@lists.linux-foundation.org
Cc: anup@brainfault.org,
	atishp@atishpatra.org,
	pbonzini@redhat.com,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	jgross@suse.com,
	srivatsa@csail.mit.edu,
	guoren@kernel.org,
	conor.dooley@microchip.com
Subject: [PATCH v2 10/13] RISC-V: KVM: selftests: Move sbi_ecall to processor.c
Date: Thu, 14 Dec 2023 11:16:02 +0100
Message-ID: <20231214101552.100721-25-ajones@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231214101552.100721-15-ajones@ventanamicro.com>
References: <20231214101552.100721-15-ajones@ventanamicro.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit

sbi_ecall() isn't ucall specific and its prototype is already in
processor.h. Move its implementation to processor.c.

Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
---
 .../selftests/kvm/lib/riscv/processor.c       | 26 +++++++++++++++++++
 tools/testing/selftests/kvm/lib/riscv/ucall.c | 26 -------------------
 2 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/riscv/processor.c b/tools/testing/selftests/kvm/lib/riscv/processor.c
index 6c25f7843ef4..6905a4348380 100644
--- a/tools/testing/selftests/kvm/lib/riscv/processor.c
+++ b/tools/testing/selftests/kvm/lib/riscv/processor.c
@@ -367,3 +367,29 @@ void vcpu_args_set(struct kvm_vcpu *vcpu, unsigned int num, ...)
 void assert_on_unhandled_exception(struct kvm_vcpu *vcpu)
 {
 }
+
+struct sbiret sbi_ecall(int ext, int fid, unsigned long arg0,
+			unsigned long arg1, unsigned long arg2,
+			unsigned long arg3, unsigned long arg4,
+			unsigned long arg5)
+{
+	register uintptr_t a0 asm ("a0") = (uintptr_t)(arg0);
+	register uintptr_t a1 asm ("a1") = (uintptr_t)(arg1);
+	register uintptr_t a2 asm ("a2") = (uintptr_t)(arg2);
+	register uintptr_t a3 asm ("a3") = (uintptr_t)(arg3);
+	register uintptr_t a4 asm ("a4") = (uintptr_t)(arg4);
+	register uintptr_t a5 asm ("a5") = (uintptr_t)(arg5);
+	register uintptr_t a6 asm ("a6") = (uintptr_t)(fid);
+	register uintptr_t a7 asm ("a7") = (uintptr_t)(ext);
+	struct sbiret ret;
+
+	asm volatile (
+		"ecall"
+		: "+r" (a0), "+r" (a1)
+		: "r" (a2), "r" (a3), "r" (a4), "r" (a5), "r" (a6), "r" (a7)
+		: "memory");
+	ret.error = a0;
+	ret.value = a1;
+
+	return ret;
+}
diff --git a/tools/testing/selftests/kvm/lib/riscv/ucall.c b/tools/testing/selftests/kvm/lib/riscv/ucall.c
index fe6d1004f018..14ee17151a59 100644
--- a/tools/testing/selftests/kvm/lib/riscv/ucall.c
+++ b/tools/testing/selftests/kvm/lib/riscv/ucall.c
@@ -10,32 +10,6 @@
 #include "kvm_util.h"
 #include "processor.h"
 
-struct sbiret sbi_ecall(int ext, int fid, unsigned long arg0,
-			unsigned long arg1, unsigned long arg2,
-			unsigned long arg3, unsigned long arg4,
-			unsigned long arg5)
-{
-	register uintptr_t a0 asm ("a0") = (uintptr_t)(arg0);
-	register uintptr_t a1 asm ("a1") = (uintptr_t)(arg1);
-	register uintptr_t a2 asm ("a2") = (uintptr_t)(arg2);
-	register uintptr_t a3 asm ("a3") = (uintptr_t)(arg3);
-	register uintptr_t a4 asm ("a4") = (uintptr_t)(arg4);
-	register uintptr_t a5 asm ("a5") = (uintptr_t)(arg5);
-	register uintptr_t a6 asm ("a6") = (uintptr_t)(fid);
-	register uintptr_t a7 asm ("a7") = (uintptr_t)(ext);
-	struct sbiret ret;
-
-	asm volatile (
-		"ecall"
-		: "+r" (a0), "+r" (a1)
-		: "r" (a2), "r" (a3), "r" (a4), "r" (a5), "r" (a6), "r" (a7)
-		: "memory");
-	ret.error = a0;
-	ret.value = a1;
-
-	return ret;
-}
-
 void *ucall_arch_get_ucall(struct kvm_vcpu *vcpu)
 {
 	struct kvm_run *run = vcpu->run;
-- 
2.43.0

