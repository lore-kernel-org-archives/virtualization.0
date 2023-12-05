Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6BC56A35A
	for <virtualization@lists.linux-foundation.org>; Tue,  5 Dec 2023 18:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="CmdnaeAQ"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7745561052
	for <virtualization@lists.linux-foundation.org>; Tue,  5 Dec 2023 18:11:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7745561052
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.a=rsa-sha256 header.s=google header.b=CmdnaeAQ
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AXYeJNrYPRus
	for <virtualization@lists.linux-foundation.org>;
	Tue,  5 Dec 2023 18:11:27 +0000 (UTC)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1020960E64
	for <virtualization@lists.linux-foundation.org>; Tue,  5 Dec 2023 18:11:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1020960E64
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-54c5ed26cf6so5979708a12.3
        for <virtualization@lists.linux-foundation.org>; Tue, 05 Dec 2023 10:11:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1701799885; x=1702404685; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TUVfYhEWEIN79Rgo/fTCZLpVlj3ymRf4CHKAY/mO0w8=;
        b=CmdnaeAQ7VeJBBHPNga0w64Rm6H4w3wDaVEMZktrxzv1zApayIRrDhlEfONNC0i51N
         LhWkXaH/Nap0nfvGFfVqlsrv50SzU0DmP7qhgh5uQXjt1igKjJeGbSXsQmxteaGqxokb
         wnB6F0qnajpnseXVimakXquPAALrLzk35KR/sL7QgtDjX2IVPXRIcG2loxk9L802m1/3
         tZ/VYR7bNljBpGtZMCSjU0o+dXN76BJWRmOzwh+5gXFxG9BPosYvb/WbYMbUwHw6RihO
         5IZvlpOLUW1j1FnbYA97RI2OBN9EJm8t/o6cLEuIrdxGRJXKcvGYLhMvG0NAWnCCdXiB
         /Iag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701799885; x=1702404685;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TUVfYhEWEIN79Rgo/fTCZLpVlj3ymRf4CHKAY/mO0w8=;
        b=ijW4nLWfJV7CFYUf1bx3gx8yoTa3ttKEp+rYrx0hMQw+LGw9rQ8XaAPtIjhDr3CGHq
         /pzZ5g2mxo/aWa+HPnV4yzsffS5o/CvOIB6mmnotol66F6u99qxNerEEBnhJsmw0H65p
         GvixmmJqIuBQvKeHVKgCdxMhfG+O17wgEdKM+JUFr3CpUzOXDj4saG6Zs0Pz4XBHArte
         HyIQLEJdIfhENfgsEi6iOhuJVRrHakkc6dlre4wnISCGLfc0ay0VLAxrpLmgkch9jGSs
         SKJVXk6wf0r4TjWaXFY135/WIs57CG/mN1KjCJasasGMlHyeZrle262LYkuHLjiLcL7V
         mJ9w==
X-Gm-Message-State: AOJu0YzI5gx0OI/sHKsFEJP4PD/zg/gjEHfT9yCwHuEgXPAB5GMk9XiJ
	cn60s3MimOI1B3aPO54ckhDSlO/LhXuzfQz9VQw=
X-Google-Smtp-Source: AGHT+IGlKEyEdezq1VEkWw9MEwXrbWWNV5JvIs9OhSKBme3XS3JbSQ2K0LCihus5cFUwdwbwAmPiUQ==
X-Received: by 2002:a17:907:9254:b0:a19:a19b:55ff with SMTP id kb20-20020a170907925400b00a19a19b55ffmr720720ejb.143.1701799885049;
        Tue, 05 Dec 2023 10:11:25 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id o26-20020a170906289a00b009e5ce1acb01sm7024197ejd.103.2023.12.05.10.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 10:11:24 -0800 (PST)
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
Subject: [PATCH v1 03/14] RISC-V: paravirt: Implement steal-time support
Date: Tue,  5 Dec 2023 19:11:23 +0100
Message-ID: <20231205181119.207204-19-ajones@ventanamicro.com>
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

When the SBI STA extension exists we can use it to implement
paravirt steal-time support. Fill in the empty pv-time functions
with an SBI STA implementation.

Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
---
 arch/riscv/kernel/paravirt.c | 67 ++++++++++++++++++++++++++++++++++--
 1 file changed, 64 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/kernel/paravirt.c b/arch/riscv/kernel/paravirt.c
index 141dbcc36fa2..b509bcc7292a 100644
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
+		return -ENOMEM;
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

