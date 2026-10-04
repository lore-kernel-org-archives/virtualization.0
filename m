Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B513AFD0A;
	Sun,  4 Oct 2026 13:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791118894; cv=none; b=NcPS6QpctQRV+yWr1U6X/a7cAajL0BwrP9OCRRARv4/Qc4I01fSSWyVkoyB+ELeBQ16sYcwavzfuBS9y0zO81YmKtASz9B6CwMhOhbc/KpKEaplq+ncLvkYDxnIlaGJDfqwPF0vr0gv4xCaYsmRJOU5u2AK6CSId8UxprF37ik8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791118894; c=relaxed/simple;
	bh=OLm8pvvaW1sQ9zo1tojzShZIchnfCb+HDeNmvS5Cn4Y=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=EVzBP6NAx5htzkKN020zV4/gQLxRBGiHAVTq/KQlnyGPV3O+RObnYvkstz+GHZb+iySXb2vVQFKbcrtAZERJy5HJhMYJxCtyRk7iISdUAZV59MsnKor7kDOeBdJ/GMdZ5+Y4m38ZJK3ll458bIAdeht5EXVsLcoXRbg82T44zVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=MjbyWZTQ; arc=none smtp.client-ip=162.62.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="MjbyWZTQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1791118887; bh=qdTozFLv9mjel7LKU3NvX5BPQwY50Wo8yZpFEcVIaXo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MjbyWZTQRNtON02po2/XUgZoMbxNM8KRJKMN8hbWrBXncM5MqnQbxoSg0qWiTTXkv
	 TMTWZ8EXXgp1c0ik44PWaUsz/2jUnWHsKTjKuTnj/fMC/UqmhX9tIOXX9UkCbogSLu
	 e5GYCT74DeAT2YQ5BzTvfhRPW/L2tGSzMHF0c1K4=
Received: from xiuos ([2001:da8:201:1175:6e92:bfff:fe3b:37c3])
	by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
	id 4EAF2BA; Sun, 04 Oct 2026 21:01:14 +0800
X-QQ-mid: xmsmtpt1791118885tsccphgng
Message-ID: <tencent_E9DADACA296EBD4DBF63DB0F072B37DDCC07@qq.com>
X-QQ-XMAILINFO: OVFdYp27KdlJELpXMf14EcCQbRyDheKqSgOZK6zMvC0reuT1YmlDcoCnFsS5mw
	 qZm8JS5FkGTabHHKF+JqwFXojke4DuICUqHlxXbEVPTp8FzsKs3jIjZR/bJTWRFinA4+bASLtFQI
	 h4b3tDeFJhVN2wK32yaJ5MgTB3Iu904p8M9PR2vGt5v0t6WYFBAuOueyAaJfZRtexrdsy2H7sL7J
	 jqSCb80YJHFF7M6SPHQKJStWpOgrTG201UzM/EqKXiBGfaI5i0AEGCxVwGkmZNXTfqr3LPlHKQRM
	 +aN7FOADrYOyrMEJkYdzdnt+kwnraKmsDB0WdttN+UzJqZw4bogvo7qlObDy3G11K2S8vVLikjnu
	 70Vc7hB74mkkuwHMU7QG0pRjeNbFxr/xNjrgDihigm3NuiFdNHICMIlKKTGvoB6fO+pIxR0S+I2c
	 SlEJlAKhIxJLsnLB6RrAW1M5YitdW0ByHOficTheHvlRIXew+hQ4UtFtYEvwP1ZlslwlYDQE8k13
	 xDkdlui8NmAwxcfNeA6AlIwyYBt+dyzNOcEMqFI+DOL3JQUt64qz6nxqbnSWyTNNSNHkYb58tOCu
	 /Oki/lQSaqCxJ6/b53ipHMBBp0wxEedOQ7ZZng92F5ar/BcjR1FGGTXNCZX5h/YTKDvIcDeo7acC
	 nYGOsQ3Oskmihnruf6Say3MQYnCPGwoFWz3u2Uu+021oXvzRpkpJ2I3K/E2ZnNlgb+7WH1PJdenp
	 FzPKjJnCt8WwvONs1+iCqmEay2iOXRkw9ysXerDTmH78gx3Vga/QNy8Cl52hKlz3Z0S+fppxNTe5
	 SU7GmsjZtZckJ3djZF9gku2gEaJpGAuLbb+E09kD7RxoxjbH8LM8jrRftaPcvJmCLbRlL4EeEfS3
	 afAUxHEJ09pyF2BG52h3SqARTz+NVsxeCL3CDLT4w9ttI3ml9Ged03eyfAAsgZRjJhTPnaR3ZTId
	 QvydSe0oAkucqYwcnNnO8QGF/ye/AovzyzTo78UAuwadszCJjbdtCaWBW59HDZZ0KYj+q+AlEjYa
	 UtHzga7h86x7qCjVQIbzFRjX/Gm+OlBBbGUbNiMhD5+rdtvCObFmsOAEX2aqw7H4JrOOBEbI53cO
	 dLZW8PT6X4yAPGkaX1C4nYA4tYyyyGlpD15heud0zBwCsCHeCV2d6KmoO7HxUNzXCJsFKy0sQBQS
	 vjCjPVfg7+KLnioIovnJD1R8jpdkwvxsnO8ko=
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
From: Anlai Lu <agicy@qq.com>
To: Jean-Philippe Brucker <jpb@kernel.org>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>,
	virtualization@lists.linux.dev,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Anlai Lu <agicy@qq.com>
Subject: [PATCH v2 3/6] iommu/virtio: allocate the UNMAP request with the mapping
Date: Sun,  4 Oct 2026 13:01:10 +0000
X-OQ-MSGID: <20261004130113.3225005-3-agicy@qq.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <tencent_D757B544955DDC509B5DC7161F425620BA08@qq.com>
References: <tencent_D757B544955DDC509B5DC7161F425620BA08@qq.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The iommu core states the contract plainly (iommufd pages.c): a driver
may not fail unmap for reasons beyond bad arguments, and in particular
may not allocate on the unmap path, because the caller may free the
memory as soon as unmap returns. viommu_del_mappings() still allocated
the UNMAP request there, so a forced allocation failure left the device
mapping a page the driver had already released, while the caller was told
nothing.

Allocate that request object with the mapping instead - on the map path,
which is allowed to fail and reports the failure to the caller that is
mapping - and free it with the mapping when no UNMAP is sent: the unmap
path then only fills in and queues a request. Measured with a fault
injected into that allocation (failslab, on the fault-injection harness
this work used): the unpatched driver returns success for a re-map of the
same IOVA while the device still translates it to the freed page, proven
with a real DMA through the QEMU iommu-testdev; with this patch the same
scenario reports no such case in any round and the DMA lands on the new
page. The unmap path allocates nothing afterwards, and the device sees
the same request stream.

Fixes: edcd69ab9a32 ("iommu: Add virtio-iommu driver")
Signed-off-by: Anlai Lu <agicy@qq.com>
---
 drivers/iommu/virtio-iommu.c | 101 +++++++++++++++++++++++++++++------
 1 file changed, 85 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index bb328f29ba71..f886941d8f3b 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -54,10 +54,18 @@ struct viommu_dev {
 	u32				probe_size;
 };
 
+struct viommu_request;
+
 struct viommu_mapping {
 	phys_addr_t			paddr;
 	struct interval_tree_node	iova;
 	u32				flags;
+	/*
+	 * The request that will carry this mapping's UNMAP, allocated with the
+	 * mapping: the unmap path must not allocate, since the caller may free
+	 * the memory as soon as it returns (see iommu_unmap_nofail()).
+	 */
+	struct viommu_request		*unmap_req;
 };
 
 struct viommu_domain {
@@ -296,6 +304,29 @@ static int viommu_add_req(struct viommu_dev *viommu, void *buf, size_t len)
 	return ret;
 }
 
+/* Queue a request whose object was allocated earlier (the unmap path) */
+static int viommu_queue_prealloc_req(struct viommu_dev *viommu,
+				     struct viommu_request *req, void *buf,
+				     size_t len)
+{
+	off_t write_offset;
+	unsigned long flags;
+	int ret;
+
+	write_offset = viommu_get_write_desc_offset(viommu, buf, len);
+	if (write_offset <= 0)
+		return -EINVAL;
+
+	spin_lock_irqsave(&viommu->request_lock, flags);
+	req->len = len;
+	req->writeback = NULL;
+	memcpy(req->buf, buf, write_offset);
+	ret = __viommu_queue_req(viommu, req, write_offset);
+	spin_unlock_irqrestore(&viommu->request_lock, flags);
+
+	return ret;
+}
+
 /*
  * Send a request and wait for it to complete. Return the request status (as an
  * errno)
@@ -360,6 +391,19 @@ static int viommu_add_mapping(struct viommu_domain *vdomain, u64 iova, u64 end,
 	if (!mapping)
 		return -ENOMEM;
 
+	/*
+	 * The UNMAP request object, allocated here: the unmap path may not
+	 * allocate (iommu_unmap_nofail()), so the failure is paid for by the
+	 * caller that is mapping, which is allowed to fail.
+	 */
+	mapping->unmap_req = kzalloc_flex(*mapping->unmap_req, buf,
+					  sizeof(struct virtio_iommu_req_unmap),
+					  GFP_ATOMIC);
+	if (!mapping->unmap_req) {
+		kfree(mapping);
+		return -ENOMEM;
+	}
+
 	mapping->paddr		= paddr;
 	mapping->iova.start	= iova;
 	mapping->iova.last	= end;
@@ -387,6 +431,7 @@ static int viommu_add_mapping(struct viommu_domain *vdomain, u64 iova, u64 end,
 		if (ret) {
 			interval_tree_remove(&mapping->iova, &vdomain->mappings);
 			spin_unlock_irqrestore(&vdomain->mappings_lock, irqflags);
+			kfree(mapping->unmap_req);
 			kfree(mapping);
 			return ret;
 		}
@@ -414,7 +459,7 @@ static size_t viommu_del_mappings(struct viommu_domain *vdomain,
 {
 	size_t unmapped = 0;
 	unsigned long flags;
-	bool spanning = false;
+	struct viommu_request *span_req = NULL;
 	u64 span_start = 0, span_end = 0;
 	struct interval_tree_node *node, *next;
 
@@ -445,48 +490,72 @@ static size_t viommu_del_mappings(struct viommu_domain *vdomain,
 		 * range is the mappings' own: the caller's requested range can
 		 * begin or end inside another mapping and would then invalidate
 		 * nothing at all, and a range spanning a gap would drop a
-		 * mapping that is not being removed.
+		 * mapping that is not being removed.  The request object was
+		 * allocated with the first mapping of the run, so this cannot
+		 * fail for lack of memory.
 		 */
 		if (queue_unmap && vdomain->nr_endpoints) {
-			if (spanning && mapping->iova.start == span_end + 1) {
+			if (span_req && mapping->iova.start == span_end + 1) {
 				span_end = mapping->iova.last;
+				/* this mapping's object is not needed */
+				kfree(mapping->unmap_req);
+				mapping->unmap_req = NULL;
 			} else {
-				if (spanning) {
-					struct virtio_iommu_req_unmap unmap = {
-						.head.type	= VIRTIO_IOMMU_T_UNMAP,
-						.domain		= cpu_to_le32(vdomain->id),
-						.virt_start	= cpu_to_le64(span_start),
-						.virt_end	= cpu_to_le64(span_end),
-					};
-
-					if (viommu_add_req(vdomain->viommu, &unmap,
-							   sizeof(unmap))) {
+				struct virtio_iommu_req_unmap unmap = {
+					.head.type	= VIRTIO_IOMMU_T_UNMAP,
+					.domain		= cpu_to_le32(vdomain->id),
+					.virt_start	= cpu_to_le64(span_start),
+					.virt_end	= cpu_to_le64(span_end),
+				};
+
+				if (span_req) {
+					struct viommu_request *req = span_req;
+
+					span_req = NULL;
+					if (viommu_queue_prealloc_req(vdomain->viommu,
+								      req, &unmap,
+								      sizeof(unmap))) {
+						/*
+						 * The request object was
+						 * already there, so this is
+						 * not an allocation failure:
+						 * the run is not unmapped on
+						 * the device, and the caller
+						 * is told so.
+						 */
+						kfree(req);
 						unmapped -= span_end - span_start + 1;
 						dev_warn_ratelimited(vdomain->viommu->dev,
 								     "could not queue an unmap\n");
 						goto out;
 					}
 				}
-				spanning = true;
+				span_req = mapping->unmap_req;
 				span_start = mapping->iova.start;
 				span_end = mapping->iova.last;
+				mapping->unmap_req = NULL;
 			}
 		}
 
 		interval_tree_remove(node, &vdomain->mappings);
+		kfree(mapping->unmap_req);
 		kfree(mapping);
 		unmapped += size;
 	}
 
-	if (spanning) {
+	if (span_req) {
 		struct virtio_iommu_req_unmap unmap = {
 			.head.type	= VIRTIO_IOMMU_T_UNMAP,
 			.domain		= cpu_to_le32(vdomain->id),
 			.virt_start	= cpu_to_le64(span_start),
 			.virt_end	= cpu_to_le64(span_end),
 		};
+		struct viommu_request *req = span_req;
 
-		if (viommu_add_req(vdomain->viommu, &unmap, sizeof(unmap))) {
+		span_req = NULL;
+		if (viommu_queue_prealloc_req(vdomain->viommu, req, &unmap,
+					      sizeof(unmap))) {
+			kfree(req);
 			unmapped -= span_end - span_start + 1;
 			dev_warn_ratelimited(vdomain->viommu->dev,
 					     "could not queue an unmap\n");
-- 
2.55.0

