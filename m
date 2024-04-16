Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1324913A3ED
	for <virtualization@lists.linux.dev>; Tue, 16 Apr 2024 18:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713293093; cv=none; b=AjxrPMwZOL4jW+qkDHzEkjMMH64U2p9mENyIerCA7zmzTH3vb8wIo/zO8AnkpEWRis+q0pRPodSDWkCujJSGlkrziDTbp1xbKCazpUl+7haB9fZ7MzvXMar6dF+ZPpKS0TP3dc9WxuGh5QgI7dvMMwmmbJF/DcP7Xe5lq3paLHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713293093; c=relaxed/simple;
	bh=H8usdALoznAt2isX7oNnrfLpFcaNKxvOOWa8DDbamCs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Os4Q6KAW6553KDzY8sEpL69stkWkS4okurt06iwGkcxsbQZi4cIDdYdDnsYChG9g+C5UX2PMMPhKeeaIf09w+AdqcCXTLOb2JzJwOb8uinYXp43ELAJ80pD6GcXHxNy3WKKhd6MmVT4tdNBpuQNI0HZ8Dd9R+uKNNsgOaPor5HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Xflhc2Jv; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Xflhc2Jv"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2a475bdd4a6so2768461a91.2
        for <virtualization@lists.linux.dev>; Tue, 16 Apr 2024 11:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1713293091; x=1713897891; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rU9bTQzimBlb4bBeVGV64JD8vBjMh3ZSXWmumJprSMc=;
        b=Xflhc2Jv9lLkqRw568Dd2C6TmU5a3xaVTugk1MZDawY88Z1RMZ490rZSh69FeEWjfI
         5yQI6+dP2e1nmVeuIgPrVgyv7gKFNsob5UFJiAkqPKFTkLEslrHbuCTgEb7FH1S94RET
         WiZ79uK/YenTkZxqmzGCZZPy17oweplxtgU+lqBsmHGPVMg3qTCczO3vIqrdW7nDpUvj
         VJcd/MXz1FU03+50/h82YHsLKoEfiDj+Gf1Te81Xk1MsqyxUXwvAoQHa69Vjh29pEH2X
         H4MRq0drvfiJOlqsMaejY+EON+wQHRUNt3SBRHyyQpT1q+eFfKcwbyYjBTZ7MjyTbQMm
         l8iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713293091; x=1713897891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rU9bTQzimBlb4bBeVGV64JD8vBjMh3ZSXWmumJprSMc=;
        b=lSeMqWVgYbIdzla8qXK+rcMycjyWGbCBQRhd37raaekX4DaFSXN6vUDiHb4Vz9So5y
         DOPmsziL0we6NF4XHLUpu/Q225PJOy4PWHzDfasqKDqcEtbAUQ6G0gzj8lPqaZyx6Q1W
         ZMyHqFeNIPgnDci7qgpYuV9C8XiwAgbCXyEyGtJa5npkAMJpe7rbndBR5U+TRAGnqqkC
         ad/EJInzzBOCo0WlJjmXNoM86MxMEPZOV0Xu7dY99E3fuwcOxN39HMGGUG3m1atLYuWK
         byAfki0J1rRsiGuguCqeEcGohFjgLPP+AEap1Xty4GEiZ4lp5FHbA/Xfm+oVjPemhFlU
         fUiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWH3KUm5FelsFgkNIl6P85kq3fZGln3oZFdgrHRAqi+Jsnbj+9rzOQw2WNWDhAwVUslZE+rGspHUcKfRRby/l/OmzyV7xgGgDW6NYhThew=
X-Gm-Message-State: AOJu0YzBjMDI9mmE/Pv6PPL6Q3xn15YhawxUmCeORpuuuWimMwsmKxa2
	0VcK8vBf5ggjc9sUyoI576LaorGCem7UNA4MjjdCVpwjXm5WENkrsG9kfnuNCzU=
X-Google-Smtp-Source: AGHT+IFO7gBokex9KDHR7FMDDghsIz2thvCcgFt0g1hVdtn3kLkpEMXY9Ea3s80HyJZdLNzoP7x/LQ==
X-Received: by 2002:a17:90b:46c8:b0:2a2:50ef:ece2 with SMTP id jx8-20020a17090b46c800b002a250efece2mr12099952pjb.17.1713293091321;
        Tue, 16 Apr 2024 11:44:51 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id o19-20020a17090aac1300b002a269828bb8sm8883645pjq.40.2024.04.16.11.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 11:44:50 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
To: linux-kernel@vger.kernel.org
Cc: Atish Patra <atishp@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Anup Patel <anup@brainfault.org>,
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
Subject: [PATCH v7 07/24] RISC-V: Use the minor version mask while computing sbi version
Date: Tue, 16 Apr 2024 11:44:04 -0700
Message-Id: <20240416184421.3693802-8-atishp@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240416184421.3693802-1-atishp@rivosinc.com>
References: <20240416184421.3693802-1-atishp@rivosinc.com>
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

