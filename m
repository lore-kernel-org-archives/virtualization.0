Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E7B229B224;
	Mon, 24 Nov 2025 03:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763956459; cv=none; b=jjfhNgk2Msan1zi214OFSnMMEFCWVrtrm4URvKEuZud0W4qSUdiTou6W2z8Xe8VfT8nq4aNyHZs5NQmU2IMsdesvuPHCRbgtPcxdFaVScJ5uBieuvOJ0sutcgMscum7/j+3JJshqxdKRTvyVzuI/L2YLb7kmFfO7V4rUlvbOTLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763956459; c=relaxed/simple;
	bh=Oh2KpcL2VRnaS1u4wDKzh+lWmGunM/hDSlSE3DlxIcA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Epi49nbAl7UeOGCFdkRXxPN3J0Gw1QOTQ66PPPuvWBsQECCdAHdkP2c4iJXiK/LV68vzSjkhPDS6S0k7ykjGcjjCDPwBLrYaFoZ9zDdaUudwx92fiZ2cEH4ThYshJnyNnr3reZFUbar6o7ZeF9j3lXYgYmTmBSPnRLiwNPpg++o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8AxztLj1iNpz1onAA--.18263S3;
	Mon, 24 Nov 2025 11:54:11 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowJAxusDa1iNp4WE9AQ--.13468S5;
	Mon, 24 Nov 2025 11:54:10 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Juergen Gross <jgross@suse.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	WANG Xuerui <kernel@xen0n.name>
Cc: kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev,
	x86@kernel.org
Subject: [PATCH v2 3/3] LoongArch: Add paravirt preempt print prompt
Date: Mon, 24 Nov 2025 11:54:01 +0800
Message-Id: <20251124035402.3817179-4-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20251124035402.3817179-1-maobibo@loongson.cn>
References: <20251124035402.3817179-1-maobibo@loongson.cn>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAxusDa1iNp4WE9AQ--.13468S5
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

Add paravirt preempt print prompt together with steal timer information,
so that it is easy to check whether paravirt preempt feature is enabled
or not.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 arch/loongarch/kernel/paravirt.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/loongarch/kernel/paravirt.c b/arch/loongarch/kernel/paravirt.c
index d4163679adc4..ffe1cf284c41 100644
--- a/arch/loongarch/kernel/paravirt.c
+++ b/arch/loongarch/kernel/paravirt.c
@@ -300,6 +300,7 @@ static struct notifier_block pv_reboot_nb = {
 int __init pv_time_init(void)
 {
 	int r;
+	bool pv_preempted = false;
 
 	if (!kvm_para_has_feature(KVM_FEATURE_STEAL_TIME))
 		return 0;
@@ -322,8 +323,10 @@ int __init pv_time_init(void)
 		return r;
 	}
 
-	if (kvm_para_has_feature(KVM_FEATURE_PREEMPT))
+	if (kvm_para_has_feature(KVM_FEATURE_PREEMPT)) {
 		static_branch_enable(&virt_preempt_key);
+		pv_preempted = true;
+	}
 #endif
 
 	static_call_update(pv_steal_clock, paravt_steal_clock);
@@ -334,7 +337,10 @@ int __init pv_time_init(void)
 		static_key_slow_inc(&paravirt_steal_rq_enabled);
 #endif
 
-	pr_info("Using paravirt steal-time\n");
+	if (pv_preempted)
+		pr_info("Using paravirt steal-time with preempt hint enabled\n");
+	else
+		pr_info("Using paravirt steal-time with preempt hint disabled\n");
 
 	return 0;
 }
-- 
2.39.3

