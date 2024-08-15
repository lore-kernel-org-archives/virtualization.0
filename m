Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C222C370
	for <virtualization@lists.linux.dev>; Thu, 15 Aug 2024 23:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723765996; cv=none; b=o2k8ObrADuTGq005unx+KA+Yk5vKKal86Jl+ZYvH1kpSc2Ie5u+prA7/NDhu9cL0uvfoO1a6+iKTXQjNf5e7fTlNcrlv6hiCXjsCCke7jEfPckypESam4xegnm0LnaJ3IBXqC0rteNYoZf6wo5UX4/+1UO9oGbTxlrIBnjCoCFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723765996; c=relaxed/simple;
	bh=LwOB566dtP6iRZ/PRNhmquNN3Lyoz+ETk3sAEqaNH6M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aLtB0ce34H1vutFpR22+l7XKTX6amflQLpz2Ev/nACmXH7aBmAD0pmbb6UyX4V/xuXjZIKXmnh6kEmIyKJ3uc5Ok474+Hskbx1frgpD9Ykoh6ZySGypm1w2U647Hl6oyJ3vYnHAryrlBenzzBP7Bl31+5ijHNKTMkPSPVd0Z5V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Ttba9Wn5; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Ttba9Wn5"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6bf7a2035d9so7120866d6.1
        for <virtualization@lists.linux.dev>; Thu, 15 Aug 2024 16:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1723765994; x=1724370794; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UMmHtGDxLP15DSwvGW0oZzm4yIn7Z3SZOYyZ/cXfFzU=;
        b=Ttba9Wn5V97ArVt9oGUK1lWijTnt7Fb/E294tHJ7ks/NPXPWeBcu/kTC55qoMLFECg
         2JmdEPiHOstRej9ayP00ML8gPdU71+Ej6TkqcJAll7m7dPmk/J1UAb1DaUeqGpiPlttZ
         9OjEndimj2gQw3SIFz+WnmXSk4Us7anyYa2Wo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723765994; x=1724370794;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UMmHtGDxLP15DSwvGW0oZzm4yIn7Z3SZOYyZ/cXfFzU=;
        b=ims2wvnkfg/3ehUEO1fSE4pY0cfr5atJ2YCe7qHt7ck0WlCz5TDuIzUPfoK1fok+uz
         r1COQTfxaQOgYkjXm2FVSrpUuG80jTVOmcexelkjwxDCisoThAJvKJuCIdfnWvyB2xD5
         Sg6j0Tz9g+NaqavdqKf0LB/BlaPLIW+NAITBMgzgMQ5eY+zEo3bZjdWt+tAgLLGCkjrh
         EUy4tqWdMNHZW8Wfe8AhgdIMVceJwjkfrNbcUH15aVknvyig/zl1Uj5C7X25UASJ8Ygx
         AA0H2Q4JIcEs4rf6r2RXaF2EXZ9VDzF4Z+/KdT745+fctu4hit5/Po8Jz97dKQdEa3hJ
         lC3A==
X-Forwarded-Encrypted: i=1; AJvYcCXN94CZGQepguLfVF6tdJAALqjRQSJASbgmlJdKId47pBZLxfprIlf3AMGK+LefpsSo4pAfJqYpJ7IPVkRHuQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx9k/qaa4HvCHyIXQB663D19XCHUVDw+nDG3Lw7SNReiEw90K6s
	rUX2r59ggkrIsPkyWaT85AS26tqh/q9dz56/WCNgYHlDtPhfx+JUtwQqiHplgw==
X-Google-Smtp-Source: AGHT+IFqiX06nF1pNMk7dYe8eZHjyfLcc0SwlXL8916skbzdi+3d1cwROPT64eYGuDiUUO1ovmbeCw==
X-Received: by 2002:a05:6214:4198:b0:6af:33ed:87de with SMTP id 6a1803df08f44-6bf7d5b1021mr15618336d6.20.1723765993660;
        Thu, 15 Aug 2024 16:53:13 -0700 (PDT)
Received: from amakhalov-build-vm.eng.vmware.com ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bf6fdd8880sm11277296d6.22.2024.08.15.16.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 16:53:13 -0700 (PDT)
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
Subject: [PATCH v2 2/2] x86/vmware: Fix steal time clock under SEV
Date: Thu, 15 Aug 2024 16:52:46 -0700
Message-Id: <20240815235246.806522-1-alexey.makhalov@broadcom.com>
X-Mailer: git-send-email 2.39.4
In-Reply-To: <20240814210731.761010-2-alexey.makhalov@broadcom.com>
References: <20240814210731.761010-2-alexey.makhalov@broadcom.com>
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
 arch/x86/kernel/cpu/vmware.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
index 9883766715fe..b4e57d6ec2f5 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -36,6 +36,7 @@
 #include <asm/apic.h>
 #include <asm/vmware.h>
 #include <asm/svm.h>
+#include <asm/coco.h>
 
 #undef pr_fmt
 #define pr_fmt(fmt)	"vmware: " fmt
@@ -306,9 +307,30 @@ static struct notifier_block vmware_pv_reboot_nb = {
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
@@ -371,6 +393,7 @@ static void __init vmware_paravirt_ops_setup(void)
 					      vmware_cpu_down_prepare) < 0)
 			pr_err("vmware_guest: Failed to install cpu hotplug callbacks\n");
 #else
+		sev_map_percpu_data();
 		vmware_guest_cpu_init();
 #endif
 	}
-- 
2.39.4

