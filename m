Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BEC143C40
	for <virtualization@lists.linux.dev>; Fri, 19 Apr 2024 23:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713570480; cv=none; b=VdfHbC8RX1uBXLiJ2V/RLwTkmxcNyc1RLlQqxm5KhSv4xrXuRMVwIIaN3fV8ezfBsuQY8x3fFMuD0ux0abeGI2hksJio1eDfbc19y8TCHwKk2xcplDW/PrQElbaqQU+yU8jNGPE7VqF50eGbC23iB4P2dc+hg+oQHBZ8W1sXI0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713570480; c=relaxed/simple;
	bh=H8usdALoznAt2isX7oNnrfLpFcaNKxvOOWa8DDbamCs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E2JNVHMdDfmnxheTIUZ1vdPDH3g7971fA9h8UbrbOktCSqxC993zvjdhmXl7GA4PtiNhxQFiTvwfHcl2v8TUvzuF2TnQ6+OKj91Y+dpDwGJ6gM0CCcFXbb7+00bdIIuwRdup+XfUhbLnPdGlMqaPUErS1H4PR9Poj+fEzRKzupM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=mt1WN0kT; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="mt1WN0kT"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5e8470c1cb7so1680469a12.2
        for <virtualization@lists.linux.dev>; Fri, 19 Apr 2024 16:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1713570477; x=1714175277; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rU9bTQzimBlb4bBeVGV64JD8vBjMh3ZSXWmumJprSMc=;
        b=mt1WN0kTPEHR0/5ZIg07tk2WCvk9LvbbZQ6HYd/H/2VyvBBBu/m62mJAyQJ2RCUQMt
         Kjsc2Js0Zn1p5pIRol7/6j5eZkDonWndHhi8Z47SRsGX41mIL1addBBalLbeO5/NlFxd
         O1mH+tBeoZyaEjtJlKNiiMsLgnRCDOWjUPKOyGM3525n+gDOUnZ9bLxdCpzBNmSq+7O3
         ULWatOyXOZl77QqgmXmHYOn9mbmp/+4/BGudC579zFb158Yaddjpm702j1u6bvYuGrSb
         9x2uOInHLa1MIiNYCp9Vh34HAp+wRqPqUA+suWHAWQDW9u0AUl5zOJSfDIhtJML8zFwB
         siCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713570477; x=1714175277;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rU9bTQzimBlb4bBeVGV64JD8vBjMh3ZSXWmumJprSMc=;
        b=czNhEukxuGJoN+fbDaZZG2RL3vv+0NIx3IjHRHTd8Ck46zyyiwA50pHTH7vZN1naHB
         8MMPdJXyrEfx0dI/iy99AfnOXGhYNpLI76rLvuJ10mIVc89SIP9gfL4yT4i4BvPcO43c
         6INnPmfl5+Wx7Nj5GUG34T2BklufrVWQJfw6QOaCaxqgVl9OO3X7tnkGJoOZNAWfa2Rs
         LUUC7naWnzV1R8eiOrL2XCVGATLJoC5rkXBx5IhBzWoUDvAo7sXtpYFxcNtpOUJnTqzV
         RSEqyXB1lcdfIIIe/CJAlQnGKPktUryp6Rc5dy/kXMBSjWYTJsxHnwRrp+oagUWWSmXg
         /qJg==
X-Forwarded-Encrypted: i=1; AJvYcCWDoH2sfbgfrzZi7AGzeNvbIPeMRMkn/++g60epiwn5+HaLcJgERI2q8rFHjLk5EHT3mKP9sV/VkPGC5DARw6IlhXxtYxZdtCmzCJOJHKo=
X-Gm-Message-State: AOJu0YwQu15qVflmAh+wjx8L9eYDhb8Wk9NwErPavtHxV1Ud4IbwIAvq
	2+I2h7IsHm7Xc5StfgFA75163oQESikZZnErQDAyYj6Rv1JhT0vpzBTkmS3aytk=
X-Google-Smtp-Source: AGHT+IEp4LLA0ETVFj3v2NTREBIL9JwLMfd8wP55jjHsvOjY9dRaboqfqB73D1IRQCndgtBmMeDbdg==
X-Received: by 2002:a05:6a20:8422:b0:1a7:336c:555c with SMTP id c34-20020a056a20842200b001a7336c555cmr4805991pzd.60.1713570477483;
        Fri, 19 Apr 2024 16:47:57 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id w17-20020a170902d11100b001e42f215f33sm3924017plw.85.2024.04.19.16.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 16:47:57 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
To: linux-kernel@vger.kernel.org
Cc: Atish Patra <atishp@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Anup Patel <anup@brainfault.org>,
	samuel.holland@sifive.com,
	Conor Dooley <conor.dooley@microchip.com>,
	Juergen Gross <jgross@suse.com>,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Mark Rutland <mark.rutland@arm.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Shuah Khan <shuah@kernel.org>,
	virtualization@lists.linux.dev,
	Will Deacon <will@kernel.org>,
	x86@kernel.org
Subject: [PATCH v8 07/24] RISC-V: Use the minor version mask while computing sbi version
Date: Sat, 20 Apr 2024 08:17:23 -0700
Message-Id: <20240420151741.962500-8-atishp@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240420151741.962500-1-atishp@rivosinc.com>
References: <20240420151741.962500-1-atishp@rivosinc.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As per the SBI specification, minor version is encoded in the
lower 24 bits only. Make sure that the SBI version is computed
with the appropriate mask.

Currently, there is no minor version in use. Thus, it doesn't
change anything functionality but it is good to be compliant with
the specification.

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/include/asm/sbi.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index f31650b10899..112a0a0d9f46 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -367,8 +367,8 @@ static inline unsigned long sbi_minor_version(void)
 static inline unsigned long sbi_mk_version(unsigned long major,
 					    unsigned long minor)
 {
-	return ((major & SBI_SPEC_VERSION_MAJOR_MASK) <<
-		SBI_SPEC_VERSION_MAJOR_SHIFT) | minor;
+	return ((major & SBI_SPEC_VERSION_MAJOR_MASK) << SBI_SPEC_VERSION_MAJOR_SHIFT)
+		| (minor & SBI_SPEC_VERSION_MINOR_MASK);
 }
 
 int sbi_err_map_linux_errno(int err);
-- 
2.34.1

