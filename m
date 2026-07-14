Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CF23A0E97;
	Tue, 14 Jul 2026 02:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783997988; cv=none; b=LRRVT+Z93a9mNMW42kDi1hY/ulWmzKv0Uwoe/5H01/sK99hNnRXmuuazu4MYkGiYePhNUNRd2kFYTIlwuHLNW1w2NBDeRdhX9gNvLDl+CmQt9rJz4ucFcVKwFTnpi9XOgAS1YFZgiP3VV609pqiKZFClhh6/tGRN3Wv8egVQZM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783997988; c=relaxed/simple;
	bh=rVhO9deu1bdk3yb64ULoUPj80nzZOzHqnrMXjqgLQVk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gexo29owsSyjFHF3Z29Dkx0z7JnsodTMSYcgGSxKgu7gqQSqiHc7hyFuTBQEXr2fJ7B4VBLO48265WPV2GactXIsuwIaMnz5+B6pU2BvI1ayC10GJAuRqimaKEANrJF0/oxwfHMzj8XUxG7ohZBlIerMsDNtPlLkWfF/APlhXQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=qVjxkOLj; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="qVjxkOLj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Lh
	NrACahs4ufRrQbVXxlco155SnB1aDDsdao2QJJ0wI=; b=qVjxkOLjKsrN3LSBiF
	hi6KCcMKYQJ2s4ZoTzR695HWG8NgUgL37ONGKn/7K5PCxW4WvG+xKVk6Qxh5DBCI
	QZQgB/FX0YiB+P7mkBiDqmDPUsUY5pYHewte/DYNOj/bR1aiMBf7ExkwlODOIL8f
	w5kRuB2OozT5lnTA3VnJE4aCs=
Received: from xwm-TianYi510Pro-14IMB.. (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wD3b_8CplVqBxNXJA--.48351S4;
	Tue, 14 Jul 2026 10:59:22 +0800 (CST)
From: weimin xiong <15927021679@163.com>
To: Jean-Philippe Brucker <jpb@kernel.org>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>,
	virtualization@lists.linux.dev,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Xiong Weimin <xiongweimin@kylinos.cn>
Subject: [PATCH v1 2/2] iommu/virtio: Reject short event buffers
Date: Tue, 14 Jul 2026 10:59:14 +0800
Message-ID: <20260714025914.193580-3-15927021679@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260714025914.193580-1-15927021679@163.com>
References: <20260714025914.193580-1-15927021679@163.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3b_8CplVqBxNXJA--.48351S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrtr1UXw4fWry7Ary7CrW5Awb_yoWDZFc_ur
	yvvr9rJr1UZFZ0yryUKr1I9r9aka90vrn3uFWFgrWrJ348Xws7Cryvqrs5GFW7Wr4vkFnI
	yws0y3WrXryfWjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0fwIDUUUUU==
X-CM-SenderInfo: jprvmjixqsilmxzbiqqrwthudrp/xtbC0QqbJGpVpgqTpgAA3C

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
index 4c91a82d2..4b7f0dcfa 100644
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

