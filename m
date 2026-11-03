Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.100
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793692461;
	b=UhEQEHI1W7lyPvkrLga9Hg6yqrbRJ9sS4DrUbQNYz3s1B1sStaNsKNgLFb3Ayh647e1y
	 3suxAQ3yL/la6J6QJ9oHy1/5t2WcZXavS/cc/JK3ouY58n1kjsyeM7kXZo/NVmlTXM3en
	 qcWHAk0MF1jjqQT7EOCSkKpBbnsJYPPkguXiC3rKkVQm+s5SI+0CVxwj8QEKHC0IfOWQt
	 h7XdaNoV6ifxxq5X9oy5NnbhT72oKwoF6Xu6R8eFumlppBs4NIs97HSr8C90o5/4LfPHn
	 02hqFS9NQzQ1TgKVbZK+oSHsTnrTA51YNDdMkFE6hRfpSgqnx4Lqan31q55kwlJ1ouQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793692461;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-DetectorID-Processed;
	bh=SSKe6YFblVjuOlewl86JzUttzs9TwvUcFTxoEjaaYZQ=;
	b=kATz5Bl2s7v9sykRWDQT3+QVNBKVF84/K/jIr8NYc0G17+D3fWTF5EnqlMVQ8azGawak
	 uUkmJS8MEEbu+CCacTRH4BTzvDIBNnYRb/jtBDOtLIfMjF3SyeywQ6X2mfIAgSRSJ4h4Z
	 qnlC2CZNQKZ8XjvZ72WgTBXvg+ppKMqkkWXlKrn58BXBwcevJNz00W8bnoOVkN+twoOHq
	 2jTt5J9ByMtA9acBea1+rL7Vnpsf0qMaIh48ddgBsljx4bU6ovVOuwAwdQqvO2x/OKiCB
	 dSRdzELP1d7+NQ4uSCsASu2+W9MxWrYZJNQ4ymY7k0LqEmgV7tJdTyMHLcZhBvER4aw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=GILHWIvt;
	arc=none smtp.remote-ip=209.85.216.100
Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com [209.85.216.100])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB024606A329
	for <virtualization@lists.linux.dev>; Tue,  3 Nov 2026 07:54:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB024606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=GILHWIvt
Received: by mail-pj1-f100.google.com with SMTP id 98e67ed59e1d1-3aded3c6103so1834592a91.0
        for <virtualization@lists.linux.dev>; Mon, 02 Nov 2026 23:54:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793692460; x=1794297260;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=SSKe6YFblVjuOlewl86JzUttzs9TwvUcFTxoEjaaYZQ=;
        b=Uh+kIm92+ydI7BotAsPt93rxhQUHYFxI8BSD/KTLnV9BO2Ep3Eja21P0BiFW7DuaeP
         4QSfp4PSmGcVR4bRLpYeSe2fb7pOtehU4yRgj6BJQ7Hdo00GPu2sZPZMWkOaeo8IQQAC
         LpHJTKV721BmdFkX8xW8RfrjiQ1J5qxhNNsry60UvNG4/TThUTyE0PoFu3fE2mblU1kt
         sN/oJwSgjXnfA/cMoa3ce1iO7GU13xDhpZM6OQ0dhU0ahGQJWYq9OpvC4gnOT+JrzlnN
         OH3h2jE7sUU/v94n6XOrPVrHZLSBw2HYGzBz22Tsrq4xATIzjvAyr7Nr8YA0yw5rQrjL
         mPDQ==
X-Forwarded-Encrypted: i=1; AKwUvBxhP6k7xuTNjnWBsfsAYT1EGQhJqDD2YCkl6OhbiUcPkiulcixqAwlm23hBvAbZyASZiooFMPYcid0eI6IF1w==@lists.linux.dev
X-Gm-Message-State: APuU4Z9EShX8+HoXLZWsMTDEibsm12pdztptlOGFCaO8UtcxaFfp620J
	fZ1Jh9Dv9wSd+UtBEqOj8TnTmkVUKAdFsk9Uh5uyZ1GBJjq6Mo1Id+f0RGvm5cRK/CtvnOIkOch
	Y9e5SrIwHRkAhT2C0K5/02nym9MWMhm7sr7T0+xvRQ4lKZbq9TXerqksGqxVcBDCtGdohuQPit8
	luWjO7UEEd64JCET1LfOxJkJZ6TVW4dX+Ey1/TwdPRm6dGduDpLxM4XdI4zZ4rh1NbsJ/L6edi7
	g7ynuxiEddZ/VHVqQ0=
X-Gm-Gg: AYBFou15goAPshj0Hl+gq0KD5YDY9DdqkwKy256H9x9KG7fDaWdeSyQ3gMFWWamPho8
	cbq/ZxzRrm+LcMH3yYwZNET2+r93cJ9EzpLTscbW9mgzudPcgWmxjbyCvyWguYljAP2WeABtYLR
	1fOnPrcSPKZWxrDsD6LOS7BsNFL5PezhrVVuMHxkPg9FL6SRhjaQzYLPVY1QQL6gJvnRJdRMMPg
	YR2JDm/ZW6BYXfJpOEYQZ2fOUO75X+Jgh2k6DMpeUsihIWcgWYgz+bn+NveSHm68LwGca2wAQ4G
	btV2nWx8vwqfbB+8XANisRfycbfPzks2KtzjKp6MItBSO9WDAelXXVT4i+N9jPBrFoJ+Sij4jJ6
	F3PRd6YVapj8vKHdatJLySH7r3buKQcvTso+4yP7S3CD/CXqJjpY6UCaU/fSOekvFcu4zZtG3Mt
	0Ow8vBa7Zy2ucJ5iPdEqg/FGR7HJk5rmn5
X-Received: by 2002:a17:90b:57c6:b0:3ac:80dc:f409 with SMTP id 98e67ed59e1d1-3ae898281d9mr8730110a91.61.1793692459940;
        Mon, 02 Nov 2026 23:54:19 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
        by smtp-relay.gmail.com with ESMTPS id 41be03b00d2f7-cdb363a80f1sm39047a12.3.2026.11.02.23.54.18
        for <virtualization@lists.linux.dev>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Nov 2026 23:54:19 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-30c0d568830so7584219eec.1
        for <virtualization@lists.linux.dev>; Mon, 02 Nov 2026 23:54:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793692457; x=1794297257; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=SSKe6YFblVjuOlewl86JzUttzs9TwvUcFTxoEjaaYZQ=;
        b=GILHWIvt4QJN0VkjG7F/fTGywguYsQi1PMYiTE/bNrBbcfy4eJMm0yMvdGRyR40GsC
         XU0xJNX/P/WqtF0mqQQCZQvQkGZChiQMzXSg5fGWnEUZDZNLJrJqzgZsCBe/Orae1PSQ
         +IOcjkMEylD+NbFFntEoWCU13nblY2zL8rF3k=
X-Forwarded-Encrypted: i=1; AKwUvBwgh8RDBXB1y49nwwZ6Kw3D8WspzB2g2j4EK1USyueI6/aQcAQOia/ua6+wZgJyIN4O76n6gWnkLE8U4AVgsQ==@lists.linux.dev
X-Received: by 2002:a05:693c:41d4:10b0:35c:99e1:c755 with SMTP id 5a478bee46e88-36a4242c0e1mr18340258eec.38.1793692457440;
        Mon, 02 Nov 2026 23:54:17 -0800 (PST)
X-Received: by 2002:a05:693c:41d4:10b0:35c:99e1:c755 with SMTP id 5a478bee46e88-36a4242c0e1mr18340217eec.38.1793692456621;
        Mon, 02 Nov 2026 23:54:16 -0800 (PST)
Received: from vertex.localdomain ([192.19.218.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42902649sm50287635eec.11.2026.11.02.23.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 23:54:15 -0800 (PST)
From: Zack Rusin <zack.rusin@broadcom.com>
To: Borislav Petkov <bp@alien8.de>,
	x86@kernel.org,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>
Cc: Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Alex James <alex.james@broadcom.com>,
	Michael Kelley <mhkelley58@gmail.com>,
	linux-coco@lists.linux.dev,
	virtualization@lists.linux.dev,
	bcm-kernel-feedback-list@broadcom.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH] x86/vmware: Map vTPM as private in encrypted VMs
Date: Tue,  3 Nov 2026 02:54:08 -0500
Message-ID: <e0e5389688fe4102b639c42295305e08f306a092.1793692366.git.zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.53.0
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

From: Alex James <alex.james@broadcom.com>

Encrypted VMware guests can use a virtual Trusted Platform Module
(vTPM) implemented by a paravisor, trusted code running alongside Linux
inside the protected VM. Its register page needs a private mapping so
accesses reach the paravisor instead of host device emulation.

The default ioremap() path maps device registers as shared. Without a
VMware private-MMIO override, this also applies to the vTPM registers,
preventing the guest from communicating with the paravisor's TPM.

Install is_private_mmio() for the vTPM's single register page when guest
memory encryption is active and firmware supplies a TPM event log. This
lets ioremap() select a private mapping for the device. Hyper-V already
does the same for its paravisor vTPM in hv_is_private_mmio(), added by
commit 812b0597fb40 ("x86/hyperv: Change vTOM handling to use standard
coco mechanisms").

[ zack: Moved the include and explained the private-mapping requirement ]

Signed-off-by: Alex James <alex.james@broadcom.com>
Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
---
 arch/x86/kernel/cpu/vmware.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
index 34b73573b108..afb40036ff49 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -26,6 +26,7 @@
 #include <linux/export.h>
 #include <linux/clocksource.h>
 #include <linux/cpu.h>
+#include <linux/tpm_ptp.h>
 #include <linux/efi.h>
 #include <linux/reboot.h>
 #include <linux/static_call.h>
@@ -374,6 +375,17 @@ static void __init vmware_paravirt_ops_setup(void)
 #define vmware_paravirt_ops_setup() do {} while (0)
 #endif
 
+/*
+ * VMware hypervisors use a paravisor to provide a secure vTPM device to
+ * encrypted VMs. The vTPM MMIO region must be mapped as private to ensure
+ * that it is handled by the paravisor.
+ */
+static bool vmware_is_private_mmio(u64 addr)
+{
+	return addr >= TIS_MEM_X86_LPC_BASE &&
+	       addr < TIS_MEM_X86_LPC_BASE + PAGE_SIZE;
+}
+
 /*
  * VMware hypervisor takes care of exporting a reliable TSC to the guest.
  * Still, due to timing difference when running on virtual cpus, the TSC can
@@ -442,6 +454,12 @@ static void __init vmware_platform_setup(void)
 #endif
 
 	vmware_set_capabilities();
+
+	if (IS_ENABLED(CONFIG_X86_MEM_ENCRYPT) &&
+	    cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) &&
+	    efi.tpm_log != EFI_INVALID_TABLE_ADDR) {
+		x86_platform.hyper.is_private_mmio = vmware_is_private_mmio;
+	}
 }
 
 static u8 __init vmware_select_hypercall(void)

base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
