Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.226
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794981736;
	b=wweUPuwoboox67C0QTz+KfrVXUAySd1aQsG81PZe4Vmt2ABCNoZYWTyXEftpksH7au9X
	 iffcECAnC0duwhxoyD108tBKnAzkdzTz5VEBiIoXtW5zNb3lIS9i8OFSQ8c1ANVDy0x2R
	 YzTwKeiSwLZx9JagggEI5MagZW4eE4V4gDJXS05gxMR41TIRZA+JXud1SmCnUWggC8HGl
	 V/iQ1sbzCWXFo4GqL3+twKPUGifjF1bnS5k44glHDSGUi60XSb5QA12xQUWSDavKIo50c
	 szZXQYNfKKe8+AN7N91DPIK7oM3MUBV6GZCslW51iG9k/B0HDCXM3zwkXuN5AIhi6bg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794981736;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=I0NMn6fHPSVKHVHVNpMiE+ggLiJC/6XmQS3TcCioiGQ=;
	b=0RlEfLTvGWuF/vN/kLJdIDFn5Net1t7d5B3Kbs7Q6qRSK750NtQQ2y0qK76Id+4FLA84
	 D7UggCY9ATBD5UXuD9Vkn+e2+X5aX2VG5MF7hZrrs700csBm/L8C2VJ8YYxzQdzrMXkuG
	 mxw/d3VxDLO+3N48CEhHQq1nV4Ccv4Xif+ufjxVnYXT/DoReppcT0Sa6t1VsnHE9z+dWl
	 ACslLxL09R4IJ27Uw+sOsP0QAr+vlfcv4PqLO1gEws9/JX0IiMX0oj8pMvfWB6Kcf69BE
	 MLYvZvz6s9sxCacE7CXUie1oeK+Qyf+ynpowjU5U5VCsj8wdqChEFYPLJrUagb53qjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=f4gnWoAA;
	arc=none smtp.remote-ip=209.85.215.226
Received: from mail-pg1-f226.google.com (mail-pg1-f226.google.com [209.85.215.226])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70CE606A32F
	for <virtualization@lists.linux.dev>; Wed, 18 Nov 2026 06:02:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A70CE606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=f4gnWoAA
Received: by mail-pg1-f226.google.com with SMTP id 41be03b00d2f7-cdab938dc83so337809a12.3
        for <virtualization@lists.linux.dev>; Tue, 17 Nov 2026 22:02:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794981735; x=1795586535;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I0NMn6fHPSVKHVHVNpMiE+ggLiJC/6XmQS3TcCioiGQ=;
        b=d+zsvIKHYALSBD2o8R41fhnj3Lfd2ehZzuccUS3ZgxbffT4ltjIhOtuiIih0VIcWC4
         05RyVQahAjDWEIx6okqOoEW4lg0GV1ZOXzM/R29n380XZleGmg/d2DwTZO7WBPaPJ7zz
         VMnpBmT5w8Gx11Ec5h3EbWGvoCPsw/jT8MC77FxWwiaUxck9qy6k1ffZRRQOsm87LGZl
         8grJCJ2dsljhCEM+60ACKze6LoZXfRHwLTfg5qLO9vXCs+PVu78rrV701hRRe5n/AC2y
         konABEBal6eiYJvTDs3OP4XgQp+jgZNhzzeXpZeeXli77XDXvsWa9ri3/Nfod0WgXWA8
         dOOw==
X-Forwarded-Encrypted: i=1; AL+hErESHhm2iIIGB8POFDDHQkXKvSjeVZjl0nUzV1OWT8bS3fYPc+Pz3w6imqw/E5vTXaMvoNliom5LcLrDG2wFTQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z+dZNqqdgeDM/G+h7sGxXowZRr1w2mLlzNxlDwDaejuXgme7VCC
	XHicve0+AhtUkPcnwiukU7rlDeyxeibsEUxUZsDSZcqLnfxHe8oIEvgwiHcnGhxSMKk4HW+LX17
	aYjd6gYS9mlHX0ELtuygLYEjgwTfpSD2Hd1oRM/EoGSI8giLkqfQuAN5iZQ36EYcS8zVgSjY/mg
	0GvGhyks+y/YkBTud5h4iRX/su5lX0dss5JUxwExqRnNzyE993xLmHErn/fZPfgQ6FoE2bEpTj4
	tczg8kCg68ZDXUJeYw=
X-Gm-Gg: AZFdTZdIVYLDKDN2chlUt2NsoNnQEjv+uFAUt4QAiEC8wgoOuzAyIYXrPjOv+1elyoM
	qnyLHnOSE6O8UHmfn5xojplYSKK+BHdBtaKLvVsQDnX0asCsKWzrR2xla79Yq8tLU/66qMtw9f+
	mdtaTSD5n8P5vCeCDWvBhEE6hkzG0VUSOGk7myWLBVz+tHrnakfLS4pxGd32FSnVJw9uVGwF8mj
	j/w7bB7ArJdiDxByv1RYWgiKXTHMTXhq+dAi6GFHNEXyaFIx/gHZQ5cYyekZUWyAL/BkUf/A4EW
	02PT49qg6SRK6/mivj/NThNEuWYaj4vr0XkbZ4cpuM+ufpWykVlHrCYps28QWoPTv2PP0jiegtS
	ddf9Ok8w0tIPvPzww7fSh1a9ErOq9M9J0vV14rLbY72pTAB2/wx5nWb0nIW/nq5xVPpdujEk6xc
	nUJDvZk8O59xaKAjmg/yk4UUNGJSjM1TK1
X-Received: by 2002:a17:90b:448e:b0:3ac:a1c7:20fd with SMTP id 98e67ed59e1d1-3b3d06a142amr1590827a91.4.1794981734942;
        Tue, 17 Nov 2026 22:02:14 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b3d435442csm407467a91.4.2026.11.17.22.02.13
        for <virtualization@lists.linux.dev>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Nov 2026 22:02:14 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-55d2bde4c78so10597311cf.1
        for <virtualization@lists.linux.dev>; Tue, 17 Nov 2026 22:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1794981733; x=1795586533; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=I0NMn6fHPSVKHVHVNpMiE+ggLiJC/6XmQS3TcCioiGQ=;
        b=f4gnWoAAS7H0k9lAUpmrwXEeeZRCQ8iTOqgHaklmRPwMo8H9qRxgI9GR/pf3y1noRQ
         8EYuXRzPUKyAcyCvXXKaHR8W93cwrYgrJzNVlEhBQ4tjEmv7TZeBl5tCqJQtZB0/138r
         dnQz60F5OyDOWRzDsmDYzgklh8A8D9zrW1uhc=
X-Forwarded-Encrypted: i=1; AL+hErENaGe6Wzw71wdHi9K/73W3L9d8VlYhyhbG+PEbDkG80gQNxatayrZzLQfBYQJlAv0XRPmu5EvN/gpAXj4E4w==@lists.linux.dev
X-Received: by 2002:a05:622a:551b:b0:55d:1944:a2b9 with SMTP id d75a77b69052e-55d5a5b7756mr24482331cf.51.1794981733054;
        Tue, 17 Nov 2026 22:02:13 -0800 (PST)
X-Received: by 2002:a05:622a:551b:b0:55d:1944:a2b9 with SMTP id d75a77b69052e-55d5a5b7756mr24481831cf.51.1794981732440;
        Tue, 17 Nov 2026 22:02:12 -0800 (PST)
Received: from vertex.localdomain (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d58ff0065sm14886841cf.5.2026.11.17.22.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 22:02:10 -0800 (PST)
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
Subject: [PATCH v4 4/4] x86/vmware: Report guest crashes after kmsg dumpers
Date: Wed, 18 Nov 2026 01:01:51 -0500
Message-ID: <d0f9c1188b5f78bb20bb43737b3cf80c5c0f94f4.1794980455.git.zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1794980455.git.zack.rusin@broadcom.com>
References: <cover.1794980455.git.zack.rusin@broadcom.com>
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
v4: No change.

v3: Rebase. No code change from v2.

 arch/x86/include/asm/vmware.h |  1 +
 arch/x86/kernel/cpu/vmware.c  | 62 +++++++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+)

diff --git a/arch/x86/include/asm/vmware.h b/arch/x86/include/asm/vmware.h
index dc3cf8123914..6d3c9922c92b 100644
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
