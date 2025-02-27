Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F9622D4D0
	for <virtualization@lists.linux.dev>; Thu, 27 Feb 2025 02:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740622786; cv=none; b=a5zaDJK4+ykJE1y9dZv4/AUDYrezhq0fuu9cqzCk4V2i12wjPfrSHkK9c8YNXUDyFcRu3cYCOlb3n5mcjzk2jCvqDzn37w7X/7ziu6xDUlBy02QuSCEu+0iToDTLUa6ybWOJ3NIHU/oegaudLhBPmoDWAuTFdHKE1syt2w4VIt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740622786; c=relaxed/simple;
	bh=c8XZYUiY0W1+X8puZluFjrjS+RyDGH52gngoWNRH5Ko=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=F77VVFoRrBdjoCSgJPH/cUOWlTk74pxMP9qnCecmQW5OdQxKGxo0YFxRyvqkKj1+FlknklauQEXChMs+Q+bomkB4+fyPB+1EkcZUhb8lQQPBzrRNsN6SNnOzKPFhQEp021fGBEOnqd7zr6LXd5e0PzSNFauk71RpPX6KVYOQIcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ukCcfPyB; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ukCcfPyB"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2fc1eabf4f7so1109589a91.1
        for <virtualization@lists.linux.dev>; Wed, 26 Feb 2025 18:19:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740622783; x=1741227583; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=Za0nk5QeJovZveNmDgTJSzh3R0hb/7p0/gaKYZ4C/Vs=;
        b=ukCcfPyB2dChFiuU0mGQNxIy9Zg363Osg3ycP2MhCCcGvSZqQwtjv259Gz70nMsDQA
         HSgDzw5AhNeVThOQwaXL3JANsBTFmyGMGGmpeAnRonui+1Yw9mRsECTgNyIYyxa63exi
         5AnBQnguu1QhLnhGngeCOxUIKvkiF35UZ06wTZDcMl4/AbFZbwxrfmo9sCQjsKRh0PLd
         5gw3HRGDrZ8lJY4XT1vdVE8Vbac6kFhSzR6hJP0B3VblurT88HeUj4nnIaOkUDW41hop
         7nvQCkxHmwwtkUeBljDP/ka7FEO3A4+tA4xdk+ZjHXcD0bnYUdS8rnzHVmSJIaFx5iVu
         zQcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740622783; x=1741227583;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Za0nk5QeJovZveNmDgTJSzh3R0hb/7p0/gaKYZ4C/Vs=;
        b=mVe3cWmI6eQwWe1DZ4VrBfI5GYvKBMlK/IAKSXTP2yBxfryLku4zmJduzEx3VcWNap
         +jwHA+wj0AzH8kvyvBCMg3HOUzq1vbJ3gBP+tEdzIq2esmA/TyXOe2PV8hDf7M9Y/yMk
         JPkXtvWl3FEZa/XJuK0Xtxa0Jd9nq/lGiWh0ya3/OtJG6j45gYhknXjb7JypN6cddJJw
         uQ2DwDgc3GkoT0IOeMHq3zu+Mkgu1ozIASU5kq9LfW/4LEsJEweK7xJOBHXQzH79/w4d
         dkPxcgxguYKIPHl4+Q3stXOjdrGs1UYeI+DJdusVuVqe9X1b2rJ1zxMbY6AvPaI6f3O2
         2X3w==
X-Forwarded-Encrypted: i=1; AJvYcCXDxxrcXjYBhhgGF8dY0X8U7is+EYC/gP/qwKsBnv1lLVDTm4Ksa3lNOVZW951C0GplsgDqwg94seg5yVl2eA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxD0DQQSix3f/5jgEBbHvxbmBljUUO1NPQddBGwFG1Yg8Ps9kSO
	V4dyLCqML0HzZ98iTov8B2aaUSQ5bxrwMU78d0UW8TNWWD0UcK9nmuwpGi61N6Rz8QPrYTPkFkL
	wFQ==
X-Google-Smtp-Source: AGHT+IHPEy5y9WPVcI/hX8J+CDDBk9ezIawKhLRmwSNwFlW/vj5Sb4uKTsOn6iseYydXRMp+Q/+8QjZLtQQ=
X-Received: from pjbsm1.prod.google.com ([2002:a17:90b:2e41:b0:2f8:4024:b59a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:d2d0:b0:2ee:b6c5:1def
 with SMTP id 98e67ed59e1d1-2fe68ad9ef3mr15165448a91.8.1740622783395; Wed, 26
 Feb 2025 18:19:43 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 26 Feb 2025 18:18:39 -0800
In-Reply-To: <20250227021855.3257188-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250227021855.3257188-1-seanjc@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250227021855.3257188-24-seanjc@google.com>
Subject: [PATCH v2 23/38] x86/kvmclock: Refactor handling of
 PVCLOCK_TSC_STABLE_BIT during kvmclock_init()
From: Sean Christopherson <seanjc@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, Juergen Gross <jgross@suse.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Ajay Kaher <ajay.kaher@broadcom.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	John Stultz <jstultz@google.com>
Cc: linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	linux-hyperv@vger.kernel.org, xen-devel@lists.xenproject.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>
Content-Type: text/plain; charset="UTF-8"

Clean up the setting of PVCLOCK_TSC_STABLE_BIT during kvmclock init to
make it somewhat obvious that pvclock_read_flags() must be called *after*
pvclock_set_flags().

Note, in theory, a different PV clock could have set PVCLOCK_TSC_STABLE_BIT
in the supported flags, i.e. reading flags only if
KVM_FEATURE_CLOCKSOURCE_STABLE_BIT is set could very, very theoretically
result in a change in behavior.  In practice, the kernel only supports a
single PV clock.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/kvmclock.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index 934ee4a4c6d4..0580fe1aefa0 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -304,7 +304,7 @@ static void __init kvm_sched_clock_init(bool stable)
 
 void __init kvmclock_init(void)
 {
-	u8 flags;
+	bool stable = false;
 
 	if (!kvm_para_available() || !kvmclock)
 		return;
@@ -331,11 +331,18 @@ void __init kvmclock_init(void)
 	kvm_register_clock("primary cpu clock");
 	pvclock_set_pvti_cpu0_va(hv_clock_boot);
 
-	if (kvm_para_has_feature(KVM_FEATURE_CLOCKSOURCE_STABLE_BIT))
+	if (kvm_para_has_feature(KVM_FEATURE_CLOCKSOURCE_STABLE_BIT)) {
 		pvclock_set_flags(PVCLOCK_TSC_STABLE_BIT);
 
-	flags = pvclock_read_flags(&hv_clock_boot[0].pvti);
-	kvm_sched_clock_init(flags & PVCLOCK_TSC_STABLE_BIT);
+		/*
+		 * Check if the clock is stable *after* marking TSC_STABLE as a
+		 * valid flag.
+		 */
+		stable = pvclock_read_flags(&hv_clock_boot[0].pvti) &
+			 PVCLOCK_TSC_STABLE_BIT;
+	}
+
+	kvm_sched_clock_init(stable);
 
 	tsc_register_calibration_routines(kvm_get_tsc_khz, kvm_get_tsc_khz);
 
-- 
2.48.1.711.g2feabab25a-goog

