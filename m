Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1435FDA3
	for <virtualization@lists.linux.dev>; Fri,  2 Feb 2024 08:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706863153; cv=none; b=l6qS7mGPGbWCTu4msWzyVm5vO6oSB2qu8qvVDXYhjqacPZX87PtIdBhc6Htx2JYf77PEex0LwmdxMm+xOw2Ye/oRM/cPmnA3yiIb1osPWqY4UXRgOZTy65oEC7OLEBkhE+aGS72UpF89e943MVxsTKTiNt+jm5D6gQilzy0smBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706863153; c=relaxed/simple;
	bh=kGxKTbW4+aMN2MvIGOkd7AnEeDkIqfME8YLMp34/GaA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pgzgwSry31RGAc7y/sKYZlbLu/2lYH0e6YRvt/IgkmPGVeQoyZaJozXS+/G/YMlm7fQAPJ4OYOC0L1naPMPayRoIOxee9eU0ausE60t5nscl+AHptFEq2dL+hgQsAxlwWHpUf41Bcgyy2GQHeYDAkE5GfdErnOyKJqYAzXui/eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IbB/NzwY; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IbB/NzwY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706863152; x=1738399152;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kGxKTbW4+aMN2MvIGOkd7AnEeDkIqfME8YLMp34/GaA=;
  b=IbB/NzwY7VrkDXrBqQNrI2PlDKlk0TXgqkfYFEX0BxOXQ5GR9Qv9XNUc
   rIFZUCYaJ7J1RcUOvl8jgqtrAHt4YVlPl7gmC4DdfzXEuiOx2zQbWDV5R
   f+wStfTp8bk+GhX76L5SRM3bVcByTo/rbxIlXYdp+X4eFEqtyKi0FGA1d
   /B+alo09IIb/pLLvaO5HLhCYos6Ba+sl8fW3SG1hSAkWSYA1F2Eq+OgEl
   gA7p0JoRTEPU6OedsTGc8LN6OHcBLMwFBHMdCVw3A+5MjSq/T5/z+FFLb
   Ewpds2UfCgpLepaw7tNy+ATjuaF9ipb0FRc46xkVfTrfWFzkUKHMNG5C7
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="10857089"
X-IronPort-AV: E=Sophos;i="6.05,237,1701158400"; 
   d="scan'208";a="10857089"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 00:38:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="859351540"
X-IronPort-AV: E=Sophos;i="6.05,237,1701158400"; 
   d="scan'208";a="859351540"
Received: from lingshan-icx.bj.intel.com ([10.240.192.125])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 00:38:51 -0800
From: Zhu Lingshan <lingshan.zhu@intel.com>
To: jasowang@redhat.com,
	mst@redhat.com
Cc: virtualization@lists.linux.dev,
	Zhu Lingshan <lingshan.zhu@intel.com>
Subject: [PATCH 08/10] virtio_vdpa: create vqs with the actual size
Date: Sat,  3 Feb 2024 00:39:03 +0800
Message-Id: <20240202163905.8834-9-lingshan.zhu@intel.com>
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

The size of a virtqueue is a per vq configuration,
this commit allows virtio_vdpa to create
virtqueues with the actual size of a specific
vq size that supported by the backend device.

Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
---
 drivers/virtio/virtio_vdpa.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
index 8d63e5923d24..e803db0da307 100644
--- a/drivers/virtio/virtio_vdpa.c
+++ b/drivers/virtio/virtio_vdpa.c
@@ -183,8 +183,11 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsigned int index,
 	info = kmalloc(sizeof(*info), GFP_KERNEL);
 	if (!info)
 		return ERR_PTR(-ENOMEM);
+	if (ops->get_vq_size)
+		max_num = ops->get_vq_size(vdpa, index);
+	else
+		max_num = ops->get_vq_num_max(vdpa);
 
-	max_num = ops->get_vq_num_max(vdpa);
 	if (max_num == 0) {
 		err = -ENOENT;
 		goto error_new_virtqueue;
-- 
2.39.3

