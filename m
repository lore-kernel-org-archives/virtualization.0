Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4288C4AACAB
	for <virtualization@lists.linux.dev>; Thu,  6 Aug 2026 23:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786059437; cv=none; b=Cv9zexgnyW27ls4euOysRq8bcAVi+njdp2Ks2/vR2oiJkGzGZ2tvbDtJrFevEsRAP+tRoN3g9YFi1nsQtKeNTFzjrWzCe0vwrAZcog8oZPINPdXPyhPHRgPLFyyRvRI7/il0YYX0u2IdmFZtQ0i5YSVUjP7rKMz47jIKABeedy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786059437; c=relaxed/simple;
	bh=atSdA44tQM5iL7i468JQE5pWUtYdZ9gHhqtvG2Zh53o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BkMCXSjVXzglbEA0YV3LIUXfC7Jup1MQmAdaNPwustfLY8UBYZiZbsqj0JXyAX3E0EjnULr87cHjh3L8KVQTydW203aRhrm1ykuffhUmNo3cugG64BRwm+dnlQn/TaDRP0hkuAjl5cjt6tIfW5fuTm4A7gQD9PzYtS8XoFLW3QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dufC75pc; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dufC75pc"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-84e3d575d6eso4633579b3a.3
        for <virtualization@lists.linux.dev>; Thu, 06 Aug 2026 16:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786059434; x=1786664234; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=gswAR/5wSepHR0W/S6/oLzBYH0wiOXioT7kjM1AQclw=;
        b=dufC75pc9NmDZ15xSYOsp9MhK138d1SjT00E19Jt9yd8jLooK7TBF21QHUg4xddcd3
         xZwskYCZMTphk81EJEA5wtXwAXb4r6H9LuKXoGiHHXmM4rr4mFvl8/+Solc1XDNmubbq
         y72XJX+K09pndJQhcgTny6wAlc5AHyDQ8mFFol54hDgdN4Xq5dYL9R9tfDsL2OXQehxV
         enLWfUreh3dMFf7vlOY6pwed9mkCRLAePWq7ed5ePxFpONjd7xjVccFMaDUzpzLFvnza
         2LlIzwD59iJzoNo4Gp00Y6SYWskhwVTwM14Eva8p9Exz5qUbFb3ZwUXMbNYuhTN26FY5
         L9eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786059434; x=1786664234;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gswAR/5wSepHR0W/S6/oLzBYH0wiOXioT7kjM1AQclw=;
        b=cKMJhjlt4ezogU+flK3FsVxudQpNFtmV/4hJxmPh+cYOVSfRDqivkCRxp5/yiXZe4j
         qCdYmB5hhkLGn1hCurLoagE1ItnK3MQPUmpIeUPsM1D+DLPE7Ix3ngeOz1Soo2ksi95e
         8Z9wNVtLnrsqPujDliOVo08hQHmtpGFcS2z1V14fXWkombjpVWsXa9K3+WhWJu2O/OMe
         AKGqL/Frw3mrL5VX+8wvkONCJzYHpGhLR7CQdM2sCUatDAZ3VOLlQMXr+SrDfbL8oRqv
         i41KeUV+2BizSD6+Euukg6WcvZ0r5vwmp4wbdrj+mFGpcqebG0PxJaqDLeKQB2vXNiG8
         YFng==
X-Forwarded-Encrypted: i=1; AHgh+RpTUoW+ZVcTuX9XfiY6QMLHdo+oFRb4hvLH5cU1qmSW6e5SDfiGxtvdPDCErbAVlZas2nw2hrpJi/SnKsPMkg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyd/XdU4ySZo7j5fjIrrJ6dwLYI8UvUnmMPq06OahYrLiqi8WyL
	pWSoiHIEpZU1QGKM7aHyNob9mMWlLWJ72yDpifQ6bwCbU9+EwoSa6Ul3gvNqYhsJQhw9tpIBwq6
	R0oSY1A==
X-Received: from pfjt11.prod.google.com ([2002:a05:6a00:21cb:b0:84e:2062:2edb])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:9506:b0:84a:29a7:f64c
 with SMTP id d2e1a72fcca58-84f2de45511mr20003910b3a.0.1786059434181; Thu, 06
 Aug 2026 16:37:14 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  6 Aug 2026 16:35:57 -0700
In-Reply-To: <20260806233609.212337-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260806233609.212337-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260806233609.212337-41-seanjc@google.com>
Subject: [PATCH v6 40/51] x86/pvclock: WARN if pvclock's valid_flags are overwritten
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

WARN if the common PV clock valid_flags are overwritten; all PV clocks
expect that they are the one and only PV clock, i.e. don't guard against
another PV clock having modified the flags.

Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
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
2.55.0.679.g6767b8d81c-goog

