Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7EB3136987
	for <virtualization@lists.linux.dev>; Tue, 16 Apr 2024 18:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713293086; cv=none; b=Dqwmu4o97ykgkH8VgSOkZBAapTIjdgYXvfhEFRORf8PPjg+6yG8KIQvsgVoHKBWpQYdv02MfWldgScMHpI5ycTeYy7Zihm3HttacDsQEu4F4XQ6ul0No6wvjsGyeIXJcuHeb+vlWUO3Vozus8eUDzr7wKt+qk0gyiHa32dwB3As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713293086; c=relaxed/simple;
	bh=tjU5YEqQieqMxVoH/UAjG6llZvkwIlIrjBWxORyGdm4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A5dBWHXXzSCSopj1Bcnht2tpBRGh5neuFC9h73vsbvvy2JMRTfezu/+yH6Km0iXwOzSn4CTB2QOLdS4DqLyvdxJDV6x5+U9t1oCOfRNYZiJAenf6uYNh/N/I9SiLJyHpVe5je63g7j+nV/0lOcpXaH3CpM3YeyszIR4g2BjjYwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=KgSXj/YX; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="KgSXj/YX"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2a6fa7773d3so3314797a91.3
        for <virtualization@lists.linux.dev>; Tue, 16 Apr 2024 11:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1713293084; x=1713897884; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2nwzSC0mjOXawHhzlfTnID2LKW7HdSbdpZLlPlBet3o=;
        b=KgSXj/YXqoAh9JGDjOu4joLIeERUWI2N6TZFqL5BVBcm/AmUwShaeJP26F5JuL76+h
         tuWxGkMhy6VeCW+Kf8PWJ8Gjc0SHf9pxOZWYCEgyfZ/k09dkPvQ02MUxHs2PEO9ePkrd
         XEaCZnBwy9XMZMmAUXeCxKxffIftKKO4nMEoLtk5Q6aalf3IcJs183lLgG2ez8lgmaG8
         5kSq1P+FlOM8hU55krH0ltczqn55RfIqvsz3CRP0z4+S3dTnSbICQ6nOi73o6xUd8QjJ
         kRgwogZA4DHnHs7nw84847PCk0xzB3kclZUG8vGQtSV1HjZZeLXg6wX7koXUb/xLFXAj
         uV8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713293084; x=1713897884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2nwzSC0mjOXawHhzlfTnID2LKW7HdSbdpZLlPlBet3o=;
        b=Y9oP+tMI4XJuxjPt0HsLnIw7IZ+GpvkuTNtapr/6z0c9CTAK8LvTlOE3KQia8QeCDj
         E8IrQZyU4xx9bGSHyqiNU6Qq5rmYq4SQDETEojjTLEPA879RH31uiAKlffXf8Yvc0gmE
         S5bi2I0B69vlB4VMIxYAOtuVHJRdkXYAYkaa6WdL5gnTqJES0bkKyXrBUk2fexo1Z+u8
         BJmBA++HpG3047K8iea/iaxh9hQMvNhLFtfah7/fOXe2GPOkxDO5E4kTYjxqF5Qgd/T3
         44M4f1qnP1II6x/8mFVawfQkdvkXkhlHVY+N/o0AfEzj3Nk2XxPvTqtCT24cGN44jVU4
         ha/A==
X-Forwarded-Encrypted: i=1; AJvYcCWrZiFLNYFu2z41/vhJoAWnv5oXaEvlhKllx5e5qH6qjvrcCsSnIcpcUUA4Lekr1pK/Qu1vvfw8GWsB849QF4Cah4cy9HpazL9MbiwLYrg=
X-Gm-Message-State: AOJu0Yx9c5zMetzau5J1ymEvAu/PRyKk/f9NyGgcBr5RMMCAXv4Y21ox
	86YbRncFixT2/OtamUh3xn2lSU3ajy1PzZzUvygwKVUklvCbJBdMtncOTcT6Th8=
X-Google-Smtp-Source: AGHT+IEoEjUu4cy1AorDUlJRRsn2LFZCsazPsjOtul090pjdnU5WLR3vSTyvWTwboMGTmVgvzKEuGA==
X-Received: by 2002:a17:90a:b00d:b0:2a7:8794:bd9d with SMTP id x13-20020a17090ab00d00b002a78794bd9dmr7689700pjq.39.1713293084173;
        Tue, 16 Apr 2024 11:44:44 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id o19-20020a17090aac1300b002a269828bb8sm8883645pjq.40.2024.04.16.11.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 11:44:43 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
To: linux-kernel@vger.kernel.org
Cc: Atish Patra <atishp@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Anup Patel <anup@brainfault.org>,
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
Subject: [PATCH v7 02/24] RISC-V: Add FIRMWARE_READ_HI definition
Date: Tue, 16 Apr 2024 11:43:59 -0700
Message-Id: <20240416184421.3693802-3-atishp@rivosinc.com>
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

SBI v2.0 added another function to SBI PMU extension to read
the upper bits of a counter with width larger than XLEN.

Add the definition for that function.

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Clément Léger <cleger@rivosinc.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/include/asm/sbi.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index 6e68f8dff76b..ef8311dafb91 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -131,6 +131,7 @@ enum sbi_ext_pmu_fid {
 	SBI_EXT_PMU_COUNTER_START,
 	SBI_EXT_PMU_COUNTER_STOP,
 	SBI_EXT_PMU_COUNTER_FW_READ,
+	SBI_EXT_PMU_COUNTER_FW_READ_HI,
 };
 
 union sbi_pmu_ctr_info {
-- 
2.34.1

