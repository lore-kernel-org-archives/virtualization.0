Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6F212CDA5
	for <virtualization@lists.linux.dev>; Fri, 26 Jun 2026 02:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782439566; cv=none; b=BMaKRSWIwoLxDJ4ChNExy3LxWaZe7abfv7hOhVOu9qK8Jx5MW/ucmEJlbL2V9mDCaya/JqUHIbc/qOHE+c9UkTpi2JFxEmLwLqcfK95LFKpRMngOiRQb2fqGv2NoUVcXVLyOUuddDmMjR38yQZGGv6S+jaPR4JCTj5YB8njAJ8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782439566; c=relaxed/simple;
	bh=5+wJ6pTDbqo6a5OaXQZYq75bjR1odo+XYKOik9uLp3M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W0+zPWmV8DTK4qseDBQJ4/FITiP7n2O2N7HIlut76/MdU178Eb4CqcierdHb4rsxZKOXhKRh8Aa8aHXZiKwHhr1frkofMEHxXoor7uJSxNJ9ZgV+6l1ggRhrK6tiRODm+Ae/mfMLVPdt+/T0qTb1qPkPhxQhHERNvfjMEOLJDm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=QWQuvBiU; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="QWQuvBiU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=mO
	SgYwaLawiIFYNPeX44qpXqdxhREpsWdcKCCKp8Sow=; b=QWQuvBiU+ZCjVB7V4K
	xBYysWD1egowB6GO2M7yUMc+1fxh7E6mOW9txsZbpUvlJCeQ2/pn4L2ahskCajjc
	aNgDRmTk+3bSyJs4ntwL6/vN1iTDflFzInxjC1CEdGmKwncfk2m4Jy0OFgMWGMRt
	Ee9O9hsRresk7ZLhKUV3PQ+yw=
Received: from xwm-TianYi510Pro-14IMB.. (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgBn4SB83j1qWhWLEA--.17305S2;
	Fri, 26 Jun 2026 10:05:49 +0800 (CST)
From: Xiong Weimin <15927021679@163.com>
To: Jason Wang <jasowang@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Xiong Weimin <xiongweimin@kylinos.cn>
Subject: [PATCH 0/2] vdpa_sim: fix suspend/reset and dma_unmap locking
Date: Fri, 26 Jun 2026 10:05:43 +0800
Message-ID: <20260626020545.607600-1-15927021679@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgBn4SB83j1qWhWLEA--.17305S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZF47Gw4rXw4kGr18Jw1kXwb_yoW3CrbEgr
	Z7uryqyw1rGrZayw1UKr9rJFsxK39FkrWrZw1qga17X34rtwnxWa1kKFyUJF17GFW2yFs5
	tF1UtryfAr1xCjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbgdb7UUUUU==
X-CM-SenderInfo: jprvmjixqsilmxzbiqqrwthudrp/xtbC0h3ASWo93n2IHQAA3n

From: Xiong Weimin <xiongweimin@kylinos.cn>

This series fixes two independent issues in the vDPA simulator:

1. Clear pending_kick on device reset so a deferred kick from a
   suspended device cannot be replayed after reset/re-init.

2. Hold iommu_lock across the full dma_unmap() path, including the
   passthrough-to-custom mapping transition, matching dma_map().

Both patches tested on an openEuler VM running kernel 6.16.8: built
vdpa_sim.ko from /usr/src/linux-6.16.8 and reloaded vdpa_sim /
vdpa_sim_net successfully.

Xiong Weimin (2):
  vdpa_sim: clear pending_kick on device reset
  vdpa_sim: hold iommu_lock across dma_unmap passthrough transition

---
 drivers/vdpa/vdpa_sim/vdpa_sim.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

-- 
2.43.0

