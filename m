Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55524207D
	for <virtualization@lists.linux-foundation.org>; Sun, 17 Dec 2023 20:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="XfqaobOX"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 54B9A410A3
	for <virtualization@lists.linux-foundation.org>; Sun, 17 Dec 2023 20:40:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 54B9A410A3
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.a=rsa-sha256 header.s=google header.b=XfqaobOX
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HGOFWRUNbqZq
	for <virtualization@lists.linux-foundation.org>;
	Sun, 17 Dec 2023 20:40:48 +0000 (UTC)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 4C78640985
	for <virtualization@lists.linux-foundation.org>; Sun, 17 Dec 2023 20:40:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4C78640985
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-a2330a92ae6so99911466b.0
        for <virtualization@lists.linux-foundation.org>; Sun, 17 Dec 2023 12:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1702845646; x=1703450446; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NtGr4Fn+I2+EzIJxOXUDFqiD7JlAKn3Prc9Bkz+E+cc=;
        b=XfqaobOX58oj4rLVNbbfVCjDsaBeh8OyDv5vWwUcohfMSZGnnoEwgIrsAWkpO95muI
         f1uSe90U0KEkReGtOL6T+wc7cuNNLXh7Zdc+mnKDxPkuI6chfwuhQLLv/hJnDOkMDh2q
         ok20Gz225Y0s5gJOcoH3RHTrcoqRgULpJEigSzxvwKmyd63NRNxA6puv5hx3EBXRXCaS
         lKOnlEtftnRsIEZ/FbJe9TxTZEi7fTvcJpfdP1zkzR3FXsppumVbToWKe0drlrxq8a1B
         645S5m0j3epslbiaJr+EHmSKiWwTHWMP7anRcnlNfCvaZxQah9ICNTpOTMC0roG9yymx
         Ja7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702845646; x=1703450446;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NtGr4Fn+I2+EzIJxOXUDFqiD7JlAKn3Prc9Bkz+E+cc=;
        b=KSI/ChHz4jW6tbai1sZ8JHUUBPJPQP1GQEaRVigBqiyUZxRtFZekmRuvR6OVRgofls
         ZBUYX+XkE6HTeHFGuXf9Ih/sW98oy09LhFe6f7aZB+yHfBJB/70W0g/2S2GbxFp9W3Dx
         e5Pvd3ywGySZZfL7ubJzqQIoMLoAsJ6Z1QO9HZXvpCUn5PZqrya06lOgxgUMUW+Q7ntf
         zrJlA24vl4vKxB13noYWyLiOeOTgel3BB1D9LroQU9aMWSviwzSQXIxt9O+wqj4zXkQO
         U2NdhNObzwTmMOreC5PAcLJzuU6LkYTnJZoON3mb3luyB3GEOnMnMzxitJMx6vyzO3HH
         ympQ==
X-Gm-Message-State: AOJu0YxGiP9J9SLRTq874BGGTlqn7+1ZQXMS4bjSxgpiLO8OXO68yeZY
	3jHsSWp6mw0NLxlYgTRouCOyVw==
X-Google-Smtp-Source: AGHT+IGZSyA+qVaXofC6/vCZf32Av6rxB35TER1A+ZgRIjF4fteian0c+B1PhM+QLysyNcIBtGTkig==
X-Received: by 2002:a17:906:74db:b0:a23:5776:d03f with SMTP id z27-20020a17090674db00b00a235776d03fmr385947ejl.64.1702845646284;
        Sun, 17 Dec 2023 12:40:46 -0800 (PST)
Received: from localhost (cst-prg-88-42.cust.vodafone.cz. [46.135.88.42])
        by smtp.gmail.com with ESMTPSA id tm6-20020a170907c38600b00a1db955c809sm13328040ejc.73.2023.12.17.12.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Dec 2023 12:40:45 -0800 (PST)
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
Subject: [PATCH v3 08/13] RISC-V: KVM: Add support for SBI STA registers
Date: Sun, 17 Dec 2023 21:40:28 +0100
Message-ID: <20231217204019.36492-23-ajones@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231217204019.36492-15-ajones@ventanamicro.com>
References: <20231217204019.36492-15-ajones@ventanamicro.com>
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
 arch/riscv/kvm/vcpu_onereg.c          | 36 +++++++++++-------
 arch/riscv/kvm/vcpu_sbi.c             |  5 +++
 arch/riscv/kvm/vcpu_sbi_sta.c         | 55 +++++++++++++++++++++++++++
 5 files changed, 96 insertions(+), 14 deletions(-)

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
index 30f89a0e855f..d8974f954f2a 100644
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
 #define KVM_REG_RISCV_SBI		(0x0a << KVM_REG_RISCV_TYPE_SHIFT)
+#define KVM_REG_RISCV_SBI_STA		(0x0 << KVM_REG_RISCV_SUBTYPE_SHIFT)
+#define KVM_REG_RISCV_SBI_STA_REG(name)		\
+		(offsetof(struct kvm_riscv_sbi_sta, name) / sizeof(unsigned long))
 
 /* Device Control API: RISC-V AIA */
 #define KVM_DEV_RISCV_APLIC_ALIGN		0x1000
diff --git a/arch/riscv/kvm/vcpu_onereg.c b/arch/riscv/kvm/vcpu_onereg.c
index 901480e73817..66d8fa648cfe 100644
--- a/arch/riscv/kvm/vcpu_onereg.c
+++ b/arch/riscv/kvm/vcpu_onereg.c
@@ -961,27 +961,35 @@ static unsigned long num_sbi_ext_regs(struct kvm_vcpu *vcpu)
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
-			  KVM_REG_RISCV_SBI | i;
+	if (scontext->ext_status[KVM_RISCV_SBI_EXT_STA] == KVM_RISCV_SBI_EXT_STATUS_ENABLED) {
+		u64 size = IS_ENABLED(CONFIG_32BIT) ? KVM_REG_SIZE_U32 : KVM_REG_SIZE_U64;
+		int n = sizeof(struct kvm_riscv_sbi_sta) / sizeof(unsigned long);
 
-		if (uindices) {
-			if (put_user(reg, uindices))
-				return -EFAULT;
-			uindices++;
+		for (int i = 0; i < n; i++) {
+			u64 reg = KVM_REG_RISCV | size |
+				  KVM_REG_RISCV_SBI | KVM_REG_RISCV_SBI_STA | i;
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
index 834176242ddf..0689f6813968 100644
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

