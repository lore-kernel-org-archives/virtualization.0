Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC081D69C
	for <virtualization@lists.linux.dev>; Thu, 11 Apr 2024 00:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712794116; cv=none; b=BQnOd5WJQOdi84agrwWrJ2x/u7CowPNE2fr5uVOLK9mJU+3nxDbTEn3TuTYskrZ77n6bwVaK1fF1ufb+S5mw40NCR2uZ/i2oQ5pMd+FQcotybcsX+xBJxrv7EwqmaIGD4oc3ZwMWCc+cLrAg0GM5nZHSfPh7atfZrtgvRnTH5UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712794116; c=relaxed/simple;
	bh=i4/+SnhxIOkVH6jnqRPVGKLSvQvEdBjQqHeh5YP3SQk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MNtHG9Ll/kYsfLFD3ZkV3CTcdqwvtoWGBbGanlptmQNVZdDcbhgVxKFtgr4phLDRYrUbJfzhlcmUvk17UO/rZfOizA1Sx93bBoVR9WtsM2+FVPjFrcghtJ+upnBnTIQ7Oa53TMadXFw78NpRtGpF7QTcLDTat5qnlZYqqkPUO14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=eTPXzyBY; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="eTPXzyBY"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5e8470c1cb7so5200612a12.2
        for <virtualization@lists.linux.dev>; Wed, 10 Apr 2024 17:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712794114; x=1713398914; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N3Hu7DESDZEmcgrq2jc0sr2sorL47aa7h3H8SzaxXXM=;
        b=eTPXzyBY7FsP4CJcs+2CkeDe1gIdB5K2YgtqD5KrVRx9l//Wle9k8gdrIvpH8VmgQJ
         gJq7DAPLYds+9ITTfv3K9da4gYX9ho/nOMQq3JtbRgbgEvrH14vesEW+ulSjZNQPFbgx
         GNRQliy+822nRfvGb/M/E46X8BpfC9xnqv8SReAqPYJJ8v3e0+XydlLMpFaim1eC7Dlz
         uY2eP0a0AUhfSS51NlmYdyCFaPgxAxTJcsXiYVvxypIgtcVvVs6OPsj83xUVltAMb693
         xrhO0pY8CcYZ03z7NtmbPzwcUsHlRa4rBiGpoKqzrbORSDM6vaQ1RyVtCpEtFTA3Gjo2
         EQDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712794114; x=1713398914;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N3Hu7DESDZEmcgrq2jc0sr2sorL47aa7h3H8SzaxXXM=;
        b=OVLjNReOgwKBqo4lViPFqZsGQNup0GrtJdKIpEyw3tOFgHxhB6c0bR3HvfDHxZRgqv
         QbcXw4GhPArW2yImIiYjs3ZWhxqiFWuTZwS9QHbXRNCYPWJjkqFgjSOSKTKqZs0LCV5n
         O2S+GWFKF5Dgv7RGF32go8NzFzgUdLSobdbRYn7WBWyfWGgkhZOY71FsqRtRqCJSNau6
         WXzVPdFVTiCGTgo1gJB9d0FgtH/ht361Xr+NObOX+bOACChktSALNukDTaHd1WpNfSsv
         mWwgVUZbgXCG8SZxvWKdpr02BIlp4LMCwEc00YYNQBbIjuErZvihk+lkKrYP5Td0UMVr
         5M0Q==
X-Forwarded-Encrypted: i=1; AJvYcCU4KfWfA1sGJVrtJGjlrPrD96iaOOPkOcpWZaGxk0P+nymegP6FmR2LP24P9X93nNq39LlmG6gYUViYXVmt/ItfrJgAjBZRgPSiAP40mG8=
X-Gm-Message-State: AOJu0YxKHd9Oz/hgUqRdn13mQdS7gTZqfCnlbmwkVoGAIG3uNaqSAXUq
	jv22LwWO5d6TrijoGm2aEpt/Ea+w1YG9RqDZ8YRuC+E2kDoAHUpfyUlbm9OW3CA=
X-Google-Smtp-Source: AGHT+IGlZjUnG/cOH6oxCvOCuQrtoKifdSzPlvvNyoKqm+NzGiaKMBomwqkIVAChpjCW/s39Q+Uflg==
X-Received: by 2002:a17:902:8490:b0:1e0:119e:f935 with SMTP id c16-20020a170902849000b001e0119ef935mr3564608plo.15.1712794114043;
        Wed, 10 Apr 2024 17:08:34 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id f7-20020a170902684700b001e3d8a70780sm130351pln.171.2024.04.10.17.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 17:08:33 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
To: linux-kernel@vger.kernel.org
Cc: Atish Patra <atishp@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Alexey Makhalov <alexey.amakhalov@broadcom.com>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atishp@atishpatra.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
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
Subject: [PATCH v6 10/24] RISC-V: KVM: Fix the initial sample period value
Date: Wed, 10 Apr 2024 17:07:38 -0700
Message-Id: <20240411000752.955910-11-atishp@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240411000752.955910-1-atishp@rivosinc.com>
References: <20240411000752.955910-1-atishp@rivosinc.com>
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

