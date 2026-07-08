Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBAB8313E36
	for <virtualization@lists.linux.dev>; Wed,  8 Jul 2026 11:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783511846; cv=none; b=NtubomvU+pYXFEkY3nRSMfG0H6zIZC+iHXL2S6QgZbOa3NKsMGOyfaNFB7oSi6s5vbrqFXWFQulBbYRwHB9g67zD1uzgLpMsF4zNY6HNlEtC/o8tdNSbqddy/IlnI2T59MY8Hln9BPCEQ1B6ehW0LBco4sQ1D29uH4bPBmgF3Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783511846; c=relaxed/simple;
	bh=SB5yBSpKpRxL622DthPeE9AhDUHaoafjvnJQXZ2a7rI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nDohvbXS4CAReRXi53IEh1bmCWNbviVXc8GzJF6/BlV2q6V6+R8ca9BZlNq82TkgZ3N6oR5Hq1BkPto7CQjmluj0/gQIYXEAhknVwQoWxTejuguT/+00hlzUIAf+4aUksZxVTwh3nslUjqfPDkg7gNDGlFhcvA6l4FmBpkXsHp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D8r2iFq0; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D8r2iFq0"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-37fc02e660bso670030a91.0
        for <virtualization@lists.linux.dev>; Wed, 08 Jul 2026 04:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783511844; x=1784116644; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IJb42q/+aKaf7klJf5qXtBaLq12oxzXxgI/ICJcz0hM=;
        b=D8r2iFq0fu/APbghVG2e3KpRYU+dqrN0LqvxXIB6JfLcL6XLMRfq9HER9jGbBziSWE
         AP0ZUS1urCxMqs23m8+BfYLPFVnyOOHCDTn11k3zqzIlsxunOAzo93+SLoy62EU4eGn2
         +i3uTu/dcfsb0PzIamuTZiQpGf8mZAnk5Qd36Hu6gvF82H4xWpQTxM//YAMV4NKY6MwT
         9IqzzYS1LPm3Iv3lgYHzvdeM2bOMMaYdJBlEZ5jZyeZI+80TiObZSGEbKtPHtQ6OQDPp
         tsAUC6GkeSC+eVear1iTdH70zDzIH97uMJ5P+5DY5ReTXmOxomeQ8R2NZTgiCbnvLqpz
         /sbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783511844; x=1784116644;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IJb42q/+aKaf7klJf5qXtBaLq12oxzXxgI/ICJcz0hM=;
        b=RHeaMpAky6tUC9w5Mv9fsoBb8rIhrl6J2vOuyA61Ls8u4dudNlz2+BTpsDA1lUucaC
         qi2CQhs7+kXRDBVVIJW87P4G5B2ErG+5gZDpaUIIXQkfGJtTb49wdhVYeKEZ6YFbPj5O
         1SUbbiPzBPOXZBhEAVc3QpR74HHcvDuCP4+4qoaR0OkwpTaqQ63b7IZrNE/Yk23VNwZO
         DQm9f6RSlnW8HxIYNB7F/+P1sg1Y9T/QJUcp0Wy040aDh8iCXSctnjXDYnPkJ85TpRX7
         Lsy21GHwkH6NnxY6YlQnUPBfhrZnTo0egPz8W3qg73QwGYgd2RhC7sv0y3gaCA12A2IG
         q3cw==
X-Forwarded-Encrypted: i=1; AHgh+RoZB1+5bOIbIyDtIipQcloOMaWEgXz0bDEFP8n0GhwHQnEUtAXxuc6fT5hZ9AoPdsebdhiGfsfygle+30rMuA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzMgCs203mGmS/p2jG4cRuFyae5XKHRsXYeLugXeYlTB2ULrSIu
	tuWnz7SdlICowSPs44jFgOBeoGZYcmu2iCDISc5enxZTEM2jLLsQzQZ+
X-Gm-Gg: AfdE7cktBbuWRYi2pmAPnoR2kHXwTWJHxQl4Ttn2d8bE/AOkh7hTvp70DxBNZOtigxk
	8QjLt+m6srh6nSA8v+Ajwc9OEUGFaKI4LmgRJeygp67TlzJvXvz2WQ+C0FuqZZ3MaW6T57iusOJ
	pal+vjSBT7/vkATtDiajWrshn1ZpsxDvPhl1y6CeU5uEiPlOLb8CIPya2cHe3xoh4pMaRictoHp
	QcjDsm2m4KNNzgobZFOs/QmZC81RpuUdu5wPVrJu6gGonFah3GV+FBR3uAtMekt8hfnUJU6wrif
	9AR18HlVY5wR6JTfZCR+6GgfX/OCZqz8JnMLVgPG+xnBPugjQxBuqUwLHqniota77fSzXSsZGTM
	itvvaaFQJSyTX/CgNB94Brz4RWuYQ6TbLx4znhvQ04nhcwznniE7qKpucFP+CtsQLTS6YhHccgg
	5K8Gk=
X-Received: by 2002:a17:90b:1d48:b0:387:e0cb:c8df with SMTP id 98e67ed59e1d1-3894239babdmr2393428a91.40.1783511844075;
        Wed, 08 Jul 2026 04:57:24 -0700 (PDT)
Received: from lgs.. ([101.36.109.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-387d15f13f1sm2675379a91.6.2026.07.08.04.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 04:57:23 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>
Subject: [PATCH] x86/vmware: mark RDI and RSI clobbered in hypercall1
Date: Wed,  8 Jul 2026 19:57:11 +0800
Message-ID: <20260708115711.754672-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vmware_hypercall1() uses inline asm for the VMware backdoor hypercall,
but its clobber list does not include RDI and RSI.

QEMU's vmmouse emulation can restore those registers through 32-bit
storage, clearing the upper halves of RDI and RSI. If the compiler keeps
a live 64-bit pointer in either register across vmware_hypercall1(), the
pointer can be truncated and a later dereference can fault.

Mark RDI and RSI as clobbered for vmware_hypercall1(), matching the
protection already used by the other VMware hypercall wrappers which are
affected by the same register-clobbering behavior.

Fixes: 34bf25e820ae ("x86/vmware: Introduce VMware hypercall API")
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 arch/x86/include/asm/vmware.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/vmware.h b/arch/x86/include/asm/vmware.h
index 4220dae14a2d..b9d9c4b98238 100644
--- a/arch/x86/include/asm/vmware.h
+++ b/arch/x86/include/asm/vmware.h
@@ -115,7 +115,7 @@ unsigned long vmware_hypercall1(unsigned long cmd, unsigned long in1)
 		  "b" (in1),
 		  "c" (cmd),
 		  "d" (0)
-		: "cc", "memory");
+		: "di", "si", "cc", "memory");
 	return out0;
 }
 
-- 
2.43.0

