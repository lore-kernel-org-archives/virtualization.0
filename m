Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2530C48CC3
	for <virtualization@lists.linux-foundation.org>; Sun, 17 Dec 2023 20:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="ZZZw68vW"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B123F60A77
	for <virtualization@lists.linux-foundation.org>; Sun, 17 Dec 2023 20:40:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B123F60A77
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.a=rsa-sha256 header.s=google header.b=ZZZw68vW
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Wptn6WiCcesr
	for <virtualization@lists.linux-foundation.org>;
	Sun, 17 Dec 2023 20:40:34 +0000 (UTC)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C9A2C60881
	for <virtualization@lists.linux-foundation.org>; Sun, 17 Dec 2023 20:40:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C9A2C60881
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-55359dc0290so76864a12.1
        for <virtualization@lists.linux-foundation.org>; Sun, 17 Dec 2023 12:40:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1702845632; x=1703450432; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1C9+m5vX7gcyxmg3o58CZNvyTEXIZyT+2uiierRNF4w=;
        b=ZZZw68vWxhj9KMUyK+ffmaUlYtL3GXCzDIhoTN+lB0L5xhB9jH0XwMrapf1itkq1cy
         fdiECrzW3qMiYJNKLKawht3SFHd/BS+RWIV9xf2NAaPryu8QgbNMXBgkrD9gMEbvQBz4
         7B4Q71ieaguNvbUDEFUCCQ7kzZGCO12Q2+rcUaxn6DO6RmteawwfWUzLXOtLe91EJyuN
         gtQgcCC49Gpkwmyta81i4+hs/JVGJzdAYw+CSiv9HYtlgFHoC5LfHDna1xVPNrgcGXJc
         KRJ8zR8qbfD2Xm5lwO0j2Z5Ak1XnbiyzPRuvRV7/qsqHRZTXHwl/7XlO8PpkCPemhil5
         lJJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702845632; x=1703450432;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1C9+m5vX7gcyxmg3o58CZNvyTEXIZyT+2uiierRNF4w=;
        b=PwXC96okSs/n0BVQ2D0ioKuISVV5pYjc3ydxmOu3w0UbrZXz2eXzZBSc06HpokI67X
         qD9Ax8/BrTsNhthkDz4gSFmEBhe/4CGNr/ZzIJbFPaD/k7bkKTNEZvAkpy/AyALvadYO
         A2+dmJIgwPFvRu0jxI/CmwFeY3JHbzf+e0S/rIBeB10+5o/Wp0o/xiLH/ZGhNhvANF4c
         Np6gkZm1CF/y40pmIL5GI0BS0riCPqqRocpRXuGsrNsFvJo5qpOrVZphBkG9fn9FLreS
         Jdh70s3y/YHHHx3IZGpdkc8gLB3vrsLk+tzhAqIngrEegSlqboaZg5gWqABzQ4ABWaqB
         HP+A==
X-Gm-Message-State: AOJu0YywMjE99rthyzBJHZH+Z9yuiu/XMyu3vmaIZVkuWaxJRtvlEWOv
	sWF12USHofuvZ1udFPdeC3WEWQ==
X-Google-Smtp-Source: AGHT+IEb5mXAsy/TcJRY+ESJBC2XjarrnzMd6USLhSGOvGSddsgFgaE+w41cFsUI7yalBL6uW3ZbrA==
X-Received: by 2002:a50:8712:0:b0:54c:aa1c:205e with SMTP id i18-20020a508712000000b0054caa1c205emr13974797edb.17.1702845631646;
        Sun, 17 Dec 2023 12:40:31 -0800 (PST)
Received: from localhost (cst-prg-88-42.cust.vodafone.cz. [46.135.88.42])
        by smtp.gmail.com with ESMTPSA id ev14-20020a056402540e00b005519a444a6asm5555289edb.71.2023.12.17.12.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Dec 2023 12:40:31 -0800 (PST)
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
Subject: [PATCH v3 03/13] RISC-V: paravirt: Implement steal-time support
Date: Sun, 17 Dec 2023 21:40:23 +0100
Message-ID: <20231217204019.36492-18-ajones@ventanamicro.com>
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

When the SBI STA extension exists we can use it to implement
paravirt steal-time support. Fill in the empty pv-time functions
with an SBI STA implementation and add the Kconfig knobs allowing
it to be enabled.

Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
---
 arch/riscv/Kconfig           | 19 +++++++++++
 arch/riscv/kernel/paravirt.c | 63 ++++++++++++++++++++++++++++++++++--
 2 files changed, 79 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 95a2a06acc6a..b99fd8129edf 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -724,6 +724,25 @@ config COMPAT
 
 	  If you want to execute 32-bit userspace applications, say Y.
 
+config PARAVIRT
+	bool "Enable paravirtualization code"
+	depends on RISCV_SBI
+	help
+	  This changes the kernel so it can modify itself when it is run
+	  under a hypervisor, potentially improving performance significantly
+	  over full virtualization.
+
+config PARAVIRT_TIME_ACCOUNTING
+	bool "Paravirtual steal time accounting"
+	depends on PARAVIRT
+	help
+	  Select this option to enable fine granularity task steal time
+	  accounting. Time spent executing other tasks in parallel with
+	  the current vCPU is discounted from the vCPU power. To account for
+	  that, there can be a small performance impact.
+
+	  If in doubt, say N here.
+
 config RELOCATABLE
 	bool "Build a relocatable kernel"
 	depends on MMU && 64BIT && !XIP_KERNEL
diff --git a/arch/riscv/kernel/paravirt.c b/arch/riscv/kernel/paravirt.c
index 141dbcc36fa2..cc6a85432678 100644
--- a/arch/riscv/kernel/paravirt.c
+++ b/arch/riscv/kernel/paravirt.c
@@ -6,12 +6,21 @@
 #define pr_fmt(fmt) "riscv-pv: " fmt
 
 #include <linux/cpuhotplug.h>
+#include <linux/compiler.h>
+#include <linux/errno.h>
 #include <linux/init.h>
 #include <linux/jump_label.h>
+#include <linux/kconfig.h>
+#include <linux/kernel.h>
+#include <linux/percpu-defs.h>
 #include <linux/printk.h>
 #include <linux/static_call.h>
 #include <linux/types.h>
 
+#include <asm/barrier.h>
+#include <asm/page.h>
+#include <asm/sbi.h>
+
 struct static_key paravirt_steal_enabled;
 struct static_key paravirt_steal_rq_enabled;
 
@@ -31,24 +40,72 @@ static int __init parse_no_stealacc(char *arg)
 
 early_param("no-steal-acc", parse_no_stealacc);
 
+DEFINE_PER_CPU(struct sbi_sta_struct, steal_time) __aligned(64);
+
 static bool __init has_pv_steal_clock(void)
 {
+	if (sbi_spec_version >= sbi_mk_version(2, 0) &&
+	    sbi_probe_extension(SBI_EXT_STA) > 0) {
+		pr_info("SBI STA extension detected\n");
+		return true;
+	}
+
 	return false;
 }
 
-static int pv_time_cpu_online(unsigned int cpu)
+static int sbi_sta_steal_time_set_shmem(unsigned long lo, unsigned long hi,
+					unsigned long flags)
 {
+	struct sbiret ret;
+
+	ret = sbi_ecall(SBI_EXT_STA, SBI_EXT_STA_STEAL_TIME_SET_SHMEM,
+			lo, hi, flags, 0, 0, 0);
+	if (ret.error) {
+		if (lo == SBI_STA_SHMEM_DISABLE && hi == SBI_STA_SHMEM_DISABLE)
+			pr_warn("Failed to disable steal-time shmem");
+		else
+			pr_warn("Failed to set steal-time shmem");
+		return sbi_err_map_linux_errno(ret.error);
+	}
+
 	return 0;
 }
 
+static int pv_time_cpu_online(unsigned int cpu)
+{
+	struct sbi_sta_struct *st = this_cpu_ptr(&steal_time);
+	phys_addr_t pa = __pa(st);
+	unsigned long lo = (unsigned long)pa;
+	unsigned long hi = IS_ENABLED(CONFIG_32BIT) ? upper_32_bits((u64)pa) : 0;
+
+	return sbi_sta_steal_time_set_shmem(lo, hi, 0);
+}
+
 static int pv_time_cpu_down_prepare(unsigned int cpu)
 {
-	return 0;
+	return sbi_sta_steal_time_set_shmem(SBI_STA_SHMEM_DISABLE,
+					    SBI_STA_SHMEM_DISABLE, 0);
 }
 
 static u64 pv_time_steal_clock(int cpu)
 {
-	return 0;
+	struct sbi_sta_struct *st = per_cpu_ptr(&steal_time, cpu);
+	u32 sequence;
+	u64 steal;
+
+	/*
+	 * Check the sequence field before and after reading the steal
+	 * field. Repeat the read if it is different or odd.
+	 */
+	do {
+		sequence = READ_ONCE(st->sequence);
+		virt_rmb();
+		steal = READ_ONCE(st->steal);
+		virt_rmb();
+	} while ((le32_to_cpu(sequence) & 1) ||
+		 sequence != READ_ONCE(st->sequence));
+
+	return le64_to_cpu(steal);
 }
 
 int __init pv_time_init(void)
-- 
2.43.0

