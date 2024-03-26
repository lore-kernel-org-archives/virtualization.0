Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A4E13C80C
	for <virtualization@lists.linux.dev>; Tue, 26 Mar 2024 15:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711466366; cv=none; b=X8SG1HP00ALllgVnf5aZ+GbCjuAiC2ET/0w1spSxOUsRS6F++r3DceuVXpx+dSpHNcYFRSA8e9ORLRe2DY+vLC7hya3n7OJgQvkeQVxY6Ijf3eA9MIcJ1RIVuBqCxc0hSkc/NsHowETthW3pe6h/Vj7cOT6DNG4J/BdPAnz9t9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711466366; c=relaxed/simple;
	bh=hHinf3uw5mGBk3XfcvWhk/gfoOKl1t3aCvp3XB22w68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tmoMt8aDuEeaM8BGSWvVyF24MhwiJ23WjicOD8/hhqDhVFLKu3FT9t1C+9AF6dApeRt53QMk0/VIlxf1OPiCKur3RqIRheXr2wpT024S2AN2HVKCXKTUzW1iK1Skg/f+qvpUFQJEYaE6aZsjeZ6QrBeL2IzW6DZ560mcIiUTrAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-513e89d0816so7059701e87.0
        for <virtualization@lists.linux.dev>; Tue, 26 Mar 2024 08:19:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711466363; x=1712071163;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JUVslbHxJBsutcvQ73cVdAnF0u3jUnm/TB9Hv1RCS88=;
        b=hykKVkU3p0T98G8kPBVwJhILmmYbS3/i0tN8AZgoVkvPf2BfmnuZ8Dh6nG+8tBKOd9
         IGLBwUJf3R2mvjtdByCDMLIOVXCB+xaFkU7qn1jOXL+zBwPy/ruU6I8XQPZSYhcJDMHD
         2QCyT9qoC4GPwnwIwm20nEFBsj9r8loeGrIFH1R6Ad/AYfDqrcpyGcv6aw4R9IoMbmrY
         edEVwi0NTg8knYtO/flkEMAynToBIS1pagDZnXhadKlhu4SmOk8zYRpULV7XFsIHpIBB
         ZGAqAjJV9L4vhpDbwaSmk0l0IJjYT0xHDX1PaSFwtytHJRsphM3MP+3wruwOWkJh3KF4
         QlgA==
X-Forwarded-Encrypted: i=1; AJvYcCW2BAKyb6nQs9CoXEKwMdCnrGVChdmxKD0sIyPibu/khCwIge1+2GEhfL7h9FlV/uTyye33xgWubEi2amQpLahT29GtcLiGWjsWldrAfV8=
X-Gm-Message-State: AOJu0YynA9aKUHtJMKHPFIq/vYbJebGetCAvmeFhQ+VE3hMUaYEouzNn
	VVNseAynObKowNVPmKwcShwrtYc56FgrGUn/YP0IUYGZmR24lfZK
X-Google-Smtp-Source: AGHT+IFP2FZZbpvO9c2stqUmT05DnUhkBn3keNu/tRQhmT0rhlV567sSQvXWBoBrIb87kTJm2cF7ag==
X-Received: by 2002:a05:6512:54e:b0:513:d522:b58c with SMTP id h14-20020a056512054e00b00513d522b58cmr6423792lfl.56.1711466363049;
        Tue, 26 Mar 2024 08:19:23 -0700 (PDT)
Received: from localhost (fwdproxy-lla-000.fbsv.net. [2a03:2880:30ff::face:b00c])
        by smtp.gmail.com with ESMTPSA id i16-20020a170906091000b00a4735fc654fsm4295335ejd.205.2024.03.26.08.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 08:19:22 -0700 (PDT)
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
Subject: [PATCH net v2 2/2] virtio_net: Do not send RSS key if it is not supported
Date: Tue, 26 Mar 2024 08:19:09 -0700
Message-ID: <20240326151911.2155689-2-leitao@debian.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240326151911.2155689-1-leitao@debian.org>
References: <20240326151911.2155689-1-leitao@debian.org>
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
 drivers/net/virtio_net.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index c640fdf28fc5..e6b0eaf08ac2 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3809,6 +3809,9 @@ static int virtnet_set_rxfh(struct net_device *dev,
 	struct virtnet_info *vi = netdev_priv(dev);
 	int i;
 
+	if (!vi->has_rss && !vi->has_rss_hash_report)
+		return -EOPNOTSUPP;
+
 	if (rxfh->hfunc != ETH_RSS_HASH_NO_CHANGE &&
 	    rxfh->hfunc != ETH_RSS_HASH_TOP)
 		return -EOPNOTSUPP;
-- 
2.43.0

