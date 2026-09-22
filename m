Received: from mail-qk2-f42.google.com (mail-qk2-f42.google.com [74.125.230.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF48D489FA7
	for <virtualization@lists.linux.dev>; Tue, 22 Sep 2026 05:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790055684; cv=none; b=M/QCd/GpS8eH9DE3IeLb9G2/bswL/NqEHPXU6kCSDB3vSIRZuB4M56GCw6xtmEIvp2I6ErbGiRdxKMWP93pmEcH3gWn8x1RXMwcms7pbL3RNrN4754l+B7aYq+kv1F76c5pLdIgyDiqRQ7my46/eyjDf0gRbU9Cb0y+NrdiKtEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790055684; c=relaxed/simple;
	bh=iFLkf+rOhLizaAv8+B8/2aNKubqrFbO1iPrtUYCmcBM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rGbfybjSLqUJXjv5PYWgkzhMzCigNQBImoM4MmzRlLlwWEp1hpDPdQ5+66NotxEI6M7e/2qD0YYpAHALbesuF1EOcOxKshH8Ub/AZ+Sd/ECUUZ6G2g4VVr5635NEgqfSa5UHRmctCzk5/HIaKTxswClURsylGa2zks1T1nyW6Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O9gjfbHK; arc=none smtp.client-ip=74.125.230.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O9gjfbHK"
Received: by mail-qk2-f42.google.com with SMTP id d75a77b69052e-52fb766bfd8so33953581cf.3
        for <virtualization@lists.linux.dev>; Mon, 21 Sep 2026 22:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790055682; x=1790660482; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OCtKANYoOWihnD2FHnwq5WRM5Q7npRAqL2fydivBlQ4=;
        b=O9gjfbHKunXNO+26PMlfAKsPLB5EJeGUmJL4vOxw/URxVpGzHnmyFITqgUIReRC8eG
         28Z7aOibHki9UlkjtRh1ua+O+bqPkMlraWG0FKsmSlbbKHJ5lhaQMb2ujlreLYQVdJu2
         zFycdUJZP5ALRwCnC+4TXy7CE5o9Jdm3NtSq4J0gmr3DN8a94xR0PAne71qctQpg7nSp
         NaJ0bo/2KT4WuzC3Cf+YVm4S4IKWJBtQJ3V4Bl5KOd9vpuLWPmIXWDTaEh41yRiky/dy
         7sI7p7nDbz1aeSW8wMMeOjlQ8E7roaunlQ5n0vYYDqm5r5U4ifySdLeJNh6FR2xNQtlV
         a61A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790055682; x=1790660482;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OCtKANYoOWihnD2FHnwq5WRM5Q7npRAqL2fydivBlQ4=;
        b=dCdKKtLx0FkOeb7V8DFvMcUQsbBQvZn6tM2nuTPq4cqepK1xrCgBYX1Rq4SQFA5/el
         qkOIwCaaN+7FD+7QNg7m3iHQ7HKLxEonrAIAx9a4fDyDtTEZiilG7kGce0FANzvXy3ya
         eqVDt6PeWZhJxAaVh/+YL/MZzc8Yd03VND5W+xJ5G+k8e0sf62vDS+ohc92TD1tFBY2s
         vHOAzHnBhvq/c4AniaOXdq/LTegr49QqRUbQE4G+iCBy2c7PcsVpffiUqkfTGBG13CLn
         C+kgnSO08EU6wI1WFhC7zfJw3AZvK+zznMhLMiK3o5SlMSYgjqOqim8/NePip32X0e0S
         5jQA==
X-Forwarded-Encrypted: i=1; AKwUvBwsW8jJd0JZW7uUJsO1R4F8mlXtV75zgvVhPpWe+yYu5iR7kuZgych2Aw0vIqXqBwbY9PPAbiJGP1VM/SGgNg==@lists.linux.dev
X-Gm-Message-State: AFuF++nhr8Hn4euc89Ti3lXl9XVlHxiQ66GJyh/WW6DIZs2gBSpOTEcx
	ROf/ueon/q4IpZIiOu5sS78OMAa97w48U4PDVIwZGEmyL5FH9dLaTSJ+
X-Gm-Gg: AYBFou2Sm7EayLm7tXXAqyFGEENxe91BVj7DNLy40NdtKBTQlqjr+BGBVfaNDMT6fCg
	dWm2E/VuTi3UExPINN6aJO4Z0GCOt6qgituhxaf4PVozfA8lCvOxTl+9uiGqTrTIje08EM9UjZz
	NTd9pmDC29oAnKvXt/Y1P3c3eVZ64hBy3Iv6nC1NRuP6gsenOpQcJZWZnxPaaXwZRQ7WqDh3/ef
	ooaVRDiB3sGF58x3nn+nW0J9aOtClN2htUxhxyswHe7AoAYsAWeCkO5oqtH++TLfFQ8ahyWH7yU
	X51Opo1eZa4cjJIgy8aIgy3KlT5UxPEcILfJ6JhkVsPJb6OFGHIE6E02g9bQev+whts/gcfc52f
	0YtuJ3qZGXWG9rbDu1BFZftA7DF7Y3kDq4GodfPsGCYAIVL18dwge7WEEcosAeVZruQ8TRdmY+h
	6o+3LWRRfocpjJ203k0o23pp7exOyGmhdAxI1PtoBHpErdUd1NbjS2x0H1YAJLKQk8No3U+HRyq
	Mewlux/Y0DEdDvtw4Rn5g==
X-Received: by 2002:a05:622a:1aaa:b0:532:9adc:639f with SMTP id d75a77b69052e-532d8e70943mr39247461cf.67.1790055681695;
        Mon, 21 Sep 2026 22:41:21 -0700 (PDT)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-532e192f96dsm4515801cf.23.2026.09.21.22.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 22:41:21 -0700 (PDT)
From: Yuho Choi <oss.patchbox@gmail.com>
To: Jean-Philippe Brucker <jpb@kernel.org>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	virtualization@lists.linux.dev,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Yuho Choi <oss.patchbox@gmail.com>
Subject: [PATCH v1] iommu/virtio: Reset device before deleting virtqueues on probe failure
Date: Tue, 22 Sep 2026 01:41:16 -0400
Message-ID: <20260922054116.416333-1-oss.patchbox@gmail.com>
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
 

base-commit: f0100363d8c374bd8e9ea7c9ba02744f0b802ca4
-- 
2.43.0

