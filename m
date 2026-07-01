Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91884229C4
	for <virtualization@lists.linux.dev>; Wed,  1 Jul 2026 19:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782934391; cv=none; b=NrVRAKIMO7/1CMKLcMsKcP6I+Cb6VC5lkO1TuHTv/Q/6pT9DoFZdqN90I1WOpjn0toAJXVFQsbJbaa7CyvqE5+p+MQB1Xpy2gh7A47J0H0KE17PLWQmPNXXprUAdJiZbffcBoknfIKlPN4KLZqsObnECcrYWkCMwkBkdYK1eJ2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782934391; c=relaxed/simple;
	bh=odtTAw4qAyKVMoQOFS9NQKiMBl8SSPflZ8sexqq+tVc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mJ6tlr1jc+CBtSAnum2ZYvKOI+j+FMjCoG4VwEH173haYV1VAX0Z9uz5+hfa1KABgSmb/imYvGiTSZrZwe16xo3fGvKUPre08PKj6OAtxvs2ZiIS9iBQ/c65yH+AN7OvhaIirW4V8rZqHcwOS7n6S4DSIxv5DjTjXAWk23vZMM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t5pxOrje; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t5pxOrje"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c88e0f04e51so737698a12.0
        for <virtualization@lists.linux.dev>; Wed, 01 Jul 2026 12:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782934388; x=1783539188; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=qFfbhUmYyCU6tRW/uev50JnnPJRuq59CtmTnO4qaTps=;
        b=t5pxOrje2izaza7iORT+H4AX70ARGdNgHwFP0nEqvtPKSbma2o9GORWwBAgJm/zJCW
         qLTd07C6GokS9mLvkHc+YOfp95q4ZAp7gzXYW0SiV1suPPsC9arj1SraDdC7AkGYoHJw
         YQe4RM5zzntIbBFGk9SDkuIWFJ9oejL3EliM/+nV20+P1AZQbx/xO5UZKDhTayeJbXH1
         3Y230cGCfx9ycsMybmhmwc27ywQduVd3ELisYHH0VC1IJpwSNn6V9hIgEH+ANaREYRbV
         cBxD5KJ1ePZhoi2IPDO/SsxCpF0DRyg8uaki+EFZ/ZrafrBTfStdj3gothf5pZYiLxmi
         YS8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782934388; x=1783539188;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qFfbhUmYyCU6tRW/uev50JnnPJRuq59CtmTnO4qaTps=;
        b=eSo6yO56hmC3LSoawpbpFwiAApCpJqbkzbN8/olA6VA4EK/1ZTSiGXtKlaSs0Y7/aR
         WsSIISC8OqTQ591esyDBWwawSL5AgtNO6+dkLzVKETdnUxMhQ3+UGV4OCWTto+x6mDjb
         bk3ZXHsuo9r0fqbNhtS7ri9V/c8PvoVTjuHutb7rUQ9vGfIqXCGCDgcHRm25TxuT2Twr
         grbv10274fWv50J8sY6n4cFk3AruQ94ohkWlIOQhQfJM4fGn7vPQRasE6dEha2v8S6Tm
         XbQ8yQvomb2i43y/8p8rhxf89VC01rFYwbT1FblmLv/p2NDHBAmgtuMlM8iZPCCp3vya
         Qx9g==
X-Forwarded-Encrypted: i=1; AFNElJ+yJbe9phQZQ80zDHj9ZioalWSpg6Dk5j82iejoBedIBH6DltfnOu8JyS6T8OmIUm9AOByPkj7sqgIOHd7sDQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzuraKNpgq5bSdCRjJlyZNPgFmaoNhEbbHBDAfNsk4wOFTMUPjQ
	AJND4jQRxD10O/6fK/xAusG23cOwH3sAmVPGzSd9roE5zVx8bLQ4ZP6Fzk8RFeWVS5IfnjJ2YDj
	kd7yNCQ==
X-Received: from pfvx7.prod.google.com ([2002:a05:6a00:2707:b0:847:8f34:1b76])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:8f0a:b0:847:86d8:5937
 with SMTP id d2e1a72fcca58-847c51e4a35mr1955201b3a.50.1782934387701; Wed, 01
 Jul 2026 12:33:07 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  1 Jul 2026 12:31:54 -0700
In-Reply-To: <20260701193212.749551-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260701193212.749551-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260701193212.749551-34-seanjc@google.com>
Subject: [PATCH v5 33/51] x86/xen/time: NOP-ify x86_platform's sched_clock
 save/restore hooks
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

NOP-ify the x86_platform sched_clock save/restore hooks when setting up
Xen's PV clock to make it somewhat obvious the hooks aren't used when
running as a Xen guest (Xen uses a paravirtualized suspend/resume flow).

Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/xen/time.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/xen/time.c b/arch/x86/xen/time.c
index 487ad838c441..477441752f40 100644
--- a/arch/x86/xen/time.c
+++ b/arch/x86/xen/time.c
@@ -567,6 +567,12 @@ static void __init xen_init_time_common(void)
 	xen_sched_clock_offset = xen_clocksource_read();
 	static_call_update(pv_steal_clock, xen_steal_clock);
 	paravirt_set_sched_clock(xen_sched_clock);
+	/*
+	 * Xen has paravirtualized suspend/resume and so doesn't use the common
+	 * x86 sched_clock save/restore hooks.
+	 */
+	x86_platform.save_sched_clock_state = x86_init_noop;
+	x86_platform.restore_sched_clock_state = x86_init_noop;
 
 	x86_init.hyper.get_tsc_khz = xen_tsc_khz;
 	x86_platform.get_wallclock = xen_get_wallclock;
-- 
2.55.0.rc0.799.gd6f94ed593-goog

