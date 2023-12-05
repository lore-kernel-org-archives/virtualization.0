Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A546A333
	for <virtualization@lists.linux-foundation.org>; Tue,  5 Dec 2023 18:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="dyhdXJRa"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 031C160E64
	for <virtualization@lists.linux-foundation.org>; Tue,  5 Dec 2023 18:11:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 031C160E64
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.a=rsa-sha256 header.s=google header.b=dyhdXJRa
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZMe3dukuo_28
	for <virtualization@lists.linux-foundation.org>;
	Tue,  5 Dec 2023 18:11:34 +0000 (UTC)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0340E60E55
	for <virtualization@lists.linux-foundation.org>; Tue,  5 Dec 2023 18:11:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0340E60E55
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-a1caddd6d28so115306666b.1
        for <virtualization@lists.linux-foundation.org>; Tue, 05 Dec 2023 10:11:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1701799892; x=1702404692; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6h85CYq2H3Bjzoic/rnr1HxTS56+iOncT279HVmrGAo=;
        b=dyhdXJRavIAjcnNZtnWB0UCagOr2QYl8ReXZC5Avj6qcthxxmCzVCfJegWeZtNmACU
         n3Z5EXRaQ6Du4s6HkrkfKV1SeE0I2DfjQpeIwflVFTRVEteRsMiuW2d4SDJUUxBn2zD2
         pVQcNlr4BsXEq2EuzrCzbE/9pxHHm32IJhqUU4N7LJZLYVuys5KdOEByeFEH2EMkQpZb
         R+jgB++exRylA5A3S6qXXwuKkjB3bLRHqM6Dm2R/EP0zLZpCoFQma5Z7RKfakETviKRR
         oeZke2hFZ9KBImkhOxZJPI4Wl9YoMGdCzvVLukrpH6gx9X7+H8I1LieKKwcKb7tu5ekF
         U9Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701799892; x=1702404692;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6h85CYq2H3Bjzoic/rnr1HxTS56+iOncT279HVmrGAo=;
        b=jrkaGmIRBaJqrRaHORqlm33wKjP8dvLt6gIZpMI6WILsz+OFEX0T/eV2vI88oyWS9M
         OltzbNi4j9358lPdsmcD/ShJ8+TbWuenbcq4CALE69Nlw2dL4UuWYpBIZoNIXfAvLm2S
         gEuGFTtA6NuHEhGWwDQxPZCPgNGDB61qPKHVU4+hOpybxcb7Jeu0m/W2bdUnV4/e3iam
         O9if98mcaFtjv6gYyu/QF3WtjHa8qwybeJ7uo6AqNOebETQnurPj7lwO5PimscGISCCj
         y+ROT5kl91CkRjzMJo738qyXUCu4+zeeQa/iMUmk/1343Xs7mDXps9f0HYRjXIwiWye/
         IOLw==
X-Gm-Message-State: AOJu0Yx3G09KmZc90K9J9Mkn+INgplN/BL6kL6yrLYnwYd4Y/zmgGo0m
	nfXDK2p4a5NWn3qhQquy8aNr1A==
X-Google-Smtp-Source: AGHT+IER/2CAuqh6Z8btx+hMbI7wTr23oYfEqmvRl1QXxp3ynKfAd3uxyZ8YM9016kMOwyB/0+BT2g==
X-Received: by 2002:a17:906:c5b:b0:a19:9b79:8b41 with SMTP id t27-20020a1709060c5b00b00a199b798b41mr567854ejf.82.1701799892243;
        Tue, 05 Dec 2023 10:11:32 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id cb26-20020a170906a45a00b00a0958af2387sm6986924ejb.201.2023.12.05.10.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 10:11:31 -0800 (PST)
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
	guoren@kernel.org
Subject: [PATCH v1 08/14] RISC-V: KVM: Add support for SBI extension registers
Date: Tue,  5 Dec 2023 19:11:28 +0100
Message-ID: <20231205181119.207204-24-ajones@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231205181119.207204-16-ajones@ventanamicro.com>
References: <20231205181119.207204-16-ajones@ventanamicro.com>
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
 arch/riscv/include/uapi/asm/kvm.h |  3 +
 arch/riscv/kvm/vcpu_onereg.c      | 92 +++++++++++++++++++++++++++++++
 2 files changed, 95 insertions(+)

diff --git a/arch/riscv/include/uapi/asm/kvm.h b/arch/riscv/include/uapi/asm/kvm.h
index 85b979f7d2bd..86df125ef17f 100644
--- a/arch/riscv/include/uapi/asm/kvm.h
+++ b/arch/riscv/include/uapi/asm/kvm.h
@@ -269,6 +269,9 @@ enum KVM_RISCV_SBI_EXT_ID {
 #define KVM_REG_RISCV_VECTOR_REG(n)	\
 		((n) + sizeof(struct __riscv_v_ext_state) / sizeof(unsigned long))
 
+/* Registers for specific SBI extensions are mapped as type 10 */
+#define KVM_REG_RISCV_SBI		(0x0a << KVM_REG_RISCV_TYPE_SHIFT)
+
 /* Device Control API: RISC-V AIA */
 #define KVM_DEV_RISCV_APLIC_ALIGN		0x1000
 #define KVM_DEV_RISCV_APLIC_SIZE		0x4000
diff --git a/arch/riscv/kvm/vcpu_onereg.c b/arch/riscv/kvm/vcpu_onereg.c
index 62c7334f74cf..dbd8cedfd556 100644
--- a/arch/riscv/kvm/vcpu_onereg.c
+++ b/arch/riscv/kvm/vcpu_onereg.c
@@ -1015,6 +1015,87 @@ static unsigned long num_sbi_ext_regs(struct kvm_vcpu *vcpu)
 	return copy_sbi_ext_reg_indices(vcpu, NULL);
 }
 
+static int kvm_riscv_vcpu_get_reg_sbi(struct kvm_vcpu *vcpu,
+				      const struct kvm_one_reg *reg)
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
+static int kvm_riscv_vcpu_set_reg_sbi(struct kvm_vcpu *vcpu,
+				      const struct kvm_one_reg *reg)
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
 /*
  * kvm_riscv_vcpu_num_regs - how many registers do we present via KVM_GET/SET_ONE_REG
  *
@@ -1032,6 +1113,7 @@ unsigned long kvm_riscv_vcpu_num_regs(struct kvm_vcpu *vcpu)
 	res += num_fp_d_regs(vcpu);
 	res += num_isa_ext_regs(vcpu);
 	res += num_sbi_ext_regs(vcpu);
+	res += num_sbi_regs(vcpu);
 
 	return res;
 }
@@ -1082,6 +1164,12 @@ int kvm_riscv_vcpu_copy_reg_indices(struct kvm_vcpu *vcpu,
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
@@ -1110,6 +1198,8 @@ int kvm_riscv_vcpu_set_reg(struct kvm_vcpu *vcpu,
 		return kvm_riscv_vcpu_set_reg_sbi_ext(vcpu, reg);
 	case KVM_REG_RISCV_VECTOR:
 		return kvm_riscv_vcpu_set_reg_vector(vcpu, reg);
+	case KVM_REG_RISCV_SBI:
+		return kvm_riscv_vcpu_set_reg_sbi(vcpu, reg);
 	default:
 		break;
 	}
@@ -1141,6 +1231,8 @@ int kvm_riscv_vcpu_get_reg(struct kvm_vcpu *vcpu,
 		return kvm_riscv_vcpu_get_reg_sbi_ext(vcpu, reg);
 	case KVM_REG_RISCV_VECTOR:
 		return kvm_riscv_vcpu_get_reg_vector(vcpu, reg);
+	case KVM_REG_RISCV_SBI:
+		return kvm_riscv_vcpu_get_reg_sbi(vcpu, reg);
 	default:
 		break;
 	}
-- 
2.43.0

