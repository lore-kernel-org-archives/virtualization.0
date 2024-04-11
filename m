Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554BF43161
	for <virtualization@lists.linux.dev>; Thu, 11 Apr 2024 00:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712794142; cv=none; b=cFtLl8iLJv4PsiQU3fj/tgM0KW3n8hePFoYgZYuxCjUb1CAG9sRHMK+fWVFHYSDhzuDWJNwrIqfWTHEL1svO0E/gOF9DD9RIk5n8IYzwBmR2DyzpfNw+esn/7/NnSdcxLcAtO2XFqmn88229cfO1x/t/aGnmCdE+xUtBFw3vAAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712794142; c=relaxed/simple;
	bh=kGDqdfAz5O6jd2BlwqWEgDKuhCYmFyrLfaexp9eWGuU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U5oajDDMHchD5YCi1BYYBPyKh2pyNF3g6F2GS8FDaLex3KSAH77CPXGN3hh8VGPgd+1+wB9x2qNGp0fSHYdVfB4KqskhH9O6r5rWpythR8VN/Q6QFtV8ZAb92cO8YMDAuGMMp8XrY/enJaKyBFw2YDZ/7abiSK0FqN1lx8Iqlhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=qIeSaGq9; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="qIeSaGq9"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1e2c725e234so2638775ad.1
        for <virtualization@lists.linux.dev>; Wed, 10 Apr 2024 17:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712794141; x=1713398941; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xZMdAGbGUb3Pn/mM6S9aCTNbs+MKWuMa25SVPrHMqxo=;
        b=qIeSaGq9LlQlapV5TH6ozD9GgZ3AQbsSTOxV6MgkjRK7EgWTummbMt369vEQLlu+hV
         HvG4Z0mCaimSL1FSlWk2yYPNZYwgKcXaQ/Xr0fnk709GdKU4MU/tebK4OXNYuu5yU5z5
         LGcjXVQNbaEwOCZ5xR6m+Kk6KAf8OFMlncMtpYKuZGeANbnqIMMs9STpaR/FEv6xNe63
         UHVcHmNfw/XXq++CZBh8n6dCqpMlXI40DbWsGB0vaElFfJf+7Duh/+jktEaSPg67c3Tv
         uvE/lUDza6lXQ9uDWlS1ZCN2SG8L1OJfRq+AjzEyD+Uc6tmAxyFIHG9x6RM+B5eQm+c/
         tgzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712794141; x=1713398941;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xZMdAGbGUb3Pn/mM6S9aCTNbs+MKWuMa25SVPrHMqxo=;
        b=kx0HaN4Q/VCWAKVGvIQ8NkeIfqgaN7czuDXHtLGHJ7A1yIEoOwjwvWCG2R8SaxhZwO
         8IEYQzkXfAibPBytPtUb5M/zKUqac4FXurxzoMCib3nALk9jrrLBKQPzWOz2mtJjttPt
         7dbfhxdqLgNH7v1zTFScxni+X3tkXDKSxatdY64REyuISxYjRSr4c2do1xrLMQWsbaji
         6QZLUIL4cQdUZ233POXFJDIPIPNmwsFGGc4WTF7jUlh7KipWHgo7eBH1FpounTWDYX+R
         F0fYzY0ThyjSyf1FTJ2yMLL53W0SPWFhJyfAXylk0PL1jVRKnoIp0nz+jze7FMOT+q08
         5aVg==
X-Forwarded-Encrypted: i=1; AJvYcCXN7meAsE5cpog7Gwya9sq0/aGPIwSyPphU6dsF5hlc8sMJQAARZ1RJcuKiomWgTtAx8isKq/mtmEy6AaZboFJaHubApp9WLRTSJO05GsI=
X-Gm-Message-State: AOJu0Ywfrxm4hMIZuReUNqwk8XD+YqimO9NWZxYHhxHvoXkx4LVGPnNn
	kUqlzdUFAP8sNwMWHgNLEiO8IJ8gd8fJ4GkAmuoL6rDhshvBT+RH8dwwEo4PaVg=
X-Google-Smtp-Source: AGHT+IHrdco+Nn3vB823qWCjNowMIOzBoGtN1xF2JabKGjxDIXVa2NH6OeieucLnKkpVZpIdiowNLg==
X-Received: by 2002:a17:902:e743:b0:1e4:39e0:660c with SMTP id p3-20020a170902e74300b001e439e0660cmr1368224plf.23.1712794140724;
        Wed, 10 Apr 2024 17:09:00 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id f7-20020a170902684700b001e3d8a70780sm130351pln.171.2024.04.10.17.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 17:08:59 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
To: linux-kernel@vger.kernel.org
Cc: Atish Patra <atishp@rivosinc.com>,
	Anup Patel <anup@brainfault.org>,
	Andrew Jones <ajones@ventanamicro.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Alexey Makhalov <alexey.amakhalov@broadcom.com>,
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
Subject: [PATCH v6 19/24] KVM: riscv: selftests: Add Sscofpmf to get-reg-list test
Date: Wed, 10 Apr 2024 17:07:47 -0700
Message-Id: <20240411000752.955910-20-atishp@rivosinc.com>
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

The KVM RISC-V allows Sscofpmf extension for Guest/VM so let us
add this extension to get-reg-list test.

Reviewed-by: Anup Patel <anup@brainfault.org>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 tools/testing/selftests/kvm/riscv/get-reg-list.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/kvm/riscv/get-reg-list.c b/tools/testing/selftests/kvm/riscv/get-reg-list.c
index b882b7b9b785..222198dd6d04 100644
--- a/tools/testing/selftests/kvm/riscv/get-reg-list.c
+++ b/tools/testing/selftests/kvm/riscv/get-reg-list.c
@@ -43,6 +43,7 @@ bool filter_reg(__u64 reg)
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_V:
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_SMSTATEEN:
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_SSAIA:
+	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_SSCOFPMF:
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_SSTC:
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_SVINVAL:
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_SVNAPOT:
@@ -408,6 +409,7 @@ static const char *isa_ext_single_id_to_str(__u64 reg_off)
 		KVM_ISA_EXT_ARR(V),
 		KVM_ISA_EXT_ARR(SMSTATEEN),
 		KVM_ISA_EXT_ARR(SSAIA),
+		KVM_ISA_EXT_ARR(SSCOFPMF),
 		KVM_ISA_EXT_ARR(SSTC),
 		KVM_ISA_EXT_ARR(SVINVAL),
 		KVM_ISA_EXT_ARR(SVNAPOT),
@@ -931,6 +933,7 @@ KVM_ISA_EXT_SUBLIST_CONFIG(fp_f, FP_F);
 KVM_ISA_EXT_SUBLIST_CONFIG(fp_d, FP_D);
 KVM_ISA_EXT_SIMPLE_CONFIG(h, H);
 KVM_ISA_EXT_SUBLIST_CONFIG(smstateen, SMSTATEEN);
+KVM_ISA_EXT_SIMPLE_CONFIG(sscofpmf, SSCOFPMF);
 KVM_ISA_EXT_SIMPLE_CONFIG(sstc, SSTC);
 KVM_ISA_EXT_SIMPLE_CONFIG(svinval, SVINVAL);
 KVM_ISA_EXT_SIMPLE_CONFIG(svnapot, SVNAPOT);
@@ -986,6 +989,7 @@ struct vcpu_reg_list *vcpu_configs[] = {
 	&config_fp_d,
 	&config_h,
 	&config_smstateen,
+	&config_sscofpmf,
 	&config_sstc,
 	&config_svinval,
 	&config_svnapot,
-- 
2.34.1

