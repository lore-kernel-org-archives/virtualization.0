Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534E4381BA
	for <virtualization@lists.linux.dev>; Tue,  9 Jan 2024 08:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Whvuzriw"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-28c2b8d6f2aso1674459a91.2
        for <virtualization@lists.linux.dev>; Tue, 09 Jan 2024 00:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1704789676; x=1705394476; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X8/C+cZAZlDGQnbyhqyYcqig/5vzt/WyH0xZX56gmkE=;
        b=WhvuzriwxUp6hXi0anGuuzjGkS9wqpy7mKn4acp5ELjZVWJxi2xgwFzwCrZP95PSSs
         mOG0RYzORL2ZtfaeWMm7a1b0KNudmUUg0aKthXH6KteNAZCVCIrITmRwA2sjuwEWQ6Ae
         nMoTpddFJGWnaQ596uthwp3sYeBtD8d60Nh5M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704789676; x=1705394476;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X8/C+cZAZlDGQnbyhqyYcqig/5vzt/WyH0xZX56gmkE=;
        b=SOcDQGI3C/WIQLtzgKKCehjTrvegF1i3qnUtTf4gXBK/+NDTTZXBNA7kNASTWPQg+F
         PN2QZh3SI4Eo1tmbdD32j4/fOwU60EccbVJ5QLuanj1bOpWc9vjii0DoE+HZPe19iWkL
         rP398uogXL4XPmNR5pPZCEYDJt4gZGW732Bl9nLqiqRZsab+oaJW9gx1T0e6JMnxZP6i
         Fv+X6t/k5RDW/FXER99/qBb3M/mS5TevAF4XHTdQfXinpZHFyyBEUO9UTSrI38PAuxMs
         V9adccpL4TAbaaxVhKsu61VAzkEAi0nbPSir+MHrBzMRwmlX2YJw7anIjsEMutUZuQ0y
         TKtQ==
X-Gm-Message-State: AOJu0YwFN0uV/rooDB/e3x2r4t5+r6EyMVNCI97/f09y3+EFAsPyXM81
	kqCM+XN8vMmiISH6lfIhFnhF9t9ECKRU
X-Google-Smtp-Source: AGHT+IEKSJPQQ5kZXHfegHUZEeEfLJv3dBHvaNcjAImiJtqEMm+GIdULd8bk6lMU/uJqJHQXXQBX1A==
X-Received: by 2002:a17:90a:d50d:b0:28d:1e1b:d73b with SMTP id t13-20020a17090ad50d00b0028d1e1bd73bmr1951835pju.19.1704789675730;
        Tue, 09 Jan 2024 00:41:15 -0800 (PST)
Received: from amakhalov-build-vm.eng.vmware.com ([128.177.82.146])
        by smtp.gmail.com with ESMTPSA id sf15-20020a17090b51cf00b0028d435cc2cbsm4772293pjb.15.2024.01.09.00.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 00:41:15 -0800 (PST)
From: Alexey Makhalov <alexey.makhalov@broadcom.com>
X-Google-Original-From: Alexey Makhalov <amakhalov@vmware.com>
To: linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev,
	bp@alien8.de,
	hpa@zytor.com,
	dave.hansen@linux.intel.com,
	mingo@redhat.com,
	tglx@linutronix.de
Cc: x86@kernel.org,
	netdev@vger.kernel.org,
	richardcochran@gmail.com,
	linux-input@vger.kernel.org,
	dmitry.torokhov@gmail.com,
	zackr@vmware.com,
	linux-graphics-maintainer@vmware.com,
	pv-drivers@vmware.com,
	namit@vmware.com,
	timothym@vmware.com,
	akaher@vmware.com,
	jsipek@vmware.com,
	dri-devel@lists.freedesktop.org,
	daniel@ffwll.ch,
	airlied@gmail.com,
	tzimmermann@suse.de,
	mripard@kernel.org,
	maarten.lankhorst@linux.intel.com,
	horms@kernel.org,
	kirill.shutemov@linux.intel.com
Subject: [PATCH v6 6/7] x86/vmware: Undefine VMWARE_HYPERCALL
Date: Tue,  9 Jan 2024 00:40:51 -0800
Message-Id: <20240109084052.58661-7-amakhalov@vmware.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20240109084052.58661-1-amakhalov@vmware.com>
References: <20240109084052.58661-1-amakhalov@vmware.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No more direct use of VMWARE_HYPERCALL macro should be allowed.

Signed-off-by: Alexey Makhalov <amakhalov@vmware.com>
---
 arch/x86/include/asm/vmware.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/vmware.h b/arch/x86/include/asm/vmware.h
index 2ac87068184a..84a31f579a30 100644
--- a/arch/x86/include/asm/vmware.h
+++ b/arch/x86/include/asm/vmware.h
@@ -273,5 +273,6 @@ unsigned long vmware_hypercall_hb_in(unsigned long cmd, unsigned long in2,
 }
 #undef VMW_BP_REG
 #undef VMW_BP_CONSTRAINT
+#undef VMWARE_HYPERCALL
 
 #endif
-- 
2.39.0

