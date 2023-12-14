Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DA13BB23
	for <virtualization@lists.linux-foundation.org>; Thu, 14 Dec 2023 10:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="ARdxK9Gg"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9A4A282EA1
	for <virtualization@lists.linux-foundation.org>; Thu, 14 Dec 2023 10:16:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9A4A282EA1
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.a=rsa-sha256 header.s=google header.b=ARdxK9Gg
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7ALPTUqx2vz5
	for <virtualization@lists.linux-foundation.org>;
	Thu, 14 Dec 2023 10:16:01 +0000 (UTC)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 973F0821DE
	for <virtualization@lists.linux-foundation.org>; Thu, 14 Dec 2023 10:16:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 973F0821DE
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-40c38de1ee4so56216005e9.0
        for <virtualization@lists.linux-foundation.org>; Thu, 14 Dec 2023 02:16:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1702548960; x=1703153760; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x9z0wgw7c1ACY0OXaouY2QfTkuMcYS+PVo6Y2wv+kfs=;
        b=ARdxK9GgJ+PVqL9d9Ab0FOd36MNS7wG/TNi9/GfblOR+akYUcxVDYoAvifUSyXefk2
         GI5vNxU9DyjKi7DiFVNQN1wr1N9v2vOny4LWBbOMy/uGnB5wVctz1lsjDJsRrX5WGmPu
         jfaDucwJAXAhBJYFl/dsOfYiWVE49WOtR4N1MXTh/SdDiCxaWsfN1T38Tm9h6yqpFB3g
         7LrIcOQAtfHqtRFyzXVvEmG3kFGo3rg6yeWtHgyTizsjyErWKAncEYpifZDqJWp3UiRM
         LLCDUus0Wv21px3yChUDmER/OkFS0S4gYUKWNDCy81XKRMCmu0YVnahtciYc7APxBWwT
         ipGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702548960; x=1703153760;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x9z0wgw7c1ACY0OXaouY2QfTkuMcYS+PVo6Y2wv+kfs=;
        b=aZ8ePgWI2Azn7rP9+CAxLEqhNMdrZgrDN0AAYQ7FtPhP3f8VdwptdHbuggLrZtC4IW
         vT2ukW/Gj9ryZ+5mLDDYj+cyQG6960O6fPz+3BZkhJpDjzhMh+iycC53+DQ2t7LZktIT
         pZCGnL2665UCZnZkGZtojlIqNrZIWDumMof0YTLErYEosFVsEF5w/rXuLPZnF6MgsNjn
         fNGvywrNuQp9oGgnv9lchC/O14zQoS5EIpV6Mbr0NjOXKMOMBjL5glHmIjrnJu5FFPJd
         bbmZmfXwd1uI6X2dq5S93IxHzK/TDawg4W25/p4j37UICW8N31gMDfjXtGp2siQ5XFGe
         iW1A==
X-Gm-Message-State: AOJu0YxKdOqK3mX+c3x0JScqtw/PFLJAmUJ1jMFt6X8eRLIW6rNOwtJq
	WlJ0qU+DOGrlHRtKHcBy6PDYYQ==
X-Google-Smtp-Source: AGHT+IGZ9AhHTgJYYQdcMzfopk/2VTVccWhKtFnEy35KuQx9NmDe9qnj6vpjEZ2H7uzqWvgT+zRFhA==
X-Received: by 2002:a05:600c:3657:b0:40c:2d85:3a13 with SMTP id y23-20020a05600c365700b0040c2d853a13mr4944422wmq.185.1702548959717;
        Thu, 14 Dec 2023 02:15:59 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id v9-20020a05600c470900b0040c4acaa4bfsm13074951wmo.19.2023.12.14.02.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 02:15:59 -0800 (PST)
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
Subject: [PATCH v2 04/13] RISC-V: KVM: Add SBI STA extension skeleton
Date: Thu, 14 Dec 2023 11:15:56 +0100
Message-ID: <20231214101552.100721-19-ajones@ventanamicro.com>
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

Add the files and functions needed to support the SBI STA
(steal-time accounting) extension. In the next patches we'll
complete the functions to fully enable SBI STA support.

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

