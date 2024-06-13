Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1F814C5B0
	for <virtualization@lists.linux.dev>; Thu, 13 Jun 2024 19:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718306243; cv=none; b=H3ZK49RHArw1ctI0kui6BGwmZ41oFgwTRxU+bzynR1Jwj5JQK1lxXPW+EOocVGUgdNJbdQyDxdIoEuVWsTMGqGINUW5OwrFhz1AzOIbXd1kKeBmRKKJBceNAy99pPw80ltX5z8/ah0+bU65MwfgvkZx1rdu9KdtpMY7b9yaY/9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718306243; c=relaxed/simple;
	bh=OG42qfwazXtBgUNMq966TfvZjei0oGY3S3mxCfCH66M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c/Kl3SN1eIQl492erc5rfpZR9AkRktc45ErIb7jmZEMPuQFZ33V8tWrvkHm2zaoT2kjNEMzvDaZx8Y8kIoK6MKMUgAvNyg8HDHzDRDE1vmZQSSOihUgg0dfb+kQMApjH3TqH/BrmDtyXW6vcyQaW5hxqIep/JC2DZVamOTLYVzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=VAEsiMMQ; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="VAEsiMMQ"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6b06446f667so7669826d6.2
        for <virtualization@lists.linux.dev>; Thu, 13 Jun 2024 12:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1718306240; x=1718911040; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ax+3nG0Kdev/eny6WkBwEporcnkaWtjPbwWuGAk8XSQ=;
        b=VAEsiMMQBnvz1gHkfrtBstVU0WYh87hDnrNk9F799bQKhvdmxwgUnEgYwvU3Sj2l0E
         cRoHdQaTCmeq6mATLKQV0t4HKDe87iOweloT0yEuPDoPI5WcGlRGvGVi8oPYlJ3rPqxW
         STYLJ79aCpavvG8e6DOOK+48Vr2OvQ+xQty4Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718306240; x=1718911040;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ax+3nG0Kdev/eny6WkBwEporcnkaWtjPbwWuGAk8XSQ=;
        b=vWI9l39VoTw/frPGd9bRNIItnMjOaAVR5OodLcgMf1pi2CVf1n41ZOveaY3UYmMclN
         0OKiQHebFxuAsk3PAu15G0odWVKwxuYWDDZau/ZP2ZHOnOCxSmh/oScsZ8eYPHammRrf
         9TGT62qm7ySmECTH10kU7Gu9hjLGaSU5FR006ePl87oVXS6RRaE1gIY6kV9SOOomSl7l
         /hkeysukNo3s6uMizaE/N4kutp5q9SnPdN3PAWLgPv3GJaSE5zXFla5HCHMGpsUDjXSY
         BOskADtwvzQqLa0ChMEvwgVlmsc25Y/BbgnY3aUZweaUPmkEc2mxdoEcUe9qb70pEGAB
         xsDA==
X-Forwarded-Encrypted: i=1; AJvYcCXfc6KNcUkkSTcI+HF4LJH/Y9Z/lOsDXMoxpWT1ohO8TSBrFfFwabCnOld64YHLwzqzVjm3XB4rMiyJwwwum7mX10BkST95Jb3n9tm6nLM=
X-Gm-Message-State: AOJu0Yyy0E42d3Yvd25cWif32eND6FleQk602PqRQGmP/x073S0EB+Yv
	rbYd8nm5JUTjYbNA54Ig4sBaIuHHb/W1PnA+dJf+d56MvrX5XHNLznbXwx3fIg==
X-Google-Smtp-Source: AGHT+IEeXpn3Ttz0XbsYPXByW9dR39UVsdwJC6JosUg+iPFfKoIf29zQxFw7l7oJP0aQ82f3abYR7Q==
X-Received: by 2002:ad4:5a03:0:b0:6b2:b054:c64a with SMTP id 6a1803df08f44-6b2b054c6c8mr4382156d6.1.1718306240532;
        Thu, 13 Jun 2024 12:17:20 -0700 (PDT)
Received: from amakhalov-build-vm.eng.vmware.com ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b2a5eb47f6sm9714106d6.82.2024.06.13.12.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 12:17:20 -0700 (PDT)
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
Subject: [PATCH v11 2/8] ptp/vmware: Use VMware hypercall API
Date: Thu, 13 Jun 2024 12:16:44 -0700
Message-Id: <20240613191650.9913-3-alexey.makhalov@broadcom.com>
X-Mailer: git-send-email 2.39.4
In-Reply-To: <20240613191650.9913-1-alexey.makhalov@broadcom.com>
References: <20240613191650.9913-1-alexey.makhalov@broadcom.com>
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
2.39.4

