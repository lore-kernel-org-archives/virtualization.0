Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DAB54C3AF
	for <virtualization@lists.linux-foundation.org>; Wed, 20 Dec 2023 16:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="IT5pbTjA"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C4C3A4206B
	for <virtualization@lists.linux-foundation.org>; Wed, 20 Dec 2023 16:00:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C4C3A4206B
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.a=rsa-sha256 header.s=google header.b=IT5pbTjA
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gyRUPGO9DlZM
	for <virtualization@lists.linux-foundation.org>;
	Wed, 20 Dec 2023 16:00:30 +0000 (UTC)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
	by smtp4.osuosl.org (Postfix) with ESMTPS id CA15D4206A
	for <virtualization@lists.linux-foundation.org>; Wed, 20 Dec 2023 16:00:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CA15D4206A
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-33679c49fe5so735607f8f.3
        for <virtualization@lists.linux-foundation.org>; Wed, 20 Dec 2023 08:00:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1703088028; x=1703692828; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ef7BOv98cAGOovGfjdBZq243xgaKf+nknpOtiiGkzlE=;
        b=IT5pbTjAH+CngLrt0HhgSfxrvXbsR8zxmfw0CKrV+t5XvZ3DId1ZpfyUWN8LR8yaTx
         Ynvq786ha+F/o/Qu5QvCZO9FWH/eZAWRNnktApkSemUbw/OwsBT8bpwCYQ0u/J0yFL1D
         TwUy9QswjK5IqB1lYnUZNcCIbotrgeOqmtrAIpUf3uzk07AUibHsHkKE6pn8MB8MwVRI
         RHdSS+74XWOpJKLTG0UF/gyR0Uwdh4VxHywXH8WR5Fz5J/dUzuP97wCrkCbY5exrSoFH
         ahtYHlROQj0y/L5Cn+f9OooAsMo8HE4sJbY902/b0g/t46BNxoyWwW2C+sRf8Q/diEm0
         t3Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703088028; x=1703692828;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ef7BOv98cAGOovGfjdBZq243xgaKf+nknpOtiiGkzlE=;
        b=vpZnzvw3YU7q3tnpOO/fNy2NNTIId7lppwOKAGL2S8B3YfdtqNq1BVq2ubUze//Hed
         qerfZySSSAZMLHfudfjdz8gu5qmMYArzg21aasJIJecryzFx/HdfAJoNjgDBeJwwvFgx
         LmsAkmg5HoFywVQ4Ea5Oa/ER04s9XTBkTlviKjZD2RjIQurapaBbHT3p2lAXRdzpGX/w
         p4ewcgiMHU5PrP8YMHFNhc2QUBsH+sgJQQ5nPN+GliVVBfSZuWImTQnEF+iTw2dUr+qL
         yL/fJMkkHwolOotOVZ4GwSO34I5WWG6DAngqCm9oNCh9gxmz8ufHvXs93phdimFLCq5H
         lDUQ==
X-Gm-Message-State: AOJu0YwFR8RCxuMRjTMiRTOoYaeb8o1+t2XK6YgP4BXHSxymQuGIerX6
	ABVD8LHdYauo68B3MNaSSSoqUg==
X-Google-Smtp-Source: AGHT+IEUaGQVUmOJpZrX/6wcMiUkr7MlMCgJwXmlqp3SKkS+7blylWY6WOfvZFXTaKATAxCW7rwCPQ==
X-Received: by 2002:adf:f68c:0:b0:336:64cd:3fc3 with SMTP id v12-20020adff68c000000b0033664cd3fc3mr3328065wrp.59.1703088027960;
        Wed, 20 Dec 2023 08:00:27 -0800 (PST)
Received: from localhost (cst-prg-16-115.cust.vodafone.cz. [46.135.16.115])
        by smtp.gmail.com with ESMTPSA id d5-20020a5d5385000000b0033662cf5e51sm10303884wrv.93.2023.12.20.08.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 08:00:27 -0800 (PST)
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
Subject: [PATCH v4 04/13] RISC-V: KVM: Add SBI STA extension skeleton
Date: Wed, 20 Dec 2023 17:00:17 +0100
Message-ID: <20231220160012.40184-19-ajones@ventanamicro.com>
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

Add the files and functions needed to support the SBI STA
(steal-time accounting) extension. In the next patches we'll
complete the functions to fully enable SBI STA support.

Reviewed-by: Anup Patel <anup@brainfault.org>
Reviewed-by: Atish Patra <atishp@rivosinc.com>
Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
---
 arch/riscv/include/asm/kvm_vcpu_sbi.h |  1 +
 arch/riscv/include/uapi/asm/kvm.h     |  1 +
 arch/riscv/kvm/Makefile               |  1 +
 arch/riscv/kvm/vcpu_sbi.c             |  4 +++
 arch/riscv/kvm/vcpu_sbi_sta.c         | 47 +++++++++++++++++++++++++++
 5 files changed, 54 insertions(+)
 create mode 100644 arch/riscv/kvm/vcpu_sbi_sta.c

diff --git a/arch/riscv/include/asm/kvm_vcpu_sbi.h b/arch/riscv/include/asm/kvm_vcpu_sbi.h
index bffda0ac59b6..99c23bb37a37 100644
--- a/arch/riscv/include/asm/kvm_vcpu_sbi.h
+++ b/arch/riscv/include/asm/kvm_vcpu_sbi.h
@@ -76,6 +76,7 @@ extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_rfence;
 extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_srst;
 extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_hsm;
 extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_dbcn;
+extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_sta;
 extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_experimental;
 extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_vendor;
 
diff --git a/arch/riscv/include/uapi/asm/kvm.h b/arch/riscv/include/uapi/asm/kvm.h
index 60d3b21dead7..e961d79622fb 100644
--- a/arch/riscv/include/uapi/asm/kvm.h
+++ b/arch/riscv/include/uapi/asm/kvm.h
@@ -157,6 +157,7 @@ enum KVM_RISCV_SBI_EXT_ID {
 	KVM_RISCV_SBI_EXT_EXPERIMENTAL,
 	KVM_RISCV_SBI_EXT_VENDOR,
 	KVM_RISCV_SBI_EXT_DBCN,
+	KVM_RISCV_SBI_EXT_STA,
 	KVM_RISCV_SBI_EXT_MAX,
 };
 
diff --git a/arch/riscv/kvm/Makefile b/arch/riscv/kvm/Makefile
index 4c2067fc59fc..c9646521f113 100644
--- a/arch/riscv/kvm/Makefile
+++ b/arch/riscv/kvm/Makefile
@@ -26,6 +26,7 @@ kvm-$(CONFIG_RISCV_SBI_V01) += vcpu_sbi_v01.o
 kvm-y += vcpu_sbi_base.o
 kvm-y += vcpu_sbi_replace.o
 kvm-y += vcpu_sbi_hsm.o
+kvm-y += vcpu_sbi_sta.o
 kvm-y += vcpu_timer.o
 kvm-$(CONFIG_RISCV_PMU_SBI) += vcpu_pmu.o vcpu_sbi_pmu.o
 kvm-y += aia.o
diff --git a/arch/riscv/kvm/vcpu_sbi.c b/arch/riscv/kvm/vcpu_sbi.c
index dcdff4458190..088daaa23dd8 100644
--- a/arch/riscv/kvm/vcpu_sbi.c
+++ b/arch/riscv/kvm/vcpu_sbi.c
@@ -70,6 +70,10 @@ static const struct kvm_riscv_sbi_extension_entry sbi_ext[] = {
 		.ext_idx = KVM_RISCV_SBI_EXT_DBCN,
 		.ext_ptr = &vcpu_sbi_ext_dbcn,
 	},
+	{
+		.ext_idx = KVM_RISCV_SBI_EXT_STA,
+		.ext_ptr = &vcpu_sbi_ext_sta,
+	},
 	{
 		.ext_idx = KVM_RISCV_SBI_EXT_EXPERIMENTAL,
 		.ext_ptr = &vcpu_sbi_ext_experimental,
diff --git a/arch/riscv/kvm/vcpu_sbi_sta.c b/arch/riscv/kvm/vcpu_sbi_sta.c
new file mode 100644
index 000000000000..839911dcd837
--- /dev/null
+++ b/arch/riscv/kvm/vcpu_sbi_sta.c
@@ -0,0 +1,47 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2023 Ventana Micro Systems Inc.
+ */
+
+#include <linux/kvm_host.h>
+
+#include <asm/kvm_vcpu_sbi.h>
+#include <asm/sbi.h>
+
+static int kvm_sbi_sta_steal_time_set_shmem(struct kvm_vcpu *vcpu)
+{
+	return SBI_ERR_FAILURE;
+}
+
+static int kvm_sbi_ext_sta_handler(struct kvm_vcpu *vcpu, struct kvm_run *run,
+				   struct kvm_vcpu_sbi_return *retdata)
+{
+	struct kvm_cpu_context *cp = &vcpu->arch.guest_context;
+	unsigned long funcid = cp->a6;
+	int ret;
+
+	switch (funcid) {
+	case SBI_EXT_STA_STEAL_TIME_SET_SHMEM:
+		ret = kvm_sbi_sta_steal_time_set_shmem(vcpu);
+		break;
+	default:
+		ret = SBI_ERR_NOT_SUPPORTED;
+		break;
+	}
+
+	retdata->err_val = ret;
+
+	return 0;
+}
+
+static unsigned long kvm_sbi_ext_sta_probe(struct kvm_vcpu *vcpu)
+{
+	return 0;
+}
+
+const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_sta = {
+	.extid_start = SBI_EXT_STA,
+	.extid_end = SBI_EXT_STA,
+	.handler = kvm_sbi_ext_sta_handler,
+	.probe = kvm_sbi_ext_sta_probe,
+};
-- 
2.43.0

