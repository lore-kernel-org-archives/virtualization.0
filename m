Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5EE4C3A5
	for <virtualization@lists.linux-foundation.org>; Wed, 20 Dec 2023 16:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="YvUWfamH"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 927F9834F1
	for <virtualization@lists.linux-foundation.org>; Wed, 20 Dec 2023 16:00:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 927F9834F1
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.a=rsa-sha256 header.s=google header.b=YvUWfamH
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NJ2WZwMiHOPC
	for <virtualization@lists.linux-foundation.org>;
	Wed, 20 Dec 2023 16:00:27 +0000 (UTC)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 969A1833D3
	for <virtualization@lists.linux-foundation.org>; Wed, 20 Dec 2023 16:00:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 969A1833D3
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-40d2376db79so18094465e9.0
        for <virtualization@lists.linux-foundation.org>; Wed, 20 Dec 2023 08:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1703088025; x=1703692825; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lWv1b2FFYWZhlrkz0rd4Y40mouV9jQQisf/jEYboQMg=;
        b=YvUWfamHQ9XKIwcAGNAp0xYbNfmt7IsLLRXuSIT4M75csJnGxLd7S07xGfXgbbM5gT
         QmymEY90030vkDTD2i+lOshKM6ASh2oSc7YukiEc/hj+uzQvVy2fPoDM2qs7yZLmewwI
         0eVucrmUbAwFGiOchn1faHtF1MChXrig5p4S2mpTJqQjUo6B9BbuUyTNJ6LftqxgOfmv
         BZBCBXolD/pWjMXPp0jJtZ97Aa5Aw0bkzjg11bQn4WonrLt4xtDfGpAWAe+fBr65L95q
         IBvM3U5U4D+fl7E0L44R3gGIF+uk0iiaAH8mLZUaZLstUnpbj+Yx/pjb3JezcGBr6Ss5
         pcWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703088025; x=1703692825;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lWv1b2FFYWZhlrkz0rd4Y40mouV9jQQisf/jEYboQMg=;
        b=rHjp6Y3ABfwI2SShnGztlDtq0jPQ+d8FBV2Kos2ZcgXwgpQtX9jEKI6gdqYFLPmuF2
         KdSRCZXiPFgr60/U0FzfGhAJFqPQgtzaOW9YJb9pHRFiYHQBaEA4dxkn44bdx3kOJmt5
         dXA2ksJwvObJ2VJtS8vlYd9gp1vfIRdxMXiO3tzuBSiEkJkE/TF4dMQ3Cz/Xj9Ej4ud7
         WZSiLN8zJWcBDvAq6tVP3JLhCHpvOpdtYSeJOHpX+XCqmQ2/6GBN3trR68hqYFUnYApy
         yKcK/WrtX2L9MIY2x4z82lb8zWl8s2syBQAf/G+blqOz1GivKDdbWy90ksIHk5VTbYJu
         iZjA==
X-Gm-Message-State: AOJu0YwCQMOvbaXzUraLia2a/WDRYISoetwNR8c2T2V+pXxRRJeCB3/I
	WlUdeiO2f498sQ6C88ZVeUH11A==
X-Google-Smtp-Source: AGHT+IHVvI5ZqhZaeg4C46CXZ1+zhCNNhxSIuL3dAJlR2VQgnunKdikGdwK0omwckzUrn3x0Ub3amQ==
X-Received: by 2002:a05:600c:3105:b0:40c:7103:d9c9 with SMTP id g5-20020a05600c310500b0040c7103d9c9mr4994434wmo.115.1703088025717;
        Wed, 20 Dec 2023 08:00:25 -0800 (PST)
Received: from localhost (cst-prg-16-115.cust.vodafone.cz. [46.135.16.115])
        by smtp.gmail.com with ESMTPSA id c5-20020a05600c0a4500b0040c411da99csm7955710wmq.48.2023.12.20.08.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 08:00:25 -0800 (PST)
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
Subject: [PATCH v4 03/13] RISC-V: paravirt: Implement steal-time support
Date: Wed, 20 Dec 2023 17:00:16 +0100
Message-ID: <20231220160012.40184-18-ajones@ventanamicro.com>
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

When the SBI STA extension exists we can use it to implement
paravirt steal-time support. Fill in the empty pv-time functions
with an SBI STA implementation and add the Kconfig knobs allowing
it to be enabled.

Reviewed-by: Atish Patra <atishp@rivosinc.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
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
index 080c95d2a295..574733b2bbea 100644
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

