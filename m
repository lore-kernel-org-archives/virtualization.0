Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDFAB19AA7F;
	Tue, 16 Jul 2024 12:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721134725; cv=none; b=IqfvYtnWxMaamrVT4alYUld1ZxQh0xCmE5RxJcFUFgSfsYNrLx4sjqpGzosELaUaKqzvswnwNvKosrp8buKqcP4M2ecJKPGiX5DNFaYtiH4V4tAdqWOyiQbzPL6G4tGWpf4HBnsN7RLqQQhpY7IyI/0E9wKXAl7xxDFGkHBwBgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721134725; c=relaxed/simple;
	bh=M2McNn1TDJEXoE8lkDdMuk6Xw2H50/F77YmP1osHO2A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aoiGA6HFHxgm82r7v8V3UfFCp+omXrNLY6C71MVfPKNftdDEKE4dtYjFfrAn6sqQ8f6CcYzCd1p7n4/CPoM8f/meE5KvC1nQS4h/SpPcNi1Y71vw3F0pbrOKrD7OClLMJEwNDyW94idI8pLx9sa/xrmuROduFu5rCkeLfOKnJIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8AxRup4bpZmvA8FAA--.3945S3;
	Tue, 16 Jul 2024 20:58:32 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8DxPMd4bpZmezpLAA--.39798S2;
	Tue, 16 Jul 2024 20:58:32 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Tianrui Zhao <zhaotianrui@loongson.cn>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>,
	kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: [PATCH] LoongArch: KVM: Implement function kvm_arch_para_features
Date: Tue, 16 Jul 2024 20:58:31 +0800
Message-Id: <20240716125831.1621975-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8DxPMd4bpZmezpLAA--.39798S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

Function kvm_arch_para_features() is to detect supported para features,
it can be used by device driver to detect and enable para features,
such as extioi irqchip driver to detect KVM_FEATURE_VIRT_EXTIOI.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 arch/loongarch/include/asm/kvm_para.h | 10 ++++++++++
 arch/loongarch/kernel/paravirt.c      | 14 ++++++++++----
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/arch/loongarch/include/asm/kvm_para.h b/arch/loongarch/include/asm/kvm_para.h
index 4ba2312e5f8c..955f4ee85d55 100644
--- a/arch/loongarch/include/asm/kvm_para.h
+++ b/arch/loongarch/include/asm/kvm_para.h
@@ -143,10 +143,20 @@ static __always_inline long kvm_hypercall5(u64 fid,
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
index 1633ed4f692f..c3240e85baa7 100644
--- a/arch/loongarch/kernel/paravirt.c
+++ b/arch/loongarch/kernel/paravirt.c
@@ -114,11 +114,14 @@ static void pv_init_ipi(void)
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
@@ -128,16 +131,19 @@ static bool kvm_para_available(void)
 	return hypervisor_type == HYPERVISOR_KVM;
 }
 
+unsigned int kvm_arch_para_features(void)
+{
+	return read_cpucfg(CPUCFG_KVM_FEATURE);
+}
+
 int __init pv_ipi_init(void)
 {
 	int feature;
 
-	if (!cpu_has_hypervisor)
-		return 0;
 	if (!kvm_para_available())
 		return 0;
 
-	feature = read_cpucfg(CPUCFG_KVM_FEATURE);
+	feature = kvm_arch_para_features();
 	if (!(feature & KVM_FEATURE_IPI))
 		return 0;
 

base-commit: 1467b49869df43c4ee51bdaa0ec1cb69e333407d
-- 
2.39.3

