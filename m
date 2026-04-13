Received: from va-1-115.ptr.blmpb.com (va-1-115.ptr.blmpb.com [209.127.230.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90CC3932CC
	for <virtualization@lists.linux.dev>; Mon, 13 Apr 2026 07:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776065032; cv=none; b=jsmno3Obiu6b2RWaFuKS2I2pkGlF0Wrw+jObNMlttit7ZYYMzgjTeNKGdT6m1ux6SxnN6djgMX2nDKvPnBr/BqFz3yKC5bxKiuSRudtUhbyyysHjQMXtZfRtqed7yWN/H4d38/LCJSDH4JGLWdi2MtCrM3NB4pfsdV5X5r2JK7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776065032; c=relaxed/simple;
	bh=0zZfHOOWFWw4+HC5cgC+7XSH/R0wjD1a138VWny+jHA=;
	h=To:Subject:Date:Message-Id:Cc:From:Mime-Version:Content-Type; b=i3ePAETychAXV4GaJHzpB/iAM5Y59iWvoIIQpzprpo2eLV+1cX47RtkCI57aKM7YmVJnLvzAt7Wr8YpXIMF5PsFOmxhr0s57f4nm6KtJtZlrkSsouFZahGpCunoHvIFWpzCpFSNk1lJ+NEmkpyv3ufYtg1yqYaRr4vIcIOg0ksI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ULGSXsZe; arc=none smtp.client-ip=209.127.230.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ULGSXsZe"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1776065019; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=jP3ET5/NQK/iIZIBTGcvS9TsKHd5N6bf39hH0vZuuvw=;
 b=ULGSXsZeW6xQzUEpP1k8aHAryB5PWPQ6p4GKAaCNNrruM5qNpvWkFPfUN6CXUyRx89mU/R
 MCD0nNXzCgv8ejMYtcVv5TiLE+wYLTVmneMZgytg2Qhz/B7T/SEcXX0xNWln+SGe5I3Abx
 3UTRv1Fv+Wn7AFYT9uKk9lb9jeEeeaiM9MnqMOS2twn4Uzbu+RhUN43QiqXpR/azdKOuff
 9C82I28t0D0WB07YCyWpjoS9d9EfBFitRgLBqZyW4xiqaU4FMViRtW4BiJFBIs8G6l0xGr
 IQE2Kct7dkt1WgqQYkK1sqkV55mS4oAW6KvTLGxNUJV9CRAwlxX/t/cbRpEsEg==
X-Original-From: Jinhui Guo <guojinhui.liam@bytedance.com>
Content-Transfer-Encoding: 7bit
To: "Michael S. Tsirkin" <mst@redhat.com>, 
	"Jason Wang" <jasowang@redhat.com>, 
	"Xuan Zhuo" <xuanzhuo@linux.alibaba.com>, 
	=?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	"Jiri Pirko" <jiri@resnulli.us>
Subject: [PATCH] virtio_pci_modern: Use GFP_ATOMIC with spin_lock_irqsave held in virtqueue_exec_admin_cmd()
Date: Mon, 13 Apr 2026 15:22:49 +0800
Message-Id: <20260413072249.30433-1-guojinhui.liam@bytedance.com>
X-Mailer: git-send-email 2.17.1
X-Lms-Return-Path: <lba+269dc99f9+7dd85b+lists.linux.dev+guojinhui.liam@bytedance.com>
Cc: <virtualization@lists.linux.dev>, <linux-kernel@vger.kernel.org>, 
	"Jinhui Guo" <guojinhui.liam@bytedance.com>, <stable@vger.kernel.org>
From: "Jinhui Guo" <guojinhui.liam@bytedance.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8

virtqueue_exec_admin_cmd() holds admin_vq->lock with spin_lock_irqsave(),
which disables interrupts.  Using GFP_KERNEL inside this critical section
is unsafe because kmalloc() may sleep, leading to potential deadlocks or
scheduling violations.

Switch to GFP_ATOMIC to ensure the allocation is non-blocking.

Fixes: 4c3b54af907e ("virtio_pci_modern: use completion instead of busy loop to wait on admin cmd result")
Cc: stable@vger.kernel.org
Signed-off-by: Jinhui Guo <guojinhui.liam@bytedance.com>
---
 drivers/virtio/virtio_pci_modern.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index 6d8ae2a6a8ca..db8e4f88b749 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -101,7 +101,7 @@ static int virtqueue_exec_admin_cmd(struct virtio_pci_admin_vq *admin_vq,
 		return -EIO;
 
 	spin_lock_irqsave(&admin_vq->lock, flags);
-	ret = virtqueue_add_sgs(vq, sgs, out_num, in_num, cmd, GFP_KERNEL);
+	ret = virtqueue_add_sgs(vq, sgs, out_num, in_num, cmd, GFP_ATOMIC);
 	if (ret < 0) {
 		if (ret == -ENOSPC) {
 			spin_unlock_irqrestore(&admin_vq->lock, flags);
-- 
2.20.1
