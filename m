Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED51E306B10;
	Tue, 18 Nov 2025 08:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763453239; cv=none; b=ea8B+r810GpWX4N0zUIfPTsTVWS+v2dtJkVyjlo+aaoZPydQG8SPmKCM7/A9qc7mMNNxxieRlXN47HqmhIAW4AcZAAxCxAmHNm2uVOXmUCP0NeR5VYqoKWXqe33kHr5IIkgNnHnxfISKWseKhTiihL1wZKzWy/J+7tOANbdeCak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763453239; c=relaxed/simple;
	bh=FHBYnYx9E71kz6F0WzQVGiFMwXRhZuGue7tKqX4UKcc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rHwuA05flxoLRIbQGCBg0IWc6Fh72PYiraZ0kwA95w2I0sGGxlcjC2KSh0yEw5wBJc3XDEHFQaG8w5wJ9zjAqaeWXRYM0M864YalJ/dWZxwxABDFnQ1CkBbnj30prkG7/3IMykTBVK0dH4xqTKk9j2FiM0AJEe3Djzt85Tx44kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8Axz9MyKRxpB9kkAA--.8859S3;
	Tue, 18 Nov 2025 16:07:14 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowJBxC8EsKRxpbBc3AQ--.49231S2;
	Tue, 18 Nov 2025 16:07:13 +0800 (CST)
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
Subject: [PATCH 3/3] LoongArch: Add paravirt preempt hint print prompt
Date: Tue, 18 Nov 2025 16:06:56 +0800
Message-Id: <20251118080656.2012805-4-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20251118080656.2012805-1-maobibo@loongson.cn>
References: <20251118080656.2012805-1-maobibo@loongson.cn>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBxC8EsKRxpbBc3AQ--.49231S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

Add paravirt preempt hint print prompt together with steal timer
information, so that it is easy to check whether paravirt preempt hint
feature is enabled or not.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 arch/loongarch/kernel/paravirt.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/loongarch/kernel/paravirt.c b/arch/loongarch/kernel/paravirt.c
index b99404b6b13f..b7ea511c288b 100644
--- a/arch/loongarch/kernel/paravirt.c
+++ b/arch/loongarch/kernel/paravirt.c
@@ -294,6 +294,7 @@ static struct notifier_block pv_reboot_nb = {
 int __init pv_time_init(void)
 {
 	int r;
+	bool pv_preempted = false;
 
 	if (!kvm_para_has_feature(KVM_FEATURE_STEAL_TIME))
 		return 0;
@@ -316,8 +317,10 @@ int __init pv_time_init(void)
 		return r;
 	}
 
-	if (kvm_para_has_feature(KVM_FEATURE_PREEMPT_HINT))
+	if (kvm_para_has_feature(KVM_FEATURE_PREEMPT_HINT)) {
 		mp_ops.vcpu_is_preempted = pv_vcpu_is_preempted;
+		pv_preempted = true;
+	}
 #endif
 
 	static_call_update(pv_steal_clock, paravt_steal_clock);
@@ -328,7 +331,10 @@ int __init pv_time_init(void)
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

