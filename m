Received: from mail-pf1-f225.google.com (mail-pf1-f225.google.com [209.85.210.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2B636A363
	for <virtualization@lists.linux.dev>; Mon, 28 Sep 2026 18:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790618561; cv=none; b=Q+o9d30yk/oIJdKXNbTTGklpAkCfzvToU2cI4+nOuvOGqCOM8Hfamk0wtPL0LpJnnWMIdfZ+qIThtKY9lh4pVvEA6uKoCPw3I+AlpcFINySW9Sr7HT32cwA66UKERFe1ceBnv0MmbGLuw5hVMSsb98xCOsIkPh8G2MNUna/KKUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790618561; c=relaxed/simple;
	bh=kjPzSgKukGJeOcNErrJKgTuGs69bRKEq8kMNgC1lM6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ty0OiidL2a/vFJzBT4hCOzbouBjMRHHe1tcdPxlvKGzrHsdFH7ARZ9F0HrU9XdPr88O6cScPanNyQW/nAGX8pWhBGBQqQNiMPID9LshStUU5w2g4xXbRlp2fqBP02rYof5rJ5P6tkKZV818dAucpBN2kumFYVfrnPJDXYOq4yZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=FoTPpAm1; arc=none smtp.client-ip=209.85.210.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="FoTPpAm1"
Received: by mail-pf1-f225.google.com with SMTP id d2e1a72fcca58-884062f32fdso352136b3a.2
        for <virtualization@lists.linux.dev>; Mon, 28 Sep 2026 11:02:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790618559; x=1791223359;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ejipg3r3UVU9vc4qrGUJPGiICgZ3Att93JZtQzMULZA=;
        b=bYk1fR57eimIfRC2Y2GAN2nH4cVFY+PDNSNkvPrBQvo0ubofQKr1QOWK0jHHqAei0s
         sggk2P5gtxWB+FL+r+VftmDsBamOmi40Bu6O5CfwSJIpxdlwhFX7B3R4CAyt8P0R8CMs
         DA3Opc5D36b1fbbJhw1+WaZX4b+vqQmRoqMKoO+vr5XukF1DwgNkzOKCDjfH9WhHgeuH
         uP5N+hHy6+nZSCmL+VA4fMBHyoJdFrVR85hR/ybkJik50yXkGuAqaC+jcvXkoJZBir77
         LoKABBOlTe62IpgEngFmCqtvIjtud27gdY+Z6i4//AndewFnOPUExkwfvX34IiYWjIpV
         y26g==
X-Forwarded-Encrypted: i=1; AKwUvByZqKDpTPMUDMpEtCDKml/u7/7KR/a8RXP+5IuJwBJC44b2/nUyh4qXqNPPhDdnGBoLG1rweorXZkjIjgC+pg==@lists.linux.dev
X-Gm-Message-State: AFuF++lXKWZE2wtDQ2H3FepGMsi1BkfgmoFhxCV60b7QOk4DZeQomvTE
	BWe9QTCkxTBvidMeHZQJW5CePHpfiESYBiGZt277pAnIRlTJgzbDOb9oimirqE48xdxJd6DDQ4H
	prtibWXaLs4SFB4nFpXRpikM2HajMIduLKx8X67C4liSDQgxiWie0Me9RwPDnKthZkmSij/BfUa
	KtP8TYvlSf9kUPRtZefsFCjghGa5jTb6WIVOL3yKf+KwdY1TC2f+bK/2E0q0fzbIl/t4H46N/E2
	hTeZu9+DOYcIkuLdsQ=
X-Gm-Gg: AYBFou1GUhOxQx7X+pe1oeTUV3JVH4ahfEUdlWl+m7JjhtqGFoTERq1kA7MXXhuzLpv
	Rt+sumDbHCSxY+C9Rd1ic2ZzSXsij8uPb/B5n69k2ODTM01nxBJydK6KATzyCArNXYldQKhalZJ
	6kj3NqMtzNXtfrbaMMQM5xdMSmKSsA7HoYhBlwbCCoC3dP9AOBHfvhji8LUBAX/BSWhlR+cY4yL
	+MW4iIZsO5SWnobJuY2XNRKlKZRZlVMzGSKuC1kXrFfPa/TwjaowgVmwSGqq7LMmxzaSBlAuKn1
	CI5dvjb/ScKJ6ja/o3/Q7vySVojrvYv7pIM38WlPVrccs2ezn3jKCVRvYKXDzaBEFDcfHfd77HR
	0ohkrQq0hw8sAP4Ykjt9im0dbOvCcgLuLJroFqJCTKmK8JPYhFF52IjaEmgxkBYhWd9kB+6r8sU
	9aQUiK7xZ9Lw0SSjifD9nHEtTOwY2k75HSUwA=
X-Received: by 2002:a05:6a21:2c12:b0:3de:557e:5eac with SMTP id adf61e73a8af0-3de557e7ad3mr3944402637.31.1790618559087;
        Mon, 28 Sep 2026 11:02:39 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id 41be03b00d2f7-cc78773d268sm6721366a12.4.2026.09.28.11.02.38
        for <virtualization@lists.linux.dev>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Sep 2026 11:02:39 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-5cd0c08d264so3403904e0c.3
        for <virtualization@lists.linux.dev>; Mon, 28 Sep 2026 11:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1790618557; x=1791223357; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ejipg3r3UVU9vc4qrGUJPGiICgZ3Att93JZtQzMULZA=;
        b=FoTPpAm1W3azCZRaMGFwwTNuJCVJgFfnqc1Q743kSVT1dbDc8oTguegp1whDWjpTbf
         cIAq0SdZbqGR03Ef7xPKaVdrVFVCzj65Jh0ydHl9j4ythYmMUUwgx+62SmKEE8Ukbhdy
         kTiDxaokHfG80ajvSOxa9UKJo6sd/hrtTEp8Y=
X-Forwarded-Encrypted: i=1; AKwUvBwD9GDVZkB4fSau1Iq8Ut2hSyfZL1RihKqclqwZwR/iXf1PB4yh2N4ABWpcnkpPBdDuM4nEZxU97k8DsufmnQ==@lists.linux.dev
X-Received: by 2002:a05:7300:3e93:b0:340:f935:5fa with SMTP id 5a478bee46e88-3427384f956mr10866063eec.40.1790618169757;
        Mon, 28 Sep 2026 10:56:09 -0700 (PDT)
X-Received: by 2002:a05:7300:3e93:b0:340:f935:5fa with SMTP id 5a478bee46e88-3427384f956mr10865927eec.40.1790618167270;
        Mon, 28 Sep 2026 10:56:07 -0700 (PDT)
Received: from vertex.localdomain ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3421dbb2971sm26076069eec.10.2026.09.28.10.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 10:56:01 -0700 (PDT)
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
Subject: [PATCH v2 1/6] panic: Add a notifier chain for pre-kdump callbacks
Date: Mon, 28 Sep 2026 13:55:35 -0400
Message-ID: <81cb85568b36273a8e66215b3e6d671b8488d402.1790014793.git.zack.rusin@broadcom.com>
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

Selected crash callbacks should not require running every panic notifier
before kdump. Add a separate atomic chain with an at-most-once dispatch
helper, and invoke it before panic reaches the kmsg dumpers.

The helper permits another call from the crash path without repeating
callbacks or recursing into them. Document that callbacks may run in NMI
context, with other CPUs running and the kexec lock held.

Link: https://lore.kernel.org/r/aquttpMVKX8e6zGB@pathway.suse.cz
Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
---
New in v2: separate pre-kdump chain, with a set-once dispatch guard.

 include/linux/panic_notifier.h |  3 +++
 kernel/panic.c                 | 26 ++++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/include/linux/panic_notifier.h b/include/linux/panic_notifier.h
index 41e32483d7a7..3ad390764a41 100644
--- a/include/linux/panic_notifier.h
+++ b/include/linux/panic_notifier.h
@@ -6,6 +6,9 @@
 #include <linux/types.h>
 
 extern struct atomic_notifier_head panic_notifier_list;
+extern struct atomic_notifier_head panic_pre_kdump_list;
+
+void panic_notify_pre_kdump(char *msg);
 
 extern bool crash_kexec_post_notifiers;
 
diff --git a/kernel/panic.c b/kernel/panic.c
index 213725b612aa..d78e90abb192 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -82,6 +82,10 @@ ATOMIC_NOTIFIER_HEAD(panic_notifier_list);
 
 EXPORT_SYMBOL(panic_notifier_list);
 
+struct atomic_notifier_head panic_pre_kdump_list =
+	ATOMIC_NOTIFIER_INIT(panic_pre_kdump_list);
+EXPORT_SYMBOL_GPL(panic_pre_kdump_list);
+
 static void panic_print_deprecated(void)
 {
 	pr_info_once("Kernel: The 'panic_print' parameter is now deprecated. Please use 'panic_sys_info' and 'panic_console_replay' instead.\n");
@@ -567,6 +571,27 @@ static void panic_other_cpus_shutdown(bool crash_kexec)
 		crash_smp_send_stop();
 }
 
+/**
+ * panic_notify_pre_kdump - invoke selected callbacks before kdump
+ * @msg: Panic message, or NULL for direct crash-kexec entry
+ *
+ * Dispatch at most once per boot, including recursive entry. Callbacks run
+ * with interrupts disabled, possibly in NMI context, before other CPUs have
+ * necessarily stopped. The kexec lock may be held. They must not sleep,
+ * allocate, wait for other CPUs, or call into kexec management operations.
+ * The message is read-only and may only be used during the callback.
+ */
+void panic_notify_pre_kdump(char *msg)
+{
+	static atomic_t started = ATOMIC_INIT(0);
+	unsigned long flags;
+
+	local_irq_save(flags);
+	if (!atomic_xchg(&started, 1))
+		atomic_notifier_call_chain(&panic_pre_kdump_list, 0, msg);
+	local_irq_restore(flags);
+}
+
 /**
  * vpanic - halt the system
  * @fmt: The text string to print
@@ -682,6 +707,7 @@ void vpanic(const char *fmt, va_list args)
 
 	sys_info(panic_print);
 
+	panic_notify_pre_kdump(buf);
 	kmsg_dump_desc(KMSG_DUMP_PANIC, buf);
 
 	/*
