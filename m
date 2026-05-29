Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9693FB7F4
	for <virtualization@lists.linux.dev>; Fri, 29 May 2026 14:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780065913; cv=none; b=bSNIqi7K6BWM9D9MvEegXOfSeINTe1olgwpQk/KH0osMPMe9Bij188wyy6k5FUdw2pzyOdZsCwIbp+gW0/TWh1LrcSOUlcrfLjI/kv6TJRZfyU7Jl+mP9klvKr4MPg99bEc+KIHgCq+7XSUofkEtNo2kKiTSqWF9Qyz/nkuDlwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780065913; c=relaxed/simple;
	bh=jHrseVAKRqGmwC9Fe/Np6DB+hJz8SxDvyvMk6X++Bss=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=F3V41AV258Bi/IiEiz/BYBz131gc0KhWwmKOeCjVPheQA1DS6H3kKqe7IMCGKZ3PGBgLsVPWtc/EZdhd7mNiIlgTXa14Fg2vvLGKsgfiOko5vVEqx88A8EJqW7sOws8Gac56OikqRF4DMVJAbyXizult5+4VlRTRYCGNCC1Tmxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XZyXcoGs; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XZyXcoGs"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2bf32fb7cb2so1508355ad.2
        for <virtualization@lists.linux.dev>; Fri, 29 May 2026 07:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780065910; x=1780670710; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=Tb2qB/MKxqPq5hP5Gb3eErmk5uhqs24IfPhH0/tbELk=;
        b=XZyXcoGseEPsoO3BGhEOZE2TFGXZcf1hfRFneXobrBOxP9phXAdUEoVO0wcbHRsIfx
         4kq2pglhbIPr+IjcRdjWXN6bNoPalOLi4wTa9mHWAsRxvhxGi71TYRc8n/JalGGt81Gl
         26Y5zZjJwJQp1QZtmRmCWP93PG6YU7gL9YZLrVxUkYwHDHEOI3JzT6MGT3M6Ha6UgxnF
         VuyKWSnYWkt7HtW3mVl9msukzYhftDjAmU6xq4OpkqfWdEkhSyxa80RDwZgwPomfhwoI
         4G/3eTdeYkESK7yxxPFxKJkBy1PTclU2pmTqr6kQvp1FFf9sgJzpOc9mxx3vC4LmrQK6
         eraA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780065910; x=1780670710;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tb2qB/MKxqPq5hP5Gb3eErmk5uhqs24IfPhH0/tbELk=;
        b=rFFxdf4qjAagKwG2/B08f0/Kgx/yg2eX05GZs24fzqE3TgRKNjnjDvreNBH8N4sVfF
         4shHheEJMdE2hRGTKBaGkrJLiC4hVcFjthJBOacLOriAOP9zNKLLjWXB+wwo8Iw0Ld83
         21WcKaeROWlBfT/UdlAtea6i2Q9nQAOyrnJlxe1xBLCpRye5Wr+UCAjFUGkmmbI7AiSP
         X2QwIlGGfkWaxVPUODOJ4z/4DJMn4CqcYVUFfjRcYDM4ML/vkhsvDEgfraD8XagGr24v
         3sQyhtS4xfxCEz4hNKNhhpyhLDGvw5jkkERE9kyzmW3PPaAgiYBqEUFbuqEAAc5+dddF
         zF+Q==
X-Forwarded-Encrypted: i=1; AFNElJ8vaymmGDJwFGWej2mu3gJ10Fa/rPg+Hh9Az/BwUMQFsxXi2pYk14/HszgCJdVbG4rnxzp3ZCgR/HMIwMbhUQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyZAhVKLDXY5iwavmgV+NOa5BlqCvfHD/frdTGnXYxbM2tWdQvi
	35o7/sH9ijGQGgaCegkJT+DZhfohtM3Fb7pfI5jc2TOfLdpnkoI/nUKX2uWKntL8hHfasQfRgRC
	EkZKrbg==
X-Received: from plpw17.prod.google.com ([2002:a17:902:9a91:b0:2b2:4f3d:3df4])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3888:b0:2b2:ec31:25b0
 with SMTP id d9443c01a7336-2bf3685ac3dmr1280905ad.29.1780065909849; Fri, 29
 May 2026 07:45:09 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 29 May 2026 07:44:02 -0700
In-Reply-To: <20260529144435.704127-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260529144435.704127-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529144435.704127-16-seanjc@google.com>
Subject: [PATCH v4 15/47] KVM: x86: Officially define CPUID 0x40000010 as PV
 Timing Info (TSC and Bus)
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

Formally define and document CPUID 0x40000010 as providing TSC and local
APIC bus frequency information for KVM's PV CPUID range.  Way back in
2008, VMware proposed (https://lkml.org/lkml/2008/10/1/246) carving out a
range of CPUID leaves for use by hypervisors.  While the broader proposal
from VMware was mostly shot down in flames, use of CPUID 0x40000010 to
provide TSC and local APIC bus frequency information survived and made it's
way into multiple guest operating systems.

XNU unconditionally assumes CPUID 0x40000010 contains the frequency
information, if it's present on any hypervisor:

  https://github.com/apple/darwin-xnu/blob/main/osfmk/i386/cpuid.c

As does FreeBSD:

  https://github.com/freebsd/freebsd-src/commit/4a432614f68

More importantly, QEMU (the de facto "reference" VMM for KVM) has
conditionally provided timing information in CPUID 0x40000010 for almost
9 years, since commit 9954a1582e ("x86-KVM: Supply TSC and APIC clock
rates to guest like VMWare").

So at this point it would be daft for KVM (or any hypervisor) to expose
0x40000010 for any *other* content.  Officially carve out and define the
CPUID leaf so that Linux-as-a-guest can follow suit and pull TSC and Local
APIC Bus frequency information from CPUID.

Defer providing userspace with the necessary information needed to
precisely and accurately enumerate the _actual_ configured TSC frequency
to the guest (that exact information, along with the scaled ratio, isn't
exposed to userspace).  As evidenced by QEMU, providing CPUID 0x40000010
without help from KVM is entirely possible, just not ideal.

Link: https://lore.kernel.org/all/ea0d7f43d910cee9600b254e303f468722fa355b.camel@infradead.org
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
[sean: drop KVM filling of CPUID, add documentation, massage changelog]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 Documentation/virt/kvm/x86/cpuid.rst | 12 ++++++++++++
 arch/x86/include/uapi/asm/kvm_para.h | 11 +++++++++++
 2 files changed, 23 insertions(+)

diff --git a/Documentation/virt/kvm/x86/cpuid.rst b/Documentation/virt/kvm/x86/cpuid.rst
index bda3e3e737d7..f02e395cfa9b 100644
--- a/Documentation/virt/kvm/x86/cpuid.rst
+++ b/Documentation/virt/kvm/x86/cpuid.rst
@@ -122,3 +122,15 @@ KVM_HINTS_REALTIME 0            guest checks this feature bit to
                                 preempted for an unlimited time
                                 allowing optimizations
 ================== ============ =================================
+
+function: KVM_CPUID_TIMING_INFO (0x40000010)
+
+returns::
+
+   eax = (Virtual) TSC frequency in kHz
+   ebx = (Virtual) Bus (local APIC timer) frequency in kHz
+   ecx = 0 (Reserved)
+   edx = 0 (Reserved)
+
+Note, KVM only defines the semantics of KVM_CPUID_TIMING_INFO; KVM does NOT
+advertise support via KVM_GET_SUPPORTED_CPUID.
\ No newline at end of file
diff --git a/arch/x86/include/uapi/asm/kvm_para.h b/arch/x86/include/uapi/asm/kvm_para.h
index a1efa7907a0b..c3a384711f3a 100644
--- a/arch/x86/include/uapi/asm/kvm_para.h
+++ b/arch/x86/include/uapi/asm/kvm_para.h
@@ -44,6 +44,17 @@
  */
 #define KVM_FEATURE_CLOCKSOURCE_STABLE_BIT	24
 
+/*
+ * The timing information leaf provides TSC and local APIC timer frequency
+ * information to the guest.  Note, userspace is responsible for filling the
+ * leaf with the correct information.
+ *
+ *  # EAX: (Virtual) TSC frequency in kHz.
+ *  # EBX: (Virtual) Bus (local APIC timer) frequency in kHz.
+ *  # ECX, EDX: Reserved (must be zero).
+ */
+#define KVM_CPUID_TIMING_INFO	0x40000010
+
 #define MSR_KVM_WALL_CLOCK  0x11
 #define MSR_KVM_SYSTEM_TIME 0x12
 
-- 
2.54.0.823.g6e5bcc1fc9-goog

