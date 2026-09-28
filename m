Received: from mail-ot1-f98.google.com (mail-ot1-f98.google.com [209.85.210.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F904E237D
	for <virtualization@lists.linux.dev>; Mon, 28 Sep 2026 17:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790618208; cv=none; b=eB9ma7ku6SFTpIbyaiVOTczrxoM8YHVRad8ySjg56IjWTmv2HBKkz/BJ6ZMPAR2Tk1sch/LEVUg68neB1TlU3EWZRUoK2A6GfZNtxv/kjnKH7ebuTRYUTl9eLymI0tPuSCIinPNfeRPA6PPVO10Wq0slSOQtXktVwNlwzo4NQiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790618208; c=relaxed/simple;
	bh=5aQuQm3bDSHDGXMaipi3sPWMnLQu2UOrACug29vYOto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hPFI5HTh9/PwBRn/TIWI/rg2SEX+Xvg7jF1pYvIe71VpeDCkOYnOa/Xx8n3kASOPRHcjwqjO6DIGuA3I0e1/Ijh9Uipa/N1nUywPguJarBaRKhCei5CD1CZr4NUFqehe7PFSNkzBdXrOrGYp2Jbc/VRBG1z3N9/jFGxAmdz1+II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Z4eaM4Fb; arc=none smtp.client-ip=209.85.210.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Z4eaM4Fb"
Received: by mail-ot1-f98.google.com with SMTP id 46e09a7af769-81666504c59so963864a34.2
        for <virtualization@lists.linux.dev>; Mon, 28 Sep 2026 10:56:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790618206; x=1791223006;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rTHP+RKFRTvsoz5ZQC0H2auzr0/LWHqaonCSO4TGaa4=;
        b=J/TWHbBXPS0L2Whf+tIucWlIKSKI3qR5WVsWttuCwKhyv08yB16MSKCq99owk98nO+
         6NPTJ4VlL7n3gPrlVRZNu2u4krjeOuYt3nXdNlqgYYlmYwfMr3O7r4ElqgDMdzYcIJcs
         0C8R8kCMjEjpsU57dxYe8n99QKdGd9JIRHMbGeRa+qNsOE8FsCvjgrDjqOan4AGzXAVM
         +i/ASVgy5rWDpfDtJmWaNXW+liKfZn5pIHiMwitUE6Uzox1+7fwSHMlVvYZmBFuqlMk5
         fIzUsfud8Qo8NKzHt/n/I6NTSOIMfVau2yQ4J1opsO+V3mQ9DWLEIk+dDe2vtEch47uh
         ZRiw==
X-Forwarded-Encrypted: i=1; AKwUvBw/fabgU59576UkRb2gc9xPkmviWm3/l0V8noQVqn8CNcJ2tuwsc27424as2F6hqkVMcX0ETvBIzRgoYUFFhA==@lists.linux.dev
X-Gm-Message-State: AFuF++ks1Ud73ah4h+FaBWioqh4viV1SVTslVlBYPhs8qdUbJ7gsw9uf
	cASqkkLNZ0vzrBZJiDbHFQd6RFIMk+9Ygbd4MS3wzmyUp5oeSuxMeSUPS5ll697ykU7z3EjJ6/d
	yM1EWQlBlLjeB0q9C4Wju7cXLloyC9hW5d02MdxCGZTo2cEK/ICpXqA8izJGvbJ8Ldg2eC8/30Z
	34kxvujj6rAwHw9AWtFwB87C2B//GiyMBwqVvVZdois3SDbdvLfUniSGb+eDB7qTHAB1VrC6eN3
	b+d0e8XwLmMkbHsn/g=
X-Gm-Gg: AYBFou3az0pg8T/5OvraS5edbCobT0xDGMTeleHl6bFoa+4lA/EBdMln9HVoCWjJGSU
	7sH15N7mo4jDJACG0qGoppmaG6CU4L62Dgb/MU0vSuCvj/qX7bWTO8A4Yj/hHYLuAnSs1nu3oy9
	1qyHNletzGI5JfanFOg44d9lXCSW6nXTFO2mCkrlM7nWUjoe6NNUXeC7SnexKVvswUlqf6mYl6P
	aOOmieHgxjeLl4JRxoL0xt1cYvj17fPvxrUKbsWlpxx3HElNIQbIVdwdkZFDKBvTYGTiMpLs0Km
	Hiki63mytb9SsQqE0evS68tyStUdaQh1+v2uJegBceWlo8EcKW8MCSIMyHe/E/69tF9mKbT8KnA
	ZyFW7QerzwuaUjk7m5pV7qjr3jj4zUPxnnHBgmCvnjY/0mvdmKPYg8CQ9eT2IlsMFbXedri54YU
	6RYXVeg0jaf0uy7JTXBiFEpaOKZiihyA24
X-Received: by 2002:a05:6830:3785:b0:80b:6c70:94b9 with SMTP id 46e09a7af769-81781d92f62mr13059145a34.19.1790618206183;
        Mon, 28 Sep 2026 10:56:46 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-18.dlp.protect.broadcom.com. [144.49.247.18])
        by smtp-relay.gmail.com with ESMTPS id 46e09a7af769-81d59011416sm622982a34.9.2026.09.28.10.56.45
        for <virtualization@lists.linux.dev>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Sep 2026 10:56:46 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-3437d0cc8c7so6739106eec.0
        for <virtualization@lists.linux.dev>; Mon, 28 Sep 2026 10:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1790618205; x=1791223005; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rTHP+RKFRTvsoz5ZQC0H2auzr0/LWHqaonCSO4TGaa4=;
        b=Z4eaM4Fb9IURiSxFcCtG3z+a0pOi8WpiuYzFqwpI3vyrxdTJrD/IV+TqNWa4wnsIC4
         MaSzLHcQLqZYgYrU4MSXNvJQuYndr4AhEmzrwSDSOYNXippJl1GVfUAiN0SxFdphez5V
         TmcDhVdHb7s4SrnJ2C2RhwLlo1sBigeIoa3yo=
X-Forwarded-Encrypted: i=1; AKwUvBxeWIqpcRdoObohczscLbNCA1e/PGeIjl1/MVO4uHAvU+EZO0vYU4+jnnvTTWj879bLGrawuvb5GFJu8OiB+A==@lists.linux.dev
X-Received: by 2002:a05:7301:1a02:b0:33e:84c3:a056 with SMTP id 5a478bee46e88-342710ae7bamr9978557eec.17.1790618203900;
        Mon, 28 Sep 2026 10:56:43 -0700 (PDT)
X-Received: by 2002:a05:7301:1a02:b0:33e:84c3:a056 with SMTP id 5a478bee46e88-342710ae7bamr9978508eec.17.1790618203106;
        Mon, 28 Sep 2026 10:56:43 -0700 (PDT)
Received: from vertex.localdomain ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3421dbb2971sm26076069eec.10.2026.09.28.10.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 10:56:34 -0700 (PDT)
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
Subject: [PATCH v2 5/6] x86/vmware: Add the vmware_record_panic_msg sysctl
Date: Mon, 28 Sep 2026 13:55:39 -0400
Message-ID: <269888613b5dc16d19899b2c87c5ecdfd2610e8d.1790014793.git.zack.rusin@broadcom.com>
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

Allow administrators to disable host log transfer on ordinary guests or
opt in on encrypted guests. Expose the boolean recording policy through
kernel.vmware_record_panic_msg using proc_dobool(), as Joel suggested.
Zero disables recording, nonzero integers enable it, and reads return
0 or 1.

Register the sysctl only after the logger is ready. A registration failure
leaves the internal default in force. Document that disabling the old
post-notifier ordering does not disable this independent logger.

Link: https://lore.kernel.org/r/4e73yd2ofpdzl6rptzvd74no3hnyfblknoq7wzxlw7f3zjbz7c@srfabx6lsusj
Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
---
v2: use bool/proc_dobool as Joel requested; document direct crash entry.
Maaz's v1 Reviewed-by is omitted for renewed review of the changed sysctl.

 Documentation/admin-guide/sysctl/kernel.rst | 20 ++++++++++++++++++++
 arch/x86/kernel/cpu/vmware.c                | 15 +++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index ffea61d448eb..be13c143b8bb 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -1690,6 +1690,26 @@ entry will default to 2 instead of 0.
 = =============================================================
 
 
+vmware_record_panic_msg
+======================
+
+Controls whether panic or fatal-oops kmsg data is written to the host's
+``vmware.log`` before kdump. This setting does not control the separate
+VMware guest-crash event. Writing zero disables recording; writing a
+nonzero integer enables it. Reads return 0 or 1.
+
+= ==============================================================
+0 Do not write kmsg data to ``vmware.log``. This is the default
+  for encrypted guests.
+1 Write kmsg data to ``vmware.log``. This is the default for
+  ordinary guests.
+= ==============================================================
+
+``crash_kexec_post_notifiers=0`` alone does not disable this logger.
+``panic_pre_kdump_postpone=1`` skips early logging but leaves late panic
+logging eligible; set this sysctl to 0 to disable both.
+
+
 warn_limit
 ==========
 
diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
index ccf8dc84b30e..4b0e5b084c2c 100644
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
