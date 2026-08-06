Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8756F4A0A1E
	for <virtualization@lists.linux.dev>; Thu,  6 Aug 2026 23:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786059413; cv=none; b=eRv895SbTt/CNuVzwFp0+tpP/ZpX3fGhu3azbe9Oo5QhJDiVQVyP2Sfp3FX43YxCX7IqdzViBn7ob9+UiBBYIzG3PlCLy9Ae8caUuM79+6bAN1QlQqPWDDHhAg+o6KR4QP3Wrujg8EZT2kvEaW2IeEb9YGZJPCxNKmvN0sp0Jq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786059413; c=relaxed/simple;
	bh=vnLOYKuncVcjJxpKnUglkawzKiqOPtPepUlhfI+oXJw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=H0AiQmQoeb09lCGBx/rH5g2+R4B8EWrTHxBYwzRftho7CO4y9wtdtkPOJkaB5Ay26+8rGK1Zr8BP2IwExiaAAI97ErllIAxkh+ceUQU4S7y/knaLCr9vScsiPgfkL5oskajQ+kOfMRB6fuObOarYntiRDSzBBYuBLubfrMSCqn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C4fBKN+1; arc=none smtp.client-ip=209.85.210.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C4fBKN+1"
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-84e024d2129so4668690b3a.2
        for <virtualization@lists.linux.dev>; Thu, 06 Aug 2026 16:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786059411; x=1786664211; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:reply-to:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GbCVidvwQkuTYRlTXFKmfz6LBshlnXLBUNEqveo1L6E=;
        b=C4fBKN+19CB1p4yaG0M1+JAuG3nzWKm+qL9Sk1O2HUPRguxRky3n6rSJBjaqoThPgw
         MR+oIxlx+h9dZ6cVMmDa9TC5icuzyqaOE07/o4V7AW70p41PJ6rB6oTsDzxt5W8gsVun
         eZ8aBtIzbnWuiJM9e1HBHdduhdVRFuAX/EJvxPr24Iw1iPbRPLId5m5sJDK3XKlUDREb
         0DzInqvpC58CQSv+MEJBvRAB+vnOcVOwELwQWEWtaouKJXnNWLUicLsE0pZEr22J5jji
         8uQGs9QfC2RiV/7P3YKF1RvHN3V1Uons1RNNy8UljlKolaJnOWOoImEg9URVFbiH0VBs
         D42Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786059411; x=1786664211;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GbCVidvwQkuTYRlTXFKmfz6LBshlnXLBUNEqveo1L6E=;
        b=Zw5q7KhPvcsznsmwn/GlRRWMX3pu8Zyq/ZSn4tQBmxQrvdiQ2MzhZDnH9FA7dyo1pn
         kLTe/JJ5TnpuiOhMvwxkMNO9E/G6ClLQvM2LqMOzHP9A+Oz7zeKGpjeFhBeVHlYSJ8jP
         qaIliA4UddObc8b0xc9Ssw0UmQ1zfKvrm2riiSUlP1HhDXPQ/R0p/Im2nLuC9Lp6K9Yi
         e71ZbKLkElYYwkAlp+6LcWiRuPdTt7Ju2grUPFXQXZHLYCTFENpfAoFEVx0li/+JgVXZ
         uv2/ECxYYITqgaatTFmYeVjxY+oxMn5gZrrfmW4jxPSotGN01Ka/qQQlW46M/Q6KKXz8
         kwoQ==
X-Forwarded-Encrypted: i=1; AHgh+RolPtky1qOBuShlOZxjrpednWJYjCZUlse2732TE8BvAQGdShGeVPNO5WsTJBtoaJlFTIapb5PdS2jZKLS44Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YxBN7U0yiaErvIACrS2bBcYJgywmS2h8k4p+WeIOgdJ14zrSUSJ
	sJwPSkiqR/wk25HjYzPPiOqgc+cfwaqQ2nIX0byX7q1JGB/We61NzQoABxPEl4ezrIOvmEu3z0B
	Cokzfyw==
X-Received: from pfbll6.prod.google.com ([2002:a05:6a00:7286:b0:84e:a25:1e6b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3a12:b0:848:354f:4f8f
 with SMTP id d2e1a72fcca58-84f2dff3015mr20822585b3a.22.1786059410525; Thu, 06
 Aug 2026 16:36:50 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  6 Aug 2026 16:35:38 -0700
In-Reply-To: <20260806233609.212337-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260806233609.212337-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260806233609.212337-22-seanjc@google.com>
Subject: [PATCH v6 21/51] x86/kvm: Obtain TSC frequency from PV CPUID if present
From: Sean Christopherson <seanjc@google.com>
To: Kiryl Shutsemau <kas@kernel.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Juergen Gross <jgross@suse.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	John Stultz <jstultz@google.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Stephen Boyd <sboyd@kernel.org>, 
	Miroslav Lichvar <mlichvar@redhat.com>, x86@kernel.org, linux-coco@lists.linux.dev, 
	kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	xen-devel@lists.xenproject.org, Michael Kelley <mhklinux@outlook.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>, 
	David Woodhouse <dwmw@amazon.co.uk>, David Woodhouse <dwmw2@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

From: David Woodhouse <dwmw@amazon.co.uk>

In https://lkml.org/lkml/2008/10/1/246 a proposal was made for generic
CPUID conventions across hypervisors. It was mostly shot down in flames,
but the leaf at 0x40000010 containing timing information didn't die.

It's used by XNU and FreeBSD guests under all hypervisors=C2=B9=C2=B2 to de=
termine
the TSC frequency, and also exposed by the EC2 Nitro hypervisor (as
well as, presumably, VMware). FreeBSD's Bhyve is probably just about
to start exposing it too.

Use it under KVM to obtain the TSC frequency more accurately, instead of
reverse-calculating the frequency from the mul/shift values in the KVM
clock.  Use the information to get the CPU frequency as well (kvmclock
feeds in kvm_get_tsc_khz() for both TSC and CPU calibration), as the info
from CPUID is superior in every way; whether or not kvmclock should be
overriding CPU calibration in the first place is an entirely different
question.

Use the info from CPUID even if the user explicitly disables kvmclock, or
if it's unsupported.  The PV CPUID leaf has no dependency on kvmclock, and
is in fact more useful if kvmclock is disabled since the kernel won't be
able to use kvmclock to derive a derive the TSC frequency.

Before:
[    0.000020] tsc: Detected 2900.014 MHz processor

After:
[    0.000020] tsc: Detected 2900.015 MHz processor

$ cpuid -1 -l 0x40000010
CPU:
   hypervisor generic timing information (0x40000010):
      TSC frequency (Hz) =3D 2900015
      bus frequency (Hz) =3D 1000000

Note!  *Independently* query for non-null get_{cpu,tsc}_khz() overrides so
that kvmclock doesn't clobber x86_init.hyper.get_cpu_khz() if/when KVM adds
support for getting the CPU frequency separately from the TSC frequency.

=C2=B9 https://github.com/apple/darwin-xnu/blob/main/osfmk/i386/cpuid.c
=C2=B2 https://github.com/freebsd/freebsd-src/commit/4a432614f68

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Co-developed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/kvm.c      | 33 +++++++++++++++++++++++++++++++++
 arch/x86/kernel/kvmclock.c |  6 ++++--
 2 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 5b554e480c0e..8ed02f4f5775 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -49,6 +49,8 @@
 #include <asm/svm.h>
 #include <asm/e820/api.h>
=20
+static unsigned int kvm_tsc_khz_cpuid __initdata;
+
 DEFINE_STATIC_KEY_FALSE_RO(kvm_async_pf_enabled);
=20
 static int kvmapf =3D 1;
@@ -913,6 +915,21 @@ bool kvm_para_available(void)
 }
 EXPORT_SYMBOL_GPL(kvm_para_available);
=20
+static u32 __init kvm_cpuid_timing_info_leaf(void)
+{
+	u32 base =3D kvm_cpuid_base();
+
+	if (!base || cpuid_eax(base) < (base | KVM_CPUID_TIMING_INFO))
+		return 0;
+
+	return base | KVM_CPUID_TIMING_INFO;
+}
+
+static unsigned int __init kvm_get_tsc_khz(void)
+{
+	return kvm_tsc_khz_cpuid;
+}
+
 unsigned int kvm_arch_para_features(void)
 {
 	return cpuid_eax(kvm_cpuid_base() | KVM_CPUID_FEATURES);
@@ -962,6 +979,7 @@ static void __init kvm_init_platform(void)
 		.mask_lo =3D (u32)(~(SZ_4G - tolud - 1)) | MTRR_PHYSMASK_V,
 		.mask_hi =3D (BIT_ULL(boot_cpu_data.x86_phys_bits) - 1) >> 32,
 	};
+	u32 timing_info_leaf;
=20
 	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) &&
 	    kvm_para_has_feature(KVM_FEATURE_MIGRATION_CONTROL)) {
@@ -1009,6 +1027,21 @@ static void __init kvm_init_platform(void)
 			wrmsrq(MSR_KVM_MIGRATION_CONTROL,
 			       KVM_MIGRATION_READY);
 	}
+
+	/*
+	 * If KVM advertises the frequency directly in CPUID, use that instead
+	 * of reverse-calculating it from the KVM clock data, or worse, trying
+	 * to calibratate the TSC using an emulated device.
+	 */
+	timing_info_leaf =3D kvm_cpuid_timing_info_leaf();
+	if (timing_info_leaf) {
+		kvm_tsc_khz_cpuid =3D cpuid_eax(timing_info_leaf);
+		if (kvm_tsc_khz_cpuid) {
+			x86_init.hyper.get_tsc_khz =3D kvm_get_tsc_khz;
+			x86_init.hyper.get_cpu_khz =3D kvm_get_tsc_khz;
+		}
+	}
+
 	kvmclock_init();
 	x86_platform.apic_post_init =3D kvm_apic_init;
=20
diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index 29ca37e9a3bc..f55d0305d1f3 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -342,8 +342,10 @@ void __init kvmclock_init(void)
 	flags =3D pvclock_read_flags(&hv_clock_boot[0].pvti);
 	kvm_sched_clock_init(flags & PVCLOCK_TSC_STABLE_BIT);
=20
-	x86_init.hyper.get_tsc_khz =3D kvmclock_get_tsc_khz;
-	x86_init.hyper.get_cpu_khz =3D kvmclock_get_tsc_khz;
+	if (!x86_init.hyper.get_tsc_khz)
+		x86_init.hyper.get_tsc_khz =3D kvmclock_get_tsc_khz;
+	if (!x86_init.hyper.get_cpu_khz)
+		x86_init.hyper.get_cpu_khz =3D kvmclock_get_tsc_khz;
 	x86_platform.get_wallclock =3D kvm_get_wallclock;
 	x86_platform.set_wallclock =3D kvm_set_wallclock;
 #ifdef CONFIG_X86_LOCAL_APIC
--=20
2.55.0.679.g6767b8d81c-goog

