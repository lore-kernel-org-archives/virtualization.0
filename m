Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4965A247280
	for <virtualization@lists.linux.dev>; Mon, 30 Jun 2025 09:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751277082; cv=none; b=UeTYwJ5o0C9xFt5hcqHpblKaWLvMJ3cVg33HKnAemUmrjtAGwh4QBd+NNlB/4kVLz54pbXacuLdNrTvV9m8/PT25qvZ8WZHfkoqWXpn25bpI8rPgfhsuUriFE0iYF1BgUzyjuZ+f6RcJlOKCS+U+jngsesN+5CaU3G1RkJFuIfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751277082; c=relaxed/simple;
	bh=iqcbsqqx91hRFW3nOeQh2fCgpjZp4yNOzZLmUmGbW98=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dAUW/EvM2PEKDaeBwCc9B4oFe8eplzApDWiL+IIdrfg1oHAPIwxoLbIxc9xZsnQ97bo9h1rfYit95Hfe0OV4zMbfvPdA5HrWU/4ZjQzGSKjVZnSFBTrFMyj/EWtcAxuU1iGb8WIW8On0fHrJWXsUsAYynl6XdNqXiYyl/ulVX/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=T1HCxY0y; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="T1HCxY0y"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-311ef4fb43dso1414212a91.3
        for <virtualization@lists.linux.dev>; Mon, 30 Jun 2025 02:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1751277077; x=1751881877; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1axG9UN4guwGf2MhIje1rzGErylNfM2qtIpn5Wq0YrA=;
        b=T1HCxY0yuwxM4FN8JQ+66qXoAOWBRx13vF2vOvMX3sLjVlA/QB3AtbDUaqbKL0zH97
         ScnTUkFrEAedn917goj2T/aWXkyQEo6rkl8Pr4KXO0lhMvj4MheGeSA+HhLVMi/a5kN2
         +eqdL2VK7ld6YjHqKeOITFh5f0yKnWQLIWVhY2gRWFbh7PmcuAjc5VXAbrRm1nBEYawU
         4YPAt5wY/k6+4FU47kHf3YgfvP11HWlpNeixMbEMG+FeE4WEz6qlDkj05iJjROW92ApZ
         4CQatIDDInL7kxfQFRvCU2rIYZuo6O9WUlv7q/WSESBu+x6vNbeNCH6f4fDZGbrRZ8Z+
         b7wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751277077; x=1751881877;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1axG9UN4guwGf2MhIje1rzGErylNfM2qtIpn5Wq0YrA=;
        b=eEZ8eydF1FkHukzGE4nmAUSZL2F85TtunQ1AO449ykZrkbXwjHzH7TdmL3DkJJLfSA
         Smc5mR9mmjFB54N4Yk+m+G160/r7cIZAnBbcAQr1TMh8Ip+3IjZqbdRL7axH97qPolts
         zycZxvtMmritsY5vGJ3XU1eyU9MpchuTh/xP2Paco8mturZ8CESbPsPNRh2EqJXKJ527
         j37ormZXPNhu6Oe4NTAimP/FbiVlmqL/iDBO0RpGmEnIC97cGw3Ffu2xXjo/orBNsG3h
         eNojT7j3cuGpfS3mzpRhubNX2fow6DE2QD/CLwDyntYeNxucFt7mjo5VJs+jRoCjr9l0
         kd5g==
X-Forwarded-Encrypted: i=1; AJvYcCU0oHeqS4/Zlc1woyuWkjZ/MFDoGD7xIdouhhOrI+21+rzK7hIoQVKy45dWxJhDn4AGZRG7uZvTTDBSM0RqHA==@lists.linux.dev
X-Gm-Message-State: AOJu0YywPq05g3WU+OmmAkSwUh3QXb5IV4ZUhhJ7h07ivgVl/5dFapK1
	2CWIQeqcq2QZx2Bji3BhGScMDfTkg+8+YBgCc8j6NMAOjYJ6hS1WIN9I+JChB8bb14g=
X-Gm-Gg: ASbGncvjCDbiYgbXyvpNIDhX5I5lR80h+5nHJ5neP16Zmi3EBL3D5R8JkQOJgyMDNrK
	DOd7zxO3Cn8NhUASOy+Xo7FxzHcwa9XQLhgHIefZuLow1T4yWN68Cw7lswLGaaxPVbKk3vmE29W
	Npa6BIIT5TqwGmuyBBl8hPiu116H1KtEpEL6zhbw4ZaoMoulsySI6+ynIIrTaU9P5lGFIB7Sslz
	FNSWKNDcLsKC1ASbPr/wO6oRmlrYMpaB9MmrCmJDV3JofPxcGQFeqZxQ4vz8+cClUE2PveaRF6l
	n3T6bbkUVKXbfYCk8OhuGcysI8vCfBuqits1co1S01WclBdlT9NMUNSx4ouvqNkLc826yCpk
X-Google-Smtp-Source: AGHT+IHPgTj4lH/A7AaOqx4zS1bLYGSTxDSUFaa71SvEDg6oNnPYe86WGVy9RGJSkXmiLAkS60LykA==
X-Received: by 2002:a17:90b:35ce:b0:312:db8:dbdd with SMTP id 98e67ed59e1d1-318c925a50fmr17658008a91.28.1751277077433;
        Mon, 30 Jun 2025 02:51:17 -0700 (PDT)
Received: from vexas.. ([203.208.189.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-318c14e18bbsm8409468a91.23.2025.06.30.02.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 02:51:17 -0700 (PDT)
From: Zigit Zo <zuozhijie@bytedance.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com
Cc: zuozhijie@bytedance.com,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] virtio-net: fix a rtnl_lock() deadlock during probing
Date: Mon, 30 Jun 2025 17:51:09 +0800
Message-ID: <20250630095109.214013-1-zuozhijie@bytedance.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This bug happens if the VMM sends a VIRTIO_NET_S_ANNOUNCE request while
the virtio-net driver is still probing with rtnl_lock() hold, this will
cause a recursive mutex in netdev_notify_peers().

Fix it by skip acking the annouce in virtnet_config_changed_work() when
probing. The annouce will still get done when ndo_open() enables the
virtio_config_driver_enable().

We've observed a softlockup with Ubuntu 24.04, and can be reproduced with
QEMU sending the announce_self rapidly while booting.

[  494.167473] INFO: task swapper/0:1 blocked for more than 368 seconds.
[  494.167667]       Not tainted 6.8.0-57-generic #59-Ubuntu
[  494.167810] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  494.168015] task:swapper/0       state:D stack:0     pid:1     tgid:1     ppid:0      flags:0x00004000
[  494.168260] Call Trace:
[  494.168329]  <TASK>
[  494.168389]  __schedule+0x27c/0x6b0
[  494.168495]  schedule+0x33/0x110
[  494.168585]  schedule_preempt_disabled+0x15/0x30
[  494.168709]  __mutex_lock.constprop.0+0x42f/0x740
[  494.168835]  __mutex_lock_slowpath+0x13/0x20
[  494.168949]  mutex_lock+0x3c/0x50
[  494.169039]  rtnl_lock+0x15/0x20
[  494.169128]  netdev_notify_peers+0x12/0x30
[  494.169240]  virtnet_config_changed_work+0x152/0x1a0
[  494.169377]  virtnet_probe+0xa48/0xe00
[  494.169484]  ? vp_get+0x4d/0x100
[  494.169574]  virtio_dev_probe+0x1e9/0x310
[  494.169682]  really_probe+0x1c7/0x410
[  494.169783]  __driver_probe_device+0x8c/0x180
[  494.169901]  driver_probe_device+0x24/0xd0
[  494.170011]  __driver_attach+0x10b/0x210
[  494.170117]  ? __pfx___driver_attach+0x10/0x10
[  494.170237]  bus_for_each_dev+0x8d/0xf0
[  494.170341]  driver_attach+0x1e/0x30
[  494.170440]  bus_add_driver+0x14e/0x290
[  494.170548]  driver_register+0x5e/0x130
[  494.170651]  ? __pfx_virtio_net_driver_init+0x10/0x10
[  494.170788]  register_virtio_driver+0x20/0x40
[  494.170905]  virtio_net_driver_init+0x97/0xb0
[  494.171022]  do_one_initcall+0x5e/0x340
[  494.171128]  do_initcalls+0x107/0x230
[  494.171228]  ? __pfx_kernel_init+0x10/0x10
[  494.171340]  kernel_init_freeable+0x134/0x210
[  494.171462]  kernel_init+0x1b/0x200
[  494.171560]  ret_from_fork+0x47/0x70
[  494.171659]  ? __pfx_kernel_init+0x10/0x10
[  494.171769]  ret_from_fork_asm+0x1b/0x30
[  494.171875]  </TASK>

Fixes: df28de7b0050 ("virtio-net: synchronize operstate with admin state on up/down")
Signed-off-by: Zigit Zo <zuozhijie@bytedance.com>
---
 drivers/net/virtio_net.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index e53ba600605a..0290d289ebee 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -6211,7 +6211,8 @@ static const struct net_device_ops virtnet_netdev = {
 	.ndo_tx_timeout		= virtnet_tx_timeout,
 };
 
-static void virtnet_config_changed_work(struct work_struct *work)
+static void __virtnet_config_changed_work(struct work_struct *work,
+					  bool check_announce)
 {
 	struct virtnet_info *vi =
 		container_of(work, struct virtnet_info, config_work);
@@ -6221,7 +6222,7 @@ static void virtnet_config_changed_work(struct work_struct *work)
 				 struct virtio_net_config, status, &v) < 0)
 		return;
 
-	if (v & VIRTIO_NET_S_ANNOUNCE) {
+	if (check_announce && (v & VIRTIO_NET_S_ANNOUNCE)) {
 		netdev_notify_peers(vi->dev);
 		virtnet_ack_link_announce(vi);
 	}
@@ -6244,6 +6245,11 @@ static void virtnet_config_changed_work(struct work_struct *work)
 	}
 }
 
+static void virtnet_config_changed_work(struct work_struct *work)
+{
+	__virtnet_config_changed_work(work, true);
+}
+
 static void virtnet_config_changed(struct virtio_device *vdev)
 {
 	struct virtnet_info *vi = vdev->priv;
@@ -7030,7 +7036,10 @@ static int virtnet_probe(struct virtio_device *vdev)
 	   otherwise get link status from config. */
 	netif_carrier_off(dev);
 	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_STATUS)) {
-		virtnet_config_changed_work(&vi->config_work);
+		/* The check_annouce work will get scheduled when ndo_open()
+		 * doing the virtio_config_driver_enable().
+		 */
+		__virtnet_config_changed_work(&vi->config_work, false);
 	} else {
 		vi->status = VIRTIO_NET_S_LINK_UP;
 		virtnet_update_settings(vi);

base-commit: 2def09ead4ad5907988b655d1e1454003aaf8297
-- 
2.49.0

