Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E522D403EAC
	for <virtualization@lists.linux.dev>; Fri, 29 May 2026 15:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780067311; cv=none; b=cnderEYw5aeQ0bmYaDK729HGVsR87JPXiL9c1CUKwiXHfuwMxvIsb3LcLSnWg2IpwIIS/1jTekCWhE6tcw5U6wtz7LC5+uue3cKOVvrCpjfBtvkp4NOUwOxcWaV5+Eke9ckIKFCxZt78tnOSPnGd4pHtSiNBoh2vSxalJY+D+9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780067311; c=relaxed/simple;
	bh=DEZgJF7aGT/S6bfnpIcTdfbLyrYZ4GO7q+5YqQ+zuvQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qZ7/bYKZdeShcf3AtQrzdPGP1gWPciahxcaX4wIipfT6I79XXR9xnMN04TGY1GoOpn5wJxWMqROkWxEoryy5PiCXVOFStQOkR8rOModPgsEfviyBRGg6hD8DxnOwuhuWzcE5csjVK0dNnfZJ+vAg9wemMRKvdpgrlwSI4AS3IZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bliJiAuL; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bliJiAuL"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2b2ecc96a9aso160822475ad.1
        for <virtualization@lists.linux.dev>; Fri, 29 May 2026 08:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780067309; x=1780672109; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=EFwMDca4i0UUfWhYRWZx1hhbmviPyyt5LCM1/HLShPA=;
        b=bliJiAuLaG3+nmRidPY682iIMJBnBPv43MROQyp26NNwr5z5uJe4QcEagFt1WMOe7C
         cndkt42OfhjpOfobFl96vTnCS2frmWO+0qBAzlo13OSDibfBpUZGcWhOtCKca2OI3muO
         8eMowoY/4voFotpkOAJOHNiy0SunQhtyozSrfZ6yiG2zCyTG2oxdesA7jRzJrMfAxEcB
         dE2x5L023KZwwnhA0zJjnSIbcirVGUc5EAbkgq5KQd/6G8S3ff9w4j+kh2XxX7QKHoOf
         w2wkcWyHuNdlT2FUzpltYeZkLffqFv+loT7d6/gKAaUViUvOzlicuw6uL1UJZ8j9Vv8v
         hxEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780067309; x=1780672109;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EFwMDca4i0UUfWhYRWZx1hhbmviPyyt5LCM1/HLShPA=;
        b=rm6tQ1w5S7tH3v/bz2rSj6+Dlp0HUPk09YhXwOx+VJG5M8O54tj2uSwf8oBoOB05tH
         5yym2e+5Ffmz/2vM2s801tSyx7LbJopOP6sA0FUG86MVAFqpE7Lwjt/QAena60IxnfHB
         frDx0EoUtRyvZXXUAFWml0+NAZKXK/AM6YOBiyT3XQnyWbwPp8sSfTd9fOYPZtxAvjYd
         0qBR2kiHj8FfqRUgqaHXn9dfx5ZzLKmAyko8BL9p9L7vUMh1nJnIoKm+AdDoZqNuihPf
         E98UzUPQQObHNNvsRS0Fk6q66SAvBW5S3DD5l8GUqQinUMeKMKjz50wJIsR5mHpVHGDZ
         /HlQ==
X-Forwarded-Encrypted: i=1; AFNElJ+UFrx8roF8YeFdNVHV992qMxTkkpSAS/P6erF5jrUfoQ4y9FSrtaF5q18PaRXF7F5Nrqj4tWsA164h9J2raA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwH/ONrsuaUr6wrfTJ/NyzdPxtXBdQ7lQYOtSBydYzLNyiYbFEV
	uETLaXrCvKdPT47++lJhw3Uewh5ceHGzib+inB2ARQEDI/AotKbUMKUv9kK3vuZU9Mj9rqlXWsX
	FOzZZeg==
X-Received: from plbjy6.prod.google.com ([2002:a17:903:42c6:b0:2bd:d2c2:2776])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:eccf:b0:2bf:3126:44b6
 with SMTP id d9443c01a7336-2bf368bd5dfmr2325645ad.40.1780067309070; Fri, 29
 May 2026 08:08:29 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 29 May 2026 08:08:26 -0700
In-Reply-To: <20260529144435.704127-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260529144435.704127-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529150827.714968-1-seanjc@google.com>
Subject: [PATCH v4 44/47] x86/paravirt: Don't use a PV sched_clock in CoCo
 guests with trusted TSC
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Kiryl Shutsemau <kas@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	"K . Y . Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Juergen Gross <jgross@suse.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, John Stultz <jstultz@google.com>
Cc: "H . Peter Anvin" <hpa@zytor.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Stephen Boyd <sboyd@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev, 
	xen-devel@lists.xenproject.org, David Woodhouse <dwmw@amazon.co.uk>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>, 
	David Woodhouse <dwmw2@infradead.org>, Michael Kelley <mhklinux@outlook.com>, 
	Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"

Silently ignore attempts to switch to a paravirt sched_clock when running
as a CoCo guest with trusted TSC.  In hand-wavy theory, a misbehaving
hypervisor could attack the guest by manipulating the PV clock to affect
guest scheduling in some weird and/or predictable way.  More importantly,
reading TSC on such platforms is faster than any PV clock, and sched_clock
is all about speed.

Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/tsc.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 7bcf757bf551..036916953f4a 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -283,6 +283,15 @@ bool using_native_sched_clock(void)
 int __init __paravirt_set_sched_clock(u64 (*func)(void), bool stable,
 				      void (*save)(void), void (*restore)(void))
 {
+	/*
+	 * Don't replace TSC with a PV clock when running as a CoCo guest and
+	 * the TSC is secure/trusted; PV clocks are emulated by the hypervisor,
+	 * which isn't in the guest's TCB.
+	 */
+	if (cc_platform_has(CC_ATTR_GUEST_SNP_SECURE_TSC) ||
+	    boot_cpu_has(X86_FEATURE_TDX_GUEST))
+		return -EPERM;
+
 	if (!stable)
 		clear_sched_clock_stable();
 
-- 
2.54.0.823.g6e5bcc1fc9-goog

