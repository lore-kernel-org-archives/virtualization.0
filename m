Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A181D48094F
	for <virtualization@lists.linux.dev>; Thu,  6 Aug 2026 23:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786059394; cv=none; b=tndsua+HMgNgErpQRTf0o2/Yp2t416Zk+AsjJw4F/6PaBtVBl5bpAb7RGbvhGWVmcSJ0OnE/0Ey0uPbcIel+jDUCN8TRVm34oZVojYeVLsUFqtZxWwEBu/YPYKfTx5ZayDQ9/mIMkDX4d7fiTewUuRMTxhrHP8CJbjgZZ7cI+xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786059394; c=relaxed/simple;
	bh=X1lXC7wwYepEcyxXlelWc3xQjHjFJjQegmWHjMap6JE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rLc1HGdWEFlc4YNUSzakjZAiB6dtbquHf03b2bbDiRakQR98JhDB4L3DdE1KvnGRXhIPbslSO5l+liOieJA/kUKD9W8+W4c/Y66Jm0VzMKbBgBLkfEkhkTl9q5MMkhbohdhrZRmhSHOmuKLpYsj0mhS91Wl4TiVZK01zzGmZGF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RGqlbNEy; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RGqlbNEy"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cf7dd9fd91so24417135ad.1
        for <virtualization@lists.linux.dev>; Thu, 06 Aug 2026 16:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786059389; x=1786664189; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Bl6f0kmYO+QvCHyY9ZYfUQzYrQcYJLjL3x7Z6ExdFrE=;
        b=RGqlbNEyJTVRdqBEnCLV32Ym/ouDUO1C5aqHfoGi1v0YWyI9NaHEl92ELcfqsqvqL/
         0rusC6d+svwT+TKjopjsnXQwDWibfsbwPRjHEcwYw/BReS45zm9GPECmm4rGPnih4S80
         /JumUloA2krGjQoOshc0yj8ipcShLV8aknqT5Ak06xC4bmL+BepdXePHjAPNHPExJhlA
         t8A7zW1L/euQSJ2UOwhb9tgtc8p3aGTFRvxip3jIzEWlCuJs1kZo7egEoOnBb6djGK3R
         WqmCa2wwJSwOIVBnDjoy1cSYztn+mjOeJ9bLRYUkpJZK2rqNpwOoggOcjupBI+q86xWi
         7dBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786059389; x=1786664189;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Bl6f0kmYO+QvCHyY9ZYfUQzYrQcYJLjL3x7Z6ExdFrE=;
        b=TqQmiLukz9xgVs7Rk1zIH79Xk91kTpqputFMq5Y2H4irt4v1VkXsg9N5LUiLXXFy/K
         kY4aATfS820cnHqiYSDD5HBOEoNprqIEp+lwq9gXQofIV4rQhzt41lobxSh8+amEwBgA
         7wJTbkM/c2RrNUl221KnKajx9DXQrchgHtHYAmun7gj51ZxfoegXXN6/XO5cR1UDEDw1
         db/AKrkVpAU1+cEsxX3zYjP77hhJRFGa+Ys+/ZqL9QgwmGbYHj1vddWSoPm6mLWu21Ln
         n8SnQdm5TEfQ3qZPkvdfs72ND91px6oskX/IQgBLr013pseteewu8JFhf/BQxxHsvRU5
         DqZA==
X-Forwarded-Encrypted: i=1; AHgh+RpxbdsK7YfSLnnCa4O3bgu6qFjVifuAhoxnAIshpqlJCIDP7088uaj9x6tdj2ZphlJExRY3qFVwemBs8uHZFA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyk7cJYb7xKzK2z2ECHQ9z4b24rvBuvtnopkDMXEUHY9j1IUKEJ
	0qslHeXaIW2TIv8RVzVB3gCnUgGX6eg3h595QfLVJcDpR0hFYMyV5TOUAlkeTBAswfu2UvDQMMa
	Y6GIPFQ==
X-Received: from pgav2.prod.google.com ([2002:a05:6a02:2dc2:b0:c85:9dd2:d11e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:7349:b0:3c6:3c5b:f2e1
 with SMTP id adf61e73a8af0-3cbadcfcacfmr5222309637.32.1786059388428; Thu, 06
 Aug 2026 16:36:28 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  6 Aug 2026 16:35:21 -0700
In-Reply-To: <20260806233609.212337-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260806233609.212337-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260806233609.212337-5-seanjc@google.com>
Subject: [PATCH v6 04/51] x86/tsc: Restrict recalibrate_cpu_khz() export to
 p4-clockmod and powernow-k7
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

Export recalibrate_cpu_khz() only for its two users, p4-clockmod.ko and
powernow-k7.ko, to help document that recalibration is relevant only to
ancient CPUs.

For all intents and purposes, no functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/tsc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index bc4348585194..09bf10f322ba 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -943,7 +943,7 @@ void recalibrate_cpu_khz(void)
 						    cpu_khz_old, cpu_khz);
 #endif
 }
-EXPORT_SYMBOL_GPL(recalibrate_cpu_khz);
+EXPORT_SYMBOL_FOR_MODULES(recalibrate_cpu_khz, "p4-clockmod,powernow-k7");
 
 
 static unsigned long long cyc2ns_suspend;
-- 
2.55.0.679.g6767b8d81c-goog

