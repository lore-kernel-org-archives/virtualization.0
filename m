Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E492394464;
	Fri, 24 Apr 2026 10:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777027635; cv=none; b=bMkkpQPYW4w9rk4VkL8qwlvq3BHHAehSaVJaw+HPqGAM/E4bDRhWm1X8K3yJ3iCT1pNOFNfrHP+Q7nMUNMWBKXUc0b+0MTpevml05RnDreOz50Mxs/z3MyV5OKXMNCvf/5Hd5pDpWCos5VOSo4DIy5z0NOw1PSSJrEijWSncdp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777027635; c=relaxed/simple;
	bh=3RcMyIf8B03fXv3rOizYKPr4wA8XSpbTZAvHMz/ObcY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M7bwB5MHMczH17/FOFzqPQlDKGoNUoav/QWHyBrA3BCJL24EigD1huG657mzT3m8I5knyzU/YCCsfqo33vOMpRMgpR3YJNzat7ZAyUgvlm4khT3iWD06ATeBKdowmZkcPwYXI4tNQPqd6/nGqKq2+zbPsz2SVnp8E8CllrpqfJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rrxOD3cV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rrxOD3cV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6746C2BCB6;
	Fri, 24 Apr 2026 10:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777027634;
	bh=3RcMyIf8B03fXv3rOizYKPr4wA8XSpbTZAvHMz/ObcY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rrxOD3cVo6BaOWIX9/RJn/XbxD7clyhX8FzT2G7uxa7PljbcgqPAh0HrUK395MQ9F
	 q+nAa/9RUfCPeVH1t6xT2AcHp5RF40fPBUieMXnvoa1RlGnw2fX5QaE9vSqLeWGPcM
	 XtQr0vHtzVueU06fJMicMk/729OtP5eY9H2nOJr0O/aTvczuPG+Qn+nxUkVGwKFIu6
	 ADcQqUm5PbK85PZe8JXYa+hac/SMvMa+RxBYCAsODKfB0452U656NwbuExX17iKyP0
	 XZEHFWaCQCIyh7qNxD7XgDOwTZYvI5gP5FvjOwt0miG2ZKbnaUcqQmzR/30bbmohGF
	 YLx03JuvLTB5w==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wGE40-0000000AzLq-2rKz;
	Fri, 24 Apr 2026 12:47:12 +0200
From: Johan Hovold <johan@kernel.org>
To: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 2/2] vdpa_sim_net: switch to dynamic root device
Date: Fri, 24 Apr 2026 12:47:03 +0200
Message-ID: <20260424104703.2619093-3-johan@kernel.org>
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
 drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
index 6caf09a1907b..29fd14ce5860 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
@@ -453,14 +453,7 @@ static void vdpasim_net_free(struct vdpasim *vdpasim)
 	kvfree(net->buffer);
 }
 
-static void vdpasim_net_mgmtdev_release(struct device *dev)
-{
-}
-
-static struct device vdpasim_net_mgmtdev = {
-	.init_name = "vdpasim_net",
-	.release = vdpasim_net_mgmtdev_release,
-};
+static struct device *vdpasim_net_mgmtdev;
 
 static int vdpasim_net_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
 			       const struct vdpa_dev_set_config *config)
@@ -538,7 +531,6 @@ static struct virtio_device_id id_table[] = {
 };
 
 static struct vdpa_mgmt_dev mgmt_dev = {
-	.device = &vdpasim_net_mgmtdev,
 	.id_table = id_table,
 	.ops = &vdpasim_net_mgmtdev_ops,
 	.config_attr_mask = (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR |
@@ -552,26 +544,25 @@ static int __init vdpasim_net_init(void)
 {
 	int ret;
 
-	ret = device_register(&vdpasim_net_mgmtdev);
-	if (ret) {
-		put_device(&vdpasim_net_mgmtdev);
-		return ret;
-	}
+	vdpasim_net_mgmtdev = root_device_register("vdpasim_net");
+	if (IS_ERR(vdpasim_net_mgmtdev))
+		return PTR_ERR(vdpasim_net_mgmtdev);
 
+	mgmt_dev.device = vdpasim_net_mgmtdev;
 	ret = vdpa_mgmtdev_register(&mgmt_dev);
 	if (ret)
 		goto parent_err;
 	return 0;
 
 parent_err:
-	device_unregister(&vdpasim_net_mgmtdev);
+	root_device_unregister(vdpasim_net_mgmtdev);
 	return ret;
 }
 
 static void __exit vdpasim_net_exit(void)
 {
 	vdpa_mgmtdev_unregister(&mgmt_dev);
-	device_unregister(&vdpasim_net_mgmtdev);
+	root_device_unregister(vdpasim_net_mgmtdev);
 }
 
 module_init(vdpasim_net_init);
-- 
2.53.0

