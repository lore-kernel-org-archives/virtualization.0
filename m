Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4A72BE647
	for <virtualization@lists.linux.dev>; Wed, 16 Jul 2025 11:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752667052; cv=none; b=UlwhVfZ67fK6qx20cUNKO4lDjIjzDciS8pPZK2q2dsQOzHRNCdKUmif/p69K96vfoyu7+xfOsDYq/4yYHYPj1h4PkMp/JXlRRFakxCFdlVtvmB7fKmzPkbE643Z0hvTqNKZ7uX1Mn5a2RlzBZSITEGGHePi1/H670oLonIYe5Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752667052; c=relaxed/simple;
	bh=csn7WYtvsUdjHkQMbcST2wsNn0ffcZxw8hDRTLxE6DA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ctuuWK5ESX5Ph9JClwXDs+ADZUbs6Xi0HoXZK/CovZFaNori8GMXiEjJPSkWe757CTocJrJfFuG0a2dw6W8hgRsntC3sCqI+Or54XKWnINmC3hnc8RXS3DqOniBJbDsRcmfchf3DEhhG4MfvBu2U/3e0/ogmOvvpqgWzKbNIH5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=YdIjergt; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="YdIjergt"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b3bdab4bf19so3550268a12.2
        for <virtualization@lists.linux.dev>; Wed, 16 Jul 2025 04:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1752667049; x=1753271849; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hLRTtR8co0X61jWgkdjoqtJ4EJUXMSFsfzr4OSlttHI=;
        b=YdIjergtWkn9UJshHTLN6LaFERpj7z48hvfgsvW9vmx8V9jwHEZThq66LwhMgv413I
         8l7rgsgREJKCTQwQ9S3ONzkUv2pK4ZYFM7mX3oU5+xoUwp5avrNWiH+Txl6LF1wM5qv8
         vIupkO4l/5ff9g6dj2uCTkVjZPJk6mD3AWh523bdvckSWrRYWP3KXuevZgsuITA6MR6f
         NB/0Z3W+ECneVDSjwypBop8j1I9YhdI4auNu/5/eOYZ7QpRyVmDqud1xLIaKpARYLNmn
         p+1pMBPfbg6ZXL8oOEDuiHEHBKw9amwgIfwforEpbR0JZ5bxiVjmcxdA6dOdCGLgthQX
         7hJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752667049; x=1753271849;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hLRTtR8co0X61jWgkdjoqtJ4EJUXMSFsfzr4OSlttHI=;
        b=iniaHNdBI/EnCNH/8xHskaQN42eKgCEsb88IGDhxhVMGiUIezANKyMb+I6vnv0OY6f
         EIPWaqVF6Rp6r1VJWqw62AoAs1WU9OyCEyQSF/PIEGhCRe415AF7/o/hYdQBVyXJ7i/e
         xHdCOZ6brHpdmbps7U6HRp7V8uTKk9H3X/qhfWt3LmkwSGk6PUCDUQBQHXw2nHlGYYea
         lXHrGbPAfH6oYEO4vL7YEABwZIbC4WOmmrwupbtwqq3/RYOdQuAxtlfuH7A2kgOW1pyK
         VmLcq+VHwlrSDqPazLhczflqmkJfrCPDrwg8cYLnzVqURunzTeXhOMq4MAFRjCWxINZ5
         w+UQ==
X-Forwarded-Encrypted: i=1; AJvYcCXIJE/6LYO0OryNb4xK/wov6X/XD/l5iabsFFngmrdnSVlR37gZ6wNEqCMwOgANRjzHWwrC45FBVKG4oQAKAA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxQAg2IERitlb2Ev6+M1lE/MI8BYd0hdpMyVy72MLqx87JzCN7P
	dCpWYdE4672BoZE5ZaUNGr2cLcf7zboTawTV7taW3izzNI4x6yUiNlh4Eh0D/qu3yW0=
X-Gm-Gg: ASbGnct8zNrD+xzL9Qf5/L6T/P+eu9Cf7sk5tbWghbYB5pwFm0zXVzAhYQpQI2AH7BL
	rsYjorImNajubsvf8fZyH9s8SYUmbK4FrfRKi1XATJYwHqSCW4oJj46jJdw/PIgfO71ABPcf4qd
	FWo9mrNG8Vrr8KQgM+/SA7jDETGY1NfGyP6we+XcORJ8vR55Tt7uAgdXYvHp6e6u832C+KuPUmf
	t1JEWDPjv1KjQXlhfQthYzTpgPCL+OuRscPXwCZXWElymF4ebCBwVtPejn2lwX4A91AiCxji8XV
	yUHO9GeIBsTAXkLqmFzfJ+EYeEbUCuh2TlgWfAfUDuvQ4hJUgh0E8Ib3litnmCc9Oon3pjLrnv4
	WP6qMAI52MpVrvRfrBk6q066IUxTwVezc
X-Google-Smtp-Source: AGHT+IEQPkNtoh9bRZW+IJ62bS4hVLKInbUmsPl/kIaslUF8mapeIjngutJf68Y6R1ZJMkkbtdUZ7Q==
X-Received: by 2002:a17:90b:1c89:b0:313:2768:3f6b with SMTP id 98e67ed59e1d1-31c9e77ce91mr4104373a91.27.1752667048532;
        Wed, 16 Jul 2025 04:57:28 -0700 (PDT)
Received: from vexas.. ([203.208.189.9])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c9f29ddcbsm1292668a91.36.2025.07.16.04.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 04:57:28 -0700 (PDT)
From: Zigit Zo <zuozhijie@bytedance.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com
Cc: zuozhijie@bytedance.com,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	edumazet@google.com
Subject: [PATCH net v3] virtio-net: fix recursived rtnl_lock() during probe()
Date: Wed, 16 Jul 2025 19:57:17 +0800
Message-ID: <20250716115717.1472430-1-zuozhijie@bytedance.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The deadlock appears in a stack trace like:

  virtnet_probe()
    rtnl_lock()
    virtio_config_changed_work()
      netdev_notify_peers()
        rtnl_lock()

It happens if the VMM sends a VIRTIO_NET_S_ANNOUNCE request while the
virtio-net driver is still probing.

The config_work in probe() will get scheduled until virtnet_open() enables
the config change notification via virtio_config_driver_enable().

Fixes: df28de7b0050 ("virtio-net: synchronize operstate with admin state on up/down")
Signed-off-by: Zigit Zo <zuozhijie@bytedance.com>
---
v3 -> v2:
* Simplify the changes.
v1 -> v2:
* Check vi->status in virtnet_open().
* https://lore.kernel.org/netdev/20250702103722.576219-1-zuozhijie@bytedance.com/
v1:
* https://lore.kernel.org/netdev/20250630095109.214013-1-zuozhijie@bytedance.com/
---
 drivers/net/virtio_net.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 5d674eb9a0f2..82b4a2a2b8c4 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -7059,7 +7059,7 @@ static int virtnet_probe(struct virtio_device *vdev)
 	   otherwise get link status from config. */
 	netif_carrier_off(dev);
 	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_STATUS)) {
-		virtnet_config_changed_work(&vi->config_work);
+		virtio_config_changed(vi->vdev);
 	} else {
 		vi->status = VIRTIO_NET_S_LINK_UP;
 		virtnet_update_settings(vi);

base-commit: dae7f9cbd1909de2b0bccc30afef95c23f93e477
-- 
2.49.0

