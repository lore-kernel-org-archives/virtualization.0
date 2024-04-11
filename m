Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A023DEC4
	for <virtualization@lists.linux.dev>; Thu, 11 Apr 2024 00:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712794092; cv=none; b=VxdOcLMrAzxA//2dvZoVr6UKT/HZ87lDalUz379IoVbLwNNMifu7EohnnNfvQZsTv2xcIgDPokNEfINrKbEOCa3qtqGn4OyaRiCTBa+FX+IagTtd5jy05BnIxFzicK068Zucd+683VcGzTqmwEtoIQRUobCKD5ouKPaTu9LR0D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712794092; c=relaxed/simple;
	bh=QPSBE9QZ9I3ka5tiVYaLmRJclnGfjz8CpXpruGJQvzE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fruvP1J0AmCnwTZCv1Q2Dy9wWWQQy81FyE7AZDyDGJ3sebG/ORsoCxO8WVlf/SeEzEg92rFzHt41LegmUp/3mCapBhEpInaE9vEfDLqAqpfxe1NK+C+9zHa3dxAgiNWygIl1FCs8UQ+nEZ4X9G4uSXMcrTILNyYgQmAmRTgjADw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=o6296qHp; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="o6296qHp"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6ed267f2936so3175650b3a.3
        for <virtualization@lists.linux.dev>; Wed, 10 Apr 2024 17:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712794090; x=1713398890; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wk9dPs2pdPMy/ouYyBMSDOPD1OQUOIvovvehkpc98kM=;
        b=o6296qHpjuSf6nlbC4vbKn/5rpbpv0KLUDddrXju2Dc5IXBNNAx6fq3FtKu09pAIgJ
         0IuZgFhOsHJFCNbp9F0H37dXV9IRKToS4ZxTFyjut7D3Uk3qNZCIzR682msdTsDwtf1Z
         iHPVJ1O0gN3B9AQOl0vajoUuWhqmnl0m/R7WjthXBpusviQogzyic3PtWjYRQQKSFjlU
         E4S/TKYm8jI9S4C/gf7zEDdIKO5nKci9ktzDlqdKOO8BYP5W307f70Gy/XmyVFQSfCzS
         vtZiFTWX1t4BB+ZbSmAd2GrJYibxfU0tsAyj2CpbPSMJqG1ixRsiFxDlZCCWB6JkavwW
         i+hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712794090; x=1713398890;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wk9dPs2pdPMy/ouYyBMSDOPD1OQUOIvovvehkpc98kM=;
        b=AtEcRRr2zjNcF9y4ZiI7RRt4cI6b4G9iBEN2PfF9oqEZAJO5WoXHGs7rDflLWNfZ4S
         MO6CGG/j/FOBkGDCTv1cy8wruu6VaG8ysW0m2Y9HML2mZoBMwoHTb7XDOQzIUM3ke3GK
         3XtKsMpyyx6UIGENVzk84OQN1Ww7E6b3LZjwS9l6uybwoemu/hSM6H8d18jyz3UULIiw
         2zFQfk/Bme1dUKtDB0ruYeXDA/igd1wBwJwHLIFdQIiPcJGolqX0G+VykW3UafWOtCHc
         WzTDogDsjNnwUeccgRa6rFcd0yN93PPh6EifKSutMb/kW3dsmhp/GmkDNbbXi/qYLC56
         c89A==
X-Forwarded-Encrypted: i=1; AJvYcCWi2M0UQvNuUiq3Rp3wM8ZlReM97Q7kFJpFp2VhNJLZ7ZSMKuXMzIaHrzHzBvC6+P9zEjvMeG3QAjjAGXGfw86PeUvFxOGaKP4uRqr9qys=
X-Gm-Message-State: AOJu0YzzJbwWk1gJnpR6v9ky9TGfV5VYzxlJNIBIpwXS+m1rs0Jge+DX
	yE+/N4uKmRzbmU8X/HnH4/QmXuxycNjkE/X5D2XjnVsnCjaTXIh7fh94zCAA4O0=
X-Google-Smtp-Source: AGHT+IEUlLK4WAkAvm3dQl//UcwbrhAG4hAU1Ze/VITIGy9xvn1rUCggLrBxo4kkHL3eR04eJnJL9Q==
X-Received: by 2002:a05:6a20:2d06:b0:1a9:4343:7649 with SMTP id g6-20020a056a202d0600b001a943437649mr5367555pzl.56.1712794089923;
        Wed, 10 Apr 2024 17:08:09 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id f7-20020a170902684700b001e3d8a70780sm130351pln.171.2024.04.10.17.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 17:08:08 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
To: linux-kernel@vger.kernel.org
Cc: Atish Patra <atishp@rivosinc.com>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Anup Patel <anup@brainfault.org>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Alexey Makhalov <alexey.amakhalov@broadcom.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Atish Patra <atishp@atishpatra.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
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
Subject: [PATCH v6 01/24] RISC-V: Fix the typo in Scountovf CSR name
Date: Wed, 10 Apr 2024 17:07:29 -0700
Message-Id: <20240411000752.955910-2-atishp@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240411000752.955910-1-atishp@rivosinc.com>
References: <20240411000752.955910-1-atishp@rivosinc.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The counter overflow CSR name is "scountovf" not "sscountovf".

Fix the csr name.

Fixes: 4905ec2fb7e6 ("RISC-V: Add sscofpmf extension support")
Reviewed-by: Clément Léger <cleger@rivosinc.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/include/asm/csr.h | 2 +-
 drivers/perf/riscv_pmu_sbi.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
index 2468c55933cd..9d1b07932794 100644
--- a/arch/riscv/include/asm/csr.h
+++ b/arch/riscv/include/asm/csr.h
@@ -281,7 +281,7 @@
 #define CSR_HPMCOUNTER30H	0xc9e
 #define CSR_HPMCOUNTER31H	0xc9f
 
-#define CSR_SSCOUNTOVF		0xda0
+#define CSR_SCOUNTOVF		0xda0
 
 #define CSR_SSTATUS		0x100
 #define CSR_SIE			0x104
diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
index 8cbe6e5f9c39..3e44d2fb8bf8 100644
--- a/drivers/perf/riscv_pmu_sbi.c
+++ b/drivers/perf/riscv_pmu_sbi.c
@@ -27,7 +27,7 @@
 
 #define ALT_SBI_PMU_OVERFLOW(__ovl)					\
 asm volatile(ALTERNATIVE_2(						\
-	"csrr %0, " __stringify(CSR_SSCOUNTOVF),			\
+	"csrr %0, " __stringify(CSR_SCOUNTOVF),				\
 	"csrr %0, " __stringify(THEAD_C9XX_CSR_SCOUNTEROF),		\
 		THEAD_VENDOR_ID, ERRATA_THEAD_PMU,			\
 		CONFIG_ERRATA_THEAD_PMU,				\
-- 
2.34.1

