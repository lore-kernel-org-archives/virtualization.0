Received: from mail-ua1-f100.google.com (mail-ua1-f100.google.com [209.85.222.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CD857982A
	for <virtualization@lists.linux.dev>; Tue,  8 Sep 2026 18:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788891297; cv=none; b=saxO9Y1f2mmRXiy/+vtU9eKa0uQcllBVS6Bb+aD65slucXVoSCSZd4gDbqlIMEwzo7EdGAF/DzEZteYOqID9+LQjsO8og5xBaGfHhLNPxJijVFyus6brz8fL9N1Wa/rk3USP6th+7aOxSEio/GkAiH0sPMK7B15YGK7p1IPO35g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788891297; c=relaxed/simple;
	bh=j2DJfVUt0mtvNFgR9qjhwA26YfFt3lRsoWgx9vJ3wP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y4G4QxfkiwT26Ce3qpfNNpi/b4Q+aYI+YoFDhllTn2gk3a03HEpUC/pHtbFENc3boNFMzZstr1h+/0wJTT9iYROkkn0P1Q7esVNb5DJakG+P9Xyh7d/Y2TsEZalkdAFmkWXt5QdDhnoyW5+1ENdJptuHvtxxAkpr5PVvz5o6f8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=QyDcuhua; arc=none smtp.client-ip=209.85.222.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="QyDcuhua"
Received: by mail-ua1-f100.google.com with SMTP id a1e0cc1a2514c-980c4f5c921so592520241.2
        for <virtualization@lists.linux.dev>; Tue, 08 Sep 2026 11:14:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788891294; x=1789496094;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i+U6lKJy3E9UudZt3FknVdHylx4G9kfIGWhaOGKfOa4=;
        b=BoDPq0m8R4ZvEd7YSoqmA9dLH4jbvrZpsq39bVZMtJbm3C2cZEFuY720U9IBev+N6C
         YCfO7N0qHOv7hDk24ORpqXDSeczMOAUbUGqBS2z5YzKZ5ovS95rE6JCw9JNa8UL7eUuy
         kEXsmcHFTN2yUGYOdoRn/1ip4mQd9tlfdMo1KswvYTCj6jQjexCcvoS7rux+sNAgorwo
         w4FxDwPUguu2DMYPqdsbkwCpf2OYe8QI/hMzT3dSlMgPY8+axZ4Qm2cGkqao5BWZ74Mt
         o1Ntlo249gLuA0zb5pCh7HARLs9gN1pZ2qG02qldfzh9nrpXjBgP7+UiwsCgLsOXrWR6
         W0Yg==
X-Forwarded-Encrypted: i=1; AKwUvByrjQbNft7Ws/+qogP1011tYXF9cA9sfbH9ei2YdsRQ7WdhvDYeZ3C3jNI1G1HixCrhXfiJo8shvY/U31etVQ==@lists.linux.dev
X-Gm-Message-State: AFuF++msN6LqKS1XYBaDcUemj/+SFgGh7HMbMd9hg6CUe+oizDr/iH0U
	xMloQPxiUDuq8tjpa8u+00OPVjbkRbZnxlhAiw1ka+6uMzD9aAKaMVOtbBDVUbYe+MQxXpOaRVn
	4SVzcyStJ56JTWHu8vrT3w7UNDWxFZwLYWaX3+CviPJFQHbGpZhB4xwVmoLLBoqVTy36AilN0pA
	uoQ6MwKeXO9GNI5UhRxmvaowrYszhvabPBwAlMcnKB3hSpmKahKUre2TQo4rL3azg8FRRJXK46t
	/4oYtTP3fiwR4Nt7/0=
X-Gm-Gg: AYBFou2UeVhy+3BX8mNeE5e5ewYg/0f5kMuYmEj/V+lARrd/uEdGYw8jPMFvQNKyhuO
	sIZ2Fi+ePRewy94gYzJJTFQQJ/biNUAo8TauvfzwcBaJ8psiMlYys3fBRGU09xYr6N/sd4QscXv
	f3Mufo0kGJb6AUKZbF6VnQXehu1oFUpVynGkGutQ7qRDzUYlk7fozppCJQMvqPENfHX4rafVDHz
	AErCzw4nP29UcVx//8CRa7BplOxZyR+s4f2zGGYzuuRSUGmxHXvAdgMDfQh54BQhwcEnU8ut6qj
	9NuBEg5PWx/E+M9BQu99KwUA+zaF4P6rI0hCqWaG9ZZWTDFUwriDDgUpHHXliqNh+yNjFoeF3NJ
	RZY2+hNhdaGr+cuTIRr84urstBd75f0wihgTIAQ0WgSMSIlbKTEra23YCGPq95I+8UU4raNN3pq
	Dyvgt7EA7dUowkYu4G0g9CFeaUTRhpoA==
X-Received: by 2002:a05:6102:554a:b0:780:5605:743f with SMTP id ada2fe7eead31-78a4a8bb311mr11768312137.3.1788891294484;
        Tue, 08 Sep 2026 11:14:54 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-2.dlp.protect.broadcom.com. [144.49.247.2])
        by smtp-relay.gmail.com with ESMTPS id a1e0cc1a2514c-9808e9758adsm4337999241.0.2026.09.08.11.14.54
        for <virtualization@lists.linux.dev>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Sep 2026 11:14:54 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-4b325074c26so4956766b6e.2
        for <virtualization@lists.linux.dev>; Tue, 08 Sep 2026 11:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1788891293; x=1789496093; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=i+U6lKJy3E9UudZt3FknVdHylx4G9kfIGWhaOGKfOa4=;
        b=QyDcuhuahW7j/BsI84nx8rBGS8o8U0CQA1x3KX9kKCEFCaP8P9UNox7n31tlqBVdBg
         PHGMan1k5iVZMWh+Co93U+DkHk7Izil6ZOBU1HPxcGcFeOE6ZxtO888YEZ/48gzcb5M8
         tangrICD1Uw47aVSv0vLo25L0rtoMmSWJKZng=
X-Forwarded-Encrypted: i=1; AKwUvBx136uKCgcCGx0ponjknqTz6mo0WO2aLRq7Jr762BoHaBuhJ+bO01I3QB/evTBjmXU8fo9P1tdW7UHgBxwMWQ==@lists.linux.dev
X-Received: by 2002:a05:6214:4905:b0:90e:7e02:cc3f with SMTP id 6a1803df08f44-9103ef88ddemr25982166d6.18.1788890854642;
        Tue, 08 Sep 2026 11:07:34 -0700 (PDT)
X-Received: by 2002:a05:6214:4905:b0:90e:7e02:cc3f with SMTP id 6a1803df08f44-9103ef88ddemr25981186d6.18.1788890853962;
        Tue, 08 Sep 2026 11:07:33 -0700 (PDT)
Received: from vertex.localdomain (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9106412e038sm27114866d6.20.2026.09.08.11.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 11:07:29 -0700 (PDT)
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
Subject: [PATCH v1 2/4] x86/vmware: Add the vmware_record_panic_msg sysctl
Date: Tue,  8 Sep 2026 14:07:14 -0400
Message-ID: <03e5c9855e9578b00abf8da69764f1b468597218.1788414671.git.zack.rusin@broadcom.com>
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

Full panic text is useful on ordinary guests. Encrypted guests should
export it only when an administrator opts in. Reporting a crash does not
require transferring the log.

Enable panic recording by default for ordinary VMware guests and disable
it when guest memory encryption is active. Expose the policy as the
boolean kernel.vmware_record_panic_msg sysctl and document that it
controls only the vmware.log transfer.

Register the sysctl only after the panic buffer and dumper are ready, and
only when sysctl support is built. A registration failure leaves the
internal default in force.

Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
---
 Documentation/admin-guide/sysctl/kernel.rst | 14 +++++++++++++
 arch/x86/kernel/cpu/vmware.c                | 23 +++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index b6328cd0f43e..4577e935ddcf 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -1690,6 +1690,20 @@ entry will default to 2 instead of 0.
 = =============================================================
 
 
+vmware_record_panic_msg
+=======================
+
+Controls whether panic kmsg data is written to the host's ``vmware.log``.
+This setting does not control the separate VMware guest-crash event.
+
+= ==============================================================
+0 Do not write panic kmsg data to ``vmware.log``. This is the
+  default for encrypted guests.
+1 Write panic kmsg data to ``vmware.log``. This is the default for
+  ordinary guests.
+= ==============================================================
+
+
 warn_limit
 ==========
 
diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
index bf59653d6e07..3848811550e9 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -31,6 +31,7 @@
 #include <linux/efi.h>
 #include <linux/reboot.h>
 #include <linux/static_call.h>
+#include <linux/sysctl.h>
 #include <linux/wordpart.h>
 #include <linux/sched/cputime.h>
 #include <asm/div64.h>
@@ -255,6 +256,19 @@ static int vmware_log_rpc(const char *buffer, size_t length)
 }
 
 static struct page *vmware_panic_page;
+static int vmware_record_panic_msg;
+
+static const struct ctl_table vmware_panic_sysctls[] = {
+	{
+		.procname	= "vmware_record_panic_msg",
+		.data		= &vmware_record_panic_msg,
+		.maxlen		= sizeof(vmware_record_panic_msg),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
+	},
+};
 
 static void vmware_panic_log_dump(struct kmsg_dumper *dumper,
 				  struct kmsg_dump_detail *detail)
@@ -263,6 +277,9 @@ static void vmware_panic_log_dump(struct kmsg_dumper *dumper,
 	char *buffer = page_address(vmware_panic_page);
 	size_t length = 0;
 
+	if (!READ_ONCE(vmware_record_panic_msg))
+		return;
+
 	memcpy(buffer, VMWARE_LOG_PREFIX, VMWARE_LOG_PREFIX_LEN);
 	kmsg_dump_rewind(&iter);
 	(void)kmsg_dump_get_buffer(&iter, true,
@@ -283,6 +300,9 @@ static int __init vmware_panic_log_init(void)
 	if (!hypervisor_is_type(X86_HYPER_VMWARE))
 		return 0;
 
+	vmware_record_panic_msg =
+		!cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT);
+
 	vmware_panic_page = alloc_page(GFP_KERNEL);
 	if (!vmware_panic_page) {
 		pr_err("failed to allocate panic log buffer\n");
@@ -295,6 +315,9 @@ static int __init vmware_panic_log_init(void)
 		__free_page(vmware_panic_page);
 		vmware_panic_page = NULL;
 	}
+	if (vmware_panic_page && IS_ENABLED(CONFIG_SYSCTL) &&
+	    !register_sysctl("kernel", vmware_panic_sysctls))
+		pr_err("failed to register panic log sysctl\n");
 
 	return 0;
 }
-- 
2.53.0

