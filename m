Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A984175B6
	for <virtualization@lists.linux.dev>; Thu, 11 Apr 2024 00:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712794107; cv=none; b=RX7CX6NKBMv2Bz6cUsGdi29ORx4OubFQs4YP/OkduyWK9vtVyVbve/VthRtVvgAh9KGVEFLmoYDEBSZvGri66cszQ6Hpck1wTbRlyNCBw1Ap2vQ5ZIJeNTlIczmfOeleavqR544FxDv7s3TMwxdBMYcVVzWob+47c9yDIxq6XZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712794107; c=relaxed/simple;
	bh=f7jwD7at3eRXjUvJMDfYkww4RoUkr2LuWcPC7rhOq1c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iodp4lfYvwMHf3DdAPREPb7BSavjMX/AaMrI3WeoGpXVH1N4A6LivBoJukomYtgdPMW4jM4tsBV/0rFHUm5wIafPgaBZl8eWgDxCA7H8i8MUJYic5IvdAQAHuqhzV8p1LL6i+zHf8GvnZotWJQaUSJXCrnaZtHmnxv6O0UOmm5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=ChbWi6Vq; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="ChbWi6Vq"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1e3e56c9d2cso38855085ad.1
        for <virtualization@lists.linux.dev>; Wed, 10 Apr 2024 17:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712794106; x=1713398906; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Ogf9r7p61Rc1oGw0oa8bhNwO/iV9jqlxUmzvsZGcz8=;
        b=ChbWi6VqRDPQRuQiFSy/ZBHMRWRX3P6VvhlK9wBJmQuHjefPqOLUAtzqsogwUK5ttv
         oEGsOdPc8GSdw8GLYzOP9ha2LB0Bz51Ek+Ls3EzppuboV+KI8tSuQBzw4Za2mhiTSb/H
         7ky5ZJphpNz3buOTzJW88npkCp8Sobc47pO0va6/TRJeycx4kl/NvmMdxKXjOhQLLjk4
         V6oaYJNCnAZPoScxU2H86bJFSMnB5kxqxaKmZ5zZhTlU9D/YMx14QfYctIBP1q1/3htt
         NLlGjjlR+cXaCitYvRmzLAk1CFd31IiEdf2mZ8EKBEwAdLJebgcLIW5jyGArABWigJGk
         utiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712794106; x=1713398906;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Ogf9r7p61Rc1oGw0oa8bhNwO/iV9jqlxUmzvsZGcz8=;
        b=E/ZS5WLDC5lOIBpuebj1d6+ZMh2pWifCkxz7O4MNuEypNlK+sXDUiKOdZIX2S7pmBc
         Zp7vUAN53p+GFtkAQB6vpUCi1LqqTSMIxJij2jTEpj8zjhLibb61KR/B7JUarj7Whzp7
         7RSviE89o76K92f6fCbS6HlI3lvSSJb+UqZp9CUVuuOQ7XFupHb+jG/QIofuDu9YCOWS
         GY/nZHK42T5AiyDoLta8k9R25z7Sv1TkvvfN4smd3DAM7/v/r+qMz+v5B4R/xbZwgXzQ
         kFebo+sZbKrVr8pCv/uuL3i/fc5s+ZAZIIfycCz2WAXJJzlo76zQHWJD1hSR3r0qhRxL
         iFsg==
X-Forwarded-Encrypted: i=1; AJvYcCUBQ/Q4EbrKErfz+U3YvhSbiLMGSbEj0xDbErZSg93Vk7dBAXwOwPHWK8MsUDrc//Cf3nc605aQ0+bqW5UaIeDnWE8Bdm3jURxzTeBbAy4=
X-Gm-Message-State: AOJu0Yz+LVbBm7dsHm11byZsY58R00Kq6ODELyivpKw3s5U6LfgvHmO9
	fiVsH5Zsh4j+8AX6TwDG12nED3fgaBP+CRVTOhopnJ4zobRJBJMOtlkqttNFQ10=
X-Google-Smtp-Source: AGHT+IG/gd//TA1TkjWqM9vD82L3r8r0JszUDH21ZhI6QqZDs4OR9Y/ESBK0GgL0mQ8WNU4EjNB6Kg==
X-Received: by 2002:a17:902:c944:b0:1e4:911b:7a6b with SMTP id i4-20020a170902c94400b001e4911b7a6bmr5362603pla.61.1712794105838;
        Wed, 10 Apr 2024 17:08:25 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id f7-20020a170902684700b001e3d8a70780sm130351pln.171.2024.04.10.17.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 17:08:25 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
To: linux-kernel@vger.kernel.org
Cc: Atish Patra <atishp@rivosinc.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Alexey Makhalov <alexey.amakhalov@broadcom.com>,
	Andrew Jones <ajones@ventanamicro.com>,
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
Subject: [PATCH v6 07/24] RISC-V: Use the minor version mask while computing sbi version
Date: Wed, 10 Apr 2024 17:07:35 -0700
Message-Id: <20240411000752.955910-8-atishp@rivosinc.com>
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

As per the SBI specification, minor version is encoded in the
lower 24 bits only. Make sure that the SBI version is computed
with the appropriate mask.

Currently, there is no minor version in use. Thus, it doesn't
change anything functionality but it is good to be compliant with
the specification.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/include/asm/sbi.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index f31650b10899..935b082d6a6c 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -367,8 +367,8 @@ static inline unsigned long sbi_minor_version(void)
 static inline unsigned long sbi_mk_version(unsigned long major,
 					    unsigned long minor)
 {
-	return ((major & SBI_SPEC_VERSION_MAJOR_MASK) <<
-		SBI_SPEC_VERSION_MAJOR_SHIFT) | minor;
+	return ((major & SBI_SPEC_VERSION_MAJOR_MASK) << SBI_SPEC_VERSION_MAJOR_SHIFT
+		| (minor & SBI_SPEC_VERSION_MINOR_MASK));
 }
 
 int sbi_err_map_linux_errno(int err);
-- 
2.34.1

