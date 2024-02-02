Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2E15FDAC
	for <virtualization@lists.linux.dev>; Fri,  2 Feb 2024 08:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706863151; cv=none; b=bZ4IkReMUj3xdhyWJ099jnk70f4Bvv92N1qykoFi8vk/rtpJXdZybCwB0aEt8xjcztOz8YyipeI5QuMe5DU53ICOcJXwRQf8nsn5PkaFOQbldX+TA3VHuxBNgljukf+SHN55ctoHmNE8qNJXHR34Nvpa6eyPDwfkE9s8GzeP/qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706863151; c=relaxed/simple;
	bh=LJsQwKnyTMo/e+pfQg8MK6odyFlP31hEgjcWTj0yBWA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nNBicgyOuWGdTp9dFR+UgJiA7QdMQZwtHGGTz9pWupIqwOukYMCZzr3IpKWBy0Zyjec1ISdAT2hZlhmJcLaGBaswLh6OwJwuoJ/7R7WWjPIZ2SQTrTZ8Is0rzIoRSnsoHUpscl834Eg+PUy8poQd0W8eGIIJfxDXbXD+Wk/sO0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BlwcTLNO; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BlwcTLNO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706863149; x=1738399149;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LJsQwKnyTMo/e+pfQg8MK6odyFlP31hEgjcWTj0yBWA=;
  b=BlwcTLNOd/NuTerNb37wchPUOqBl/sx/5Pd9JZX7F6gjtKKIPl5JjJqE
   HSAc0cUXnhuemgmhdmW8/oICBd3ZdHJkNivnpL2dFC0NNKrOO9343Yk9F
   M20bMv7c37D1GXaGb/vZPWKxndvjiO0dBToxblVQ+uKcq+gG8O8AUjNAj
   +zJUEY4R+iuvj0JtqqHJDqqbomugsVwx0aZaOnrj+MC9GnWNe0X9cq5Il
   GnmHaohCpXvZjviq5XAwArhfEBboR03zSEnSkNNUYwsKqeV6s47AGquND
   5b1GvYLwRcTFuSViASEK7SiXGcWXtQxoUezUt1VoKXXTmR+oDFMfO1ZIh
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="10856941"
X-IronPort-AV: E=Sophos;i="6.05,237,1701158400"; 
   d="scan'208";a="10856941"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 00:38:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="859351517"
X-IronPort-AV: E=Sophos;i="6.05,237,1701158400"; 
   d="scan'208";a="859351517"
Received: from lingshan-icx.bj.intel.com ([10.240.192.125])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 00:38:45 -0800
From: Zhu Lingshan <lingshan.zhu@intel.com>
To: jasowang@redhat.com,
	mst@redhat.com
Cc: virtualization@lists.linux.dev,
	Zhu Lingshan <lingshan.zhu@intel.com>
Subject: [PATCH 04/10] vp_vdpa: implement vdpa_config_ops.get_vq_size
Date: Sat,  3 Feb 2024 00:38:59 +0800
Message-Id: <20240202163905.8834-5-lingshan.zhu@intel.com>
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

This commit implements vdpa_config_ops.get_vq_size in
vp_vdpa, which reports per virtqueue size.

Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
---
 drivers/vdpa/virtio_pci/vp_vdpa.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pci/vp_vdpa.c
index 281287fae89f..df5f4a3bccb5 100644
--- a/drivers/vdpa/virtio_pci/vp_vdpa.c
+++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
@@ -328,6 +328,13 @@ static void vp_vdpa_set_vq_num(struct vdpa_device *vdpa, u16 qid,
 	vp_modern_set_queue_size(mdev, qid, num);
 }
 
+static u16 vp_vdpa_get_vq_size(struct vdpa_device *vdpa, u16 qid)
+{
+	struct virtio_pci_modern_device *mdev = vdpa_to_mdev(vdpa);
+
+	return vp_modern_get_queue_size(mdev, qid);
+}
+
 static int vp_vdpa_set_vq_address(struct vdpa_device *vdpa, u16 qid,
 				  u64 desc_area, u64 driver_area,
 				  u64 device_area)
@@ -449,6 +456,7 @@ static const struct vdpa_config_ops vp_vdpa_ops = {
 	.set_vq_ready	= vp_vdpa_set_vq_ready,
 	.get_vq_ready	= vp_vdpa_get_vq_ready,
 	.set_vq_num	= vp_vdpa_set_vq_num,
+	.get_vq_size	= vp_vdpa_get_vq_size,
 	.set_vq_address	= vp_vdpa_set_vq_address,
 	.kick_vq	= vp_vdpa_kick_vq,
 	.get_generation	= vp_vdpa_get_generation,
-- 
2.39.3

