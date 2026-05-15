Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D02A403404
	for <virtualization@lists.linux.dev>; Fri, 15 May 2026 19:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778872888; cv=none; b=qIJ3nP+zsz9jL6wbjPJtfFzLL93lhOkYUgMmAqDxCDvZivg90o6QK7SZDxE3oYEks/vQI1ZwM24WdXRV9yGXFFTergQSA10XkCwQZ+OYrOAHO1KvusX99BNzDcHI+8irqpqoX/8Prm1mLIjTdr6YPuhKdjgOzoMYImsuPfKTLp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778872888; c=relaxed/simple;
	bh=QioBrwKpRdsCytYFTzNNbiVitx8MQJE4M4sQvpXgFXY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SqOIlarFsfYM5Ya5UmTCTZDFK0JicWLaHMEeaf1U+8gk6GJSZyVTZ778/9ME0olx9ViWxlAv6qlGWJkyZ9ULiFbCfCRVBGkAcVbj20Yx3wP8svnuDhOTibjTL5xYscIjnYz45aNtGLE7rBAYIRLYQPXceM1AqLnfurdU8W/mFj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cBnxmMln; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cBnxmMln"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c8294d8c48eso84473a12.0
        for <virtualization@lists.linux.dev>; Fri, 15 May 2026 12:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778872885; x=1779477685; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=5BJQi7ZR1svDe2KF7RHkPrmL6MBNA7Dkc8gFvThdUD0=;
        b=cBnxmMlnSczUfCvjJ4IK0it6gclw0HudADy8FxyLeawlGnFu0WTD0rweIcI9/ewOF8
         P7iOwpXLvm0IkKLDNMz2IS/3yj6+MjaenaRgMmglgC0Rx6u35JPrnMHpJkhQooXtvIR+
         ToGCJOm+MkE0i/zEVzPQJ3MTtnS6p4/TzKRoVItQTROQouNfN9Jd+r2UB3D1dPEafuYA
         gIPIbLdleqTqWNNPZHJUCyq7GtD+td0C+zGNry32vfmbHgQk2K70+ThwQ2AEB1vlVkMQ
         E3akH8Rtm2mMWTMYJ9bHobA3SQV/A1vTUOJnj/ptj3rM8YHdUJD79eiuvymp937IKWQ0
         s2Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778872885; x=1779477685;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5BJQi7ZR1svDe2KF7RHkPrmL6MBNA7Dkc8gFvThdUD0=;
        b=RP15/Pw0zV628fGP3ki8QdihsMUk/v2FhWLvwbEOxzQWlw85nnan4chk+0ziExU+Dg
         tus31cbl8QY93i8dGljmdyqEipebzoFUaBz6KsdkkfbkAC4bAUBAeK4rE11Bv0FqslGs
         DdvWaxZPN2oHj2iLGj2wGDxj1z2CdNSRRQf1RlsCF3/dfzh70crYDnUwt9bMy3B5wfPi
         0x/0MCX69+rVScpw6VHtFeIoHUv6qHRCzSg+j4QdEo2KyZSMVPgoPrLZWWTgEVamK1xS
         nvkx220+OtBJ/iqa79wX6Pcl4IvwO5S2MaiMJdCdd/ZqhysCM6kXx7Hhu08jRdrcVKZv
         Zq0w==
X-Forwarded-Encrypted: i=1; AFNElJ8FD1VzyZOGg9w5LCosdEa2aCZ2jgw0YtJz6jmukkrdplwpmcVOkygwV8pWU9oxRvF6zNtyg0VavLXTzkFcaQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyksa7oPTYpPdkHr26ZJTFPkLDmbCXuaCEdY81yiWQBJuH1wjAe
	GyTth8zhhd1oewxIXfwIZyYiBvaPramlPFgoN3xexdIuGymGkpUc5HXdyNwl04sKkO2/prPZ1FV
	c9GGN9A==
X-Received: from pfbeq4.prod.google.com ([2002:a05:6a00:37c4:b0:82f:344e:386a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:9502:b0:838:1c02:2763
 with SMTP id d2e1a72fcca58-83f33ab667bmr5736284b3a.9.1778872884225; Fri, 15
 May 2026 12:21:24 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 15 May 2026 12:19:42 -0700
In-Reply-To: <20260515191942.1892718-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260515191942.1892718-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260515191942.1892718-42-seanjc@google.com>
Subject: [PATCH v3 41/41] x86/kvmclock: Get CPU base frequency from CPUID when
 it's available
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

If CPUID.0x16 is present and valid, use the CPU frequency provided by
CPUID instead of assuming that the virtual CPU runs at the same
frequency as TSC and/or kvmclock.  Back before constant TSCs were a
thing, treating the TSC and CPU frequencies as one and the same was
somewhat reasonable, but now it's nonsensical, especially if the
hypervisor explicitly enumerates the CPU frequency.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/kvmclock.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index 62c8ea2e6769..7607920ae386 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -190,6 +190,20 @@ void kvmclock_cpu_action(enum kvm_guest_cpu_action action)
 	}
 }
 
+static unsigned long kvm_get_cpu_khz(void)
+{
+	unsigned int cpu_khz;
+
+	/*
+	 * Prefer CPUID over kvmclock when possible, as the base CPU frequency
+	 * isn't necessarily the same as the kvmlock "TSC" frequency.
+	 */
+	if (!cpuid_get_cpu_freq(&cpu_khz))
+		return cpu_khz;
+
+	return pvclock_tsc_khz(this_cpu_pvti());
+}
+
 /*
  * If we don't do that, there is the possibility that the guest
  * will calibrate under heavy load - thus, getting a lower lpj -
@@ -434,7 +448,7 @@ void __init kvmclock_init(void)
 		kvm_sched_clock_init(stable);
 	}
 
-	tsc_register_calibration_routines(kvm_get_tsc_khz, kvm_get_tsc_khz,
+	tsc_register_calibration_routines(kvm_get_tsc_khz, kvm_get_cpu_khz,
 					  tsc_properties);
 
 	x86_platform.get_wallclock = kvm_get_wallclock;
-- 
2.54.0.563.g4f69b47b94-goog

