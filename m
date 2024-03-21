Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5203712C522
	for <virtualization@lists.linux.dev>; Thu, 21 Mar 2024 16:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711040105; cv=none; b=fVdXfCUzX36DGYitLwtYpPG1On2YPP3OeZgxAbSkqZacpeO6XKcPz97u0dh0LPZE/m6+eHpCnhVMMF5oymZRm/DsCPNG1clt23keBLekWiEaQej5QiFItfxsBC++L9dnOCm7Z18ZQvQutkoVRWYPYGYQMokZ1ZRffuEU/8hzNYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711040105; c=relaxed/simple;
	bh=rCBFI2/Sb/TgBo8zFSf6+nYs3exnoqd8nVE8RY19PjA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MQcf+10wNjE/0rwVRP9CAjF40xcjwdQc/qAZIUI+hvl0tXWcyX2C3Sc7mWUglr/kuVETllnMBsl51DZ7UfMsCmFq5eNy2lWwREl39Sbw6tJqxCQ66bdeMIIIew2dAg7ITBu7+myOb2+LuX/uP9JK2FXxgFcWnrnhfUcIujwjuzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5684db9147dso1349493a12.2
        for <virtualization@lists.linux.dev>; Thu, 21 Mar 2024 09:55:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711040099; x=1711644899;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ccIASRuLFeE03wCjAHLbamrjeo4bc7XautdiMnRXVho=;
        b=QYVjtYlC5lSS8tTQVos1BYZsjTZe02ID+oKVtd/CM0FMTsjNuEPlc10ChhPNYzZS7f
         3GlYo29Vyg5EUAsrYMyUfHEP3MUYqZyWJxU3NIEwQCodJYKZb/wpa3eYbsKfsiHk0f+t
         I17hJKchyQ5kNKk/meVRdKhPcYB0sIdov+yocAVNu+/O/TSj/Au0147RbIJrqzHKpqz3
         +oCkZNMfpFsMNmvKWzC6ucLRe1+m0BzfpGlq04g7hy9Ok4LLq5yEy8g/TrD1SW93jzvU
         NuBTsWcfV7Leg+Mi8ZDBt9dRlyJjJmxef9OpRnIugZJbxowv3xGFsPbA4UkJGJmnJnop
         qo/w==
X-Forwarded-Encrypted: i=1; AJvYcCWLk+3BcssWHuKszfZoQlw1eL/egE9OQhlkOdD6/1wyOQi/mEDvNfmM8fJBSAYMdv0iy0dU8hqI5YPOmYap9sL03r99Zs03AbCflzr9cQI=
X-Gm-Message-State: AOJu0YySaR9G4VWevRJVTEqKQc5a7XnsBLKZ+3fC+RpvEBUaqkrA0lIz
	mVnz/qixNzV+Rbg4SzhAETuggI0jVpwuh/dvfZqvszRTdB8CvP0H
X-Google-Smtp-Source: AGHT+IHe9TCxSTl6z2Gms7re62jr63VC4NJfpI1DXxe/3yVX/mluDaq35PbXeDEagIXyoqmGKtJLsQ==
X-Received: by 2002:a05:6402:5409:b0:56a:fbe9:80a4 with SMTP id ev9-20020a056402540900b0056afbe980a4mr5910560edb.1.1711040099434;
        Thu, 21 Mar 2024 09:54:59 -0700 (PDT)
Received: from localhost (fwdproxy-lla-118.fbsv.net. [2a03:2880:30ff:76::face:b00c])
        by smtp.gmail.com with ESMTPSA id d16-20020a056402401000b005686037bc12sm63505eda.29.2024.03.21.09.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 09:54:59 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
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
Subject: [PATCH] virtio_net: Do not send RSS key if it is not supported
Date: Thu, 21 Mar 2024 09:54:30 -0700
Message-ID: <20240321165431.3517868-1-leitao@debian.org>
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

Fix it by not sending the key scatter-gatter key if it is not set.

Fixes: c7114b1249fa ("drivers/net/virtio_net: Added basic RSS support.")
Signed-off-by: Breno Leitao <leitao@debian.org>
Cc: stable@vger.kernel.org
Cc: qemu-devel@nongnu.org
---
 drivers/net/virtio_net.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index d7ce4a1011ea..5a7700b103f8 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3041,11 +3041,16 @@ static int virtnet_set_ringparam(struct net_device *dev,
 static bool virtnet_commit_rss_command(struct virtnet_info *vi)
 {
 	struct net_device *dev = vi->dev;
+	int has_key = vi->rss_key_size;
 	struct scatterlist sgs[4];
 	unsigned int sg_buf_size;
+	int nents = 3;
+
+	if (has_key)
+		nents += 1;
 
 	/* prepare sgs */
-	sg_init_table(sgs, 4);
+	sg_init_table(sgs, nents);
 
 	sg_buf_size = offsetof(struct virtio_net_ctrl_rss, indirection_table);
 	sg_set_buf(&sgs[0], &vi->ctrl->rss, sg_buf_size);
@@ -3057,8 +3062,13 @@ static bool virtnet_commit_rss_command(struct virtnet_info *vi)
 			- offsetof(struct virtio_net_ctrl_rss, max_tx_vq);
 	sg_set_buf(&sgs[2], &vi->ctrl->rss.max_tx_vq, sg_buf_size);
 
-	sg_buf_size = vi->rss_key_size;
-	sg_set_buf(&sgs[3], vi->ctrl->rss.key, sg_buf_size);
+	if (has_key) {
+		/* Only populate if key is available, otherwise
+		 * populating a buffer with zero size breaks virtio
+		 */
+		sg_buf_size = vi->rss_key_size;
+		sg_set_buf(&sgs[3], vi->ctrl->rss.key, sg_buf_size);
+	}
 
 	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_MQ,
 				  vi->has_rss ? VIRTIO_NET_CTRL_MQ_RSS_CONFIG
-- 
2.43.0

