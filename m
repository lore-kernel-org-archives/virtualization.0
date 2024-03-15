Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D02F014A81;
	Fri, 15 Mar 2024 08:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710490044; cv=none; b=etc6bOQvRMQvAWbUTY2bU5z6wVoKJykZeMVss/1zJIy6cMvIJcoHLHjO/Y3575raaX3gd78qxzSjHflS9O+4yiawmG3/8DZEKtC5zgUSWVH3C94nUj/OTW+ekTNyOUb0CfC/HFDsYs5HDT80SXWZLS8heraLctdD7mRNzJksdxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710490044; c=relaxed/simple;
	bh=jL1Y5Rf0DpIO2PgtH24jYFKN2AV9dJqQDRYDr/6rsUw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jAdKmOV5auUusRcXJW1slSfsS+N9KtTiweD5fVsjKBsRIBOj9EpcKigSuepkSiK/GcktWmmWub9iOj2tmw8ah+Eq+iqgVKIljhqrcvH/WSlrFJ2TX8N4w45P/s0PE/L56fYbpiR3j/Xa2VdYprY+gVEHKpK1kvhZ8yKN1VH642Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8CxXOmzAfRlN2UZAA--.51490S3;
	Fri, 15 Mar 2024 16:07:15 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8Cx_c6uAfRl4MZaAA--.41676S5;
	Fri, 15 Mar 2024 16:07:14 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Tianrui Zhao <zhaotianrui@loongson.cn>,
	WANG Xuerui <kernel@xen0n.name>,
	Juergen Gross <jgross@suse.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>
Cc: loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org
Subject: [PATCH v7 3/7] LoongArch: KVM: Add cpucfg area for kvm hypervisor
Date: Fri, 15 Mar 2024 16:07:06 +0800
Message-Id: <20240315080710.2812974-4-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240315080710.2812974-1-maobibo@loongson.cn>
References: <20240315080710.2812974-1-maobibo@loongson.cn>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8Cx_c6uAfRl4MZaAA--.41676S5
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxGr13ZF15ZryftrW5WF48uFX_yoWrWF17pF
	Z3urykWr48GryfA39rtrZ8Ww15uF4kGr12qFW3J3yUCF4UXryrAr4vkrWDAFyDKws5C3WI
	qF15tr1aqF4DAabCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUkIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1q6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI
	0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280
	aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28Icx
	kI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2Iq
	xVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42
	IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY
	6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aV
	CY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IUbCzuJUUUUU==

Instruction cpucfg can be used to get processor features. And there
is trap exception when it is executed in VM mode, and also it is
to provide cpu features to VM. On real hardware cpucfg area 0 - 20
is used.  Here one specified area 0x40000000 -- 0x400000ff is used
for KVM hypervisor to privide PV features, and the area can be extended
for other hypervisors in future. This area will never be used for
real HW, it is only used by software.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 arch/loongarch/include/asm/inst.h      |  1 +
 arch/loongarch/include/asm/loongarch.h | 10 +++++
 arch/loongarch/kvm/exit.c              | 59 +++++++++++++++++++-------
 3 files changed, 54 insertions(+), 16 deletions(-)

diff --git a/arch/loongarch/include/asm/inst.h b/arch/loongarch/include/asm/inst.h
index d8f637f9e400..ad120f924905 100644
--- a/arch/loongarch/include/asm/inst.h
+++ b/arch/loongarch/include/asm/inst.h
@@ -67,6 +67,7 @@ enum reg2_op {
 	revhd_op	= 0x11,
 	extwh_op	= 0x16,
 	extwb_op	= 0x17,
+	cpucfg_op	= 0x1b,
 	iocsrrdb_op     = 0x19200,
 	iocsrrdh_op     = 0x19201,
 	iocsrrdw_op     = 0x19202,
diff --git a/arch/loongarch/include/asm/loongarch.h b/arch/loongarch/include/asm/loongarch.h
index 46366e783c84..a1d22e8b6f94 100644
--- a/arch/loongarch/include/asm/loongarch.h
+++ b/arch/loongarch/include/asm/loongarch.h
@@ -158,6 +158,16 @@
 #define  CPUCFG48_VFPU_CG		BIT(2)
 #define  CPUCFG48_RAM_CG		BIT(3)
 
+/*
+ * cpucfg index area: 0x40000000 -- 0x400000ff
+ * SW emulation for KVM hypervirsor
+ */
+#define CPUCFG_KVM_BASE			0x40000000UL
+#define CPUCFG_KVM_SIZE			0x100
+#define CPUCFG_KVM_SIG			CPUCFG_KVM_BASE
+#define  KVM_SIGNATURE			"KVM\0"
+#define CPUCFG_KVM_FEATURE		(CPUCFG_KVM_BASE + 4)
+
 #ifndef __ASSEMBLY__
 
 /* CSR */
diff --git a/arch/loongarch/kvm/exit.c b/arch/loongarch/kvm/exit.c
index 923bbca9bd22..a8d3b652d3ea 100644
--- a/arch/loongarch/kvm/exit.c
+++ b/arch/loongarch/kvm/exit.c
@@ -206,10 +206,50 @@ int kvm_emu_idle(struct kvm_vcpu *vcpu)
 	return EMULATE_DONE;
 }
 
-static int kvm_trap_handle_gspr(struct kvm_vcpu *vcpu)
+static int kvm_emu_cpucfg(struct kvm_vcpu *vcpu, larch_inst inst)
 {
 	int rd, rj;
 	unsigned int index;
+	unsigned long plv;
+
+	rd = inst.reg2_format.rd;
+	rj = inst.reg2_format.rj;
+	++vcpu->stat.cpucfg_exits;
+	index = vcpu->arch.gprs[rj];
+
+	/*
+	 * By LoongArch Reference Manual 2.2.10.5
+	 * Return value is 0 for undefined cpucfg index
+	 *
+	 * Disable preemption since hw gcsr is accessed
+	 */
+	preempt_disable();
+	plv = kvm_read_hw_gcsr(LOONGARCH_CSR_CRMD) >> CSR_CRMD_PLV_SHIFT;
+	switch (index) {
+	case 0 ... (KVM_MAX_CPUCFG_REGS - 1):
+		vcpu->arch.gprs[rd] = vcpu->arch.cpucfg[index];
+		break;
+	case CPUCFG_KVM_SIG:
+		/*
+		 * Cpucfg emulation between 0x40000000 -- 0x400000ff
+		 * Return value with 0 if executed in user mode
+		 */
+		if ((plv & CSR_CRMD_PLV) == PLV_KERN)
+			vcpu->arch.gprs[rd] = *(unsigned int *)KVM_SIGNATURE;
+		else
+			vcpu->arch.gprs[rd] = 0;
+		break;
+	default:
+		vcpu->arch.gprs[rd] = 0;
+		break;
+	}
+
+	preempt_enable();
+	return EMULATE_DONE;
+}
+
+static int kvm_trap_handle_gspr(struct kvm_vcpu *vcpu)
+{
 	unsigned long curr_pc;
 	larch_inst inst;
 	enum emulation_result er = EMULATE_DONE;
@@ -224,21 +264,8 @@ static int kvm_trap_handle_gspr(struct kvm_vcpu *vcpu)
 	er = EMULATE_FAIL;
 	switch (((inst.word >> 24) & 0xff)) {
 	case 0x0: /* CPUCFG GSPR */
-		if (inst.reg2_format.opcode == 0x1B) {
-			rd = inst.reg2_format.rd;
-			rj = inst.reg2_format.rj;
-			++vcpu->stat.cpucfg_exits;
-			index = vcpu->arch.gprs[rj];
-			er = EMULATE_DONE;
-			/*
-			 * By LoongArch Reference Manual 2.2.10.5
-			 * return value is 0 for undefined cpucfg index
-			 */
-			if (index < KVM_MAX_CPUCFG_REGS)
-				vcpu->arch.gprs[rd] = vcpu->arch.cpucfg[index];
-			else
-				vcpu->arch.gprs[rd] = 0;
-		}
+		if (inst.reg2_format.opcode == cpucfg_op)
+			er = kvm_emu_cpucfg(vcpu, inst);
 		break;
 	case 0x4: /* CSR{RD,WR,XCHG} GSPR */
 		er = kvm_handle_csr(vcpu, inst);
-- 
2.39.3

