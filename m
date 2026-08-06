Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED42D4A7018
	for <virtualization@lists.linux.dev>; Thu,  6 Aug 2026 23:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786059435; cv=none; b=G51vTXMucaZnMxVX+Z7UOv7DrLyT+x51plJPKNUQw6y9STvZqSEWs1TrMTgF3kK0tFMyyO+iqcefOibdHPqLhwbDcFI3sNg2Z73nrg6v8Tye4GydgpV+r8EQ/1GrNcrOUFqRuQrNqvlcv0v51s2U0Uo6LTaw0rYcLNlAMLBqXM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786059435; c=relaxed/simple;
	bh=QnNlfXQgGwJN0/JkuWp/4XAMGB0Vt5ulI8HR+vmeXt8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ehQ8q2LhTnuMnkMoR+YETeinps5uJ1wj5X2/lioob6itWUH1bJcrKhAknTMSHI7AaAg5yqtFpbvbL9GZtAfCIaO/JlaPlryyvgR2SVjrseKncFGirw0xIrJdYJ2DCJdpIOwZgSOuLKQjgxuT0uuFTpLOuAenACUMIbQpfztfYyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RmSsM05k; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RmSsM05k"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cbb467e56aaso2947133a12.1
        for <virtualization@lists.linux.dev>; Thu, 06 Aug 2026 16:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786059433; x=1786664233; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=rt852L9wHdv0bDRlKJAMITX85TrVIH1oxytQu/w6xUg=;
        b=RmSsM05krVVjnDRsEAOdwsWOjRjSmcIiCk7M3oYpVa0eh6bZD9C4JNYec3mjg3F0Mx
         3FCuiQkquoe/JTAoMItOjJehK/DSjkNDReaU3kFzYXoANsPPwZqUlOzXnDmsffE52PNY
         WsBXkT3fRD6CfdeCae+N2egFcTU6bks9MzWQGM8v+zJIvST+4nmC6vAOvZbvVIfDuaJX
         gKja4TqOORNMgREPIrgi+tzsFDd7goVuMECNpLgI02ZsKSlcSFK1kbH7FNYyFjKhTSnx
         IIiB/OOMtrl40nGlyKOBLighXS+39HFlMkpfeqsGD1qZ7TpoGhUGgZKlE3lGkD9/3s/7
         3trw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786059433; x=1786664233;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rt852L9wHdv0bDRlKJAMITX85TrVIH1oxytQu/w6xUg=;
        b=do+LGXm6uxqj9GeW3brw0/1+38bxG6K3bzQCEZDRFoex56Fy3/I2Bcqygp/z1kwFNd
         xMKHpTOYIqLlZXJEE1TRyz0oN0dH0EpZy4F+ivwGlqvL/uI+v2Xm8FEhA4WtOjD6UMfU
         h/gCwkY4WTWAHhSgdl3leDmwtS/ioVyY8+OxE3MLNfY8FL4WUPLZA7gjvk8lDb88j3Z8
         q6ERAGSypqvQZ4m8wx871QBLPsgLII/sEkgzLcC0VUO7oej54IJdPxT412S3TIWzfVcp
         HAvavEuw9qKdDUqsVSZUk+KDzaXYaoccpdqQuehEpWCXdGtqQ29H1VAu6B0p2dY7z80Y
         zgfg==
X-Forwarded-Encrypted: i=1; AHgh+RqkqGbkuvrcNuJiPHfq6ABdL/a62j50SSNpwEazeRYEZs67OaG2bstXRHi6COtl7nFuXJDguQDg5zjt+iu6pw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxaAPpnnADaU78oT5Ah3r4V71l+82vTO/eC4PLmtuoOwAFyksGo
	wtoMYZr0+PuXACCenOZeURKuA0N2teTLqM7Vdr0prAD5RMrUkLfh/u3ELwzd+38M5YFNESGtHnG
	MgIniIg==
X-Received: from pgkd23.prod.google.com ([2002:a63:f257:0:b0:cbe:7907:901])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:d52c:b0:3c3:812a:2198
 with SMTP id adf61e73a8af0-3cb85df190amr24070365637.4.1786059433092; Thu, 06
 Aug 2026 16:37:13 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  6 Aug 2026 16:35:56 -0700
In-Reply-To: <20260806233609.212337-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260806233609.212337-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260806233609.212337-40-seanjc@google.com>
Subject: [PATCH v6 39/51] x86/pvclock: Mark setup helpers and related various
 as __init/__ro_after_init
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
2.55.0.679.g6767b8d81c-goog

