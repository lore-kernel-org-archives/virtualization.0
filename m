Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B361804D;
	Wed,  3 Jan 2024 07:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8BxHOvACZVlvHIBAA--.5690S3;
	Wed, 03 Jan 2024 15:16:16 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8Dxqb2_CZVlm1EYAA--.43800S3;
	Wed, 03 Jan 2024 15:16:16 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Tianrui Zhao <zhaotianrui@loongson.cn>,
	Juergen Gross <jgross@suse.com>
Cc: loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org
Subject: [PATCH 1/5] LoongArch: KVM: Add hypercall instruction emulation support
Date: Wed,  3 Jan 2024 15:16:11 +0800
Message-Id: <20240103071615.3422264-2-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240103071615.3422264-1-maobibo@loongson.cn>
References: <20240103071615.3422264-1-maobibo@loongson.cn>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8Dxqb2_CZVlm1EYAA--.43800S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxXr1DuFW7XF17Gw1DKF47ZFc_yoW5Zr1xpF
	93Cr1kGr4rGryfCFy3twn8Wr13ArZ7Kw12gFy2k3yUAF12qF1Fyr4kKryDZFy5Jw4rXF1S
	gFWftw1Y9F4UtacCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r126r13M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv
	67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE
	42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
	kF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jjOJ5UUUUU=

On LoongArch system, hypercall instruction is supported when system
runs on VM mode. This patch adds dummy function with hypercall
instruction emulation, rather than inject EXCCODE_INE invalid
instruction exception.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 arch/loongarch/include/asm/Kbuild      |  1 -
 arch/loongarch/include/asm/kvm_para.h  | 26 ++++++++++++++++++++++++++
 arch/loongarch/include/uapi/asm/Kbuild |  2 --
 arch/loongarch/kvm/exit.c              | 10 ++++++++++
 4 files changed, 36 insertions(+), 3 deletions(-)
 create mode 100644 arch/loongarch/include/asm/kvm_para.h
 delete mode 100644 arch/loongarch/include/uapi/asm/Kbuild

diff --git a/arch/loongarch/include/asm/Kbuild b/arch/loongarch/include/asm/Kbuild
index 93783fa24f6e..22991a6f0e2b 100644
--- a/arch/loongarch/include/asm/Kbuild
+++ b/arch/loongarch/include/asm/Kbuild
@@ -23,4 +23,3 @@ generic-y += poll.h
 generic-y += param.h
 generic-y += posix_types.h
 generic-y += resource.h
-generic-y += kvm_para.h
diff --git a/arch/loongarch/include/asm/kvm_para.h b/arch/loongarch/include/asm/kvm_para.h
new file mode 100644
index 000000000000..9425d3b7e486
--- /dev/null
+++ b/arch/loongarch/include/asm/kvm_para.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_LOONGARCH_KVM_PARA_H
+#define _ASM_LOONGARCH_KVM_PARA_H
+
+/*
+ * LoongArch hypcall return code
+ */
+#define KVM_HC_STATUS_SUCCESS		0
+#define KVM_HC_INVALID_CODE		-1UL
+#define KVM_HC_INVALID_PARAMETER	-2UL
+
+static inline unsigned int kvm_arch_para_features(void)
+{
+	return 0;
+}
+
+static inline unsigned int kvm_arch_para_hints(void)
+{
+	return 0;
+}
+
+static inline bool kvm_check_and_clear_guest_paused(void)
+{
+	return false;
+}
+#endif /* _ASM_LOONGARCH_KVM_PARA_H */
diff --git a/arch/loongarch/include/uapi/asm/Kbuild b/arch/loongarch/include/uapi/asm/Kbuild
deleted file mode 100644
index 4aa680ca2e5f..000000000000
--- a/arch/loongarch/include/uapi/asm/Kbuild
+++ /dev/null
@@ -1,2 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-generic-y += kvm_para.h
diff --git a/arch/loongarch/kvm/exit.c b/arch/loongarch/kvm/exit.c
index e708a1786d6b..59e5fe221982 100644
--- a/arch/loongarch/kvm/exit.c
+++ b/arch/loongarch/kvm/exit.c
@@ -650,6 +650,15 @@ static int kvm_handle_fpu_disabled(struct kvm_vcpu *vcpu)
 	return RESUME_GUEST;
 }
 
+static int kvm_handle_hypcall(struct kvm_vcpu *vcpu)
+{
+	update_pc(&vcpu->arch);
+
+	/* Treat it as noop intruction, only set return value */
+	vcpu->arch.gprs[LOONGARCH_GPR_A0] = KVM_HC_INVALID_CODE;
+	return RESUME_GUEST;
+}
+
 /*
  * LoongArch KVM callback handling for unimplemented guest exiting
  */
@@ -679,6 +688,7 @@ static exit_handle_fn kvm_fault_tables[EXCCODE_INT_START] = {
 	[EXCCODE_TLBM]			= kvm_handle_write_fault,
 	[EXCCODE_FPDIS]			= kvm_handle_fpu_disabled,
 	[EXCCODE_GSPR]			= kvm_handle_gspr,
+	[EXCCODE_HVC]			= kvm_handle_hypcall,
 };
 
 int kvm_handle_fault(struct kvm_vcpu *vcpu, int fault)
-- 
2.39.3

