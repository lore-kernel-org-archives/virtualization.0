Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0EB2931E3
	for <virtualization@lists.linux.dev>; Tue, 11 Aug 2026 02:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786414749; cv=none; b=Yy0HpfHGiTUgtvosQ2X1jFQwTwe6Lf/YIZu5hXbkZxfhlwL0D5pN4JnyXsUOjXR1gHpYJ6ZXheM4qZo0ukhCTK9FgK/ftGLZYvm/MW6HDU/Ljc/MwJWyjrdWLtDfUgte6Q3XnuWLp6jj5zk+tdkavNSroEazcjLSoO0Hg+xROWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786414749; c=relaxed/simple;
	bh=CFn2HbdpfUMtoNH8ZuvuuA2iPn83pn2jTSB/3ln6ux4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SBlkKZ8bcplLYX7KER8IqlkYbx3DoGpKep2jAZnUG+RhCwWtbnt9c4AUkpsSbGRw/SeXhhLsY8Ba2ylp3OLcUC/nOxggcdGHISlJeXSF4eGoVSKaFE5AMWE1/L62PkoXF7aeA4kaMU/U5cXunxXB20do8JFE9ACYjDTyI27IYG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 054f9e18952b11f1aa26b74ffac11d73-20260811
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:abc0ebec-63a5-414b-bead-13dff9d800a8,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:e7bac3a,CLOUDID:fa4d02fda70af90fa5aa4847e10bba74,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|136|865|898,TC:nil,Content:0|15|50,E
	DM:5|-100,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0
	,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 054f9e18952b11f1aa26b74ffac11d73-20260811
X-User: xiongweimin@kylinos.cn
Received: from xwm-tianyi510pro-14imb.. [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiongweimin@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1352161534; Tue, 11 Aug 2026 10:19:03 +0800
From: Xiong Weimin <xiongweimin@kylinos.cn>
To: mst@redhat.com
Cc: kuba@kernel.org,
	jasowang@redhat.com,
	netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Xiong Weimin <xiongweimin@kylinos.cn>
Subject: [PATCH] virtio_net: roll back RSS state on control failure
Date: Tue, 11 Aug 2026 10:19:00 +0800
Message-ID: <20260811021900.3464410-1-xiongweimin@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ethtool RSS and RXHASH paths update the driver's cached RSS state
before committing the change to the device.  If the control virtqueue
command fails, the cached hash types, key or indirection table can then
report a configuration that the device did not accept.

Preserve the previous local state around RSS/hash control commands and
restore it when the device update fails, while propagating the error to
the caller.

v1 -> v2:
  - Use kvmemdup() instead of kmemdup() in virtnet_set_rxfh() for the
    saved RSS header, since the indirection table can push the header
    size up to ~128K.

Signed-off-by: Xiong Weimin <xiongweimin@kylinos.cn>
---
 drivers/net/virtio_net.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index ccd96315a..995ca4640 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -5573,8 +5573,8 @@ static int virtnet_set_rxfh(struct net_device *dev,
 	}
 
 	if (rxfh->indir) {
-		old_rss_hdr = kmemdup(vi->rss_hdr, virtnet_rss_hdr_size(vi),
-				      GFP_KERNEL);
+		old_rss_hdr = kvmemdup(vi->rss_hdr, virtnet_rss_hdr_size(vi),
+				       GFP_KERNEL);
 		if (!old_rss_hdr)
 			return -ENOMEM;
 
-- 
2.43.0
