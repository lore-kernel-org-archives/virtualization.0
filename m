Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E09429DAD
	for <virtualization@lists.linux.dev>; Wed,  1 Jul 2026 19:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782934410; cv=none; b=EAQUqymsseJiXTTYx8MeHupdHuTIpeiLaKxNPLUHsWmlgPjGi2mbYfe0CBbNpTwEaXB/yCXgjaAQ6VFFz/uL11H0HeW/ANp4ikW4A7v/UeX9s5oq4RtYBMg5raP3xWu+dkg90TcQnIq5g+sySH4oAPiK3OZ4ubpAQ9LyTkMgHsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782934410; c=relaxed/simple;
	bh=y0eTf6sBBqtgXOMcKj6+dRH4mQYHxDct/p+oWayuTuo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=u4CJpGh0TzI0EMOFa9pAAXIyZWOmATzzpRQibOC46TESOCEo7NrrAR7OPMonhe9rpdluapZzkcNxjwhxY6z3lAS6p4GY0HhWt194U02Q52VOdGO8z7pJJwj9GrdDa/02seU2Q2Qigag0LWTM8lWaTu2PbEBZytctb2H7aplO3hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ORv/wTaK; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ORv/wTaK"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2c9b1b608e2so14576765ad.3
        for <virtualization@lists.linux.dev>; Wed, 01 Jul 2026 12:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782934404; x=1783539204; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=KILxImADtcVlkoacCtqYmxEGcZEGxD9ytdtd9JfAHyU=;
        b=ORv/wTaKsBNfrlgPBKO36ChLCvIYqPwt+9YgP2EYpb107ecgI+M6x7F4Asrp14zCL6
         P6NwaDasmbBajfykLu+Odi07szGE8BbYtW/T9BLAxfLqV29xo3tsqL3H0G8k/dovuaH7
         kwYTeFNkhaYGlJPcbfzVtA0soBGDTYwtAvY+NrGl9Y1bNR2dz1e+jdRx0E4JYpNtlVuC
         qxqvTybx+4bfBuSCwtg48ZsRALQRFyVPNxYzgfGe5TnJ5bjbSPUdcIL4h1wpB9s7mHM0
         9Ebb+z1kGb9uz+VSwmKTJfZZiAm/VBVf5G659v54ZKJwZOfiAVBLlY7vQjH8xxWQa8Rd
         zZ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782934404; x=1783539204;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KILxImADtcVlkoacCtqYmxEGcZEGxD9ytdtd9JfAHyU=;
        b=dCfLSoCrC0/JP++kRNviVqpZ/is06MEpXrlZ6DkqyZR64goFprBAQ5ywjtfpM5Sjzl
         D7Afgj6xLQQwci5tllD5yUEnqz40rjV3+C2pXzUhuc4JYJQUP4pMUlrLnqZsgg0G0RHp
         Kf+kYqkpojSpPmQRIftG2zLkuPFRguQf+wUzZ3jV88uIBCyUZRCChtG+Xif9zm6jSKXU
         OMEPuDXp2YBHckYxIRgE41HxEhMEWsevTFf7wRYUV/8dft1rqX163pJopD4FZGauuSoO
         X68kedJPqSR3fyDP62+vn9CoFPbRpQcjy1wIzkUO9fd54iBVZS2tZKN78jSGf4spDb52
         SUFQ==
X-Forwarded-Encrypted: i=1; AHgh+RqVh5hLsljK3fIzkmpRiet0lkvOqINgEW72OBzf9QNiuF9e2UX+eP03aADcofGnQc5KKNXz0ne25NUrUbKlGw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzR9wzBLktMDYkTg4VPlEb+VUKjeSAl+hqdZMn6JjVf41oL4afT
	nPg0t56IShxTWrS0RcNOGnILlxlQT1EvKgs5NVTS4Ogyh+V39BZMRjLlf9KYXqME+MqzYVkSih7
	RZvAJ4A==
X-Received: from pltf1.prod.google.com ([2002:a17:902:74c1:b0:2c7:5af7:37a3])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:c952:b0:2c9:c169:7483
 with SMTP id d9443c01a7336-2ca7e87dc6bmr34187285ad.37.1782934403691; Wed, 01
 Jul 2026 12:33:23 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  1 Jul 2026 12:32:08 -0700
In-Reply-To: <20260701193212.749551-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260701193212.749551-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260701193212.749551-48-seanjc@google.com>
Subject: [PATCH v5 47/51] x86/paravirt: Don't use a PV sched_clock in CoCo
 guests with trusted TSC
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
index 012321fed5e5..a146fc7b5e74 100644
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
2.55.0.rc0.799.gd6f94ed593-goog

