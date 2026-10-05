Received: from mail-qk2-f41.google.com (mail-qk2-f41.google.com [74.125.230.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1764503B
	for <virtualization@lists.linux.dev>; Mon,  5 Oct 2026 04:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791175762; cv=none; b=ATWBk/zzIxaEHRk8ZTJYZd/fpXGUmDjFJrmFTJ+IVTScq0JTaJoK0wPennKI7lQQ2U9j2/alpeMCL7jTlwQ2AdqFOJ2mD+XHUy0tDH6Rl/5Jdo5KP1QHh8eStrE0KEQk5rDfagY6KH/xQiD2zPrtMFWxB2a41Kx62PDRm6z4Ads=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791175762; c=relaxed/simple;
	bh=RlwK2Cmq0cHokex+6+EAEcjz6T0MlTNy+oIrYy7vIgY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EhcRfHGa5MyBOHMCpXQSW8k/Xgo/Qhp68YyeQSNoM6xOITvj05SrIYUav3st8NKlynhXWxxoxUW6fr9sWQ69iUlm23QIVfQsQxAtsbMOl+FjhYHssYLF/3JyiFHBhoyzfrOsu74QBq5UW1qAfNcCOa8f6TVK02zQuMCGZN2sV48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RrEVOodu; arc=none smtp.client-ip=74.125.230.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RrEVOodu"
Received: by mail-qk2-f41.google.com with SMTP id af79cd13be357-93c5818c4a4so94548285a.3
        for <virtualization@lists.linux.dev>; Sun, 04 Oct 2026 21:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791175760; x=1791780560; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kcJnHXIt83QrSyOF8UJnIWTRMzOTcOywYQswfygDEJY=;
        b=RrEVOoduFxOv0LmKiFkPczEV33Br7Z0SMsDlRYw8fYDpUoZ8azXoCVN8hLDT2JeCc6
         VGdHNd7PRGOSKOC5iFeryuIlsq+/TzqyGnejTrhXFsatcY0syAvWA1TrtlrRgtKfXkmh
         9pG4DHKW2I57WMejtZf/rjphulRLSasz76cZwmXeq1v8iEzFTgnH6PZt5ACdsMSNeCIf
         MWoZazJyXU/JbpYfsWROvfAVFVG5+wm7dPulOcth2Dmp58eFT9wNl1GQebx+dGvdvvzb
         cAq1uPVk6i5lS1LrNspe2JHrWn2lH4dmtX7pGNj1KsZzfSQIqVY6rc6eUbQZX+3Xbmsl
         r3fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791175760; x=1791780560;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kcJnHXIt83QrSyOF8UJnIWTRMzOTcOywYQswfygDEJY=;
        b=x4OQK4jKPrDAt0jzSAMNpEDUFd5S4ATKqWIKkfJehQtFEiQuQmo6rkWHxrfwUZ7Ppb
         dH2fQBIUtHgswrOO9HVaeCy2Stf8zqKqBBFZeFHoGsEJSx/BKZp0zsPjZQa2DI4CNMEF
         aprw9gMpvodOV8tW8c+LXmNR03hQPGS4K3/DveYBcxRIfYYLjHsswVPsHRmuHUHWGZHk
         m4L03ppyGaPzj+87EInPZLmoRg/knvOCIEUh6lYbLJC6fUPL8TAVyk9g4r3ghIV4E1at
         woXrmGSseCTPx04jatR5Zyu5GJCfhoyG4eCvY8uTgOAXq3qdD+/qhxeo0m0FDRnBMdCU
         dBnw==
X-Forwarded-Encrypted: i=1; AKwUvBx069xV9t0JhGzwoY+EToTLdfiD5IHVckwwEy4em8gptYT5JJBZkvaMPsG45Vj9QhQmLloUnhc6zMdR5ptJDg==@lists.linux.dev
X-Gm-Message-State: AFuF++mM+tohUf7Y0GBV6DofnAV3yaihk50jKkY4K/qCfqZPUowIK+or
	7GDTcveY/w9dbsqkqE4NL8Hdcqi7Sq20TZNU9SbU34Gnhr6a8eoXFbnn
X-Gm-Gg: AYBFou3Y0md34zcgaiIqZeJWDXyVjU78eFIw+j4aPTrjAF3fLYJH3Cn4LXLGZj7wuFZ
	N235q31ahLdmPGxF+JTRZxYZn+A7tn/SR225CzN/gM39VvMHYPVD61bImSNsgOdwUIdDMtRvvU4
	Zr70fqwjmXbxq2LwyUs8rpi8DVJlnUmslu62wenOWVP/yxbE98unhzofoCVHsixyiFvc64AF22Q
	wnkM6ipvBEGM5Oe3GrtuuaONPIMagpbprbIx5G8vFkZvigDtYeRo8pOdz/hFKkIrmORrDpCVYr4
	1Htcdxb5WYMb05LigeKjWYTYbL8UHDWSy/9CgZAprQyqyCEH0ZP8mraIdnjxVBwbqcnROpX8Xhs
	B2vpFmo4ctrss104jNjIs8sQzoG9srGpGby3b8KCGETGS3N3DgAsNtcSmyc5zKt5xdr2yjkDrCO
	Bp76HfrO4WMOrQB0XAQqodxdbJTz12E1Nf2lFH42Vq4fe/rzibhmGS4FV2aG3T946Hcx68OHrTK
	FbLz37u42NrJDkJvwLWDw==
X-Received: by 2002:a05:620a:438f:b0:939:bc7c:15c8 with SMTP id af79cd13be357-93cf18979e3mr1635069085a.45.1791175760243;
        Sun, 04 Oct 2026 21:49:20 -0700 (PDT)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-917e0b67167sm79120846d6.21.2026.10.04.21.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 21:49:18 -0700 (PDT)
From: Yuho Choi <oss.patchbox@gmail.com>
To: Alvaro Karsz <alvaro.karsz@solid-run.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>
Cc: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Yuho Choi <oss.patchbox@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v1] vdpa/snet: Don't discard the DPU error in snet_send_ctrl_msg()
Date: Mon,  5 Oct 2026 00:47:45 -0400
Message-ID: <20261005044915.264532-1-oss.patchbox@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

snet_send_ctrl_msg() reads the error code the DPU reports when it ACKs
a control message, but then overwrites it with the return value of
snet_wait_for_dpu_completion(). As a result, a DESTROY, SUSPEND or
RESUME that the DPU rejects is reported to the caller as a success as
long as the DPU clears the opcode register in time.

For SUSPEND this means vhost-vdpa marks the device as suspended and
lets userspace reprogram the vrings while the DPU is still running
them; for DESTROY, snet_reset_dev() never even sees that the device
failed to stop.

Return the error from the saved ACK value once the completion wait
itself has succeeded.

Fixes: 3f3a1675b731 ("vdpa/snet: support getting and setting VQ state")
Cc: stable@vger.kernel.org
Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
---
Compile-tested only (x86_64 defconfig + SNET_VDPA, W=1, sparse).

 drivers/vdpa/solidrun/snet_ctrl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/vdpa/solidrun/snet_ctrl.c b/drivers/vdpa/solidrun/snet_ctrl.c
index e284c3a06717..09afa0487fd6 100644
--- a/drivers/vdpa/solidrun/snet_ctrl.c
+++ b/drivers/vdpa/solidrun/snet_ctrl.c
@@ -291,7 +291,6 @@ static int snet_send_ctrl_msg(struct snet *snet, u16 opcode, u16 vq_idx)
 
 	/* Check for errors */
 	val = snet_read_ctrl(regs);
-	ret = SNET_VAL_TO_ERR(val);
 
 	/* Clear the chunk ready bit */
 	val &= ~SNET_CTRL_CHUNK_RDY_MASK;
@@ -301,6 +300,8 @@ static int snet_send_ctrl_msg(struct snet *snet, u16 opcode, u16 vq_idx)
 	if (ret)
 		SNET_WARN(pdev, "Timeout waiting for DPU to complete a control command, err %d\n",
 			  ret);
+	else
+		ret = SNET_VAL_TO_ERR(val);
 
 exit:
 	mutex_unlock(&snet->ctrl_lock);

base-commit: 7704c4c5bb127673b4f0ead839919db573559e38
-- 
2.43.0

