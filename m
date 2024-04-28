Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D21F56455;
	Sun, 28 Apr 2024 10:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714298727; cv=none; b=rgvJh+J/P2rSpojNz9oq47NHLPrl32QODnNdFdI5Fcd6TrC5XYqAkDA8bZvwHIgnEss/F+umbqkWyE2Wp/3LS1nvCcW5k5dJyI4xp0yPL+cZp8eClnheQdWl6TfA9WoublZwg2QllsZ7UVz926xWCVpRaXBq1i0dNEl7o9dEOUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714298727; c=relaxed/simple;
	bh=2FbE4jj+ugZfEAfok1kYC2xiS/f7hM14i+zVMXzSj54=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k49LFCxCz+OmpcpUE/CBi3EDzwXUHmlUVSLEVWrGp+Fzlq4ABtDqyrxzmlizoFFpldfJN7G+JPbLO0Ay3ntlTKkK+mOTH34T8/aPwQfGCscYuneXM2AzjKQfMNQFkKxgZv5sC5JKK9lYaU36pyVdz6Slh0n7C6yGEqRaTUeAlAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8Dx_+tiHy5mqV0EAA--.16088S3;
	Sun, 28 Apr 2024 18:05:22 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8DxsFVeHy5maTIIAA--.5646S4;
	Sun, 28 Apr 2024 18:05:21 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Tianrui Zhao <zhaotianrui@loongson.cn>,
	Juergen Gross <jgross@suse.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>
Cc: loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org
Subject: [PATCH v8 2/6] LoongArch: KVM: Add hypercall instruction emulation support
Date: Sun, 28 Apr 2024 18:05:14 +0800
Message-Id: <20240428100518.1642324-3-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240428100518.1642324-1-maobibo@loongson.cn>
References: <20240428100518.1642324-1-maobibo@loongson.cn>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8DxsFVeHy5maTIIAA--.5646S4
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

On LoongArch system, there is hypercall instruction special for
virtualization. When system executes this instruction on host side,
there is illegal instruction exception reported, however it will
trap into host when it is executed in VM mode.

When hypercall is emulated, A0 register is set with value
KVM_HCALL_INVALID_CODE, rather than inject EXCCODE_INE invalid
instruction exception. So VM can continue to executing the next code.

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
index 2dbec7853ae8..c862672ed953 100644
--- a/arch/loongarch/include/asm/Kbuild
+++ b/arch/loongarch/include/asm/Kbuild
@@ -26,4 +26,3 @@ generic-y += poll.h
 generic-y += param.h
 generic-y += posix_types.h
 generic-y += resource.h
-generic-y += kvm_para.h
diff --git a/arch/loongarch/include/asm/kvm_para.h b/arch/loongarch/include/asm/kvm_para.h
new file mode 100644
index 000000000000..d48f993ae206
--- /dev/null
+++ b/arch/loongarch/include/asm/kvm_para.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_LOONGARCH_KVM_PARA_H
+#define _ASM_LOONGARCH_KVM_PARA_H
+
+/*
+ * LoongArch hypercall return code
+ */
+#define KVM_HCALL_STATUS_SUCCESS	0
+#define KVM_HCALL_INVALID_CODE		-1UL
+#define KVM_HCALL_INVALID_PARAMETER	-2UL
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
index ed1d89d53e2e..923bbca9bd22 100644
--- a/arch/loongarch/kvm/exit.c
+++ b/arch/loongarch/kvm/exit.c
@@ -685,6 +685,15 @@ static int kvm_handle_lasx_disabled(struct kvm_vcpu *vcpu)
 	return RESUME_GUEST;
 }
 
+static int kvm_handle_hypercall(struct kvm_vcpu *vcpu)
+{
+	update_pc(&vcpu->arch);
+
+	/* Treat it as noop intruction, only set return value */
+	vcpu->arch.gprs[LOONGARCH_GPR_A0] = KVM_HCALL_INVALID_CODE;
+	return RESUME_GUEST;
+}
+
 /*
  * LoongArch KVM callback handling for unimplemented guest exiting
  */
@@ -716,6 +725,7 @@ static exit_handle_fn kvm_fault_tables[EXCCODE_INT_START] = {
 	[EXCCODE_LSXDIS]		= kvm_handle_lsx_disabled,
 	[EXCCODE_LASXDIS]		= kvm_handle_lasx_disabled,
 	[EXCCODE_GSPR]			= kvm_handle_gspr,
+	[EXCCODE_HVC]			= kvm_handle_hypercall,
 };
 
 int kvm_handle_fault(struct kvm_vcpu *vcpu, int fault)
-- 
2.39.3

