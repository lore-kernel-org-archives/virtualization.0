Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB771C7B77
	for <virtualization@lists.linux.dev>; Wed, 14 Aug 2024 21:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723669688; cv=none; b=cLf9TQL4FwQVlnSHpP0icnR0S1WQdJYmZhvgj63osdGLgT3HNOrmmFq0exFfr/Fnzf4ObjMpxufdVg2ukl0H2LUxmP8/YfKyQFbjnu0cAdssB10xPys1EnZiH5YaAgP0WuD1kKNbgO41CATnk2vbx+dvSW36mC1q2LYnmnVP5aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723669688; c=relaxed/simple;
	bh=XQNLMLHB8Bq6urDZ7RRKnhgvnEBtv3VWmll28dAOMf4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mRQPDXA/v4kd4yRE1DFall2CwBa/Xompl3fmZOgjXv82fiZCViEdd+rCEvRJicz0sQDaREl4QTm7jRMAUaOKcqxne9sLD1PKCYW/uCG4iq+LNEfC95EZluKj538XY4Ow9sZ/xcYZr3Vajqh4novCgOkcXUg5n6OkaT6NSwtZ0IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=HU8Cq16w; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="HU8Cq16w"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6bd6f2c9d52so1294286d6.3
        for <virtualization@lists.linux.dev>; Wed, 14 Aug 2024 14:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1723669683; x=1724274483; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8sHW2F3yGzQtos1f5meNnseSubKzvRLxPjBnQoi7yoI=;
        b=HU8Cq16wjmc8l7yvSupCDjV054O2ceNm3k5ka2DMvs2CRJlbd/OipSBgggCFKxhqES
         MvC9B+c1oyJBhOlWYOB5q94zLEvvufxKfzxYjLdpcW33NQ2Bi8tWeFrhXN6Ipffp5+iz
         1ELOQRQpAG7he9jupjgYQQPe6kqwNdtHELs1I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723669683; x=1724274483;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8sHW2F3yGzQtos1f5meNnseSubKzvRLxPjBnQoi7yoI=;
        b=d//Ux8NXCFg6dgAXQ6u9wr6d5aoN9yT5l3ogKhzIYY+L/BDQ+xojnp5wEcK3QnKU6S
         cHzUThHLSDNB8C7NRZrsPr7p35sggvk+KBt65j2fT+86ZU8+SjO3m06sqDyqO5OTrT0P
         mnjAHwsBLgWCzQfaF8HboAk4qcbw0TZRCA7wsaLEXc+CHh0ANDHCVUnG+cqP+TESoTT1
         6Ip/F5ywwihoQeYJoqBIPLicCbR8kF6HvjJn93HZ0TQAGy6ibDnSwtG5Ha/qjImIAOCG
         OHHYrVMOq344PhnXHNudKE+NS9tfFKIL4TRUyYiYfkHPJfaAKZHooKoesp+qRlC063HG
         K3Ug==
X-Forwarded-Encrypted: i=1; AJvYcCUEmPmo2jpSm4Y1j14dl9bObg4VTzSh7OccI0szB+UhHWO0w9vZ40oFtKedeQg6yyGjVB2VG0qPok616rvDru+UJRhXPIy1aFCzhwyRHh4=
X-Gm-Message-State: AOJu0YwOgtEaeKKHQDZ8J/CTg8IKN5g24waUCx+nsmu6LDzxe9ZzMtnn
	3PrpeazzKXPq+iY0kfahbz62wdWyaFUWIMtLs2uRKme+WaEcnkwinhKUqdeWqA==
X-Google-Smtp-Source: AGHT+IFIMpLE+58fX37ApJWrzeiVS1CLUDddwvO8oWStXYZRlBPnDD5/J1dS9XGvC5TERyHE3wXqFA==
X-Received: by 2002:a05:6214:4303:b0:6b7:abe7:5665 with SMTP id 6a1803df08f44-6bf5d22a952mr54358836d6.22.1723669682933;
        Wed, 14 Aug 2024 14:08:02 -0700 (PDT)
Received: from amakhalov-build-vm.eng.vmware.com ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bf6fef3845sm414526d6.125.2024.08.14.14.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 14:08:02 -0700 (PDT)
From: Alexey Makhalov <alexey.makhalov@broadcom.com>
To: linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev,
	bp@alien8.de,
	hpa@zytor.com,
	dave.hansen@linux.intel.com,
	mingo@redhat.com,
	tglx@linutronix.de
Cc: x86@kernel.org,
	ajay.kaher@broadcom.com,
	bo.gan@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	Alexey Makhalov <alexey.makhalov@broadcom.com>
Subject: [PATCH 2/2] x86/vmware: Fix steal time clock under SEV
Date: Wed, 14 Aug 2024 14:07:31 -0700
Message-Id: <20240814210731.761010-2-alexey.makhalov@broadcom.com>
X-Mailer: git-send-email 2.39.4
In-Reply-To: <20240814210731.761010-1-alexey.makhalov@broadcom.com>
References: <20240814210731.761010-1-alexey.makhalov@broadcom.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Shared memory containing steal time counter should be set to
decrypted when SEV is active.

Co-developed-by: Bo Gan <bo.gan@broadcom.com>
Signed-off-by: Bo Gan <bo.gan@broadcom.com>
Signed-off-by: Alexey Makhalov <alexey.makhalov@broadcom.com>
---
 arch/x86/kernel/cpu/vmware.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
index 9883766715fe..f20bdc3128f3 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -306,9 +306,30 @@ static struct notifier_block vmware_pv_reboot_nb = {
 	.notifier_call = vmware_pv_reboot_notify,
 };
 
+static void __init sev_map_percpu_data(void)
+{
+	int cpu;
+
+	if (cc_vendor != CC_VENDOR_AMD ||
+	    !cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
+		return;
+
+	for_each_possible_cpu(cpu) {
+		early_set_memory_decrypted(
+			(unsigned long)&per_cpu(vmw_steal_time, cpu),
+			sizeof(vmw_steal_time));
+	}
+}
+
 #ifdef CONFIG_SMP
 static void __init vmware_smp_prepare_boot_cpu(void)
 {
+	/*
+	 * Map the per-cpu variables as decrypted before vmware_guest_cpu_init()
+	 * shares the guest physical address with the hypervisor.
+	 */
+	sev_map_percpu_data();
+
 	vmware_guest_cpu_init();
 	native_smp_prepare_boot_cpu();
 }
@@ -371,6 +392,7 @@ static void __init vmware_paravirt_ops_setup(void)
 					      vmware_cpu_down_prepare) < 0)
 			pr_err("vmware_guest: Failed to install cpu hotplug callbacks\n");
 #else
+		sev_map_percpu_data();
 		vmware_guest_cpu_init();
 #endif
 	}
-- 
2.39.4

