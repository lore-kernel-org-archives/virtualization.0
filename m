Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8754C3AD
	for <virtualization@lists.linux-foundation.org>; Wed, 20 Dec 2023 16:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="G/G2k5Uh"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3A1E04206B
	for <virtualization@lists.linux-foundation.org>; Wed, 20 Dec 2023 16:00:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3A1E04206B
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.a=rsa-sha256 header.s=google header.b=G/G2k5Uh
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lGX6BF4q9_w4
	for <virtualization@lists.linux-foundation.org>;
	Wed, 20 Dec 2023 16:00:22 +0000 (UTC)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 6F04B4206A
	for <virtualization@lists.linux-foundation.org>; Wed, 20 Dec 2023 16:00:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6F04B4206A
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-3367f050e04so463992f8f.3
        for <virtualization@lists.linux-foundation.org>; Wed, 20 Dec 2023 08:00:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1703088020; x=1703692820; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bsqMVAX9+HvHM4O5cP+0LJ3eZPLQeiGLpoG96t1YCys=;
        b=G/G2k5Uh4Qh5okZmOy4r7KSyOyUEHIgpUfaXxh9LrJxttGj/CDvlHj34YiTlC9V5dD
         kiF2Jjvb44rmrVL1urZX/ulwU5R9vKiiwnRSHwM1x7jYKY2ALT6kAv/urhfODr7uGnPB
         eRd/YwMoZU0/g/a2UR8kJIobrOX1dmsLXmvx+QtsxKL9k9gxvnNtvJlKPp5ZypEG3Hx3
         QqX294Kxh6MM9SRP4VybopHBCs1eG22Uc6ijm8iokncGlqHuQ/gDgzdYQB5JmszEObpM
         QbS0TXXI0zxrLcwuZjzj26o27cm1jC3rFS7+dgVOMe2L1Uu7H2P48P5afTi8O+k5D13e
         AVww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703088020; x=1703692820;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bsqMVAX9+HvHM4O5cP+0LJ3eZPLQeiGLpoG96t1YCys=;
        b=c8nJ7qw4NNuPuN03fNjg/B94p4QUulOJhxqXFCjYU7134XccRpYkhoO/hEu0V3T92Z
         b6M/olpZN5NzphaXcn+u1RrBZaQc5lAsmucWRpJoJc8gaxWy8IY845fwigcjErCL6vb/
         /6z6gSduqIaKqzb/oK6LC1kOxn5voWKUX0811EFdiNpyzXbAKscOhDMTipe35Ob09VN/
         boe1yLh2SFqLG5z9z2p6wGEHcGo7m6ZbBQuvpZblTCXRSvV74HFPLlfDpEFDrbufcN4z
         9DKtopHsvoK6BkeoNOaMygO7f42bIL3JILLd4ej1b8SaMSPMcKAbh24FdM0xXpdRbEWM
         wW8w==
X-Gm-Message-State: AOJu0YyeAlXSdgujnaZu3E0lmYD2LBU4lAVCi4LnNC0fcKT+BZ2dLpF1
	zI/WoIrEqdo3ZvfCHojDX0n+usmfrLSYKpGRkKQ=
X-Google-Smtp-Source: AGHT+IGvi//DvXAg1xDIrKAJaGuMCehkfokcMb0T9IgvWVneX0+gPJn+9LH1j0ttz6W8NArfksk+Iw==
X-Received: by 2002:adf:e412:0:b0:336:7a8d:bf6b with SMTP id g18-20020adfe412000000b003367a8dbf6bmr757905wrm.58.1703088020563;
        Wed, 20 Dec 2023 08:00:20 -0800 (PST)
Received: from localhost (cst-prg-16-115.cust.vodafone.cz. [46.135.16.115])
        by smtp.gmail.com with ESMTPSA id n9-20020a5d4009000000b0033677a4e0d6sm2893440wrp.13.2023.12.20.08.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 08:00:20 -0800 (PST)
From: Andrew Jones <ajones@ventanamicro.com>
To: kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	virtualization@lists.linux-foundation.org
Cc: anup@brainfault.org,
	atishp@atishpatra.org,
	pbonzini@redhat.com,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	jgross@suse.com,
	srivatsa@csail.mit.edu,
	guoren@kernel.org,
	conor.dooley@microchip.com,
	Atish Patra <atishp@rivosinc.com>
Subject: [PATCH v4 02/13] RISC-V: Add SBI STA extension definitions
Date: Wed, 20 Dec 2023 17:00:15 +0100
Message-ID: <20231220160012.40184-17-ajones@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231220160012.40184-15-ajones@ventanamicro.com>
References: <20231220160012.40184-15-ajones@ventanamicro.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit

The SBI STA extension enables steal-time accounting. Add the
definitions it specifies.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
Reviewed-by: Atish Patra <atishp@rivosinc.com>
Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
---
 arch/riscv/include/asm/sbi.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index 0892f4421bc4..b6f898c56940 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -31,6 +31,7 @@ enum sbi_ext_id {
 	SBI_EXT_SRST = 0x53525354,
 	SBI_EXT_PMU = 0x504D55,
 	SBI_EXT_DBCN = 0x4442434E,
+	SBI_EXT_STA = 0x535441,
 
 	/* Experimentals extensions must lie within this range */
 	SBI_EXT_EXPERIMENTAL_START = 0x08000000,
@@ -243,6 +244,22 @@ enum sbi_ext_dbcn_fid {
 	SBI_EXT_DBCN_CONSOLE_WRITE_BYTE = 2,
 };
 
+/* SBI STA (steal-time accounting) extension */
+enum sbi_ext_sta_fid {
+	SBI_EXT_STA_STEAL_TIME_SET_SHMEM = 0,
+};
+
+struct sbi_sta_struct {
+	__le32 sequence;
+	__le32 flags;
+	__le64 steal;
+	u8 preempted;
+	u8 pad[47];
+} __packed;
+
+#define SBI_STA_SHMEM_DISABLE		-1
+
+/* SBI spec version fields */
 #define SBI_SPEC_VERSION_DEFAULT	0x1
 #define SBI_SPEC_VERSION_MAJOR_SHIFT	24
 #define SBI_SPEC_VERSION_MAJOR_MASK	0x7f
-- 
2.43.0

