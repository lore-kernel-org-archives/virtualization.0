Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11429429036;
	Sun,  4 Oct 2026 11:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791115059; cv=none; b=OZw3RPFHS8bQKqupvkvZnLuETu5bbG5CJyfB2fufqY8/QvWsV/KwwA8K2y/zH7U7gNulSomV2dXs1ngsU2RSNJ278F4riGBTmpi492NteKsaqxZaMD6KrtN+a8tbds0mpsi2DAxZzl14lCUjhpyjFWSD0zGvNmRh1YV9gvgY5vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791115059; c=relaxed/simple;
	bh=ewcgvO+MUuc9ETZGburdNnPv5NcO1npTSXN2vD2CCx0=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=Pw0IqLjXyGdL/vQt/a/DhoGwzAbm6i1z/FFkZFOftbH1rqP+EnZJJ81j45ONRlGj1MLy7FaaRuGT9Lzjt+qxgMZ6rW6OBdU3aELFMinrsDEq0/mIuLfzQz57z3CK4tkGlvu1jFS82BAc8Y6duxIP9Q14vLSp0EBb29ZZPhy06Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=M0yExTn/; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="M0yExTn/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1791115043; bh=s1+Dt+EW7DAeK4ciPFuAH6sY0Tl27Q3OzPmrBNCQHWw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=M0yExTn/02BvQV2EBqAuf3ymm/LxIICS87lHtPKNgaCk3vzMV9rCzxNrLuaa1qu8w
	 I7xtPHYdZwbVAQPGZwMXyAb3StM0HxBIWf90ADVbFGZ5Dv98FJQzlbNsZYe/9cHC7P
	 f3gSHY+xZlEqM+hTbDHyTkga+eReC4tOkhiwDE5E=
Received: from xiuos ([2001:da8:201:1175:6e92:bfff:fe3b:37c3])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id E4D020DE; Sun, 04 Oct 2026 19:57:13 +0800
X-QQ-mid: xmsmtpt1791115040t2jdeabym
Message-ID: <tencent_C11DBB7E9C5985EA4AD5BE569E70336F460A@qq.com>
X-QQ-XMAILINFO: NGgULbyAgjAd/VUkYoMiWMJAdND2Sr8JBJdbFxrLDwFhFs/B+XJocZZKM5Q4q5
	 YJXo2UTGIxiB4/O47v4jsdUu41JInYHp+e3ijiUyynNrabjPU6lFL70ikSO9lUgh36xqnfePCda1
	 RahGqXxgtAd7wymfNu2Vy8pK5nJ/OFns6ylhhYOeTDRi4mH6GRQjHw6tLrj32uhChfck6UWPve6M
	 dCnwZ0MxVoyJBNoLqjWbXPB/A7MAVvWb+IeQLvAglQiYPcV598gNygaPOHXddmcFM/HZsFou6krX
	 Fzo3gk5TKhHf9bR+fb8JsXg4bCzkes302+jp78tem+S/gQfcQNNVmsZ4SDiBKTvUQsfV7sG8R2zO
	 6UlyLzbSWhv+ctqp3E0RVrVlmO5HFAcDTQTwX/B61HZoREV0NC010aU/rGbFgpvIFEEPpEYCb9m/
	 ddrW3XI0ZfuW2n59u4aJ/fAPV/zA4z0f1g+7F6RtQtgWo32bCBe6NSRiksjzXxK9lDOkrVlRjflF
	 1/ezBThsm46Uaq7gbRONzw5WKs3MdmVMirPHhAV7WOWTtsRnGrPmc/JukAwH1hUHeDzZLjvE58sH
	 oNULARrzl8gKkdVAARBYGCUck4vSvG2Oju8QqI7UQuKdK0tsn9A1iUFeNy3CLz6tkL24iMufZxiW
	 kO6/gbfqX0E4ZkZRd5HJ+aKGG2TpCyTid9MzDVCxBMq2vbqMZY6hhc9Dk9AA4E8lEpRwLG+UeVRQ
	 9c6J/z+6PjDlcKLj9Cu0S3CBv7vRtvn7whvJl5rupN5bTR4Jg4vFp9gt+Jgpl1c/GCzwzq80gG1C
	 tfHNq0QlAl+Qlqnp5MZlPTy5krOrqyxSRvziqKjPTV+t86JsKy7RoMsUuuGJfx1wG1Ts2pyYG4FV
	 sz4xX/4p/KAK+85OCCax9RaVzBLQ9Gtd4HfDM11Kzc6G2bVVkJgM8qy2kIa2NBoMpDaZtcK2MnGM
	 u10BNtXPgY44r6qW3lVudli5IrtJVhfJ5V99r5Zk6BcMM9KJM0D2MsuyA3jgBC6vBAa0wMT8NTDe
	 yJow5p87hYKROc0DxGGjj5VgslVxKR4u4CXEIoVcWkwu6jmJU9XyrSkJYwFagVEHuNTu+KmZ4Mku
	 RJ6lk4hF84KJ+24IygcEr7YoM3YDPlRTdVJBerkvmvC1YhXQIQfaMhAnOWl8aLC0aqio/0
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
From: Anlai Lu <agicy@qq.com>
To: Jean-Philippe Brucker <jpb@kernel.org>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>,
	virtualization@lists.linux.dev,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Anlai Lu <agicy@qq.com>
Subject: [PATCH 2/6] iommu/virtio: queue an UNMAP for every removed mapping
Date: Sun,  4 Oct 2026 11:57:05 +0000
X-OQ-MSGID: <20261004115709.3181856-2-agicy@qq.com>
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

viommu_unmap_pages() removed whole mappings from the tree and then, with
mappings_lock dropped, queued a single UNMAP built from the range the
caller asked for. Both halves are wrong in the direction the device's
semantics are strict about: a device must not split a mapping, so the
driver removes whole mappings - and an UNMAP whose range begins or ends
inside another mapping invalidates nothing there, leaving the device
mapping memory the driver has released; and between the removal and the
queueing a concurrent map_pages() of the same range can put its MAP in
front of the UNMAP.

Queue the UNMAPs in the critical section that removes the mappings, one
request per contiguous run of removed mappings, covering exactly the
mappings' own ranges: a run's mappings are removed together and its
request covers all of them, nothing else. If a request cannot be queued,
the mapping being examined stays in the tree and the walk stops there,
and the run whose request could not be queued is not reported as
unmapped. That is not an atomic rollback: the run's mappings were already
removed from the tree and freed, and the caller is told the bytes that
really were unmapped, not that the whole range failed to unmap. The
request itself is still allocated on the unmap path here; the next patch
moves that allocation to the map path, where it is allowed to fail.

Fixes: edcd69ab9a32 ("iommu: Add virtio-iommu driver")
Signed-off-by: Anlai Lu <agicy@qq.com>
---
 drivers/iommu/virtio-iommu.c | 97 ++++++++++++++++++++++++++----------
 1 file changed, 71 insertions(+), 26 deletions(-)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 0e5fbdfa8ef4..0e17c1b22483 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -402,20 +402,28 @@ static int viommu_add_mapping(struct viommu_domain *vdomain, u64 iova, u64 end,
  * @vdomain: the domain
  * @iova: start of the range
  * @end: end of the range
+ * @queue_unmap: queue an UNMAP for each run of removed mappings; false when
+ *               the device has already dropped the mappings
  *
- * On success, returns the number of unmapped bytes
+ * Returns the number of bytes unmapped, i.e. the mappings removed from the
+ * tree.  A run whose UNMAP could not be queued is not counted, and the walk
+ * stops there: later mappings stay in the tree.
  */
 static size_t viommu_del_mappings(struct viommu_domain *vdomain,
-				  u64 iova, u64 end)
+				  u64 iova, u64 end, bool queue_unmap)
 {
 	size_t unmapped = 0;
 	unsigned long flags;
-	struct viommu_mapping *mapping = NULL;
+	bool spanning = false;
+	u64 span_start = 0, span_end = 0;
 	struct interval_tree_node *node, *next;
 
 	spin_lock_irqsave(&vdomain->mappings_lock, flags);
 	next = interval_tree_iter_first(&vdomain->mappings, iova, end);
 	while (next) {
+		struct viommu_mapping *mapping;
+		size_t size;
+
 		node = next;
 		mapping = container_of(node, struct viommu_mapping, iova);
 		next = interval_tree_iter_next(node, iova, end);
@@ -428,13 +436,69 @@ static size_t viommu_del_mappings(struct viommu_domain *vdomain,
 		 * Virtio-iommu doesn't allow UNMAP to split a mapping created
 		 * with a single MAP request, so remove the full mapping.
 		 */
-		unmapped += mapping->iova.last - mapping->iova.start + 1;
+		size = mapping->iova.last - mapping->iova.start + 1;
+
+		/*
+		 * Queue one UNMAP per contiguous run of removed mappings, in the
+		 * same critical section that removes them, so that a concurrent
+		 * map of the same range cannot put its MAP in front of it.  The
+		 * range is the mappings' own: the caller's requested range can
+		 * begin or end inside another mapping and would then invalidate
+		 * nothing at all, and a range spanning a gap would drop a
+		 * mapping that is not being removed.
+		 */
+		if (queue_unmap && vdomain->nr_endpoints) {
+			if (spanning && mapping->iova.start == span_end + 1) {
+				span_end = mapping->iova.last;
+			} else {
+				if (spanning) {
+					struct virtio_iommu_req_unmap unmap = {
+						.head.type	= VIRTIO_IOMMU_T_UNMAP,
+						.domain		= cpu_to_le32(vdomain->id),
+						.virt_start	= cpu_to_le64(span_start),
+						.virt_end	= cpu_to_le64(span_end),
+					};
+
+					if (viommu_add_req(vdomain->viommu, &unmap,
+							   sizeof(unmap))) {
+						unmapped -= span_end - span_start + 1;
+						dev_warn_ratelimited(vdomain->viommu->dev,
+								     "could not queue an unmap\n");
+						goto out;
+					}
+				}
+				spanning = true;
+				span_start = mapping->iova.start;
+				span_end = mapping->iova.last;
+			}
+		}
 
 		interval_tree_remove(node, &vdomain->mappings);
 		kfree(mapping);
+		unmapped += size;
+	}
+
+	if (spanning) {
+		struct virtio_iommu_req_unmap unmap = {
+			.head.type	= VIRTIO_IOMMU_T_UNMAP,
+			.domain		= cpu_to_le32(vdomain->id),
+			.virt_start	= cpu_to_le64(span_start),
+			.virt_end	= cpu_to_le64(span_end),
+		};
+
+		if (viommu_add_req(vdomain->viommu, &unmap, sizeof(unmap))) {
+			unmapped -= span_end - span_start + 1;
+			dev_warn_ratelimited(vdomain->viommu->dev,
+					     "could not queue an unmap\n");
+		}
 	}
+out:
 	spin_unlock_irqrestore(&vdomain->mappings_lock, flags);
 
+	/*
+	 * What was really unmapped: a run whose UNMAP could not be queued is not
+	 * reported as one.
+	 */
 	return unmapped;
 }
 
@@ -483,7 +547,7 @@ static int viommu_domain_map_identity(struct viommu_endpoint *vdev,
 	return 0;
 
 err_unmap:
-	viommu_del_mappings(vdomain, 0, iova);
+	viommu_del_mappings(vdomain, 0, iova, false);
 	return ret;
 }
 
@@ -757,7 +821,7 @@ static void viommu_domain_free(struct iommu_domain *domain)
 	struct viommu_domain *vdomain = to_viommu_domain(domain);
 
 	/* Free all remaining mappings */
-	viommu_del_mappings(vdomain, 0, ULLONG_MAX);
+	viommu_del_mappings(vdomain, 0, ULLONG_MAX, false);
 
 	if (vdomain->viommu)
 		ida_free(&vdomain->viommu->domain_ids, vdomain->id);
@@ -1075,29 +1139,10 @@ static size_t viommu_unmap_pages(struct iommu_domain *domain, unsigned long iova
 				 size_t pgsize, size_t pgcount,
 				 struct iommu_iotlb_gather *gather)
 {
-	int ret = 0;
-	size_t unmapped;
-	struct virtio_iommu_req_unmap unmap;
 	struct viommu_domain *vdomain = to_viommu_domain(domain);
 	size_t size = pgsize * pgcount;
 
-	unmapped = viommu_del_mappings(vdomain, iova, iova + size - 1);
-	if (unmapped < size)
-		return 0;
-
-	/* Device already removed all mappings after detach. */
-	if (!vdomain->nr_endpoints)
-		return unmapped;
-
-	unmap = (struct virtio_iommu_req_unmap) {
-		.head.type	= VIRTIO_IOMMU_T_UNMAP,
-		.domain		= cpu_to_le32(vdomain->id),
-		.virt_start	= cpu_to_le64(iova),
-		.virt_end	= cpu_to_le64(iova + unmapped - 1),
-	};
-
-	ret = viommu_add_req(vdomain->viommu, &unmap, sizeof(unmap));
-	return ret ? 0 : unmapped;
+	return viommu_del_mappings(vdomain, iova, iova + size - 1, true);
 }
 
 static phys_addr_t viommu_iova_to_phys(struct iommu_domain *domain,
-- 
2.55.0

