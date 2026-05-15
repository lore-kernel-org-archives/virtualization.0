Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085473E1200
	for <virtualization@lists.linux.dev>; Fri, 15 May 2026 19:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778872849; cv=none; b=ldhCtxjtvh2ApCsxj3Tae30iULiO+8FD97B/2ERP/odix1uDwsnZUgG4Nh4BRnpGrSUUKqylCMxbVcfStPeq8Xp0AX1uZ4GBRtMQq98Prbuo3fJnA+xde78Cf4D2rYYjWj2puX3SSnmzrnIym/0NVxwx6RNSvmkpNhkOQlN1qKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778872849; c=relaxed/simple;
	bh=bIvGpEwSZtu1dFGmRrUgP1xhupYQhI4tOk7weRcJRgU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GeQBX5sLR9/avZU4jj8rwIRn+jv/RVfaJYRmvsHO+6IA+LxCewwuq+eoSzOHLMU47pYWMzJ0FxQCatyXph6/EEYrBpi8JtG6y/m4GF3TxJ/DCQ5Q8dF5lOOXnybmhUxSfDWmzuDLWeaH0j2XV1x4wfw2xc8Ydw/YST5GNEcJkYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wGtyso6U; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wGtyso6U"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c828ab3b033so211318a12.3
        for <virtualization@lists.linux.dev>; Fri, 15 May 2026 12:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778872847; x=1779477647; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=eVzC+1NNlxe1k/R0gBkxcy+TPbGnZzPB3ftmmd4+5ik=;
        b=wGtyso6Uqxty1AiB9MEoJ7TFW/JGcjvBIfH9n/kdRgsJ2LNOzDvZYg23OD5FWesSRC
         mOkoW7/jY+FQdR409lGivhhDFD7xmKog8XwkPgpICSDqS1+NvVBnyVJ640qVNR3J5pif
         F2tSrxuv/zcLAjmCPjBf1ONAMrMgYv6MpcbIgQHuhMLoOVLWE/VT2Ml6Mj4WYGl9itZ4
         JMOi45bisFe+KHkXtx50BZPbavRr7K41hHlMpduBm88vlKafh6PboU3UR0YbrQy4kd8t
         Cyosat61oKKh3Uw1V50ZNUUU2MVZxcvDBi5B22mtK0Q/HaIt3/h7PsMAJySYtGCPMOXl
         7QkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778872847; x=1779477647;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eVzC+1NNlxe1k/R0gBkxcy+TPbGnZzPB3ftmmd4+5ik=;
        b=ay7rp1+1n4ay8GvwYF3cID6v6/0cl2IJ2fEvPLB1l50/QPwqBGYTRFSKZaZQXZsnrA
         IACpqON4OpwN3K5w/ax/exbzScmnV465FZHUb1he+KZklwcA9DXYlySCIQzu+SzZg7C0
         LvOBO5BrigrDU1SoOvMhdOE2GXJlozgoUNBKRu1nzqBdJjidmeFk7oKMleDolwQ0eylE
         HMAN3pHwnk05Ec2O/LyUlfOnDOmAaF8kLencU3+scx+yoc4wxdmszehm2XlaM0UI9N+u
         tUIxHoHWy5z4YAwHa2xL6JXj5/aLH1RQ3SJPZjD06GFsyVvTu7J3XssM5FqL02jN0K0h
         AhTw==
X-Forwarded-Encrypted: i=1; AFNElJ9q21E42maMLTWVDCJNoWvU0vYflABDaLnDtJ0slyLK5F12MB1icZNpBawDBGuOcMvk5WOrkVISNH9iMANdyg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwiAW6G9mm30qDGi2RzIJ3ddzanogyO0+mbE4DHE0SJ0wLtQo4x
	6RlmfAIbzrCglUGYAPtmtfW9wVoTWepbuRD3wE8Erq6aNpnS7G3Q1q2jrq2loBeEpBpY20e+S/5
	QdAP/zg==
X-Received: from pfblu4.prod.google.com ([2002:a05:6a00:7484:b0:83a:58c1:f5e2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1404:b0:829:9a7b:db84
 with SMTP id d2e1a72fcca58-83f33f30bf8mr5787888b3a.49.1778872846903; Fri, 15
 May 2026 12:20:46 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 15 May 2026 12:19:16 -0700
In-Reply-To: <20260515191942.1892718-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260515191942.1892718-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260515191942.1892718-16-seanjc@google.com>
Subject: [PATCH v3 15/41] x86/xen/time: Nullify x86_platform's sched_clock
 save/restore hooks
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

Nullify the x86_platform sched_clock save/restore hooks when setting up
Xen's PV clock to make it somewhat obvious the hooks aren't used when
running as a Xen guest (Xen uses a paravirtualized suspend/resume flow).

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/xen/time.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/xen/time.c b/arch/x86/xen/time.c
index 3d3165eef821..21d366d01985 100644
--- a/arch/x86/xen/time.c
+++ b/arch/x86/xen/time.c
@@ -568,6 +568,12 @@ static void __init xen_init_time_common(void)
 	xen_sched_clock_offset = xen_clocksource_read();
 	static_call_update(pv_steal_clock, xen_steal_clock);
 	paravirt_set_sched_clock(xen_sched_clock);
+	/*
+	 * Xen has paravirtualized suspend/resume and so doesn't use the common
+	 * x86 sched_clock save/restore hooks.
+	 */
+	x86_platform.save_sched_clock_state = NULL;
+	x86_platform.restore_sched_clock_state = NULL;
 
 	tsc_register_calibration_routines(xen_tsc_khz, NULL);
 	x86_platform.get_wallclock = xen_get_wallclock;
-- 
2.54.0.563.g4f69b47b94-goog

