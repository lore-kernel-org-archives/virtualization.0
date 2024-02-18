Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19DBD4EB4D
	for <virtualization@lists.linux.dev>; Sun, 18 Feb 2024 10:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708253742; cv=none; b=tf6aaveTTZkX64mpIykOaR57/2IKZPagTVWpwud9C7RlJ30B6+n2Mua0Jm7KOv+ZdLkaRTIiDVatY4QPwllHac3KgX0qLCKKdsmplutVIHX4qyChtI/ov3Lsq4GeJX0qel8lA+pOXAI+YoCR71zpgVwx8njchEUDpmUai7buc0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708253742; c=relaxed/simple;
	bh=jpcrsc9SkfM2EPPkNx/Zqf5nMdI1WP8A8hc6xnBjFLI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qo1JmvHnIXA9QehQa/QJTmQUou27qhwvxANt9I3DbW4p/pRRFtcad52No6bp7aWMP+/Lhtq+7Gd8J0DDqwgbPot67/g3X2Ihd7t4c84hWtMOGD5E/11ydKSR0//bLUkj6uLIHcK8gvyy+eZlpKjL0QB24Gx3Fawz1dggVSlT1nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FJiPauPG; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FJiPauPG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708253740; x=1739789740;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jpcrsc9SkfM2EPPkNx/Zqf5nMdI1WP8A8hc6xnBjFLI=;
  b=FJiPauPGSAKbQ7y9dftPngtjiqZj7+DK8fd+MzcO0gMS1CTthnTHti5T
   DUiQ2j+fBLi4A0SvFQyl2//cDDTMG8UdyF3fZHGNTJg4E57J+CLBFZ4Tv
   3IoLKK7l9wCNgTgAo0f5c8+/xuh43g3xQBQr5M6/+iWsHqUzTTtAH5wJh
   +ajioDV0oEd3uxzBQVsoxK8b8rs71Dko7ByYtA4RWkccazRqeCu8DEte3
   DzKrmIUXEA9TgjUfMbD3oijp84JliUBaMUm37Ik/WQHt6LwCN1Y4OV1/P
   GlT9KL7E1C6kDY+T4zYitsP3M/bFF+ZI1N0k6dCnfBTssbfbv4rMt7k6H
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10987"; a="2204610"
X-IronPort-AV: E=Sophos;i="6.06,168,1705392000"; 
   d="scan'208";a="2204610"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2024 02:55:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10987"; a="912691611"
X-IronPort-AV: E=Sophos;i="6.06,168,1705392000"; 
   d="scan'208";a="912691611"
Received: from lingshan-icx.bj.intel.com ([10.240.192.125])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2024 02:55:37 -0800
From: Zhu Lingshan <lingshan.zhu@intel.com>
To: jasowang@redhat.com,
	mst@redhat.com
Cc: virtualization@lists.linux.dev,
	Zhu Lingshan <lingshan.zhu@intel.com>
Subject: [PATCH 00/10] vDPA: allow userspace query virito-block device
Date: Mon, 19 Feb 2024 02:55:56 +0800
Message-Id: <20240218185606.13509-1-lingshan.zhu@intel.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series allows the user space applications query vDPA virtio-block
device inforamtion.

testing on vdpa_sim_blk, iproute2 output:
sudo ./vdpa/vdpa dev config show -jp vdpa_blk0
{
    "config": {
        "vdpa_blk0": {
            "capacity": 262144,
            "segment size": 4096,
            "block size": 512,
            "max segments in a request": 32,
            "num of queues": 1,
            "logical blocks per physical block (log2)": 0,
            "offset of first aligned logical block": 0,
            "minimum io size": 1,
            "optimal io size": 1,
            "maximum discard sectors for a segment": 4294967295,
            "max discard segments in a command": 1,
            "discard sector alignment": 512,
            "max write zeros sectors in a segment": 4294967295,
            "max write zero segments": 1,
            "read only": false,
            "flush command support": true
        }
    }
}

Please help review

Thanks
Zhu Lingshan

Zhu Lingshan (10):
  vDPA: report virtio-block capacity to user space
  vDPA: report virtio-block max segment size to user space
  vDPA: report virtio-block block-size to user space
  vDPA: report virtio-block max segments in a request to user space
  vDPA: report virtio-block MQ info to user space
  vDPA: report virtio-block topology info to user space
  vDPA: report virtio-block discarding configuration to user space
  vDPA: report virtio-block write zeroes configuration to user space
  vDPA: report virtio-block read-only info to user space
  vDPA: report virtio-blk flush info to user space

 drivers/vdpa/vdpa.c       | 212 ++++++++++++++++++++++++++++++++++++++
 include/linux/vdpa.h      |   1 +
 include/uapi/linux/vdpa.h |  17 +++
 3 files changed, 230 insertions(+)

-- 
2.39.3

