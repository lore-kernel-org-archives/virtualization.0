Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F188F33CC4
	for <virtualization@lists.linux.dev>; Fri, 29 Mar 2024 17:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711732618; cv=none; b=P+oMoa8uavQb6ona0ffnhdp2hqi2uAnqSTgjzYp9x9x6jk/r3Y8j0D4DY3K0Vhi8uZsTnlvMv/ZbGCYlI2ars3TpF4Q38rSJHEktVAanqs9EezCyIOjJAQHoSPfGrc1Yrgjp0+puA3ecC5tgXTvFRnRJiWQQcYu6WKw9miZQtDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711732618; c=relaxed/simple;
	bh=89L2hT9j8ZH6xSeMx6kL7OhHLwv6S7ZBlgaulX44G44=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UvlMEEhAckv+km1F2PEOBsiAIGKpBdmQB+JuFRn1XuoGuZNdxYEtBui8jDVPewZZ0JeLwU5bh+gX6ysQd/1FrTQDNLxGG9JMl14viKjHICjHVCewBRTYCs1cPG2poJiDrekv8ihu+wWXHs8/PjKSEsol+Ch4cZXryB7W0Pca4Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-56d7a0cf96cso685801a12.2
        for <virtualization@lists.linux.dev>; Fri, 29 Mar 2024 10:16:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711732613; x=1712337413;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hTKsJeBejVR4zYvKMWuByymkgZTrO1JGV3ZTFtbHxR4=;
        b=ck7b0pIFuBaFjCQP4BgT2fFSuTbU6W8KRzEKP/0Jv9Oviypa/1nQXKMJ+q62WJPT74
         y0TgtPvSfd1O7ChOkUdLKIJruzwZbNYriCheFRiU/f7UU0NbkutuoHR2ZxiEeK0R+BEZ
         55dilI2A0EQtCZKJ9kT1a8ldrg3DevMD9Bl9znlU+vDb/REK8ITdAx4vIzP+YwAktFWJ
         TtbI3CWo++LUeIu+H1p7hgAzlN9XO+risjvgzRFkC/RMuFo9BgkmzueTh7ivbg8RA6K0
         7Bdxj0sUpD3racOgvDDIZwlC28BQZVAXsdxp6wYPT4O2BdEx8KT79Y/klCpcY/HTnvdE
         KCcg==
X-Forwarded-Encrypted: i=1; AJvYcCV7nwVIQhK9gOY8McrOoSeNAza1QjNasmebs4qyDvn0+4f0ZmIlpMGpYIcM4MWeEFpbs24MiZjrWH2J5CJA3W090UzCs19Rr4hoDUUMm5Q=
X-Gm-Message-State: AOJu0Yw2lZ3NDk+rxZZ5m5ENmvZviDhUXaijwbq4mcNN1n9dVIMEHIY4
	BBM2x3/fnjg64ZGsA79IiUXE8ovEFzW5Pb/XNNvs0cMG88OWJako
X-Google-Smtp-Source: AGHT+IEOhTAJ2kk+k1zB7aww/76+35nhb1XyeU1rgxU55vXVijPYjJ5oUVM1Xv+Gs065gM9lKqmFxg==
X-Received: by 2002:a05:6402:34d4:b0:56b:9b11:9594 with SMTP id w20-20020a05640234d400b0056b9b119594mr2715983edc.2.1711732613087;
        Fri, 29 Mar 2024 10:16:53 -0700 (PDT)
Received: from localhost (fwdproxy-lla-116.fbsv.net. [2a03:2880:30ff:74::face:b00c])
        by smtp.gmail.com with ESMTPSA id u23-20020aa7d897000000b0056ba017ca7fsm2191542edq.87.2024.03.29.10.16.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 10:16:52 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: hengqi@linux.alibaba.com,
	xuanzhuo@linux.alibaba.com,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Melnychenko <andrew@daynix.com>
Cc: rbc@meta.com,
	riel@surriel.com,
	stable@vger.kernel.org,
	qemu-devel@nongnu.org,
	virtualization@lists.linux.dev (open list:VIRTIO CORE AND NET DRIVERS),
	netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net v3] virtio_net: Do not send RSS key if it is not supported
Date: Fri, 29 Mar 2024 10:16:41 -0700
Message-ID: <20240329171641.366520-1-leitao@debian.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a bug when setting the RSS options in virtio_net that can break
the whole machine, getting the kernel into an infinite loop.

Running the following command in any QEMU virtual machine with virtionet
will reproduce this problem:

    # ethtool -X eth0  hfunc toeplitz

This is how the problem happens:

1) ethtool_set_rxfh() calls virtnet_set_rxfh()

2) virtnet_set_rxfh() calls virtnet_commit_rss_command()

3) virtnet_commit_rss_command() populates 4 entries for the rss
scatter-gather

4) Since the command above does not have a key, then the last
scatter-gatter entry will be zeroed, since rss_key_size == 0.
sg_buf_size = vi->rss_key_size;

5) This buffer is passed to qemu, but qemu is not happy with a buffer
with zero length, and do the following in virtqueue_map_desc() (QEMU
function):

  if (!sz) {
      virtio_error(vdev, "virtio: zero sized buffers are not allowed");

6) virtio_error() (also QEMU function) set the device as broken

    vdev->broken = true;

7) Qemu bails out, and do not repond this crazy kernel.

8) The kernel is waiting for the response to come back (function
virtnet_send_command())

9) The kernel is waiting doing the following :

      while (!virtqueue_get_buf(vi->cvq, &tmp) &&
	     !virtqueue_is_broken(vi->cvq))
	      cpu_relax();

10) None of the following functions above is true, thus, the kernel
loops here forever. Keeping in mind that virtqueue_is_broken() does
not look at the qemu `vdev->broken`, so, it never realizes that the
vitio is broken at QEMU side.

Fix it by not sending RSS commands if the feature is not available in
the device.

Fixes: c7114b1249fa ("drivers/net/virtio_net: Added basic RSS support.")
Cc: stable@vger.kernel.org
Cc: qemu-devel@nongnu.org
Signed-off-by: Breno Leitao <leitao@debian.org>
---
Changelog:

V2:
  * Moved from creating a valid packet, by rejecting the request
    completely
V3:
  * Got some good feedback from and Xuan Zhuo and Heng Qi, and reworked
    the rejection path.

---
 drivers/net/virtio_net.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index c22d1118a133..c4a21ec51adf 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3807,6 +3807,7 @@ static int virtnet_set_rxfh(struct net_device *dev,
 			    struct netlink_ext_ack *extack)
 {
 	struct virtnet_info *vi = netdev_priv(dev);
+	bool update = false;
 	int i;
 
 	if (rxfh->hfunc != ETH_RSS_HASH_NO_CHANGE &&
@@ -3814,13 +3815,24 @@ static int virtnet_set_rxfh(struct net_device *dev,
 		return -EOPNOTSUPP;
 
 	if (rxfh->indir) {
+		if (!vi->has_rss)
+			return -EOPNOTSUPP;
+
 		for (i = 0; i < vi->rss_indir_table_size; ++i)
 			vi->ctrl->rss.indirection_table[i] = rxfh->indir[i];
+		update = true;
 	}
-	if (rxfh->key)
+
+	if (rxfh->key) {
+		if (!vi->has_rss && !vi->has_rss_hash_report)
+			return -EOPNOTSUPP;
+
 		memcpy(vi->ctrl->rss.key, rxfh->key, vi->rss_key_size);
+		update = true;
+	}
 
-	virtnet_commit_rss_command(vi);
+	if (update)
+		virtnet_commit_rss_command(vi);
 
 	return 0;
 }
@@ -4729,13 +4741,15 @@ static int virtnet_probe(struct virtio_device *vdev)
 	if (virtio_has_feature(vdev, VIRTIO_NET_F_HASH_REPORT))
 		vi->has_rss_hash_report = true;
 
-	if (virtio_has_feature(vdev, VIRTIO_NET_F_RSS))
+	if (virtio_has_feature(vdev, VIRTIO_NET_F_RSS)) {
 		vi->has_rss = true;
 
-	if (vi->has_rss || vi->has_rss_hash_report) {
 		vi->rss_indir_table_size =
 			virtio_cread16(vdev, offsetof(struct virtio_net_config,
 				rss_max_indirection_table_length));
+	}
+
+	if (vi->has_rss || vi->has_rss_hash_report) {
 		vi->rss_key_size =
 			virtio_cread8(vdev, offsetof(struct virtio_net_config, rss_max_key_size));
 
-- 
2.43.0

