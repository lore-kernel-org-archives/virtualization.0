Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61445FBAA
	for <virtualization@lists.linux.dev>; Fri,  2 Feb 2024 08:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706863147; cv=none; b=eTP9tBv7RgoLT+MqWTGvQVCl9B2kG+XarEkYkilGQwqPPSov23s64UxRMWmxRWKdIS5SavM+MY3SswZa9hMDE76TplK5od0kdUF3/S5NQ/+1FuDacQQtHGU62pdA9uRpo7vZphqgMXqUsFHwtDqFWvyZ1lM/HPkOK95kyKu8g0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706863147; c=relaxed/simple;
	bh=ri2ILfOVKlVnQo64qqLRdXMuagLBrqRZdzmsITrPDD8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hdUmNl1/mj/u0b46cKDAO87uARCnFbPhHA3HzDbGXn6HGgXtENklhuQ3aElaguUVV5hnbSbIbFiD5YKE4aD6NbNF3OsnlfjDon7KQAyR7bGy9cZ4R/ravbJZr9ySKXYvxSw4mNT0WqIwnVNdcbTVrUmsrx2TlaBxDNQVb7z2rbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AEM6iUfm; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AEM6iUfm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706863145; x=1738399145;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ri2ILfOVKlVnQo64qqLRdXMuagLBrqRZdzmsITrPDD8=;
  b=AEM6iUfmFWw35j0Qt+2svWsp4dy1ZLs61d83/y+WXx5vUOrW1Nlkm0uW
   5zqAC+7gp/Uu11aAFJQO3zg2uoSW2B24fOnXXrr0eDxyBMMNv+sIYy4CB
   qabVbBwkwZcKJwRcgQ3ungy2Fk2DSTncQP+27osh9u9RDoqw0Fxmik/yt
   ZzzTmeDde2pfzSS3unj2q0Ua8sNpMtVp1gR/xVhRYdQNFrK4827L7IB6W
   Rov+5O3SdajaUgguly2Ww1hm0qZ/NmfqHiTeQYF2kdG100N2VLHrfzyj1
   k0H8fneI7/LJVTUHOKoQKS9Rh6q6DCEnF0AFBsiyveAaXk/ruQ2xnAKyK
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="10856824"
X-IronPort-AV: E=Sophos;i="6.05,237,1701158400"; 
   d="scan'208";a="10856824"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 00:38:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="859351494"
X-IronPort-AV: E=Sophos;i="6.05,237,1701158400"; 
   d="scan'208";a="859351494"
Received: from lingshan-icx.bj.intel.com ([10.240.192.125])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 00:38:38 -0800
From: Zhu Lingshan <lingshan.zhu@intel.com>
To: jasowang@redhat.com,
	mst@redhat.com
Cc: virtualization@lists.linux.dev,
	Zhu Lingshan <lingshan.zhu@intel.com>
Subject: [PATCH 00/10] vDPA: Allocate each vq with its size individually
Date: Sat,  3 Feb 2024 00:38:55 +0800
Message-Id: <20240202163905.8834-1-lingshan.zhu@intel.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The size of a virtqueue is a per vq configuration.

This series introduces a new operation function
get_vq_size to vdpa_config_ops, to help
reporting per vq size.

vhost_vdpa and virtio_vdpa then initialize each
virtqueue buffer individually with its actually
size.

Please help review

Thanks
Zhu Lingshan

Zhu Lingshan (10):
  vhost-vdpa: uapi to support reporting per vq size
  vDPA: introduce get_vq_size to vdpa_config_ops
  vDPA/ifcvf: implement vdpa_config_ops.get_vq_size
  vp_vdpa: implement vdpa_config_ops.get_vq_size
  eni_vdpa: implement vdpa_config_ops.get_vq_size
  vdpa_sim: implement vdpa_config_ops.get_vq_size for vDPA simulator
  vduse: implement vdpa_config_ops.get_vq_size for vduse
  virtio_vdpa: create vqs with the actual size
  vDPA/ifcvf: get_max_vq_size to return max size
  vDPA/ifcvf: implement vdpa_config_ops.get_vq_num_min

 drivers/vdpa/alibaba/eni_vdpa.c    |  8 ++++++++
 drivers/vdpa/ifcvf/ifcvf_base.c    | 11 +++++------
 drivers/vdpa/ifcvf/ifcvf_base.h    |  2 ++
 drivers/vdpa/ifcvf/ifcvf_main.c    | 15 +++++++++++++++
 drivers/vdpa/vdpa_sim/vdpa_sim.c   | 12 ++++++++++++
 drivers/vdpa/vdpa_user/vduse_dev.c | 12 ++++++++++++
 drivers/vdpa/virtio_pci/vp_vdpa.c  |  8 ++++++++
 drivers/vhost/vdpa.c               |  8 ++++++++
 drivers/virtio/virtio_vdpa.c       |  5 ++++-
 include/linux/vdpa.h               |  5 +++++
 include/uapi/linux/vhost.h         |  7 +++++++
 11 files changed, 86 insertions(+), 7 deletions(-)

-- 
2.39.3

