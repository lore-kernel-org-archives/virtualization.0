Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3FB3BB38
	for <virtualization@lists.linux-foundation.org>; Thu, 14 Dec 2023 10:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="kbxVfdHA"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5DD2083CBC
	for <virtualization@lists.linux-foundation.org>; Thu, 14 Dec 2023 10:16:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5DD2083CBC
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.a=rsa-sha256 header.s=google header.b=kbxVfdHA
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Y2o0Nu2Se6Lz
	for <virtualization@lists.linux-foundation.org>;
	Thu, 14 Dec 2023 10:16:06 +0000 (UTC)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
	by smtp1.osuosl.org (Postfix) with ESMTPS id AC9B983CA6
	for <virtualization@lists.linux-foundation.org>; Thu, 14 Dec 2023 10:16:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AC9B983CA6
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-40c38e292c8so2417935e9.0
        for <virtualization@lists.linux-foundation.org>; Thu, 14 Dec 2023 02:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1702548964; x=1703153764; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XYS8fA2u8jdiTOaLOE6JjNR40Nvi3zTmLhn6Y0kb13Y=;
        b=kbxVfdHAJlzS89xL1gWchV2Hwg3pVaAX0S5WmFLTUnX3EiGk6ipk4cKdsCXUuoPoiw
         gx/gaK/9e86FeOiJ3L3Sk2uYcFsZBcRaShTfXk6swuJVC38evtmRte7F64o7Wd+sYl7P
         r2HeWs4SBWTMIPAkyQQyOInAHETCA7EcEBQ+/JzNti9jUhYjYgFfRPNFo5R9CironD9A
         SiWFnQRcDVhf0vvWRRCUJat261rQ1kZ+Nvlt5qOTIR7Gzn22UbZm7C6Tw2VT1JFCZFvJ
         MNo99FP7TOqB3aaHsj8nLKOD7dbx2zM7Cj9AIqcbIF1Tz+SEETtV2YfRMF6U/n1Cxl+g
         Q4Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702548964; x=1703153764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XYS8fA2u8jdiTOaLOE6JjNR40Nvi3zTmLhn6Y0kb13Y=;
        b=qzx5HRJ1P+Rao4Th7mq15nUuVrH7zM4UJOS82ZVd1Xno8w2Kdv6kZYZjZn/R2266Sp
         2RKo89FAA3lbCNMciljlRo9mF3mZruI6d+tnT8RmLMuNVnjNRecuc/QyT9AU62qOYvfQ
         7n5VBYxlRs/RyszwLIj75mXK5fI7EHLQ9Ena4+YkdUfEyQg9PVy+DNCQbKc1EQ2kMxdq
         29HhJfWo+JAQq/uJOKzi9Pwj/itKIrkOln/H4AQMvutA+6RcSKsczIbvMzdSOacK7zkv
         w8De+Xr6c93OUIBq7SSs0NwZfaiZxRuy+Emtgo5jziDwCIsZV4AS4+FwK3xNaGjBRq5g
         Z2NA==
X-Gm-Message-State: AOJu0YyUM58UW4G9FBnSysPVbDwXwr9tZOhfeb0De6NsTO8vtrKx7OI/
	dPlnpXOopbIlLxWOVuYOwFAIig==
X-Google-Smtp-Source: AGHT+IHWi/Q17hyThAxoAYyLpX+AXOSBI7CDCNwmTuPfERhY3kp+7EJ0IOm1AmAiBWjQC/oaucGzkA==
X-Received: by 2002:a05:600c:2a41:b0:40b:5e56:7b67 with SMTP id x1-20020a05600c2a4100b0040b5e567b67mr4940265wme.176.1702548963873;
        Thu, 14 Dec 2023 02:16:03 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id p8-20020a05600c468800b0040c488e4fb5sm14092326wmo.40.2023.12.14.02.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 02:16:03 -0800 (PST)
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
Subject: [PATCH v2 07/13] RISC-V: KVM: Add support for SBI extension registers
Date: Thu, 14 Dec 2023 11:15:59 +0100
Message-ID: <20231214101552.100721-22-ajones@ventanamicro.com>
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

Some SBI extensions have state that needs to be saved / restored
when migrating the VM. Provide a get/set-one-reg register type
for SBI extension registers. Each SBI extension that uses this type
will have its own subtype. There are currently no subtypes defined.
The next patch introduces the first one.

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
index e961d79622fb..30f89a0e855f 100644
--- a/arch/riscv/include/uapi/asm/kvm.h
+++ b/arch/riscv/include/uapi/asm/kvm.h
@@ -242,6 +242,9 @@ enum KVM_RISCV_SBI_EXT_ID {
 #define KVM_REG_RISCV_VECTOR_REG(n)	\
 		((n) + sizeof(struct __riscv_v_ext_state) / sizeof(unsigned long))
 
+/* Registers for specific SBI extensions are mapped as type 10 */
+#define KVM_REG_RISCV_SBI		(0x0a << KVM_REG_RISCV_TYPE_SHIFT)
+
 /* Device Control API: RISC-V AIA */
 #define KVM_DEV_RISCV_APLIC_ALIGN		0x1000
 #define KVM_DEV_RISCV_APLIC_SIZE		0x4000
diff --git a/arch/riscv/kvm/vcpu_onereg.c b/arch/riscv/kvm/vcpu_onereg.c
index 11cdbf844291..901480e73817 100644
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
+			  KVM_REG_RISCV_SBI | i;
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
+	case KVM_REG_RISCV_SBI:
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
+	case KVM_REG_RISCV_SBI:
+		return kvm_riscv_vcpu_get_reg_sbi(vcpu, reg);
 	default:
 		break;
 	}
diff --git a/arch/riscv/kvm/vcpu_sbi.c b/arch/riscv/kvm/vcpu_sbi.c
index 088daaa23dd8..834176242ddf 100644
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
+					    KVM_REG_RISCV_SBI);
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
+					    KVM_REG_RISCV_SBI);
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

