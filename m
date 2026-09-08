Received: from mail-qk1-f225.google.com (mail-qk1-f225.google.com [209.85.222.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF2859C971
	for <virtualization@lists.linux.dev>; Tue,  8 Sep 2026 18:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788891342; cv=none; b=pD8xNysXn2pEbP780Yho1JbnBFgj7nbPzm+ezxvkNDRT1vjP8jUcVcJ76FNt8gJp3egUA9ye4Ek9kNtF+UjVrWrEQAXV0TkK8ahjP8uEXs/ypPz4ghkH2OWLgtvGgR6vsp50KWzkq3xc2p5o8uNQ+AneWbMfi8vwcu4Ejn0Sz5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788891342; c=relaxed/simple;
	bh=OTLibMJN8TSomAcVsMbXDk3Gt+WGTUspXK8ZV+K+zOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p68wQFtyKZQS0TIoK9cVMrPss2qeZWQV/1Fkws5RRchEtgppwS7FOqgSxwFJrK9n2zGWjdadO0BgVu0LGIvi/Bg/cZloXpgOBHszfcTSl6FZ1A30MarckJWf/clbyw4Xh+WsUumn1fTBdle0SglLS5hYChWx8SCunhXhuaebQkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Md427YCi; arc=none smtp.client-ip=209.85.222.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Md427YCi"
Received: by mail-qk1-f225.google.com with SMTP id af79cd13be357-92ed19f4d60so447799485a.0
        for <virtualization@lists.linux.dev>; Tue, 08 Sep 2026 11:15:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788891338; x=1789496138;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X96+zYCvaN6SOrdHaZFaRkSOvwWaLyxQvweykkN1/zc=;
        b=h3CMdhhITks5eBtsFDEjv46Fvzm7MOO2R1y1wACtv0jnHWQO1ivFAHjXSQTWD+PbrO
         Sjyr63BQocuf8yKhexW4TD3k1q0sX6LX1cG4ykyW8/fFh/wdxpelj7iU5bLK+ioQePI4
         2H99yd8AH4mNhACoYBi+gYgAZLQVWNJEpmdrBUWwTCc9tO5Gf1nddnaDFJ65scXEkXg6
         S5wnNfRtG515rk2hfvaPxa1+bhwEsNyW4shrjGMabRC02LZN3IEg7DQLJFj0D6x88YEJ
         6SMUb2e1wyxanES1/6qu4IxcF79HzqT7TCy7ZybAzTxktHM0IYnE/yRQfxpyQppGaCBx
         0A7A==
X-Forwarded-Encrypted: i=1; AKwUvBwma1VvhoWldWqbAyGpvlJPv1iEKKaW3Nbq3yvrNxa0kprShDgglIE6+UMqPEZ3ZxrHsdTksFQ2478WLrsK5g==@lists.linux.dev
X-Gm-Message-State: AFuF++kuA9ggsSz+9Zj5lVvgs/DTyOHO07jHQkyAnHW1n/9GqDdfi8WD
	EawswccqZpuJr3q9Kcsp3oFpQwIdVIfhsLh8eoj6iR1r7ZDIrY2CQ06gzNQ48M6sXmf5WWWiq6e
	6BMBvf5c4mzlbiS+F2NGvC29z1RH2Y8EV1KS57yO9kTnc0M4WZEYVw7XxYj6liw0xMX35js6hL5
	p6E/3LMHCeul59+QnDecbfbAlIzaRjPjlpepg4qzBv4I14GrOy7NU4eH1XI4VxsC3mqKZv4FNba
	pWBN+g2t0B6NmCLMX4=
X-Gm-Gg: AYBFou3sP70QBUCCMbNTR+TwULMYjI5Wt7WQRbRSt2qjoXy3YluxtIqfh1mdAIHCKij
	owJ0udHl3tdsoOXEYMJYYHxcc2v8CuHkU1Z0sIXNz8vVtNSaAS6wjmDxxzlt+E8W5sFQKYCtMAi
	DaSx+OPW7gMcQWCBI3nziXc+Hec/wbNUoTxJRWIKbwdzGAV1786cwcsqz88n/SNSbK0aEPIZmwI
	r0gD5rp0lDESDRuJntON53HiM3lZFxLS6JPwE/ThVoemysj4DuBgYmQdSZ16U6Ni3ugjdWbY0hO
	t5TT6q7adwBv3PDUV4WmctczSPy5Pp8RtNCEH++npsMwdHrIyspvyVB6iGd6+Rz/i/UA52aKNYl
	QyZCvaPIS2bBUR6t3FEA82G7CRdrurLjahH8tRx3lDq2obdt3qXBeywDXZ5WiZL5BAmkreHMj+9
	8l4B6jtkr4n1IgZzH9ZwnvKRu5mD5CCS7aqX4=
X-Received: by 2002:a05:620a:a70e:b0:934:b798:c245 with SMTP id af79cd13be357-9396e07a2bdmr2586974885a.16.1788891338308;
        Tue, 08 Sep 2026 11:15:38 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-125.dlp.protect.broadcom.com. [144.49.247.125])
        by smtp-relay.gmail.com with ESMTPS id af79cd13be357-9397f80ad94sm122772285a.0.2026.09.08.11.15.37
        for <virtualization@lists.linux.dev>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Sep 2026 11:15:38 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-45eb9967696so5102093fac.1
        for <virtualization@lists.linux.dev>; Tue, 08 Sep 2026 11:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1788891337; x=1789496137; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=X96+zYCvaN6SOrdHaZFaRkSOvwWaLyxQvweykkN1/zc=;
        b=Md427YCi4W6YacMZyTD+wS4ernipzQBcRXjAKrAlDETaWTfOeyLt+K6t6JP5naErjf
         zy1NiMqpSoUqd3HBr0j4XHSoDMuH1b3gxiqI8I7vlmeOF5+2ZVAEpb7l318tXvhqk8+8
         lCBJTYBgJchCDCUkF7mKJWfQ7Hn8gFmEHnn8I=
X-Forwarded-Encrypted: i=1; AKwUvBzRIDL6opXWyhVPnpdKjRqj2K8sN7jaGqXepOCcliuOutjjWRtH5CrN/NH+/74eKuMODL0njLEtqAMVzka2hw==@lists.linux.dev
X-Received: by 2002:a05:690e:418d:b0:671:4d2:804e with SMTP id 956f58d0204a3-67104d28276mr98601d50.36.1788890858286;
        Tue, 08 Sep 2026 11:07:38 -0700 (PDT)
X-Received: by 2002:a05:690e:418d:b0:671:4d2:804e with SMTP id 956f58d0204a3-67104d28276mr98573d50.36.1788890857670;
        Tue, 08 Sep 2026 11:07:37 -0700 (PDT)
Received: from vertex.localdomain (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9106412e038sm27114866d6.20.2026.09.08.11.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 11:07:34 -0700 (PDT)
From: Zack Rusin <zack.rusin@broadcom.com>
To: Borislav Petkov <bp@alien8.de>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	x86@kernel.org,
	Petr Mladek <pmladek@suse.com>,
	Joel Granados <joel.granados@kernel.org>,
	Baoquan He <baoquan.he@linux.dev>
Cc: Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	virtualization@lists.linux.dev,
	bcm-kernel-feedback-list@broadcom.com,
	linux-kernel@vger.kernel.org,
	John Ogness <john.ogness@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Kees Cook <kees@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Dave Young <ruirui.yang@linux.dev>,
	Jonathan Corbet <corbet@lwn.net>,
	Bo Gan <bo.gan@broadcom.com>,
	Brennan Lamoreaux <brennan.lamoreaux@broadcom.com>,
	kexec@lists.infradead.org,
	linux-doc@vger.kernel.org,
	Zack Rusin <zack.rusin@broadcom.com>
Subject: [PATCH v1 3/4] x86/vmware: Report guest crashes after kmsg dumpers
Date: Tue,  8 Sep 2026 14:07:15 -0400
Message-ID: <8243a70e3bc282e3fbc1b507f40b889cb7e74305.1788414671.git.zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1788414671.git.zack.rusin@broadcom.com>
References: <cover.1788414671.git.zack.rusin@broadcom.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

VMware accepts a structured guest-crash event, but a host configured with
backdoor.coredumpOnCrash may terminate the VM before the hypercall
returns. Sending the event from a panic notifier could prevent later kmsg
dumpers and a loaded crash kernel from running.

Register a second panic-only kmsg dumper with late_initcall_sync(). Kmsg
dumpers run in registration order, placing the report after the early
VMware logger and built-in dumpers registered by then. This leaves no
report before the late initcall, but avoids losing dump output to a
terminating host.

Skip the event when a crash kernel is loaded. The earlier logger can still
write panic text to vmware.log before __crash_kexec(). If kdump later
fails, no structured event is sent; issuing it first could prevent kdump
from running at all.

Issue the event at most once. With CONFIG_PRINTK=n, install a late
INT_MIN panic notifier. An unexpected dumper registration failure with
printk enabled leaves reporting disabled because a notifier fallback
would overtake working dumpers.

Link: https://lore.kernel.org/r/20260309235250.2611115-4-alexey.makhalov@broadcom.com
Co-developed-by: Brennan Lamoreaux <brennan.lamoreaux@broadcom.com>
Signed-off-by: Brennan Lamoreaux <brennan.lamoreaux@broadcom.com>
Co-developed-by: Alexey Makhalov <alexey.makhalov@broadcom.com>
Signed-off-by: Alexey Makhalov <alexey.makhalov@broadcom.com>
Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
---
 arch/x86/include/asm/vmware.h |  1 +
 arch/x86/kernel/cpu/vmware.c  | 63 +++++++++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+)

diff --git a/arch/x86/include/asm/vmware.h b/arch/x86/include/asm/vmware.h
index 598d4cd448ec..ea2ce5272a00 100644
--- a/arch/x86/include/asm/vmware.h
+++ b/arch/x86/include/asm/vmware.h
@@ -61,6 +61,7 @@
 #define VMWARE_CMD_GETHZ		45
 #define VMWARE_CMD_GETVCPU_INFO		68
 #define VMWARE_CMD_STEALCLOCK		91
+#define VMWARE_CMD_REPORTGUESTCRASH	102
 /*
  * Hypercall command mask:
  *   bits [6:0] command, range [0, 127]
diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
index 3848811550e9..c21fc835537f 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -22,10 +22,14 @@
  */
 
 #include <linux/dmi.h>
+#include <linux/atomic.h>
+#include <linux/crash_core.h>
 #include <linux/init.h>
 #include <linux/export.h>
 #include <linux/kmsg_dump.h>
+#include <linux/limits.h>
 #include <linux/mm.h>
+#include <linux/panic_notifier.h>
 #include <linux/clocksource.h>
 #include <linux/cpu.h>
 #include <linux/efi.h>
@@ -323,6 +327,65 @@ static int __init vmware_panic_log_init(void)
 }
 early_initcall(vmware_panic_log_init);
 
+static atomic_t vmware_crash_reported = ATOMIC_INIT(0);
+
+static void vmware_report_guest_crash(void)
+{
+	if (kexec_crash_loaded())
+		return;
+	if (atomic_xchg(&vmware_crash_reported, 1))
+		return;
+
+	vmware_hypercall1(VMWARE_CMD_REPORTGUESTCRASH, 0);
+}
+
+static void vmware_crash_report_dump(struct kmsg_dumper *dumper,
+				     struct kmsg_dump_detail *detail)
+{
+	vmware_report_guest_crash();
+}
+
+static struct kmsg_dumper vmware_crash_report_dumper = {
+	.dump = vmware_crash_report_dump,
+	.max_reason = KMSG_DUMP_PANIC,
+};
+
+static int vmware_crash_report_notify(struct notifier_block *nb,
+				      unsigned long action, void *data)
+{
+	vmware_report_guest_crash();
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block vmware_crash_report_nb = {
+	.notifier_call = vmware_crash_report_notify,
+	.priority = INT_MIN,
+};
+
+static int __init vmware_crash_report_init(void)
+{
+	int ret;
+
+	if (!hypervisor_is_type(X86_HYPER_VMWARE))
+		return 0;
+
+	ret = kmsg_dump_register(&vmware_crash_report_dumper);
+	if (!ret)
+		return 0;
+	if (IS_ENABLED(CONFIG_PRINTK)) {
+		pr_err("failed to register crash report dumper: %d\n", ret);
+		return 0;
+	}
+
+	ret = atomic_notifier_chain_register(&panic_notifier_list,
+					     &vmware_crash_report_nb);
+	if (ret)
+		pr_err("failed to register crash report notifier: %d\n", ret);
+
+	return 0;
+}
+late_initcall_sync(vmware_crash_report_init);
+
 #ifdef CONFIG_PARAVIRT
 static struct cyc2ns_data vmware_cyc2ns __ro_after_init;
 static bool vmw_sched_clock __initdata = true;
-- 
2.53.0

