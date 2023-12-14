Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930273BB38
	for <virtualization@lists.linux-foundation.org>; Thu, 14 Dec 2023 10:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="dmYKPhtx"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4A836436F8
	for <virtualization@lists.linux-foundation.org>; Thu, 14 Dec 2023 10:16:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4A836436F8
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.a=rsa-sha256 header.s=google header.b=dmYKPhtx
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SO3IB-DSKb3X
	for <virtualization@lists.linux-foundation.org>;
	Thu, 14 Dec 2023 10:16:04 +0000 (UTC)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 27018436E8
	for <virtualization@lists.linux-foundation.org>; Thu, 14 Dec 2023 10:16:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 27018436E8
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-40c3ceded81so50999785e9.1
        for <virtualization@lists.linux-foundation.org>; Thu, 14 Dec 2023 02:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1702548962; x=1703153762; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hx79abP2JnQDv60fnp0e25hp/gEQsdJWCSNhtAMvtKE=;
        b=dmYKPhtx+ttZtAUY6PNAJY60XKcmnGT2i1ldy1Q4CEp4iUNBiEwJNhOKO35JeSS84j
         K2jnmyhNEq7a7mwoCe1tWUrqe7kdCeggC73OJPB4GaKIIsVA89AuT/kX8KZpr6sXArsb
         IYL0C9wOP8fMpnJsCYWAY2f9OUdmL0m6vHcSDwPqIu5ZP6zuYlGEoGj0OQoQUJHay1C+
         iXZfNfKfEuj87ZgeywD0lchE2rbBi4YpPLwgV6mB9wwTNzVg//+W4zsHkt/Z/ISj7OjH
         wjObMvvHBYfJOzvKOCipvMtGg4EFaznlDNp9LAUl6GFPBfAihRwZE6C2SekznoKu6Csw
         Xrug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702548962; x=1703153762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hx79abP2JnQDv60fnp0e25hp/gEQsdJWCSNhtAMvtKE=;
        b=ddM4JxKLhRgIPwEod8Jo1TloOP4NNZxhSMvDSRubR/IBi1WoQn6fmIWe2Xk++WvOLI
         cW1/uWe45clHDnP/C54qci74SguFCIHGtz2IW2e53DOsPEuxXyLQTuTE8AVelpfoUAg5
         06/s65OvHGNw74nLPB9h4Q+TUouRM5k3Nyt3ISoN95MFiGuabpONhM8DMwO6zIRwgOW+
         u2K1CAvMAirHi7sdIJnFW3npjowwCOsioMybFD9uzrjze+f4YGdP0ozg5oxaDWr/2JSB
         QPXUk58jOJoKg2ghvOdAFXRGNzz4lprRf0OJ+bovO8EVKqX15Dyp6JOEXSeL2iusMDLz
         INqw==
X-Gm-Message-State: AOJu0YwKcz8NUIAJ1dKgDanCYj98cY1HKc9HLhTIJFByaHZDmJMcRhn4
	ckjahUJDeW+SMpy15+AhQsZygw==
X-Google-Smtp-Source: AGHT+IFF4leJuBes4jdP4P+sdaOzCkkm+rXp4maTBymg0v5E5HnoiVKGX/tmKr5qr6ESyYY5Yk0quQ==
X-Received: by 2002:a1c:7906:0:b0:40b:5e21:ec30 with SMTP id l6-20020a1c7906000000b0040b5e21ec30mr5270280wme.98.1702548962368;
        Thu, 14 Dec 2023 02:16:02 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id j8-20020a05600c190800b0040c58e410a3sm6758401wmq.14.2023.12.14.02.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 02:16:01 -0800 (PST)
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
Subject: [PATCH v2 06/13] RISC-V: KVM: Add SBI STA info to vcpu_arch
Date: Thu, 14 Dec 2023 11:15:58 +0100
Message-ID: <20231214101552.100721-21-ajones@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231214101552.100721-15-ajones@ventanamicro.com>
References: <20231214101552.100721-15-ajones@ventanamicro.com>
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

Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
---
 arch/riscv/include/asm/kvm_host.h | 6 ++++++
 arch/riscv/kvm/vcpu.c             | 2 ++
 arch/riscv/kvm/vcpu_sbi_sta.c     | 4 ++++
 3 files changed, 12 insertions(+)

diff --git a/arch/riscv/include/asm/kvm_host.h b/arch/riscv/include/asm/kvm_host.h
index 230b82c3118d..b10026fb6412 100644
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
diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
index 6995b8b641e4..fec4f5fd0fa7 100644
--- a/arch/riscv/kvm/vcpu.c
+++ b/arch/riscv/kvm/vcpu.c
@@ -83,6 +83,8 @@ static void kvm_riscv_reset_vcpu(struct kvm_vcpu *vcpu)
 	vcpu->arch.hfence_tail = 0;
 	memset(vcpu->arch.hfence_queue, 0, sizeof(vcpu->arch.hfence_queue));
 
+	vcpu->arch.sta.shmem = INVALID_GPA;
+
 	/* Reset the guest CSRs for hotplug usecase */
 	if (loaded)
 		kvm_arch_vcpu_load(vcpu, smp_processor_id());
diff --git a/arch/riscv/kvm/vcpu_sbi_sta.c b/arch/riscv/kvm/vcpu_sbi_sta.c
index e28351c9488b..157c199be0b4 100644
--- a/arch/riscv/kvm/vcpu_sbi_sta.c
+++ b/arch/riscv/kvm/vcpu_sbi_sta.c
@@ -10,6 +10,10 @@
 
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

