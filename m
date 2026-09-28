Received: from mail-pj1-f99.google.com (mail-pj1-f99.google.com [209.85.216.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16A24EF124
	for <virtualization@lists.linux.dev>; Mon, 28 Sep 2026 17:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790618219; cv=none; b=iIzNhykJIW4v0UW5c30JFk2wb6BXT6VzkUaZ+uahXpHgJWD4Do/sEbeD2ulhcsmbzZEoLRtCGL/QeVjakKaluazVaOkDnmFkU88aiKXfR2hHNP6iFVAZ9mk3nl2gVK9x6fvHYt+t+UXMwsxdTX9X6uj+6utmCMk0xVPvuwiX+x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790618219; c=relaxed/simple;
	bh=CBv00AL3BTLNsUFe9tB6GyqcDTTDzgpUZMK43TlrJOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AA83PJ/1MpsM+C0z9b4DZIdM3kQQxNnKuxnpuc96eBqLnD/pS34OQRIUw7OYmWtB1/DNqsIzLsVFPsjKi1TuStENb7F7HyxhcceSClWSinkZfE7Zarqx4XAYZxaWzK/ttJ0rHq+bIy3Wfri/0O+ormst14XZDgBP36UgwyE31ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=PlNmfT+2; arc=none smtp.client-ip=209.85.216.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="PlNmfT+2"
Received: by mail-pj1-f99.google.com with SMTP id 98e67ed59e1d1-3a0af54af74so1758984a91.3
        for <virtualization@lists.linux.dev>; Mon, 28 Sep 2026 10:56:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790618217; x=1791223017;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yiEqvVPcujwO0jzo0ebX90rTLmO4XRBVQ6+xmjHfKA0=;
        b=bU1BMsncAPzdQ7FyFLKPKJygR8s/341BfEPcGYtMaV731mFtEjCOLm2yyNQDNA4aC9
         N/PWbt8ilDplZuIW2qhm/W4x11aPh1bHDHuJ6fGKG6P32+NxMcNFqiIXRQ4R7dJvDMYI
         vmIjL8MSUmFJbESHEoUiANmAMdglHqAAGA37GWOL5sA3cS+rH4Bce21duIhaEj9KTG2c
         xP9JcSpcKCm2fR5ogOIOT51IrDoVp0bBT2jyHnOzxyPJaQW8z3Gy+btDVrvavr7TQTdk
         tloXnSPH+MnWTyKmRzfZPK8Yoe7a5F3R/lGne5j7GqUbhkM7ylm/EsZ65ZMjS+MlA4BT
         ndlA==
X-Forwarded-Encrypted: i=1; AKwUvByfwduaWwfleQVycAKh8+CEWdsOzoGPwhT2lffDG9J0EpYSod1dN7p6vBqdstyVClpMaC9BenidUQxhDZxXfA==@lists.linux.dev
X-Gm-Message-State: AFq9FYIS4iemNnfaLzodrum8Mdci9ORTgaTTRY+3aFYnnLuP4jkoAwIW
	JaEQxQzr6/V/hJmdPUHdYor6HX1pFhp8O6Jg6IyAyKHaHAhYpiZojjDOOKGb05Cji9mADq27RrQ
	x4uKUYQzIOOgDz2yYPK/xffp9SzsyyHpnylNhDYBLky6RnE+7YFvXs0CYCO7u9/2WS9HkBH47mc
	jt9C2jh6p2cPqCviBNfaCf9mw7RPc7tx9ZebLbVJ8ls3GtRAYP89lw734StQpNox7/svRystFrN
	bUjS9WbbJv+PeZIHY4=
X-Gm-Gg: AYBFou2U9+MYIHWOkxclTHPH2uwegamE/ekOTYc+YJJZEDsVpgkoEnyCxH7XqvPsUPx
	cT10knKYqaaEut0g5t13+9U03Iqf80R5azT953v3m3Wi2JrmkDhyfiMnWzeekGx3iTiP0R4n2x8
	pmW0FlTJK9VQ+Iu7Q8x5HB+Q3QBVSQTQzHS2JmfP+7LKD7L7AnQS7o6sFDK055XK3gNzrNJRsDR
	q22k4GihB7t8qu08066QD3RSTfyHCkc5+YuuimtKaPwRzj5zOTVIy7WbY5+d4wawqJ5ToF6K8jB
	TF3n6os8M4RBOj8eU86DYS0J85TGjQ+5TFHWjLVVcYxcr7P1UO6mzkDezNU57GZ1YCGJrE/UXfa
	PC4NLCkSx1xsakIYpMoixGji5skSCzSwHQS1GI6rwKrxPRF4Q5DeuESltmVbW/tk6uDJ52CKGV/
	oTshezuSq/7biuMtrx3Q180fdTtPA0AD0s
X-Received: by 2002:a17:90a:ce:b0:3a0:4146:2955 with SMTP id 98e67ed59e1d1-3a0bb6596f3mr5588129a91.61.1790618217011;
        Mon, 28 Sep 2026 10:56:57 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3a4988c2959sm35660a91.1.2026.09.28.10.56.56
        for <virtualization@lists.linux.dev>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Sep 2026 10:56:56 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-341eff9e381so1957686eec.1
        for <virtualization@lists.linux.dev>; Mon, 28 Sep 2026 10:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1790618215; x=1791223015; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yiEqvVPcujwO0jzo0ebX90rTLmO4XRBVQ6+xmjHfKA0=;
        b=PlNmfT+2nikdIYUjmlojC4DrT7N2Mh5aVLU0CEHSykEMurbaXoGAQ/2LnqW8hRWYYP
         uLrVNGbLNyD0O1RIoyZMYuMENulPKIxRTX5p0hV3xRpL0iSEIYYvP+q9kz0FS7DzyqUN
         gZBxAFHVb+J0hlL+QThvzz4JoAYVnj19glEHQ=
X-Forwarded-Encrypted: i=1; AKwUvBzk2/62xiI2MQnBLzD5JGSGS8sGPCNEXMKC5A8Z/nl4PQG2yqFqvxcbeBYHiZdTyn/3aTG9XmMzisVb0Sg+ow==@lists.linux.dev
X-Received: by 2002:a05:7300:561c:b0:33c:343a:1045 with SMTP id 5a478bee46e88-342702bf61dmr9331303eec.10.1790618214819;
        Mon, 28 Sep 2026 10:56:54 -0700 (PDT)
X-Received: by 2002:a05:7300:561c:b0:33c:343a:1045 with SMTP id 5a478bee46e88-342702bf61dmr9331262eec.10.1790618214131;
        Mon, 28 Sep 2026 10:56:54 -0700 (PDT)
Received: from vertex.localdomain ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3421dbb2971sm26076069eec.10.2026.09.28.10.56.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 10:56:46 -0700 (PDT)
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
	Ian Forbes <ian.forbes@broadcom.com>
Subject: [PATCH v2 6/6] x86/vmware: Report guest crashes after kmsg dumpers
Date: Mon, 28 Sep 2026 13:55:40 -0400
Message-ID: <996d3ceefd98ed9a7c40508e6f62039ba5a15325.1790014793.git.zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1790014793.git.zack.rusin@broadcom.com>
References: <cover.1790014793.git.zack.rusin@broadcom.com>
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
returns. Keep this event separate from the pre-kdump log sender.

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
v2: keep the terminating event separate from the pre-kdump logger.
Maaz's v1 Reviewed-by is omitted for renewed review of the new ordering.

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
index 4b0e5b084c2c..70553da771c9 100644
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
