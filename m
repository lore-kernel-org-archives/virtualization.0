Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DDF4207D
	for <virtualization@lists.linux-foundation.org>; Sun, 17 Dec 2023 20:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="daNwl4uK"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4E07960A77
	for <virtualization@lists.linux-foundation.org>; Sun, 17 Dec 2023 20:40:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4E07960A77
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.a=rsa-sha256 header.s=google header.b=daNwl4uK
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id J-PpRoC0y0dB
	for <virtualization@lists.linux-foundation.org>;
	Sun, 17 Dec 2023 20:40:42 +0000 (UTC)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 726ED60881
	for <virtualization@lists.linux-foundation.org>; Sun, 17 Dec 2023 20:40:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 726ED60881
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-548ce39b101so2813480a12.2
        for <virtualization@lists.linux-foundation.org>; Sun, 17 Dec 2023 12:40:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1702845640; x=1703450440; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e/JsdsBfwTQ+WtoE+ZqPAArqtl47MKSL1wHIgI3qALc=;
        b=daNwl4uK80HsOfXVUNwg3/tqGomELj/5Mxp2jDbukdW6oSO4a3ztrKA+mlI6XSseep
         LfpM9h04oUPu3Czm3j1EK0beYFI+aEtsBzVSAr7inF5dyfYXDI0iUbIDTC1gO3oBg0dK
         9OPWV12gUFzKuBvSon2Jtvbl+i5qC537mnD7vo6zucFkhxYyI0+EYub7UQPqH8NR6vAG
         aihXi6kRXgb1d+DvLIregNmxR0EhrVS1EyUmFoPOd76jnRcdbhF3P0KeTGhO8y3Cjo2K
         4BHJdPmD2hraTP9BPsQcGaP+8w5ZkaG0ANkHMIpKE0bHyIUGd6QtI/GsV9j0NCLl6H/u
         gUXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702845640; x=1703450440;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e/JsdsBfwTQ+WtoE+ZqPAArqtl47MKSL1wHIgI3qALc=;
        b=ca81mTtZ3IzOPGpFjobxIBxB71ohh3uj2hD/9MlRMyGfLQShV91jqVar+pYPU70eu8
         UbLprbC41q4XiGv8aSwmAKvHgRbFuB0ltOgwE1hrUeIiBl3pUfF52Yt0gv58e1jrcKia
         RoWy3z6XZDZqRkZQUntQYWaw8PWRJP4v6U4m6Mf86xJrNzoqJjTRV4FjjJROnnf9JDR6
         +nQDYkQjbxno7Zw6tEaGTAIeDPPrZUgr2uHnwSK5YPmy93K+mitDA0aqa6DthpLUcYFW
         Drmyn5FPXtEmYCMGe7W+/NoODkacwioZnpaeIRjCkAS9t1MzEgU4xzyCbKu3dyUAYmrN
         hL+w==
X-Gm-Message-State: AOJu0YxTy/YHIaJMAYpyCqIEJexM+CZE5vtUF21zz4Z5rMmtAHfAy7Nd
	13q1UAYSTpbXhENO3UQmKP1PDA==
X-Google-Smtp-Source: AGHT+IFR1J9OT5X4e0axZZpDP0qQuLSOAw+65TiLvqTzqYi3kfqjSPifUFVpqKX1wfG6EKURYOYfHQ==
X-Received: by 2002:a50:d0cd:0:b0:553:432f:d46f with SMTP id g13-20020a50d0cd000000b00553432fd46fmr388919edf.95.1702845640693;
        Sun, 17 Dec 2023 12:40:40 -0800 (PST)
Received: from localhost (cst-prg-88-42.cust.vodafone.cz. [46.135.88.42])
        by smtp.gmail.com with ESMTPSA id en18-20020a056402529200b00552666f4745sm3884263edb.22.2023.12.17.12.40.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Dec 2023 12:40:40 -0800 (PST)
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
	conor.dooley@microchip.com
Subject: [PATCH v3 06/13] RISC-V: KVM: Add SBI STA info to vcpu_arch
Date: Sun, 17 Dec 2023 21:40:26 +0100
Message-ID: <20231217204019.36492-21-ajones@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231217204019.36492-15-ajones@ventanamicro.com>
References: <20231217204019.36492-15-ajones@ventanamicro.com>
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

