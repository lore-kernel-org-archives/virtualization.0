Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765483F39F3
	for <virtualization@lists.linux.dev>; Fri, 29 May 2026 15:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780067276; cv=none; b=fX5v592adjvPWyTdmmSEAAwTTwHX25AwC+eGEKzVXCF4CeMQwcsehDG+2I/k7F86iat6ewbMwS6ij5DNdRPRz1nR8X9oQLLM9Brxpi4d0mnM+YDihGQ8LGgyWt4QOg1g2PlmwTjWoGG9a7W9Miel8h0zYeErr6RZKzrdo5STlSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780067276; c=relaxed/simple;
	bh=kqQGoMW+oi+5ZrWtSd7Fuu/ZnSkBt2VrapqrWKwhgpU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BQWv2pFBJSQFC3LrApDrWxWbdXeTfnR/Tq+z5vR3UPD01nvXUWxyF6trN5B1PuahBfmwnkU5U5l+5kHJEUHZ6zDUehR1Gq/hSmERzS8+QA5X4KbNv3ohp/nfgvfJ0ULLKNMr8Vgt3LXwt92TsAH0WsLImsaXMWrt7XlxJpEgM5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ihh4gcuR; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ihh4gcuR"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2bc7f9b2213so104563995ad.0
        for <virtualization@lists.linux.dev>; Fri, 29 May 2026 08:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780067275; x=1780672075; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=yp4siaZu6zeBY6Dr4EV8ib3+ttfMwXywWsfu9IVNNX0=;
        b=Ihh4gcuR4swBY4g6gpI2bcbWGmxNWv8WqJL2611I3R1Pyh06BF1AB89wC0d13XA2eo
         ZKSleBuSfrIi6fSNdYgBsqdeeLtjOxlvtt1k4HADVh8KqFDPZ28XLFRFE3UN/g/dkq5Y
         Evv0bAxHHzps4umHP4grnmyXvP9CnpBrzyCjHPYnzW/hmKtMIW9zA1UaUs0pgSFXci4I
         JSX8UF4rFM7tCRRLBzF/YjmplfEr+KzrmCUvpUYxeoTxSuoVkyjppX8DstbpXfJGWDUD
         MrtjSP/SfoThd7srVyXqYJ+r5K3B4mGdVsckKFjDw6FxQ+QK+ngDNUjRTWB6V3hlSzAq
         gqzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780067275; x=1780672075;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yp4siaZu6zeBY6Dr4EV8ib3+ttfMwXywWsfu9IVNNX0=;
        b=PqMtGvkhUaZR8RPQ+yAYYShK/DpSLoLiyRHlCh5TQu8Zmv0Ej/SwShSOCS5AjZ6G1V
         oKX+jwkhEEDi9V/sFECLFsAUu1naXEZbOgcUINGcREQmAOOoKTQvHXwFVN+/8xnVt8FO
         Q7HA4NC4V9LPik8Sk3zO4UI09XenWg5MlUFkLKnO5ztqbzYOdup7OKZktEh51juhAg2Q
         +KQSDrB/FrhieSNgCkfS5tgy0ec/0HIhgiNTXdRY56jJcFjc100JqhQ+ccVu3W0cJfyx
         yToP4OJ4Hb4oJ68HYeupuRxPzjNWymDMJeezmUtexPoOQv21nbqqvWQ3sJk3KmuCcKhc
         +jtQ==
X-Forwarded-Encrypted: i=1; AFNElJ99UWkb9SiEk5zY9TkAh+xm9aLbRyf9/Q6jnIRebq70ty70U/xPa2YQk6AIk5nHysl2ycGP3jYPssRP7N5mOA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzOZWUS4xReDVvV3DknWFMMnCXGXefQHVwedpJe24S/2uhCO+9S
	T16195V7uboaZO98vfIAmPl/EhTShRhXoLkaCTVFf6wYeof6Untv7tARs9QOj+HGGqk1RcTNiWJ
	euAz00w==
X-Received: from plgv8.prod.google.com ([2002:a17:902:e8c8:b0:2bf:2f05:e721])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2450:b0:2ba:6ca2:be0
 with SMTP id d9443c01a7336-2bf36798a4emr3028165ad.4.1780067274515; Fri, 29
 May 2026 08:07:54 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 29 May 2026 08:07:52 -0700
In-Reply-To: <20260529144435.704127-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260529144435.704127-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529150753.714296-1-seanjc@google.com>
Subject: [PATCH v4 31/47] x86/vmware: NOP-ify save/restore hooks when using
 VMware's sched_clock
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Kiryl Shutsemau <kas@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	"K . Y . Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Juergen Gross <jgross@suse.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, John Stultz <jstultz@google.com>
Cc: "H . Peter Anvin" <hpa@zytor.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
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

NOP-ify the sched_clock save/restore hooks when using VMware's version of
sched_clock.  This will allow extending paravirt_set_sched_clock() to set
the save/restore hooks, without having to simultaneously change the
behavior of VMware guests.

Note, it's not at all obvious that it's safe/correct for VMware guests to
do nothing on suspend/resume, but that's a pre-existing problem.  Leave it
for a VMware expert to sort out.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/cpu/vmware.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
index 2d0624c66799..051ef89029a7 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -347,8 +347,11 @@ static void __init vmware_paravirt_ops_setup(void)
 
 	vmware_cyc2ns_setup();
 
-	if (vmw_sched_clock)
+	if (vmw_sched_clock) {
 		paravirt_set_sched_clock(vmware_sched_clock);
+		x86_platform.save_sched_clock_state = x86_init_noop;
+		x86_platform.restore_sched_clock_state = x86_init_noop;
+	}
 
 	if (vmware_is_stealclock_available()) {
 		has_steal_clock = true;
-- 
2.54.0.823.g6e5bcc1fc9-goog

