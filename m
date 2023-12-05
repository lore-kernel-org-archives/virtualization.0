Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364ED60BB6
	for <virtualization@lists.linux-foundation.org>; Tue,  5 Dec 2023 18:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="IHFnlUPm"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B328643591
	for <virtualization@lists.linux-foundation.org>; Tue,  5 Dec 2023 18:11:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B328643591
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.a=rsa-sha256 header.s=google header.b=IHFnlUPm
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DLJh4dXPYIMv
	for <virtualization@lists.linux-foundation.org>;
	Tue,  5 Dec 2023 18:11:25 +0000 (UTC)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A11F6400D0
	for <virtualization@lists.linux-foundation.org>; Tue,  5 Dec 2023 18:11:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A11F6400D0
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-54cd8f5bb5cso2691186a12.1
        for <virtualization@lists.linux-foundation.org>; Tue, 05 Dec 2023 10:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1701799883; x=1702404683; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HRw0KXpWF3PD2YzUN9JvnW9Ep67nDr8wRq9WIR/MR38=;
        b=IHFnlUPmzq9TNbNvllY/YwPbS7n4peDQDT2q7LtMTnBdQXjeeg5VXdNv3pCTK+cJjq
         aeSPVq1fdzAYlmBVBviDaYK7bWBkp+WlMG0965+Xskt2VsoN55XR4e+ftWJPHXcIkw6o
         vRWpDWqFYXwTaROfUK7tnv1f5OTLfcXXc57nLZ5rcCQemZ/4eCeDotYaUNcmAhiWmtPn
         gdS/o5dorEx5nVEQ5wEC+2hx0SjfSNVDxpp4GcsNhJRw3cPQg8TpZb+G2CmYNZkA6Eft
         xhGFX71/1JX2Eh8+3zGY2ZzibLiyP+nLKYNB+O2xZy7ZS2vf42iD+pCm8ubxyeh/Zfz7
         oRmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701799883; x=1702404683;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HRw0KXpWF3PD2YzUN9JvnW9Ep67nDr8wRq9WIR/MR38=;
        b=hTiKyCX6dbdTIkKyjcw4O3176r92p9Qv8CgiVkBxd0KhR9sLlqdYRoJuqZ+YFhDvFN
         VFXNYmUSj4415XDxoZij5q4bLGqyDL6QBBl0bbSpLFoQdrAXiUfOVJFzUrkymwRmm/R5
         Sqp+SPSpc6wQlOkQ1EkTBqIfSPrLykf4swYro+v954o2x0DhXmYbS1kxk7MBtdTmGt+5
         1HBhmYgG0DjTudHHMrCSuVAcvHw7IKCQPOceTP0O9Td1GqlKcKw/0/oINaBXnhL4oAnA
         hUkZpFXrFFFxAAkH1xpw22/q5YRkTVhV7UgxexwXr6WT3uYeJlNtAJzHYWa2/twpciRJ
         B/8w==
X-Gm-Message-State: AOJu0Yz9q1oEwb4GAdqq+mqhhJdwraPsKPTp3MHSm2LKxLTLos48qi5E
	nDGvX2jCxGNGehSkcrfQsY50uw==
X-Google-Smtp-Source: AGHT+IHdRdiNB1/9lM/3ljpOvu3WCzaBOIiET8u87nHacNp7Cvi++zT4Z0+YHsCVKgXDNtECj1I7hg==
X-Received: by 2002:a50:9b0c:0:b0:54b:24d6:de03 with SMTP id o12-20020a509b0c000000b0054b24d6de03mr4556108edi.6.1701799883799;
        Tue, 05 Dec 2023 10:11:23 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id n26-20020aa7c79a000000b0054cea9f91e9sm1386978eds.20.2023.12.05.10.11.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 10:11:23 -0800 (PST)
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
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v1 02/14] RISC-V: Add SBI STA extension definitions
Date: Tue,  5 Dec 2023 19:11:22 +0100
Message-ID: <20231205181119.207204-18-ajones@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231205181119.207204-16-ajones@ventanamicro.com>
References: <20231205181119.207204-16-ajones@ventanamicro.com>
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
index 9eef25308d53..d88d4e8f517e 100644
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

