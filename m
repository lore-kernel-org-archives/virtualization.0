Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BDD43BDD8;
	Sun,  4 Oct 2026 11:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791115060; cv=none; b=NA+K7FXui8NivHsMUJVjBg4IV/vMjM3b5Lu0EsxxvNDd2HgM0U8LOQwi/PQXTwsVf7ZxZB3vtTosZbgQzU189tf7MfrcmfTIicN/KKqAaRCy6Zjm2J5eLEgYate+eF6jPbFz8LJIBVj/laWtpWuyG91ZCHqcqFnMBmWm0E9U1z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791115060; c=relaxed/simple;
	bh=UkC1fLh/aCINqBAcJae8ll926LkJml/F3tuLfNPqnjU=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=VekSUN1LFxTi1AmPGILLGgIT6FmJSdipmYNNAOL96UZXTg4Db6qECNSKZuyU9yav50IDHkbR6b8LrT1QZSPPAVUrA3+KBf9wEITYM4jpVnJ5SGtj5wWmCS1CERF/opJxv3PBBZvHj9+o9gdGTOQrDlx303ykTaLbL80+NOVJGZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=bfkxLpqp; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="bfkxLpqp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1791115045; bh=ZZiYWxcQWiA23elo/+ufxdGFIR5H7wzKjVL7gfgRUkU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bfkxLpqppIc2qaTJhE22zTBEcU9kQYb5GBVCoPU9KU8M6JpVrY+HNb+2kRBpd0aS4
	 X5z6AYiiwCg5fBtXgY5s4so99uFSggIWvucIeUcYBjgc3ZOtuGJr8iLvfBBWDC4Pmi
	 DqlzGF/+2G/EPODoQBRxKxQkbD04KMULjsztyyK0=
Received: from xiuos ([2001:da8:201:1175:6e92:bfff:fe3b:37c3])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id E4D020DE; Sun, 04 Oct 2026 19:57:13 +0800
X-QQ-mid: xmsmtpt1791115043tnvnpyy5v
Message-ID: <tencent_110F1F4156EDBA12B5409541DC2D9BA0C708@qq.com>
X-QQ-XMAILINFO: NbgegmlEc3JuDC7d6l50HCnUiuBIc0K9WFpEWVp4f6WvsXsy8YPwk3WeFV91Jx
	 +zJ9yuckcBD1QeXFsAZPbdLW18VywnrRGYR0w6vWq21dKd4d/Ww9PidcTZ+IN1sxrxvZXK3zLzvs
	 OqawJn6Ii+P1GVJj1izyLIAQaGD8ltS8ZIlMdMkerrh1H29ATqv+YXjgCJicKkHk8YLPpkBpQ12T
	 /cyvrvEGFe4F/lYfDs6K767qnuJ5xkt3iBp9+WpXthoiWTyM7QeoCwGSccfej+X7xG2sM0XMWuiJ
	 3sG+4RnYCGQG2zO9RowVJNC7VwFTP7l00snFthVOf7YXOq04M5t14VIwmn2vl9qLKyg4hPBA5LXq
	 IPFqcT7fjX6gT7ey5KuRscbI4/tjVxebTk+g2Ng4/Tv4RRyRcfkIptKe9YHnNBCC5caz1iX1SPSO
	 MbXUv7tz3HpLaJdWzsoBPnMnga248FVtRnleF88Kz9sOQChnrOn85NhzqBZNP/59GyxewhMjErnw
	 b+oFbjCARIZLdq+MtvNwThjIzVAArxCn5dID7awT7fwK1kD5eWB9cKB0IJz4+Dp/trrc4xIzT+fL
	 31feUTzv1qsQBYn+bW7DfLBpvrHU7AGiSinis4gyidtcq+oKnGxlQUD39Pe1I6Fph24VM0IOh0gH
	 xnQGnz1d9cuLjZ8Xrpvw1cCJ6dqRP+u0OFmuliX10Sld/B9QwHfjQPeJVlfALaA6Yplp2owQWOwD
	 zj8aG5C+qidrzs4rYsaZ2uXTHaZD1hXmVPT2fs5YkQj12Z7ivCyITrYHOaRZn/siR8ldgYx5xI4o
	 JvYOZyHyUnyfqIrMp9JWQhgBSlA1Vyja6x07skO9EVUv3/tyiaYjLH13swUVyiaRKRHOayoV6zjd
	 H7z2maSektELQ8RY1GDZ8w8WASoNPK0svPYpAwPdOJGvYFTxj5mpkmzrlK+Bl+4PTPHtXBNa5pY9
	 q6Tu7eLLmXUy5lNzbfPqkA7CZ5473yBq358W3hPUZb17eJHtulGsrxBPsSInbCumndBSOF+dFzq2
	 Jl+shDLkXp7u+Yu2DfCmB2jx1hIRwmIy4zQPvO5jS/aDX3Ojgr4C2hXZ6lkMp/bCRO/SXnvA7dGy
	 fGliv55zSNImbdO5B/5iO+cAMcNA==
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
From: Anlai Lu <agicy@qq.com>
To: Jean-Philippe Brucker <jpb@kernel.org>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>,
	virtualization@lists.linux.dev,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Anlai Lu <agicy@qq.com>
Subject: [PATCH 4/6] iommu/virtio: stop queueing and draining once the device is removed
Date: Sun,  4 Oct 2026 11:57:07 +0000
X-OQ-MSGID: <20261004115709.3181856-4-agicy@qq.com>
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

viommu_remove() resets the device and deletes the virtqueues while
userspace may still hold domains that it maps or attaches, and nothing
stopped a request from being queued - or a drain from walking the queue -
on a virtqueue that was being torn down.

Set ->removed under request_lock before the teardown - the lock a
queueing path holds while it checks liveness and adds the request, and
the one the drain holds for its whole run - check it in the queueing
helper, and let the drain return early when it is set.

Fixes: edcd69ab9a32 ("iommu: Add virtio-iommu driver")
Signed-off-by: Anlai Lu <agicy@qq.com>
---
 drivers/iommu/virtio-iommu.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 1a4366458751..ba1d78e4daa0 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -42,6 +42,11 @@ struct viommu_dev {
 	spinlock_t			request_lock;
 	struct list_head		requests;
 	void				*evts;
+	/*
+	 * Set before the teardown: nothing may be queued or drained after
+	 * that.
+	 */
+	bool				removed;
 
 	/* Device configuration */
 	struct iommu_domain_geometry	geometry;
@@ -116,6 +121,16 @@ static struct viommu_domain viommu_identity_domain;
 #define to_viommu_domain(domain)	\
 	container_of(domain, struct viommu_domain, domain)
 
+/*
+ * The device can be removed while its domains still exist (userspace may hold
+ * them for a while), and the queues go away with it: nothing may be queued or
+ * drained after that.
+ */
+static bool viommu_device_live(struct viommu_dev *viommu)
+{
+	return !viommu->removed;
+}
+
 static int viommu_get_req_errno(void *buf, size_t len)
 {
 	struct virtio_iommu_req_tail *tail = buf + len - sizeof(*tail);
@@ -206,6 +221,10 @@ static int viommu_sync_req(struct viommu_dev *viommu)
 	unsigned long flags;
 
 	spin_lock_irqsave(&viommu->request_lock, flags);
+	if (!viommu_device_live(viommu)) {
+		spin_unlock_irqrestore(&viommu->request_lock, flags);
+		return 0;
+	}
 	ret = __viommu_sync_req(viommu);
 	if (ret)
 		dev_dbg(viommu->dev, "could not sync requests (%d)\n", ret);
@@ -229,6 +248,9 @@ static int __viommu_queue_req(struct viommu_dev *viommu,
 
 	assert_spin_locked(&viommu->request_lock);
 
+	if (!viommu_device_live(viommu))
+		return -ENODEV;
+
 	sg_init_one(&top_sg, req->buf, write_offset);
 	sg_init_one(&bottom_sg, req->buf + write_offset,
 		    req->len - write_offset);
@@ -1555,10 +1577,20 @@ static int viommu_probe(struct virtio_device *vdev)
 static void viommu_remove(struct virtio_device *vdev)
 {
 	struct viommu_dev *viommu = vdev->priv;
+	unsigned long flags;
 
 	iommu_device_sysfs_remove(&viommu->iommu);
 	iommu_device_unregister(&viommu->iommu);
 
+	/*
+	 * The queues go away here: nothing may be queued or drained from now
+	 * on.  Taking request_lock is what tells a drain in flight that it has
+	 * to finish before the teardown, since the drain holds it throughout.
+	 */
+	spin_lock_irqsave(&viommu->request_lock, flags);
+	viommu->removed = true;
+	spin_unlock_irqrestore(&viommu->request_lock, flags);
+
 	/* Stop all virtqueues */
 	virtio_reset_device(vdev);
 	vdev->config->del_vqs(vdev);
-- 
2.55.0

