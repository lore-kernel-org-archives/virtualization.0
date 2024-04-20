Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B499B145332
	for <virtualization@lists.linux.dev>; Fri, 19 Apr 2024 23:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713570484; cv=none; b=ddHZF1pb3EdB5vy5sBRH4uoHiyxwlDzJg+bJTy9fGPM6SRwEGIdWIDLPFeXJwoxaxyTUy3zM5KkGOwfSZH3MbSxnAxlicQbnmYq6LJ0Jo24F0tjvCnoCCO+Q1aTRVD/YcPzzlVEFokGSJUc1TgFP6gIjeEi+MD/VNcZd0rrtFM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713570484; c=relaxed/simple;
	bh=i4/+SnhxIOkVH6jnqRPVGKLSvQvEdBjQqHeh5YP3SQk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N/oZmCFBG/VI+Vsur0r/WsJhMIT1f5xwp4x79b+yR4Cj+XUqyeWX2bkAZ/nUC65KRkwU2EQD0ERPzRKhtKHwmmsZQTQgMfVZbuRTXP+/EU7v2kMCfSbc+5cZEwagjX8i/XID3befbqJsWiVhCAn0BP7r215ddAkRC+6D1VNgYB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=atq9iKuK; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="atq9iKuK"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1e40042c13eso21256615ad.2
        for <virtualization@lists.linux.dev>; Fri, 19 Apr 2024 16:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1713570483; x=1714175283; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N3Hu7DESDZEmcgrq2jc0sr2sorL47aa7h3H8SzaxXXM=;
        b=atq9iKuKXNG3+kQkcwxL+VB0vAAZutJ5w3uJJD1+r62kUqAoTpgICXM/3jnh0Wv/Qb
         eu0C2XQHlbZB7hKAQN6K4Xl8S/eDhtpm/uJmEFt+faXVOB9+GzPqkcctxjby6qtbvqBw
         6M3vjNeL4yKmVa3tFZTvhV9x/tLdGaW7G35AS29NR15wYyfcAJ7tCH55BUvzquoCFleM
         Xc/DYvpPC0IvFZWPn+H4ekCBJ0op2AfPr5+7LI9ApL9CsTYwswkhRdbOqwQN6C89bjsu
         AR6IX+16OcEl1OAOjpEd5nRTE6/Z0+35hVH9sdGijyJCydw/LhxP0VXKvIXa8nG+BbHG
         aaog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713570483; x=1714175283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N3Hu7DESDZEmcgrq2jc0sr2sorL47aa7h3H8SzaxXXM=;
        b=A94+C+CvsbemcBbZ7ZKE8VbXKfrmNvwKwsxZNBHsk6AsxYqgNxcE+4cHyNTawDR6vu
         7hv6CnNCPkCp9CoIajrAm/glzZ34Xl4fNzLi4stLqINT/cYIGeJRzVyueayNL8fdoxTY
         PYgIQAipRgkT79g+HEpl9YC9bYYbNi0uq7YZlwbnQsLJCVq4BWMVvbBVWG+bXscJkEY1
         GgmmE4xOxO6exU7BYtLyz4E/3Am4Y04C/MoHYRzbQ8ZkhRiGGbG/EdDmkbNrvYb5hN1w
         B0tzpGs4mwsMFlUS1HxD5jxHkGRUbrvi3s61akBq21E+2T5n/FvqjOgPiPozBbeSx1mD
         gqQA==
X-Forwarded-Encrypted: i=1; AJvYcCVQHPpUobhU0L8Ssr23mjA+6o8hMMZEnEPFC1tkFpJnO7wtjL5kCjyvnyvZrueIb5qBOtI7WxFYkjpRR1noQ0zJ8nzV2F8u5J5XlbI56s4=
X-Gm-Message-State: AOJu0YzTye/5Mxm9zCeNI1nclkHRSwIGFkwLi1BZSDCPg8jleWycRK+x
	dlspFlfa2NXL9eJXKpIkgGdC622zLFzVZEtOpHgbwLQxunzzqd+MLaFMUSUBblY=
X-Google-Smtp-Source: AGHT+IFuxivVAucFqLYqwANgIIbEmyPV0tNMGWLxqaH8776sBq/Go9KZec7LTwKbbmPafjRvAwUZ5w==
X-Received: by 2002:a17:903:22ca:b0:1e5:2ba9:a667 with SMTP id y10-20020a17090322ca00b001e52ba9a667mr4212130plg.3.1713570483020;
        Fri, 19 Apr 2024 16:48:03 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id w17-20020a170902d11100b001e42f215f33sm3924017plw.85.2024.04.19.16.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 16:48:02 -0700 (PDT)
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
Subject: [PATCH v8 10/24] RISC-V: KVM: Fix the initial sample period value
Date: Sat, 20 Apr 2024 08:17:26 -0700
Message-Id: <20240420151741.962500-11-atishp@rivosinc.com>
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

The initial sample period value when counter value is not assigned
should be set to maximum value supported by the counter width.
Otherwise, it may result in spurious interrupts.

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/kvm/vcpu_pmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kvm/vcpu_pmu.c b/arch/riscv/kvm/vcpu_pmu.c
index 86391a5061dd..cee1b9ca4ec4 100644
--- a/arch/riscv/kvm/vcpu_pmu.c
+++ b/arch/riscv/kvm/vcpu_pmu.c
@@ -39,7 +39,7 @@ static u64 kvm_pmu_get_sample_period(struct kvm_pmc *pmc)
 	u64 sample_period;
 
 	if (!pmc->counter_val)
-		sample_period = counter_val_mask + 1;
+		sample_period = counter_val_mask;
 	else
 		sample_period = (-pmc->counter_val) & counter_val_mask;
 
-- 
2.34.1

