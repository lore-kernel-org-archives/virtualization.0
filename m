Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71528B653
	for <virtualization@lists.linux.dev>; Tue,  9 Jan 2024 05:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="C1ulYcR1"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-28cb3bc3fe7so1732305a91.1
        for <virtualization@lists.linux.dev>; Mon, 08 Jan 2024 21:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1704777034; x=1705381834; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FPJVwuu4FbYV5iHDsqoRPE2dBrY067QdoWIAplCPCFE=;
        b=C1ulYcR1SAIKcv6fycfedNF0mpT5mjozFidDI/zEJ8beh5DRg+Z//cR6mAAjWWvQ8S
         WZmbc2UyC48mm2XmQTQR2rbTc7uj4xanB9V/Bk0n4G79cy6ga9OBKABUwybG3tDde9Bq
         j2DSMWXv7aam+tTVf94LT3JyJ2c74vq/rd2/Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704777034; x=1705381834;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FPJVwuu4FbYV5iHDsqoRPE2dBrY067QdoWIAplCPCFE=;
        b=kc5tUUfAUJfPaPTpbDYE1jxAfiT3lNW+YIzKw1NgCik23yi3xjHqSApgV2ThgjJk47
         T217Wysp9KIhNKgK/IKhMQOX/217OposI3dSMui1NCwxaUOyrwt177fQhcHKrpibMuKv
         26evD6BQAp6QWuULp88SyTShyWLAEE7PVf1jnZfVfRuhhkoKM2N8nFY1ED/BLn7zv1iF
         Yvjoam2/w1x5CyH/m3HcqKKDVnqe3Tf4yoIaoJgq7WaF9G9W33AnVi/5ec3tMnVIINKN
         I+oBfYCzaPk67Q4J33fC+kCVz4c/DhieGPQrovY3riR6WQHdpY3SB1JssJq6H3NLDglZ
         2hwA==
X-Gm-Message-State: AOJu0YzECW3H8riORyCgI6HwSFvCo8UNnYiYOgiMALWc3oRjh1iDLKMX
	UeyP9UtLzohvwUDIvPT+3fy4nREzVm0/
X-Google-Smtp-Source: AGHT+IF8dZpjBWWe0z4dBottyxYx1ikBBs7WVJxcndsJDTAagxtQXlqQ+kLYDBJXFVwQ3s/k1DbpXw==
X-Received: by 2002:a17:90a:de0e:b0:28b:fee8:17e0 with SMTP id m14-20020a17090ade0e00b0028bfee817e0mr271922pjv.19.1704777034669;
        Mon, 08 Jan 2024 21:10:34 -0800 (PST)
Received: from amakhalov-build-vm.eng.vmware.com ([128.177.82.146])
        by smtp.gmail.com with ESMTPSA id u12-20020a17090ac88c00b0028aecd6b29fsm7344115pjt.3.2024.01.08.21.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 21:10:34 -0800 (PST)
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
Subject: [PATCH v5 3/7] ptp/vmware: Use VMware hypercall API
Date: Mon,  8 Jan 2024 21:10:13 -0800
Message-Id: <20240109051017.58167-4-amakhalov@vmware.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20240109051017.58167-1-amakhalov@vmware.com>
References: <20240109051017.58167-1-amakhalov@vmware.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Switch from VMWARE_HYPERCALL macro to vmware_hypercall API.
Eliminate arch specific code. No functional changes intended.

Signed-off-by: Alexey Makhalov <amakhalov@vmware.com>
Reviewed-by: Nadav Amit <namit@vmware.com>
Reviewed-by: Jeff Sipek <jsipek@vmware.com>
---
 drivers/ptp/ptp_vmw.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/ptp/ptp_vmw.c b/drivers/ptp/ptp_vmw.c
index 279d191d2df9..e5bb521b9b82 100644
--- a/drivers/ptp/ptp_vmw.c
+++ b/drivers/ptp/ptp_vmw.c
@@ -14,7 +14,6 @@
 #include <asm/hypervisor.h>
 #include <asm/vmware.h>
 
-#define VMWARE_MAGIC 0x564D5868
 #define VMWARE_CMD_PCLK(nr) ((nr << 16) | 97)
 #define VMWARE_CMD_PCLK_GETTIME VMWARE_CMD_PCLK(0)
 
@@ -24,17 +23,10 @@ static struct ptp_clock *ptp_vmw_clock;
 
 static int ptp_vmw_pclk_read(u64 *ns)
 {
-	u32 ret, nsec_hi, nsec_lo, unused1, unused2, unused3;
-
-	asm volatile (VMWARE_HYPERCALL :
-		"=a"(ret), "=b"(nsec_hi), "=c"(nsec_lo), "=d"(unused1),
-		"=S"(unused2), "=D"(unused3) :
-		[port] "i" (VMWARE_HYPERVISOR_PORT),
-		[mode] "m" (vmware_hypercall_mode),
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

