Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593DA6CDB4
	for <virtualization@lists.linux.dev>; Wed,  3 Apr 2024 08:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712131515; cv=none; b=Yg+VD/rYUdtqmEfriKEAc8WkIV0yIARM6vfDeevt/GRnE5HDf4AwkiiSoppsqjqKX9nWeqBwiZtijXQJUo5K1pS/YTeAA1NQP2LXcOWq95lsJX6RGi338kLqR2lzlh+Mc73OSEjAyQxnlZygiTkyys1sNGvTgZpzZ7VdOQEpyOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712131515; c=relaxed/simple;
	bh=QPSBE9QZ9I3ka5tiVYaLmRJclnGfjz8CpXpruGJQvzE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MKM9siRqBi9b9OlwyGC0ZcP/jgnzas5uhRtM66+vg6RlLBYtXORkv+OYLZmO5cX8AcWQswtuucTznrmM4KTsGssVvu6g3neRrpjOpa/HRf2C4mQ5eV+bcp6qDalA9Uts/dfoMUgterBJdxQjkvKvSuS5wqtG9c5e2QcLoMnGMsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=hSthJEqU; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="hSthJEqU"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1def3340682so52557675ad.1
        for <virtualization@lists.linux.dev>; Wed, 03 Apr 2024 01:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712131514; x=1712736314; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wk9dPs2pdPMy/ouYyBMSDOPD1OQUOIvovvehkpc98kM=;
        b=hSthJEqUZNQtIpyhz6abU6FaH/nOI+dfNs55Qp8Ga7iQA0FJ9C7itUVkKzkKxZXdGg
         Hy8Ta15jGgFEKW3OWSaNDcRjcfAeFFBakxLYgQ9s2DLDtxdk84AT61BHnk/3rwh6ypJK
         jclHtGvZXoBtk6+uZ2XIcx9MF0S5HtRVOKZ/H61rsZOQ+vNo4HnRvZ9DDtRuVySXYlEc
         qMee3um8RJPN64J37GIs8/1RBv48JOZnqSSi0lf/EpcvmJ24TdJ06A0uDtD27jCZYpF6
         y3xIwl8J2VlZJFk8Jar6yXtRrieCe6GM95ub1ZZTvEQmuqeZVAlwR2Oj50Kq1YUxwC7h
         jOgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712131514; x=1712736314;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wk9dPs2pdPMy/ouYyBMSDOPD1OQUOIvovvehkpc98kM=;
        b=ryBTj0hfMV4oavEkkUf+NPfAYoj2rdzgT4q5viC95tGy/K89DfW9AGAr9VW7Et70k6
         bg3qSNbL7BeCg0Jb6iENct7ShhvJaLarutFlUoKYRXpyekEeVRTENMa+zcOeC6BNt6po
         ZS6fuij93PrJr8G3Hh+Tx69NrLtRfKoQArxju2zgz1KeJoRO1R3uRtGU85WbyQlqc3eh
         uKBlQG9hPjB8Uenp4dKLfcZekItqk0lTFHOM37y9o+w0Meq1Gj6XNG8rPT9oCseG9TVb
         ZZJes/qGY+kTmrGpe3pVZlqNTmChcxgXA2fTZanHbB0hvQ+yu61fVE9B96K2Ovu400BA
         mhnw==
X-Forwarded-Encrypted: i=1; AJvYcCWvIQzis3JcUw2NBgTh+bLz77tuG3SFvvKUlGigxgnB5UQOEPvXbuLawc5JAANUrePsKYoPKmjxn+1SA0Uo59GDKy5QvBGfgMZ4rhn0VCY=
X-Gm-Message-State: AOJu0YymZwII+9VtPdFuE2qLRSPwKZemy5b54xQTnC3/gaOqbIVsILJM
	vtCIX1/uNkTG56RmIJrPekW4xjp0rjne1ipHsow3G7tT+5Lwv7xx8blorxItf0Y=
X-Google-Smtp-Source: AGHT+IGJGNXcOyb9YrykwAGNPaYyhw8xhsLdGwuGzUBrwVAzvp1h6eGWJ0tNbKMZggDJyDT4f6wwug==
X-Received: by 2002:a17:903:292:b0:1e2:6240:72e7 with SMTP id j18-20020a170903029200b001e2624072e7mr5865569plr.53.1712131513754;
        Wed, 03 Apr 2024 01:05:13 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id c12-20020a170902d48c00b001e0b5d49fc7sm12557229plg.161.2024.04.03.01.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 01:05:13 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
To: linux-kernel@vger.kernel.org
Cc: Atish Patra <atishp@rivosinc.com>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Anup Patel <anup@brainfault.org>,
	Ajay Kaher <akaher@vmware.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Alexey Makhalov <amakhalov@vmware.com>,
	Andrew Jones <ajones@ventanamicro.com>,
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
	VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
	Will Deacon <will@kernel.org>,
	x86@kernel.org
Subject: [PATCH v5 01/22] RISC-V: Fix the typo in Scountovf CSR name
Date: Wed,  3 Apr 2024 01:04:30 -0700
Message-Id: <20240403080452.1007601-2-atishp@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240403080452.1007601-1-atishp@rivosinc.com>
References: <20240403080452.1007601-1-atishp@rivosinc.com>
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

