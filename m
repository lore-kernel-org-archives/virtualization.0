Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46BE25FDBB
	for <virtualization@lists.linux.dev>; Fri,  2 Feb 2024 08:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706863152; cv=none; b=B/h9fOcrLd1PqwyJ5S1hRxXTzWDjq4+uTE6FrEy1eeXejMVivyEAyp6zOZ8JADUpdWpzvr18Po3+BvRFrJZgGLQI4VOC/fCbPgKIS8DeVIyeex5shWKYUkTEgOSkf8oyaKtMHX9ayXtVI+5Nwm+puFzxLZvWltwlIe4UgB3nu08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706863152; c=relaxed/simple;
	bh=q6wBkZ2EIHA3mZEgBUjwpa+yk5XBb5WZYqfMvP0Q1AI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SrGKE+vEoz7YAsva4DNJmSf2WX1CxW9OsgHin9twuER3PDA2WcXhO0L/YY29d/JURFmhcToN1JBnfmhxKNFB3N6lb9gYBuEHQVTCXiAbiszixGswfPQrptGybskeD/Q43jBga43bQJsXCCeNSwg3yJzKxJA4GexFv5x+bRkewDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AB0F5VXV; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AB0F5VXV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706863151; x=1738399151;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=q6wBkZ2EIHA3mZEgBUjwpa+yk5XBb5WZYqfMvP0Q1AI=;
  b=AB0F5VXVoNSdwafeJazYhtF98F5hD6pBM7RscoMXOw06ejmp4dMfpqE5
   LpjiJ+vCWWbVjF1JRlA1tWTMLGQ/3XnTWz4jvmJnk2/a7Ebiai2ETEPJr
   AuaeL5Tw8UOA+ZRuay7TfnYF9gfUIVuYtaFC0ATvzbSsn7IFaLPZ+tf9Z
   7XTXJlJnXNLmh0hxGBfqdq8iTBQd8EXUnMlL+xWkAw6j8o8V8/wgPWrBt
   0Vyhq5KIti0OrCfvE8US80ioj5z04GZxRtaIG8Ue9XtEGApPcNGLi1YmZ
   3EcO+h51hnNgGNAoptPm+qqtIDiNJsBACEG5h/grkQ+WUGOucE1ycIXJc
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="10857018"
X-IronPort-AV: E=Sophos;i="6.05,237,1701158400"; 
   d="scan'208";a="10857018"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 00:38:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="859351527"
X-IronPort-AV: E=Sophos;i="6.05,237,1701158400"; 
   d="scan'208";a="859351527"
Received: from lingshan-icx.bj.intel.com ([10.240.192.125])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 00:38:48 -0800
From: Zhu Lingshan <lingshan.zhu@intel.com>
To: jasowang@redhat.com,
	mst@redhat.com
Cc: virtualization@lists.linux.dev,
	Zhu Lingshan <lingshan.zhu@intel.com>
Subject: [PATCH 06/10] vdpa_sim: implement vdpa_config_ops.get_vq_size for vDPA simulator
Date: Sat,  3 Feb 2024 00:39:01 +0800
Message-Id: <20240202163905.8834-7-lingshan.zhu@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240202163905.8834-1-lingshan.zhu@intel.com>
References: <20240202163905.8834-1-lingshan.zhu@intel.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit implements vdpa_config_ops.get_vq_size for vDPA
simulator, this new interface can help report per vq size.

Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index be2925d0d283..a870c983d89f 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -311,6 +311,17 @@ static void vdpasim_set_vq_num(struct vdpa_device *vdpa, u16 idx, u32 num)
 	vq->num = num;
 }
 
+static u16 vdpasim_get_vq_size(struct vdpa_device *vdpa, u16 idx)
+{
+	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
+	struct vdpasim_virtqueue *vq = &vdpasim->vqs[idx];
+
+	if (vdpasim->status & VIRTIO_CONFIG_S_DRIVER_OK)
+		return vq->num;
+	else
+		return VDPASIM_QUEUE_MAX;
+}
+
 static void vdpasim_kick_vq(struct vdpa_device *vdpa, u16 idx)
 {
 	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
@@ -774,6 +785,7 @@ static const struct vdpa_config_ops vdpasim_config_ops = {
 	.get_driver_features    = vdpasim_get_driver_features,
 	.set_config_cb          = vdpasim_set_config_cb,
 	.get_vq_num_max         = vdpasim_get_vq_num_max,
+	.get_vq_size		= vdpasim_get_vq_size,
 	.get_device_id          = vdpasim_get_device_id,
 	.get_vendor_id          = vdpasim_get_vendor_id,
 	.get_status             = vdpasim_get_status,
-- 
2.39.3

