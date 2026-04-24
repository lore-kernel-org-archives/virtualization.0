Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E354390CB8;
	Fri, 24 Apr 2026 10:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777027635; cv=none; b=ZoxWmGkTzQ0bgUg4ZKTEQ4jeG0rER4zBAMr0lgrQgC3hS6wnvC4uHyh8HT2P4hzi8rL+dgKZKqK9hGLvl5zUSPZsIHFcVMbYo5kWOXLtvUW3ywBMnylgMEb57+Y16FtZ5u/UNOU6DHm7ks+5nFdENTybZPJtjUJ4otlioxmDV4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777027635; c=relaxed/simple;
	bh=wytBV/xu+tl6Z2Bv8ZKCO2G0KM7uzajcWNJ0doR9qmU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PMqmHjI4JU+GgljfqoO3RGpPn7iqHARnzFhrYUQZxxZhRYdrdWakSFPm8KUxFEKnnJxrxxsCERGct9mtueJM3LBVd+jJOBkXPWXPCeAazTXKBd1t4C+h1uxvw7xyW0qAP2Xk6s3s71WdGnA/ANd+36041nPjalQAXmrl8UnkD3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k7MAhyOk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k7MAhyOk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA742C19425;
	Fri, 24 Apr 2026 10:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777027634;
	bh=wytBV/xu+tl6Z2Bv8ZKCO2G0KM7uzajcWNJ0doR9qmU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k7MAhyOkHKbb2hw+as1w0kn9Tzp1qCfl10pIGjDRnDoBWwI/q04v/OBh6woZFm0O6
	 DTZ59EMCfTcvpAV0TfqMxU3aM/l71CiSRv4MqBpYINv/v03PWtEq4R/HusSFOh6HnP
	 lt7AVoYA+RKirIRh3O9J+Rpat9IbgVsYz76Pld1WRLgoQgbS6F3iiBEPPHCUg2o3sC
	 WgcLf28kWw7ZIoOvq4TNqvn+T39nbxcDjyUdYTNmhzREEhancHxNFdx/61EHqXJT1r
	 Ec/C9rOY00QqKNYYb63GD22ix6i1mybDMxers3dOrU4538x+ba4xWPRjZ5WZQAneXK
	 Oa2T5LkgIp1Ig==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wGE40-0000000AzLo-2p0u;
	Fri, 24 Apr 2026 12:47:12 +0200
From: Johan Hovold <johan@kernel.org>
To: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 1/2] vdpa_sim_blk: switch to dynamic root device
Date: Fri, 24 Apr 2026 12:47:02 +0200
Message-ID: <20260424104703.2619093-2-johan@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424104703.2619093-1-johan@kernel.org>
References: <20260424104703.2619093-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Driver core expects devices to be dynamically allocated and will, for
example, complain loudly when no release function has been provided.

Use root_device_register() to allocate and register the root device
instead of open coding using a static device.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/vdpa/vdpa_sim/vdpa_sim_blk.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
index b137f3679343..f70f454dde8e 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
@@ -397,14 +397,7 @@ static void vdpasim_blk_free(struct vdpasim *vdpasim)
 		kvfree(blk->buffer);
 }
 
-static void vdpasim_blk_mgmtdev_release(struct device *dev)
-{
-}
-
-static struct device vdpasim_blk_mgmtdev = {
-	.init_name = "vdpasim_blk",
-	.release = vdpasim_blk_mgmtdev_release,
-};
+static struct device *vdpasim_blk_mgmtdev;
 
 static int vdpasim_blk_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
 			       const struct vdpa_dev_set_config *config)
@@ -475,7 +468,6 @@ static struct virtio_device_id id_table[] = {
 };
 
 static struct vdpa_mgmt_dev mgmt_dev = {
-	.device = &vdpasim_blk_mgmtdev,
 	.id_table = id_table,
 	.ops = &vdpasim_blk_mgmtdev_ops,
 };
@@ -484,12 +476,11 @@ static int __init vdpasim_blk_init(void)
 {
 	int ret;
 
-	ret = device_register(&vdpasim_blk_mgmtdev);
-	if (ret) {
-		put_device(&vdpasim_blk_mgmtdev);
-		return ret;
-	}
+	vdpasim_blk_mgmtdev = root_device_register("vdpasim_blk");
+	if (IS_ERR(vdpasim_blk_mgmtdev))
+		return PTR_ERR(vdpasim_blk_mgmtdev);
 
+	mgmt_dev.device = vdpasim_blk_mgmtdev;
 	ret = vdpa_mgmtdev_register(&mgmt_dev);
 	if (ret)
 		goto parent_err;
@@ -507,7 +498,8 @@ static int __init vdpasim_blk_init(void)
 mgmt_dev_err:
 	vdpa_mgmtdev_unregister(&mgmt_dev);
 parent_err:
-	device_unregister(&vdpasim_blk_mgmtdev);
+	root_device_unregister(vdpasim_blk_mgmtdev);
+
 	return ret;
 }
 
@@ -515,7 +507,7 @@ static void __exit vdpasim_blk_exit(void)
 {
 	kvfree(shared_buffer);
 	vdpa_mgmtdev_unregister(&mgmt_dev);
-	device_unregister(&vdpasim_blk_mgmtdev);
+	root_device_unregister(vdpasim_blk_mgmtdev);
 }
 
 module_init(vdpasim_blk_init)
-- 
2.53.0

