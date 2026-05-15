Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95BB240EBAB
	for <virtualization@lists.linux.dev>; Fri, 15 May 2026 19:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778872876; cv=none; b=OlGzE9gwjiLYm3n2xqvgGHCvFcPSfRlbOGu0YVIHMVk1Rw+bS69zotre9PcWjJc8k99IrTE/JqCgp5kgkrAw91wBLrV6WKqv4njb1r2+OQCwcR9A7mgzAxUskyiOs0U6oey7c4lxBLPnPZ9QxI9MZW0icNJTwNl4ibbM6YRRZPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778872876; c=relaxed/simple;
	bh=B/Nd88zreMJtUwVM+EKuE0OYb6EhoS4ohLt5CAFmh34=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VFl+XXpwI34Vook68W4r3HohGshR0RbZPULeO+jeSzWbvf5gmIM19QT9G82CrlNxMpzkApfT0ajHbQRcc9TErQGofYKuniEWvF0WFx/jHSVKHQ2tRYfM5aXYG64MUEz2SrOZNHh4KztrN3WPRd3OzBwZlo6NVIIMoH+kvtlL1so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jEujuRgz; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jEujuRgz"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-8353b042152so237895b3a.3
        for <virtualization@lists.linux.dev>; Fri, 15 May 2026 12:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778872874; x=1779477674; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=vVLX5t3yX9DiZyDHfD7io13ZG0m6EjUCrIAXjsJko2U=;
        b=jEujuRgz9/2h3q4u/KrUBjHquT0pazIMxt4L0RnnftUKL00nhOmaQ7VP/URJQdZVjc
         0cZIaYjqiVuwJ8j8MwWk7FfqwpUWPirAQvAykx5UfqbV3554Fek8fjjHsBwB67XqeyTr
         uSxpn1Y9tP4ql1BwFteVy7WOiZgtcs2H1wJL25xyeJNAvokIJc7G9uQwHR85Ub/nd380
         aKOZ0la7E0B8H8byRhlNjeFziTAW4shqdDyyHgjB1ruznvEQTM1F4Me5Ir1BnzNdoyti
         YIQAxpsawZGpsYPVaO4xxCI+vN4gXHisbuhm0+bSmb7lWqteSjdH77IFajnaEwYG/8ex
         kq2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778872874; x=1779477674;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vVLX5t3yX9DiZyDHfD7io13ZG0m6EjUCrIAXjsJko2U=;
        b=cBWNSXeHY1nw3tW2I43lpp/uCQo3+dMPfBLr2j/X562TfWyUZUzQOzNU8gUswogFe8
         pEowTv8nUlS/pV6TTCBrUCagnsog1C2J2DyRKotCmCavBedsg3b6ES/owWVQkbf527jy
         iQ1HtYfVaPlSNe4wrMhcr6CHTqxUsBqT+sxkTNvNzXXwkE/g9uDD1EsGwJQtETAptrPZ
         CSruAfWklbaXtcIVimmuUVBjTLc6IapMEugLM8LBeHAWTRXzg9zDTGQgJ5vJKw7GSxF4
         HNnu2f9lYAYxjS1ssaMeptv9IPpSAoBGuBz31eyAz9puBiwH3BDbQLqMYpULWzEe/AN1
         gDeg==
X-Forwarded-Encrypted: i=1; AFNElJ9dQsSdngfhN40mm7l23vg9hCIj/TL8UhSBRUy3Gy2Ls8ivL/CxxuItnC4KlUSZ4bNrTi1YdIBhrnOoZDcKIA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxJrDDGQvF8WW61bDEXxjY6Fz5qWocmc4vSGzDivcUyWSZovZnK
	hb927GjfByGkabn+Xaft7HPc4JnlW2R4CwPQWpF44vYavVnZAiIWdd8OdWMFrUp7vm9Dw+BlkXh
	PuhFXFQ==
X-Received: from pfoo22.prod.google.com ([2002:a05:6a00:1a16:b0:836:d115:1e44])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:299a:b0:83b:c487:43d2
 with SMTP id d2e1a72fcca58-83f33df451fmr5925936b3a.36.1778872873374; Fri, 15
 May 2026 12:21:13 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 15 May 2026 12:19:35 -0700
In-Reply-To: <20260515191942.1892718-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260515191942.1892718-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260515191942.1892718-35-seanjc@google.com>
Subject: [PATCH v3 34/41] KVM: x86: Officially define CPUID 0x40000010 as PV
 Timing Info (TSC and Bus)
From: Sean Christopherson <seanjc@google.com>
To: Kiryl Shutsemau <kas@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Juergen Gross <jgross@suse.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	John Stultz <jstultz@google.com>
Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Stephen Boyd <sboyd@kernel.org>, x86@kernel.org, 
	linux-coco@lists.linux.dev, kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	xen-devel@lists.xenproject.org, Michael Kelley <mhklinux@outlook.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>, 
	Thomas Gleixner <tglx@linutronix.de>, David Woodhouse <dwmw@amazon.co.uk>
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
2.54.0.563.g4f69b47b94-goog

