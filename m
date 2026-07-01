Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F75142EEC4
	for <virtualization@lists.linux.dev>; Wed,  1 Jul 2026 19:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782934355; cv=none; b=UDVymcvbBWgo9DtKu23gmSWMdLGRji2j7cQ+4Rp1okluUrGsZYnZHvL4dFn275+ZEucbkGMrG7/YsDA0ixoGU4MEj7OL+pBO3dgxqMwMDdJi9z+zQFMNHWpxwwJGgx3VRYygQ11Asv2aVFw2PdJ2kJl4fwKgg6I+uUSms5Ec35Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782934355; c=relaxed/simple;
	bh=m7RzfJ+dglccDpbLj8Vzsd5+h0OdO8Af8uWyaDtsUyA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jjpIyV5FIgPLL8rHPBm13VPsPQLj46dkKLmsIdWlmRtFSx/oAyRUaoW7cn5Bs3lcJe+ItCBpMVlyGWZy2H8b6dNOVgI1JARDiwlqCo6xdn3+LAdK6Ft7DmtMXjKDa0QxLwDhNKGQQAO2fggzZbw33spcYcmvrMrtS/ugA1qsvgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QVR4RimH; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QVR4RimH"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-847a483ea41so1122445b3a.0
        for <virtualization@lists.linux.dev>; Wed, 01 Jul 2026 12:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782934352; x=1783539152; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=s/QSbcUaf8Mr1OX5FYkbnza8ilhhfuHPZoXwnM4X05U=;
        b=QVR4RimH47KCDN/lYBasBdG4XpusXLwFpje4ELDAsJOvf1+SoED5igHah7VnWMDr0G
         qikokoMFUeB1Ll3SadTPquK+D2013tQDKzeAgy2m5OiuryCPjmedCsroUTImucgoW5hm
         kPr4zq7a/zVb5C6i4yw2D7BV6nPLUt1+YIzLINpb1q7Ov/V3mPh0FEVgZpUCPcLyO8VD
         spPUPQQmY1afM5PeRMHTz7YG8s+E8aslo2rirTy3Ff5I/pAiyTmuWjc9O+ybPNknmgFS
         vAxD5aRUZ5HPXuhEqB/P7YvgC+PLs+SyyY8E1lZXp4pSKyynKGaIIzjleCQZIQ22xcwZ
         +Uhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782934352; x=1783539152;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s/QSbcUaf8Mr1OX5FYkbnza8ilhhfuHPZoXwnM4X05U=;
        b=UMeaP+6d59QDow3n25jaAbpwFWxs2lHBBM1ISz+UTJtBRGeRJVdqGK7h90bUfbn3p2
         gokUQsHgUBl+Fss6NK/FUxarFAOLFjgF1IqxviNzidKVcHb008OMRPfg9Tz0jK3b3vmD
         HHajZTTYBAr45IqE8QwIFm0xYrXmnhL+Tfjdaqli/GhsY+E7depoWEjZflMbzz0UatdD
         vSO/LLpsXvYalmN+asw5fB8RpM3Oypoz+vMrLO7hAmWc7AzEPyCbZlD+W5ssEGxNN3Oi
         oEYgPhbcB+XxUHlzWamrReLEMT4LbkUoZEYbKq2eG1tjdFkoPf8QrgvLX/o43dGXWjB5
         /B9A==
X-Forwarded-Encrypted: i=1; AHgh+RoG35wJ5/cgg6PjgQsJuAdiQOuAUz8DzWNA3ce7yCG4g0514eg9vXu7ZLbZ2SOEMTHNcTi6vXr15Wk78tBC5Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw9XYdyWbecL1YJhZlYV6y51yINj9XfOWwPAMJIn4JnUI2Z/kYh
	Ro2RsOqltuJWkXTvZyrBl1x4SbmbDlpPjFuK5l14P+MrtvzgZUEnVmDmfvlkq3MgO0FPzv39Afp
	r5D/Zlw==
X-Received: from pfbhc3.prod.google.com ([2002:a05:6a00:6503:b0:846:aff8:5614])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3e10:b0:842:499d:450e
 with SMTP id d2e1a72fcca58-847a82d978dmr5886277b3a.20.1782934351240; Wed, 01
 Jul 2026 12:32:31 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  1 Jul 2026 12:31:25 -0700
In-Reply-To: <20260701193212.749551-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260701193212.749551-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260701193212.749551-5-seanjc@google.com>
Subject: [PATCH v5 04/51] x86/tsc: Restrict recalibrate_cpu_khz() export to
 p4-clockmod and powernow-k7
From: Sean Christopherson <seanjc@google.com>
To: Jonathan Corbet <corbet@lwn.net>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Kiryl Shutsemau <kas@kernel.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Sean Christopherson <seanjc@google.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Juergen Gross <jgross@suse.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, John Stultz <jstultz@google.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>, "H. Peter Anvin" <hpa@zytor.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Stephen Boyd <sboyd@kernel.org>, linux-doc@vger.kernel.org, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev, 
	xen-devel@lists.xenproject.org, Tom Lendacky <thomas.lendacky@amd.com>, 
	Nikunj A Dadhania <nikunj@amd.com>, David Woodhouse <dwmw@amazon.co.uk>, 
	David Woodhouse <dwmw2@infradead.org>, Michael Kelley <mhklinux@outlook.com>, 
	Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"

Export recalibrate_cpu_khz() only for its two users, p4-clockmod.ko and
powernow-k7.ko, to help document that recalibration is relevant only to
ancient CPUs.

For all intents and purposes, no functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/tsc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 4393902c0ddd..482cc3a8999a 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -943,7 +943,7 @@ void recalibrate_cpu_khz(void)
 						    cpu_khz_old, cpu_khz);
 #endif
 }
-EXPORT_SYMBOL_GPL(recalibrate_cpu_khz);
+EXPORT_SYMBOL_FOR_MODULES(recalibrate_cpu_khz, "p4-clockmod,powernow-k7");
 
 
 static unsigned long long cyc2ns_suspend;
-- 
2.55.0.rc0.799.gd6f94ed593-goog

