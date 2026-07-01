Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FB94189C5
	for <virtualization@lists.linux.dev>; Wed,  1 Jul 2026 19:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782934397; cv=none; b=KlFbnfLQfYkpwadp/CKF4VUMPMKvQZY+G9CiFpPiI/GP02g9ayaN+vVpA8cD0xqeDgV8hETohAbDLTJT6KbAcQwl2+/OJaT1fOqpnTn0DTDRKjjJsV2mntGWhro3SadVwHiBws9LGlbb8xNEuYG1k3bvEry3wXddHrMYZkho8eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782934397; c=relaxed/simple;
	bh=KWdxvECh9J5tLpTeYZdnmrdHt5yEzLjA+8xSwXhHHr8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rWNnJxQ9lqlj4cOTZBCMeg6x2waB+1V3QGNC0LGMw7aAApnE8MxmYocLOBnJthDAFAButwYn6gqat+kSGyotKLwwn19g1gMdzFIM+x0YOS3GdyqZN5eHlC3BK6yiZn/hS1jxymaXcEfFh2ltayWUEShOxEKqqAoEBb7Pq7IrSHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S5fpShy2; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S5fpShy2"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2c9f452d260so14905725ad.2
        for <virtualization@lists.linux.dev>; Wed, 01 Jul 2026 12:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782934394; x=1783539194; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=webyAG7YP8cSF0fuLH5JBcVLeBtJwYsS/eijECri5dU=;
        b=S5fpShy2x6ktuvbmSw92uX0fSRwsczc3z/sx0vPa5CYBxnoO6iYxQXjfSKAMhBv2K5
         yNYZX15lB7svlWtwcw4Yc5FHbCezxf+tpC07KiX3p5vEdMbRuEUFrGOnEARv06SwRKgi
         +u2ILr7Tmdu4w1M9f0dXhateicIaeoMs3rMMKiK9RvG8twtZdCCzBI2oCJ+o3nZyv52R
         Os6gKwQt4B4bEISnrhkTHXDeUMfHrKRuos+goIpICHNW+xKHqDodvuFSF5H0IXRjbLTB
         DQ5fIQczbL41hBYIzQfQgcD+Yq8Le2Ei1B35+IZjDQe2nRCelqe5s4qsEd38n4LP2YMc
         F0NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782934394; x=1783539194;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=webyAG7YP8cSF0fuLH5JBcVLeBtJwYsS/eijECri5dU=;
        b=oanyhDRKU4cnwjUVFrZa9cT79GwSNjvmqR4TZYkhU1LbCyH50NlvYXZV/2x6AVm2J0
         u+jYiZqQBFn9Vk76sTk0nJXdka3j9d/x2/ptiQnscsSEsqElm63g8H7q6n4OicRuAhZ7
         unWsaYejvZK51FjZz8VtTDg+a+vo4PSkOSgF+cKUgg4Q9u/0WVt+YHNfOSblGxOa8nVX
         jq9LIkrPQ6VA66KbbROxYu+duNPn/ALLd8Spq7Jh51rsWwjJJKQbbBlAzQk3e2xCM1DA
         Gv31f6tpI18J/A5QcTmZylObKFcj2W5nSdLrni+VHIAdY4KB8nC5DULuCy0HuSoU6IN7
         MIhQ==
X-Forwarded-Encrypted: i=1; AHgh+RqjRUT30gBJkwCFlA+y6ZEeaSA8sBp4B6vvRQ0o75FydtSWlA37V4qQtzkpQ7WcVv35bg3Brkds5Mdo/XkQRQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyrB47qmlQ5HutZQ2Sm1oDJ7Mjpwo3xKfnl+cHttJQq/4/FfLmR
	w500PSjvppTN8uFrcVa7ewGpTqWdriqU1mtxE+lWVlZwb29OEmK/zXXDikmm8HUCj3CL1obo2wR
	iCYi8eQ==
X-Received: from plq6.prod.google.com ([2002:a17:903:2f86:b0:2bd:c5f9:e27b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d48b:b0:2c9:feea:4e50
 with SMTP id d9443c01a7336-2ca7e71111emr31590225ad.10.1782934393274; Wed, 01
 Jul 2026 12:33:13 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  1 Jul 2026 12:31:59 -0700
In-Reply-To: <20260701193212.749551-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260701193212.749551-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260701193212.749551-39-seanjc@google.com>
Subject: [PATCH v5 38/51] x86/xen/time: Mark xen_setup_vsyscall_time_info() as __init
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

Annotate xen_setup_vsyscall_time_info() as being used only during kernel
initialization; it's called only by xen_time_init(), which is already
tagged __init.

Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/xen/time.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/xen/time.c b/arch/x86/xen/time.c
index 8cd8bfaf1320..bc26f00fc53e 100644
--- a/arch/x86/xen/time.c
+++ b/arch/x86/xen/time.c
@@ -443,7 +443,7 @@ void xen_restore_time_memory_area(void)
 	xen_sched_clock_offset = xen_clocksource_read() - xen_clock_value_saved;
 }
 
-static void xen_setup_vsyscall_time_info(void)
+static void __init xen_setup_vsyscall_time_info(void)
 {
 	struct vcpu_register_time_memory_area t;
 	struct pvclock_vsyscall_time_info *ti;
-- 
2.55.0.rc0.799.gd6f94ed593-goog

