Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D710F839F7
	for <virtualization@lists.linux.dev>; Thu, 23 May 2024 19:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716491718; cv=none; b=Fr9+Hj6m4jeSulXHCj9Qdc4Oe8Zx3HBOjbvYjp37rNGFXIXbWhN1k7lHUgKgOQ9vvB9mcVsvaEmAcgEWHSytICix4FiU5JjmhQ4jhUwYvvs4NNrszIa1hXNHDIf1qosdd4kzoslJ+xv//MkeVGJRdkKon/fMRu566RRlo5JJneU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716491718; c=relaxed/simple;
	bh=ZNBT2utWr+CWbtzicSB/YTCRG247E6qB9Nr+UR8KY4w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KGmAEBYaa45i0C2nNAzQuw/f9PLGZQZKhbZSxkCFAWLxsZs6RbZCx2ZiMrZJxDx/8whbeTDvwZTOKgdP+H2Sljraujg5MYg9g72LMEl3PlxCWZRpGfTSZjGgMAqWkaeTQdqk60sbUoK3QugX03PuRyJSMt3ZHXh6FkstMKnKLNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=hG2zwOmV; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="hG2zwOmV"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-43f84f53f56so14782401cf.0
        for <virtualization@lists.linux.dev>; Thu, 23 May 2024 12:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1716491716; x=1717096516; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uHMYUJYhS9fLzUcof3ntSmUnLahUe/mGFjgJPys0Prk=;
        b=hG2zwOmVxF0IaAFRuMJ9QGhM4ZtTWo1sq7VL+Mkm/IoAzATZ+ROWIo+mzGuJMqpXb8
         zL1yf16CzG7EkLhdl9mkeHYUqD6uTAG8aAzawSZGG+g3BHvV3Kt/NhYZYY9uu8kJ75fV
         qY/49J7a2xlNqFG9nxhsAo2N3aO9OKlgmUovs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716491716; x=1717096516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uHMYUJYhS9fLzUcof3ntSmUnLahUe/mGFjgJPys0Prk=;
        b=po2aXpqfMh9HtHYXanosB+xsAKpeaLme2XYdvxPSvSUggPvPsQeLQoMrbXPBGH15Gf
         yJ1sSIO0Abv/Exh1KygcRcgbLrCyA5oZCzkfJAJkRoP7TQO69NK0aW3d4TVqkpg+sJMJ
         R0OwJ+JLDMGYUb+nCTR95VAjszEWDhmNo1UlIbdKF11suC84x+c/LjCI9eASkEcMghPy
         SXew2DFdDL3sOEnZFDRVdNZBJuS72NDbtBUOOLeZN33CSZNJXQv1KJHgNPtqHUbaqsQp
         DrOUhhWtImHNyx72gqtO9NvQl+qnu8K9/eKnsez1aNCAJ/nBEmpReP/k20W3v/cSsxDD
         nWWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUoI++USkcmxsfy8hjzQ2UOpzIzhgDpNuFfdU+reOfQ2FOuz+/utYYkr4pRCib8sdxSBIDdA4f8Le5c0Sd9Hk1auXcevWFLRScZmhAhPc=
X-Gm-Message-State: AOJu0Yx5Ma/8djQr4IC+rmXXzWfjZUtbXd92UiyJZHwkj631hd+gdsXt
	R01SszBNfOJZ47NsWPiUU12JCioVKhxmw6vsJ+sUplNysLNbvtzdH78Pv3ugpQ==
X-Google-Smtp-Source: AGHT+IFaSpHOaQG+6UeUCtVGRI/ILrUKTLrw9mZL+0TgADU5BA3XN+dK8zNwM9U3mMN6EkgRA6eSzw==
X-Received: by 2002:a05:622a:1650:b0:43a:f441:75ab with SMTP id d75a77b69052e-43fb0e64ca6mr342501cf.22.1716491715608;
        Thu, 23 May 2024 12:15:15 -0700 (PDT)
Received: from amakhalov-build-vm.eng.vmware.com ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43e4a89b61dsm21219821cf.45.2024.05.23.12.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 12:15:15 -0700 (PDT)
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
	Alexey Makhalov <alexey.makhalov@broadcom.com>
Subject: [PATCH v10 2/8] ptp/vmware: Use VMware hypercall API
Date: Thu, 23 May 2024 12:14:40 -0700
Message-Id: <20240523191446.54695-3-alexey.makhalov@broadcom.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20240523191446.54695-1-alexey.makhalov@broadcom.com>
References: <20240523191446.54695-1-alexey.makhalov@broadcom.com>
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
---
 drivers/ptp/ptp_vmw.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/ptp/ptp_vmw.c b/drivers/ptp/ptp_vmw.c
index 7ec90359428a..20ab05c4daa8 100644
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

