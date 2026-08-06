Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E187A4AD68F
	for <virtualization@lists.linux.dev>; Thu,  6 Aug 2026 23:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786059449; cv=none; b=u1ekHsm07G5drRRyUMwej0J3js4m+ELWUnodnrOl1xtjN4p8rnCdLH8N3U5N2t7LHl/7LvhEc6B/o38gaGtyfAjwZWkrDTT5LKLrvMdXxiF23Z/cZxue9u/IC7cCD8UIoGiGLyaCsUThITwlGdbZ6NTV8BUTWmhdDb8wT0HfTgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786059449; c=relaxed/simple;
	bh=BnM4G2QoVq+BwBjw0knb7MjaTBG0gVh357KJ4LCrn0Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hPJJvlsj+2dLgTKLuiIUGR580BzK17t/kf8qOV6V4KCuOV6OO/3FZpMNeXoCdZhGaIhMRH83r4eXgcCZvIwalsxBLABdxjvLDNKY6L4G5Ex2pdOiNRWYEs51R/o0zIYkZrP4bEIsZKvS9Ex1BdH/sTnj/YLSeSwZK3csLJs0nQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Xeh1s4xT; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xeh1s4xT"
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-ca8aee88725so3901031a12.3
        for <virtualization@lists.linux.dev>; Thu, 06 Aug 2026 16:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786059444; x=1786664244; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ZEuUzNS+h+uJbnucj4BSLPHP7Njp50j+oXkHsgjPk/g=;
        b=Xeh1s4xTJFB6kaBL5DdOqF7y1/rFvYip2qZOf1qgIAlnIPaQPMPOIM9PBwLLb2T4BH
         e4P0iCIykJ05fNK4sxwfPPdXQn0NrJsuw2TgLEU52EAAWonVqqKb1C9gek9EvA8Mirad
         o73E+7TbfhuJEZwm88tncDFkmOkk4f1QlVnxCThpvq2FWI6Cigpk2jtJ4IKSDXr07CI5
         0QscnS6hEdVdq0RzN2oZf7SdfvGbCFAsIrYU1EFeG4tvonM23gII0W0c65oXple73Yy/
         jDfk2gy/Ji9WK9mGONMllwtg79MJ/i/6OvF1LJ/ayDeMbYAgoZnKLJL0vbF91JVPiIbN
         8VyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786059444; x=1786664244;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZEuUzNS+h+uJbnucj4BSLPHP7Njp50j+oXkHsgjPk/g=;
        b=D6muDy9FTOFS3a3QY6gIiR0NZBztsAhOiWbBR/D69eVE0yJbWop+WP7rQmI/ovJeGA
         XEWH6Kar2fh9enc99AT5MOZu4Za4umA4Gsip/qwUWKEIQlvNZQpw2JmRWRVrGBmvi1Tb
         3LoYGxdTXIENCX0uWr4g063jps/PBAyX/wU9acExn+5SJyJXL5ZwBKITM/kq4Bb1HDgj
         3L97+2MzvZN5u9RM6j1H+99NsRltBWewwcX6NOXRbT+izmYahhIYvt2Qk0ZHPS+qDMWz
         E9vW3OT0HDQ+MqQPiqcwzYDbXyRhXdh3kvrTv5RNxSzkesg2QvYbu6ZyIACsYc1PFjn1
         wsHQ==
X-Forwarded-Encrypted: i=1; AHgh+RpbLI4sPjcfjCRmPRyRLW/kQfmxvuaNCEy3Z9CcUk/epMoJ43RhbAbmmZ+Q++SrM75GQeQWN23gpeoNQMJDkg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx47PaQtbyy1tDDoxenIvThlPKP9IgsDQ/xZujMzOAmHbEQLFzG
	b1c3UqsZzDKE7y6BiJgwxkauMuAS1LXEeGhWizk8Zc7vlDauVNWK6Id83SmP2iOSS9mIcy6CavK
	Zt9ycjw==
X-Received: from pgng29.prod.google.com ([2002:a63:375d:0:b0:c9a:c533:8329])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:4309:b0:3c8:ead5:bf7b
 with SMTP id adf61e73a8af0-3cb85ded991mr21268446637.4.1786059443651; Thu, 06
 Aug 2026 16:37:23 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  6 Aug 2026 16:36:05 -0700
In-Reply-To: <20260806233609.212337-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260806233609.212337-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260806233609.212337-49-seanjc@google.com>
Subject: [PATCH v6 48/51] x86/kvmclock: Use TSC for sched_clock if it's
 constant and non-stop
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

Prefer the TSC over kvmclock for sched_clock if the TSC is constant and
nonstop.  I.e. use the same criteria as tweaking the clocksource rating so
that TSC is preferred over kvmclock.  Per the below comment from
native_sched_clock(), sched_clock is more tolerant of slop than
clocksource; using TSC for clocksource but not sched_clock makes little to
no sense, especially now that KVM CoCo guests with a trusted TSC use TSC,
not kvmclock.

        /*
         * Fall back to jiffies if there's no TSC available:
         * ( But note that we still use it if the TSC is marked
         *   unstable. We do this because unlike Time Of Day,
         *   the scheduler clock tolerates small errors and it's
         *   very important for it to be as fast as the platform
         *   can achieve it. )
         */

The only advantage of using kvmclock is that doing so allows for early
and common detection of PVCLOCK_GUEST_STOPPED, but that code has been
broken for over two years with nary a complaint, i.e. it can't be
_that_ valuable.  And as above, certain types of KVM guests are losing
the functionality regardless, i.e. acknowledging PVCLOCK_GUEST_STOPPED
needs to be decoupled from sched_clock() no matter what.

Link: https://lore.kernel.org/all/Z4hDK27OV7wK572A@google.com
Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/kvmclock.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index 22e8855fcd4d..bc98ebb8587d 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -396,7 +396,6 @@ void __init kvmclock_init(bool prefer_tsc)
 			 PVCLOCK_TSC_STABLE_BIT;
 	}
 
-	kvm_sched_clock_init(stable);
 
 	if (!x86_init.hyper.get_tsc_khz)
 		x86_init.hyper.get_tsc_khz = kvmclock_get_tsc_khz;
@@ -416,6 +415,8 @@ void __init kvmclock_init(bool prefer_tsc)
 	 */
 	if (prefer_tsc)
 		kvm_clock.rating = 299;
+	else
+		kvm_sched_clock_init(stable);
 
 	clocksource_register_hz(&kvm_clock, NSEC_PER_SEC);
 	pv_info.name = "KVM";
-- 
2.55.0.679.g6767b8d81c-goog

