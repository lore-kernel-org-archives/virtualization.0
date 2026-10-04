Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CE43B813C
	for <virtualization@lists.linux.dev>; Sun,  4 Oct 2026 18:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791138148; cv=none; b=jt5bLy3tqCXsLaiXxV9N+94pNX9J7gPI3v9Icy7F/WhSv3TjGdR1dlOnmap5kZA1oeY4eAExwn2g3amXbGOv2lWUyV03tdNaKq/no6nOV2EweeOEUbUsqr5xWTP7V5JMeG72Yy/335XGjGi1gwdHCK6YTokf6U4oR5fatx1IkKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791138148; c=relaxed/simple;
	bh=oWV1x6C2ME/T5Yb2MZ7o3ypqhTuzYDHLFIWMHTAMo24=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CMQC9pWh2mBSLEKlcg4WZqXmRZJb/YkpD70xOdrarJM9CBcr7UvlB8+oOtDywaNnXN0DtAkf4u6imWYD7XQ8V0SwHYYS3sk3adi4528A7xaBcdfWZAV1b25OmklwM6oIaIi/N4nA0OpmH9hyf5jFO8I+suBDCFpkBfA2pysyJaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bgfM+iDu; arc=none smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bgfM+iDu"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-52fb766bfd3so8209731cf.0
        for <virtualization@lists.linux.dev>; Sun, 04 Oct 2026 11:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791138146; x=1791742946; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CF4IOObCfjFDOCjh2XXYxYv4lcIPIAWQIMOn46YsfNw=;
        b=bgfM+iDu1SHwDsVAyt4v2fvqfPeJ+KTb9XDBK4MR8KVDj7tPRhs4VwVfdhROkevpOU
         /N7tjA3ZQqXWyfddyQVwsfdC9uBjIqLTaPZZPQxVPet3xBo1bdJngnyveNTmS3vG1DLx
         RR9joGWUl2oS7HB4PskBf2iNFxSZ8mwT1SCullx4q0OSydIKzqQ/Oc270kqz4X8187hn
         Nw5xAxGXIe+Gx8JphG0cEygx1GkfT/n6kURr28xbKi9H4Ps/nJkl5hne/+QsMUUXSCsL
         +jgt19IBfWxt6aKBr8O4DPGIul/kQIa8gRCldVsH1btiA3n2BvsjJfH2Ny8q4hW0ucNe
         7MfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791138146; x=1791742946;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CF4IOObCfjFDOCjh2XXYxYv4lcIPIAWQIMOn46YsfNw=;
        b=Wx4E0HMEMAEqZS29lqdsVcr/v1Qh6a7zLsykedSRxtP/hR7UVRdW4bszWAbY3zTRPX
         d+nYUuBNWbn4q2IFJnNGPeqvHQEnayZFE7AeWjBro3+RzqzaKZgoV53MB7y41rIwR4t9
         bAAcu2cskO0x3IkfGanqznJWiwBp78suybvb+/2wCezw3SRbb4YF4TeInBrdzRX6Zew+
         WV77tbBNi+Xm70hWRBrtkAOk0aV5tqJcPMVI5jiaW6J9t9665VedsFj+0icvkLbhi+wJ
         urktiayKw6ALEOceluat2T7WQ2da2zXDnkoGHTEh0U9YsyGAepKCMHwdRvPujJ60uUCS
         fdig==
X-Forwarded-Encrypted: i=1; AKwUvBw8X9NKMAJJwLd+2hGHRtc2UOvuNOJgnk4T4SpUsyj/e/kOvj1rWbwvXeyiRYMiFOFVfqHeZAUfF9xZwJn2rg==@lists.linux.dev
X-Gm-Message-State: AFuF++nLr73DlJ31M2DOnQ+yNRQAHBajIudnbv9Wj7tWLgtIvnuylzsK
	2HLc5xerF5blgQ73wmaeDJgEzX96ViEfouarG6PR8jsTrS4h9cyz8vP8
X-Gm-Gg: AYBFou2+2azIcT9waL9LrfGzKp7Q6REdATCrm3LEUZpNv2Iufv2EqWWnriHUc1LoU/6
	8iLySdedzw+eZHsm+z6xPURG6aPLT3/BFey7WzrOWNwiwyFqn7obLGBZh1GBCxrc2TRfARnnGTL
	AJs2pblti5A/kIkq2VjGLxvYURp6JjYBHcQFDM3rS1rTrG1Dcf9p45wRr0muJppBsNMI1w1Euhy
	+D9nazgix7ijpnG/nGbonAe13SnR5cWLr5OeMsxqfd5pMHhluRITDCjjbL95kg29esl4bD+a4O4
	aTiPth3vIf9iOB48tEkOgteJ83ANicTi+kUm0Ck0cvz0F1qcxU9avRBWhHK8FcA/RswsrGyd0TV
	sPUt7fc4UWv2JWq8MQj8w0rNl4BCsfXr6K5/gNvU27LkB6uMNjQOht3bjvsBCXe9HTfu7cMl7tU
	gNkfwG5ynH/Hd+TaZVE44JFbywOR1haI/qzTk2aI3J+i2Zf+JR5yHWun4PT02G02F/puitkdmHI
	2Qg9wlU4e4tidJUO3vNtYLH/mkYpnnC
X-Received: by 2002:a05:622a:618c:b0:531:ab4:c604 with SMTP id d75a77b69052e-533bc652ea4mr174969861cf.1.1791138145927;
        Sun, 04 Oct 2026 11:22:25 -0700 (PDT)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5351fd92b58sm27430061cf.21.2026.10.04.11.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 11:22:25 -0700 (PDT)
From: Yuho Choi <oss.patchbox@gmail.com>
To: Jean-Philippe Brucker <jpb@kernel.org>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>,
	Eric Auger <eric.auger@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	virtualization@lists.linux.dev,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Yuho Choi <oss.patchbox@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] iommu/virtio: Reset device before deleting virtqueues on probe failure
Date: Sun,  4 Oct 2026 14:21:10 -0400
Message-ID: <20261004182218.177343-1-oss.patchbox@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

viommu_probe() marks the device DRIVER_OK before populating the event
virtqueue and registering the IOMMU device in sysfs.  viommu_fill_evtq()
hands the device a set of device-writable buffers through
virtqueue_add_inbuf(), so from that point on the device may write into
them and into the rings.

If either step fails, the error path deletes the virtqueues without
resetting the device first.  The event buffers are allocated with
devm_kmalloc_array() and are released as probe unwinds, so the device can
go on writing to memory that has been freed.

Reset the device before deleting the virtqueues, the way viommu_remove()
already does.

Fixes: edcd69ab9a32 ("iommu: Add virtio-iommu driver")
Cc: stable@vger.kernel.org
Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
---
Changes in v2:
- No code change.
- Reword the commit message to explain how the device can write to the
  freed event buffers.
- Add Cc: stable.
- v1 was mistakenly posted twice; this version supersedes both postings.

v1: https://lore.kernel.org/all/20260911011249.1498825-1-oss.patchbox@gmail.com/

Compile-tested only (x86_64 allmodconfig, W=1).

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
 

base-commit: 7704c4c5bb127673b4f0ead839919db573559e38
-- 
2.43.0

