Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.227
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794203289;
	b=Cn8OVSHIG0NjSvWH1mL4DFlXpzlK85Bx2DRNtsGnrv+hzEcYjK6NY89Yb+UbGsQyjjYC
	 f85f2X2BrTFx8wK9/KYs9Dl8xLTluArtfiTm384XvxyvJx1pymSdb7WCt/J4s0onrHoGx
	 Sqp318NobEhFH0Mcu+4tc0y5DA8mpOm5CBg74Y/ppH/WzoepwTGz4A6wvvz4/5hGIt2Yo
	 nhfywm0EtBDGsCZQFK0ho/fzqMemC6ywT4qnnwoTOBiHTkdja97al9fUTiMAnbHKpw5en
	 JjG6UjxGFXPD9CjeETFoRlhJQW4ZeklrO33gW0pgucpTmw+/B+B9pYY/F+bllek3K6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794203289;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=JGC1OZer+fxOvlxCzlIKJtRbCmUbw0UPR8fUshisWB0=;
	b=sMtWZRhDpnp4DOSdZwmb4rvEI0N6bCXBD3fuVwB023fUSihm8jqwpbW0+adSZqNkCdbF
	 JzYovv9Dxbwn2ddSi9NOrXZ/2MPmcZKz5ZK8gQU8+zKLtQnBHfVgqBv7bO3Htz4lQ97zg
	 OkkTZLHgL9E5e/TAg1k57L8byQPrWbPY1hWacJhvwleE/Ftad2oThk3/or7+3QPxCU5Es
	 dZ6ULgSwf5p5L1PM0ScBQswd7wslZEkh+hN1J+Y3cnJRtQB27t5sttrNjUhhBf/sZO3ol
	 0t+KVAHArE2XwbhFHhHMomR/F7jpdQ4cHA+n+fDA3anveo956WCjH3Oj1uaXy/rGEpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=IUlf+PUr;
	arc=none smtp.remote-ip=209.85.215.227
Received: from mail-pg1-f227.google.com (mail-pg1-f227.google.com [209.85.215.227])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B39606A331
	for <virtualization@lists.linux.dev>; Mon,  9 Nov 2026 05:48:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0B39606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=IUlf+PUr
Received: by mail-pg1-f227.google.com with SMTP id 41be03b00d2f7-cd6a7b62ce8so126737a12.0
        for <virtualization@lists.linux.dev>; Sun, 08 Nov 2026 21:48:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794203288; x=1794808088;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JGC1OZer+fxOvlxCzlIKJtRbCmUbw0UPR8fUshisWB0=;
        b=2UgzjC+SQTwLCisFnPviph6pNLf57zJGgU48vN6iawqX674nIS0xL/CRNuHPe/NZSs
         6f1uzFQpm5dO6jNfadXkoGi47iRq40sFKowBrdckewh7V0bbCu2RHC7SsoJ91Qu3RwIs
         a2dbuqGGb9GqNrBSE4WgpJ3dZlTf/3X/hP61B2vucoau2EkwcaGxlf/SbVho166/0lcV
         ub9/0cMNIi3izYmyTPpmFDPY7QrYIhXg7n+myJz4DAIcJCQ0Q4Sz+lHe2o0I+qJ0D2K0
         NFeNZhXHJ980ilhQcM2Bc6BanD5wv3GPSi+sASAA+49YAhiGRONsznIlNI4GnAWjtXHq
         A3YQ==
X-Forwarded-Encrypted: i=1; AL+hErEo7E0EATEEzQlWgtlPhcp59I048m/TchrglF58UWrt6dhD9HOfzgEwD9RjD1cqrQs27/SD287VIhbTjnrNCQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z/SpmA760LJL02zhYcwk+CjE8tKJz2Cr28ypopOMBVeq1Y8Flxo
	n6QYO/hao4B69uDbkAT88d+VBQWqGxOGE+M5zIMLmKxPjLoZcbDUeJW29kZS/Y6x5wfZHvV/O3c
	VqTYl1O6wXII35GeQECoXSdSYaaa27l6V6jmNe+dN1m0mVfi6n91WquGh8IrUvDPC2RhmuQK4jb
	PSHwLBgkmyITk92vXIECuO4Yy+HJdqY/ThCvlFN+BNwpyFwKvxEEFJZHTVhH3QwQNcvIhWj4oKn
	vfV/TRiV2veLKYbUbM=
X-Gm-Gg: AYBFou0EbKaWZidGulNAuYwhG9u/QOSE+MOiHHoKDW+GSH9hxqF+8kgp5ohj7eyxe6J
	VNeZB9GogOj2fVKDwX+hDO79FhZYYTOnQfo9SN4fjNra2Vxluqf84smCAKAG+2fY24SxsDwGVyo
	WV+MhP596JA/FMTdm62/7JorzOJskzw0h1fLRkSnCjlm11YCoAbtDlpWlfarJaZATcrLIimM8UN
	VXia9fdXYSrMGHKVWeQPoDzPMJicFM0SXoSU/AJZ2z44DnOgxUvJCkOIiNioJ3YvUuKx67ELpiB
	xYvNlPY3TNV/PIuiunpgan1EnTc9WltkJrZKvZWTh9XN5Q1O/PuTslCau7IDD+7SfBs2QA0VrxV
	/qrL6AziINC2s/0HBQZ8Gsr5S2vab7yhxQ0tMaCBLHysQwJvqXgaYzA/3coTVqQW5Jd+CM5H4Tt
	orN+QTreI6sXx6UeUo4QxYCKjSL8YyWvbc
X-Received: by 2002:a17:90b:2547:b0:3ac:8897:7b9f with SMTP id 98e67ed59e1d1-3b12d41d92dmr2677191a91.43.1794203288025;
        Sun, 08 Nov 2026 21:48:08 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-17.dlp.protect.broadcom.com. [144.49.247.17])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b105934590sm5177319a91.8.2026.11.08.21.48.07
        for <virtualization@lists.linux.dev>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Nov 2026 21:48:08 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-1a71dd190b0so2292322c88.1
        for <virtualization@lists.linux.dev>; Sun, 08 Nov 2026 21:48:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1794203286; x=1794808086; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JGC1OZer+fxOvlxCzlIKJtRbCmUbw0UPR8fUshisWB0=;
        b=IUlf+PUr5G28X+078pK/hsVnldqTfC1Psbhf2oQMTXt9nrLzwJv9n1wzuvbRAWEBVY
         qHLpTQ7LSWN/xSlrz661U8MNEOOHMu/drwxPsDGEHV6IFgx+8vG2Tp2yf2dRpy/+cdNt
         kr04QtMtkBcijn8/YuOe68d84zvsuj2AFGZrI=
X-Forwarded-Encrypted: i=1; AL+hErEWtZ0o+VH+HLdoaiK/T3kKesTxRzz5OB24rqGOwxnM1diWJUraSWu4ZvBEClrO5RdJ9VfgpJxCFxA7MbieCw==@lists.linux.dev
X-Received: by 2002:a05:701a:844d:20b0:153:21e5:4328 with SMTP id a92af1059eb24-1b39fe9a93dmr4799621c88.17.1794203286136;
        Sun, 08 Nov 2026 21:48:06 -0800 (PST)
X-Received: by 2002:a05:701a:844d:20b0:153:21e5:4328 with SMTP id a92af1059eb24-1b39fe9a93dmr4799565c88.17.1794203285441;
        Sun, 08 Nov 2026 21:48:05 -0800 (PST)
Received: from vertex.localdomain (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b37314626dsm13745136c88.1.2026.11.08.21.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 21:48:04 -0800 (PST)
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
Subject: [PATCH v3 3/4] x86/vmware: Add the vmware_record_panic_msg sysctl
Date: Mon,  9 Nov 2026 00:47:39 -0500
Message-ID: <abaa78b64a6f975bae42d8ef523062e55554a28e.1794201807.git.zack.rusin@broadcom.com>
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
