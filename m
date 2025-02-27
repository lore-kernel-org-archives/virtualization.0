Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B062405EC
	for <virtualization@lists.linux.dev>; Thu, 27 Feb 2025 02:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740622807; cv=none; b=rqQ2PuaIVhuEjo+Nh8tMbdMJpbvyvKwVF4y0ML1aTEr2ox2FA8Vcv0DjVhm8P9V4IxqX21Vdmlqmsgl2IuoK6buGlTAGIp7xzB2opCBF+cJ/xt3YOKvicHfh98aZKgGiguy087VAvW6sPfV5Av4Hmkt97zsczFf2N2LvibPTma4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740622807; c=relaxed/simple;
	bh=KkUJ82b9H7sinf/zXMFW+qV85JdkMspMIEMKpj9sh/I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kZs1ls2KRQv5Tm+GI0K8oD1XSsX/BpeFwBBQCBcmZ8kgPQpXFVZC7ji8klo7KRrbwwwOUm1Jfs6BQtfck7y6mn7utRj6A5Ub03NN+xuwLyXLAhMobUMXMXMRPJ1Fgv07UPgAJTsDVDoIAnsdonJPuDbRxgR3p8qxhBoOzV2F3Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lyGX2vNs; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lyGX2vNs"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-220d8599659so8025005ad.0
        for <virtualization@lists.linux.dev>; Wed, 26 Feb 2025 18:20:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740622805; x=1741227605; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:reply-to:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pIteN/a7AZFre1KWgiuGeMT9S5HjiwYxYNebWBQLyrA=;
        b=lyGX2vNspny3ZyIhamhRK+EYpCfPDAEmcg+VHOAqiAkc7DO2RKZ2TSUIT0pmkogpAx
         rZzIxz9uwJcU9gdqluDCY5w6+/gGHaSPp4+8iIp+1rtcVBF284xoNi6YTXZUw3grVHGY
         mW42wP/y6t46YakaR5feOcHG/TPtmBnpZBwhwNtRvXJ9WzuOvSvLRaBADoHjXd656Klq
         WOXpfL9oCHUL+BxBiab9cAFaQew17H/Q+vRTunBy1dgb9Flg1SQMxX488OMVxeyfgoWW
         lPgEVNyHaI/EZpaPwYUDd9hs2VWjxYjMdUDhXn4Af6QX1Wv3qqxX3O9RmSB4Cqf95EQv
         lbNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740622805; x=1741227605;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:reply-to:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pIteN/a7AZFre1KWgiuGeMT9S5HjiwYxYNebWBQLyrA=;
        b=aON+tekjeioWl0WHPT9oAylPo1ZgiS0auVtU/CPQulZwhDkr4cR75DPNaA79OMymwI
         9AGNAw6OeKJdZ9kNW8HUKYD2cPPz5aaG4/XvKkBxno1+lWL1L5v/jz5N2vFWIvMigEIt
         K/mDhts6KVyfpazYoGCdLYGMcSS9ulBE6Gm6r6K5NyCaMvfs0m1o0WC0MBw0aeJo1t0e
         Hjb7Kq0eePAzYNnFUxxESFIKX14HQQmH02AYn4PguHuFBeXv38CVYCZ6QD6iQzxRbEf/
         nqXOCxGGn3uNG5E+FnnfUYodu61XWz/8nODLS3OKnDer3awJc6frsM470If3+06WyTWO
         pHOA==
X-Forwarded-Encrypted: i=1; AJvYcCWSjOW7wNuqqfij0sq80uHxxYeQqsl58U/ChSkSaCJ37KnVrwS0VLaRijrcw4BQmvBlGJiJEv+C6fDXBR9TIw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxwiz2hM5n5zVRscEmtP33WetsIA2eH7RI3MPcGMSHGEc/4Zou4
	ifV88XrzpPlno/MlTxX5O1+puYf8RwW5hc6vecyfOx8vtB7eTRh1jnnGxLZRd836WTrFr5J0MdZ
	WeQ==
X-Google-Smtp-Source: AGHT+IGP2cZX6cw4gCRMv2fLrFe/TXNI5NPzTOobUK44ADJodiEA9LQbSXwMRfyGc0rCQ4WOggdSpeUhPyc=
X-Received: from pfhk13.prod.google.com ([2002:aa7:998d:0:b0:730:479d:3482])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2181:b0:731:ff1b:dd6a
 with SMTP id d2e1a72fcca58-7348be4c455mr8342588b3a.20.1740622805598; Wed, 26
 Feb 2025 18:20:05 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 26 Feb 2025 18:18:52 -0800
In-Reply-To: <20250227021855.3257188-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250227021855.3257188-1-seanjc@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250227021855.3257188-37-seanjc@google.com>
Subject: [PATCH v2 36/38] x86/kvmclock: Stuff local APIC bus period when core
 crystal freq comes from CPUID
From: Sean Christopherson <seanjc@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, Juergen Gross <jgross@suse.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Ajay Kaher <ajay.kaher@broadcom.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	John Stultz <jstultz@google.com>
Cc: linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	linux-hyperv@vger.kernel.org, xen-devel@lists.xenproject.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

When running as a KVM guest with kvmclock support enabled, stuff the APIC
timer period/frequency with the core crystal frequency from CPUID.0x15 (if
CPUID.0x15 is provided).  KVM's ABI adheres to Intel's SDM, which states
that the APIC timer runs at the core crystal frequency when said frequency
is enumerated via CPUID.0x15.

  The APIC timer frequency will be the processor=E2=80=99s bus clock or cor=
e
  crystal clock frequency (when TSC/core crystal clock ratio is enumerated
  in CPUID leaf 0x15).

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/kvmclock.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index 3efb837c7406..80d9c86e0671 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -192,8 +192,18 @@ static unsigned long kvm_get_tsc_khz(void)
 {
 	struct cpuid_tsc_info info;
=20
-	if (!cpuid_get_tsc_freq(&info))
+	/*
+	 * Prefer CPUID over kvmclock when possible, as CPUID also includes the
+	 * core crystal frequency, i.e. the APIC timer frequency.  When the core
+	 * crystal frequency is enumerated in CPUID.0x15, KVM's ABI is that the
+	 * (virtual) APIC BUS runs at the same frequency.
+	 */
+	if (!cpuid_get_tsc_freq(&info)) {
+#ifdef CONFIG_X86_LOCAL_APIC
+		lapic_timer_period =3D info.crystal_khz * 1000 / HZ;
+#endif
 		return info.tsc_khz;
+	}
=20
 	return pvclock_tsc_khz(this_cpu_pvti());
 }
--=20
2.48.1.711.g2feabab25a-goog

