Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.97
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794982039;
	b=AV2lyVPYhDp3jLNlNmd8Euv5bIGNySSW+Mu6521fXikh2EwV1YvDnQxUznPiLTOYvRnb
	 LZqoN2XU3UWHaoq7ZdduyQSXZjIa1GJjNW6WZV5PvEuiQat8D+uKAfBLruG9ccLkqTxzw
	 xysa1uyTAQ37XCrra44nqT4J7EFQOzv9XEYXUqqytg5jqdvR5GDWE4q1VRBfEAradRpHf
	 Mm+0cjUk6SI0uyyIO9c9vsLdVxtlgFa1SSsjydflTetipW+sqxMXQTR7sam6CUGOV6GW+
	 Loe7Zh/4f54HbhBp0KXZdU0dMMYPDzsleCqcvXzX1BotHrNhHM53FhtCjton6Bk5yoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794982039;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=hDAVKUxd5qtHRxyEIWChofvlPqSC6zajAOsizwKxViY=;
	b=pVR4aD27CDrFk7erllaMdRqWyK5E3INALSRDx11r5YDpyvdGKLnBZNUVuDCzFgjK+ScR
	 bi0s/uVkAXqRL9wD8ZaoOxbiG6ABe+rH1TkNGVeH1EMOhtVPEcIsHZlgSkL4knnSoxFc7
	 hkBcoIyhFMKQ6Nn52t+rLD0kQMisqYmEMDWvMJ+NpObZRzVtXrE2pGqyNQbQyQ9SuHYfF
	 tF7Y2oeI5Gf9nbo0Iok12scvwYB7y0T5FZjEgXIWzJozK0D7N0Lk3P+3GCP/dBI17O4HU
	 0KLNF5NCsZnfz6oyiTO8Lg8qVMpIrWpp7PqOI/tYkKeUy8g5p6LOrZD2Q0t4ZhPkSmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=Bb4S+sX2;
	arc=none smtp.remote-ip=209.85.216.97
Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com [209.85.216.97])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22FF606A338
	for <virtualization@lists.linux.dev>; Wed, 18 Nov 2026 06:07:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E22FF606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=Bb4S+sX2
Received: by mail-pj1-f97.google.com with SMTP id 98e67ed59e1d1-3b3be948e60so303615a91.3
        for <virtualization@lists.linux.dev>; Tue, 17 Nov 2026 22:07:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794982038; x=1795586838;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hDAVKUxd5qtHRxyEIWChofvlPqSC6zajAOsizwKxViY=;
        b=EpeWuUoI8Ih+6Bs1l52+6ssXeNfYr/h2E0vPElLK0QpfYE6IIh52yrjBgVDRmlF2Ek
         RnL4q9NentgH8l/ivClEKs2mCccwcQwkabiIwRF4r8hqL1Z+3XhsqNkj101Tr4V3NGjK
         HbQtMfaSmgffJXhrwSBh7MVTkbsbqyXbeitH0/CHggavAdRpnoeF5cpiWSVGfli+CEqA
         dUi8jlRvSbwAKdqJWj3EXcH5SNP/zbJBLOMVWCrMuNmAsLvg85kKR1qVgi3DygXDdFFo
         VsBj3nCKzKAkar6jC1yWLThePN1sZ0dJFsr9TOvnAYVrBBxueqwCK5/Vd0zzE3ELAruc
         vZBA==
X-Forwarded-Encrypted: i=1; AL+hErEZfLlAIfrV86l036Gi4LCxNisNN1EikXPSel5Wv47kZmq8sIM1N3hGGzIbHXrNtVAIgDLoEuV7mcQUTgsskg==@lists.linux.dev
X-Gm-Message-State: APuU4Z+o7DqOJ6g+PZS2Fl6x9fFlHkFKhb81sJ91jlvzywZNq5UXQWS/
	QCaYirq7fV5lmY2uMzrzat0L3kVo3jKr+hxGP2sc0C9pF6Rl5nYJmoQDT8J3Fpr0DgBTR3ofAtu
	6dbf4s9YhCn3tqJE+g01ueoaPkmAmiaWp1LEHLeygaTLIIFlZFSefDn9VNFWz/6opYZdgKEvFGu
	oFZSpOkTjZ6abaFkEIEWQ/i6rtJwMD6ixvNj8rHTZvqsD9xDxwUivc2ROLtXYCWYeO8cdcSLgzb
	XcbAtAsHQJafdKFiII=
X-Gm-Gg: AZFdTZd2dBRrWmNH9cMJxlk9PKNpOGKPN6cr09p3f6DozFDLly8Mwm/JBf56E7BKZ02
	11CEn3UA7rCIrvq/Gx25lzEMran2aOX8NuEL6OyZP5Gb8VXkCx33hH/loJt9tNwBVxg4iKNl4tP
	a2Qw0rCzVnEpt6Qg7e2L8EYrnkjCzuBLlYeO2HHUuDSrEHs46lwU+FwY49XKxV34MxgiTEd0Old
	8TQYzYDX5LVZJ4BnvnJtWDU8svJjeN8N2zAtMBde8dH4jCYjAX+m5PjLxUDFF/LKR/X4rx8JqE0
	I27LSCzqqrUeHNMCRgiA5bjfLYhXIWelk9KtxB+faCe+Jj9ApdiP/UNs/ynfw0+97bUXp8xAdEv
	5GJc4XOI9SvaeFvvg87woD+Kjv9OZL8u80yde2rXsK3GaXFyvaWNOfgJe1NlK47PdrNbZnLD4+N
	QUCLanXAG7LiZR3Ywc0UpRjlHXhS4PPMuH7VY=
X-Received: by 2002:a17:90b:39c5:b0:3a7:8350:3f7e with SMTP id 98e67ed59e1d1-3b3d07c9a75mr1978150a91.44.1794982038214;
        Tue, 17 Nov 2026 22:07:18 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-123.dlp.protect.broadcom.com. [144.49.247.123])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b3c050721csm2244858a91.4.2026.11.17.22.07.17
        for <virtualization@lists.linux.dev>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Nov 2026 22:07:18 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-92105a68062so13688596d6.3
        for <virtualization@lists.linux.dev>; Tue, 17 Nov 2026 22:07:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1794982037; x=1795586837; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hDAVKUxd5qtHRxyEIWChofvlPqSC6zajAOsizwKxViY=;
        b=Bb4S+sX2QImkCrGjw+q7X0f9hU7txfA5k2Py/b66L/lz1ZwTdQ5U8/xYriO3Nhq1g1
         6Uraph0U2GBM8YgvLHBBLfuHTKZ9jykNYCresWhIRCyIRKSGAupTfKj0kwpvjtkJL/VB
         DLrF8Eip0EiwLOfqOlAQ+voILFVbLr+0YBzbM=
X-Forwarded-Encrypted: i=1; AL+hErH1KdO2LHrV6XtVMLVBOU9G6mDnnjV/2KtF6O4mYDtn6NvDCbeH8cwFQ9dvCsjOfVgYnMjo0qEdcfzFnVo+ng==@lists.linux.dev
X-Received: by 2002:a05:622a:50e:b0:55b:8632:6d42 with SMTP id d75a77b69052e-55d5a539184mr26035491cf.23.1794981730227;
        Tue, 17 Nov 2026 22:02:10 -0800 (PST)
X-Received: by 2002:a05:622a:50e:b0:55b:8632:6d42 with SMTP id d75a77b69052e-55d5a539184mr26035081cf.23.1794981729786;
        Tue, 17 Nov 2026 22:02:09 -0800 (PST)
Received: from vertex.localdomain (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d58ff0065sm14886841cf.5.2026.11.17.22.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 22:02:05 -0800 (PST)
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
Subject: [PATCH v4 3/4] x86/vmware: Add the vmware_record_panic_msg sysctl
Date: Wed, 18 Nov 2026 01:01:50 -0500
Message-ID: <4c5de34b10f579368b890eaa9333a2755886bad3.1794980455.git.zack.rusin@broadcom.com>
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

Allow administrators to disable host log transfer on ordinary guests or
opt in on encrypted guests. Expose the boolean recording policy through
kernel.vmware_record_panic_msg using proc_dobool(), as Joel suggested.
Zero disables recording, nonzero integers enable it, and reads return
0 or 1.

Register the sysctl only after the logger is ready. A registration failure
leaves the internal default in force. Document that the log is sent
before kdump, and that disable_panic_notifiers_platform_list also skips
it.

Link: https://lore.kernel.org/r/4e73yd2ofpdzl6rptzvd74no3hnyfblknoq7wzxlw7f3zjbz7c@srfabx6lsusj
Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
---
v4: No change.

v3: Document the platform list ordering and the disable switch, and fix
the short section-title underline reported by Sashiko. No code change
from v2.

 Documentation/admin-guide/sysctl/kernel.rst | 20 ++++++++++++++++++++
 arch/x86/kernel/cpu/vmware.c                | 15 +++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index 608055d7ccc4..be2d5aa52362 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -1680,6 +1680,26 @@ entry will default to 2 instead of 0.
 = =============================================================
 
 
+vmware_record_panic_msg
+=======================
+
+Controls whether kmsg data is written to the host's ``vmware.log`` on
+panic. This setting does not control the separate VMware guest-crash
+event. Writing zero disables recording; writing a nonzero integer
+enables it. Reads return 0 or 1.
+
+= ==============================================================
+0 Do not write kmsg data to ``vmware.log``. This is the default
+  for encrypted guests.
+1 Write kmsg data to ``vmware.log``. This is the default for
+  ordinary guests.
+= ==============================================================
+
+The data is written by a platform panic notifier: early in panic,
+before kdump, and also when a fatal oops enters kdump without a panic.
+Setting ``disable_panic_notifiers_platform_list`` skips it as well.
+
+
 warn_limit
 ==========
 
diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
index 0c6f7248a665..8c8b6dd7c3e8 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -33,6 +33,7 @@
 #include <linux/reboot.h>
 #include <linux/sizes.h>
 #include <linux/static_call.h>
+#include <linux/sysctl.h>
 #include <linux/wordpart.h>
 #include <linux/sched/cputime.h>
 #include <asm/div64.h>
@@ -260,6 +261,16 @@ static int vmware_log_rpc(const char *buffer, size_t length)
 static struct page *vmware_panic_page;
 static bool vmware_record_panic_msg;
 
+static const struct ctl_table vmware_panic_sysctls[] = {
+	{
+		.procname	= "vmware_record_panic_msg",
+		.data		= &vmware_record_panic_msg,
+		.maxlen		= sizeof(vmware_record_panic_msg),
+		.mode		= 0644,
+		.proc_handler	= proc_dobool,
+	},
+};
+
 static int vmware_panic_log_notify(struct notifier_block *nb,
 				   unsigned long action, void *data)
 {
@@ -311,6 +322,10 @@ static int __init vmware_panic_log_init(void)
 		vmware_panic_page = NULL;
 	}
 
+	if (vmware_panic_page && IS_ENABLED(CONFIG_SYSCTL) &&
+	    !register_sysctl("kernel", vmware_panic_sysctls))
+		pr_err("failed to register panic log sysctl\n");
+
 	return 0;
 }
 early_initcall(vmware_panic_log_init);
