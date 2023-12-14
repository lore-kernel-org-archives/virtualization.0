Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155CB3C46A
	for <virtualization@lists.linux-foundation.org>; Thu, 14 Dec 2023 10:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="NIbgHpLS"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 836B841E87
	for <virtualization@lists.linux-foundation.org>; Thu, 14 Dec 2023 10:16:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 836B841E87
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.a=rsa-sha256 header.s=google header.b=NIbgHpLS
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.092
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wdOrjiKgKMi9
	for <virtualization@lists.linux-foundation.org>;
	Thu, 14 Dec 2023 10:16:14 +0000 (UTC)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 51B4841E72
	for <virtualization@lists.linux-foundation.org>; Thu, 14 Dec 2023 10:16:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 51B4841E72
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-336447f240cso604108f8f.3
        for <virtualization@lists.linux-foundation.org>; Thu, 14 Dec 2023 02:16:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1702548972; x=1703153772; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5sLAOsgZcpQSTBwUzgMdLDrxCilAijeI38aq9HKFasU=;
        b=NIbgHpLSGdCgBBb2Z5J3f0V79NHjroKFXoRHd0KHpjyyC8SypxAfohSmTOrcLBVZuY
         Ef/b09G52DQaNM9IFzaylvaW0GS4g6AU6us1c+gaCYr/hV8+fvA4tH0UxQ4GP63zhMIW
         v4r5B/wl3zysIXvWmmlYehlA+A0UIZM7zM14QLbomMrEgsdUSLAu+42fM0mrScALJhNd
         D1c62T7daJ0cMPr5ukg2lAAAVc4lFt8Kcm8Jhl3Nj6tTiKGXJjyhlYDzsX4D0wMrZi0r
         sUSWgAYA185EHl1JG9deg8joQDwqPOLu8zEjOLP6Haycrlesvp6VvJ2L+W43IpQkzzBu
         qWZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702548972; x=1703153772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5sLAOsgZcpQSTBwUzgMdLDrxCilAijeI38aq9HKFasU=;
        b=OlJ6eUGJVAX7+XelJm5SsK9npc/YF9oUk+Vrrmh3vtUSwf+S3e70CLNomvCcOuZySG
         aCqP88OD3R5+dMPMvv83xrEVTRnUn8cxWSmXaF4vv7MdqzUy/HljTwF4yhL3cBqHQP7k
         l3st7LPkPPxeV1ydF5WhYJamgB27txtg8S+LDpN3C7+2GDpQn/ESdbOyn3NaV1LyUw6A
         LzQoMpFcY7ICXpeNPBJuYOOPYOOrDNh++XH4WoG2dlSJOBeKetkg7YOB3KCipOfM+jAd
         DxkvppdHYkH8ylTA3Qn2G7txa2tUD85oQvnUmVG9CReW02eRAlqu+R8UkIoLPJcs5JQG
         a+og==
X-Gm-Message-State: AOJu0YzqEK2+iR1GbVC3IK4mdebArpcERqQQGaIjQlEbaoVO/fnixtMt
	Uc8SAsmX1weCl/2jHnCvxyTbEUWQEFb8ihvjn1c=
X-Google-Smtp-Source: AGHT+IFhmTfylzqxQ7QtmIDq35GQY0mfi2q4zqVqrYz2qB19Hm9VLve5wK0FwX7YnFMDWHqCP9lDbA==
X-Received: by 2002:a05:600c:1913:b0:40c:a12:d626 with SMTP id j19-20020a05600c191300b0040c0a12d626mr5001525wmq.103.1702548972544;
        Thu, 14 Dec 2023 02:16:12 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id d12-20020a05600c3acc00b0040836519dd9sm23896227wms.25.2023.12.14.02.16.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 02:16:12 -0800 (PST)
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
Subject: [PATCH v2 13/13] RISC-V: KVM: selftests: Add get-reg-list test for STA registers
Date: Thu, 14 Dec 2023 11:16:05 +0100
Message-ID: <20231214101552.100721-28-ajones@ventanamicro.com>
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

Add SBI STA and its two registers to the get-reg-list test.

Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
---
 .../selftests/kvm/riscv/get-reg-list.c        | 43 +++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/tools/testing/selftests/kvm/riscv/get-reg-list.c b/tools/testing/selftests/kvm/riscv/get-reg-list.c
index b8da2e86bf9c..55dd1fc3c536 100644
--- a/tools/testing/selftests/kvm/riscv/get-reg-list.c
+++ b/tools/testing/selftests/kvm/riscv/get-reg-list.c
@@ -71,6 +71,7 @@ bool filter_reg(__u64 reg)
 	case KVM_REG_RISCV_SBI_EXT | KVM_REG_RISCV_SBI_SINGLE | KVM_RISCV_SBI_EXT_HSM:
 	case KVM_REG_RISCV_SBI_EXT | KVM_REG_RISCV_SBI_SINGLE | KVM_RISCV_SBI_EXT_PMU:
 	case KVM_REG_RISCV_SBI_EXT | KVM_REG_RISCV_SBI_SINGLE | KVM_RISCV_SBI_EXT_DBCN:
+	case KVM_REG_RISCV_SBI_EXT | KVM_REG_RISCV_SBI_SINGLE | KVM_RISCV_SBI_EXT_STA:
 	case KVM_REG_RISCV_SBI_EXT | KVM_REG_RISCV_SBI_SINGLE | KVM_RISCV_SBI_EXT_EXPERIMENTAL:
 	case KVM_REG_RISCV_SBI_EXT | KVM_REG_RISCV_SBI_SINGLE | KVM_RISCV_SBI_EXT_VENDOR:
 		return true;
@@ -461,6 +462,7 @@ static const char *sbi_ext_single_id_to_str(__u64 reg_off)
 		KVM_SBI_EXT_ARR(KVM_RISCV_SBI_EXT_SRST),
 		KVM_SBI_EXT_ARR(KVM_RISCV_SBI_EXT_HSM),
 		KVM_SBI_EXT_ARR(KVM_RISCV_SBI_EXT_PMU),
+		KVM_SBI_EXT_ARR(KVM_RISCV_SBI_EXT_STA),
 		KVM_SBI_EXT_ARR(KVM_RISCV_SBI_EXT_EXPERIMENTAL),
 		KVM_SBI_EXT_ARR(KVM_RISCV_SBI_EXT_VENDOR),
 		KVM_SBI_EXT_ARR(KVM_RISCV_SBI_EXT_DBCN),
@@ -509,6 +511,32 @@ static const char *sbi_ext_id_to_str(const char *prefix, __u64 id)
 	return strdup_printf("%lld | %lld /* UNKNOWN */", reg_subtype, reg_off);
 }
 
+static const char *sbi_sta_id_to_str(__u64 reg_off)
+{
+	switch (reg_off) {
+	case 0: return "KVM_REG_RISCV_SBI_STA | KVM_REG_RISCV_SBI_STA_REG(shmem_lo)";
+	case 1: return "KVM_REG_RISCV_SBI_STA | KVM_REG_RISCV_SBI_STA_REG(shmem_hi)";
+	}
+	return strdup_printf("KVM_REG_RISCV_SBI_STA | %lld /* UNKNOWN */", reg_off);
+}
+
+static const char *sbi_id_to_str(const char *prefix, __u64 id)
+{
+	__u64 reg_off = id & ~(REG_MASK | KVM_REG_RISCV_SBI);
+	__u64 reg_subtype = reg_off & KVM_REG_RISCV_SUBTYPE_MASK;
+
+	assert((id & KVM_REG_RISCV_TYPE_MASK) == KVM_REG_RISCV_SBI);
+
+	reg_off &= ~KVM_REG_RISCV_SUBTYPE_MASK;
+
+	switch (reg_subtype) {
+	case KVM_REG_RISCV_SBI_STA:
+		return sbi_sta_id_to_str(reg_off);
+	}
+
+	return strdup_printf("%lld | %lld /* UNKNOWN */", reg_subtype, reg_off);
+}
+
 void print_reg(const char *prefix, __u64 id)
 {
 	const char *reg_size = NULL;
@@ -565,6 +593,10 @@ void print_reg(const char *prefix, __u64 id)
 		printf("\tKVM_REG_RISCV | %s | KVM_REG_RISCV_SBI_EXT | %s,\n",
 				reg_size, sbi_ext_id_to_str(prefix, id));
 		break;
+	case KVM_REG_RISCV_SBI:
+		printf("\tKVM_REG_RISCV | %s | KVM_REG_RISCV_SBI | %s,\n",
+				reg_size, sbi_id_to_str(prefix, id));
+		break;
 	default:
 		printf("\tKVM_REG_RISCV | %s | 0x%llx /* UNKNOWN */,\n",
 				reg_size, id & ~REG_MASK);
@@ -651,6 +683,12 @@ static __u64 sbi_base_regs[] = {
 	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_EXT | KVM_REG_RISCV_SBI_SINGLE | KVM_RISCV_SBI_EXT_VENDOR,
 };
 
+static __u64 sbi_sta_regs[] = {
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_EXT | KVM_REG_RISCV_SBI_SINGLE | KVM_RISCV_SBI_EXT_STA,
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI | KVM_REG_RISCV_SBI_STA | KVM_REG_RISCV_SBI_STA_REG(shmem_lo),
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI | KVM_REG_RISCV_SBI_STA | KVM_REG_RISCV_SBI_STA_REG(shmem_hi),
+};
+
 static __u64 zicbom_regs[] = {
 	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CONFIG | KVM_REG_RISCV_CONFIG_REG(zicbom_block_size),
 	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZICBOM,
@@ -757,6 +795,9 @@ static __u64 fp_d_regs[] = {
 #define SUBLIST_SBI_BASE \
 	{"sbi-base", .feature_type = VCPU_FEATURE_SBI_EXT, .feature = KVM_RISCV_SBI_EXT_V01, \
 	 .regs = sbi_base_regs, .regs_n = ARRAY_SIZE(sbi_base_regs),}
+#define SUBLIST_SBI_STA \
+	{"sbi-sta", .feature_type = VCPU_FEATURE_SBI_EXT, .feature = KVM_RISCV_SBI_EXT_STA, \
+	 .regs = sbi_sta_regs, .regs_n = ARRAY_SIZE(sbi_sta_regs),}
 #define SUBLIST_ZICBOM \
 	{"zicbom", .feature = KVM_RISCV_ISA_EXT_ZICBOM, .regs = zicbom_regs, .regs_n = ARRAY_SIZE(zicbom_regs),}
 #define SUBLIST_ZICBOZ \
@@ -832,6 +873,7 @@ static struct vcpu_reg_list config_sbi_##ext = {		\
 /* Note: The below list is alphabetically sorted. */
 
 KVM_SBI_EXT_SUBLIST_CONFIG(base, BASE);
+KVM_SBI_EXT_SUBLIST_CONFIG(sta, STA);
 KVM_SBI_EXT_SIMPLE_CONFIG(pmu, PMU);
 KVM_SBI_EXT_SIMPLE_CONFIG(dbcn, DBCN);
 
@@ -858,6 +900,7 @@ KVM_ISA_EXT_SIMPLE_CONFIG(zihpm, ZIHPM);
 
 struct vcpu_reg_list *vcpu_configs[] = {
 	&config_sbi_base,
+	&config_sbi_sta,
 	&config_sbi_pmu,
 	&config_sbi_dbcn,
 	&config_aia,
-- 
2.43.0

