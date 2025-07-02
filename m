Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099FD2571AC
	for <virtualization@lists.linux.dev>; Wed,  2 Jul 2025 10:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751452657; cv=none; b=bmqOgP2nrT7LRD2qdrXtvpwPdN3UEQt8fv+uL6g2rZMBAUxWiDBUffvQvjMq3ajqHvoK1Bjxc2ibH1r/5gHV0ga/tzELgjlKsmvHWOaK1qnp5lbPx63PVg/xfSs2fhq9Fu6VU+Qw08Ojpacsx2yMSjTfgFp67Sh7VkaQTBtkL8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751452657; c=relaxed/simple;
	bh=5TsIlHMOqUqTuoTUEe3ywov4SmaUQtSaropRxRMo6AE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MP+jsuLuit5mOk/gxkkI+QEKjmD6spin6I3rmq1P97lhExF4xx2MQDw3suhLOm7pS935rRTVJSgMZU29jfGiPmypb9ndxLiiw1XV2nxpzb69N+wIrRsj3OjnIEWoHOlJCS1YH0+J5euhVFd6SlKqnxCMuRCRMx1VswSV4AqZIbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=fZ4M8cUg; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="fZ4M8cUg"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-313bb9b2f5bso6857959a91.3
        for <virtualization@lists.linux.dev>; Wed, 02 Jul 2025 03:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1751452655; x=1752057455; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dp8QDDHxGgYM4d2YqBrz5e3aQ8kR4QlztrSv4nHpc30=;
        b=fZ4M8cUgeva8Z3iI4b7V4/ypUo0CSb/sIv3PzhTCJca7Eegxy43vfcYjkZKuJovcWV
         a7OqsqGEZ2DMWAaqopBanqEZ+1S66cWW7vhCrC88+RmqECH/Pa/hCwZxQezLVt42nsT5
         Udzugfq/eN4Uw7idAQV65oK+xrqIS9EWM3p+fFjLzkPS1weG8WY7lwUHksjuQzQ+LUwy
         xpUfwA+NYOm4MEcbXf8mNnMo4SdjM4WI87gRwWjT7gMWp8+iyol+PDBqUjEoZrP50oX1
         gQQVAUPdvMiiuwIde4KZGWaWXMhXZT8plE17ZctxHa5JtBQS52mCncPY+NKr3wETAM03
         ldyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751452655; x=1752057455;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dp8QDDHxGgYM4d2YqBrz5e3aQ8kR4QlztrSv4nHpc30=;
        b=So8aqPHY8pWmEVmYsfoKY1OsAdykFzDnFjW4CwbYtAhIxpRVUTizsen7W7R6i07uEO
         9nY6KEiJR6B8w9mbUKwNnwoSjPWBsbW0g9/0e3WSdhmfeGbmRGsi9ijevN+BMpiAi2PV
         RvvSSMXSCqTwD8goloG1SBKT4PNiuwE7V32SVhc9MPWnS9xa+Bx/vkYWFYvQyuMV3RSR
         QopA1Ox9nS/kOG9SEHN6RucJfc10bxnEMEY/1Id0unJWO+2wRBemeMRMz67Lft9SG0vA
         mg7qvzlTOpCd0zzGnxBckk97b6YLK3GHatqI9eKte3Ew/NrWyjVJQBmiTzqsqwR9LmUQ
         XfRA==
X-Forwarded-Encrypted: i=1; AJvYcCWoLFO009uVvdpGZeEZt5PMY7TS/b71YWYR00B4UGx0a0FmpsO2QVpLP7k+h7SHV3tZclboq7tUpO+4Q/rS1A==@lists.linux.dev
X-Gm-Message-State: AOJu0YxuNIIi/thNcXNXt1BOLu3eWIRvqrOxRpztTB90LdLj+97TJ/52
	o5Hxm+woqUQ4c4KCH9gM0Huhy70L5VidYiF2USwdtvr2xg0zgivCl3Mvm9feUvMUXEQ=
X-Gm-Gg: ASbGncsQHPfdCDc0AT4wjfowrCmQwR2zAreqXyD3AoF0LdWaDTHzHKA7YeuYkSM8PBp
	J4Az3zgTT6PP2NPxiIQpXVlgiMC/kK++dvc9FBNog2VniQFrq0W6DJJB+XnKrltIsF26IXp7RDN
	4nR4sPcqvbu7QBzI8MPDdyR/v08BPEIHeKdYnKXHJf/F/IdRYSO25LDvGVYs5dZazWoLRUA6RtK
	P5r6BlSCTEl1Ow1rt7+zOE1tvQYk2XHNuKKqv2vBZGQpqfSCVWu9jxgC/pGJ60/OS35H4bzc6pr
	R4m09l+hYzoHxRAzcnUyxF4fLaczQXdIgfk2Ustnn+5ajY2vhG2cdyiXR0bAa9vpZNRAn2YR+KI
	miKYxg5w=
X-Google-Smtp-Source: AGHT+IE3rKt5WHNJuMqRNYlFDXT8dSxi19usBdAhzGgY+n3rXRZOSIXnkXSl67UdwZvDarrui7g/Eg==
X-Received: by 2002:a17:90b:2547:b0:313:d6ce:6c6e with SMTP id 98e67ed59e1d1-31a90b26982mr3763532a91.8.1751452655134;
        Wed, 02 Jul 2025 03:37:35 -0700 (PDT)
Received: from vexas.. ([203.208.189.12])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-318c14e23a3sm14201200a91.29.2025.07.02.03.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 03:37:34 -0700 (PDT)
From: Zigit Zo <zuozhijie@bytedance.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com
Cc: zuozhijie@bytedance.com,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2] virtio-net: fix a rtnl_lock() deadlock during probing
Date: Wed,  2 Jul 2025 18:37:22 +0800
Message-ID: <20250702103722.576219-1-zuozhijie@bytedance.com>
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

Fix it by temporarily save the announce status while probing, and then in
virtnet_open(), if it sees a delayed announce work is there, it starts to
schedule the virtnet_config_changed_work().

Another possible solution is to directly check whether rtnl_is_locked()
and call __netdev_notify_peers(), but in that way means we need to relies
on netdev_queue to schedule the arp packets after ndo_open(), which we
thought is not very intuitive.

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
v1 -> v2:
- Check vi->status in virtnet_open().
v1:
- https://lore.kernel.org/netdev/20250630095109.214013-1-zuozhijie@bytedance.com/
---
 drivers/net/virtio_net.c | 43 ++++++++++++++++++++++++----------------
 1 file changed, 26 insertions(+), 17 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index e53ba600605a..859add98909b 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3151,6 +3151,10 @@ static int virtnet_open(struct net_device *dev)
 	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_STATUS)) {
 		if (vi->status & VIRTIO_NET_S_LINK_UP)
 			netif_carrier_on(vi->dev);
+		if (vi->status & VIRTIO_NET_S_ANNOUNCE) {
+			vi->status &= ~VIRTIO_NET_S_ANNOUNCE;
+			schedule_work(&vi->config_work);
+		}
 		virtio_config_driver_enable(vi->vdev);
 	} else {
 		vi->status = VIRTIO_NET_S_LINK_UP;
@@ -6215,33 +6219,34 @@ static void virtnet_config_changed_work(struct work_struct *work)
 {
 	struct virtnet_info *vi =
 		container_of(work, struct virtnet_info, config_work);
-	u16 v;
+	u16 v, changed;
 
 	if (virtio_cread_feature(vi->vdev, VIRTIO_NET_F_STATUS,
 				 struct virtio_net_config, status, &v) < 0)
 		return;
 
-	if (v & VIRTIO_NET_S_ANNOUNCE) {
+	changed = vi->status ^ v;
+
+	/* Assume the device will clear announce status when ack received. */
+	if ((changed & VIRTIO_NET_S_ANNOUNCE) && (v & VIRTIO_NET_S_ANNOUNCE)) {
 		netdev_notify_peers(vi->dev);
 		virtnet_ack_link_announce(vi);
+		v &= ~VIRTIO_NET_S_ANNOUNCE;
 	}
 
-	/* Ignore unknown (future) status bits */
-	v &= VIRTIO_NET_S_LINK_UP;
-
-	if (vi->status == v)
-		return;
-
-	vi->status = v;
-
-	if (vi->status & VIRTIO_NET_S_LINK_UP) {
-		virtnet_update_settings(vi);
-		netif_carrier_on(vi->dev);
-		netif_tx_wake_all_queues(vi->dev);
-	} else {
-		netif_carrier_off(vi->dev);
-		netif_tx_stop_all_queues(vi->dev);
+	if (changed & VIRTIO_NET_S_LINK_UP) {
+		if (v & VIRTIO_NET_S_LINK_UP) {
+			virtnet_update_settings(vi);
+			netif_carrier_on(vi->dev);
+			netif_tx_wake_all_queues(vi->dev);
+		} else {
+			netif_carrier_off(vi->dev);
+			netif_tx_stop_all_queues(vi->dev);
+		}
 	}
+
+	/* Ignore unknown (future) status bits */
+	vi->status = v & (VIRTIO_NET_S_LINK_UP | VIRTIO_NET_S_ANNOUNCE);
 }
 
 static void virtnet_config_changed(struct virtio_device *vdev)
@@ -7030,6 +7035,10 @@ static int virtnet_probe(struct virtio_device *vdev)
 	   otherwise get link status from config. */
 	netif_carrier_off(dev);
 	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_STATUS)) {
+		/* If there's (rarely) an announcement, the actual work will be
+		 * scheduled on ndo_open() to avoid recursive rtnl_lock() here.
+		 */
+		vi->status = VIRTIO_NET_S_ANNOUNCE;
 		virtnet_config_changed_work(&vi->config_work);
 	} else {
 		vi->status = VIRTIO_NET_S_LINK_UP;

base-commit: 34a500caf48c47d5171f4aa1f237da39b07c6157
-- 
2.49.0

