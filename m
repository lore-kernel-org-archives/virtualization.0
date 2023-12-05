Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3939568B62
	for <virtualization@lists.linux-foundation.org>; Tue,  5 Dec 2023 18:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="cfjLSy6I"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5CEBF8148B
	for <virtualization@lists.linux-foundation.org>; Tue,  5 Dec 2023 18:11:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5CEBF8148B
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.a=rsa-sha256 header.s=google header.b=cfjLSy6I
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0aNSELHAOvWu
	for <virtualization@lists.linux-foundation.org>;
	Tue,  5 Dec 2023 18:11:28 +0000 (UTC)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 860F58144C
	for <virtualization@lists.linux-foundation.org>; Tue,  5 Dec 2023 18:11:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 860F58144C
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-54d0ae6cf20so1600165a12.0
        for <virtualization@lists.linux-foundation.org>; Tue, 05 Dec 2023 10:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1701799886; x=1702404686; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H0OmI3qPlz0+qT63geWVDLkAyW7X1IhJLuWTK1eJmuY=;
        b=cfjLSy6ICy9QiG0cEH/M9/mA20xUl1zUlLBkhv61oTFzwW1Nnoyuh5mRix0Yy/0Kdm
         oUSaoEZ3u6CL985D3sBYKrungydf4hYWDRwUCtVyQ0OkBm4F6q76/ZDByENRjv8DaM8A
         LWflyuUc+Rr58jCzHYa6faORIPXKINESfxGH4HZvCG1aOYf9r8P7xV8HAdlm73iCdPyo
         hhLcm5BHiUO+nqX406dwrlMvEXuiaHaj/anqrS4AxmfNoCoAc5YTnXvEHukMU/LD58nC
         9NW7BcqwolHVP07uYfpYSwk2NrORlZJ67kJNqXPW+DN05fCFZC73pQcYKvoOi+iO6Fpg
         CIFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701799886; x=1702404686;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H0OmI3qPlz0+qT63geWVDLkAyW7X1IhJLuWTK1eJmuY=;
        b=bSZf+mImuudrKHcRLAI8GSwbNArpYcNonvTMIdknXZh8u+vFvhW0fkuZRpocYnfrSK
         wHeq607qMnaJhKM4d3ZL2A1bdKOgXLbfHvJDs1g497g9OMG4bvL7/LHhJ+xV5z7etBtt
         2k5qZ/hlfarwteCCFws1lYiIH/HBkQqUHux2RvDhHze20VCAXf3MJ/2BVYz5HsNdSUWx
         sqMgQGQW4UJtPfspjU5bkplTKYNWayjOJfm1EHIf5u6pKD4d3xWwmGbiRqLhiG5gvQ7y
         mwsfbBwmOqlpgGODDm753yxpEIWKBtY9Mj7S2o7SVR8vS+04bxX4XgBuPkFsjkV8RhfV
         u00Q==
X-Gm-Message-State: AOJu0Yw78c2HKswCFgYmTLMOIdKAe0de6xtdt/350lNFFbTQG+FYoaho
	QtPMtPtrI6Vutio2BzQDxyRKiw==
X-Google-Smtp-Source: AGHT+IE/yuKOo9WSdx/SzvpE3H4wlV+8/v1fI1MTPtBMgFwY2hcTrHqFjyG/lMGWAoD3qGeq3g18HQ==
X-Received: by 2002:a50:c316:0:b0:54c:c6ce:ccbd with SMTP id a22-20020a50c316000000b0054cc6ceccbdmr2279355edb.65.1701799886465;
        Tue, 05 Dec 2023 10:11:26 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id s24-20020aa7d798000000b0054c9211021csm1391169edq.69.2023.12.05.10.11.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 10:11:26 -0800 (PST)
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
Subject: [PATCH v1 04/14] RISC-V: paravirt: Add kconfigs
Date: Tue,  5 Dec 2023 19:11:24 +0100
Message-ID: <20231205181119.207204-20-ajones@ventanamicro.com>
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

Now that we can support steal-time accounting, add the kconfig
knobs allowing it to be enabled.

Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/Kconfig | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 29f0f8fcb5c2..caf6f5ea578b 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -726,6 +726,25 @@ config COMPAT
 
 	  If you want to execute 32-bit userspace applications, say Y.
 
+config PARAVIRT
+	bool "Enable paravirtualization code"
+	depends on RISCV_SBI
+	help
+	  This changes the kernel so it can modify itself when it is run
+	  under a hypervisor, potentially improving performance significantly
+	  over full virtualization.
+
+config PARAVIRT_TIME_ACCOUNTING
+	bool "Paravirtual steal time accounting"
+	depends on PARAVIRT
+	help
+	  Select this option to enable fine granularity task steal time
+	  accounting. Time spent executing other tasks in parallel with
+	  the current vCPU is discounted from the vCPU power. To account for
+	  that, there can be a small performance impact.
+
+	  If in doubt, say N here.
+
 config RELOCATABLE
 	bool "Build a relocatable kernel"
 	depends on MMU && 64BIT && !XIP_KERNEL
-- 
2.43.0

