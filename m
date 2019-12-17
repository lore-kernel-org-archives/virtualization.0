From: <yezengruan@huawei.com>
Subject: [PATCH 2/5] KVM: arm64: Implement PV_LOCK_FEATURES call
Date: Tue, 17 Dec 2019 21:55:46 +0800
Message-ID: <20191217135549.3240-3-yezengruan__23919.0685608023$1576591007$gmane$org@huawei.com>
References: <20191217135549.3240-1-yezengruan@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191217135549.3240-1-yezengruan@huawei.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: yezengruan@huawei.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org, linux-doc@vger.kernel.org, virtualization@lists.linux-foundation.org
Cc: mark.rutland@arm.com, suzuki.poulose@arm.com, catalin.marinas@arm.com, daniel.lezcano@linaro.org, linux@armlinux.org.uk, steven.price@arm.com, james.morse@arm.com, maz@kernel.org, will@kernel.org, julien.thierry.kdev@gmail.com
List-Id: virtualization@lists.linuxfoundation.org

From: Zengruan Ye <yezengruan@huawei.com>

This provides a mechanism for querying which paravirtualized lock
features are available in this hypervisor.

Also add the header file which defines the ABI for the paravirtualized
lock features we're about to add.

Signed-off-by: Zengruan Ye <yezengruan@huawei.com>
---
 arch/arm64/include/asm/pvlock-abi.h | 16 ++++++++++++++++
 include/linux/arm-smccc.h           | 13 +++++++++++++
 virt/kvm/arm/hypercalls.c           |  3 +++
 3 files changed, 32 insertions(+)
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
index 59494df0f55b..59e65a951959 100644
--- a/include/linux/arm-smccc.h
+++ b/include/linux/arm-smccc.h
@@ -377,5 +377,18 @@ asmlinkage void __arm_smccc_hvc(unsigned long a0, unsigned long a1,
 			   ARM_SMCCC_OWNER_STANDARD_HYP,	\
 			   0x21)
 
+/* Paravirtualised lock calls */
+#define ARM_SMCCC_HV_PV_LOCK_FEATURES				\
+	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,			\
+			   ARM_SMCCC_SMC_64,			\
+			   ARM_SMCCC_OWNER_STANDARD_HYP,	\
+			   0x40)
+
+#define ARM_SMCCC_HV_PV_LOCK_PREEMPTED				\
+	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,			\
+			   ARM_SMCCC_SMC_64,			\
+			   ARM_SMCCC_OWNER_STANDARD_HYP,	\
+			   0x41)
+
 #endif /*__ASSEMBLY__*/
 #endif /*__LINUX_ARM_SMCCC_H*/
diff --git a/virt/kvm/arm/hypercalls.c b/virt/kvm/arm/hypercalls.c
index 550dfa3e53cd..ff13871fd85a 100644
--- a/virt/kvm/arm/hypercalls.c
+++ b/virt/kvm/arm/hypercalls.c
@@ -52,6 +52,9 @@ int kvm_hvc_call_handler(struct kvm_vcpu *vcpu)
 		case ARM_SMCCC_HV_PV_TIME_FEATURES:
 			val = SMCCC_RET_SUCCESS;
 			break;
+		case ARM_SMCCC_HV_PV_LOCK_FEATURES:
+			val = SMCCC_RET_SUCCESS;
+			break;
 		}
 		break;
 	case ARM_SMCCC_HV_PV_TIME_FEATURES:
-- 
2.19.1
