Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC46140361
	for <virtualization@lists.linux.dev>; Thu,  7 Mar 2024 21:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709847007; cv=none; b=mrgwOg7lP/PASCK50IgfRNmt/85ZFjsisArML3jbkYT7jnMxJFKJzda48tD3kTZOOoPQ5v4Mbh0/2jmU2aRdDrDOrgXePOJSPxUIN3k+MrYhVKk1I68pFGb1o/D17qrMILyRaBTBRt1OXapPfskuTpJGZI5CdNJ8/wY2QPB+aGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709847007; c=relaxed/simple;
	bh=q85JgD8Oce/GbMxM2hbzE2uK2kTx5PPLdicGaPM50nQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mMq/d1UjB8EQv/0Eh3D2NtfOHompFlk4u+u9qjejxyb/5awjFZmbZ1HYT7v5jWHo+EoBAxaUjk2S579dtv8b7CCT/6uJbBRgJFhIhYVZ8ZSHZmS/gJkGnCxOYEU6mqe1Pg2DBYlH7ojEVy2p2UFz6gq8EfTdsvxmvuNtLAJustY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Wdv0Gs1o; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Wdv0Gs1o"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6e5d7f1f25fso156405b3a.0
        for <virtualization@lists.linux.dev>; Thu, 07 Mar 2024 13:30:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1709847005; x=1710451805; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Feyhzg/TR2GQbj1o1biQfDTvdEbNWX0xziUVAK97Nvg=;
        b=Wdv0Gs1o4UOAlAS0LXURUZARVthcvnmorjvhpSjhThXzTBfavyW/DsyuvQ3UPa/s1m
         yWjjwWICoWhhKpDWAy/2hH+E6q7BWrkCWAZD/7eAK/AyijL/egGJOsqKp2YnR7QEuyVk
         vKmzKcsxjdhdBuwQxJcUAGeUODWu+AisWLJgY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709847005; x=1710451805;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Feyhzg/TR2GQbj1o1biQfDTvdEbNWX0xziUVAK97Nvg=;
        b=iRpXnAHJzos2JnnA7vlm28t+hOMZpaGQBUjqBPd03ZuDGAS3ZDyh5w8iLVmvRKcpup
         K/oSOW4OeI2+2ou1zM2fdRZAUmg6wPfTooeurSd4hDRXNrbpIt6HeMm3A5OFt7T1q++O
         TtVkNl8HHwOf8y5BZFVMFdbL10KGnHlhcdmETYkoiIDFLEaQX+s2S+2Nr9/nHFkc0CUW
         Tuvl3pnCQnp9XYflBX7hVPcdQPsJYPiL8hdOMoeH+dhsu+TNG1VU16vTmfy2P8+vTDAt
         NUkXLRkh+G7uT0rIsq5g2ObqwFz1bqTGl9fnintSGxOn+2yN/ky6Zrd1r0Y+wvwRSjlB
         XjGA==
X-Forwarded-Encrypted: i=1; AJvYcCWvh2jma3XaYTavJYsUjA8Piw4NIVjJI6rthf3Zef23E1k2pt1gdCGCFFRNC5WUoI8m8xjM193RlBfIydP75+eZyTgiCrQPmgS/3A4PrZg=
X-Gm-Message-State: AOJu0YyergZDzi8txN5L4hKGH6fNXYgUOeU6kFKskA5YVOgdAmkxDdib
	Hagx3MciCXCRM8+oQ4zg05ej4kRuq+tNgE9CHqd+AlfJm44QD7yqCuz26A0PoA==
X-Google-Smtp-Source: AGHT+IH9OHYBQPXQb7OICX+HbM6+SdDdiit+wioICdr/cHaeFQ14VaIDLC5V3mR+Gh0DgUqUIeZdxg==
X-Received: by 2002:a05:6a21:78a7:b0:1a1:3ecb:5303 with SMTP id bf39-20020a056a2178a700b001a13ecb5303mr9695877pzc.0.1709847005037;
        Thu, 07 Mar 2024 13:30:05 -0800 (PST)
Received: from amakhalov-build-vm.eng.vmware.com ([64.186.27.43])
        by smtp.gmail.com with ESMTPSA id y12-20020a17090abd0c00b00299db19a81asm1991021pjr.56.2024.03.07.13.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 13:30:04 -0800 (PST)
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
Subject: [PATCH v7 3/7] ptp/vmware: Use VMware hypercall API
Date: Thu,  7 Mar 2024 13:29:45 -0800
Message-Id: <20240307212949.4166120-4-alexey.makhalov@broadcom.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20240307212949.4166120-1-alexey.makhalov@broadcom.com>
References: <20240307212949.4166120-1-alexey.makhalov@broadcom.com>
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

