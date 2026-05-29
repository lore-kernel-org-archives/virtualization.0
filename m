Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2EF13F9F21
	for <virtualization@lists.linux.dev>; Fri, 29 May 2026 15:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780067292; cv=none; b=DycHBc2fYNPb4kbfckir1tOsDMcHVo/3qYhvx+5mgvp+U4A0CzuXKRdMdFbQz3RmveXqFcOH2SAfTxy3cGe7ZbWghmyUT11bXKUeIOuYUUYnonAR1XQFDd6NTroMhlzO35Om/eX3EP/TAIY3514B58dc85muCYkdvslDZSD15L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780067292; c=relaxed/simple;
	bh=cC+ojIAc3Le9jXEf/baGTObcFZeIkk6RSMDwnRnXepg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=J8OIBUA9bAHZ4fPOocxa+0EvvSmDbS8NTof83GDcmBWT0Z0u5UTFLh7uaJmgN9pJ5T7rltn8p06GAj1NOe2XcNxS1HbGvHn9eRqb3Lr2NRh0DY8c9L/A6FK3kS7HBa8xi+B95kad46CcwLznsPIfPPw3m+z/7W0EEQ5MXUg/27k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vf6plHPw; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vf6plHPw"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c8525f0807aso10090741a12.3
        for <virtualization@lists.linux.dev>; Fri, 29 May 2026 08:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780067290; x=1780672090; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=4xsn0b4/TuAYVw8d7nIvqzj+ui/IxR9VfuC7re3vJ7o=;
        b=vf6plHPwW+wzFH70olJSgA4vwTxMSzWl+04OZS/V2PdjcQV4q671lskaHmsFE+VyQJ
         Yu4QsrH5BcfWytzzfPP2T8iofY6zieO4/oki8iEDisDkymGjd84UYjmhTKRw5h43Qtb7
         ey0XUy8XweqXuMS4sRexuWUKrcc9eAXSfp6AppDf+V43+vuNFzNsuuQjsBW0Pcpq4vLu
         fgxVIGfohtH9bVRa9aNTKfhuF8Wcf36/3WSEiKNoW7EW1nHtQYnOcyhoId0CTU0Q56tS
         J1EayF91Gck6n3ugwKvqONg2pVcr+1t/SK2Oj3pghpRI0YiGUmDPWhmjtw4q6CFC0GIw
         jPfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780067290; x=1780672090;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4xsn0b4/TuAYVw8d7nIvqzj+ui/IxR9VfuC7re3vJ7o=;
        b=QPl7J2C2UoPRCf0HsmjNSAlaMRFZ+ZjNI7Q9RIPwYHVb5Rf8egXNBQoRnVFqZqhLWP
         rBgcoZsr9rSKCdW2IjZSE49/DKN8sbm45XyqLsbx0poOGrrJ8u+usprArexNXBECMwXK
         mZkM8tNGcPhMxyay+TFrABI3hxSsB1vEGl2b2AWjQPtAQD0P+mIHzT3WhP59zlsodi6w
         f3c0LA0/uEvhh7t7FXyGCIFykrUwakkvL3lQFuB9OuRJYG8ERtMGj69p3dUPJTMStdsX
         uYwQrESgan+1Vx/vewENdhCg3T4TyyG5QVBDil013cOpR9QhbOxQTegP7sKZT6NLEBDo
         iUVQ==
X-Forwarded-Encrypted: i=1; AFNElJ9z6QFgFH+59AY7YhrPdP1JZFztAc6YNOxybWrhbnnT1UTkvXxwGe7NM6ocnmsWNhScoBtPBeac3ZwA6mhP3A==@lists.linux.dev
X-Gm-Message-State: AOJu0YwAlXmzhkUVq5cu7/sEzu3uCza+urONAHRPmbKKFRY3wY4TprZU
	8z/zjyLunZpBqynZT9+Q8CojLzpXJWVKqHB3gqYpy1xeX1cnzRvfzr3GM0O+hAMoQ8Q+LoxVhW5
	QOx7abQ==
X-Received: from pgfu20.prod.google.com ([2002:a65:6714:0:b0:c85:82f6:34d1])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:2452:b0:3b3:24d5:d656
 with SMTP id adf61e73a8af0-3b411deb049mr3990553637.23.1780067290086; Fri, 29
 May 2026 08:08:10 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 29 May 2026 08:08:07 -0700
In-Reply-To: <20260529144435.704127-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260529144435.704127-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529150807.714538-1-seanjc@google.com>
Subject: [PATCH v4 36/47] x86/pvclock: Mark setup helpers and related various
 as __init/__ro_after_init
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

Now that Xen PV clock and kvmclock explicitly do setup only during init,
tag the common PV clock flags/vsyscall variables and their mutators with
__init.

Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/pvclock.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/pvclock.c b/arch/x86/kernel/pvclock.c
index b3f81379c2fc..a51adce67f92 100644
--- a/arch/x86/kernel/pvclock.c
+++ b/arch/x86/kernel/pvclock.c
@@ -16,10 +16,10 @@
 #include <asm/pvclock.h>
 #include <asm/vgtod.h>
 
-static u8 valid_flags __read_mostly = 0;
-static struct pvclock_vsyscall_time_info *pvti_cpu0_va __read_mostly;
+static u8 valid_flags __ro_after_init = 0;
+static struct pvclock_vsyscall_time_info *pvti_cpu0_va __ro_after_init;
 
-void pvclock_set_flags(u8 flags)
+void __init pvclock_set_flags(u8 flags)
 {
 	valid_flags = flags;
 }
@@ -153,7 +153,7 @@ void pvclock_read_wallclock(struct pvclock_wall_clock *wall_clock,
 	set_normalized_timespec64(ts, now.tv_sec, now.tv_nsec);
 }
 
-void pvclock_set_pvti_cpu0_va(struct pvclock_vsyscall_time_info *pvti)
+void __init pvclock_set_pvti_cpu0_va(struct pvclock_vsyscall_time_info *pvti)
 {
 	WARN_ON(vclock_was_used(VDSO_CLOCKMODE_PVCLOCK));
 	pvti_cpu0_va = pvti;
-- 
2.54.0.823.g6e5bcc1fc9-goog

