Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26E8143C7A
	for <virtualization@lists.linux.dev>; Fri, 19 Apr 2024 23:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713570481; cv=none; b=knNYTV+bdXSkAcVBOPvgEVoyCPepGKs2DSDLBAe1fLJPpoLIEo3LBNMDeLfOfPvwwcrTW8LcjpkZv26LJVwqvTfnT41RBqoFxIylER43WvILdOyWxHd9gz07IEfWpKYUTqb2nHfZVWFeG2YsN/l8msoQSNHE+xgY1mFglYhh5qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713570481; c=relaxed/simple;
	bh=MfjfJpm3VBkwjMm72HsMOvO9UI9tfbob2HC7hMKYzy4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B0E5xsKYVfoAcxG8WhdSX4Z17WZ9X+i87ABxO8A4WAXIBL3xhUHJr8ZIHo4iarevXQpfrpLiozJoXXmSt8uABzNZWdzviWZqfEGUW0JwzOa+A+Rkl3LNbeNtXCiT6RNC0mcNo7o+hpyuebsHPSMlJlH6KIVpZNj056p/Mase99s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=r9315kSE; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="r9315kSE"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1e3f17c6491so23430235ad.2
        for <virtualization@lists.linux.dev>; Fri, 19 Apr 2024 16:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1713570479; x=1714175279; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wkOPph+llp8Otwcwt9B3eiemeK+kGnMbysCIlXdxbFk=;
        b=r9315kSE634MwA15S/3xZK4Q18vFlKFxJsAn42TyyJL06sunU71UlVMGnnL/b0TrUl
         pLBFd1XJ3oUls11qHFfnHzbYnO8Z6zWu9hVLeLlOszeoZgp7rUd335OSYXrCu/pJP8pp
         N3cTxMa1F/MtI/AZ89iqPQKfUGGnmswTIFJ67HON1HN4VfLLOeDUCJ1/5vIQqwK4Gayu
         Auy2bPft3ATmwvFcfoY6fJDEGXqNswfQlALA6DJTj/f3wwxWA/4w2gUzmTYvLv9jqJJ3
         3tqk0ngMvBKPviTGgCvgo8KhMY7kqh016X/94EyzGX5f1IcO/uEhfLd9+7Ev2+4c80kl
         sWkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713570479; x=1714175279;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wkOPph+llp8Otwcwt9B3eiemeK+kGnMbysCIlXdxbFk=;
        b=ai7IalGTXaItHIn9nRJg4aVzg4oQ1NZnmBtGx1RfDxn8rUwMd76E+CAwtLgSymjuI0
         +2gM9MzdX8I9/MZavsm4O3TbOvNrzpNPeYIVu40FDt7g6iqDMaNmA8/NN1DhdD+RNkiC
         vb1/yqwo7T/x+oehLS1lSo7reUTKE1yOQkgA6JhegQyYYjlTMzeDqLGdsTpT+sOsUwqe
         3pb0SLjFA+SaUFafBKjX3FM59uhglm9ZdN+Wt+TDyibz7zPMxsz8L8RyUvSVe7hmN0Lr
         /gaiPdhd4I31AEcfAJTVWRVFAvdcbOBVIOHMwgZq+RcWNmL+KIwU4NwZ5xi7oJSAAyMX
         05+g==
X-Forwarded-Encrypted: i=1; AJvYcCUsNG9G3E0KZFcDHj5bmyB84shdMdH1dVbJMzO6WUSL1aoe29MUoW+7axO2iHVciKfC7r74YXq23hurQks9V3hYDvQWk77LZN0QoG63aBU=
X-Gm-Message-State: AOJu0YzGpT85LtTilDzR8b5Z629GqVMnMqLER+Ev0qXG/8msiX7GxnAW
	cr+vgALchVUaKWXAG3Ou1Zx0ORO6TbRjPnOid62X0lJTKzQkv4aCbryZQdWgxG0=
X-Google-Smtp-Source: AGHT+IH1qz0aQ7clqAJJ4fHpFjaj37g2CZsxbNmpL8sCd2e71ca+suKQb30C+gPwakigrEbB4x5ueg==
X-Received: by 2002:a17:902:784f:b0:1e4:a120:14f3 with SMTP id e15-20020a170902784f00b001e4a12014f3mr3799131pln.51.1713570479336;
        Fri, 19 Apr 2024 16:47:59 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id w17-20020a170902d11100b001e42f215f33sm3924017plw.85.2024.04.19.16.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 16:47:58 -0700 (PDT)
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
Subject: [PATCH v8 08/24] drivers/perf: riscv: Fix counter mask iteration for RV32
Date: Sat, 20 Apr 2024 08:17:24 -0700
Message-Id: <20240420151741.962500-9-atishp@rivosinc.com>
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

For RV32, used_hw_ctrs can have more than 1 word if the firmware chooses
to interleave firmware/hardware counters indicies. Even though it's a
unlikely scenario, handle that case by iterating over all the words
instead of just using the first word.

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 drivers/perf/riscv_pmu_sbi.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
index f23501898657..4eacd89141a9 100644
--- a/drivers/perf/riscv_pmu_sbi.c
+++ b/drivers/perf/riscv_pmu_sbi.c
@@ -652,10 +652,12 @@ static inline void pmu_sbi_stop_all(struct riscv_pmu *pmu)
 static inline void pmu_sbi_stop_hw_ctrs(struct riscv_pmu *pmu)
 {
 	struct cpu_hw_events *cpu_hw_evt = this_cpu_ptr(pmu->hw_events);
+	int i;
 
-	/* No need to check the error here as we can't do anything about the error */
-	sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_STOP, 0,
-		  cpu_hw_evt->used_hw_ctrs[0], 0, 0, 0, 0);
+	for (i = 0; i < BITS_TO_LONGS(RISCV_MAX_COUNTERS); i++)
+		/* No need to check the error here as we can't do anything about the error */
+		sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_STOP, i * BITS_PER_LONG,
+			  cpu_hw_evt->used_hw_ctrs[i], 0, 0, 0, 0);
 }
 
 /*
@@ -667,7 +669,7 @@ static inline void pmu_sbi_stop_hw_ctrs(struct riscv_pmu *pmu)
 static inline void pmu_sbi_start_overflow_mask(struct riscv_pmu *pmu,
 					       unsigned long ctr_ovf_mask)
 {
-	int idx = 0;
+	int idx = 0, i;
 	struct cpu_hw_events *cpu_hw_evt = this_cpu_ptr(pmu->hw_events);
 	struct perf_event *event;
 	unsigned long flag = SBI_PMU_START_FLAG_SET_INIT_VALUE;
@@ -676,11 +678,12 @@ static inline void pmu_sbi_start_overflow_mask(struct riscv_pmu *pmu,
 	struct hw_perf_event *hwc;
 	u64 init_val = 0;
 
-	ctr_start_mask = cpu_hw_evt->used_hw_ctrs[0] & ~ctr_ovf_mask;
-
-	/* Start all the counters that did not overflow in a single shot */
-	sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_START, 0, ctr_start_mask,
-		  0, 0, 0, 0);
+	for (i = 0; i < BITS_TO_LONGS(RISCV_MAX_COUNTERS); i++) {
+		ctr_start_mask = cpu_hw_evt->used_hw_ctrs[i] & ~ctr_ovf_mask;
+		/* Start all the counters that did not overflow in a single shot */
+		sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_START, i * BITS_PER_LONG, ctr_start_mask,
+			0, 0, 0, 0);
+	}
 
 	/* Reinitialize and start all the counter that overflowed */
 	while (ctr_ovf_mask) {
-- 
2.34.1

