Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55B73B789
	for <virtualization@lists.linux-foundation.org>; Thu, 14 Dec 2023 10:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="ji+N73Qi"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 51BB9436E8
	for <virtualization@lists.linux-foundation.org>; Thu, 14 Dec 2023 10:16:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 51BB9436E8
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.a=rsa-sha256 header.s=google header.b=ji+N73Qi
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IjxwP13IVhYi
	for <virtualization@lists.linux-foundation.org>;
	Thu, 14 Dec 2023 10:16:00 +0000 (UTC)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 01AB1436DF
	for <virtualization@lists.linux-foundation.org>; Thu, 14 Dec 2023 10:15:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 01AB1436DF
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-3363aa1b7d2so1377953f8f.0
        for <virtualization@lists.linux-foundation.org>; Thu, 14 Dec 2023 02:15:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1702548958; x=1703153758; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZDFKjtkEUBXvnuN4CRr8+YcMZn89qdhvuFwTlW15tEo=;
        b=ji+N73QipqZiKSKVJ2XGCP2H+XNHllzBT4275bKktUXlA7dYMFsVwtdSVTos0XTGKj
         Jvba1u24wQX5f6c/ItPJLPExcKyIX8jyV+n8wV81XdKxhfqlUJC71eeWCJLD0GW7IDX8
         /IW8RSUiWoC92Lbuj9yhteqUi3P1QFywkdXUPJ8tABlq2rjIpkvJSQ46uSb065WLDKdJ
         /OphpoprJ/1vXZVcMAjG2t9t/VvtnbZHJORdBdc9LWP5GEMo/vecZ7xYbhOBG8QWj35N
         WfcCnowBIqL/2s81hYbMkBBSBYU7iZure/O5YLxN8OOjThH920l0MQvocmwCvZRNcoQA
         SmXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702548958; x=1703153758;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZDFKjtkEUBXvnuN4CRr8+YcMZn89qdhvuFwTlW15tEo=;
        b=o2w5bTzvEcBH3iik/PiSD28Q0G3nQuxQ6Fsjc2ZK4I2aoNMsrRsO4wptxUpurXvpLS
         Segc42QI+6SNXwQKlYDAakqX7FynoonA/4QZIhNsTn89u1j53FE1vG4lIdpKSRcA9zOW
         m+IIyl/ORohaT3o0WP8n6X4nXq+bbnhzIqVc9fIFDNbTcxr6zdv+3rgiOXaDri4avaZr
         tR/jXzn7eT3Y0vMZorFAjtphgj96oBlxP/5zkM5bQEfYULyoPABQMkApsPZZy+V649vB
         uLWbN8jxDs8tuNpRoJu6bCRNmodW82okLBDVfQC2DoZpPCMN2z1zSK/wB2KF08d7UTNG
         wBYA==
X-Gm-Message-State: AOJu0YzzTsh576RvzVLmSNQ6BA2UMOQcW7u20/Z0aZy9kYEn9Q69zlZR
	9FeM9xIeMWq2A1ndat7UHR6tdA==
X-Google-Smtp-Source: AGHT+IGp5Rd3G1mgW2O3vK3x6v4ws/oY3mSDmogD/aXwkyD9KfbxZIOuMClxn+rbdPkn05lnyYl5Qg==
X-Received: by 2002:adf:ecc2:0:b0:333:2fd2:3c0d with SMTP id s2-20020adfecc2000000b003332fd23c0dmr3732444wro.198.1702548958139;
        Thu, 14 Dec 2023 02:15:58 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id e18-20020a056000121200b00333404e9935sm15526269wrx.54.2023.12.14.02.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 02:15:57 -0800 (PST)
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
Subject: [PATCH v2 03/13] RISC-V: paravirt: Implement steal-time support
Date: Thu, 14 Dec 2023 11:15:55 +0100
Message-ID: <20231214101552.100721-18-ajones@ventanamicro.com>
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

When the SBI STA extension exists we can use it to implement
paravirt steal-time support. Fill in the empty pv-time functions
with an SBI STA implementation and add the Kconfig knobs allowing
it to be enabled.

Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
---
 arch/riscv/Kconfig           | 19 ++++++++++
 arch/riscv/kernel/paravirt.c | 67 ++++++++++++++++++++++++++++++++++--
 2 files changed, 83 insertions(+), 3 deletions(-)

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
index 141dbcc36fa2..b09dfd81bcd2 100644
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
 
@@ -31,24 +40,76 @@ static int __init parse_no_stealacc(char *arg)
 
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
+	if (IS_ENABLED(CONFIG_32BIT)) {
+		/*
+		 * Check the sequence field before and after reading the steal
+		 * field. Repeat the read if it is different or odd.
+		 */
+		do {
+			sequence = READ_ONCE(st->sequence);
+			virt_rmb();
+			steal = READ_ONCE(st->steal);
+			virt_rmb();
+		} while ((le32_to_cpu(sequence) & 1) ||
+			 sequence != READ_ONCE(st->sequence));
+	} else {
+		steal = READ_ONCE(st->steal);
+	}
+
+	return le64_to_cpu(steal);
 }
 
 int __init pv_time_init(void)
-- 
2.43.0

