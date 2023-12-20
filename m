Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8870441850
	for <virtualization@lists.linux-foundation.org>; Wed, 20 Dec 2023 16:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="CXar+bKc"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F28246151C
	for <virtualization@lists.linux-foundation.org>; Wed, 20 Dec 2023 16:00:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F28246151C
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.a=rsa-sha256 header.s=google header.b=CXar+bKc
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SY316Zf23FZ3
	for <virtualization@lists.linux-foundation.org>;
	Wed, 20 Dec 2023 16:00:40 +0000 (UTC)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
	by smtp3.osuosl.org (Postfix) with ESMTPS id EC1D160AC6
	for <virtualization@lists.linux-foundation.org>; Wed, 20 Dec 2023 16:00:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EC1D160AC6
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-40c339d2b88so62389965e9.3
        for <virtualization@lists.linux-foundation.org>; Wed, 20 Dec 2023 08:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1703088038; x=1703692838; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zpURfIIPcWjXkfktChCkrPfs/5M7Hj157zHrpDPFlwA=;
        b=CXar+bKcIkhg/rP98X9vWaPIy5SMjptBVELWFu2dIT+oq06FGLe2K0f/QXzTJp9yB6
         bxfQiwLztfmT392VnGnmB6Av4tZNxij5Bp6sbHwAzL/kUgAc1JYgeDqGWtVuhqbQPpLP
         8F+938ifMWz5wmYyFHhb31SyBRS3gDKXbmES8Zdd2w9elyiDbjeBNHqit1eSU5sVUyoC
         DW3yS/I78GDNy0psJsx0tJcVIbVx9aw7DbfQ9IiHlx/TL1IxefjxDxNnoI2JJDjcNtyu
         xG56m4/H2oG5I0pSn5ZT5U/pLSJKtu3ZdJIUyBwi+in211aTHGgfSPI5ofPFkxme6b71
         mZ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703088038; x=1703692838;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zpURfIIPcWjXkfktChCkrPfs/5M7Hj157zHrpDPFlwA=;
        b=R346EJ+Xu181zaeW0JiZek8QA05Gnka5UKIby78MXy9Ig1VZXGpeBBMNrDv30j9pjB
         5y6JlNz61vGztgm3uWJio3FfW5Jz18IeYD7JiXXhLp6QV3oskLu/J47c67AR9izJDBYR
         WS3mP4oRJaYHcpOKNtUesDSh+aYE149lyvNkwFlwBXzDkJKajEMLOmf6oOsfgbNeMjvX
         YwSTa3WMKaOSAM7NVmssrOJ2e6X+qaR4h2rfPKEk6PfXYIfRO/cPbUK6E4Bg5HjwIada
         CLXBVvgUSnWNa93WvQErtpmPgmVkR8uG+ZXeOFtiPkGsX3cEcw2wsQoDZPVtRIoqMwfa
         HniA==
X-Gm-Message-State: AOJu0YzfHmVo5PNJritqfDN+X1+8GfyoIgzqZi/RaXnd0Jz7YYAxBJye
	eLosqDCTPJ6ZNdxV5Idunblw8A==
X-Google-Smtp-Source: AGHT+IGL7oUGx3f83Bo5k9llp34bKGp7jr5O5YoDBmVfFbYVE8j7jG1k5cMM6Pj230qSoSaurUzjsg==
X-Received: by 2002:a05:600c:1688:b0:40c:1db4:3a53 with SMTP id k8-20020a05600c168800b0040c1db43a53mr10192900wmn.157.1703088038040;
        Wed, 20 Dec 2023 08:00:38 -0800 (PST)
Received: from localhost (cst-prg-16-115.cust.vodafone.cz. [46.135.16.115])
        by smtp.gmail.com with ESMTPSA id r20-20020a05600c459400b0040c3dcc36e6sm54372wmo.47.2023.12.20.08.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 08:00:37 -0800 (PST)
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
Subject: [PATCH v4 08/13] RISC-V: KVM: Add support for SBI STA registers
Date: Wed, 20 Dec 2023 17:00:21 +0100
Message-ID: <20231220160012.40184-23-ajones@ventanamicro.com>
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

KVM userspace needs to be able to save and restore the steal-time
shared memory address. Provide the address through the get/set-one-reg
interface with two ulong-sized SBI STA extension registers (lo and hi).
64-bit KVM userspace must not set the hi register to anything other
than zero and is allowed to completely neglect saving/restoring it.

Reviewed-by: Anup Patel <anup@brainfault.org>
Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
---
 arch/riscv/include/asm/kvm_vcpu_sbi.h |  5 +++
 arch/riscv/include/uapi/asm/kvm.h     |  9 +++++
 arch/riscv/kvm/vcpu_onereg.c          | 37 +++++++++++-------
 arch/riscv/kvm/vcpu_sbi.c             |  5 +++
 arch/riscv/kvm/vcpu_sbi_sta.c         | 55 +++++++++++++++++++++++++++
 5 files changed, 97 insertions(+), 14 deletions(-)

diff --git a/arch/riscv/include/asm/kvm_vcpu_sbi.h b/arch/riscv/include/asm/kvm_vcpu_sbi.h
index dd60f73b5c36..b96705258cf9 100644
--- a/arch/riscv/include/asm/kvm_vcpu_sbi.h
+++ b/arch/riscv/include/asm/kvm_vcpu_sbi.h
@@ -70,6 +70,11 @@ bool riscv_vcpu_supports_sbi_ext(struct kvm_vcpu *vcpu, int idx);
 int kvm_riscv_vcpu_sbi_ecall(struct kvm_vcpu *vcpu, struct kvm_run *run);
 void kvm_riscv_vcpu_sbi_init(struct kvm_vcpu *vcpu);
 
+int kvm_riscv_vcpu_get_reg_sbi_sta(struct kvm_vcpu *vcpu, unsigned long reg_num,
+				   unsigned long *reg_val);
+int kvm_riscv_vcpu_set_reg_sbi_sta(struct kvm_vcpu *vcpu, unsigned long reg_num,
+				   unsigned long reg_val);
+
 #ifdef CONFIG_RISCV_SBI_V01
 extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_v01;
 #endif
diff --git a/arch/riscv/include/uapi/asm/kvm.h b/arch/riscv/include/uapi/asm/kvm.h
index 3471b1e48d18..d6b7a5b95874 100644
--- a/arch/riscv/include/uapi/asm/kvm.h
+++ b/arch/riscv/include/uapi/asm/kvm.h
@@ -161,6 +161,12 @@ enum KVM_RISCV_SBI_EXT_ID {
 	KVM_RISCV_SBI_EXT_MAX,
 };
 
+/* SBI STA extension registers for KVM_GET_ONE_REG and KVM_SET_ONE_REG */
+struct kvm_riscv_sbi_sta {
+	unsigned long shmem_lo;
+	unsigned long shmem_hi;
+};
+
 /* Possible states for kvm_riscv_timer */
 #define KVM_RISCV_TIMER_STATE_OFF	0
 #define KVM_RISCV_TIMER_STATE_ON	1
@@ -244,6 +250,9 @@ enum KVM_RISCV_SBI_EXT_ID {
 
 /* Registers for specific SBI extensions are mapped as type 10 */
 #define KVM_REG_RISCV_SBI_STATE		(0x0a << KVM_REG_RISCV_TYPE_SHIFT)
+#define KVM_REG_RISCV_SBI_STA		(0x0 << KVM_REG_RISCV_SUBTYPE_SHIFT)
+#define KVM_REG_RISCV_SBI_STA_REG(name)		\
+		(offsetof(struct kvm_riscv_sbi_sta, name) / sizeof(unsigned long))
 
 /* Device Control API: RISC-V AIA */
 #define KVM_DEV_RISCV_APLIC_ALIGN		0x1000
diff --git a/arch/riscv/kvm/vcpu_onereg.c b/arch/riscv/kvm/vcpu_onereg.c
index c7f82a3b8fba..c95ea55c29a7 100644
--- a/arch/riscv/kvm/vcpu_onereg.c
+++ b/arch/riscv/kvm/vcpu_onereg.c
@@ -961,27 +961,36 @@ static unsigned long num_sbi_ext_regs(struct kvm_vcpu *vcpu)
 	return copy_sbi_ext_reg_indices(vcpu, NULL);
 }
 
-static inline unsigned long num_sbi_regs(struct kvm_vcpu *vcpu)
-{
-	return 0;
-}
-
 static int copy_sbi_reg_indices(struct kvm_vcpu *vcpu, u64 __user *uindices)
 {
-	int n = num_sbi_regs(vcpu);
+	struct kvm_vcpu_sbi_context *scontext = &vcpu->arch.sbi_context;
+	int total = 0;
 
-	for (int i = 0; i < n; i++) {
-		u64 reg = KVM_REG_RISCV | KVM_REG_SIZE_U64 |
-			  KVM_REG_RISCV_SBI_STATE | i;
+	if (scontext->ext_status[KVM_RISCV_SBI_EXT_STA] == KVM_RISCV_SBI_EXT_STATUS_ENABLED) {
+		u64 size = IS_ENABLED(CONFIG_32BIT) ? KVM_REG_SIZE_U32 : KVM_REG_SIZE_U64;
+		int n = sizeof(struct kvm_riscv_sbi_sta) / sizeof(unsigned long);
 
-		if (uindices) {
-			if (put_user(reg, uindices))
-				return -EFAULT;
-			uindices++;
+		for (int i = 0; i < n; i++) {
+			u64 reg = KVM_REG_RISCV | size |
+				  KVM_REG_RISCV_SBI_STATE |
+				  KVM_REG_RISCV_SBI_STA | i;
+
+			if (uindices) {
+				if (put_user(reg, uindices))
+					return -EFAULT;
+				uindices++;
+			}
 		}
+
+		total += n;
 	}
 
-	return n;
+	return total;
+}
+
+static inline unsigned long num_sbi_regs(struct kvm_vcpu *vcpu)
+{
+	return copy_sbi_reg_indices(vcpu, NULL);
 }
 
 static inline unsigned long num_vector_regs(const struct kvm_vcpu *vcpu)
diff --git a/arch/riscv/kvm/vcpu_sbi.c b/arch/riscv/kvm/vcpu_sbi.c
index a1997c39dfde..72a2ffb8dcd1 100644
--- a/arch/riscv/kvm/vcpu_sbi.c
+++ b/arch/riscv/kvm/vcpu_sbi.c
@@ -345,6 +345,8 @@ int kvm_riscv_vcpu_set_reg_sbi(struct kvm_vcpu *vcpu,
 	reg_num &= ~KVM_REG_RISCV_SUBTYPE_MASK;
 
 	switch (reg_subtype) {
+	case KVM_REG_RISCV_SBI_STA:
+		return kvm_riscv_vcpu_set_reg_sbi_sta(vcpu, reg_num, reg_val);
 	default:
 		return -EINVAL;
 	}
@@ -370,6 +372,9 @@ int kvm_riscv_vcpu_get_reg_sbi(struct kvm_vcpu *vcpu,
 	reg_num &= ~KVM_REG_RISCV_SUBTYPE_MASK;
 
 	switch (reg_subtype) {
+	case KVM_REG_RISCV_SBI_STA:
+		ret = kvm_riscv_vcpu_get_reg_sbi_sta(vcpu, reg_num, &reg_val);
+		break;
 	default:
 		return -EINVAL;
 	}
diff --git a/arch/riscv/kvm/vcpu_sbi_sta.c b/arch/riscv/kvm/vcpu_sbi_sta.c
index 6592d287fc4e..87bf1a5f05ce 100644
--- a/arch/riscv/kvm/vcpu_sbi_sta.c
+++ b/arch/riscv/kvm/vcpu_sbi_sta.c
@@ -3,6 +3,8 @@
  * Copyright (c) 2023 Ventana Micro Systems Inc.
  */
 
+#include <linux/kconfig.h>
+#include <linux/kernel.h>
 #include <linux/kvm_host.h>
 
 #include <asm/kvm_vcpu_sbi.h>
@@ -59,3 +61,56 @@ const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_sta = {
 	.handler = kvm_sbi_ext_sta_handler,
 	.probe = kvm_sbi_ext_sta_probe,
 };
+
+int kvm_riscv_vcpu_get_reg_sbi_sta(struct kvm_vcpu *vcpu,
+				   unsigned long reg_num,
+				   unsigned long *reg_val)
+{
+	switch (reg_num) {
+	case KVM_REG_RISCV_SBI_STA_REG(shmem_lo):
+		*reg_val = (unsigned long)vcpu->arch.sta.shmem;
+		break;
+	case KVM_REG_RISCV_SBI_STA_REG(shmem_hi):
+		if (IS_ENABLED(CONFIG_32BIT))
+			*reg_val = upper_32_bits(vcpu->arch.sta.shmem);
+		else
+			*reg_val = 0;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+int kvm_riscv_vcpu_set_reg_sbi_sta(struct kvm_vcpu *vcpu,
+				   unsigned long reg_num,
+				   unsigned long reg_val)
+{
+	switch (reg_num) {
+	case KVM_REG_RISCV_SBI_STA_REG(shmem_lo):
+		if (IS_ENABLED(CONFIG_32BIT)) {
+			gpa_t hi = upper_32_bits(vcpu->arch.sta.shmem);
+
+			vcpu->arch.sta.shmem = reg_val;
+			vcpu->arch.sta.shmem |= hi << 32;
+		} else {
+			vcpu->arch.sta.shmem = reg_val;
+		}
+		break;
+	case KVM_REG_RISCV_SBI_STA_REG(shmem_hi):
+		if (IS_ENABLED(CONFIG_32BIT)) {
+			gpa_t lo = lower_32_bits(vcpu->arch.sta.shmem);
+
+			vcpu->arch.sta.shmem = ((gpa_t)reg_val << 32);
+			vcpu->arch.sta.shmem |= lo;
+		} else if (reg_val != 0) {
+			return -EINVAL;
+		}
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
-- 
2.43.0

