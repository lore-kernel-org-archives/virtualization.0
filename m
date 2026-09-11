Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6ED2E6CB8
	for <virtualization@lists.linux.dev>; Fri, 11 Sep 2026 01:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789089178; cv=none; b=G98Y/mqKQq+CHDa+XDzNAispSRMMi2n/HrfBGf4YVMYK8UO0IwND5R0WaChMTokjwlzGE7OBEjJKmMgqbKykyG5cb4P14uEk8O6JAdbyCKetuN2c5zDSHUam2aO1wOYu4ehyFYgYAIAI1ZOdNWvkWlVTLHFaTFSUbMhOrtZPGoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789089178; c=relaxed/simple;
	bh=aSoY/N0oGpMD3DwFVn0NoXhZY918z65CXFED2AS+aH0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=liOfJyUD+JY84/yYsvMZBVPc0kqZBF3yw9tCVlD400ofjVT3aEjWjCnml49+xr1BQM6sH+sCxyMXSSBUAUZtG+haf/gwRMNJwmzKKgCSnglGc0F/Vxkqr2UmuSmXFvHqq2tTSh1MNiTvOvQ+Sxj/m6XVYQtl1xw4QXnBcm2zOss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U11vEc+r; arc=none smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U11vEc+r"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-52fb76ef19aso4962761cf.2
        for <virtualization@lists.linux.dev>; Thu, 10 Sep 2026 18:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789089176; x=1789693976; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=uynqckbdmTZIURakBh8b2Eoz8Wxwr8hx5bA5rcYTljQ=;
        b=U11vEc+r23s18BbWWNj8b0Twwfxop5bsBrJWG1fhP2OuJWfQ/c2gCix2JkE6nCV8Ls
         /oW2YAkgeUs00jl3JPX81l8xl81rLFefAqYo5H+16Y7x9xoS9XgCkcoLAmVKKbULdKh0
         r7C3teJYbnqVm0YqVVvF/ujON97xbyJTU28qRDtK7ZXJoyutWg+Tk9dcNzNaJLQU/fZw
         YzgLDU8V1ZLMyehA8KLSPMauk790htw46jv3mjtwXq5hxGPU77+l+fiQ0gWHUIycY9OZ
         547vWL3kJGSq89AKQvADoJsIRnhpSnGCMnUlay4eet6trekYuwxUurYNBtjAsrCmC8Ls
         TJJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789089176; x=1789693976;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uynqckbdmTZIURakBh8b2Eoz8Wxwr8hx5bA5rcYTljQ=;
        b=U2tvK5zjv1K/cAxXegZDkPqCLnTXmF42ZtS0pPlAGNqCvNfS7/PHJg3i9SpWCLsAQA
         l6SsLkGyrdzodEt9BfOompktNgRKJtTs452OM6u5pnZH/IauixNKEQUDvfR2ZD1vyRPe
         lenzchQgH7IX5wIIc9N+Njissw/xVQ2j9EFwrpsC8657sFCSEGwthDTjI7Q8nA4WH9vX
         LlsDAkiZHwbRmKv1RYS/MWl0eT5kzeY3YO29yWhleqqutUm1fvA9+iFapL6izNZHGr3B
         NHoF+i1b6OuTWKztxKVHO9QLS4/ajnfKvMA1xpQmz/F6UFFDIcYMXw2AexRELSDeu/3i
         J01A==
X-Forwarded-Encrypted: i=1; AKwUvBxSnxaHBRhtieQYd+CwTFcIQgOCR91wsav1jWLwHCz8jyWWrbnV7I5ZIjDM4Q7cIa4frGI9PvE9fAjXLh3ZGw==@lists.linux.dev
X-Gm-Message-State: AFuF++nH15ZSVeTSZoQWY/s/grALhxuCWOixZ1ho6PFkNYK+0Mzcv/ZL
	Cdehs5H9nZPVRfkU6vNLlPvpPTpWToNLkMC3EvZ3qRdg4SUANNt8/4Bi
X-Gm-Gg: AYBFou0vfO3Wzz2H4t+k1+B1zclQbpb/roU9s/kQaK1FctyDtPiNnEkmN00YfMnhBQV
	S0D1Ca9lrpXU9QfyRAXRGOMaeHLqxF1HqRzeFfqRfRD4Q3JjHMdjrIwjU7AnOJXMZFw2nZ9pqHl
	2okRX08Rqv0iZ0VqOAWoyVzzA25t7LQCTg0hpmV+G55znKf2h9bzro1vZpQgCrrLZoh7WAJGieY
	ZcXGXaRnaqwQhIL80+CTZdDsTSxcxN6DbT2XhaTnV/MUx/gb+yNijvGRzf/+FmJ9r6205ZuHsB9
	MZTP1/DS/hFjmn+Kk4lpRxElD6vFmLjJXEA0vwFclNdKZXB2XI8agmcXnTsTPnr5jkqtzgoaedY
	bkGaWiHJuKrEqaWxkKJ8+t4StjSx7zjo/xM1bBo5Yq1UBo5iwNWRt+3THmJlMQsdsuypyd77yb4
	OkERzo3auDaYpjiDBW57lezB65Ms/SZBefVEGin4e10pjHO29Ecu3VjfuzpBcLpy9J9c/UM2OOi
	bse9SA=
X-Received: by 2002:ac8:7d55:0:b0:530:5434:e4d7 with SMTP id d75a77b69052e-530c86fd1abmr32349001cf.32.1789089175533;
        Thu, 10 Sep 2026 18:12:55 -0700 (PDT)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-530ce4ec298sm4289851cf.16.2026.09.10.18.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 18:12:55 -0700 (PDT)
From: Yuho Choi <oss.patchbox@gmail.com>
To: jpb@kernel.org,
	joro@8bytes.org,
	will@kernel.org
Cc: robin.murphy@arm.com,
	virtualization@lists.linux.dev,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Yuho Choi <oss.patchbox@gmail.com>
Subject: [PATCH v1] iommu/virtio: Reset device before deleting virtqueues on probe failure
Date: Thu, 10 Sep 2026 21:12:49 -0400
Message-ID: <20260911011249.1498825-1-oss.patchbox@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

viommu_probe() marks the device DRIVER_OK before populating the event
virtqueue and registering the IOMMU device in sysfs. If either operation
fails, the error path deletes the virtqueues while the device is still
live. The device may therefore continue accessing queue memory after it
has been freed.

Reset the device on error paths after DRIVER_OK before deleting the
virtqueues, matching viommu_remove().

Fixes: edcd69ab9a32 ("iommu: Add virtio-iommu driver")
Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
---
 drivers/iommu/virtio-iommu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 587fc13197f12..fa72ae23b8afa 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -1227,12 +1227,12 @@ static int viommu_probe(struct virtio_device *vdev)
 	/* Populate the event queue with buffers */
 	ret = viommu_fill_evtq(viommu);
 	if (ret)
-		goto err_free_vqs;
+		goto err_reset_vdev;
 
 	ret = iommu_device_sysfs_add(&viommu->iommu, dev, NULL, "%s",
 				     virtio_bus_name(vdev));
 	if (ret)
-		goto err_free_vqs;
+		goto err_reset_vdev;
 
 	vdev->priv = viommu;
 
@@ -1244,6 +1244,8 @@ static int viommu_probe(struct virtio_device *vdev)
 
 	return 0;
 
+err_reset_vdev:
+	virtio_reset_device(vdev);
 err_free_vqs:
 	vdev->config->del_vqs(vdev);
 
-- 
2.43.0

