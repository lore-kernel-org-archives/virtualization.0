Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0842356D3;
	Tue, 11 Mar 2025 10:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.143.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741689851; cv=none; b=arS73R8Jdj5/yWfacITHuNJdqJ9EuQdj1QObS9LYe9GyEMNTgCXoRNsJyywsvdbTUhDQu2yoX811Ox3Ft623mj+KaMe9N9AvKNW2/V2vKakp12SSTtD0JEKG8sJD5GKVNur89KXe8IBJiWgFHjqpGre5AVvMlXUrLyaoYUrCkjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741689851; c=relaxed/simple;
	bh=tOzGi1+oE4i2IJoUxhsL9xdE2CFvuKnrU3TH/IWp1Uw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FzV5TwJIsJZ0CkmSOCx0EabxGckDMieoJT1+eZXGXkQ2roNu6z+p4FrwxdHPgJBcQPQ0gws2obdc9wxHgWsUXodam2mlwLRflBjLEyP/R8vUIa7IogqU9sGWDIzabksWTQatYrjNQF0mQP7Pzn+kxsUcbZie8zHZyCcpq6PNlH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=WhLfVkP2; arc=none smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="WhLfVkP2"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1741689849; x=1773225849;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tOzGi1+oE4i2IJoUxhsL9xdE2CFvuKnrU3TH/IWp1Uw=;
  b=WhLfVkP2QKhSGgS8eIWZtQk+z+EY2KprwA7AFzeJTQ71J1S6q72ZLBNh
   tQrBfTajgq1+J8bXzGC01GfIQBPQKYvEhVW+lWcQlBZ9Cfa7lad5Bhv5M
   TtsQB2RomAsxYZZSkzgBOtCFz0OGOXIZzCpmcb8XEbKQOBifOZfr3igzj
   d7KZxMk0PgnfWZHV1FUIS2p1EOQFFZjCQCJF1lD0KBPSdgCKylnB+Cb2W
   kXWJtlIpnKIGihOYLWHzGEhvTcmxy2xlM07W0TmbgYC0whukLD/ZummFR
   MrTjs1vL7N+RDfpFErDrDHBvkkbnPQZsLCnpVPBfmMQBKAvyjNC6MdmVW
   g==;
X-CSE-ConnectionGUID: GXH8IgrFSJ6PCLI32KKlpg==
X-CSE-MsgGUID: 0xG1Jhb9SWW1ugCPT8EfWA==
X-IronPort-AV: E=Sophos;i="6.14,238,1736784000"; 
   d="scan'208";a="47728707"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 11 Mar 2025 18:44:02 +0800
IronPort-SDR: 67d0061d_jl0FgI4kEXCFm7V4DqvKXrJam9/zYQmhcQVQhY9bHLcgX3q
 ZQy6MS6152w4bSBhvBqdG2LCy9kxCBQiydYIRuA==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Mar 2025 02:45:01 -0700
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip01.wdc.com with ESMTP; 11 Mar 2025 03:43:59 -0700
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
	Hannes Reinecke <hare@suse.de>,
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
Subject: [PATCH v2 0/2] block: nvme: fix blktests nvme/039 failure
Date: Tue, 11 Mar 2025 19:43:57 +0900
Message-ID: <20250311104359.1767728-1-shinichiro.kawasaki@wdc.com>
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

Changes from v1:
* 1st patch: Added Reviewed-by tags
* 2nd patch: Replaced argument blk_status_t with boolean 'is_error'
             Added kerneldoc of blk_mq_add_to_batch() arguments

Shin'ichiro Kawasaki (2):
  nvme: move error logging from nvme_end_req() to __nvme_end_req()
  block: change blk_mq_add_to_batch() third argument type to bool

 drivers/block/null_blk/main.c |  4 ++--
 drivers/block/virtio_blk.c    |  5 +++--
 drivers/nvme/host/apple.c     |  3 ++-
 drivers/nvme/host/core.c      | 12 ++++++------
 drivers/nvme/host/pci.c       |  5 +++--
 include/linux/blk-mq.h        | 11 ++++++++---
 6 files changed, 24 insertions(+), 16 deletions(-)

-- 
2.47.0

