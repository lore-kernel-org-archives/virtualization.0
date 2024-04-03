Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41410745C4
	for <virtualization@lists.linux.dev>; Wed,  3 Apr 2024 08:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712131531; cv=none; b=sk0/EOXDokaJ8M57jGv+7/GUmZaf2LTVVmcqXLgRODQumTOAn5yRlW5d1/981j2E9ohtznf2Yngxx2gtpzlbl1VLCZsAz6J0F+BzpIjv9D75PYInq7wgAt6HFbSfHMyp0LubesLnOeCcHCNjHXYH39x5pzCdMYdp7GZaf+h4U4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712131531; c=relaxed/simple;
	bh=qmTer1L5IWEJQe0rkUy5cvb4CMl5u/8y+hPoEZoMutA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R5ARgN4+DYOa1+ItuwejkTMJWKT+0B1gYSle0f/rtqg9x9VTI29KnmGw9D5z89hQMe/ybuWdlTfpG/wileiCgOXlJ/ZZ7z3nMHpqsmVqZBX15Az69l0Vc+RB/Jygg+/RXak1JJmpwy6r+oKXbn6tfG2ZLGMKt7U3w+Flh4yXwo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=XUmHNg/E; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="XUmHNg/E"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1e2232e30f4so46283715ad.2
        for <virtualization@lists.linux.dev>; Wed, 03 Apr 2024 01:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712131529; x=1712736329; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2HMUEh/ouJpwrjadx4E8ELJ1oGZIEAqlVNHNOiveHPA=;
        b=XUmHNg/EYiMU8/WXh7zAN3pDlZnmQpd2Lkuv1jaZwNz7F9CzRGw+qXoHNGZPGWxCku
         ht/B15AOxn9e8iq6cn7Ut/gQFwPyuPmyG8P1pXVT/CpqPd/V+fd5VkA5cBKbYaswn9lL
         kZpRnoaFC1PEe8wPM/e8iWSza78nITOqBZTl79Ba3PjOZf3/GxxqDL+ZsTPcgC/wsnnw
         2exYpvpJo52aAkAU1sRFIW8HmXaBoWaxxjJvlErCAzy9it7NWxMeYRH+Bi2IQWn4Odyu
         r2dkCnASuBhgKULtI5WxxtgaAYAMu3rJ0UqobZFz+LecEBIZ2jDzymR3/YzNPetkH+8B
         y6OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712131529; x=1712736329;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2HMUEh/ouJpwrjadx4E8ELJ1oGZIEAqlVNHNOiveHPA=;
        b=ee0xY9COfOU++9zUolTHiFn5tLofZUZzcq3+2+AxDe3ujBRr8aHt3/zWlcABGhrgEW
         iEwDRZ3kdAsyiz8kpdBIbred6zbx6g7fkNjME7Y3OLWga1uQ1i+HDlOQuclxQjBIs69C
         2iZie//SiHxTvFyivTy1lXVgg6jy+3ikLL7ian218Zec7UAqjL5TVV2roTXfjXoZQ1Y4
         gnkC7jq/8LOCV7p46J0RlrhxIlPHASiw72cpYp+AHHM9VnxwKovuXAD30n9vEJlSSjm3
         bNJjNHrREVE/+4xdnPudphZsIIqO6SdwCxnEJuuqL5iSCDaTUeICzS35zcRUjHpr9/UH
         Anmw==
X-Forwarded-Encrypted: i=1; AJvYcCWu8MmHcrBoLSzKtC7/e7n4w/3hcDpNoGFqATAUGbMgoLyZzMwQVZ/gJO6MHZbeadXq3vAx0jR5HOOqQg2aJnlrskVRYcRUiNBcuBp6jI4=
X-Gm-Message-State: AOJu0YwyxuM5s+lzd1IvV0eDdhEIG151RFNEUIfZcOi7P7tbLqlSFi+G
	e/y/t+YOgT1KD0Cr3LPlF3YEcQ8YbUVxqiXqUm8TwaRw1e1YYIgalBTMwhtJ28I=
X-Google-Smtp-Source: AGHT+IF30gBaFjuZamH6gB+fLa8VQAOCDXL32p+FdETcNWyCBYGk0g9s0A7zOmyK2RvO8zqC4rEDCA==
X-Received: by 2002:a17:902:aa04:b0:1e2:23b8:98dd with SMTP id be4-20020a170902aa0400b001e223b898ddmr14090965plb.69.1712131529484;
        Wed, 03 Apr 2024 01:05:29 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id c12-20020a170902d48c00b001e0b5d49fc7sm12557229plg.161.2024.04.03.01.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 01:05:28 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
To: linux-kernel@vger.kernel.org
Cc: Atish Patra <atishp@rivosinc.com>,
	Ajay Kaher <akaher@vmware.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Alexey Makhalov <amakhalov@vmware.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Anup Patel <anup@brainfault.org>,
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
Subject: [PATCH v5 08/22] RISC-V: KVM: Fix the initial sample period value
Date: Wed,  3 Apr 2024 01:04:37 -0700
Message-Id: <20240403080452.1007601-9-atishp@rivosinc.com>
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

The initial sample period value when counter value is not assigned
should be set to maximum value supported by the counter width.
Otherwise, it may result in spurious interrupts.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/kvm/vcpu_pmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kvm/vcpu_pmu.c b/arch/riscv/kvm/vcpu_pmu.c
index 86391a5061dd..cee1b9ca4ec4 100644
--- a/arch/riscv/kvm/vcpu_pmu.c
+++ b/arch/riscv/kvm/vcpu_pmu.c
@@ -39,7 +39,7 @@ static u64 kvm_pmu_get_sample_period(struct kvm_pmc *pmc)
 	u64 sample_period;
 
 	if (!pmc->counter_val)
-		sample_period = counter_val_mask + 1;
+		sample_period = counter_val_mask;
 	else
 		sample_period = (-pmc->counter_val) & counter_val_mask;
 
-- 
2.34.1

