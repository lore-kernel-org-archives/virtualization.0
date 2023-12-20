Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402854174A
	for <virtualization@lists.linux-foundation.org>; Wed, 20 Dec 2023 16:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="iJO7XzAv"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A99996151C
	for <virtualization@lists.linux-foundation.org>; Wed, 20 Dec 2023 16:00:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A99996151C
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.a=rsa-sha256 header.s=google header.b=iJO7XzAv
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id A4YIAlMbCC3g
	for <virtualization@lists.linux-foundation.org>;
	Wed, 20 Dec 2023 16:00:33 +0000 (UTC)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
	by smtp3.osuosl.org (Postfix) with ESMTPS id BB0F760AC6
	for <virtualization@lists.linux-foundation.org>; Wed, 20 Dec 2023 16:00:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BB0F760AC6
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-3366827ca79so3263645f8f.3
        for <virtualization@lists.linux-foundation.org>; Wed, 20 Dec 2023 08:00:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1703088030; x=1703692830; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r9WZowL+tiFdWWavUDOR83U5hXyPT732YQIbLq7cwAs=;
        b=iJO7XzAvBaCozFDAoC2PJL5+UkmyFryTT6+FZtXdiI5aUFY0yeVchhD1v6cXN+Gy30
         Gnnx2Vvf0SVNjlF/iogEH3Nk7gXT7dK53zTS7xAdFkFl6DqnRiTVUakZkBKiwKsUFzZ1
         0OUtdLO5ze5KcWA6XzsoP+6V4x8JZUn5WOw4Im+p7szmTOJY3VxpYkaZ9HE1R62v/ZmF
         h5xS2VNOJr0/xZtEMoBdR23IDsWrPCoEHNEHbcWqEPWV0+CQv7t10aOFo33gMfVm5qao
         L0jcNERpWA1saUb41Zs6Wzvfh4uG6qg38iW12s1xi7+EM2HPoRqEV+OcIe6C7IZZwIG7
         VXXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703088030; x=1703692830;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r9WZowL+tiFdWWavUDOR83U5hXyPT732YQIbLq7cwAs=;
        b=K2OZPB+Hvdj3CeD7xjP9lSiyRgJhK+pLVZyA01Xj4oLhato1dgcjQZkgiqGVg5ukuQ
         yqCF+CqvvQUjazmpNL285bAV5Soaz2DcY6y/0hrLZyWkNmReBqNd+kTWyGO/I+xcuLK1
         mD8uOYts8AaIK7rKM3E8GfbsUREn1ZKZDAVfH5MXIFL8CBuuyhmFuZmSH1m8xwCmI0L7
         DpFoGSmLcOAHM1aratwf8r2exd1ICM+Ei6qau1yJ/m08JDGUFHwBUCr+r3DxvBSfni40
         mtOWkc8HAWo4ywJcb18ORVRQkuAuiuNiBYUdXtfgh3KY4qWSP46RHKbOkBdsHG0q6Ah8
         U3iw==
X-Gm-Message-State: AOJu0YzFYGroVSGaqhHMLeiKkXuG814rJ4OxjIl1U3ZwhWjO+ccHF5hJ
	df+5FhlqlNW/nApZKcSCD22SGQ==
X-Google-Smtp-Source: AGHT+IEVa6diqsl6ZvfXSq0rGo7hhkqDRW+n7TrUzKDkkOE6cmouItUMotaPVRNMlhVQdWbIguLklw==
X-Received: by 2002:a05:6000:2ae:b0:336:7a51:5fad with SMTP id l14-20020a05600002ae00b003367a515fadmr862343wry.141.1703088030605;
        Wed, 20 Dec 2023 08:00:30 -0800 (PST)
Received: from localhost (cst-prg-16-115.cust.vodafone.cz. [46.135.16.115])
        by smtp.gmail.com with ESMTPSA id z18-20020a5d4412000000b003367a51217csm2000039wrq.34.2023.12.20.08.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 08:00:30 -0800 (PST)
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
Subject: [PATCH v4 05/13] RISC-V: KVM: Add steal-update vcpu request
Date: Wed, 20 Dec 2023 17:00:18 +0100
Message-ID: <20231220160012.40184-20-ajones@ventanamicro.com>
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

Add a new vcpu request to inform a vcpu that it should record its
steal-time information. The request is made each time it has been
detected that the vcpu task was not assigned a cpu for some time,
which is easy to do by making the request from vcpu-load. The record
function is just a stub for now and will be filled in with the rest
of the steal-time support functions in following patches.

Reviewed-by: Anup Patel <anup@brainfault.org>
Reviewed-by: Atish Patra <atishp@rivosinc.com>
Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
---
 arch/riscv/include/asm/kvm_host.h | 3 +++
 arch/riscv/kvm/vcpu.c             | 5 +++++
 arch/riscv/kvm/vcpu_sbi_sta.c     | 4 ++++
 3 files changed, 12 insertions(+)

diff --git a/arch/riscv/include/asm/kvm_host.h b/arch/riscv/include/asm/kvm_host.h
index 0eefd9c991ae..230b82c3118d 100644
--- a/arch/riscv/include/asm/kvm_host.h
+++ b/arch/riscv/include/asm/kvm_host.h
@@ -41,6 +41,7 @@
 	KVM_ARCH_REQ_FLAGS(4, KVM_REQUEST_WAIT | KVM_REQUEST_NO_WAKEUP)
 #define KVM_REQ_HFENCE			\
 	KVM_ARCH_REQ_FLAGS(5, KVM_REQUEST_WAIT | KVM_REQUEST_NO_WAKEUP)
+#define KVM_REQ_STEAL_UPDATE		KVM_ARCH_REQ(6)
 
 enum kvm_riscv_hfence_type {
 	KVM_RISCV_HFENCE_UNKNOWN = 0,
@@ -372,4 +373,6 @@ bool kvm_riscv_vcpu_has_interrupts(struct kvm_vcpu *vcpu, u64 mask);
 void kvm_riscv_vcpu_power_off(struct kvm_vcpu *vcpu);
 void kvm_riscv_vcpu_power_on(struct kvm_vcpu *vcpu);
 
+void kvm_riscv_vcpu_record_steal_time(struct kvm_vcpu *vcpu);
+
 #endif /* __RISCV_KVM_HOST_H__ */
diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
index bf3952d1a621..6995b8b641e4 100644
--- a/arch/riscv/kvm/vcpu.c
+++ b/arch/riscv/kvm/vcpu.c
@@ -541,6 +541,8 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 
 	kvm_riscv_vcpu_aia_load(vcpu, cpu);
 
+	kvm_make_request(KVM_REQ_STEAL_UPDATE, vcpu);
+
 	vcpu->cpu = cpu;
 }
 
@@ -614,6 +616,9 @@ static void kvm_riscv_check_vcpu_requests(struct kvm_vcpu *vcpu)
 
 		if (kvm_check_request(KVM_REQ_HFENCE, vcpu))
 			kvm_riscv_hfence_process(vcpu);
+
+		if (kvm_check_request(KVM_REQ_STEAL_UPDATE, vcpu))
+			kvm_riscv_vcpu_record_steal_time(vcpu);
 	}
 }
 
diff --git a/arch/riscv/kvm/vcpu_sbi_sta.c b/arch/riscv/kvm/vcpu_sbi_sta.c
index 839911dcd837..e28351c9488b 100644
--- a/arch/riscv/kvm/vcpu_sbi_sta.c
+++ b/arch/riscv/kvm/vcpu_sbi_sta.c
@@ -8,6 +8,10 @@
 #include <asm/kvm_vcpu_sbi.h>
 #include <asm/sbi.h>
 
+void kvm_riscv_vcpu_record_steal_time(struct kvm_vcpu *vcpu)
+{
+}
+
 static int kvm_sbi_sta_steal_time_set_shmem(struct kvm_vcpu *vcpu)
 {
 	return SBI_ERR_FAILURE;
-- 
2.43.0

