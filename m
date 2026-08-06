Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CF44A09F0
	for <virtualization@lists.linux.dev>; Thu,  6 Aug 2026 23:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786059412; cv=none; b=N9sV40VZbwZ/GH79A22TN9b8876LLUWBoU7Tg8ZJhnHKq5TdfaKly07GcBLFBgVbNBDPtSshb2BgZNHOLS7VP0LykK4Lrfvb+ydalMik60Q4Jpnczw6CJrD9HKJ6boUzzZeFEtbM5pngLqMz99yuvxFFaKfe4/uxXOHoHkgTIdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786059412; c=relaxed/simple;
	bh=YuCMxhXTIsqx6zpcODEUb6qXKu+EziAmx+3M3LR9+3o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UMqjNtuqlO6w4VWh6RmdUjsVEshmm0IUNEnoAsVL1ORHyKtGl+Y+VqOMfFA9qNZVZY7y2TYJJ0yqtmCqA9FPz82mN15eiLBtNp2z4jt5kGk2IxrurCcuh1kPzGyEbyW4K0zWQDvZfslompawRrusnopBV54SRe/HfA9lWoaztYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nmoI8QgN; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nmoI8QgN"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38f283baf1fso2571717a91.3
        for <virtualization@lists.linux.dev>; Thu, 06 Aug 2026 16:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786059410; x=1786664210; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=eYIjdKzjgH3nVD0iNsx5sVBVp8XFdFFsnkR62+s/p+Q=;
        b=nmoI8QgN6s+CnYjGkTHTEb5soHzeoaV5DFmdyEHIm6goLrj5mb7JoZwQrqgI5zWI4H
         f6L/HIrE8sFKuOO5LFzALCRcyHwYQ9n7JamD+c5alR/HJwTcEIEeDClpMNRYhlJk33bl
         PkYv+EpcRW7C6MOryTs/Aev5KwfgOA40Tz1lRQsY7O72NJD65UzbBJwXA8WlFL6AftJR
         x7a0wT+yh3gAVIHBTLjIGxOnvXi3wXcU37c49SMGcsfkOxW7/yk/KbO03icLgYrb1HCK
         8swWVCKaQrgD/TE9zVi/wAlbtYL7udf0O4JeR1cMaiemsYx3bm2rVq7Bx+o9MeNb1P51
         9FYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786059410; x=1786664210;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eYIjdKzjgH3nVD0iNsx5sVBVp8XFdFFsnkR62+s/p+Q=;
        b=cMoRkIomeJUn/KVy9vX6fNV8e77nQOtZCXzwkwhp669tmLdvtwG1uZXp8DOHmJ8V+r
         clNKIVfBhXPv3A7mwPsPO2S4H+3v2wYH/qXm6SORRIwhf3sVCmEK7s7v/Z11U9lg7eZB
         hzk5wvZIA9ghzRjwhXvoGB4boZe4m5+LLQmhL9Tmi9aYai4KZXjqqn5qoDVpJS56khzh
         Y4U/Cy+aDjkI+HSlFGv9AEdqTSZAXw3Ogp5r5IRFAl+1FD6uHqnygIqU7MrkOHATD2n3
         vXzr4ugsl3+5dhwnBgj4Vbg0OjQRYNcunyY3v/8NaOCAZ5kaWb55B5EDoB+JBv6ljTS9
         PoHA==
X-Forwarded-Encrypted: i=1; AHgh+Rq65qlacXWNT4Tzx3AbTQCmR/ylWBmUhCaMGege3CfqZC6HhjZF20RX8+Co6kzhWXEuXLIrKKLmIYkNsUF/xA==@lists.linux.dev
X-Gm-Message-State: AOJu0YycN0TbGGA8on7+9zc/3o9kObFIHxacmoggPVJRcLEgbiPVw96w
	g6LAQWvi61uVjO17Y6F16Zycyv8YRw6drrpKcvU2SZmbN8d9YNmB+lZ4anO8VMfpKKe+I4iPV7e
	H3MQ7xg==
X-Received: from pjji3.prod.google.com ([2002:a17:90a:6503:b0:381:224:393a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:c106:b0:38e:250b:122f
 with SMTP id 98e67ed59e1d1-3909d8d5993mr5453558a91.16.1786059409368; Thu, 06
 Aug 2026 16:36:49 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  6 Aug 2026 16:35:37 -0700
In-Reply-To: <20260806233609.212337-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260806233609.212337-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260806233609.212337-21-seanjc@google.com>
Subject: [PATCH v6 20/51] KVM: x86: Officially define CPUID 0x40000010 as PV
 Timing Info (TSC and Bus)
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
2.55.0.679.g6767b8d81c-goog

