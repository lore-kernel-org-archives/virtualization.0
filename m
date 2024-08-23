Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F8980631;
	Fri, 23 Aug 2024 06:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724395199; cv=none; b=hQWsmTeZj99IKS/oYGSc9W8UU2r/TPGJKqpgdkACfwFX6TuTjRkHc2SLGG3DVZcBq0iJXS1P/1pcB13oQ89JKhSdbc5xcAczvJzO3sU8Ytd32Cg9HNuwLr12muTLfTcnDsyLuUlkOItP/e0Hzz95Y2ZI+Pb7a7gVaZvoWYguIg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724395199; c=relaxed/simple;
	bh=MKI/sWHIyLgpfqJt/N3sHA/FKOoAGPohHnYGV6nLDQ0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D1/uTHCMzJzuMA4hcK/TrLihwh5hH3pIFUdZS55nIde47mfxtdnVOTktkqYjnP5EleBvYouyTUKKwGjljByBU7L+24z2p4/pbjcp82UxfrR98/AC4shUdK5BliUzgmhPpnQvOQU39Nx2+1kV5ErGuVAQc68Rvkt1fU4UF3evnWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8Bxnpu0Lshm0h8dAA--.35999S3;
	Fri, 23 Aug 2024 14:39:48 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowMDxnWevLshmUPoeAA--.41360S4;
	Fri, 23 Aug 2024 14:39:47 +0800 (CST)
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
Subject: [PATCH v7 2/3] LoongArch: KVM: Implement function kvm_para_has_feature
Date: Fri, 23 Aug 2024 14:39:42 +0800
Message-Id: <20240823063943.2618675-3-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240823063943.2618675-1-maobibo@loongson.cn>
References: <20240823063943.2618675-1-maobibo@loongson.cn>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMDxnWevLshmUPoeAA--.41360S4
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
 arch/loongarch/include/asm/kvm_para.h | 10 +++++++++
 arch/loongarch/kernel/paravirt.c      | 31 ++++++++++++++-------------
 2 files changed, 26 insertions(+), 15 deletions(-)

diff --git a/arch/loongarch/include/asm/kvm_para.h b/arch/loongarch/include/asm/kvm_para.h
index 39d7483ab8fd..2174fb53c2e7 100644
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
index cc6bf096cb88..dc3cebcb550a 100644
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
 	if (!kvm_para_available())
 		return 0;
 
-	feature = read_cpucfg(CPUCFG_KVM_FEATURE);
-	if (!(feature & BIT(KVM_FEATURE_IPI)))
+	if (!feature)
+		feature = read_cpucfg(CPUCFG_KVM_FEATURE);
+	return feature;
+}
+
+int __init pv_ipi_init(void)
+{
+	if (!kvm_para_has_feature(KVM_FEATURE_IPI))
 		return 0;
 
 #ifdef CONFIG_SMP
@@ -258,15 +265,9 @@ static struct notifier_block pv_reboot_nb = {
 
 int __init pv_time_init(void)
 {
-	int r, feature;
-
-	if (!cpu_has_hypervisor)
-		return 0;
-	if (!kvm_para_available())
-		return 0;
+	int r;
 
-	feature = read_cpucfg(CPUCFG_KVM_FEATURE);
-	if (!(feature & BIT(KVM_FEATURE_STEAL_TIME)))
+	if (!kvm_para_has_feature(KVM_FEATURE_STEAL_TIME))
 		return 0;
 
 	has_steal_clock = 1;
-- 
2.39.3

