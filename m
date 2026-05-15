Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FA73F86E9
	for <virtualization@lists.linux.dev>; Fri, 15 May 2026 19:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778872857; cv=none; b=VM11Hi6j9WOKh0SPYLCvt9Vf9o6PxUSL23o9OZbzV9zDjYrPZnirF9Je3ZjYRCkEk9faq004OsPIlcqV8Rk/NAk5ms+xrsIuQdUMBogQUjG6RrYe6OhDKYt3iOozT3Q8SdfkZJpEzzYf5UKRoyQIorj6RkYaiLlcFgpt5OJhIt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778872857; c=relaxed/simple;
	bh=lbZq5HMMUdoKD8t+V1QOxdv8UCq5RsQl+bpxwZwTljc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VOc/UcQl4xDkTQ33wJtrPOGdaGDqfBgpjmjXCL5sMTJDoeoiQ8zp/SRLPtmAl1zVbi9SDe5UYR3uqTlWpa7QINYqaM2VPGpufAUSARB7kgLw6E30zYhCwNMtVPHQSQbffoY0JG0wQBmONS0P9VxWh4PYTZNw6afyggOYnt5wFJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qVg4AZzC; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qVg4AZzC"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c709551ec08so187717a12.3
        for <virtualization@lists.linux.dev>; Fri, 15 May 2026 12:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778872855; x=1779477655; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=BtD3/8r1rxxPL0bRTCD1R2r93qIzEoWuEeKvRfTm7KE=;
        b=qVg4AZzCKwvLSp8hSMdbR/HMWueCRkMUCN/uMXs33Q3yu5f6HwLXxOdznqW1gtv7s/
         fKG/C5zT4I0L8Ve+s7AF5T8mjvXz8AjMJt4XgLR86zj/SOkg7uAZg3r5MUr1/O5KBbUe
         26HAMLOUcrEEz576BNmQ8lFPyAAZnOoHnPEUTIUyypV4orOa0HbSD64Ak2a+aRXU8DhL
         o+vfWSCIhIOyZPQTfNmW+iYy0XXJrc1ek7SZi3w6/xPePrQDAZWcCJpyCsfbqmOFpi1H
         F4JlymwbZLPwI+onhkJwHr6GwQej6+dSeGeMlEhfCfbbfbLQt1IxqmF3Wd1d40z+xQZ8
         nVeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778872855; x=1779477655;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BtD3/8r1rxxPL0bRTCD1R2r93qIzEoWuEeKvRfTm7KE=;
        b=AbQPiTuJezlbIPFoXwU7pESqdGRD3ZuvA/EFG6xf7VfcgMys0zGSSoJv7jsKTX7rh9
         Dj0ZsfptQ1pCHJdlNFoVNoZb+xNo3YY1R+L/69+oYieFo+H1z6uRTbO2SI2pRmHgAfO8
         ZbMZznP6q/sx4Eux8Y13KoGDOJt2VX9DvfWKNl1AmO6/wncDvwFJ/3fp8FthAP4m46PE
         nPx8+NGBhPS4UWf5mq7KnsKyrbjFagL74TNyGtN/M9Y9qPk3Zf3jibg0H2YwKwrccF6h
         z2gB5i14K47v63Ai3B3CJHe5xrWlPZSsO/t9wDDnm335Vy9MVx91qmLsp3ZbTy21464O
         EWpg==
X-Forwarded-Encrypted: i=1; AFNElJ85PXZ4FcYLZAzz61QVPG67LRPczZ/p6lf2N9XFphcnvD2tZ4+sSF+pBShW953OBC4t+XQIw/9InnKmw6UWzg==@lists.linux.dev
X-Gm-Message-State: AOJu0YweJLdmeVIAphCPk8thmv6uhUv3EPzQiKUXv0j6YwABuYip5DkN
	8668q0Z3Qdl2y8fyxawwl8lOTqiyUxlbQ71UKeZy7FpZUxa+CLbiPkyHOmb3uisTfpSMoysI70D
	yc8N4ew==
X-Received: from pfbly26.prod.google.com ([2002:a05:6a00:759a:b0:82f:a4cc:2fb3])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:ac86:b0:82a:805a:7e2
 with SMTP id d2e1a72fcca58-83f33c4ed90mr5838917b3a.9.1778872854522; Fri, 15
 May 2026 12:20:54 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 15 May 2026 12:19:23 -0700
In-Reply-To: <20260515191942.1892718-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260515191942.1892718-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260515191942.1892718-23-seanjc@google.com>
Subject: [PATCH v3 22/41] x86/pvclock: WARN if pvclock's valid_flags are overwritten
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

WARN if the common PV clock valid_flags are overwritten; all PV clocks
expect that they are the one and only PV clock, i.e. don't guard against
another PV clock having modified the flags.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/pvclock.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/pvclock.c b/arch/x86/kernel/pvclock.c
index a51adce67f92..8d098841a225 100644
--- a/arch/x86/kernel/pvclock.c
+++ b/arch/x86/kernel/pvclock.c
@@ -21,6 +21,7 @@ static struct pvclock_vsyscall_time_info *pvti_cpu0_va __ro_after_init;
 
 void __init pvclock_set_flags(u8 flags)
 {
+	WARN_ON(valid_flags);
 	valid_flags = flags;
 }
 
-- 
2.54.0.563.g4f69b47b94-goog

