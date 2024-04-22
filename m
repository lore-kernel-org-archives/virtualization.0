Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1D118410C
	for <virtualization@lists.linux.dev>; Mon, 22 Apr 2024 22:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713826637; cv=none; b=WLvwpwixz+eN8PTM0Z8oKfSwPsh5or9RysjMlxr1qhyEdp+SjLzstStsJpCOv2JsXEv8KicA9aJsnVYFnZpMd/pa84yFSd7mvTidCgBP7d+fHJCXIBiJX0Fyc5h0zf7Wggfq2A2pqwOXqsuA6MMEjowr3Ol8ua42w7EwhDnMvoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713826637; c=relaxed/simple;
	bh=oNDqfcadVCBv1NHKCDbX55nWD61GnGcAsAeavqpXrsE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=diHvKUY5Wki9lP2m0vZWhJvEgvr/rL9KrSTcpYR8Zim8cMgtLwTFPsT+fIhQiQZRBsC+6ZCff/OG8jNLu8+wtg1kNeqMDOZgiBU7hWKs4m7dflggiiqThSg7qLXPWuwAm9NYtAHFweXYuh6hvWRQ5HYvCHyreC8GSCQV/b4r90c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=CtuytlwA; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="CtuytlwA"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6ece8991654so4782440b3a.3
        for <virtualization@lists.linux.dev>; Mon, 22 Apr 2024 15:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1713826635; x=1714431435; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qbe175V7J4mZKX1qbMhvDPfRMOR41WhVMQTZgQjYbwc=;
        b=CtuytlwAxyWIU7iQ8SH/8Spj/9P2XsS949utcfEcSz9p9pa+Y1Yv+5Lu8VIbXbG2Gl
         yWaaApD5rlplo6/kjpplzPxtlM5Nvkn9pEnBPmQhpj0Xw0WjTf2QUgtmsArXHkHHWvKr
         AYaCLqon3o4kQPzzm//F9R3Exa4QWJV4H/MNQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713826635; x=1714431435;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qbe175V7J4mZKX1qbMhvDPfRMOR41WhVMQTZgQjYbwc=;
        b=L/sexdsyEz3ZzbmIIxex5nQstUJnDhR/+SRACvWRWa7Bj+CvX1R/+pTyOJpxZa1B13
         X+MFlKeG0h51va9Fmf2PruNUAA2Nif5kdfxlvx8SM4xchq2LisPTLngUl7cgQgeRLdUQ
         ts9bF0dQWSZOzvE1pLCTIvZOgpSr4HW59x6Y4OnEPlEp5MYjNDQajRp7Z/y8LSlPPRf2
         Vukv6RiMLqR7GOY1bjADnyumLt1f76XD7qrFYr2xZjQ76jLZKrGsBn2Y3opnFreRViaB
         7lTHrXWZKqJq/JfW1kK5p4WbRHxqYns/vT58Fl90yEmWs6jpxcMJQZ0PiJWpD0sqn6Y7
         46TQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGkQKqB2WVN0QyQ7JuKBZL+v9XLLw3Nu1UepwiP7Af7GBmitcoHc45J8hZ7+UkNt6h5bqvyF10WmJHiqG7Cz124+7uz/dROSCx2a5G9mk=
X-Gm-Message-State: AOJu0YzosbYvzUU/VxFwRa3A1ytkPDjj4k2BWwtSIx93TSyjySX2MY+q
	+4Py/1UX4Nf7EDOSim7mZ5sRuAX8blFByqbcRvKerYh+k1KEEibiAqNeJ/gCmQ==
X-Google-Smtp-Source: AGHT+IEFR7KNfHlG9ODURmFuea8hUHKaNcbvVa/moCCwACPaA96hdooyXKpZmuNWh/BCyTnbNdW3EA==
X-Received: by 2002:a05:6a20:9484:b0:1aa:7097:49e2 with SMTP id hs4-20020a056a20948400b001aa709749e2mr13552908pzb.50.1713826635356;
        Mon, 22 Apr 2024 15:57:15 -0700 (PDT)
Received: from amakhalov-build-vm.eng.vmware.com ([128.177.82.146])
        by smtp.gmail.com with ESMTPSA id e131-20020a636989000000b005e43cce33f8sm8093597pgc.88.2024.04.22.15.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 15:57:15 -0700 (PDT)
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
Subject: [PATCH v8 3/7] ptp/vmware: Use VMware hypercall API
Date: Mon, 22 Apr 2024 15:56:52 -0700
Message-Id: <20240422225656.10309-4-alexey.makhalov@broadcom.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20240422225656.10309-1-alexey.makhalov@broadcom.com>
References: <20240422225656.10309-1-alexey.makhalov@broadcom.com>
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

