Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63703FAE19
	for <virtualization@lists.linux.dev>; Fri, 29 May 2026 15:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780067294; cv=none; b=nbBy9l5Ly4TSjKxV8fLCjsF3flUGFN0Hwc4HAA5TRxurAmXAbPp/BDx8TmKqE1c6Eh/ydE1eTcCG3LkEHGs5FQB0chPh3LOnDLH54XQcXyR4ixwqOqTyORIIUDHCyv7s1tmZdCA5UgNedltBPycsYvLlQ1/xRlyujZu0+zSGmVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780067294; c=relaxed/simple;
	bh=exJIaYP606/6I81t2u+ZeN9QwrdKHiAhDu05aj2jV5A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NSxsMUnoxVG3Ljt0sDusHpW3lcGuXnnZ5uKD8z3Yuk7F9KpwiXmSY1BHZTlEV4mdQKz04DeLOu6ZZwqnlG6Ekcz/C50jg/4szl5SNrTRA8qTMm6LH0AAzlDlmbLD5LIg/FghdtQlwibFpFW3gQ4gPyv1BeqLlEKNs15ngdy2Z0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UONXSS87; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UONXSS87"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-36bc380fbf9so892684a91.3
        for <virtualization@lists.linux.dev>; Fri, 29 May 2026 08:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780067292; x=1780672092; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=0jsX4kmzCmqMaCGwN5oKHLOUS2DjjzJWXK44/xdBtv0=;
        b=UONXSS87awcnuG09vA8ub9onEwWCzBbbb11XZrPRjVfo696POo/Svj/idC/13W5Kfu
         TqN82eJlKgZ76CkVdzjbPkNceb+mtrci8ebhQsr3uhGemi8HMg1fa6wfBkw2ug77aRA4
         ZRINvh5wgo8VpN9fEQytgmWyTdFOkrXqbgJh7/gQ54OCzoNRAB1so+W3ff6SW5YP5T8x
         rbDgog7F92wI9PHcVamwo1IuH7S65fdxSsAzSRH511YvltClYeKGBK0JJMfDm2WRQwa3
         +XRhW10KH2DlVLoCxaqyfg2VTSvqK/gxJnUUqjv/FSwGCAkY/r54iyHGu0qrwY2tEZEv
         aADw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780067292; x=1780672092;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0jsX4kmzCmqMaCGwN5oKHLOUS2DjjzJWXK44/xdBtv0=;
        b=QjY+WDt5nPFGtftEbDlyC2ROeGsg+883HywDrkGxPWTp9anVNvxx3XqJogI6Wz60p5
         T3QvJiAmjiaSIIf71D/lrwe6x7Yj2kjUjUKFldeUAIi3HzucqZgqvcmDbWdnJLBCtmto
         SHrnr4SiQW934D9OKFueJrA2nFqHHxN3TkLX09Hh7lc3yBzkej7//S+KCag9d0JDR7O9
         Dcm48I/o0B9HYrXdPEy69YcRh5amAI/GDM2bVJVUm0GEP9Mn7dZm67VE7sit+BEbeZ8T
         4wI9s+57mZvpxqbrKz8e2MlyofXthDCTSUumZgS+QBDXyHx1S6soqX2pxSV1B/OBrxyK
         PBUg==
X-Forwarded-Encrypted: i=1; AFNElJ+3W1fxHMesJdTmbGq5y3f2kRRXPoj1Q3gff4M6PemR8JVUWj50T5/9DqnWrlN/Sh5pocSMjJqLweaYwixW3Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YxmyeuYpp5mZjd+Iri5aeMfljFgH9oEgkJmxA290T6XJNiq8Gbe
	1yTqFSS3U5dVNFcGFseAiTvqF5Bjq1p3HA2/soXgosiu90XA9OdDMaynR7AA8lQUB+CzUZXNQh8
	1GUkbew==
X-Received: from pgvi5.prod.google.com ([2002:a65:61a5:0:b0:c82:2dd8:9d49])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6b87:b0:3b3:d4a:793b
 with SMTP id adf61e73a8af0-3b411e5b284mr4378476637.43.1780067291927; Fri, 29
 May 2026 08:08:11 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 29 May 2026 08:08:10 -0700
In-Reply-To: <20260529144435.704127-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260529144435.704127-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529150810.714572-1-seanjc@google.com>
Subject: [PATCH v4 37/47] x86/pvclock: WARN if pvclock's valid_flags are overwritten
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
2.54.0.823.g6e5bcc1fc9-goog

