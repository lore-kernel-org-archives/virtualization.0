Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2541D283FDD;
	Thu, 23 Jul 2026 01:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784771676; cv=none; b=TJQDBtp3uGq/FOy+D1EfY+rsxuhvWMTNwIG589MBm++R19M2LjvnEz8fBCWy66Vsx4RfbR6xXSLL/yWkSJ8A0Bfut/5vqOgD7ufWgqXXWrCBfC8EWOkfTQA7eh4YSHLhEwkEV9LBxtvqK78q4JIHXNJngFf4UICXcW9GLWA7/NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784771676; c=relaxed/simple;
	bh=SC0rg+x03vywBcBZlzeedgSQzH5J/lge60v4ABi6CrA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e1VWXQPRldA/1LpPacyQGUnB/W1gV3XvvD8gb1Jla/7WvKvqftqJce89P6HZtnPTpYV9DYdIg+Khs4rCQGjucMJUXS0elO0jwT2M1SZjWOKV2wLSvH8Wo5kK1/Q9439PIK7xHP+W1Jmfu4LE7JGuouUgkPlkmXSZiYYUE0KLr1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=iPOQeVMy; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="iPOQeVMy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version:
	Content-Type; bh=paZdsCGqBdUsjK0gMnjdeBOx6BhxhyfrY1AIHZrqBdM=;
	b=iPOQeVMyZC9MECl8WbSyWi4UmbxVwbIOu77LPgz03ldLBp72H1w8ISWhA7pVig
	vzFkmEIA7h6/g7aSBv02VEjbmfT7PKDZWUfuDJbOUArlO4CkbeqEst8QV53JP0It
	8li0SZrY1pueW+6kdciskaVxWqHIrgYhrKHXrtYHV1sow=
Received: from xwm-TianYi510Pro-14IMB.. (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgD3Xy5BdGFqQfyBIg--.17302S5;
	Thu, 23 Jul 2026 09:54:11 +0800 (CST)
From: Weimin Xiong <xiongwm2026@163.com>
To: Jean-Philippe Brucker <jpb@kernel.org>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Cc: Xiong Weimin <xiongweimin@kylinos.cn>,
	Robin Murphy <robin.murphy@arm.com>,
	virtualization@lists.linux.dev,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] iommu/virtio: Reject short event buffers
Date: Thu, 23 Jul 2026 09:54:09 +0800
Message-ID: <20260723095103.1-xiongweimin@kylinos.cn>
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
X-CM-TRANSID:PygvCgD3Xy5BdGFqQfyBIg--.17302S5
X-Coremail-Antispam: 1Uf129KBjvdXoWrZw1fCF1xGr1kCw1kJr1fWFg_yoWkJFc_ur
	yvvr9rJr1UZFZ0yr4UKryIgr9Ikay5Zrn3uFWFgrWrJ348Xwn5Cryvqr1kKFW7Wr4UKFnx
	tws0y3WfXryfWjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU5Wa0PUUUUU==
X-CM-SenderInfo: x0lr0wdzpsijqw6rljoofrz/xtbC8AMgr2phdEPWAQAA3X

From: Xiong Weimin <xiongweimin@kylinos.cn>

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

