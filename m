Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDC512E1D3
	for <virtualization@lists.linux.dev>; Wed,  3 Apr 2024 08:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712131553; cv=none; b=DtNJKSbhS/d69wn+xlGDPwc+7IQiUhgEisgRx/RvZ4UABRjPOwVRDBMBS/EbWAP6u8u/CoCI8oH9u3qMr1HI83aKFfyzQGnyltb9k8vaPNCOmiLIDG8qXuL1g1Uo3QojHPkKJnLnOMMZJ5aL5amO4KPCLDwWFeQ0wRJjM56kiNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712131553; c=relaxed/simple;
	bh=kGDqdfAz5O6jd2BlwqWEgDKuhCYmFyrLfaexp9eWGuU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RexG/V7putpQtacBwRx4hwMXylKISlHu2HPTRiPFjr8taayQp18g8xmwzu1gE2ajXFi9VHG+XbTEC/V/cAWePTkT2bO2WhRoyITh8qQeeONFmqV0JypRIA2ZMOSnWRKYPTll3559owMSMVq8Iq3Sbb/JR9tCgCmkgUfMdzRTnQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=2fIESv7s; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="2fIESv7s"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6eaf1005fcaso2789812b3a.3
        for <virtualization@lists.linux.dev>; Wed, 03 Apr 2024 01:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712131551; x=1712736351; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xZMdAGbGUb3Pn/mM6S9aCTNbs+MKWuMa25SVPrHMqxo=;
        b=2fIESv7s7ofQ7LClkBrmIWNkWU7B1IpU2daCp5E6jwlXrBlOgweQ/ezo/RnFZGeCV3
         6RyxoUs7w0+0SGPN0DeEEiH8Mh+hmxhHqtc9epFzDbKrlF+z23u61iBFGUzaheE/4Nrj
         u6bsq3DYC1XfVyZkpo0iq1kmtlXH3LZBRLzhnOqPPMdeS9yboqQy4u2QPc/RCc92t9PW
         i/zlC+QVXkmxJ/WvcJ4y+LtE0kHXvZJEHns/P+i8OkQDkvMTJF6Il2IoeGY5i6M7dKy2
         1M1fhnzF2xm/1IpeHkokfVDJPdQFmXoyVGGeU/qiNpBLrZuVgChGqopo1i8OfLm4xbhP
         rPAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712131551; x=1712736351;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xZMdAGbGUb3Pn/mM6S9aCTNbs+MKWuMa25SVPrHMqxo=;
        b=a7k4APzLyjAWHIHjH01K8bpFd4oacgVYZ/x8yFf27G18VlPbo/HucAaUapkinarHXv
         PEQKmjJLHNMIflQSNfRlEE62W2Vaq0gFwm+jeDuCQ7u4S66TWIx7DuD9jPzsXrvJGs9K
         XOpoLt44eVmQ3eb5vJ1djfqn1UT7zuixrseNl4o0t05fKyqmhL/alJHlFwRG+vRjNATj
         nJnU8yEDtO4iohmycuC10QLk5f25wWFPZ3yJMrgp75RWKxc4hOz+1oD8+TgEwiEklNzW
         WSBPyPqpZjxkwToZDUA+b4DuYpDj8EALMMj2GI57JNkAYfVrSNcf8DL5ypsdiaXzsBLA
         7WQw==
X-Forwarded-Encrypted: i=1; AJvYcCVyBR2yr4h7SyUZq9Seda1KMEyZIeLlLifVrgDMqSQ3GyJ+NjM3Ihzf6oI3SKMaD2HLDwKS3Vac2VCa806BZ2EfrhF6tyvgW/n9CZ/5Vc8=
X-Gm-Message-State: AOJu0YwZhcsfHZfMAw+R5C6aGDHhxqxWqPdbRVnyx6N8Ruk7nKhS2jgx
	NUs1AoDroWOgzMO5599FiDR/zDwFBT7iv4Yr9EVQhmym0TQQzjjJ+6Z+9Em8hj0=
X-Google-Smtp-Source: AGHT+IFHku/sICvAenYJFC+cS7PaObyEd64lSbck4sFkQiPnTcMjwhsfqy4pdW/5l9uIy4qG4AZ0Fg==
X-Received: by 2002:a05:6a20:94cf:b0:1a7:377:b867 with SMTP id ht15-20020a056a2094cf00b001a70377b867mr11062652pzb.57.1712131551038;
        Wed, 03 Apr 2024 01:05:51 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id c12-20020a170902d48c00b001e0b5d49fc7sm12557229plg.161.2024.04.03.01.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 01:05:49 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
To: linux-kernel@vger.kernel.org
Cc: Atish Patra <atishp@rivosinc.com>,
	Anup Patel <anup@brainfault.org>,
	Andrew Jones <ajones@ventanamicro.com>,
	Ajay Kaher <akaher@vmware.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Alexey Makhalov <amakhalov@vmware.com>,
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
	VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
	Will Deacon <will@kernel.org>,
	x86@kernel.org
Subject: [PATCH v5 18/22] KVM: riscv: selftests: Add Sscofpmf to get-reg-list test
Date: Wed,  3 Apr 2024 01:04:47 -0700
Message-Id: <20240403080452.1007601-19-atishp@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240403080452.1007601-1-atishp@rivosinc.com>
References: <20240403080452.1007601-1-atishp@rivosinc.com>
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

