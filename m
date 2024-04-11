Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F2B8BEA
	for <virtualization@lists.linux.dev>; Thu, 11 Apr 2024 00:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712794094; cv=none; b=BDqwcqnur7GOpiVh1ezn7pTKaTuSXVJtjUcvBsgi7HBnzd7WvPARfJQRpMp49ojo1T0pcYTsdR/BlSlfTch4g50TZtoiGtTBRk8w9LtNPy7YPr1VLwh6USl7XcPta/FIG0WPgjn8jHK64BU+k/9ebIrKRj8jRH9KjhP31OrzHuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712794094; c=relaxed/simple;
	bh=tjU5YEqQieqMxVoH/UAjG6llZvkwIlIrjBWxORyGdm4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F71rr6YJ33hH+b9GmcXihwedabMkAxXxXsSmS519UVbc/a7nYZJUbn2QguJt7RYGizWc0vVOZ8wfg9OU2gwyANG8NEVtXnkL2p9/op8VlyBkKhFolEeuL0eqLxDJNQJ97ShydEzjrNKCbED8KXyxLR1BQ8MJJTpLUoSCdIUVKUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=CHi+pjTP; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="CHi+pjTP"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5ce2aada130so5116899a12.1
        for <virtualization@lists.linux.dev>; Wed, 10 Apr 2024 17:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712794093; x=1713398893; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2nwzSC0mjOXawHhzlfTnID2LKW7HdSbdpZLlPlBet3o=;
        b=CHi+pjTPe9/gQfCtuqFQSJCYcQcxBTkdPYrM4AUAC6wlVZjM5pEwOpfjJQXF0xvsWj
         ADs1XoIQHmvODEyHBRmq6ouHcm55R6hT+6ikcUuugT5DgiH8FAwhtfFfguyOCZ/bQlvg
         2hfoFmTQhPGtgDH0khakDzKUTQcyZC8AE8zP3dAD79tPGJLTEAqiycGzVib+8CXiBlGj
         Tbshku2zlYQ3FuFEDNiiPBg/MKcgylI6k+KrU4vdnrlf5gPhfqdBCbi7RCDjq2BZMnwm
         ZI8F4pt7vfur4byYhyarJG0PMjKxUk/xjRioqpDgo7B87ouYBDysiu1aYuQJIhnUhsEZ
         jabw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712794093; x=1713398893;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2nwzSC0mjOXawHhzlfTnID2LKW7HdSbdpZLlPlBet3o=;
        b=QK1n/QFSQMI3GUkrRunXiZJMuLkkWRFy1lQUfgf91MIc/PilhVa82FZ1bATnE9fwMc
         6jfGAp9aBJBzBxUFcCjt2YraaJs+uin9SaUHr+sGk6aKvCdJMvfJmiUslMAOAMge6rZH
         UsaMhFWsRmSVFUtFUJJnPLv1cIc4z5lqn66rjIJdgAMjhd9jo/J7SLITvBZOYD0XjgVH
         n+qcOMdGgIq0I99LmDZZ6ONaWm5Wtlw3w4uQRFWYQkVeEzGwwT+3/x++7NCy1c/bGyhc
         KrtPALlxhfmtYa71rroT/amPNApgZ2TKr6/fXPObqlrgm0iE949YG0iiN3y6Flu48WE2
         xCqg==
X-Forwarded-Encrypted: i=1; AJvYcCWRcwyGJXF7mCiJGDJl5/3S24Y3IJfjq0EhdtuEep3vkbOFFN3c5NvIcS2eXr6ge+9riOSug0q9lVY/KFBDsnMAi+7I3Y/tGqcNsFLM89E=
X-Gm-Message-State: AOJu0YwAbRJiDz7TO6SpjV1JBEQR3gE9iiZ1DpGjdvLFuZ9wuBDDi7rC
	DDkP26DB2/vSGJcvNSLJ2ztWA8A1sE3mVtiyQUrdua79qurAAfcjTRP8VcIDFOA=
X-Google-Smtp-Source: AGHT+IG6OqYaJjg7MK1R6d7hiCeHot83RH1wCuW5h1sC+EdY34oQu3GEIDBFrBS/g+puRrw/WL9vMQ==
X-Received: by 2002:a17:902:d511:b0:1e0:b62a:c0a2 with SMTP id b17-20020a170902d51100b001e0b62ac0a2mr5130331plg.51.1712794092857;
        Wed, 10 Apr 2024 17:08:12 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id f7-20020a170902684700b001e3d8a70780sm130351pln.171.2024.04.10.17.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 17:08:11 -0700 (PDT)
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
	Alexey Makhalov <alexey.amakhalov@broadcom.com>,
	Atish Patra <atishp@atishpatra.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
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
Subject: [PATCH v6 02/24] RISC-V: Add FIRMWARE_READ_HI definition
Date: Wed, 10 Apr 2024 17:07:30 -0700
Message-Id: <20240411000752.955910-3-atishp@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240411000752.955910-1-atishp@rivosinc.com>
References: <20240411000752.955910-1-atishp@rivosinc.com>
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

