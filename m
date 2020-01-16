From: Zengruan Ye <yezengruan@huawei.com>
Subject: [PATCH v3 4/8] KVM: arm64: Add SMCCC paravirtualised lock calls
Date: Thu, 16 Jan 2020 20:46:22 +0800
Message-ID: <20200116124626.1155-5-yezengruan@huawei.com>
References: <20200116124626.1155-1-yezengruan@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20200116124626.1155-1-yezengruan@huawei.com>
Sender: linux-doc-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org, linux-doc@vger.kernel.org, virtualization@lists.linux-foundation.org
Cc: yezengruan@huawei.com, maz@kernel.org, james.morse@arm.com, linux@armlinux.org.uk, suzuki.poulose@arm.com, julien.thierry.kdev@gmail.com, catalin.marinas@arm.com, mark.rutland@arm.com, will@kernel.org, steven.price@arm.com, daniel.lezcano@linaro.org, wanghaibin.wang@huawei.com, peterz@infradead.org, longman@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

Add two new SMCCC compatible hypercalls for PV lock features:
 * ARM_SMCCC_VENDOR_HYP_KVM_PV_LOCK_FUNC_ID:  0x86000001
   - KVM_PV_LOCK_FEATURES:   0
   - KVM_PV_LOCK_PREEMPTED:  1

Also add the header file which defines the ABI for the paravirtualized
lock features we're about to add.

Signed-off-by: Zengruan Ye <yezengruan@huawei.com>
---
 arch/arm64/include/asm/pvlock-abi.h | 16 ++++++++++++++++
 include/linux/arm-smccc.h           | 10 ++++++++++
 2 files changed, 26 insertions(+)
 create mode 100644 arch/arm64/include/asm/pvlock-abi.h

diff --git a/arch/arm64/include/asm/pvlock-abi.h b/arch/arm64/include/asm/pvlock-abi.h
new file mode 100644
index 000000000000..06e0c3d7710a
--- /dev/null
+++ b/arch/arm64/include/asm/pvlock-abi.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright(c) 2019 Huawei Technologies Co., Ltd
+ * Author: Zengruan Ye <yezengruan@huawei.com>
+ */
+
+#ifndef __ASM_PVLOCK_ABI_H
+#define __ASM_PVLOCK_ABI_H
+
+struct pvlock_vcpu_state {
+	__le64 preempted;
+	/* Structure must be 64 byte aligned, pad to that size */
+	u8 padding[56];
+} __packed;
+
+#endif
diff --git a/include/linux/arm-smccc.h b/include/linux/arm-smccc.h
index 2b2c295c9109..081be5f6a6be 100644
--- a/include/linux/arm-smccc.h
+++ b/include/linux/arm-smccc.h
@@ -394,14 +394,24 @@ asmlinkage void __arm_smccc_hvc(unsigned long a0, unsigned long a1,
 
 /* KVM "vendor specific" services */
 #define ARM_SMCCC_KVM_FUNC_FEATURES		0
+#define ARM_SMCCC_KVM_FUNC_PV_LOCK		1
 #define ARM_SMCCC_KVM_FUNC_FEATURES_2		127
 #define ARM_SMCCC_KVM_NUM_FUNCS			128
 
+#define KVM_PV_LOCK_FEATURES			0
+#define KVM_PV_LOCK_PREEMPTED			1
+
 #define ARM_SMCCC_VENDOR_HYP_KVM_FEATURES_FUNC_ID			\
 	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,				\
 			   ARM_SMCCC_SMC_32,				\
 			   ARM_SMCCC_OWNER_VENDOR_HYP,			\
 			   ARM_SMCCC_KVM_FUNC_FEATURES)
 
+#define ARM_SMCCC_VENDOR_HYP_KVM_PV_LOCK_FUNC_ID			\
+	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,				\
+			   ARM_SMCCC_SMC_32,				\
+			   ARM_SMCCC_OWNER_VENDOR_HYP,			\
+			   ARM_SMCCC_KVM_FUNC_PV_LOCK)
+
 #endif /*__ASSEMBLY__*/
 #endif /*__LINUX_ARM_SMCCC_H*/
-- 
2.19.1
