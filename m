Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800C823F388;
	Tue, 11 Mar 2025 10:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.143.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741689853; cv=none; b=t5PKgRouOb9kTbm7rjAgVIMTwxaFS3+KMlKVtk4QwLiyRPxeL7i0MhnMBegh3909pUlEA6DD7X1DW5ntpDL43kv3SFuT1iavPsuDEvl7tOoTzvrH4y6hYvghRzF69mqaNXrwDdZyNQgBhTRKCcUgt+ABWZbpwFRecKDPePbnY0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741689853; c=relaxed/simple;
	bh=qZkpL8+UK4Jf7ALWWjcCeKVGPKdF94sM7MXUzKsePGs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DxlfA7KQ6wFk5qx7lcISuCv3Blvg/C7ClqLE+gRjFrRwSv35d8f/OvIy/NlSHtBXSry8pxJvRYndjqbY222LDAHDMjAzs5km2eejdKALCoBomycmU/GdvDdoWj9OHiG0lwVFLe8A8FKglefkOZNQBsWHC4L5xG31LB8wKaHeaXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=U82T3h+2; arc=none smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="U82T3h+2"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1741689851; x=1773225851;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qZkpL8+UK4Jf7ALWWjcCeKVGPKdF94sM7MXUzKsePGs=;
  b=U82T3h+2r44hOCOZn9qc1sULQq91fCqetCUwGeJl6yJ9p4+fv3NViJUt
   jNwG5mGICwb8V65nDKuDyOsOudU5A+bau2Eu8XPiD+xsiJnr36Kreqzgp
   kNLiM+Uo4HHhF9gIbQkZNZHW1r3uAYd6rpmE5+0eCHHax2WNxH1FhGZsg
   TXAqhlftgCa7wtWT5vnYH6/zxPFe9xCQv8PJJCXcClpjUakg9B9NjAFj5
   +5JlMxXuVPE3+xkn6QvlHaUUQV5AqgBFkigQTke/qrVAOPWm/D/VEorja
   WE42MXLr9x/3vvbDaUzVx2HZITfcBOhLA19DWN6iS35erHT1FE+61AVLC
   Q==;
X-CSE-ConnectionGUID: jeonbu/aSQiCgBx/Exp+PA==
X-CSE-MsgGUID: sLKAmKVlSW+XXVUebw7L6Q==
X-IronPort-AV: E=Sophos;i="6.14,238,1736784000"; 
   d="scan'208";a="47728713"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 11 Mar 2025 18:44:05 +0800
IronPort-SDR: 67d00620_UEgOASu8nZ3BJL2aYaoTQZmTJohu1KKOah8gwStXtlHqXRo
 244g14JGmBmURrQJIjvENCEDXtwrc0Zk+C13uOA==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Mar 2025 02:45:04 -0700
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip01.wdc.com with ESMTP; 11 Mar 2025 03:44:02 -0700
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
Subject: [PATCH v2 1/2] nvme: move error logging from nvme_end_req() to __nvme_end_req()
Date: Tue, 11 Mar 2025 19:43:58 +0900
Message-ID: <20250311104359.1767728-2-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250311104359.1767728-1-shinichiro.kawasaki@wdc.com>
References: <20250311104359.1767728-1-shinichiro.kawasaki@wdc.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Before the Commit 1f47ed294a2b ("block: cleanup and fix batch completion
adding conditions"), blk_mq_add_to_batch() did not add failed
passthrough requests to batch, and returned false. After the commit,
blk_mq_add_to_batch() always adds passthrough requests to batch
regardless of whether the request failed or not, and returns true. This
affected error logging feature in the NVME driver.

Before the commit, the call chain of failed passthrough request was as
follows:

nvme_handle_cqe()
 blk_mq_add_to_batch() .. false is returned, then call nvme_pci_complete_rq()
 nvme_pci_complete_rq()
  nvme_complete_rq()
   nvme_end_req()
    nvme_log_err_passthru() .. error logging
    __nvme_end_req()        .. end of the rqeuest

After the commit, the call chain is as follows:

nvme_handle_cqe()
 blk_mq_add_to_batch() .. true is returned, then set nvme_pci_complete_batch()
 ..
 nvme_pci_complete_batch()
  nvme_complete_batch()
   nvme_complete_batch_req()
    __nvme_end_req() .. end of the request, without error logging

To make the error logging feature work again for passthrough requests, move the
nvme_log_err_passthru() call from nvme_end_req() to __nvme_end_req().

While at it, move nvme_log_error() call for non-passthrough requests together
with nvme_log_err_passthru(). Even though the trigger commit does not affect
non-passthrough requests, move it together for code simplicity.

Fixes: 1f47ed294a2b ("block: cleanup and fix batch completion adding conditions")
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f028913e2e62..8359d0aa0e44 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -431,6 +431,12 @@ static inline void nvme_end_req_zoned(struct request *req)
 
 static inline void __nvme_end_req(struct request *req)
 {
+	if (unlikely(nvme_req(req)->status && !(req->rq_flags & RQF_QUIET))) {
+		if (blk_rq_is_passthrough(req))
+			nvme_log_err_passthru(req);
+		else
+			nvme_log_error(req);
+	}
 	nvme_end_req_zoned(req);
 	nvme_trace_bio_complete(req);
 	if (req->cmd_flags & REQ_NVME_MPATH)
@@ -441,12 +447,6 @@ void nvme_end_req(struct request *req)
 {
 	blk_status_t status = nvme_error_status(nvme_req(req)->status);
 
-	if (unlikely(nvme_req(req)->status && !(req->rq_flags & RQF_QUIET))) {
-		if (blk_rq_is_passthrough(req))
-			nvme_log_err_passthru(req);
-		else
-			nvme_log_error(req);
-	}
 	__nvme_end_req(req);
 	blk_mq_end_request(req, status);
 }
-- 
2.47.0

