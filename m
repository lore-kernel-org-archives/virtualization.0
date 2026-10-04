Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89DEB420889;
	Sun,  4 Oct 2026 11:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791115051; cv=none; b=uLT8SR96LCwrUBHQGFay0Nv+qeRFWggDY21ub5nH9E3MdPiwIUNxmaxLNUvX1V4wVmiTqdqeWJUuucahGBJ/uIRtzCQBs3o9GTNmTck9VXGC30HW+Op4t1jZVy01kdWCgGQ5r3Coa4fsJkXBxc0NFf2ChPdm2+S8xs8Dqz14pKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791115051; c=relaxed/simple;
	bh=wpL3JWm5pG7MdHyx7ItDJkTZ384sIjrII0N2qaa7c4k=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=s1XnFM+sn7cB2ypwCGOqfipwu5Bw/gvcTioRhUzucSvJIY8nBKukdD1BH083NKAVau0QaBuXt0whYqABW539iv/cBC9IBuwEHrqg6wLf9VdarQGHeiOeho6dHMUrbwU7zDCfWzWM/MGsAe7YZThQHFbUya8nvjkpPVnJaagUM90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=EgrfZxsc; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="EgrfZxsc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1791115044; bh=MxDZUa5pnVG7TpiXlSEdt5nYQFecU7cbX9NiY6FMDzs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EgrfZxscGxFR0KGYz/1FvFnc9ljYLjTF+nHzuzMzZJRcxuKB3dSk1JocAJNTYGUbo
	 kuC1QAdaqEp1U4BntFjOQ1MkmpsrGCqsmOpt7TN7Lebkx8CPseMZ9XUJZWkKxgH08V
	 H8blz00eTbsI8Zll84bTuLoAg2oFyxs4slswA28Q=
Received: from xiuos ([2001:da8:201:1175:6e92:bfff:fe3b:37c3])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id E4D020DE; Sun, 04 Oct 2026 19:57:13 +0800
X-QQ-mid: xmsmtpt1791115042tyjr4qwk7
Message-ID: <tencent_9CB84937FB8F833E78AD4675C36B512A5309@qq.com>
X-QQ-XMAILINFO: ONXjbYTFhCz0m2bOhV5yITHo0Of601h8c7LJQeZonpT4qpaena+PE+UgcyoMsW
	 v2SsIUZjMlIkgtvcGKFjHExggB1KWf0zvAXxjfwxKsCvdulrg0nIDep13fko4xQ+SaStNOw6Sr2X
	 hH+uz0DYc5Uqs4eQmY75TDsOIoF4kwoxCztaaRnryTK/KVroeey7vWSN9lom+7zZNfO2IjqXV2uq
	 gD0pv3Vz368ZrEM0Mg3v68+bj+a5DMYjgLngn5y3zLSwNi/Xd9b0pMxjUGqoQM3a3kLLCChQkha4
	 1GGz2OtwpF484bVEgN/54RJ0rl+ZpcbfrSxwR8jlBahECWK40l2gqsVNJZXukpTDMxluOYm2e837
	 kDq/8rcrwsjeHJ5jxD6HS+DcD2c7PV6gyAZoI/NOse5maXbPo2AtiZdC0+k9ff/5GE7bKnkDrYEa
	 XKHkD66fa4R6Cjq9mUtteOx+61NAf6kHIObM9NkdZms9AUIbgA9Cn1RYOa36JKZcbIC5ijbHGlOO
	 70LNU1JcftsV+9r5ySCMpTJUwXShmZ2w2N4uTyiLRgrVvQr1VlLJpY7KNgVZsKov1rfXPfWpsRom
	 HobRijaUu7GTWxqXg8sX7aAk+vMFgPxwIUUfT8SWhbiLes/U4NUuLZi7LiGNMp7ynMVO2GsE7Qzn
	 qJYLeO+JZ+Ml0XmmEIeWxBziJt4SSqTgeb8//+ayMijA8wM9Tu+2ZrFZK1JtH/DIBfVqPFNm+Dtx
	 WSHnB62aJgBhEbW3fwHySlyQnZsj8GWweZhpphZUsPmASsDcHS7R5BAEICcPJfKXkAYjuOhtP32+
	 Qs9iliFDZjIzcmNjVMu3HwYDf9SoSX2+wdaHJ9eNcBccokB6bPtIGEnGQQExXOEcBVntqnP5Giva
	 iL5AqvHZ4KaX7aHTjV4/PuqSEJhyBHu8iqZQsXOvNo2+aJEEW547ENqMvMBm8Q2HQ7FjeTCulSzK
	 HqhVfXerC2ViIpOQYcuoxwc2pL0neAFk1pdvJWGqhx1i8FoT51YPPTdZxya3rO506SIm4T8Z+aXh
	 +mgXMNCGqmjIWlPLCJWPFlcYv0pNK4cLsVM6MYIajtdHU8sGTufuJU8gJlYZpjI9CeEsmW85fNPN
	 4scZmJhLA+nH7KYQf/VLu//nEWaA==
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
From: Anlai Lu <agicy@qq.com>
To: Jean-Philippe Brucker <jpb@kernel.org>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>,
	virtualization@lists.linux.dev,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Anlai Lu <agicy@qq.com>
Subject: [PATCH 3/6] iommu/virtio: allocate the UNMAP request with the mapping
Date: Sun,  4 Oct 2026 11:57:06 +0000
X-OQ-MSGID: <20261004115709.3181856-3-agicy@qq.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <tencent_85AC6E749F6A912B7BB9FF360F8ECB3F5C09@qq.com>
References: <tencent_85AC6E749F6A912B7BB9FF360F8ECB3F5C09@qq.com>
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
index 0e17c1b22483..1a4366458751 100644
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

