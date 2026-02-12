Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6373631A552
	for <virtualization@lists.linux.dev>; Thu, 12 Feb 2026 13:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770901438; cv=none; b=bVkJ5PzW3nO0T8s7hS282E1U32YN1BBShwo1w5p6JbLcI77VQYlfmlbNZfO15d8ndBsCUahogObp+S/EvC95B+sQHsKqMmM3YkZ9qaOK9dGStimHz6Mv4/fuzfPL2AYyzmXJq0a0TcGRS59KAhTXFZd5Z64JP2Drb6gTbICQZeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770901438; c=relaxed/simple;
	bh=EfLS4ZM7f5cRpk+TAS+xqWJ3cF3htCYIH5HHvc3mNg8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=H/6GhZL4V70+yD2ihaXeLuX5VZHOoE/AR7BX9DGrxhdzOAtCeKs1xQVyOu/0rOM1RUmKlQCBdQbztxVhc5z3My01Y7zljKSeFtV+YEBOGhpm76h/QqW+xJVjSqNnYEBufh/tNHsSnAWc9tGGv6yyZkynQYXoYscgHCy4OFNGExU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=i3LvwHf6; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="i3LvwHf6"
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61BLNov01274001;
	Thu, 12 Feb 2026 05:03:47 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=3woJmYNsewlYdtCBXzd3+ry
	fIzxYexwDJcAg74rOJn8=; b=i3LvwHf6wYw6jl5b6Yde8kQAwhKEnnlgOcqAMIY
	DEoUr1AeQvGnC/EO+4PbGC6vEQOuQhcqYPrBg6fds8Nv11fXBKTwadJ49Eqox4Q5
	KVZ1qwV6X+05kk2lbDX6xZlzCfp5rwMQZSjOsNvs6st53hP7MH+ZORwKKc4Icc/a
	5Kra8TTjAWtbN4zCEbk9lL+gq+zaFEsC22JnTUz6N6enx152YH2fZPy5jZgAe7Hn
	wCAr/WVPhM2h3hXI+L0HNI2eUx6XqoaoaXQeAQQ7543qpHXmxDtELAgMkyPDpVel
	h4ER4f0adJD19qjQ7wxiI6EuzYbH4X7/PFMNDkaLCSsYBrg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4c89g1nrk1-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Feb 2026 05:03:47 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 12 Feb 2026 05:04:03 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 12 Feb 2026 05:04:03 -0800
Received: from localhost.localdomain (unknown [10.28.36.175])
	by maili.marvell.com (Postfix) with ESMTP id B563D3F703F;
	Thu, 12 Feb 2026 05:03:41 -0800 (PST)
From: Srujana Challa <schalla@marvell.com>
To: <netdev@vger.kernel.org>, <virtualization@lists.linux.dev>
CC: <pabeni@redhat.com>, <mst@redhat.com>, <jasowang@redhat.com>,
        <xuanzhuo@linux.alibaba.com>, <eperezma@redhat.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <ndabilpuram@marvell.com>, <kshankar@marvell.com>,
        <schalla@marvell.com>, <stable@vger.kernel.org>
Subject: [PATCH v3,net] virtio_net: Improve RSS key size validation
Date: Thu, 12 Feb 2026 18:33:40 +0530
Message-ID: <20260212130340.3540415-1-schalla@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=ELgLElZC c=1 sm=1 tr=0 ts=698dcfb3 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8
 a=l6LeGXZaLw7GYeYAWxUA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEyMDA5NyBTYWx0ZWRfX0WbwK2tyd1wJ
 /Xuk35zeYc1CIyV+/Eh4bE8ceuV7hKDGM7jQZVO1PK5zhEqewcsvMIIzjJEOQEYQt94O0l+Rutg
 j+U+v4bqH8XQwYaq1bstvRK/8LeTRZmtVtvfWYzM6pWBL+lK8iRySiGui9IWunEMwKPBsBvC9sb
 a26RZJIetcUznrDKAvxvioZJG+dALKX4nuD5aRIdFQYzmWiFwrd6tp4Sow3DTbEXKUlarAkFV9j
 gRO4nETAAnKuSdQu/t1uKXwy+yKwg0gXuaK/xMuirqlOmT1rL92nbkf7EsPqZ7wXqKgalMV9/0c
 tTeZLEfiAxzGMiMc8PCL0Xab+/i9uFBeljEp+1VPBlBrsrCgfB1ICNbq/usgpDgmY/c/uNNSRIS
 8f4mRRxKZAFM0AcAN8+swOwMuXafA8+rtJhw8Gy6JrzDy7uk+vhVUBt2qHG8NOpRJ2tovAmplmy
 DmwsXN0nFk+BIPqqvuA==
X-Proofpoint-GUID: 076p7Qdxk9CoPxQLKMlhn7xdMoetfR5V
X-Proofpoint-ORIG-GUID: 076p7Qdxk9CoPxQLKMlhn7xdMoetfR5V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-12_03,2026-02-12_02,2025-10-01_01

Replace hardcoded RSS max key size limit with a type based definition.
Add validation for RSS key size against spec minimum (40 bytes). When
validation fails, gracefully disable RSS features and continue
initialization rather than failing completely.

Cc: stable@vger.kernel.org
Fixes: 3f7d9c1964fc ("virtio_net: Add hash_key_length check")
Signed-off-by: Srujana Challa <schalla@marvell.com>

v3:
- Moved RSS key validation checks to virtnet_validate.
- Add fixes: tag and CC -stable
---
 drivers/net/virtio_net.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index db88dcaefb20..e61cea50dcab 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -381,7 +381,9 @@ struct receive_queue {
 	struct xdp_buff **xsk_buffs;
 };
 
-#define VIRTIO_NET_RSS_MAX_KEY_SIZE     40
+#define VIRTIO_NET_RSS_MAX_KEY_SIZE \
+	(type_max(((struct virtio_net_config *)0)->rss_max_key_size) + 1)
+#define VIRTIO_NET_RSS_MIN_KEY_SIZE 40
 
 /* Control VQ buffers: protected by the rtnl lock */
 struct control_buf {
@@ -6627,6 +6629,24 @@ static int virtnet_validate(struct virtio_device *vdev)
 		__virtio_clear_bit(vdev, VIRTIO_NET_F_STANDBY);
 	}
 
+	if (virtio_has_feature(vdev, VIRTIO_NET_F_RSS) ||
+	    virtio_has_feature(vdev, VIRTIO_NET_F_HASH_REPORT)) {
+		u8 key_sz = virtio_cread8(vdev,
+					  offsetof(struct virtio_net_config,
+						   rss_max_key_size));
+		/* Spec requires at least 40 bytes */
+		if (key_sz < VIRTIO_NET_RSS_MIN_KEY_SIZE) {
+			dev_warn(&vdev->dev,
+				 "rss_max_key_size=%u is less than spec minimum %u, disabling RSS\n",
+				 key_sz, VIRTIO_NET_RSS_MIN_KEY_SIZE);
+			if (virtio_has_feature(vdev, VIRTIO_NET_F_RSS))
+				__virtio_clear_bit(vdev, VIRTIO_NET_F_RSS);
+			if (virtio_has_feature(vdev, VIRTIO_NET_F_HASH_REPORT))
+				__virtio_clear_bit(vdev,
+						   VIRTIO_NET_F_HASH_REPORT);
+		}
+	}
+
 	return 0;
 }
 
@@ -6839,13 +6859,6 @@ static int virtnet_probe(struct virtio_device *vdev)
 	if (vi->has_rss || vi->has_rss_hash_report) {
 		vi->rss_key_size =
 			virtio_cread8(vdev, offsetof(struct virtio_net_config, rss_max_key_size));
-		if (vi->rss_key_size > VIRTIO_NET_RSS_MAX_KEY_SIZE) {
-			dev_err(&vdev->dev, "rss_max_key_size=%u exceeds the limit %u.\n",
-				vi->rss_key_size, VIRTIO_NET_RSS_MAX_KEY_SIZE);
-			err = -EINVAL;
-			goto free;
-		}
-
 		vi->rss_hash_types_supported =
 		    virtio_cread32(vdev, offsetof(struct virtio_net_config, supported_hash_types));
 		vi->rss_hash_types_supported &=
-- 
2.25.1

