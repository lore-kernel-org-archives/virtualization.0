Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A852F5FDAB
	for <virtualization@lists.linux.dev>; Fri,  2 Feb 2024 08:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706863149; cv=none; b=WQThl0/W7qjy72H2U73YYsOLrL5t8+/xKYT9ciTO42yRmFg1i3a6BGaUeklMEGdxcLPptRjaj4DeU0XeO3TyY+BSeDnl+5lB/nGQb4cfEh7K8TvCT9K1QL4cVtRQbf8lpOPquivLh9xxiV3nmAHFwPDedD/wewsQlIcheKZbJiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706863149; c=relaxed/simple;
	bh=fwpDjGVWhoHwKc8QnfrXyzJbGxjn4aI/i/GPWkkfzV8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aGEiycBbT4FtFWx89abYN01Lkrax39O+o9bdp4iiKtpsmA9K0QLdLuZUt7EOWdEsfvviYnqHej+G8FTiHmZYJ5p9lH32rGWhgHqC/hATORYqsBcL9zSDGLXHnqQ+4lqWpt/iWc+A1W/Y3u0wbKKhBJOZXUK4g0ifNrO4QPSB4Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mkec/fgP; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mkec/fgP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706863147; x=1738399147;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fwpDjGVWhoHwKc8QnfrXyzJbGxjn4aI/i/GPWkkfzV8=;
  b=Mkec/fgPiPpLxB9X/1KBlGBsUKbuBdyfoscmvJyycm54xgnZRBdx5Dms
   llEg3Nr5yrv1Fi5HtIzX5Nk6CjOQamyf6LYGCa8MScJ5UjyrkAgYr69G0
   h4ZGqG/33nFc1njwaUFTN8MQHZWocDcoYhm8A21LXlAh0sxPCXqW5F9S6
   1wOcEjMmBJ1fM8SH1nJaE3TeBpjXs99GzTJcEFPdl/5wpic1Jfv8BscQf
   kdfxKQXvjoDsohLrl8aWOvEd5TRSCGJH31o9VsRx/7qu4rSylpWS57Ul4
   ovX3Y3oU08ShvSATNCyXluKEUoLfJ/IK8+Q89CI2I1tuqcmpLOi2wn3+a
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="10856853"
X-IronPort-AV: E=Sophos;i="6.05,237,1701158400"; 
   d="scan'208";a="10856853"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 00:38:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="859351499"
X-IronPort-AV: E=Sophos;i="6.05,237,1701158400"; 
   d="scan'208";a="859351499"
Received: from lingshan-icx.bj.intel.com ([10.240.192.125])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 00:38:40 -0800
From: Zhu Lingshan <lingshan.zhu@intel.com>
To: jasowang@redhat.com,
	mst@redhat.com
Cc: virtualization@lists.linux.dev,
	Zhu Lingshan <lingshan.zhu@intel.com>
Subject: [PATCH 01/10] vhost-vdpa: uapi to support reporting per vq size
Date: Sat,  3 Feb 2024 00:38:56 +0800
Message-Id: <20240202163905.8834-2-lingshan.zhu@intel.com>
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

The size of a virtqueue is a per vq configuration.
This commit introduce a new ioctl uAPI to support this flexibility.

Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
---
 include/uapi/linux/vhost.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
index 649560c685f1..bea697390613 100644
--- a/include/uapi/linux/vhost.h
+++ b/include/uapi/linux/vhost.h
@@ -227,4 +227,11 @@
  */
 #define VHOST_VDPA_GET_VRING_DESC_GROUP	_IOWR(VHOST_VIRTIO, 0x7F,	\
 					      struct vhost_vring_state)
+
+/* Get the queue size of a specific virtqueue.
+ * userspace set the vring index in vhost_vring_state.index
+ * kernel set the queue size in vhost_vring_state.num
+ */
+#define VHOST_VDPA_GET_VRING_SIZE	_IOWR(VHOST_VIRTIO, 0x80,	\
+					      struct vhost_vring_state)
 #endif
-- 
2.39.3

