Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BAE428D1B
	for <virtualization@lists.linux.dev>; Wed,  1 Jul 2026 19:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782934399; cv=none; b=qu/6H5heKpEXbTJy8glglGzQz292X+DRs5oGKeF0E0U8/hHOC30TqF3qQIwWYBHqEZymC9GZVa1uW9weWHBurwWIQG/LDPL3r57mDuZt0e+tqF3KIpoOmYDg1aMQnooLwejAiE2w8LNEjyBl6nfUiALeFP0FCBiONmhIwc6Imz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782934399; c=relaxed/simple;
	bh=uS9BChC7KgGK2M+8u75Q9Ryt/QRAbZtmL5i8BGg+y40=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=m164jLZdyTxAFQj9eNDUXt1h4s2p55TDPmMBRgbUlBCBH81I12oXy2K49387O9x8Xv2cq2Awuh8vO7NzeDYNK20Zb4We8LXsVe1bwP4Hju1fZepEe1to/iHwbA/LIRjbLpczbjG/8wz0gTTUoEOUp1xGiw32l6dfTvNZ33L5DVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CnkMyXHp; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CnkMyXHp"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-8479c6c6cbeso868235b3a.0
        for <virtualization@lists.linux.dev>; Wed, 01 Jul 2026 12:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782934396; x=1783539196; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=w419X+lYiD/kBIvhKaeAU2oxypXcdz+V5rg+/s/ZS+Q=;
        b=CnkMyXHpNTDadvB5Mlfx2LQ25bo47G4xKx/c45Np/Hm51F0cVaCjqhMYGCtY1/PULc
         kD8LIj6H2X2BDjee7Gwbut23NxKpj4bpIGOVKmCIbz57EKehqOGgWUB8b5CJl5x3EQlS
         BFuvVtEM6eJsYBe4GBgwL5zjbnCcwxqzfaCVILXlt3fu/iKUjVdj4QqhK6dMxxoBNjva
         co6MwnJNyvmTDMCAM/DadREZUkuBHiGWpev7akTe42ayqx3Fw3yvxR+VzZPxwoREkc48
         odpLvSPE0v13V5HEehL256LmWHIY+gBVNTwgr8Ffc6TgXSD4fE5a/J+6Z+wDOmLK8XfU
         f9AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782934396; x=1783539196;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w419X+lYiD/kBIvhKaeAU2oxypXcdz+V5rg+/s/ZS+Q=;
        b=AZhicK1rPuabDozJ6EaD0Lvf/9Zb/DH6dGcPow4SwtgugPtMHU0or15h0A91wc0zOH
         rFN8FdYqSmn+ekB8srXkNGo3NDG9s+ge06zsx/NRT0l5WuebZYeGFnsmedC+8cpkRHPF
         WE7BlnuGtGhOVYi8Dt73bO9EYw0wdxSFbRuvbJSzh53nqWLdqb1JHbP23d9bOp5KBz2Y
         19iC80rwhh9of3tuifQoetkuTV7lratlvLb3QxNLKY8m3x/Kdl8DUS3BVAr0KOUUa4eD
         CsbQycFigmXkYvgq/N27QoErsQhnXOCZ+2y3UidPMJgO86+5gQCxHOXIw0gYxJWxGa5w
         14hg==
X-Forwarded-Encrypted: i=1; AFNElJ+4hPWz+4sElq7x4IWkw4+ZbpPweQQ1bafIm3EbLZPLkjPkyu51JOkUJAY4K7ds8mobSkkpqFPyUubI9m0ERg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzGE27wY+hBUqzhKWKbZOzi7+i8DOuSQeS9H8cNGvnfnIbmfEL9
	DDzYCExnP+410rwkSxMU96raPeOeStJjqNszOx18v8dM7m4H5lnHjcgDb2psFJrmkZwley6uuTe
	hO6UkFg==
X-Received: from pfbdf8.prod.google.com ([2002:a05:6a00:4708:b0:847:a13f:28e2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:a112:b0:847:8f7c:fa10
 with SMTP id d2e1a72fcca58-847c0894ebamr2717987b3a.35.1782934395673; Wed, 01
 Jul 2026 12:33:15 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  1 Jul 2026 12:32:01 -0700
In-Reply-To: <20260701193212.749551-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260701193212.749551-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260701193212.749551-41-seanjc@google.com>
Subject: [PATCH v5 40/51] x86/pvclock: WARN if pvclock's valid_flags are overwritten
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
2.55.0.rc0.799.gd6f94ed593-goog

