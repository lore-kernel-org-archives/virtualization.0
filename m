Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE868149009;
	Mon,  5 Aug 2024 07:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722843351; cv=none; b=MSSW2Gt6Jfacs59f70awC8EUetod7uZRrH14Ecd9rOXmG7tGvSIoEp2lmpvaglYXNT5W/Cp1TUEhMpxb46B1fFVUUIMNQe8pCs9R1kg3lq9/g77N4J4fKba9E+sB74bvozEl2rRdEvP338ZXuINfrWo1q07W/x3W5HwfKO+DZS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722843351; c=relaxed/simple;
	bh=sntPLk9JUczN3t1GG9IWiP1HHqBUQTpUXd2iKWnCP/Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=siayVTlqxx3c6LHqjLLIOgalGr0VhQcmQzsuxdh+419WkXLXgVEX543sEa0XfZyumQsnqgIkjNsWuWZIx0Ce4jmQKtBkXwC6/OpECnfh67eHAiDsib1h8S/hqRJh0XmGpUUg2ldbgFPUqiLNhM73mZ8hMwG2IhylQ4An0PFSHXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8AxHuvTgLBmJ+UHAA--.27258S3;
	Mon, 05 Aug 2024 15:35:47 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowMAxz2fSgLBmaCgEAA--.11106S4;
	Mon, 05 Aug 2024 15:35:47 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Tianrui Zhao <zhaotianrui@loongson.cn>,
	Huacai Chen <chenhuacai@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: WANG Xuerui <kernel@xen0n.name>,
	kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev,
	x86@kernel.org,
	Song Gao <gaosong@loongson.cn>
Subject: [PATCH v5 2/3] LoongArch: KVM: Implement function kvm_para_has_feature
Date: Mon,  5 Aug 2024 15:35:45 +0800
Message-Id: <20240805073546.668475-3-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240805073546.668475-1-maobibo@loongson.cn>
References: <20240805073546.668475-1-maobibo@loongson.cn>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMAxz2fSgLBmaCgEAA--.11106S4
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

Function kvm_para_has_feature() is to detect supported paravirt features,
it can be used by device driver to detect and enable paravirt features,
such as extioi irqchip driver can detect KVM_FEATURE_VIRT_EXTIOI and do
some optimization.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 arch/loongarch/include/asm/kvm_para.h | 10 ++++++++++
 arch/loongarch/kernel/paravirt.c      | 28 +++++++++++++++------------
 2 files changed, 26 insertions(+), 12 deletions(-)

diff --git a/arch/loongarch/include/asm/kvm_para.h b/arch/loongarch/include/asm/kvm_para.h
index 9814d56b8d0e..327f331d5237 100644
--- a/arch/loongarch/include/asm/kvm_para.h
+++ b/arch/loongarch/include/asm/kvm_para.h
@@ -155,10 +155,20 @@ static __always_inline long kvm_hypercall5(u64 fid,
 	return ret;
 }
 
+#ifdef CONFIG_PARAVIRT
+bool kvm_para_available(void);
+unsigned int kvm_arch_para_features(void);
+#else
+static inline bool kvm_para_available(void)
+{
+	return false;
+}
+
 static inline unsigned int kvm_arch_para_features(void)
 {
 	return 0;
 }
+#endif
 
 static inline unsigned int kvm_arch_para_hints(void)
 {
diff --git a/arch/loongarch/kernel/paravirt.c b/arch/loongarch/kernel/paravirt.c
index cc6bf096cb88..10683e25b6b3 100644
--- a/arch/loongarch/kernel/paravirt.c
+++ b/arch/loongarch/kernel/paravirt.c
@@ -151,11 +151,14 @@ static void pv_init_ipi(void)
 }
 #endif
 
-static bool kvm_para_available(void)
+bool kvm_para_available(void)
 {
 	int config;
 	static int hypervisor_type;
 
+	if (!cpu_has_hypervisor)
+		return false;
+
 	if (!hypervisor_type) {
 		config = read_cpucfg(CPUCFG_KVM_SIG);
 		if (!memcmp(&config, KVM_SIGNATURE, 4))
@@ -165,17 +168,21 @@ static bool kvm_para_available(void)
 	return hypervisor_type == HYPERVISOR_KVM;
 }
 
-int __init pv_ipi_init(void)
+unsigned int kvm_arch_para_features(void)
 {
-	int feature;
+	static int feature;
 
-	if (!cpu_has_hypervisor)
-		return 0;
+	if (!feature)
+		feature = read_cpucfg(CPUCFG_KVM_FEATURE);
+	return feature;
+}
+
+int __init pv_ipi_init(void)
+{
 	if (!kvm_para_available())
 		return 0;
 
-	feature = read_cpucfg(CPUCFG_KVM_FEATURE);
-	if (!(feature & BIT(KVM_FEATURE_IPI)))
+	if (!kvm_para_has_feature(KVM_FEATURE_IPI))
 		return 0;
 
 #ifdef CONFIG_SMP
@@ -258,15 +265,12 @@ static struct notifier_block pv_reboot_nb = {
 
 int __init pv_time_init(void)
 {
-	int r, feature;
+	int r;
 
-	if (!cpu_has_hypervisor)
-		return 0;
 	if (!kvm_para_available())
 		return 0;
 
-	feature = read_cpucfg(CPUCFG_KVM_FEATURE);
-	if (!(feature & BIT(KVM_FEATURE_STEAL_TIME)))
+	if (!kvm_para_has_feature(KVM_FEATURE_STEAL_TIME))
 		return 0;
 
 	has_steal_clock = 1;
-- 
2.39.3

