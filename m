Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841993E316B
	for <virtualization@lists.linux.dev>; Fri, 15 May 2026 19:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778872856; cv=none; b=NXu8BBucBJgSlXm5/ZjWFSpvozqkARwPWaBJfoip9ChCali5AP+Bksw+tiIEa0LNHyH8OOQkZOUQNlehqiFmYZR3CB5zRvWcBcQjHqet06srF5tOaH+fdtt06Z9eW2d1mOpONEDP6n2XiY8ZDehazMsPOR7egw0BmBlhatfHT54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778872856; c=relaxed/simple;
	bh=xUpUGQiJgAA1ZwmKSf8xfquX01gunhdqbyqPreoYY78=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sedIQ1byR4tVFGdC0hm4ydka6Oq3Wyh4vXgsDTvrR8mXBPmx/LYfPZxdk//AErD33rURst/6TMa8fyKOoZaof2+khSneqS80p2hWL4sTdHwkBhSo/CHmtRvjJEZwIcSkC5iJmM3dJT79BfNK1CGKshsLNrUeZuo0hE0cDrlnkaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jtaB8wHD; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jtaB8wHD"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2bc7f9b2213so1365305ad.0
        for <virtualization@lists.linux.dev>; Fri, 15 May 2026 12:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778872853; x=1779477653; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=KhBZEy0/QKSWfL+Tze5jxYQtO7z6AVGLrSR5LBAuSZ4=;
        b=jtaB8wHDGA5b6cNG+CReYKG23LJrj2OMc7/816ZCXvuGZeVLQZM1eyVVZZzecCMXsx
         xaNie4iOpvjlGaPfR6zeMaadl0Y+8x84IlVLlOmpViIIKGZ5pwm9cazfqbhaW/BzdErS
         /dFMnlo2i7vL0DwBx5Lu+HSkieHU0zvQGiywNP6x3rznXSDQ43AfbEmy0vfQayzpmeSw
         DBax+NeKEA+wwE3jw1zeN8gMFa5qtbpNrw86hG2/NCS2Gw5QMhz8A3t4TwRD1StfsFfB
         vY+I8fDgzqzr+9aT5Og6iZszzyKD14noRlnPzp/7jgzrOji2NzqasRP8yQqmsUOMoErA
         CR3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778872853; x=1779477653;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KhBZEy0/QKSWfL+Tze5jxYQtO7z6AVGLrSR5LBAuSZ4=;
        b=jlppPfBUflTULSwntw9TTk3Fv+9lDiam//oXeY58VAyFIFVgz2fo+/+kkVgTeMx6HD
         emiFzdzV3mpBgifUea5bxPK5wGBBZgfgduHvc2OIkCcfA5ugZ0tKsn6HYYr8BoF1S9ka
         77ezZvekKqpaCF/9JeCEuFlTZpJRPjltsb9Nk9RewrebAXH/l+DW5KWotSs3l/bL3eYg
         A6IAK2Rg9+UMSmod6kGIaB9OSf5mettiS6FkZAjqh9B9eMSZzpnIN1HHkTyiIAk5SQaJ
         UaPGO9viPVu3VHFRwcHYGtloa4HS/8cFlYUzdLOmOUj4iWDRYvLuz+PEhobZbzEAzay1
         gh0w==
X-Forwarded-Encrypted: i=1; AFNElJ9lktyygXMJeglJ0NwSoFh7PrJl1M2N+UbHnTU+nxuabtG3Qm+JITtcZ3llCMTHOI8VqWJdxCd8h9sg7lsKpw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwF0oypUy7pNOyJLQftigCX0o8kITEdwD2qwjeZW0g8dmfU111c
	m/ssx5A8rTR3zDszC1qWYagjoGm2NEAIkq/ufO5NHquIdtnl7lpQ8/WPnB8DWkz2Chy3Rs0nNm9
	kMWC24g==
X-Received: from plbmo16.prod.google.com ([2002:a17:903:a90:b0:2ab:194e:4d54])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3c28:b0:2ba:bfb5:9cc
 with SMTP id d9443c01a7336-2bd7e8d3b9fmr61656605ad.26.1778872852484; Fri, 15
 May 2026 12:20:52 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 15 May 2026 12:19:21 -0700
In-Reply-To: <20260515191942.1892718-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260515191942.1892718-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260515191942.1892718-21-seanjc@google.com>
Subject: [PATCH v3 20/41] x86/xen/time: Mark xen_setup_vsyscall_time_info() as __init
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

Annotate xen_setup_vsyscall_time_info() as being used only during kernel
initialization; it's called only by xen_time_init(), which is already
tagged __init.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/xen/time.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/xen/time.c b/arch/x86/xen/time.c
index ee7095febfd1..f087bb76457d 100644
--- a/arch/x86/xen/time.c
+++ b/arch/x86/xen/time.c
@@ -444,7 +444,7 @@ void xen_restore_time_memory_area(void)
 	xen_sched_clock_offset = xen_clocksource_read() - xen_clock_value_saved;
 }
 
-static void xen_setup_vsyscall_time_info(void)
+static void __init xen_setup_vsyscall_time_info(void)
 {
 	struct vcpu_register_time_memory_area t;
 	struct pvclock_vsyscall_time_info *ti;
-- 
2.54.0.563.g4f69b47b94-goog

