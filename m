Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.225
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794203294;
	b=1TgLtEbvnsRS8Hh/erx9mzEro0cwRyalzpzyV92ddvW8dQrIUr96SeBkUTe96mbJ7U4P
	 tr3ZTOT6gF3zns+zyvoQ1kruAahh0mSsIvYt8CdXrsKgFGk6iQkQc1Qz84c0Me79c7Ur9
	 Uq84VNOFC4vHrsD82knVfUSWiwzXd6WS6Ah2B5AXFWvm7dMkSI/CETOlHSqt3TNukB+0K
	 tmO0qOm6w+5WpVHEcsvHtIDs+VGHNCXYvKIKWF6Wu8YMk6Gz/0MQI2T3rv1qoaDil3d9Z
	 8iZxTF19oVyNCV9lup2p6aMlgiNBtXnmbBU7/hLN/W6am7mxNfL4ycJ6vfKAuwNdCRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794203294;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=gWw97lsSXhpRitO5f1gnEdnOwIiPfae0nOjP6jdEUEo=;
	b=dHpzh7GV1P4QewTurh7cBCONhtLfqhrRWoxItTM3o4f9ihnu0d41aKoMCPxOfCVKJ+wu
	 T1T+pYZEYn7iPPlO94jaeS7hvoKHmpSP3S25FCwXSd8vqyeW/Lbbuq0PPEbbx8fsEiUof
	 h9zp+Ija5jGccYOtg0pCPXXvBmrl/w7bDTdgFSbgJbVuvgDYm+rpHrIxknKVPs63WHJ+U
	 l6Ew9FpiqRSqhPbq6hB5PH3ALjHV/4I9XnulTNvatfe19vMCrn0sQRA5112HAoeJfYM0B
	 vJs+BuYobXTWTj50tHpcAOAS17hT+2ZoxZOOUd1Myc96BcRXy/WIEK8NoRiOpdXDZEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=Rwa2iyrw;
	arc=none smtp.remote-ip=209.85.215.225
Received: from mail-pg1-f225.google.com (mail-pg1-f225.google.com [209.85.215.225])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F53606A323
	for <virtualization@lists.linux.dev>; Mon,  9 Nov 2026 05:48:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 04F53606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=Rwa2iyrw
Received: by mail-pg1-f225.google.com with SMTP id 41be03b00d2f7-cc758830601so261037a12.2
        for <virtualization@lists.linux.dev>; Sun, 08 Nov 2026 21:48:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794203293; x=1794808093;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gWw97lsSXhpRitO5f1gnEdnOwIiPfae0nOjP6jdEUEo=;
        b=deFEMDGTFvD8Qnf00HQ5KsJZ6z+tXKbEOpGBraCbkk2WUHPGeXMLm+/DEFEQyrxYcy
         uELPHTC8ngZha16IYDS4XJYD7E1yNV89VhHtVC2LqUtjZTCOIvIVb9FFxaD5fIyDht11
         rIVDMAMxhdZ9ep7uDyA41PCpAjboXETH6sW5s9i93yQE1Y0Xv/o55WbJ/XbLO2qIyaKA
         Joc1vK+Tvz6QOX9GbnUQofsJqdsoNcrComm0dtght6r2hdcMmsU0PcOZvDCuCKzmbJmx
         ZG8Ey6k/MWTrBEQywxUy7O925AFPfsyab+1YXFmlLmP1vbwKrGPA2WfCfdxBVUr1ZVOf
         NxWw==
X-Forwarded-Encrypted: i=1; AL+hErHtMq51b07rropjTiS0eKkjsvgFmDQyLBRK9qUCiYBMxoH8eKRuB9KzdhsFOGx4BXtF7GCsMERyyg/eiODKOg==@lists.linux.dev
X-Gm-Message-State: APuU4Z+uzVV05zh/9F9tZuqm4I3Pq94Sm2VXJ6mBoaOxXhsUkVg6gvi7
	0XCnxpE0mG9kEOu7ymmHUH8V9rkXPNxzD/AAnFcxtgE+wDDd2Fof1u2edHheH7e/6+lGfv0jlr3
	6Yf24HZ0HmlchdLaYzGXJY0RN/TvabBWPIKXOZ7gCqmsmsG5C6VD8W642oxyygkkM9A/KSRYzC8
	nyeC/jG8s8ul1jLYQohdmeamLrjpAWNa2ZUx4FypgfVwisMaBqyv3sU4miu/GF4s+sZZ1Q3NorY
	Ee0s244sv+BgdU1l5s=
X-Gm-Gg: AYBFou2nNzLT8zMsU2L5VVw0dBruSWqsS9DJMKqgJVCTxlpKFh2wMnr0K0EcKxaA/6g
	fimKcP03Xi3j+/Dw78u8MNlHzrTk0H+0xtLyFOJ+Je9C3kRgX60sfbC6NcSnSY8zHKnv/dTmLAJ
	E+aWrC0nqzvMosJB7ClOiLQOzeh+mn9btP7zJKLE0BxjeWEpM3fIPZ8cL0wGMnMHoMZXIQ63W51
	zswgOhqoB11nFJChziQXdsc/fTCC3iVbPghqI2qdCyxYu+Lye7iyyEkclmor7NMTDv9XLISr4yv
	bjvPhx8Xh/7Q6UJyA69uUcyjomAOquQne00ZQVgY0azDpNv37IhxwD8TOQYsQVfP4/4Gr7N4FPM
	jkCwRxScBIPcS0601DyXcXsu3mNFcu4zifIIHmqPVTxZO5FJfyFmAZ3eO4TmMqC9AyfNKAp2gQK
	9y8r8Xd2XlyPLKSFAVBVLhWL3sNwDVPCYr
X-Received: by 2002:a17:90b:1b02:b0:3ac:adce:60be with SMTP id 98e67ed59e1d1-3b12d3c74a2mr3207003a91.21.1794203293284;
        Sun, 08 Nov 2026 21:48:13 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-13.dlp.protect.broadcom.com. [144.49.247.13])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b103458b19sm2438713a91.4.2026.11.08.21.48.12
        for <virtualization@lists.linux.dev>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Nov 2026 21:48:13 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-154e9d2d94fso414137c88.0
        for <virtualization@lists.linux.dev>; Sun, 08 Nov 2026 21:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1794203291; x=1794808091; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gWw97lsSXhpRitO5f1gnEdnOwIiPfae0nOjP6jdEUEo=;
        b=Rwa2iyrw5CIS0c8ImHqxhfT/LFBALgEL6H72+Dljn0mV4WEFh7zl4iavmXW/9XUg5y
         Eu5TYQM3mQvGpqlKDGZ29yb7kTrnLPKNbFIWa4QhhpowhDk+DoQZiGGgxOP8yweJnYeC
         DLqbmy294WFccpJQ2t9iDQOn5Q/DKlbdo+094=
X-Forwarded-Encrypted: i=1; AL+hErEDuyne+63PSUQP9yq/sLItML/OuOpsIlOvFFEvMpIMR3UcTuc8IbkxT3QembGdKuYmQ9b7zf7KdQtqDNMTvg==@lists.linux.dev
X-Received: by 2002:a05:7022:b052:20b0:1ae:abd0:e2b6 with SMTP id a92af1059eb24-1b39ff033c5mr5293814c88.38.1794203291171;
        Sun, 08 Nov 2026 21:48:11 -0800 (PST)
X-Received: by 2002:a05:7022:b052:20b0:1ae:abd0:e2b6 with SMTP id a92af1059eb24-1b39ff033c5mr5293760c88.38.1794203290476;
        Sun, 08 Nov 2026 21:48:10 -0800 (PST)
Received: from vertex.localdomain (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b37314626dsm13745136c88.1.2026.11.08.21.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 21:48:09 -0800 (PST)
From: Zack Rusin <zack.rusin@broadcom.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Petr Mladek <pmladek@suse.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Dave Young <ruirui.yang@linux.dev>
Cc: Borislav Petkov <bp@alien8.de>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	x86@kernel.org,
	Joel Granados <joel.granados@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	virtualization@lists.linux.dev,
	bcm-kernel-feedback-list@broadcom.com,
	linux-kernel@vger.kernel.org,
	John Ogness <john.ogness@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Kees Cook <kees@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Bo Gan <bo.gan@broadcom.com>,
	Brennan Lamoreaux <brennan.lamoreaux@broadcom.com>,
	kexec@lists.infradead.org,
	linux-doc@vger.kernel.org,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Maaz Mombasawala <maaz.mombasawala@broadcom.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Stephen Brennan <stephen.s.brennan@oracle.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Ian Forbes <ian.forbes@broadcom.com>,
	Bradley Morgan <brads@mainlining.org>
Subject: [PATCH v3 4/4] x86/vmware: Report guest crashes after kmsg dumpers
Date: Mon,  9 Nov 2026 00:47:40 -0500
Message-ID: <4dc02120a69e0d4b21f1ea3a12b4aedf6f22e706.1794201807.git.zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1794201807.git.zack.rusin@broadcom.com>
References: <cover.1794201807.git.zack.rusin@broadcom.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

VMware accepts a structured guest-crash event, but a host configured with
backdoor.coredumpOnCrash may terminate the VM before the hypercall
returns. Keep this event separate from the log sender, which runs
earlier in panic.

Register a panic-only kmsg dumper with late_initcall_sync(), after built-in
dumpers registered by then. Skip the event while a crash kernel is loaded
so the host cannot terminate the guest before kdump saves its vmcore.

Issue the event at most once. With CONFIG_PRINTK=n, use a late INT_MIN
panic notifier. An unexpected dumper registration failure with printk
enabled leaves reporting disabled rather than overtaking working dumpers.

Link: https://lore.kernel.org/r/20260309235250.2611115-4-alexey.makhalov@broadcom.com
Co-developed-by: Brennan Lamoreaux <brennan.lamoreaux@broadcom.com>
Signed-off-by: Brennan Lamoreaux <brennan.lamoreaux@broadcom.com>
Co-developed-by: Alexey Makhalov <alexey.makhalov@broadcom.com>
Signed-off-by: Alexey Makhalov <alexey.makhalov@broadcom.com>
Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
---
v3: Rebase. No code change from v2.

 arch/x86/include/asm/vmware.h |  1 +
 arch/x86/kernel/cpu/vmware.c  | 62 +++++++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+)

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
index 8c8b6dd7c3e8..ead9f50cf89e 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -22,9 +22,12 @@
  */
 
 #include <linux/dmi.h>
+#include <linux/atomic.h>
+#include <linux/crash_core.h>
 #include <linux/init.h>
 #include <linux/export.h>
 #include <linux/kmsg_dump.h>
+#include <linux/limits.h>
 #include <linux/mm.h>
 #include <linux/panic_notifier.h>
 #include <linux/clocksource.h>
@@ -330,6 +333,65 @@ static int __init vmware_panic_log_init(void)
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
