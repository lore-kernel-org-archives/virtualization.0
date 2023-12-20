Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923F541761
	for <virtualization@lists.linux-foundation.org>; Wed, 20 Dec 2023 16:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="UAcGK1IN"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 098BB4206B
	for <virtualization@lists.linux-foundation.org>; Wed, 20 Dec 2023 16:00:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 098BB4206B
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.a=rsa-sha256 header.s=google header.b=UAcGK1IN
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qsGQXB7Ji81C
	for <virtualization@lists.linux-foundation.org>;
	Wed, 20 Dec 2023 16:00:35 +0000 (UTC)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2B5C24206A
	for <virtualization@lists.linux-foundation.org>; Wed, 20 Dec 2023 16:00:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2B5C24206A
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-40c38e292c8so5828765e9.0
        for <virtualization@lists.linux-foundation.org>; Wed, 20 Dec 2023 08:00:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1703088033; x=1703692833; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VzYdl48Qu5esNXPbSwOP+CU6JD+JcYH87so17FZbvqA=;
        b=UAcGK1INdb4E8AQHcLEi+b/A9BGUNbcJpow6rVFE+QMfbW49AcvsVsDbBJSRqXZpN5
         Ax8H7tw52scNhEH4VGERg+zX9FdyD4U7AjDWj0eIvzv9gyM3lWkh8ei/94gHBdv1VIp2
         Tupc8n+lWw4PwFdGHIysKcHYTDA2O77goFAp8yrnfODQSTbpmPKiRaokZKv2hAIWg/MQ
         hjXGToOXWPuykWnxBCk/EFdaf1rn+AkY6GVffgfiEhYy06WUtBEuPCsD7goD0qBlmOa6
         E3Cksev4O8TKZovqUtj0tkyXvrvNpHiKmCkHgjYcAtB65NWROQY00MGQe+c0mN1YxMHr
         1cxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703088033; x=1703692833;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VzYdl48Qu5esNXPbSwOP+CU6JD+JcYH87so17FZbvqA=;
        b=BERkQJ03XhASwsd5B7tWjhnedFdU0jYjIL0CeWqT33MduU/NS56XLikSOT2C8nLQxg
         OpQ96ZasrH2KeMpzMs2YwL/dWBwaCSwk6TlKbemHEauKCCMnNc4ZAdJALpLAhyaXeZ/I
         QH/3UfgEaSWhXLsoeDQ6XJMIGuMcto4Q8q5S8eX0uzGqW4G9qQbWWiIpqkRqAnxd1Z4e
         VdCILTDA4+FAL6/skcQJrrz1tBKJtpmXspHXR3hUPt73+U6NPuMeoWMII5GcS4Ybjoqg
         rpwR+0b8v/+eery55WIOr6m/nj2awE1HJhseD8pg/I7puMRADzC8p6sgKTtbowv3ymjK
         b8CA==
X-Gm-Message-State: AOJu0Yw8DnamWR9cKEmEcmoC2+UuCoLAo1V5eN5YOz9o4DsAaUu1qUVS
	2BnS6pD7pduF8/uGUiH7P8mqwN7vQNNwywgi+4gE2ONkxRQ=
X-Google-Smtp-Source: AGHT+IE2QaQuI9sTDEwmQ5L0J8v/ZOAqNOWfssdYwo0NHGA5EvJQcP/ys+t3hMIZlKA61rdHjaH6Kw==
X-Received: by 2002:a05:600c:3514:b0:40c:28ce:5d4 with SMTP id h20-20020a05600c351400b0040c28ce05d4mr1584057wmq.8.1703088033363;
        Wed, 20 Dec 2023 08:00:33 -0800 (PST)
Received: from localhost (cst-prg-16-115.cust.vodafone.cz. [46.135.16.115])
        by smtp.gmail.com with ESMTPSA id e18-20020adffc52000000b003366b15ddfasm7271251wrs.82.2023.12.20.08.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 08:00:32 -0800 (PST)
From: Andrew Jones <ajones@ventanamicro.com>
To: kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	virtualization@lists.linux-foundation.org
Cc: anup@brainfault.org,
	atishp@atishpatra.org,
	pbonzini@redhat.com,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	jgross@suse.com,
	srivatsa@csail.mit.edu,
	guoren@kernel.org,
	conor.dooley@microchip.com,
	Atish Patra <atishp@rivosinc.com>
Subject: [PATCH v4 06/13] RISC-V: KVM: Add SBI STA info to vcpu_arch
Date: Wed, 20 Dec 2023 17:00:19 +0100
Message-ID: <20231220160012.40184-21-ajones@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231220160012.40184-15-ajones@ventanamicro.com>
References: <20231220160012.40184-15-ajones@ventanamicro.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit

KVM's implementation of SBI STA needs to track the address of each
VCPU's steal-time shared memory region as well as the amount of
stolen time. Add a structure to vcpu_arch to contain this state
and make sure that the address is always set to INVALID_GPA on
vcpu reset. And, of course, ensure KVM won't try to update steal-
time when the shared memory address is invalid.

Reviewed-by: Anup Patel <anup@brainfault.org>
Reviewed-by: Atish Patra <atishp@rivosinc.com>
Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
---
 arch/riscv/include/asm/kvm_host.h |  7 +++++++
 arch/riscv/kvm/vcpu.c             |  2 ++
 arch/riscv/kvm/vcpu_sbi_sta.c     | 10 ++++++++++
 3 files changed, 19 insertions(+)

diff --git a/arch/riscv/include/asm/kvm_host.h b/arch/riscv/include/asm/kvm_host.h
index 230b82c3118d..525cba63e0c5 100644
--- a/arch/riscv/include/asm/kvm_host.h
+++ b/arch/riscv/include/asm/kvm_host.h
@@ -263,6 +263,12 @@ struct kvm_vcpu_arch {
 
 	/* 'static' configurations which are set only once */
 	struct kvm_vcpu_config cfg;
+
+	/* SBI steal-time accounting */
+	struct {
+		gpa_t shmem;
+		u64 last_steal;
+	} sta;
 };
 
 static inline void kvm_arch_sync_events(struct kvm *kvm) {}
@@ -373,6 +379,7 @@ bool kvm_riscv_vcpu_has_interrupts(struct kvm_vcpu *vcpu, u64 mask);
 void kvm_riscv_vcpu_power_off(struct kvm_vcpu *vcpu);
 void kvm_riscv_vcpu_power_on(struct kvm_vcpu *vcpu);
 
+void kvm_riscv_vcpu_sbi_sta_reset(struct kvm_vcpu *vcpu);
 void kvm_riscv_vcpu_record_steal_time(struct kvm_vcpu *vcpu);
 
 #endif /* __RISCV_KVM_HOST_H__ */
diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
index 6995b8b641e4..b5ca9f2e98ac 100644
--- a/arch/riscv/kvm/vcpu.c
+++ b/arch/riscv/kvm/vcpu.c
@@ -83,6 +83,8 @@ static void kvm_riscv_reset_vcpu(struct kvm_vcpu *vcpu)
 	vcpu->arch.hfence_tail = 0;
 	memset(vcpu->arch.hfence_queue, 0, sizeof(vcpu->arch.hfence_queue));
 
+	kvm_riscv_vcpu_sbi_sta_reset(vcpu);
+
 	/* Reset the guest CSRs for hotplug usecase */
 	if (loaded)
 		kvm_arch_vcpu_load(vcpu, smp_processor_id());
diff --git a/arch/riscv/kvm/vcpu_sbi_sta.c b/arch/riscv/kvm/vcpu_sbi_sta.c
index e28351c9488b..6592d287fc4e 100644
--- a/arch/riscv/kvm/vcpu_sbi_sta.c
+++ b/arch/riscv/kvm/vcpu_sbi_sta.c
@@ -8,8 +8,18 @@
 #include <asm/kvm_vcpu_sbi.h>
 #include <asm/sbi.h>
 
+void kvm_riscv_vcpu_sbi_sta_reset(struct kvm_vcpu *vcpu)
+{
+	vcpu->arch.sta.shmem = INVALID_GPA;
+	vcpu->arch.sta.last_steal = 0;
+}
+
 void kvm_riscv_vcpu_record_steal_time(struct kvm_vcpu *vcpu)
 {
+	gpa_t shmem = vcpu->arch.sta.shmem;
+
+	if (shmem == INVALID_GPA)
+		return;
 }
 
 static int kvm_sbi_sta_steal_time_set_shmem(struct kvm_vcpu *vcpu)
-- 
2.43.0

