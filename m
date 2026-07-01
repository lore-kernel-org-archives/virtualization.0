Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685734E3776
	for <virtualization@lists.linux.dev>; Wed,  1 Jul 2026 19:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782934373; cv=none; b=LDOdfEq/IxU77MczqdnzHBFDzZ9Y4ONp9gu8BzhnrgJpQsPRxUBmT4KDgcBn4b1Xo329KgQDlw9wUetkxDc3jIVrSU5StVpE6dRvW4+PBB4dRCUXui6pLJB+IekECUX4VEEjRFiomNzwH0UnobA1NQCsDzLqUx4yJufKaMlkrXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782934373; c=relaxed/simple;
	bh=5GEr6ZaUz9LBDqpBNqMe5y4w6C/kc2xnNXL3ExWAiBE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RX8QtPBYIkUIJbEzhCBwLT7STQ5hhmu08i9JHvG9TUd4bNe2Vl9g1vpWjI+TzKS4AKUNLV2zLDjiriwBlJK4H9EC5k0oKC4Ai39BOJLcdciGsF5aYrLWz6+UqFRNcoHjDUJcXzPezGERJc6BEA736cirWhsqGZTACZFbb9yOGD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iasIfzWB; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iasIfzWB"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c9d5a5b63c5so882683a12.1
        for <virtualization@lists.linux.dev>; Wed, 01 Jul 2026 12:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782934371; x=1783539171; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=UfbO84e0Sh/RDtmtar1VNwA0GsKq34HNdlIOIT+krtA=;
        b=iasIfzWBILfwYcF9JZ8qO1kZKrc+BC9MZsSJ2432G984WNg3l25W3FEPy9KrKzXMY6
         T62uNuyA7ZPZa3EwT++qovCbvcRoA2t7xkO2QsELQtCSZKiwih0Itknx+Q9hG9iw0/mr
         mWrnWpnBThQ5yctX4bUprI7WfkwPafXguHMPpIgNoiPGcO5tzJkCrbglB7qm66M8Gqm2
         igGFWVTqK3G/T277IsSfW9ue5OvEjxD1ougCuj6lWoDKmGYlDgR7MSaXmuGaJU2pJO1Y
         m4kTizSYEPSp4PNX+pC5QRYpq/d8PpJNqS3W0i8P4r5SvNxkctsXyZoXZrQn9D9i/iMm
         JwNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782934371; x=1783539171;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UfbO84e0Sh/RDtmtar1VNwA0GsKq34HNdlIOIT+krtA=;
        b=Yz1KxzUfCR7VrQfTGl9OSVyAHQkegce18Hzsbu7n/1MZnz7+wQ17FHNs6jjgEc91M+
         jJm05iIhLy9Qqfu9vBVxhAKWr3DXG1tnv03SA1riaWA4JbxmQ6sAhdRRMi7gPPb2xvhF
         n89WxGpCgCBQq3mZzO7vWLfHMrdEezk+Fy/rCxatUELEacJ/cq7Oma5jGi6p/9qAjx9/
         3Mvxi/CHkRsdZABr++OLzrEtphfn66pk8AbJm3Yx/yNZ3sDTQZJ+O47EURJEAbuzzi55
         BbGQU3wi1gq6PYROKAXy0BU1k5bUgnPbNtc5RkQc+nakSOhMLm0iq7S3SxvXD9RwWNOh
         LZ4g==
X-Forwarded-Encrypted: i=1; AFNElJ/Qo8hdFwJ9GUu9Oq5zRabjwo3Wcpqk6a4wsVRlGi7fhEuxwcqXpx//l5yFES5TNsj2I9Yel4r37ABY7g9ndA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx2ZaZl5oXRTg/RU19bV/BAzbQ44tnpfnLhpB4W7D2XVB8AWLjP
	2CCDsOJB8B74Y8QEHpYVOdJGvZPbPBPiTVzApeOZXri2qswHFHnAg9zxdOW5l5CjVQ5CYuXOyeH
	3Nl3HJg==
X-Received: from pgkm12.prod.google.com ([2002:a63:ed4c:0:b0:c9e:1056:de15])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:b7a7:b0:3bf:6011:53b
 with SMTP id adf61e73a8af0-3bfed47e0eamr2900412637.38.1782934370392; Wed, 01
 Jul 2026 12:32:50 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  1 Jul 2026 12:31:41 -0700
In-Reply-To: <20260701193212.749551-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260701193212.749551-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260701193212.749551-21-seanjc@google.com>
Subject: [PATCH v5 20/51] KVM: x86: Officially define CPUID 0x40000010 as PV
 Timing Info (TSC and Bus)
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
index bda3e3e737d7..a5ee8ff052ce 100644
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
2.55.0.rc0.799.gd6f94ed593-goog

