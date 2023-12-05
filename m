Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0506A35A
	for <virtualization@lists.linux-foundation.org>; Tue,  5 Dec 2023 18:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="XzreJJL9"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EA88240939
	for <virtualization@lists.linux-foundation.org>; Tue,  5 Dec 2023 18:11:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EA88240939
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.a=rsa-sha256 header.s=google header.b=XzreJJL9
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kNbzhFmESCUB
	for <virtualization@lists.linux-foundation.org>;
	Tue,  5 Dec 2023 18:11:24 +0000 (UTC)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 7194440889
	for <virtualization@lists.linux-foundation.org>; Tue,  5 Dec 2023 18:11:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7194440889
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2c9f572c4c5so49083461fa.2
        for <virtualization@lists.linux-foundation.org>; Tue, 05 Dec 2023 10:11:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1701799882; x=1702404682; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XP1/09jJyFkevarkRVCoxzJ9CMGNE+4noIB7KCFekZw=;
        b=XzreJJL9OLhGkFZ8d7S6F8NHCd2NgyNnNV+2Y4uHTb5fZ5pTcA2OIVjaJmzYNBQRf2
         s6/tCW7f1zDTbp6wI24yRzuG/Dn5AX1jJKlkCzrmYXbR48TvAb/v1ed3xgKdbVqErbOD
         xyyEZfFJ1hgOOowZGusTmunnUKmujVLWAYCDC2TcbQ0m8tREzqsMKwCYVp3rVNWDKNyq
         eNcb1Cgm3UrEyzmHZ3G6ZqGWf0pHXdn+3JLIQjqzEd5xXrs9evELi8eKdveeuCzeVn/f
         oi349Cz2awSeBNQHrd8ooVlcgYF6WuqcJnce3htYJeOkpTg3mKCoJREDEN9bZ17DB6VB
         XXdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701799882; x=1702404682;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XP1/09jJyFkevarkRVCoxzJ9CMGNE+4noIB7KCFekZw=;
        b=BKRG9W0dxhw0rUJOiFctkQb/m1Ctw0pd0fUJKBcjQOhEGXWO0C7a+crD8s1Vy3LyRN
         BL1lp9Vp1SuX5xe3Bj3f4obRlA3XslxGujmE0q9xMSL3alGvYkRHT6klpr2ZDzITlZlq
         IcoF6igK0TTlVBERJ6sROSoBSlvli2lesJ9hDNre7OaXtopFa3hcvpauXxE4bgaptODm
         fii0TMUlovPQHNEZjSQMKhZD9n3XLFNUpHcsPYiGq1XPbHlyJAyHt7NMWD1U8vvVjlL8
         8y+TvTZMBjlqlQbqDgAgKsb+DkNWg5GT8ZUlnMtgguEgN+9iMjgYPgC0Q+L0GGUgDBRJ
         GrOw==
X-Gm-Message-State: AOJu0Yw0+8CketYfKxzmSKdbprk+1lS9H6K1ZhDLTbmPzRswJ3sJ96Cw
	/yvPZnBx6L8JAT1bgVtzCXQtlA==
X-Google-Smtp-Source: AGHT+IFQQrP9gWsGKtju2PRgRCexrQ9/sNwlzBo+NchuKczBS1ZmznUIgr1OJwZo1N35ysMOVE/FFg==
X-Received: by 2002:a05:651c:1a10:b0:2ca:1923:13b2 with SMTP id by16-20020a05651c1a1000b002ca192313b2mr1055695ljb.3.1701799882455;
        Tue, 05 Dec 2023 10:11:22 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id ci6-20020a170907266600b00a1b6cba8d20sm3321235ejc.122.2023.12.05.10.11.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 10:11:22 -0800 (PST)
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
Subject: [PATCH v1 01/14] RISC-V: paravirt: Add skeleton for pv-time support
Date: Tue,  5 Dec 2023 19:11:21 +0100
Message-ID: <20231205181119.207204-17-ajones@ventanamicro.com>
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

Add the files and functions needed to support paravirt time on
RISC-V. Also include the common code needed for the first
application of pv-time, which is steal-time. In the next
patches we'll complete the functions to fully enable steal-time
support.

Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
---
 .../admin-guide/kernel-parameters.txt         |  6 +-
 arch/riscv/include/asm/paravirt.h             | 28 +++++++
 arch/riscv/include/asm/paravirt_api_clock.h   |  1 +
 arch/riscv/kernel/Makefile                    |  1 +
 arch/riscv/kernel/paravirt.c                  | 77 +++++++++++++++++++
 arch/riscv/kernel/time.c                      |  3 +
 6 files changed, 113 insertions(+), 3 deletions(-)
 create mode 100644 arch/riscv/include/asm/paravirt.h
 create mode 100644 arch/riscv/include/asm/paravirt_api_clock.h
 create mode 100644 arch/riscv/kernel/paravirt.c

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 65731b060e3f..a0d9259e4857 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3985,9 +3985,9 @@
 			vulnerability. System may allow data leaks with this
 			option.
 
-	no-steal-acc	[X86,PV_OPS,ARM64,PPC/PSERIES] Disable paravirtualized
-			steal time accounting. steal time is computed, but
-			won't influence scheduler behaviour
+	no-steal-acc	[X86,PV_OPS,ARM64,PPC/PSERIES,RISCV] Disable
+			paravirtualized steal time accounting. steal time is
+			computed, but won't influence scheduler behaviour
 
 	nosync		[HW,M68K] Disables sync negotiation for all devices.
 
diff --git a/arch/riscv/include/asm/paravirt.h b/arch/riscv/include/asm/paravirt.h
new file mode 100644
index 000000000000..c0abde70fc2c
--- /dev/null
+++ b/arch/riscv/include/asm/paravirt.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_RISCV_PARAVIRT_H
+#define _ASM_RISCV_PARAVIRT_H
+
+#ifdef CONFIG_PARAVIRT
+#include <linux/static_call_types.h>
+
+struct static_key;
+extern struct static_key paravirt_steal_enabled;
+extern struct static_key paravirt_steal_rq_enabled;
+
+u64 dummy_steal_clock(int cpu);
+
+DECLARE_STATIC_CALL(pv_steal_clock, dummy_steal_clock);
+
+static inline u64 paravirt_steal_clock(int cpu)
+{
+	return static_call(pv_steal_clock)(cpu);
+}
+
+int __init pv_time_init(void);
+
+#else
+
+#define pv_time_init() do {} while (0)
+
+#endif /* CONFIG_PARAVIRT */
+#endif /* _ASM_RISCV_PARAVIRT_H */
diff --git a/arch/riscv/include/asm/paravirt_api_clock.h b/arch/riscv/include/asm/paravirt_api_clock.h
new file mode 100644
index 000000000000..65ac7cee0dad
--- /dev/null
+++ b/arch/riscv/include/asm/paravirt_api_clock.h
@@ -0,0 +1 @@
+#include <asm/paravirt.h>
diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index fee22a3d1b53..807c2bde1f83 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -85,6 +85,7 @@ obj-$(CONFIG_SMP)		+= sbi-ipi.o
 obj-$(CONFIG_SMP) += cpu_ops_sbi.o
 endif
 obj-$(CONFIG_HOTPLUG_CPU)	+= cpu-hotplug.o
+obj-$(CONFIG_PARAVIRT)		+= paravirt.o
 obj-$(CONFIG_KGDB)		+= kgdb.o
 obj-$(CONFIG_KEXEC_CORE)	+= kexec_relocate.o crash_save_regs.o machine_kexec.o
 obj-$(CONFIG_KEXEC_FILE)	+= elf_kexec.o machine_kexec_file.o
diff --git a/arch/riscv/kernel/paravirt.c b/arch/riscv/kernel/paravirt.c
new file mode 100644
index 000000000000..141dbcc36fa2
--- /dev/null
+++ b/arch/riscv/kernel/paravirt.c
@@ -0,0 +1,77 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2023 Ventana Micro Systems Inc.
+ */
+
+#define pr_fmt(fmt) "riscv-pv: " fmt
+
+#include <linux/cpuhotplug.h>
+#include <linux/init.h>
+#include <linux/jump_label.h>
+#include <linux/printk.h>
+#include <linux/static_call.h>
+#include <linux/types.h>
+
+struct static_key paravirt_steal_enabled;
+struct static_key paravirt_steal_rq_enabled;
+
+static u64 native_steal_clock(int cpu)
+{
+	return 0;
+}
+
+DEFINE_STATIC_CALL(pv_steal_clock, native_steal_clock);
+
+static bool steal_acc = true;
+static int __init parse_no_stealacc(char *arg)
+{
+	steal_acc = false;
+	return 0;
+}
+
+early_param("no-steal-acc", parse_no_stealacc);
+
+static bool __init has_pv_steal_clock(void)
+{
+	return false;
+}
+
+static int pv_time_cpu_online(unsigned int cpu)
+{
+	return 0;
+}
+
+static int pv_time_cpu_down_prepare(unsigned int cpu)
+{
+	return 0;
+}
+
+static u64 pv_time_steal_clock(int cpu)
+{
+	return 0;
+}
+
+int __init pv_time_init(void)
+{
+	int ret;
+
+	if (!has_pv_steal_clock())
+		return 0;
+
+	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
+				"riscv/pv_time:online",
+				pv_time_cpu_online,
+				pv_time_cpu_down_prepare);
+	if (ret < 0)
+		return ret;
+
+	static_call_update(pv_steal_clock, pv_time_steal_clock);
+
+	static_key_slow_inc(&paravirt_steal_enabled);
+	if (steal_acc)
+		static_key_slow_inc(&paravirt_steal_rq_enabled);
+
+	pr_info("using paravirt steal-time\n");
+
+	return 0;
+}
diff --git a/arch/riscv/kernel/time.c b/arch/riscv/kernel/time.c
index 23641e82a9df..ba3477197789 100644
--- a/arch/riscv/kernel/time.c
+++ b/arch/riscv/kernel/time.c
@@ -12,6 +12,7 @@
 #include <asm/sbi.h>
 #include <asm/processor.h>
 #include <asm/timex.h>
+#include <asm/paravirt.h>
 
 unsigned long riscv_timebase __ro_after_init;
 EXPORT_SYMBOL_GPL(riscv_timebase);
@@ -45,4 +46,6 @@ void __init time_init(void)
 	timer_probe();
 
 	tick_setup_hrtimer_broadcast();
+
+	pv_time_init();
 }
-- 
2.43.0

