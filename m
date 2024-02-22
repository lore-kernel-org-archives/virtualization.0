Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234A819452;
	Thu, 22 Feb 2024 03:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708572493; cv=none; b=q/bIlC8voRQvlYB0MyC+xe1gMaJNHcUnnE6Ini1ZvzwIl8nPCUryJVidtmukTVF2CiL/U3hQqGojvZPprFcohdCvDPilrphA47IBW5xddOcbRePJz1C3mcb6nWhuUwK3t2UE4zklffdSYAVCeqmGhFrx3O6d9j07l70h6d/1OV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708572493; c=relaxed/simple;
	bh=tbGL0Y1sGPf25yyVHX3SZzxFuyo7nqXTcKBfEwAnPNo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oyPUwBv1Y8uD4WrdL5H83HLo8qNHU4yLCKXMO5k7RCX1yPs60Uy1iaOsL+VLz3yjcMSjY0zTxbUXxoypGJqXVb3Iwcb8IL7wylwNcFKVher8uf132iF2+PXGafDOzgOIIvs5RJG6JaU8O1I+yFrd6QqG+a/QwNEYI2FYTwwOKzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8CxLOtJv9ZlaQoQAA--.31286S3;
	Thu, 22 Feb 2024 11:28:09 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8CxrhNDv9Zl+nM+AA--.41033S7;
	Thu, 22 Feb 2024 11:28:09 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Tianrui Zhao <zhaotianrui@loongson.cn>,
	Juergen Gross <jgross@suse.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org
Subject: [PATCH v5 5/6] LoongArch: KVM: Add vcpu search support from physical cpuid
Date: Thu, 22 Feb 2024 11:28:02 +0800
Message-Id: <20240222032803.2177856-6-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240222032803.2177856-1-maobibo@loongson.cn>
References: <20240222032803.2177856-1-maobibo@loongson.cn>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8CxrhNDv9Zl+nM+AA--.41033S7
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW3WrWrKr4xGw1fAr45Kw4DGFX_yoW3Jw48pF
	ZF9wsxXr4rGr17G348tw4kurZI9rWvgw1SvasIgay3Ar1qqr98XrZYkryUZF98Jw1ruF4I
	qFn3J3W5uFW0yagCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUkIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI
	0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280
	aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28Icx
	kI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2Iq
	xVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42
	IY6xIIjxv20xvE14v26ryj6F1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY
	6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aV
	CY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8l38UUUUUU==

Physical cpuid is used for interrupt routing for irqchips such as
ipi/msi/extioi interrupt controller. And physical cpuid is stored
at CSR register LOONGARCH_CSR_CPUID, it can not be changed once vcpu
is created and physical cpuid of two vcpus cannot be the same.

Different irqchips have different size declaration about physical cpuid,
max cpuid value for CSR LOONGARCH_CSR_CPUID on 3A5000 is 512, max cpuid
supported by IPI hardware is 1024, 256 for extioi irqchip, and 65536
for MSI irqchip.

The smallest value from all interrupt controllers is selected now,
and the max cpuid size is defines as 256 by KVM which comes from
extioi irqchip.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 arch/loongarch/include/asm/kvm_host.h | 26 ++++++++
 arch/loongarch/include/asm/kvm_vcpu.h |  1 +
 arch/loongarch/kvm/vcpu.c             | 93 ++++++++++++++++++++++++++-
 arch/loongarch/kvm/vm.c               | 11 ++++
 4 files changed, 130 insertions(+), 1 deletion(-)

diff --git a/arch/loongarch/include/asm/kvm_host.h b/arch/loongarch/include/asm/kvm_host.h
index 2d62f7b0d377..3ba16ef1fe69 100644
--- a/arch/loongarch/include/asm/kvm_host.h
+++ b/arch/loongarch/include/asm/kvm_host.h
@@ -64,6 +64,30 @@ struct kvm_world_switch {
 
 #define MAX_PGTABLE_LEVELS	4
 
+/*
+ * Physical cpu id is used for interrupt routing, there are different
+ * definitions about physical cpuid on different hardwares.
+ *  For LOONGARCH_CSR_CPUID register, max cpuid size if 512
+ *  For IPI HW, max dest CPUID size 1024
+ *  For extioi interrupt controller, max dest CPUID size is 256
+ *  For MSI interrupt controller, max supported CPUID size is 65536
+ *
+ * Currently max CPUID is defined as 256 for KVM hypervisor, in future
+ * it will be expanded to 4096, including 16 packages at most. And every
+ * package supports at most 256 vcpus
+ */
+#define KVM_MAX_PHYID		256
+
+struct kvm_phyid_info {
+	struct kvm_vcpu	*vcpu;
+	bool		enabled;
+};
+
+struct kvm_phyid_map {
+	int max_phyid;
+	struct kvm_phyid_info phys_map[KVM_MAX_PHYID];
+};
+
 struct kvm_arch {
 	/* Guest physical mm */
 	kvm_pte_t *pgd;
@@ -71,6 +95,8 @@ struct kvm_arch {
 	unsigned long invalid_ptes[MAX_PGTABLE_LEVELS];
 	unsigned int  pte_shifts[MAX_PGTABLE_LEVELS];
 	unsigned int  root_level;
+	spinlock_t    phyid_map_lock;
+	struct kvm_phyid_map  *phyid_map;
 
 	s64 time_offset;
 	struct kvm_context __percpu *vmcs;
diff --git a/arch/loongarch/include/asm/kvm_vcpu.h b/arch/loongarch/include/asm/kvm_vcpu.h
index 0cb4fdb8a9b5..9f53950959da 100644
--- a/arch/loongarch/include/asm/kvm_vcpu.h
+++ b/arch/loongarch/include/asm/kvm_vcpu.h
@@ -81,6 +81,7 @@ void kvm_save_timer(struct kvm_vcpu *vcpu);
 void kvm_restore_timer(struct kvm_vcpu *vcpu);
 
 int kvm_vcpu_ioctl_interrupt(struct kvm_vcpu *vcpu, struct kvm_interrupt *irq);
+struct kvm_vcpu *kvm_get_vcpu_by_cpuid(struct kvm *kvm, int cpuid);
 
 /*
  * Loongarch KVM guest interrupt handling
diff --git a/arch/loongarch/kvm/vcpu.c b/arch/loongarch/kvm/vcpu.c
index 27701991886d..40296d8ef297 100644
--- a/arch/loongarch/kvm/vcpu.c
+++ b/arch/loongarch/kvm/vcpu.c
@@ -274,6 +274,95 @@ static int _kvm_getcsr(struct kvm_vcpu *vcpu, unsigned int id, u64 *val)
 	return 0;
 }
 
+static inline int kvm_set_cpuid(struct kvm_vcpu *vcpu, u64 val)
+{
+	int cpuid;
+	struct loongarch_csrs *csr = vcpu->arch.csr;
+	struct kvm_phyid_map  *map;
+
+	if (val >= KVM_MAX_PHYID)
+		return -EINVAL;
+
+	cpuid = kvm_read_sw_gcsr(csr, LOONGARCH_CSR_ESTAT);
+	map = vcpu->kvm->arch.phyid_map;
+	spin_lock(&vcpu->kvm->arch.phyid_map_lock);
+	if (map->phys_map[cpuid].enabled) {
+		/*
+		 * Cpuid is already set before
+		 * Forbid changing different cpuid at runtime
+		 */
+		if (cpuid != val) {
+			/*
+			 * Cpuid 0 is initial value for vcpu, maybe invalid
+			 * unset value for vcpu
+			 */
+			if (cpuid) {
+				spin_unlock(&vcpu->kvm->arch.phyid_map_lock);
+				return -EINVAL;
+			}
+		} else {
+			 /* Discard duplicated cpuid set */
+			spin_unlock(&vcpu->kvm->arch.phyid_map_lock);
+			return 0;
+		}
+	}
+
+	if (map->phys_map[val].enabled) {
+		/*
+		 * New cpuid is already set with other vcpu
+		 * Forbid sharing the same cpuid between different vcpus
+		 */
+		if (map->phys_map[val].vcpu != vcpu) {
+			spin_unlock(&vcpu->kvm->arch.phyid_map_lock);
+			return -EINVAL;
+		}
+
+		/* Discard duplicated cpuid set operation*/
+		spin_unlock(&vcpu->kvm->arch.phyid_map_lock);
+		return 0;
+	}
+
+	kvm_write_sw_gcsr(csr, LOONGARCH_CSR_CPUID, val);
+	map->phys_map[val].enabled	= true;
+	map->phys_map[val].vcpu		= vcpu;
+	if (map->max_phyid < val)
+		map->max_phyid = val;
+	spin_unlock(&vcpu->kvm->arch.phyid_map_lock);
+	return 0;
+}
+
+struct kvm_vcpu *kvm_get_vcpu_by_cpuid(struct kvm *kvm, int cpuid)
+{
+	struct kvm_phyid_map  *map;
+
+	if (cpuid >= KVM_MAX_PHYID)
+		return NULL;
+
+	map = kvm->arch.phyid_map;
+	if (map->phys_map[cpuid].enabled)
+		return map->phys_map[cpuid].vcpu;
+
+	return NULL;
+}
+
+static inline void kvm_drop_cpuid(struct kvm_vcpu *vcpu)
+{
+	int cpuid;
+	struct loongarch_csrs *csr = vcpu->arch.csr;
+	struct kvm_phyid_map  *map;
+
+	map = vcpu->kvm->arch.phyid_map;
+	cpuid = kvm_read_sw_gcsr(csr, LOONGARCH_CSR_ESTAT);
+	if (cpuid >= KVM_MAX_PHYID)
+		return;
+
+	if (map->phys_map[cpuid].enabled) {
+		map->phys_map[cpuid].vcpu = NULL;
+		map->phys_map[cpuid].enabled = false;
+		kvm_write_sw_gcsr(csr, LOONGARCH_CSR_CPUID, 0);
+	}
+}
+
 static int _kvm_setcsr(struct kvm_vcpu *vcpu, unsigned int id, u64 val)
 {
 	int ret = 0, gintc;
@@ -291,7 +380,8 @@ static int _kvm_setcsr(struct kvm_vcpu *vcpu, unsigned int id, u64 val)
 		kvm_set_sw_gcsr(csr, LOONGARCH_CSR_ESTAT, gintc);
 
 		return ret;
-	}
+	} else if (id == LOONGARCH_CSR_CPUID)
+		return kvm_set_cpuid(vcpu, val);
 
 	kvm_write_sw_gcsr(csr, id, val);
 
@@ -925,6 +1015,7 @@ void kvm_arch_vcpu_destroy(struct kvm_vcpu *vcpu)
 	hrtimer_cancel(&vcpu->arch.swtimer);
 	kvm_mmu_free_memory_cache(&vcpu->arch.mmu_page_cache);
 	kfree(vcpu->arch.csr);
+	kvm_drop_cpuid(vcpu);
 
 	/*
 	 * If the vCPU is freed and reused as another vCPU, we don't want the
diff --git a/arch/loongarch/kvm/vm.c b/arch/loongarch/kvm/vm.c
index 0a37f6fa8f2d..6006a28653ad 100644
--- a/arch/loongarch/kvm/vm.c
+++ b/arch/loongarch/kvm/vm.c
@@ -30,6 +30,14 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 	if (!kvm->arch.pgd)
 		return -ENOMEM;
 
+	kvm->arch.phyid_map = kvzalloc(sizeof(struct kvm_phyid_map),
+				GFP_KERNEL_ACCOUNT);
+	if (!kvm->arch.phyid_map) {
+		free_page((unsigned long)kvm->arch.pgd);
+		kvm->arch.pgd = NULL;
+		return -ENOMEM;
+	}
+
 	kvm_init_vmcs(kvm);
 	kvm->arch.gpa_size = BIT(cpu_vabits - 1);
 	kvm->arch.root_level = CONFIG_PGTABLE_LEVELS - 1;
@@ -44,6 +52,7 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 	for (i = 0; i <= kvm->arch.root_level; i++)
 		kvm->arch.pte_shifts[i] = PAGE_SHIFT + i * (PAGE_SHIFT - 3);
 
+	spin_lock_init(&kvm->arch.phyid_map_lock);
 	return 0;
 }
 
@@ -51,7 +60,9 @@ void kvm_arch_destroy_vm(struct kvm *kvm)
 {
 	kvm_destroy_vcpus(kvm);
 	free_page((unsigned long)kvm->arch.pgd);
+	kvfree(kvm->arch.phyid_map);
 	kvm->arch.pgd = NULL;
+	kvm->arch.phyid_map = NULL;
 }
 
 int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
-- 
2.39.3

