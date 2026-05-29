Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2DA1400E12
	for <virtualization@lists.linux.dev>; Fri, 29 May 2026 14:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780065920; cv=none; b=BYNrjhK7f9VC5GLFZHrXUEzQu0K7pf6MBlQh2Vd0t5qV0ZbDXnh0cmUG3IJhnYYwnvDpUsarsLmmyQWVuxPzcSwlZdvgB4Ni9nwWiwnxywo/epcjFJboSBcWuUK3nXcmBRx4jI4YPuoKNxyEFaexIJ6NCyPoNt1fmOCs9Uaw/9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780065920; c=relaxed/simple;
	bh=dN1xTlAsuZlAzy1KoKelGX7Cs0cog4o00BEDXP2Nha4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jv0ylxxywqFiF5vmFPdFLmp9OSyp2VmK8nrDqFR9dPBnehBXodldVLIRyQlBc6ePkUra5rqxbe7yF37eFmytUU2X8wGlCei2Ok/8I+eyIGVP9RoX5Tw+V5WeQLPNgq0k3/Y1GZUaubceDTlFEETNjMX/kdrUaaZSdg6J/0cHGtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XIdODQKE; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XIdODQKE"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c857fb0b35aso113226a12.2
        for <virtualization@lists.linux.dev>; Fri, 29 May 2026 07:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780065917; x=1780670717; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=YpIj1ucaijezC9S67db1/B7YVcsq/H2nz/z97RNrYsc=;
        b=XIdODQKEu05hsNgaCdnlkwe/oNcwQRF7Z9DF8Us8z7u+WiY5POEkP1ioN32llK2j+P
         ZyNa5dLd9xEPWA5DvOeIXlNbC2hc6DN3a4BzWOrnVBs7X0V5xlXL2R8XaOwDMGWoi77c
         O5lbhP9EEyPDHw8NQ9VIASNNCBTTUInNsrZDx5TCiDDIqEN18lWiBB6XdhenjzZtDBYw
         pfkUgT76GqCcrrPaq14Z/TPE5gyBFz2FwKmCNVI2VKwMk2B5uEp9k/8w6KIuYPlw1Y8F
         BhekPOGBT88aFP69/8zr6lVOb9sxi24r18ZOfmPF5BwgLjsVyNSbsceMpMx1mIjlQZ28
         orSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780065917; x=1780670717;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YpIj1ucaijezC9S67db1/B7YVcsq/H2nz/z97RNrYsc=;
        b=OVFS6P5djCXAxQUI1PJde0h5DrAoTJh351zAFNhnEFL7kyoWUCnr58C0Z9cf6XEgQq
         yJj7sEc+7rJuMt9egfP6S0gFI5ahg7iEq7QwOPtKAV5BQd6MjhnLGbr8YskV9kvneBYw
         0dhvkhP+n4zahqec4C9kdPPqBPfK4wA+yPo2MiQ+VeYBGa/Y0vFcZp7E58rcHk0BTdrw
         Q5slu6Nu6q6h5bTpLjWrGc4ES3sl2RWXcdTWtc6C1tKAvs6TwEQUdFZOlP5Hv3ZxIc7O
         NXIl6HqlQnyjlgBiLLo3cFiMPrOoUj+UnkBPQwfeN8aulABVE2qwjktDeZcDliQclKVG
         KrOg==
X-Forwarded-Encrypted: i=1; AFNElJ+hlGx66gzvLWia4/XOw78dvTvj782KUjrlL2FT6b+NW9uFxzG0TgX9k8RHovG0nmVRjn9oCkkaR+/wmfGfUA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw3AXtjaojbwPqWp7rxbi70VLucCdzjinhrbmPyHLwkJmJaJbn3
	j5CzmArHqNTlsiLyLxBWAeu52zFTJZrxodKHtc1+dtEYiPO1N9tbuVeqniCpeQg2rOYTnQFDIyX
	Q9UyIVg==
X-Received: from pgnm19.prod.google.com ([2002:a63:7d53:0:b0:c79:1600:6a09])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:244f:b0:3a0:67d:bba9
 with SMTP id adf61e73a8af0-3b4120a47c0mr3641480637.45.1780065916828; Fri, 29
 May 2026 07:45:16 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 29 May 2026 07:44:08 -0700
In-Reply-To: <20260529144435.704127-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260529144435.704127-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529144435.704127-22-seanjc@google.com>
Subject: [PATCH v4 21/47] x86/xen: Obtain TSC frequency from CPUID if present
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Kiryl Shutsemau <kas@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Juergen Gross <jgross@suse.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, John Stultz <jstultz@google.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
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

From: David Woodhouse <dwmw@amazon.co.uk>

The Xen CPUID leaf 3, sub-leaf 0, ECX provides the guest TSC frequency
in kHz directly. Use it when available instead of reverse-calculating
the frequency from the pvclock tsc_to_system_mul and tsc_shift values,
which loses precision.

This mirrors the equivalent change for KVM guests using the generic
0x40000010 timing leaf.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
[sean: drop non-Xen changes]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/xen/time.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/x86/xen/time.c b/arch/x86/xen/time.c
index 487ad838c441..36d66abf5379 100644
--- a/arch/x86/xen/time.c
+++ b/arch/x86/xen/time.c
@@ -42,6 +42,17 @@ static unsigned int __init xen_tsc_khz(void)
 {
 	struct pvclock_vcpu_time_info *info =
 		&HYPERVISOR_shared_info->vcpu_info[0].time;
+	u32 base = xen_cpuid_base();
+	u32 eax, ebx, ecx, edx;
+
+	/*
+	 * If Xen provides the guest TSC frequency directly in CPUID
+	 * (leaf 3, sub-leaf 0, ECX), use that instead of reverse-
+	 * calculating from the pvclock mul/shift.
+	 */
+	cpuid_count(base + 3, 0, &eax, &ebx, &ecx, &edx);
+	if (ecx)
+		return ecx;
 
 	return pvclock_tsc_khz(info);
 }
-- 
2.54.0.823.g6e5bcc1fc9-goog

