Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3879910A24
	for <virtualization@lists.linux.dev>; Thu, 28 Dec 2023 19:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="BVsp6quv"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3bbbc6b4ed1so1890170b6e.2
        for <virtualization@lists.linux.dev>; Thu, 28 Dec 2023 11:24:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1703791484; x=1704396284; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bdRA67GFcUxloyx4tvXG24BR0us5wKd/dCuK68J3MHc=;
        b=BVsp6quv7XxOHguAC5zTNJBycm063NB508Swb+JJMglp5MFF4MLNAzbnTn9TeXHXp+
         HBPHGwvNFYAU95VCrW1JdWZ405C0DLfA/Q1D/3Yi8kE86rVGQ0ndluiA9ngcoS6WN7KE
         I8Ky3ens41aRqNnbgBl8Na1JIsQeXcJkF2rKY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703791484; x=1704396284;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bdRA67GFcUxloyx4tvXG24BR0us5wKd/dCuK68J3MHc=;
        b=tSqrmzjCt0013/NKaq5xsA6DmpwXFOcGrgC68DI3eW/d42ksYFVWQz7lCN4oAwBfMI
         IwqM6XpxwYnzfMr0slfiMTCf05uVPC/6QJpBMFNv0qHFiA40UfVhnQF16LNqbb8W7+US
         2kT4n4GvPsjwIQQKB/RGVBIZTkXLaopSStC/ALifI+ngGW3zXoXnU3y3ROL4YeWt+ekz
         BDC/caYr3Om4V4rzmGaIjnUyJv33JAwX1hySp/yNCT2T5feqNltFwcZkLGjW1QfiA6lA
         yFdv/1kG0S1LJmNMhidsK6VfVBrhFbN98f6yYTuk1ab7k8p4TO+nih1sslgJP9z+qSp6
         OHIA==
X-Gm-Message-State: AOJu0YxNiymzvPjI6Adc5hV3Yix4BTDt/T/SYcVxjkzQeYyHLGgMBxcz
	mCB4reHpEeH8LLKIU9vG0lKWakwgKDo0
X-Google-Smtp-Source: AGHT+IGHYW0xYeyV3d3r2997V8Recw3s/K6MrDUwDBVQ7/8JTxUclwzguPNHYesx6/e0rfKwu0U8Qw==
X-Received: by 2002:a05:6358:103:b0:174:dc10:e528 with SMTP id f3-20020a056358010300b00174dc10e528mr5198591rwa.39.1703791484151;
        Thu, 28 Dec 2023 11:24:44 -0800 (PST)
Received: from amakhalov-build-vm.eng.vmware.com ([128.177.82.146])
        by smtp.gmail.com with ESMTPSA id k16-20020aa79990000000b006d9aa04574csm9522987pfh.52.2023.12.28.11.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Dec 2023 11:24:43 -0800 (PST)
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
Subject: [PATCH v4 3/6] ptp/vmware: Use VMware hypercall API
Date: Thu, 28 Dec 2023 11:24:18 -0800
Message-Id: <20231228192421.29894-4-alexey.makhalov@broadcom.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20231228192421.29894-1-alexey.makhalov@broadcom.com>
References: <20231228192421.29894-1-alexey.makhalov@broadcom.com>
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

