Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B413A2356CE
	for <virtualization@lists.linux.dev>; Thu, 27 Feb 2025 02:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740622806; cv=none; b=hLkpDmwnzPn4FO9rcmQf9usKB5kI7FWi/J3EkiRP2l2o0KVrf+4kCwlAAO+2H3Qi47xaFsi1H/H0yNv8nhs/qWYA6V/GIEl/2wJXhoamlQxUfv3giFZz+oQl2nUYwn2kBFWAIXH7KQNfjvWVJ8/ra38UbqJ9DW9npta/YdrUpSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740622806; c=relaxed/simple;
	bh=dSybtMuoZF9XQBwPnBkfo1UPLtlynUI+WZpyVl8WUu8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AuPtZ7gtfNpFtfu2WrJOq1D79rkZZJ/a3mgFGcAhIVsR5h4hAJ5tapczdfKci/Z+L5JNtPZH2tszNvH+w3KK7Pwayne2UqSyseLBATcBewTrS+LpwM+HRwAzqC2h03AlbQeU7qwC5q5LHaA6iO1ptqe34ewNADOScp1vWwrLH3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DEniNOYo; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DEniNOYo"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2fce2954a10so1537181a91.1
        for <virtualization@lists.linux.dev>; Wed, 26 Feb 2025 18:20:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740622804; x=1741227604; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=tqdKNUZqbb8d2CJvLoLFEQfT4OY26dkczDpR+rA3UIo=;
        b=DEniNOYora4YoMmuCNrNFtqMMpIeIn6sz8Y7pfb/Hql9PsdXIUYVumvMpnSav9xOVc
         0antxe2yUsMqD6qx4x7QF3vCNw9Tlahfo5vErdRKssS2aHUb2kTxD5lF3Jc89Iu0RvNz
         CNzsqbxvn4u2oCbTyWqUxxyKHvitcWiZPs0m1lPXMSwOndyLwlipcPO1aVJVL7xC1YDz
         nYynELiCzXk5sZXabLqWjA27bhybLmy3F8c2GPAcmFtAZHwDvwnOMm+ZDZOkEAdBMJgM
         nqtaTqLGJnjFskA58H49678+MRlximNMBoUkS4RTZeM9mbfrHHFylDLrrmXW0ktair3s
         Hajw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740622804; x=1741227604;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tqdKNUZqbb8d2CJvLoLFEQfT4OY26dkczDpR+rA3UIo=;
        b=ruXx4IBb+DZC89jH4guTl1AVOv4UpGO6UgCEbUI90ogRBt3wHGgxMydRUDU3lDBNtj
         gpws9A2PO7dVpSw7lfAo1Ke6W7kJYd/8yy/M0ZtHKdvXz4Y0LAjL6OWSLfOY5pAUY+p2
         yisu521SJ7Gv+Xi+xxoxFocp1PfjTaaQdWJGiTXgyRd8ueWZSFGGV1k/P4H+ZISNqvAa
         EsiatpGGYi5syyZYpLXn4+8nRIu2zV3Kvlmwmge1yMUmWHdnc+FLtVA5b2Ja++NLg6Xb
         fw3t4kNELXCDQ+5B1BJjqCI3nZA2ietN2t9iozVBdAj6ryCseFe6sMlX46ZIWSVTgqCP
         qpmg==
X-Forwarded-Encrypted: i=1; AJvYcCWYXjM0nOwsFnkhxNMQVpm0EkCKIYku1jnUd+uZkGYFePb0ysM7fd3njgTAEkFZHCKIMNkviphNxbp/t9csaw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwN+qcBNbFoRSQAH7e5R4Zo1HYaKcSYsp1SYPiDEj7aJKjT1IgD
	tczkkXzKWZBv+zo5zp8Cec2M7b3zBjy218RWgT6JxFe6+PdAi/QNaQpr/HoVW2mbRVz6PTMaxhz
	coA==
X-Google-Smtp-Source: AGHT+IGMz3bH4S0o1xgsITZANeNn+Z/tGuVwcYyVyvqnl2NMWrRx99tESpyiBKte9PgB4aGO5q0vwXh4uHk=
X-Received: from pjuj3.prod.google.com ([2002:a17:90a:d003:b0:2fc:b544:749e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3c84:b0:2fc:c262:ef4b
 with SMTP id 98e67ed59e1d1-2fce86cf0e0mr42953377a91.18.1740622803772; Wed, 26
 Feb 2025 18:20:03 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 26 Feb 2025 18:18:51 -0800
In-Reply-To: <20250227021855.3257188-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250227021855.3257188-1-seanjc@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250227021855.3257188-36-seanjc@google.com>
Subject: [PATCH v2 35/38] x86/kvmclock: Get TSC frequency from CPUID when its available
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

When kvmclock and CPUID.0x15 are both present, use the TSC frequency from
CPUID.0x15 instead of kvmclock's frequency.  Barring a misconfigured
setup, both sources should provide the same frequency, CPUID.0x15 is
arguably a better source when using the TSC over kvmclock, and most
importantly, using CPUID.0x15 will allow stuffing the local APIC timer
frequency based on the core crystal frequency, i.e. will allow skipping
APIC timer calibration.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/kvmclock.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index c45b321533e5..3efb837c7406 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -188,6 +188,16 @@ void kvmclock_cpu_action(enum kvm_guest_cpu_action action)
 	}
 }
 
+static unsigned long kvm_get_tsc_khz(void)
+{
+	struct cpuid_tsc_info info;
+
+	if (!cpuid_get_tsc_freq(&info))
+		return info.tsc_khz;
+
+	return pvclock_tsc_khz(this_cpu_pvti());
+}
+
 static unsigned long kvm_get_cpu_khz(void)
 {
 	unsigned int cpu_khz;
@@ -211,11 +221,6 @@ static unsigned long kvm_get_cpu_khz(void)
  * poll of guests can be running and trouble each other. So we preset
  * lpj here
  */
-static unsigned long kvm_get_tsc_khz(void)
-{
-	return pvclock_tsc_khz(this_cpu_pvti());
-}
-
 static void __init kvm_get_preset_lpj(void)
 {
 	unsigned long khz;
-- 
2.48.1.711.g2feabab25a-goog

