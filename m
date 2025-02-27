Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E4D23534E
	for <virtualization@lists.linux.dev>; Thu, 27 Feb 2025 02:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740622798; cv=none; b=KEVmj8eiZtHLsHkC5N1hFYnAJIJGquQ+FvREZcQIW5kZKffYosybXFO6+IpQVPH1WHCDQRxpZfV6k1+eqzwNafqSf1kwMrYjgTQQE4ze2tfQ2jnw6MOWJ5a991lPWMfpiBEvjb/rMVKnIid+5kj0428VOjeuWXv9LDIzB6/yfZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740622798; c=relaxed/simple;
	bh=9PNQlaFr17QsW09OA3IEH/cFSTquMC7pYNcyhSay2n0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=k+GTykQEtfUFMMxHLlY9QE5cXM0pEWLyjY5d3NjTOIwGenf5c0o+6EmthbYdBJlg7bMAzbCuO1l6nygunbgPjCeU2/qEj+bzumR3bIDh22pE2c8ejlbSUyNbYyj4YJ3ufjds1uSckg+3YbmJpf4Povg+qnGb/AtIgglaQHTzVv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cmAjvxme; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cmAjvxme"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2fe8fa38f6eso1027437a91.2
        for <virtualization@lists.linux.dev>; Wed, 26 Feb 2025 18:19:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740622795; x=1741227595; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=3F6YIZD9bSIlkGuU2KG3Ao1xkSJhhKmqbmLiePXFSIM=;
        b=cmAjvxmeLsldBT+QOQrdOaQ5D2i3k3QBVTbtK2EHoKZX2monppob8OvpAsaqq9tfqg
         jPK56vDkI4vI+l6RFSYczfmtb3Od72P7OG+W1d/gmtfe2aSLBsmpLAvWS56uf07FJihH
         H48ca87f0nC7YB+oU5vIsd85sXSYp0dGVmHiSEobsoGObrS4ZvcQjBqWK4IhlzfiQb6h
         s49M8LlwOtePIqo/bla7OaL2MkWqrx9ok0D6Y06VoYym6Hy/8rxDNdobZgme2Bc2kvNQ
         NfJU35c3VYEzkbCY79OKAsr+8xYvpYQBYjc9Dr2rRIOVoNqETSjGLfgkyT4oA++yxyO2
         4BaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740622795; x=1741227595;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3F6YIZD9bSIlkGuU2KG3Ao1xkSJhhKmqbmLiePXFSIM=;
        b=riBDTOBh2bwzOxPyCvBhMwhr3+P9XUZlD1/vGyp0AAYxwQYkOVYf9lbLddvV+KvGU/
         nEvL0zQ0WavR+AchpCyzrAegIFQ+NFL/JaNCuqc9FF/qnXUxvb/wEJVC0V/8WpdBReEo
         PWPUCS9TtS+XzGjVEhH4JyLwc+xhSMvuC0rNc2uU30ZpdXCLlQvLB7Xk5d5mKTVqdVPj
         BkenyrX0+ddGuF7UpJwTBAU1zGB0yo+K/j9gf3m0KALadselWsyFfxGDJqS8jpozmwrX
         QWnQQFor98fbQHQSkVBfkLqiuJx/hDyNVf4hzYEaDE0nLvVwmeZDehpJhRn4dkExAouI
         VqqA==
X-Forwarded-Encrypted: i=1; AJvYcCUmltUETVANqZhApIHrs5T+jbLlhXu5VF0b1WVLFgmWIZWTpcdOX0hWce0nmnQix3TfPWbn83ap6xgFUHj/cw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxcdlhdWjtSI81pAep8SdKdr5Qy9/5pcNnmeD/O9y+wegldSvdi
	tcff/LU6Uu9tKYHhYyJkPoeMQbZJ1WxSlJAcaTsN9RJbpJLe1CfKxvgVbYR1O7zB5nZ4GGMpIuK
	Kfg==
X-Google-Smtp-Source: AGHT+IGJ6z3saIzRbkZlSBZLnZw7mlbnCfDCjtlOA/kyHI3FVoB/Y5gfMuQ1H6WQ1/ZAhh6gzh0XRDRpGl4=
X-Received: from pfbfb4.prod.google.com ([2002:a05:6a00:2d84:b0:732:1ead:f8ac])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:1509:b0:1f2:e2b0:dd91
 with SMTP id adf61e73a8af0-1f2e2b0ddb7mr3698859637.21.1740622795028; Wed, 26
 Feb 2025 18:19:55 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 26 Feb 2025 18:18:46 -0800
In-Reply-To: <20250227021855.3257188-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250227021855.3257188-1-seanjc@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250227021855.3257188-31-seanjc@google.com>
Subject: [PATCH v2 30/38] x86/paravirt: Don't use a PV sched_clock in CoCo
 guests with trusted TSC
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

Silently ignore attempts to switch to a paravirt sched_clock when running
as a CoCo guest with trusted TSC.  In hand-wavy theory, a misbehaving
hypervisor could attack the guest by manipulating the PV clock to affect
guest scheduling in some weird and/or predictable way.  More importantly,
reading TSC on such platforms is faster than any PV clock, and sched_clock
is all about speed.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/paravirt.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index a3a1359cfc26..c538c608d9fb 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -89,6 +89,15 @@ DEFINE_STATIC_CALL(pv_sched_clock, native_sched_clock);
 int __init __paravirt_set_sched_clock(u64 (*func)(void), bool stable,
 				      void (*save)(void), void (*restore)(void))
 {
+	/*
+	 * Don't replace TSC with a PV clock when running as a CoCo guest and
+	 * the TSC is secure/trusted; PV clocks are emulated by the hypervisor,
+	 * which isn't in the guest's TCB.
+	 */
+	if (cc_platform_has(CC_ATTR_GUEST_SNP_SECURE_TSC) ||
+	    boot_cpu_has(X86_FEATURE_TDX_GUEST))
+		return -EPERM;
+
 	if (!stable)
 		clear_sched_clock_stable();
 
-- 
2.48.1.711.g2feabab25a-goog

