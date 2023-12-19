Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DEA3EA7D
	for <virtualization@lists.linux.dev>; Tue, 19 Dec 2023 21:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="EPbqBsGl"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d3c76ee799so17761525ad.3
        for <virtualization@lists.linux.dev>; Tue, 19 Dec 2023 13:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1703023090; x=1703627890; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bdRA67GFcUxloyx4tvXG24BR0us5wKd/dCuK68J3MHc=;
        b=EPbqBsGlFPLyKziZg5hVW3vIdGd0ryT5O2lg/u60SIQEHHAbtD6eFbSPnSlh4Xpz8E
         kELnpauMG24N2ZXFFqFwF3IBnkkqNb2RKSj0/auVmEMEzVXSixxfBIKenWv3tZqG+t3/
         5ZwcFW6CLteMpEVkfDiATse1BgAXMNO/tBDLM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703023090; x=1703627890;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bdRA67GFcUxloyx4tvXG24BR0us5wKd/dCuK68J3MHc=;
        b=XZjha7CrSGQfEPqn+RyVW5Mb82MNpLW7cKd+K+XGIx6yahYhYxn8+7Xo2A/yc2iIsH
         Fg9wDKLYP15Nla0Vi6nyzVWxaG8qhfEQFamxgxfuAJMhNlmuWDFZQ+NVotMwzHmQvqbn
         DYvS97hOnjvbzXQ300BfBr1dHNR3bxyV3Fm4ZHanF6ESO37Hn/XgGOf5W8n/0PQG1fnK
         cFHcYoj/bmL4/P1SR5RphpuVldnhO3QkLWLpX01DBDcJ7+/N0u7nAEsoAFv6OUolC7Xo
         AYbIxzMa3aKwLAFLmymdHhlLrz2zMG2D+HKWW/Zxhsq4JujilGBIA7X87A1xENhukTcv
         7gVg==
X-Gm-Message-State: AOJu0Yw4SX1epTu8IG96lBPvlIJfrITxxZLvJcmhFU30ydGkUlUg2xL4
	2W61EOLRFQyLzRMJ2s0K8oSd1Q==
X-Google-Smtp-Source: AGHT+IHGD0xZLG33r4K3W27zHJ54xxNx9BXxPN80CB3EUkCBFgov+arX/Surcqdx9o4S55QyyiUwAQ==
X-Received: by 2002:a17:902:7809:b0:1d3:e171:7d0c with SMTP id p9-20020a170902780900b001d3e1717d0cmr816076pll.83.1703023090468;
        Tue, 19 Dec 2023 13:58:10 -0800 (PST)
Received: from amakhalov-build-vm.eng.vmware.com ([128.177.82.146])
        by smtp.gmail.com with ESMTPSA id v1-20020a170902e8c100b001d3aa7604c5sm5356476plg.0.2023.12.19.13.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 13:58:10 -0800 (PST)
From: Alexey Makhalov <alexey.makhalov@broadcom.com>
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
Subject: [PATCH v3 3/6] ptp/vmware: Use vmware_hypercall API
Date: Tue, 19 Dec 2023 13:57:48 -0800
Message-Id: <20231219215751.9445-4-alexey.makhalov@broadcom.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20231219215751.9445-1-alexey.makhalov@broadcom.com>
References: <20231219215751.9445-1-alexey.makhalov@broadcom.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexey Makhalov <amakhalov@vmware.com>

Switch from VMWARE_HYPERCALL macro to vmware_hypercall API.
Eliminate arch specific code. No functional changes intended.

Signed-off-by: Alexey Makhalov <amakhalov@vmware.com>
Reviewed-by: Nadav Amit <namit@vmware.com>
Reviewed-by: Jeff Sipek <jsipek@vmware.com>
---
 drivers/ptp/ptp_vmw.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/ptp/ptp_vmw.c b/drivers/ptp/ptp_vmw.c
index 27c5547aa8a9..e5bb521b9b82 100644
--- a/drivers/ptp/ptp_vmw.c
+++ b/drivers/ptp/ptp_vmw.c
@@ -14,7 +14,6 @@
 #include <asm/hypervisor.h>
 #include <asm/vmware.h>
 
-#define VMWARE_MAGIC 0x564D5868
 #define VMWARE_CMD_PCLK(nr) ((nr << 16) | 97)
 #define VMWARE_CMD_PCLK_GETTIME VMWARE_CMD_PCLK(0)
 
@@ -24,15 +23,10 @@ static struct ptp_clock *ptp_vmw_clock;
 
 static int ptp_vmw_pclk_read(u64 *ns)
 {
-	u32 ret, nsec_hi, nsec_lo, unused1, unused2, unused3;
-
-	asm volatile (VMWARE_HYPERCALL :
-		"=a"(ret), "=b"(nsec_hi), "=c"(nsec_lo), "=d"(unused1),
-		"=S"(unused2), "=D"(unused3) :
-		"a"(VMWARE_MAGIC), "b"(0),
-		"c"(VMWARE_CMD_PCLK_GETTIME), "d"(0) :
-		"memory");
+	u32 ret, nsec_hi, nsec_lo;
 
+	ret = vmware_hypercall3(VMWARE_CMD_PCLK_GETTIME, 0,
+				&nsec_hi, &nsec_lo);
 	if (ret == 0)
 		*ns = ((u64)nsec_hi << 32) | nsec_lo;
 	return ret;
-- 
2.39.0

