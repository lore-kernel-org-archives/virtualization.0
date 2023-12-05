Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9736460BB6
	for <virtualization@lists.linux-foundation.org>; Tue,  5 Dec 2023 18:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="c2fqvNwa"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4CD8D43591
	for <virtualization@lists.linux-foundation.org>; Tue,  5 Dec 2023 18:11:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4CD8D43591
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.a=rsa-sha256 header.s=google header.b=c2fqvNwa
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HTDMM570t-LL
	for <virtualization@lists.linux-foundation.org>;
	Tue,  5 Dec 2023 18:11:33 +0000 (UTC)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1E723400D0
	for <virtualization@lists.linux-foundation.org>; Tue,  5 Dec 2023 18:11:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1E723400D0
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2c9e9c2989dso51282361fa.0
        for <virtualization@lists.linux-foundation.org>; Tue, 05 Dec 2023 10:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1701799891; x=1702404691; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+VCd6O823a8CT11v1c1Pjh6+abowcBe1J6OGxvMERwU=;
        b=c2fqvNwakweFwBSshaZtt4U7pjz8tqjL+pa4mxZhPxIfOiRmysS1Zc7JRjmUBwA5tc
         HKgCRiNn2A+Yvzs51B9T0BVXgGZH8JULkGbHWR8DcG3FHIVfPj2Mezc75DNVe14pIOG6
         MtLR321jEh0lxad5ljn3B/3zgfUAlWWX9YPm6YkWBCB+gD1g8pAUgmLz9erxLIJW0s10
         OBRaWBhnXN3TX6qRzfnMwkE3gSFyIowSb0xr1olbQWxV5IV0/s7/vXHLjQLMTLGCSuqd
         Bz/Fjt0tdI3nDRi5Ovb4Ahg5+dDW6yPMtFEQ/27sl2q1241+kHelAvtCZccrXVyxaObB
         0fZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701799891; x=1702404691;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+VCd6O823a8CT11v1c1Pjh6+abowcBe1J6OGxvMERwU=;
        b=pazUh5YeZI4+gT9E4z0XyKHJR/D4YAIkfnRSBdJzc7lS7GnrNJMw/detmpaDsklvuR
         wA/wySa3WNazRGlbQ1KJapZkqX7XYWLAZB0NpCPlqXS+v6iZ4mVb4dLss8cD5CXoIVOG
         jh/jn9KGICYM6VztL7SiI7l3iw1sZ2w1DCF+0ZvzYWr0ZABtq3ear0cijy+DEEB2Ppkt
         XUeb9gozPVwzZxGIvF5MiQOhV2JSjWx8i6deA/IdNNMmv3cE53kuheBqBGe0SDOhLw2p
         6E07xLviTEJmYFUFhf3rKVaUx+El63bSKD5upZ60ohc6gcPMVHBkkG64Xpqa0jJbTGZn
         foCQ==
X-Gm-Message-State: AOJu0YwELrcKkNPEWj79z1JTNM+E6Z4NCyBeGI0abVmBAknMLy+B7RNF
	1bI6o0Y6zpQpeMjAvUrEZ60Dzn59sZOC727rhiA=
X-Google-Smtp-Source: AGHT+IHG/g/V/zf2T/gBSVHY7HqbqYKhGPhbz56/hnwhvj2VNdYwjdJtLDBvDlcLHQY+8Zqep5EvlQ==
X-Received: by 2002:a05:651c:1053:b0:2c9:f59b:79e with SMTP id x19-20020a05651c105300b002c9f59b079emr2837980ljm.16.1701799890845;
        Tue, 05 Dec 2023 10:11:30 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id gs7-20020a170906f18700b00a090b36d618sm7104264ejb.60.2023.12.05.10.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 10:11:30 -0800 (PST)
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
	guoren@kernel.org
Subject: [PATCH v1 07/14] RISC-V: KVM: Add SBI STA info to vcpu_arch
Date: Tue,  5 Dec 2023 19:11:27 +0100
Message-ID: <20231205181119.207204-23-ajones@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231205181119.207204-16-ajones@ventanamicro.com>
References: <20231205181119.207204-16-ajones@ventanamicro.com>
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
index b77f585879b7..fb13a05d7ec5 100644
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

