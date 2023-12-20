Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7210E41757
	for <virtualization@lists.linux-foundation.org>; Wed, 20 Dec 2023 16:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="AGmT/wHt"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 078716151C
	for <virtualization@lists.linux-foundation.org>; Wed, 20 Dec 2023 16:00:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 078716151C
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.a=rsa-sha256 header.s=google header.b=AGmT/wHt
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id E0kTuFRrcouI
	for <virtualization@lists.linux-foundation.org>;
	Wed, 20 Dec 2023 16:00:38 +0000 (UTC)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
	by smtp3.osuosl.org (Postfix) with ESMTPS id EB76460AC6
	for <virtualization@lists.linux-foundation.org>; Wed, 20 Dec 2023 16:00:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EB76460AC6
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-40d31116dbeso11888095e9.3
        for <virtualization@lists.linux-foundation.org>; Wed, 20 Dec 2023 08:00:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1703088036; x=1703692836; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rNcg4udqfynRQHSfPI9BJDgQt1epD/CHP8B3hiiPTls=;
        b=AGmT/wHtSOZ+WuBZKFsmdStCnm64QAzvKuk5fk5PuTvyzE1dgfQft1tSDG6bYYisNW
         R14NNDS7kZfYI21yo/uasGMIiny0JZaXlote4hy+BzGcQBSr6vxtWTk90OjcSasMy3Z7
         N+EpXR3p6ZzpT3Wm6Yei3JSv4pcZRY5BBAMn+aPfvPfPlvt73mhNs6LrocDGuqPsZ6wH
         4EULLKZkTgRuhPBrBKapq+5Vos1GtbkIv6HDJoW8ldy6aePmIaG2oil+hkekoHN+vBxB
         ZVWjm658/LfC7PVOUlbi0z335tylkiMn1p0m1i/q/86NbGJq9ExMlJSD3s99VhCQMiit
         roww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703088036; x=1703692836;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rNcg4udqfynRQHSfPI9BJDgQt1epD/CHP8B3hiiPTls=;
        b=WN/iycWy0NmbxoRnbAHZzWV1pipakoWZ11sm+jDtKA5FufctL+XNH5MV4pK0cC2Vku
         ocdJ3LxFtFNZbLy2463cAc1QIxaTuDxUjCH0HUPr22020nYxIVO7potTzYkM6YsOCYbS
         c9kDttl0wZwdA6pPDETip7TKHXjtr5cRoIhXB64/cJB2yoVRo9m7idLaUIvBmuZDpYgj
         GDRAHcqunK/zlUY99IAUoVMlfcM64uyKWJL5qw8Z5HjwXkFEsA3/nRw7kDjdnaAjNRK3
         trYdHOMEaJAgdycMnkhRZ6nYnKMDVtbHPqIZBdP30HKAHLm6Kupd65lTI1mL3wmdaoZr
         ue3Q==
X-Gm-Message-State: AOJu0YzD66vgtFXSeX0vhWC6tQDds5fVO5vz6zrCTbeIsT1WpYyHJppL
	kRpLW6a9pwswgWpUTWyMFm6IxA==
X-Google-Smtp-Source: AGHT+IF46vxvJMbWYlmd76wErQA1d8b5qP/ZBPcfspZS1cyPORa8PdYeblN7xjiAp7wAbnWZ0L1qbQ==
X-Received: by 2002:a05:600c:808e:b0:40b:5e59:c581 with SMTP id ew14-20020a05600c808e00b0040b5e59c581mr10876084wmb.171.1703088035897;
        Wed, 20 Dec 2023 08:00:35 -0800 (PST)
Received: from localhost (cst-prg-16-115.cust.vodafone.cz. [46.135.16.115])
        by smtp.gmail.com with ESMTPSA id q11-20020a05600c46cb00b0040d2d33312csm92255wmo.2.2023.12.20.08.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 08:00:35 -0800 (PST)
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
	conor.dooley@microchip.com,
	Atish Patra <atishp@rivosinc.com>
Subject: [PATCH v4 07/13] RISC-V: KVM: Add support for SBI extension registers
Date: Wed, 20 Dec 2023 17:00:20 +0100
Message-ID: <20231220160012.40184-22-ajones@ventanamicro.com>
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

Some SBI extensions have state that needs to be saved / restored
when migrating the VM. Provide a get/set-one-reg register type
for SBI extension registers. Each SBI extension that uses this type
will have its own subtype. There are currently no subtypes defined.
The next patch introduces the first one.

Reviewed-by: Anup Patel <anup@brainfault.org>
Reviewed-by: Atish Patra <atishp@rivosinc.com>
Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
---
 arch/riscv/include/asm/kvm_vcpu_sbi.h |  4 ++
 arch/riscv/include/uapi/asm/kvm.h     |  3 ++
 arch/riscv/kvm/vcpu_onereg.c          | 42 +++++++++++++++++--
 arch/riscv/kvm/vcpu_sbi.c             | 58 +++++++++++++++++++++++++++
 4 files changed, 103 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/include/asm/kvm_vcpu_sbi.h b/arch/riscv/include/asm/kvm_vcpu_sbi.h
index 99c23bb37a37..dd60f73b5c36 100644
--- a/arch/riscv/include/asm/kvm_vcpu_sbi.h
+++ b/arch/riscv/include/asm/kvm_vcpu_sbi.h
@@ -60,6 +60,10 @@ int kvm_riscv_vcpu_set_reg_sbi_ext(struct kvm_vcpu *vcpu,
 				   const struct kvm_one_reg *reg);
 int kvm_riscv_vcpu_get_reg_sbi_ext(struct kvm_vcpu *vcpu,
 				   const struct kvm_one_reg *reg);
+int kvm_riscv_vcpu_set_reg_sbi(struct kvm_vcpu *vcpu,
+			       const struct kvm_one_reg *reg);
+int kvm_riscv_vcpu_get_reg_sbi(struct kvm_vcpu *vcpu,
+			       const struct kvm_one_reg *reg);
 const struct kvm_vcpu_sbi_extension *kvm_vcpu_sbi_find_ext(
 				struct kvm_vcpu *vcpu, unsigned long extid);
 bool riscv_vcpu_supports_sbi_ext(struct kvm_vcpu *vcpu, int idx);
diff --git a/arch/riscv/include/uapi/asm/kvm.h b/arch/riscv/include/uapi/asm/kvm.h
index e961d79622fb..3471b1e48d18 100644
--- a/arch/riscv/include/uapi/asm/kvm.h
+++ b/arch/riscv/include/uapi/asm/kvm.h
@@ -242,6 +242,9 @@ enum KVM_RISCV_SBI_EXT_ID {
 #define KVM_REG_RISCV_VECTOR_REG(n)	\
 		((n) + sizeof(struct __riscv_v_ext_state) / sizeof(unsigned long))
 
+/* Registers for specific SBI extensions are mapped as type 10 */
+#define KVM_REG_RISCV_SBI_STATE		(0x0a << KVM_REG_RISCV_TYPE_SHIFT)
+
 /* Device Control API: RISC-V AIA */
 #define KVM_DEV_RISCV_APLIC_ALIGN		0x1000
 #define KVM_DEV_RISCV_APLIC_SIZE		0x4000
diff --git a/arch/riscv/kvm/vcpu_onereg.c b/arch/riscv/kvm/vcpu_onereg.c
index 11cdbf844291..c7f82a3b8fba 100644
--- a/arch/riscv/kvm/vcpu_onereg.c
+++ b/arch/riscv/kvm/vcpu_onereg.c
@@ -961,6 +961,29 @@ static unsigned long num_sbi_ext_regs(struct kvm_vcpu *vcpu)
 	return copy_sbi_ext_reg_indices(vcpu, NULL);
 }
 
+static inline unsigned long num_sbi_regs(struct kvm_vcpu *vcpu)
+{
+	return 0;
+}
+
+static int copy_sbi_reg_indices(struct kvm_vcpu *vcpu, u64 __user *uindices)
+{
+	int n = num_sbi_regs(vcpu);
+
+	for (int i = 0; i < n; i++) {
+		u64 reg = KVM_REG_RISCV | KVM_REG_SIZE_U64 |
+			  KVM_REG_RISCV_SBI_STATE | i;
+
+		if (uindices) {
+			if (put_user(reg, uindices))
+				return -EFAULT;
+			uindices++;
+		}
+	}
+
+	return n;
+}
+
 static inline unsigned long num_vector_regs(const struct kvm_vcpu *vcpu)
 {
 	if (!riscv_isa_extension_available(vcpu->arch.isa, v))
@@ -1028,6 +1051,7 @@ unsigned long kvm_riscv_vcpu_num_regs(struct kvm_vcpu *vcpu)
 	res += num_vector_regs(vcpu);
 	res += num_isa_ext_regs(vcpu);
 	res += num_sbi_ext_regs(vcpu);
+	res += num_sbi_regs(vcpu);
 
 	return res;
 }
@@ -1083,6 +1107,12 @@ int kvm_riscv_vcpu_copy_reg_indices(struct kvm_vcpu *vcpu,
 	ret = copy_sbi_ext_reg_indices(vcpu, uindices);
 	if (ret < 0)
 		return ret;
+	uindices += ret;
+
+	ret = copy_sbi_reg_indices(vcpu, uindices);
+	if (ret < 0)
+		return ret;
+	uindices += ret;
 
 	return 0;
 }
@@ -1105,12 +1135,14 @@ int kvm_riscv_vcpu_set_reg(struct kvm_vcpu *vcpu,
 	case KVM_REG_RISCV_FP_D:
 		return kvm_riscv_vcpu_set_reg_fp(vcpu, reg,
 						 KVM_REG_RISCV_FP_D);
+	case KVM_REG_RISCV_VECTOR:
+		return kvm_riscv_vcpu_set_reg_vector(vcpu, reg);
 	case KVM_REG_RISCV_ISA_EXT:
 		return kvm_riscv_vcpu_set_reg_isa_ext(vcpu, reg);
 	case KVM_REG_RISCV_SBI_EXT:
 		return kvm_riscv_vcpu_set_reg_sbi_ext(vcpu, reg);
-	case KVM_REG_RISCV_VECTOR:
-		return kvm_riscv_vcpu_set_reg_vector(vcpu, reg);
+	case KVM_REG_RISCV_SBI_STATE:
+		return kvm_riscv_vcpu_set_reg_sbi(vcpu, reg);
 	default:
 		break;
 	}
@@ -1136,12 +1168,14 @@ int kvm_riscv_vcpu_get_reg(struct kvm_vcpu *vcpu,
 	case KVM_REG_RISCV_FP_D:
 		return kvm_riscv_vcpu_get_reg_fp(vcpu, reg,
 						 KVM_REG_RISCV_FP_D);
+	case KVM_REG_RISCV_VECTOR:
+		return kvm_riscv_vcpu_get_reg_vector(vcpu, reg);
 	case KVM_REG_RISCV_ISA_EXT:
 		return kvm_riscv_vcpu_get_reg_isa_ext(vcpu, reg);
 	case KVM_REG_RISCV_SBI_EXT:
 		return kvm_riscv_vcpu_get_reg_sbi_ext(vcpu, reg);
-	case KVM_REG_RISCV_VECTOR:
-		return kvm_riscv_vcpu_get_reg_vector(vcpu, reg);
+	case KVM_REG_RISCV_SBI_STATE:
+		return kvm_riscv_vcpu_get_reg_sbi(vcpu, reg);
 	default:
 		break;
 	}
diff --git a/arch/riscv/kvm/vcpu_sbi.c b/arch/riscv/kvm/vcpu_sbi.c
index 088daaa23dd8..a1997c39dfde 100644
--- a/arch/riscv/kvm/vcpu_sbi.c
+++ b/arch/riscv/kvm/vcpu_sbi.c
@@ -325,6 +325,64 @@ int kvm_riscv_vcpu_get_reg_sbi_ext(struct kvm_vcpu *vcpu,
 	return 0;
 }
 
+int kvm_riscv_vcpu_set_reg_sbi(struct kvm_vcpu *vcpu,
+			       const struct kvm_one_reg *reg)
+{
+	unsigned long __user *uaddr =
+			(unsigned long __user *)(unsigned long)reg->addr;
+	unsigned long reg_num = reg->id & ~(KVM_REG_ARCH_MASK |
+					    KVM_REG_SIZE_MASK |
+					    KVM_REG_RISCV_SBI_STATE);
+	unsigned long reg_subtype, reg_val;
+
+	if (KVM_REG_SIZE(reg->id) != sizeof(unsigned long))
+		return -EINVAL;
+
+	if (copy_from_user(&reg_val, uaddr, KVM_REG_SIZE(reg->id)))
+		return -EFAULT;
+
+	reg_subtype = reg_num & KVM_REG_RISCV_SUBTYPE_MASK;
+	reg_num &= ~KVM_REG_RISCV_SUBTYPE_MASK;
+
+	switch (reg_subtype) {
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+int kvm_riscv_vcpu_get_reg_sbi(struct kvm_vcpu *vcpu,
+			       const struct kvm_one_reg *reg)
+{
+	unsigned long __user *uaddr =
+			(unsigned long __user *)(unsigned long)reg->addr;
+	unsigned long reg_num = reg->id & ~(KVM_REG_ARCH_MASK |
+					    KVM_REG_SIZE_MASK |
+					    KVM_REG_RISCV_SBI_STATE);
+	unsigned long reg_subtype, reg_val;
+	int ret;
+
+	if (KVM_REG_SIZE(reg->id) != sizeof(unsigned long))
+		return -EINVAL;
+
+	reg_subtype = reg_num & KVM_REG_RISCV_SUBTYPE_MASK;
+	reg_num &= ~KVM_REG_RISCV_SUBTYPE_MASK;
+
+	switch (reg_subtype) {
+	default:
+		return -EINVAL;
+	}
+
+	if (ret)
+		return ret;
+
+	if (copy_to_user(uaddr, &reg_val, KVM_REG_SIZE(reg->id)))
+		return -EFAULT;
+
+	return 0;
+}
+
 const struct kvm_vcpu_sbi_extension *kvm_vcpu_sbi_find_ext(
 				struct kvm_vcpu *vcpu, unsigned long extid)
 {
-- 
2.43.0

