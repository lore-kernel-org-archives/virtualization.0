Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.217
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792539013;
	b=CJq6jEfJlXf654yfB5tSJEUfKcKI8QnEWAEGEs8GZtsrFoH1t1iv/7p2oRl2x8pyX9Of
	 A4Q9z2qA/GprQr6fWW+YccZR38x/C4JHXm+6+jCgkfzaNWM+h9uWlmdWVM0TxhuszgMsE
	 kP2yvyX6sjeKsjkEmTeKPR8d0uYjEYfm4O3m9WKdviZoYf43JmUb0I/UQOjYXGSmh5hPS
	 FeHSWf2KDxTlFAUriMgm+l5wF7SYCY2HiBk2fEy+NUYDi1ZtxIGZYavAh3GTeMpO/jgRA
	 JYcCCozmZYP5LYB04dSPTfKzDrHCfqaAtNpW6jLk3p1DjDGqMai/2+dKDAQ9KvQfp3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792539013;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=vpOI+1qBW/MtfJm0O85kyO88qqkrY/yJqDCLaRNjbVw=;
	b=fNp93LE5hhZFNTxL7p9zfbY6pkd7azEVYss+SNT6102auO9VzMQ9+0Shq5UfajB4y5Y6
	 qMaI0qtrIGQ6RI3FWCN2KvE5Smxt//g8VNC6HChGJdU1yVQk8hcDZgg9gffZASbA1ZXQ+
	 COEIpWIib8VyL49rs6WZPtEzNGhNgHm9p8z6vG+f/HP6vki5aKdCZuMMLotCpQiQ9D5SQ
	 LE64CJBuz+Mq++xillnWO0QY57yCgEzdoBNtxzoktjltj/kVeGzgQbtHraShsiLzi4hM3
	 MPY3Vx5zyeqhHeoamK1QSANKVXx9b4pdGit++8WS4atUXAZo+jLFNBhlaz6daiz3VwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=QGACHvRG;
	arc=none smtp.remote-ip=115.124.28.217
Received: from out28-217.mail.aliyun.com (out28-217.mail.aliyun.com [115.124.28.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63EB606A319
	for <virtualization@lists.linux.dev>; Tue, 20 Oct 2026 23:30:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D63EB606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=QGACHvRG
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1792538999; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=vpOI+1qBW/MtfJm0O85kyO88qqkrY/yJqDCLaRNjbVw=;
	b=QGACHvRGyo4WyDIcoCu3SwNOb7Os6K1a/tGqS6bchdxzNZs22XEekAaMW3KzF9RtLg/OK5BHC346YsZPRNp/FURgSMUTLuEVY5HgtIlPS5Vo/3H9f+XjQ1hNUHlxhu+4iSbbryXkrM6iAOWS1PB3l+HJSPjONbGzp0DwTPn4zw8=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.04501025|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.00619225-0.000360456-0.993447;FP=3275688948779205885|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037034184;MF=fangxy@xiaopeng.com;NM=1;PH=DS;RN=9;RT=9;SR=0;TI=SMTPD_---.jm3sHc-_1792538997;
Received: from localhost.localdomain(mailfrom:fangxy@xiaopeng.com fp:SMTPD_---.jm3sHc-_1792538997 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 21 Oct 2026 07:29:58 +0800
From: Fang Xieyan <fangxy@xiaopeng.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
Cc: virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Weibin Liu <liuwb@xiaopeng.com>
Subject: [PATCH] vhost: fix used ring index wrap in vhost_add_used_n_in_order
Date: Wed, 21 Oct 2026 07:29:56 +0800
Message-ID: <20261020232956.99970-1-fangxy@xiaopeng.com>
X-Mailer: git-send-email 2.50.1
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vhost_add_used_n_in_order() advances start by nheads[i] but wraps it
with a single subtraction.  If start + nheads[i] >= 2 * vq->num, start
can remain outside the ring.

With used-ring logging enabled, start > vq->num makes (vq->num - start)
underflow.  log_write() then sets bits beyond the dirty-log bitmap,
potentially corrupting adjacent userspace memory.  This is reachable on
the vhost-net TX path with VIRTIO_F_IN_ORDER: done_idx can reach
VHOST_NET_BATCH (64), triggering the issue with a 32-entry ring.

Wrap start with a mask to keep it within the ring.  VHOST_SET_VRING_NUM
enforces a nonzero power-of-two ring size, allowing start to be wrapped
using & (vq->num - 1).

Fixes: 67a873df0c41 ("vhost: basic in order support")
Cc: stable@vger.kernel.org
Reviewed-by: Weibin Liu <liuwb@xiaopeng.com>
Signed-off-by: Fang Xieyan <fangxy@xiaopeng.com>
---
Reproducer (verified on a kernel containing commit 67a873df0c41 with a
temporary WARN_ON_ONCE probe in log_used(); the probe is not part of
this patch):

With VIRTIO_F_IN_ORDER, num=32, and used-ring dirty logging enabled, the
TX batch reaches done_idx=64.  In the observed run, the initial index is
3, so the single subtraction leaves start=35.  The resulting length
calculation wraps to 34359738344 bytes, as confirmed by the log_used()
probe.

A 64-byte canary immediately after the 512-byte log bitmap changes from
0xA5 to 0xFF, confirming the out-of-bounds write.  The used-ring canary
remains intact because vhost_put_used() runs before start is advanced;
the demonstrated corruption is in the dirty-log bitmap.

 drivers/vhost/vhost.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 44cac11b68d2..0226c4c59709 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -3172,8 +3172,7 @@ static int vhost_add_used_n_in_order(struct vhost_virtqueue *vq,
 		}
 		start += nheads[i];
 		new += nheads[i];
-		if (start >= vq->num)
-			start -= vq->num;
+		start &= vq->num - 1;
 	}
 
 	if (unlikely(vq->log_used)) {
-- 
2.50.1

