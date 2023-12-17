Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C0248CC0
	for <virtualization@lists.linux-foundation.org>; Sun, 17 Dec 2023 20:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="BMcJLG5R"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 285D560A77
	for <virtualization@lists.linux-foundation.org>; Sun, 17 Dec 2023 20:40:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 285D560A77
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.a=rsa-sha256 header.s=google header.b=BMcJLG5R
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5LAOAAlFAPMl
	for <virtualization@lists.linux-foundation.org>;
	Sun, 17 Dec 2023 20:40:31 +0000 (UTC)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5982160881
	for <virtualization@lists.linux-foundation.org>; Sun, 17 Dec 2023 20:40:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5982160881
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-a234205785dso77517466b.0
        for <virtualization@lists.linux-foundation.org>; Sun, 17 Dec 2023 12:40:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1702845629; x=1703450429; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gJEKgoCl75+B888vMMMdWTo7SEi5lRuwQ/RrT7Q47BA=;
        b=BMcJLG5RzEgVZInL1Tv5+vdSKd0fLmRzu5qdwYXDQMqj6PeUUW4VnX+psE27urCjmX
         eWFrwdkAVcF6SmEYNCfI6Sc1sDf8M1TIn0I8wuVu5rYZsxLtT3Oka1CnBYQWy91WEL4G
         GzldXWT/VVe2zYXfAKHy4536jiQ7ZgsrSfJJQqSyfAwyLMO8knvJmOKcJQ8BcSzKI0p7
         XSEvhUfrDhxAsrVi9Q51Y0/PQ+p3evD4S3wjiXLIqX7siJHhoKc4l3SYZaUKkPFrCSN0
         LTaXk2KfpW5yq+FjkeMlbiZ4o3xgRMPSTu52v8uwprUy07mJI2JM4j6X+sdaK+NBbq1t
         v5Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702845629; x=1703450429;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gJEKgoCl75+B888vMMMdWTo7SEi5lRuwQ/RrT7Q47BA=;
        b=G6uMVcLfUnCpItnoLc+vAA0Km4y8OrB7VfG7Hak8GXpRljvYFEn8JyQk3O9eXaroXa
         8+uzNcVeeWIu6fWlqoZpfw3H/MhZ68MIb8TjXHlFb7E3g3ll3Gxk4p/g/AnuQjUYU8+a
         DtmQ9O9zpK8C7qvTk7e/k60OoCXClg0kV1GqBFGGmHmODfDuCo5BZf1yUw9amIjRSSfO
         TtAKhoZPJWEJZgR5IOa5JxXxAIU5WOAXNmF5CHhFwZsg7L2tgIlI0PXC+CN5n1h+4IZg
         XRmvIR1TCfmv1wCPe6UNdnfeY4Q5LoCwBYdAn3jGkYdsFbiCJndj5SMDvCQdl04+fjNG
         Np7w==
X-Gm-Message-State: AOJu0YyN4seWFxvGgT5p2YRPOsddGEn7h+2+q8bO9V1EoHU0rFwvg0GC
	PcxP3zlGm7c4WckJU9TAH156bw==
X-Google-Smtp-Source: AGHT+IGmIBlpFS+9pHcXMz1NvZF5Zb3Lg/gBLV72EKrLPU5g9c/YVXCXhRKKEe6j3IvX7UWfl+4alw==
X-Received: by 2002:a17:906:4a5a:b0:a23:5332:d22b with SMTP id a26-20020a1709064a5a00b00a235332d22bmr185786ejv.244.1702845628675;
        Sun, 17 Dec 2023 12:40:28 -0800 (PST)
Received: from localhost (cst-prg-88-42.cust.vodafone.cz. [46.135.88.42])
        by smtp.gmail.com with ESMTPSA id fw10-20020a170906c94a00b00a2349073119sm1115090ejb.134.2023.12.17.12.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Dec 2023 12:40:28 -0800 (PST)
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
Subject: [PATCH v3 02/13] RISC-V: Add SBI STA extension definitions
Date: Sun, 17 Dec 2023 21:40:22 +0100
Message-ID: <20231217204019.36492-17-ajones@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231217204019.36492-15-ajones@ventanamicro.com>
References: <20231217204019.36492-15-ajones@ventanamicro.com>
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

