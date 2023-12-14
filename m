Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E503A3B789
	for <virtualization@lists.linux-foundation.org>; Thu, 14 Dec 2023 10:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="L+iAPvXc"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7012240997
	for <virtualization@lists.linux-foundation.org>; Thu, 14 Dec 2023 10:15:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7012240997
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.a=rsa-sha256 header.s=google header.b=L+iAPvXc
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MF0OMf_NE5w4
	for <virtualization@lists.linux-foundation.org>;
	Thu, 14 Dec 2023 10:15:58 +0000 (UTC)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8AB6840995
	for <virtualization@lists.linux-foundation.org>; Thu, 14 Dec 2023 10:15:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8AB6840995
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-3363eba94ebso1166232f8f.3
        for <virtualization@lists.linux-foundation.org>; Thu, 14 Dec 2023 02:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1702548956; x=1703153756; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Woc15oz+CoXPrVL5FpAnQJp0K5JKZ0y7fyyofa5MJ/g=;
        b=L+iAPvXcaiuoQ1urjPJxdRw2Z86HjGNeG4oGrp68+d61MDDSSLcZMA/A6IXfsdJl30
         YM1gMCj0EersHfJGntlwgS2kjen0FpFJPke0iZm8ui+LWxs3o5W54NrG5+rvroITG6Te
         +9HZSR+MWM2nD7nT6od09Ta1tPeJWX6bZDr7D24caiXFzC7woWBnp07f2tFSTBfbDmQv
         xCJloQ4PZJUV1UXA4564YxheKVnkE0IQPHTDeHKfRfF238sRoL8KQZ2+G079gW/HfcYt
         15+Fiu7V1dCdciFnK3J+qH9tUnbD8Wmydlbtdp2UmE+t7oksh5tkHR1S+UVvG8GK5Kxs
         OIRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702548956; x=1703153756;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Woc15oz+CoXPrVL5FpAnQJp0K5JKZ0y7fyyofa5MJ/g=;
        b=FEzwCwTm47HdLJyH4MpHCxzmYMgRVINTVx9iKrtWVrA347/P/1b4PL0T1YmgKe0StB
         dIWB+1sH8rwuKn5v2rcuDZI5uyuVpVZqDUsAvuZ288nRykeVRaxmQVudanLVCkT3ito6
         RqwNrbTYt1AUdEukNbFdSNQg/O4RKk/nTTiYRYXwp0+rfE+rcWqu7qMQ3HT7htQ6yiAM
         2vfvp6lsFCZJB4NBqMrpcUY7r4HTYLF6NGTsvAcBa9MnHKpOsU/+v2dkcK5IvmRDB4aa
         cZAAwuSrFfRTSfOXUpALvDc33Me3/88+ANNKoRR/ssaIZyuRSln3HaqFfjeurnai/chC
         KqUQ==
X-Gm-Message-State: AOJu0Yz8S6+i4LzYqV1DMJdAIMA2XkyLSHEA2T20ooCRFCZHeG/KwDC9
	CXaO+0li2IYmacWVwl1c/cnhVQ==
X-Google-Smtp-Source: AGHT+IFfvKGJdC1xVt4K4bKm5d7cOnRv8TQYL5otvs9mb8+kEgJtDUDvnFCXQvhqDlCC//Y1eELkkQ==
X-Received: by 2002:a05:600c:4591:b0:40c:25f7:8da5 with SMTP id r17-20020a05600c459100b0040c25f78da5mr2433308wmo.264.1702548956738;
        Thu, 14 Dec 2023 02:15:56 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id m14-20020a05600c4f4e00b0040b30be6244sm24077359wmq.24.2023.12.14.02.15.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 02:15:56 -0800 (PST)
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
	conor.dooley@microchip.com
Subject: [PATCH v2 02/13] RISC-V: Add SBI STA extension definitions
Date: Thu, 14 Dec 2023 11:15:54 +0100
Message-ID: <20231214101552.100721-17-ajones@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231214101552.100721-15-ajones@ventanamicro.com>
References: <20231214101552.100721-15-ajones@ventanamicro.com>
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

Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
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

