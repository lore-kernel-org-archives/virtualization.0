Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E1A1494D3
	for <virtualization@lists.linux.dev>; Wed,  3 Apr 2024 15:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712159006; cv=none; b=fk9IjIH9D6ZHPd8h8BvMmipgTbTDsSVBUAsiBJHhK4GNFLpZ0CVVrKxb7dAXxQarJH4aOu19q4hVgVggImhDD8XYbftv5cYdx67sqsbdEwL9sl/rV3qRqF9ps1snL1XZhmzeuWznaytzyaUrGdg2H/ieZTTsl2QdBCJDFFuYM+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712159006; c=relaxed/simple;
	bh=X3a4pIGTWIkMI9v/XpREqOBl8ZhpS8U+c8nUeSNcENM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iLlb4524mmzupQuKdkAM6uMbGjyWVzztBgW4fNWTTIjW7fwBXerl/CKXkXj7gbazRWFUUuySPeUJPzYt8U2oGXHiPh4SsOpCyyXrNBGSw9L3azYxZJXqzwDZQVSsV4padOLC1OHuMQquBx2hVxYbTt4NGJa/Ms9T+w6yZ882Pd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-56829f41f81so9549341a12.2
        for <virtualization@lists.linux.dev>; Wed, 03 Apr 2024 08:43:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712159003; x=1712763803;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WYy0xsk/6e7/EP3ZA06B/kwt1hnSoccxl0+aSYTRzhw=;
        b=fZK7ApwvCQiaLQDa7ILjlZkrqZMO35dIkkNtgFjQjtqTo1j5UOjM+Dai683cpNDmNr
         Tno+awYIO9bE+pga5IBm+jkMAhRrZ8OL74rfKxA3cmNAAnHIjrQP+yiGUnK3uzuk0P1f
         5um7rSAZcIYMZrSjgxX7RBob/BFslWnh9q35T8bExtg6xtMTQnm59+K5L8ySOWRjPAPY
         U5Vn1MuP/hrv7ouUKwLeEIKxBBNKIpzb4tps+wmG3dltozT2CftFSgTcc8T67RJ68oMG
         rApOmEb3MTJdX21lmtqKYCOX8V4oC+XTTcnZ0cXda0ML8PTis8zkWWp5aYOyPZrd/eRz
         w64A==
X-Forwarded-Encrypted: i=1; AJvYcCUMA/InVtZjdAkRfnxy+aXx9PCrr7wJN31Jyt8QPgXQguBUq1kDf+fZuB7OGdL2VEAdagAThUzEghidp8S3Ip0TkuDhZmyVBavhVwOM2z0=
X-Gm-Message-State: AOJu0Yzn+R2cARGxNHZWc4zkU2z2LGnT8FM5FsvNJsu33YqUw7PhhBhi
	vMrEe0MVdoLkY04di+20Dq0auQP2mkqkkoVx50jh0BOBd+xXXP4E
X-Google-Smtp-Source: AGHT+IGjMXBqyqOYrFRXxpu0T86R9H2NUxfGQRZ7Sm1nQSfyM8IFBGndg+xpb3YMbBIoQ8iZBhCSaA==
X-Received: by 2002:a17:907:868d:b0:a51:7d1a:e10d with SMTP id qa13-20020a170907868d00b00a517d1ae10dmr503935ejc.32.1712159002989;
        Wed, 03 Apr 2024 08:43:22 -0700 (PDT)
Received: from localhost (fwdproxy-lla-008.fbsv.net. [2a03:2880:30ff:8::face:b00c])
        by smtp.gmail.com with ESMTPSA id wn2-20020a170907068200b00a4e781bd30dsm3029235ejb.24.2024.04.03.08.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 08:43:22 -0700 (PDT)
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
Subject: [PATCH net v4] virtio_net: Do not send RSS key if it is not supported
Date: Wed,  3 Apr 2024 08:43:12 -0700
Message-ID: <20240403154313.1331319-1-leitao@debian.org>
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
Reviewed-by: Heng Qi <hengqi@linux.alibaba.com>
---
Changelog:

V2:
  * Moved from creating a valid packet, by rejecting the request
    completely.
V3:
  * Got some good feedback from and Xuan Zhuo and Heng Qi, and reworked
    the rejection path.
V4:
  * Added a comment in an "if" clause, as suggested by Michael S. Tsirkin.

---
 drivers/net/virtio_net.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index c22d1118a133..115c3c5414f2 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3807,6 +3807,7 @@ static int virtnet_set_rxfh(struct net_device *dev,
 			    struct netlink_ext_ack *extack)
 {
 	struct virtnet_info *vi = netdev_priv(dev);
+	bool update = false;
 	int i;
 
 	if (rxfh->hfunc != ETH_RSS_HASH_NO_CHANGE &&
@@ -3814,13 +3815,28 @@ static int virtnet_set_rxfh(struct net_device *dev,
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
+		/* If either _F_HASH_REPORT or _F_RSS are negotiated, the
+		 * device provides hash calculation capabilities, that is,
+		 * hash_key is configured.
+		 */
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
@@ -4729,13 +4745,15 @@ static int virtnet_probe(struct virtio_device *vdev)
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

