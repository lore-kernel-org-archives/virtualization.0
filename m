Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A5313B2A2
	for <virtualization@lists.linux.dev>; Tue, 16 Apr 2024 18:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713293098; cv=none; b=UMgR31TEC0hEqtEozvU6fBULkRWaXvDzi+JfJVufVhFXr8ZgRlJcDua0rn6JACZJGnIxsYwXPZVn1pBGZ/43Rtl20ZWFcYaCe/zUY3AAWcO33hFCUes3UsOOlEQCCBd8aTleD8Jd6E7oGxR0EUZUCbzrEvq3S6ZIY18e2+9B62k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713293098; c=relaxed/simple;
	bh=i4/+SnhxIOkVH6jnqRPVGKLSvQvEdBjQqHeh5YP3SQk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FsyryCUSu/91HV+92esPydEquL9+GpH4FVWI8SAQybK+ji/DNXLFTjazDXyeLlmIr4xyavH8TOKkyrppYbwg6UbdX5i4TzOI4+5gQCqkxpjOL6+oThAdPDqdUyYF92Udust1lDED2GKv70mgacmVKBCxIoYMWF5HUkG0Jk/5RWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=kPqIIT0P; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="kPqIIT0P"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5d4a1e66750so2595772a12.0
        for <virtualization@lists.linux.dev>; Tue, 16 Apr 2024 11:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1713293095; x=1713897895; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N3Hu7DESDZEmcgrq2jc0sr2sorL47aa7h3H8SzaxXXM=;
        b=kPqIIT0PSxEa/SuW4Rw7DYz86C8O0npF/yJy5q7YiyBDkinBO5j5eCkYueaXwT3f9h
         +YaOf/8KaacyYwcTOKlZAtVe2UngS1ma1bQtOSLrgJGNAMOnmgX/24FQht+3iCZUyNm/
         omk2FdjUySLD7nmE2EGm14Ju8PSy1Vm9OtxR4zJX31pFQlf6rYsZJUecMdYsjbP7FFdV
         Ey3c2CKRWFzPLVcCV6sqCNg5boHuJYRqkL3mrenY6v4exw3jeT13WrIldCv+G0+/8rrN
         LC+nppA+1O8o9Z2XkURa0WTVaC1rr+Ius3YXE/zj+iNF37wNK8BNa1gYQoKcr5a+H60J
         AVhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713293095; x=1713897895;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N3Hu7DESDZEmcgrq2jc0sr2sorL47aa7h3H8SzaxXXM=;
        b=fPC3L9yNRmNOVGcXSIVeAYZIbrU43GGk/87YHZptMrpAwradWLgk6mgZ7X9A5oTBgZ
         LPdiWcaMGjF1ojf5mnsgv2AopYnFjWHFseoW3Rqq5V4wFsrrZSTJCZLnVz9JyrUtdB1h
         jzFHZub4oyTy4kmZdJalqe5CJ1hq7JR0IypkNhmDIj9QxD/3K63VntJJbfLcBDth438U
         9h9QE/2N29EbKxxhalen//lwgmy9WzqmF/2gxqt6gvC1VRcoD3SZSl51fH2cv3s/zXhE
         3hnoTE1mSeUyxFRTDTjSvuGmBVUJw6ujIfJhcFfDFrrBHaL6rliKgys+YnI1YHknFjOC
         yy+w==
X-Forwarded-Encrypted: i=1; AJvYcCVDTnNET5V4AkxndhAn5lsp8EbK2w38AKSf5/dl/OTKw2Lgxba4Oc8skqj8d/u+CfGNUlXS3dxzBwBy24HplV9fe2JvTCbIPkRvpkFxLeo=
X-Gm-Message-State: AOJu0YzeuIQjF5Poy0TYn1IM1Uv3jwBmYExzqoLxcfQxFWW27OCE2Lt5
	NP0JA3DcdLYGG3uFuLpC0E8pj2zDLLz/faE0mU778RJ6doiAt7GpfBEeLUW4altoLiw3iT+8JGv
	9
X-Google-Smtp-Source: AGHT+IHMrJmnJNbaJLJrDUHsyvS17+PaYjcpk56OE5mezOqfopuoWKSQzyxBPEpMmbqXUeSJxlz5IA==
X-Received: by 2002:a17:90a:d511:b0:2a4:8706:ed44 with SMTP id t17-20020a17090ad51100b002a48706ed44mr10231042pju.19.1713293095691;
        Tue, 16 Apr 2024 11:44:55 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id o19-20020a17090aac1300b002a269828bb8sm8883645pjq.40.2024.04.16.11.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 11:44:55 -0700 (PDT)
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
Subject: [PATCH v7 10/24] RISC-V: KVM: Fix the initial sample period value
Date: Tue, 16 Apr 2024 11:44:07 -0700
Message-Id: <20240416184421.3693802-11-atishp@rivosinc.com>
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

