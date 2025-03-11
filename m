Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B030A1DE3B1;
	Tue, 11 Mar 2025 02:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741660916; cv=none; b=Ub0kCyoMTBJ6NhiGS4P+HKECOex2LHHQNlCGKVuSngyFj/hAZmiH3Xmip+i4uRl5d/txSMP9ZKeUi9Ic9X4+I+28fURbbhoGFi+2NqL4IHTyPaDg8WQylgxqhO1Jjf+lgOp+FouowLVqj736Fy9GKiu4cbZHD1OKmgQocKIfjFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741660916; c=relaxed/simple;
	bh=3M1RX7nQUNgedOmI/wuy5kV+UAWXYSfHp90hyMNHCQo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V4lCIqQ/KJBkbOGCo/pwRLoPbONbQLXb3oLHd3sVzCk4PQjlf/5HqHcm91vEYXsqq/L2dI3G5pQO2zf7ThhJBkKIk1tK+MQyN4uBjIJTX/NGv1XTA8ziF1zmWvO38VtLZT2SUI3TarFUCEqYvzmpoUYX9svRuol2t12cB8oZ3z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=GmH8G7h6; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="GmH8G7h6"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1741660914; x=1773196914;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3M1RX7nQUNgedOmI/wuy5kV+UAWXYSfHp90hyMNHCQo=;
  b=GmH8G7h61+8vi6LU3Ae//jQEpl0sLtgc5Vjxen8lGJ3UTDVAycNjVKnK
   N4AgtXOOnCtBpK8qwz+8nnUQ3J4TJunP/yt4SGXgTBfQaORsz8huDNnoc
   esEkoo862PTFO+E+wqaoU8waTsiaCRquEhaM4tUFuiEDlFAargWC4AQB7
   aJk+W0LnDf4U/TeV/8KfNbN23h3l8NU7i5CNJK0oOCkZyKyLxr7KILMlL
   pNkQqrriAYzjD3BQi4+nC1Vlba85MDcXq4laCOym3o3YVd02SvAyVuMMQ
   qeRjWLCCo4fhJrfwAOhM82WH9O0aRKzdIZTumNyBwsB/JRrwZO6FnGZhc
   w==;
X-CSE-ConnectionGUID: Ste5H3MJQeSLmbKjECgIzg==
X-CSE-MsgGUID: mSH1NaqwSr6RTpYQmfvASA==
X-IronPort-AV: E=Sophos;i="6.14,237,1736784000"; 
   d="scan'208";a="46826386"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 11 Mar 2025 10:41:48 +0800
IronPort-SDR: 67cf9517_GvYUha1RRMLtllUkUIf6INwO2QWeP1/eL8aiyKC5HIRksFE
 HMCeOm8B4JK+P7SRuOM89KI/gjCEJukCWZsGGww==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Mar 2025 18:42:47 -0700
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip01.wdc.com with ESMTP; 10 Mar 2025 19:41:46 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Alan Adamson <alan.adamson@oracle.com>
Cc: virtualization@lists.linux.dev,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Sven Peter <sven@svenpeter.dev>,
	Janne Grunau <j@jannau.net>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH 0/2] block: nvme: fix blktests nvme/039 failure
Date: Tue, 11 Mar 2025 11:41:42 +0900
Message-ID: <20250311024144.1762333-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 1f47ed294a2b ("block: cleanup and fix batch completion adding
conditions") in the kernel tag v6.14-rc3 triggered blktests nvme/039
failure [1].

The test case injects errors to the NVMe driver and confirms the errors
are logged. The first half of the test checks it for non-passthrough
requests, and the second half checks for passthrough requests. The
commit made both halves fail.

This series addresses the test case failure. The first patch covers the
passthrough requests, and the second patch covers the non-passthrough
requests.

[1] https://lkml.kernel.org/linux-block/y7m5kyk5r2eboyfsfprdvhmoo27ur46pz3r2kwb4puhxjhbvt6@zgh4dg3ewya3/

Shin'ichiro Kawasaki (2):
  nvme: move error logging from nvme_end_req() to __nvme_end_req()
  block: change blk_mq_add_to_batch() third argument type to
    blk_status_t

 drivers/block/null_blk/main.c |  2 +-
 drivers/block/virtio_blk.c    |  5 +++--
 drivers/nvme/host/apple.c     |  3 ++-
 drivers/nvme/host/core.c      | 15 ++++++++-------
 drivers/nvme/host/nvme.h      |  1 +
 drivers/nvme/host/pci.c       |  5 +++--
 include/linux/blk-mq.h        |  5 +++--
 7 files changed, 21 insertions(+), 15 deletions(-)

-- 
2.47.0

