Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB4F41848
	for <virtualization@lists.linux-foundation.org>; Wed, 20 Dec 2023 16:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="on9M7b47"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9B75C6151D
	for <virtualization@lists.linux-foundation.org>; Wed, 20 Dec 2023 16:00:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9B75C6151D
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.a=rsa-sha256 header.s=google header.b=on9M7b47
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gWE6zu9wYa_Q
	for <virtualization@lists.linux-foundation.org>;
	Wed, 20 Dec 2023 16:00:45 +0000 (UTC)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A884060AC6
	for <virtualization@lists.linux-foundation.org>; Wed, 20 Dec 2023 16:00:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A884060AC6
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-33671384e50so2003066f8f.0
        for <virtualization@lists.linux-foundation.org>; Wed, 20 Dec 2023 08:00:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1703088044; x=1703692844; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SOMbKPx9f+JcS4fNjPCKfauG48/CPKUV3NQDAwTQdeE=;
        b=on9M7b47e9aX8RfkoutGS9770pS78qQ2oq+8Kc5HDVteTov5jG/NaxO/HkjpHkfs7C
         ibY1OOUchJqht84NSf5t7lo0txdEmo5X15UhAc7vSYuqXx2+vZLMW/uofCUBMSf/2Xs8
         thhgxmjg9TT3qzydP2zkN7b0Zmamw7fnHNaS5RJyusfHUuUzgyOlCIF0LxpmChrjtJZ3
         2WiULkW/8XdxptJ0+3VTa1jY5BwcXJs+IDZbOkSTfOjq3SR0APneDJQO7VkMVQ1/EqHa
         FA5aZ8REpZS2seSb4xIlnrojtsIfYrhOhIumq67+bwtV0QCFzWW/mi8I7NCZvQ8AqaXk
         NAqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703088044; x=1703692844;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SOMbKPx9f+JcS4fNjPCKfauG48/CPKUV3NQDAwTQdeE=;
        b=BxIArZ/rZNCUegDlricOEXTKFKKJV/IQzxhaJbArK/wTfsynCv3S9usm3inppU4RqN
         CVuIGstAVk6Q23VE9NE03FMnFLJzqLySFSn5ufdRABpsyakPtlTf/vgVJkQAlpOe11Dp
         GYBCPsLg/TsNuh7WkWC2ryMzJQoZcJSO+pbRoCQseT/huYhvkvS7BtGfqkuDcQU3PbvO
         OKIuZHA6gJdo99CeMMs8XEkNZcSH2k2h2mY8pE/D+L4MUqVOce8MqodplqoVNrWhsV85
         0nqHEgGPaIGOvzAviUMgJ6w61f1ejHFinVwGRtvG6423jgJcC4WQzvoZStXvWeZj4qZy
         RA8Q==
X-Gm-Message-State: AOJu0Yx04PvAT2TmxR3NN/rh5a/MKfvAEctf1mzI8HVK5qhIQov+mu7U
	lbSNxvwgfcJixprMG5UUfdGtHQ==
X-Google-Smtp-Source: AGHT+IHAymYvsc8zEqN1v3qElq0WfVx384eiJmTqDAz6MBPOM6JEK5f4WJQK6gTsluRbahFbSGEd9A==
X-Received: by 2002:a5d:6691:0:b0:336:7659:c2c2 with SMTP id l17-20020a5d6691000000b003367659c2c2mr1430322wru.21.1703088043894;
        Wed, 20 Dec 2023 08:00:43 -0800 (PST)
Received: from localhost (cst-prg-16-115.cust.vodafone.cz. [46.135.16.115])
        by smtp.gmail.com with ESMTPSA id s8-20020a5d5108000000b003366fb71297sm5272750wrt.81.2023.12.20.08.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 08:00:43 -0800 (PST)
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
Subject: [PATCH v4 10/13] RISC-V: KVM: selftests: Move sbi_ecall to processor.c
Date: Wed, 20 Dec 2023 17:00:23 +0100
Message-ID: <20231220160012.40184-25-ajones@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231220160012.40184-15-ajones@ventanamicro.com>
References: <20231220160012.40184-15-ajones@ventanamicro.com>
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

Reviewed-by: Anup Patel <anup@brainfault.org>
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

