Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E848F13DDC0
	for <virtualization@lists.linux.dev>; Fri, 19 Apr 2024 23:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713570470; cv=none; b=ifuseDSEdgKQ/SI6DgMNMZVTskMnAmW7MWsog0nuJ2MKMOCjdlK1rys6D/gl5et/L5MJwo4fsty0tXxIY8s1G5I6NAyfzg6F5AuO72RE2Afoo69WIFvdMD4/MhFa+ZbDe05Cve685bAzMBTgNoNXqX+i4PHLgqr5fj4/9NX1N3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713570470; c=relaxed/simple;
	bh=tjU5YEqQieqMxVoH/UAjG6llZvkwIlIrjBWxORyGdm4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=isK/ZaiepE2Cw+lAvtJ8z2jR6USzqjHDGYYA9MjGSxy63L0DvxCShrBaaZYKQhT9K0HtCezBpZ1u3aRL7jbN5DBpZAU6hL+0g2ASCmRB0qkktpKRd2mPwZ7e/l5XVQ0Xnz2jIZeuLLvMfIlCLzQGDYuiPcH98Djo1z8BYgJMaNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=a4mcGlIG; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="a4mcGlIG"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1e65b29f703so21697015ad.3
        for <virtualization@lists.linux.dev>; Fri, 19 Apr 2024 16:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1713570468; x=1714175268; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2nwzSC0mjOXawHhzlfTnID2LKW7HdSbdpZLlPlBet3o=;
        b=a4mcGlIGJCy0+gWR4bkI2Wt1y4pqdD3zyNHgp32CtUT91QaEjCwtyWLm7R0haqf/pM
         gmU2H+jEQlLkfNPU2Pu8Niuhb64apSeNKqHJIAd1JlrDO0VaQfjYch0z4PObqvV/i5KZ
         aiGIfi9zu223GUKVPtOMe9s8PNNwd1djdo3xx4B3w8Ci5ODvSnZadjkTX6Ez/lu6AYjb
         AKEN7OaovKjnZqvByogNUAkCFLzaxGSEPd9Q44oK53M7qTPl91DLxDc/8zlOSIIzwa+f
         R53gwmOJmqKZutr6vBMN1E7TURMO/k4kzC/6ETQZR8H9H1ae8t62EGC1OgFhXwy+UW6h
         aGdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713570468; x=1714175268;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2nwzSC0mjOXawHhzlfTnID2LKW7HdSbdpZLlPlBet3o=;
        b=FJ6XYflvSr6TbznNhge8Tjq1Oeniu05eDAL9ieG7liS7ljddaZHCX79DUs+qZexE3J
         y1DIoXMCv2OhMhUS1JHXBFIdrLlDeW2T/fqUy7OwtvvO+3ZaGW5Vb6PD8wnO6CEf/fnL
         w/iVzjt7ZBW4Kb+IKPmNYY+quYdd2ESdvKxZwfXUnXIMgnQTTLa9tmCI4iW/WI6VCoWp
         hQw3inqGICCBBObMP3EUVzJbbPs8h8uU7kOQzdFDq28QacsgwwPpbEib/TThMXwMf0/N
         91xcULKf+GDf5aDXt8VG+IAoaXfdc5vwEcEBF9rhN9Lz7tLGrNIdju1um9R/SzgX1JeE
         smCg==
X-Forwarded-Encrypted: i=1; AJvYcCUs59EFQhBZfhEjnhA5qnuy2iXxkObR+bxY8BYDIPPqu8IgciQd/FPnAXAPylz/3RxeAu67xMHq8tHsj+w9SDNSoJ3aCvAuRlBRHgi+0bA=
X-Gm-Message-State: AOJu0YzQim4at4e4PtKi+s5hGVaCoHv4g+ERXP2wJZFrfGD/Rm/Z2u2t
	CvGHIYHsfePtZ1ulrixIrAxuXfdweC+44phmEXqp3db07a/zpHh85aS+Iz6Enes=
X-Google-Smtp-Source: AGHT+IFwhdbfgPKxR3sTRhCsXv+l7GhC3Zl7nIRj/PlojSe97ane9b3f42xNp6we4mG5zu9et1mKlg==
X-Received: by 2002:a17:903:120f:b0:1e4:200e:9c2b with SMTP id l15-20020a170903120f00b001e4200e9c2bmr4072621plh.21.1713570468267;
        Fri, 19 Apr 2024 16:47:48 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id w17-20020a170902d11100b001e42f215f33sm3924017plw.85.2024.04.19.16.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 16:47:47 -0700 (PDT)
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
	samuel.holland@sifive.com,
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
Subject: [PATCH v8 02/24] RISC-V: Add FIRMWARE_READ_HI definition
Date: Sat, 20 Apr 2024 08:17:18 -0700
Message-Id: <20240420151741.962500-3-atishp@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240420151741.962500-1-atishp@rivosinc.com>
References: <20240420151741.962500-1-atishp@rivosinc.com>
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

