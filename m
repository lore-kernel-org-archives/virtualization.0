Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A6713D898
	for <virtualization@lists.linux.dev>; Fri, 19 Apr 2024 23:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713570469; cv=none; b=jVHXWsGrxB2pfIJThhKs0gPDscvHGZqqoZ69D5tzQ9nh74ekIjwrBccsMflSAZ2fCbNGKZBFBohp1IYlVb+jRsM78Plrf1gED2NY28HOlsrCVAo9jtiqfknybohGhXVlyqVGFHASGAvHZa3iFSEJxzKyMSSlAqpdj1AbVHz5gkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713570469; c=relaxed/simple;
	bh=CuOqtFD3uDjWgSKj5f6SchwsQQ87ZPABcb+EozPDHPU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fD8btIzSrslNxV62zXXBJ9drg42uvkr2WJnCqQVPjIIpuTZE7QkEb3batwUtfupwb58MdPqgs2yFgCmEcSCsBTSxjG3d3hrWjjOTUPeLHr8HFupR0jyetoBJ/WUOXijUC+5L5A4UUx10GVDkFy5fVBbsIOlB8atAHprQ17rpFbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=klwNhKxc; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="klwNhKxc"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6ed01c63657so2383206b3a.2
        for <virtualization@lists.linux.dev>; Fri, 19 Apr 2024 16:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1713570466; x=1714175266; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T1oS0ksNazYXtVOBgFTjTYlhVVLdg1h0owq7BrHVbdc=;
        b=klwNhKxcbhnGPENrcAq4aJ0/H/YFdPY48FN3IFhX8AIEd393rWkQQQyKTZ/Lf+64B4
         DJcn7586NtsgOX+/Xh0DsHdk9kyusjgli6QkLOr5W/Sd9H0NGOju15xhtSzvUTBh/uEc
         J8UpwsThsT+MXbrlfkfLp6A5p6TBNonsopZonby0PVuOS2ACJPMicXDukqIJQ7yTGogM
         dQOh3Q8TfAbmiOecRa8/PPfeJmwZUy+NjZqr//jciv9/Y4uypKLQtl5TtlzR+EG/Vb/v
         e04ilYhn7klsr6NFxv5N45s+HkF1lHardlTLeuM7ZJfSR5+W2E9QTK/bw2ZbDv0wzvS1
         Xt2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713570466; x=1714175266;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T1oS0ksNazYXtVOBgFTjTYlhVVLdg1h0owq7BrHVbdc=;
        b=NuBZEHtbaA7IwnoN8NQ7OB4Du1sUMeD+08OAaZanE0a18ubNL+j051S2kcsF3WlpSR
         nppTH7jlFY8iz08YBvk7knSG+jyuPcAOf9nE4U/hlHdT5b8d807SHeuwGu57lQaBI0Sn
         RBqEMC/1XdPkGyp836G9W2z9bdbn1SvGOo+pXHZg/Cl77dyN+d9WO9STY8iAH+7i+ijZ
         OWCRITyZGQib3+/hyt5k9/0FEAJJleOQb+FylOUWKguCEtwxgsG0+OWXaH4x5OCjBbar
         l14cBwhi9dxZe2zlfYNxkPRYjRHK5Vx/1VF4mkAQvyYsQEsfgag/zvfKHIOysVeeQM6J
         mjAA==
X-Forwarded-Encrypted: i=1; AJvYcCXjAjjdpa4ST3+yndqNxLOHjud+B57F4nx4dyg66EJN12yI9i3ePxGrf8R6zL2EgQCA87bk9Km9dHS+yQCIOB/m4tW1xc5WhqngbfMbIQo=
X-Gm-Message-State: AOJu0YypDN8zXkBzzUUEGvWonS7cWzmahZ6kbYqJN++BPKqoAxpOEg1r
	wi8fOLwIa+UP2a0smxi0ivSd6LgHwnHZvcmI5Ikd3xi5yiTh87LAN/u0AvG+cBU=
X-Google-Smtp-Source: AGHT+IFVCYaBvcy0sMILQIREFkDThLyGOm3uHSxCPt859IORFbCyXjP0cIaU/flxgT2NJkC34c1s7Q==
X-Received: by 2002:a05:6a20:100b:b0:1a9:5e1f:8485 with SMTP id gs11-20020a056a20100b00b001a95e1f8485mr3527584pzc.31.1713570466351;
        Fri, 19 Apr 2024 16:47:46 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id w17-20020a170902d11100b001e42f215f33sm3924017plw.85.2024.04.19.16.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 16:47:45 -0700 (PDT)
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
	samuel.holland@sifive.com,
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
Subject: [PATCH v8 01/24] RISC-V: Fix the typo in Scountovf CSR name
Date: Sat, 20 Apr 2024 08:17:17 -0700
Message-Id: <20240420151741.962500-2-atishp@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240420151741.962500-1-atishp@rivosinc.com>
References: <20240420151741.962500-1-atishp@rivosinc.com>
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

