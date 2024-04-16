Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA8513441A
	for <virtualization@lists.linux.dev>; Tue, 16 Apr 2024 18:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713293084; cv=none; b=UQXuIU7FxrquI2/wPC21QKNRH5UcOtSy8FsDOqEnJaXHvrkDp2+7KQ3lC4UnftRPSxmBwzamffn07MJHVtJ/Xqu72pTpedDbyGca8axVhNrHfvz+fl3QAc9d9x57aPEAwVG12oosXd30IF9eH3MKF0GDm9pXqtPlFpmlPj+xdco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713293084; c=relaxed/simple;
	bh=CuOqtFD3uDjWgSKj5f6SchwsQQ87ZPABcb+EozPDHPU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=acO7xIO24bF4Uo8ZSNEfMoNXjuajocHAw9+xR0o4eklPeVLQktI5cUhwqLPIN/Gy9GDMLOEmkoU3GtfmKw2OnacqnEtxOXtwlu6qFO4XHwPjV4iQXjYeLlVYu8zAqtYaSuGC03kGGp40A87E6y6NeqLE4weK0hlV4z3wvvElOks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=cnXzRI/d; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="cnXzRI/d"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2a2d0ca3c92so47366a91.0
        for <virtualization@lists.linux.dev>; Tue, 16 Apr 2024 11:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1713293083; x=1713897883; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T1oS0ksNazYXtVOBgFTjTYlhVVLdg1h0owq7BrHVbdc=;
        b=cnXzRI/d9+JBMolgQuPF1lyX69n6f5xCzlQntO2RfrXjvZ/K07rdMjItbaZn+EhFe+
         nA2KNRjWRRaO7356wZehM9ok89L9X64eVXCNdlhqp44up2HMOigC0kT3EndjiSigKxJ/
         6ldMuJruSuXs0Iu1iRoTvTrVZG8IJhYQFIV0bQz/m5PJd3lXJf83jwuFUdxrAq4tUWP1
         yphSdz5hTxqEd07HSWQDT0u1fz3KoXvKVrJk4ENAw2Uq/bHlbQbMfRuys890RrRgK58N
         7yOG3gDv8VcmSETuHoiOMnvIIYSXHs2lVxxxDIBcUxnBuUnC52bKmgUokEIdnfliOefc
         pNcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713293083; x=1713897883;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T1oS0ksNazYXtVOBgFTjTYlhVVLdg1h0owq7BrHVbdc=;
        b=NCCAynKw4O0YKQnrRYeJVcc2XnZy/DqBatwFVw7mBS7a3UlmsqMGsnIVsFDobFSN2Q
         z6ry0/dTxzDv5tJ4QFAFGF6TOITp23O4nZ3pWRyOt2zWEfwHWbFFNJgS6h2FoENHfkex
         QfDF1y45epdZAI6RmLmvOHTiv++POvqdYqP3odS9DpnH/CkVBIIlw0x+l+yC98AuviiO
         H+gOyqex6+dAffkVuSq17qa46wnqamt9yxPOQ0gQTgOJKneIOyvwDf+fR1vJpJ/SmvMD
         /GGdF/Nj/Uk7WRtEOYH9uKv2EM0ULtMy4Z4+tpu1YyLc2Uyb6Acl+xiIIKzEup0sVgmR
         ONLQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5IPogTehWVtkAkj6lws8CSgF1/e5V6Jy7rfMzbmkKleR/wT8OJCgwo/cXU32ZgK6lxv3P0AIHikeiGGQATd5oRE6A6t0pMY0jINRbUck=
X-Gm-Message-State: AOJu0YxVEBhy1U111zBnTZQ7/Wps6iiNZENvmz1NiCXViLdMBFWzZ8Bg
	oaw0tk2vMBfT1aCM9COnsTAi7QirKLnn5hlA+UJApVqE5RhjZrg9xhARd7nO8ME=
X-Google-Smtp-Source: AGHT+IFCEO++RSNi2s4BPgY/cFtIWMTnHZE2PMfQmZHO7SJaFE1gAV8eT+53+kwpYpGgaU41aAh/DA==
X-Received: by 2002:a17:90a:7c06:b0:2a2:7494:15df with SMTP id v6-20020a17090a7c0600b002a2749415dfmr4080891pjf.9.1713293082701;
        Tue, 16 Apr 2024 11:44:42 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id o19-20020a17090aac1300b002a269828bb8sm8883645pjq.40.2024.04.16.11.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 11:44:42 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
To: linux-kernel@vger.kernel.org
Cc: Atish Patra <atishp@rivosinc.com>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Anup Patel <anup@brainfault.org>,
	Andrew Jones <ajones@ventanamicro.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
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
Subject: [PATCH v7 01/24] RISC-V: Fix the typo in Scountovf CSR name
Date: Tue, 16 Apr 2024 11:43:58 -0700
Message-Id: <20240416184421.3693802-2-atishp@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240416184421.3693802-1-atishp@rivosinc.com>
References: <20240416184421.3693802-1-atishp@rivosinc.com>
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
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
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

