Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C6D30FC03;
	Thu, 23 Jul 2026 01:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784771679; cv=none; b=Kp92coq8TMgq2hIjFBKC6iwn+KWdgfdAT1kuAfzV1OXxzdGz5UGwCUpLOHtFADE/cr4/RFaR+0Z75gwWG8XfJZC4o4w9Q2isDRQO5Amxj/oT8xRbui3k1CJoDaFccjgmqQA/IRvNP0lD6TZUXYSrRbM3luPOWTCYh5s/7wSW9cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784771679; c=relaxed/simple;
	bh=089wMMeRH0mlkT2a6yek8K5n3+LUMwQNEZslixZ7cwI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GmfN7Nmyk7GlxKMIDHcUze4KEBceInWBZC/vYhIvgMSLmcYXr6Kd05odGXKga/5VWDJ8JW+8j3fIcMwYF7tld7aV1yfUdlxGuvSgCNJCGeTxLIwIvdJKGlNmp833PmqoP3wcEL9q/qG+Yej4BNqwnWzBi3AFhx6c1gPvCSAeJaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=T/YQHL43; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="T/YQHL43"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version:
	Content-Type; bh=0qHby68vxoCYmWhCjDGR3CFkk5s5D1eqNGYePT66LFw=;
	b=T/YQHL43zD7eRJoHw5gms6iCHgO93rETdcwSgFZpEnPffLcVwnhgahfs01GkvK
	YbXAJF3Ker/HrsRjDX0gR7v28KUm9VILBAng1u041FsZBudczXSZnrpC2ob6G4NM
	8JVesKXUZkD6+m1kfA5vdfLk3fX7IwviuEkBH94WoMabM=
Received: from xwm-TianYi510Pro-14IMB.. (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgD3Xy5BdGFqQfyBIg--.17302S2;
	Thu, 23 Jul 2026 09:54:10 +0800 (CST)
From: Weimin Xiong <xiongwm2026@163.com>
To: Jean-Philippe Brucker <jpb@kernel.org>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Cc: Xiong Weimin <xiongweimin@kylinos.cn>,
	Robin Murphy <robin.murphy@arm.com>,
	virtualization@lists.linux.dev,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] iommu/virtio: Probe error handling and event buffer validation
Date: Thu, 23 Jul 2026 09:54:06 +0800
Message-ID: <20260723095100.1-xiongweimin@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260716012157.88769-2-xiongwm2026@163.com>
References: <20260716012157.88769-2-xiongwm2026@163.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgD3Xy5BdGFqQfyBIg--.17302S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3Ww1fZry8XF15Xr47tF15twb_yoWfGw18pF
	Z8Ka95KrWDXr1xKan7J3yUuFWYvws7XF48urW5Xan5ur15CryqyF4a9ryjqw1ayrW8G3Wa
	vw1kXF1IkrWUurJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07juXd8UUUUU=
X-CM-SenderInfo: x0lr0wdzpsijqw6rljoofrz/xtbCzgIgr2phdEJk7AAA32

From: Xiong Weimin <xiongweimin@kylinos.cn>

On Thu, Jul 16, 2026 at 09:21:57AM +0800, Will Deacon wrote:
> It's really hard to keep track of all the patches you have on the list.
> Some of them are grouped in a series [1] with a dependency on another
> unmerged patch, others are in-reply to unordered patches [2], nothing is
> versioned and there are unlinked reply-to messages asking us to ignore
> things [3].
>
> Please can you group all related changes into a series, with a cover
> letter and then use versioning so that it's clear which is the latest
> revision?

I apologize for the confusion. I've now combined all related virtio-iommu
fixes into this single v2 series with a proper cover letter.

I've also addressed Sashiko's comments on the error handling in
viommu_probe() [4] - the v2 series sets vdev->priv early before creating
virtqueues and properly unwinds all resources on failure.

This series contains three fixes:

1. Set driver data before enabling virtqueues
   - Store vdev->priv before creating virtqueues so that the event virtqueue
     callback always sees initialized driver state when the device is made
     ready.

2. Handle iommu_device_register() failures
   - Properly propagate errors from iommu_device_register() and unwind sysfs
     entries, virtqueues, and driver data on failure.

3. Reject short event buffers
   - Check for exact buffer size match (len != sizeof(*evt)) instead of just
     rejecting oversized buffers (len > sizeof(*evt)).

Changes in v2:
- Combined all three fixes into a single series with cover letter
- Reordered patches to reflect dependencies
- Added err_clear_priv label for early error paths

Xiong Weimin (3):
  iommu/virtio: Set driver data before enabling virtqueues
  iommu/virtio: Handle iommu_device_register() failures
  iommu/virtio: Reject short event buffers

 drivers/iommu/virtio-iommu.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

-- 
2.43.0


From: Xiong Weimin <xiongweimin@kylinos.cn>
To: Jean-Philippe Brucker <jpb@kernel.org>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>,
	virtualization@lists.linux.dev,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] iommu/virtio: Set driver data before enabling virtqueues
Date: Thu, 23 Jul 2026 09:51:01 +0800
Message-ID: <20260723095101.1-xiongweimin@kylinos.cn>
References: <20260716012157.88769-2-xiongwm2026@163.com>
In-Reply-To: <20260716012157.88769-2-xiongwm2026@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Xiong Weimin <xiongweimin@kylinos.cn>

The event virtqueue callback retrieves the driver state through
vq->vdev->priv. viommu_probe() currently initializes that pointer only
after virtio_device_ready() and after the event queue is populated.

Store the driver data before creating the virtqueues so callbacks always
see initialized driver state once the device is made ready. Clear the
pointer again on probe failure.

Signed-off-by: Xiong Weimin <xiongweimin@kylinos.cn>
---
 drivers/iommu/virtio-iommu.c | 14 ++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 587fc1319..fb19d0bf4 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -1169,11 +1169,12 @@ static int viommu_probe(struct virtio_device *vdev)
 	ida_init(&viommu->domain_ids);
 	viommu->dev = dev;
 	viommu->vdev = vdev;
+	vdev->priv = viommu;
 	INIT_LIST_HEAD(&viommu->requests);
 
 	ret = viommu_init_vqs(viommu);
 	if (ret)
-		return ret;
+		goto err_clear_priv;
 
 	virtio_cread_le(vdev, struct virtio_iommu_config, page_size_mask,
 			&viommu->pgsize_bitmap);
@@ -1234,9 +1235,9 @@ static int viommu_probe(struct virtio_device *vdev)
 	if (ret)
 		goto err_free_vqs;
 
-	vdev->priv = viommu;
-
-	iommu_device_register(&viommu->iommu, &viommu_ops, parent_dev);
+	ret = iommu_device_register(&viommu->iommu, &viommu_ops, parent_dev);
+	if (ret)
+		goto err_free_sysfs;
 
 	dev_info(dev, "input address: %u bits\n",
 		 order_base_2(viommu->geometry.aperture_end));
@@ -1244,8 +1245,12 @@ static int viommu_probe(struct virtio_device *vdev)
 
 	return 0;
 
+err_free_sysfs:
+	iommu_device_sysfs_remove(&viommu->iommu);
 err_free_vqs:
 	vdev->config->del_vqs(vdev);
+err_clear_priv:
+	vdev->priv = NULL;
 
 	return ret;
 }
-- 
2.43.0


From: Xiong Weimin <xiongweimin@kylinos.cn>
To: Jean-Philippe Brucker <jpb@kernel.org>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>,
	virtualization@lists.linux.dev,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] iommu/virtio: Handle iommu_device_register() failures
Date: Thu, 23 Jul 2026 09:51:02 +0800
Message-ID: <20260723095102.1-xiongweimin@kylinos.cn>
References: <20260716012157.88769-2-xiongwm2026@163.com>
In-Reply-To: <20260716012157.88769-2-xiongwm2026@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Xiong Weimin <xiongweimin@kylinos.cn>

iommu_device_register() returns an error when the IOMMU core fails to
register the hardware instance or probe the buses. viommu_probe()
currently ignores that error and continues as if the device was
registered successfully.

Propagate the failure and unwind the sysfs entry and virtqueues that
were set up earlier. Clear the driver data on the error path as well,
since it is set before registration so bus probing can find the
virtio-IOMMU instance.

Reviewed-by: Will Deacon <will@kernel.org>
Signed-off-by: Xiong Weimin <xiongweimin@kylinos.cn>
---
 drivers/iommu/virtio-iommu.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 587fc1319..fb19d0bf4 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -1234,9 +1234,11 @@ static int viommu_probe(struct virtio_device *vdev)
 	if (ret)
 		goto err_free_vqs;
 
-	vdev->priv = viommu;
-
-	iommu_device_register(&viommu->iommu, &viommu_ops, parent_dev);
+	ret = iommu_device_register(&viommu->iommu, &viommu_ops, parent_dev);
+	if (ret)
+		goto err_free_sysfs;
 
 	dev_info(dev, "input address: %u bits\n",
 		 order_base_2(viommu->geometry.aperture_end));
@@ -1244,8 +1246,12 @@ static int viommu_probe(struct virtio_device *vdev)
 
 	return 0;
 
+err_free_sysfs:
+	iommu_device_sysfs_remove(&viommu->iommu);
 err_free_vqs:
 	vdev->config->del_vqs(vdev);
+err_clear_priv:
+	vdev->priv = NULL;
 
 	return ret;
 }
-- 
2.43.0


From: Xiong Weimin <xiongweimin@kylinos.cn>
To: Jean-Philippe Brucker <jpb@kernel.org>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>,
	virtualization@lists.linux.dev,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] iommu/virtio: Reject short event buffers
Date: Thu, 23 Jul 2026 09:51:03 +0800
Message-ID: <20260723095103.1-xiongweimin@kylinos.cn>
References: <20260716012157.88769-2-xiongwm2026@163.com>
In-Reply-To: <20260716012157.88769-2-xiongwm2026@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Xiong Weimin <xiongweimin@kylinos.cn>

viommu_event_handler() only rejects event buffers that are larger than
struct viommu_event. A short buffer is also invalid, but the handler
would still read evt->head and, for fault events, the rest of evt->fault.

Require the used length to match the event buffer size before looking at
the event contents.

Signed-off-by: Xiong Weimin <xiongweimin@kylinos.cn>
---
 drivers/iommu/virtio-iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 587fc1319..fb19d0bf4 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -635,7 +635,7 @@ static void viommu_event_handler(struct virtqueue *vq)
 	struct viommu_dev *viommu = vq->vdev->priv;
 
 	while ((evt = virtqueue_get_buf(vq, &len)) != NULL) {
-		if (len > sizeof(*evt)) {
+		if (len != sizeof(*evt)) {
 			dev_err(viommu->dev,
 				"invalid event buffer (len %u != %zu)\n",
 				len, sizeof(*evt));
-- 
2.43.0

