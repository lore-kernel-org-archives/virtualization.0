Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F9815E809
	for <virtualization@lists.linux.dev>; Mon,  6 May 2024 21:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715032429; cv=none; b=lp+cON5ca8YT6NOJXotYNaD4FU6vI6z8FwqMiHnpn9cJiSefWg046yL/kiNUSzW+l1Hxfr2f2JMbpoUApO7H5NwokkimYVulslN/anQY+8mou9u9SOybzvi+plAOsegjznyzg2WUV3bSmpVn2q8p4T+DUJsH8wlLSdodkcDTU5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715032429; c=relaxed/simple;
	bh=oNDqfcadVCBv1NHKCDbX55nWD61GnGcAsAeavqpXrsE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GDZGhZ/EvQGqtf5bkFJ7WA5ICW68JHwmNv2hyA7+l4k5DC6o+/WHawvMBBtKK+dDOqAAj1nY0gYcg6RY8OtPvwtqlg/9rc5gZYM5wHVZ9ry3iw18D71X6V8+fnHk418iLpLiQcUrP1wE26T06B5Tlm/Up73ZKe/F3asCxXEy0JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=fcIbBzbG; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="fcIbBzbG"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1ecd3867556so17075615ad.0
        for <virtualization@lists.linux.dev>; Mon, 06 May 2024 14:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1715032426; x=1715637226; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qbe175V7J4mZKX1qbMhvDPfRMOR41WhVMQTZgQjYbwc=;
        b=fcIbBzbGOpE54rCwr0OnhoGEIU898kBSH2+KK+Kvk00xDLYnnr5Nph65a6OfZ07o/I
         zQPXdMrPgbgtfVqf24WQcfgFxTiBnsehTflkYgNxdGaltjM57fbNlNkSwPil/+KCSVF8
         DE9Lyge2tOKQZBymxbtmzFEON74/s2LMDQkdk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715032426; x=1715637226;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qbe175V7J4mZKX1qbMhvDPfRMOR41WhVMQTZgQjYbwc=;
        b=r0d+DOK+AgALaI0vZJ/esX0pnTLiRGbQwr7/k8X7Ug5hSSN5gycGohIfVprFFFGc2d
         kO5ZLSHBck+QMfHEiC+sAN7CXd2k2NZ88VxvIHrLtCnDlD9DmQ4CgFT80NvaCAJjYJXi
         s2u5RZU/8Fs1kHTWVEzC2LbjgPTb7RHNJbiXY5EBfuzApF6rHNfika5kn8cwPLSs+SB/
         qFjpwsP7kd6tRKkpRutIXiNR2+j0uX5n+1CVgasNu/u9QOyhmhiQckksq5qo9WGlt0jB
         /TRLFs73RQIoUnkSQQBJiRCJnsUVZz88BeqnZkAeJOUfe/ZI8fg+mzZJnND7K4kBKBog
         OzhA==
X-Forwarded-Encrypted: i=1; AJvYcCUd13Xhb34F9L+orOnAfDY7BtefZCX4tjUyUdtVoDvXSGPgXrbMv1rFbIRTt4izHHzS7QlE5KChw2QbSUL6RPvyaqFAe6gQSJHBTQ4EPiQ=
X-Gm-Message-State: AOJu0YwEmITxJeuQUpVBWDJsrEMT/IJXsak7PKCgzT7apve5J9k0hgt8
	qkL1nsfDjfk3XlKZRh5YLoCilftmblBV78h2wXXPJ8QnaQKicSOA0yGYgh9zMA==
X-Google-Smtp-Source: AGHT+IF9KGLbu1mYoD5+HNwJ4RqC9puh1gLYMQgkGGUeZcF7dPV+YrdASSz/bi69CBBVXAU8JRj2Fg==
X-Received: by 2002:a17:902:ab8b:b0:1eb:156f:8d01 with SMTP id f11-20020a170902ab8b00b001eb156f8d01mr9782604plr.40.1715032426230;
        Mon, 06 May 2024 14:53:46 -0700 (PDT)
Received: from amakhalov-build-vm.eng.vmware.com ([128.177.82.146])
        by smtp.gmail.com with ESMTPSA id h8-20020a170902f54800b001ed6868e257sm5664008plf.123.2024.05.06.14.53.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 14:53:45 -0700 (PDT)
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
	timothym@vmware.com,
	akaher@vmware.com,
	dri-devel@lists.freedesktop.org,
	daniel@ffwll.ch,
	airlied@gmail.com,
	tzimmermann@suse.de,
	mripard@kernel.org,
	maarten.lankhorst@linux.intel.com,
	horms@kernel.org,
	kirill.shutemov@linux.intel.com,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Nadav Amit <nadav.amit@gmail.com>,
	Jeff Sipek <jsipek@vmware.com>
Subject: [PATCH v9 4/8] ptp/vmware: Use VMware hypercall API
Date: Mon,  6 May 2024 14:53:01 -0700
Message-Id: <20240506215305.30756-5-alexey.makhalov@broadcom.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20240506215305.30756-1-alexey.makhalov@broadcom.com>
References: <20240505182829.GBZjfPzeEijTsBUth5@fat_crate.local>
 <20240506215305.30756-1-alexey.makhalov@broadcom.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Switch from VMWARE_HYPERCALL macro to vmware_hypercall API.
Eliminate arch specific code. No functional changes intended.

Signed-off-by: Alexey Makhalov <alexey.makhalov@broadcom.com>
Reviewed-by: Nadav Amit <nadav.amit@gmail.com>
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

