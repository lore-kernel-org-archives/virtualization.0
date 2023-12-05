Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F24665EA1
	for <virtualization@lists.linux.dev>; Tue,  5 Dec 2023 14:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="inUejDd6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701785957;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=g2FwUnRexMbJ1eWu7b0mx103R9bklO0D/KfjDegM/pc=;
	b=inUejDd68N1MTFllxFfD2lQtoXLNQKiN2MDtpROEaTtniyuFZNfHnhKQcYZ+az0Gdju610
	pYAb5hdimDQv9+zl07moSfqd8hlA8N0Sj+U0t55rO+fQ02W7zEn1PPCBero/fhGaueNp77
	kFd5gzfy+Itg6T4erXFoCLd+eSCnIwg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-692-Hw2K6gyFNtS8WtP7wZHbSQ-1; Tue,
 05 Dec 2023 09:18:43 -0500
X-MC-Unique: Hw2K6gyFNtS8WtP7wZHbSQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9218638130AC;
	Tue,  5 Dec 2023 14:18:42 +0000 (UTC)
Received: from localhost (unknown [10.39.195.85])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 117495B7C;
	Tue,  5 Dec 2023 14:18:41 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: David.Laight@aculab.com,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	linux-block@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Jason Wang <jasowang@redhat.com>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Suwan Kim <suwan.kim027@gmail.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH v2] virtio_blk: fix snprintf truncation compiler warning
Date: Tue,  5 Dec 2023 09:18:40 -0500
Message-ID: <20231205141840.1854409-1-stefanha@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

Commit 4e0400525691 ("virtio-blk: support polling I/O") triggers the
following gcc 13 W=1 warnings:

drivers/block/virtio_blk.c: In function ‘init_vq’:
drivers/block/virtio_blk.c:1077:68: warning: ‘%d’ directive output may be truncated writing between 1 and 11 bytes into a region of size 7 [-Wformat-truncation=]
 1077 |                 snprintf(vblk->vqs[i].name, VQ_NAME_LEN, "req_poll.%d", i);
      |                                                                    ^~
drivers/block/virtio_blk.c:1077:58: note: directive argument in the range [-2147483648, 65534]
 1077 |                 snprintf(vblk->vqs[i].name, VQ_NAME_LEN, "req_poll.%d", i);
      |                                                          ^~~~~~~~~~~~~
drivers/block/virtio_blk.c:1077:17: note: ‘snprintf’ output between 11 and 21 bytes into a destination of size 16
 1077 |                 snprintf(vblk->vqs[i].name, VQ_NAME_LEN, "req_poll.%d", i);
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This is a false positive because the lower bound -2147483648 is
incorrect. The true range of i is [0, num_vqs - 1] where 0 < num_vqs <
65536.

The code mixes int, unsigned short, and unsigned int types in addition
to using "%d" for an unsigned value. The only place where a 16-bit value
is needed is during the config space access. Use unsigned int and "%u"
consistently to solve the compiler warning and clean up the code.

Cc: Suwan Kim <suwan.kim027@gmail.com>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202312041509.DIyvEt9h-lkp@intel.com/
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 drivers/block/virtio_blk.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

v2:
- Use unsigned int instead of unsigned short [David]

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index d53d6aa8ee69..dc69a40fbf08 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -1019,20 +1019,23 @@ static void virtblk_config_changed(struct virtio_device *vdev)
 static int init_vq(struct virtio_blk *vblk)
 {
 	int err;
-	int i;
+	unsigned int i;
 	vq_callback_t **callbacks;
 	const char **names;
 	struct virtqueue **vqs;
-	unsigned short num_vqs;
+	unsigned int num_vqs;
 	unsigned int num_poll_vqs;
 	struct virtio_device *vdev = vblk->vdev;
 	struct irq_affinity desc = { 0, };
+	u16 num_vqs_u16;
 
 	err = virtio_cread_feature(vdev, VIRTIO_BLK_F_MQ,
 				   struct virtio_blk_config, num_queues,
-				   &num_vqs);
+				   &num_vqs_u16);
 	if (err)
 		num_vqs = 1;
+	else
+		num_vqs = num_vqs_u16;
 
 	if (!err && !num_vqs) {
 		dev_err(&vdev->dev, "MQ advertised but zero queues reported\n");
@@ -1068,13 +1071,13 @@ static int init_vq(struct virtio_blk *vblk)
 
 	for (i = 0; i < num_vqs - num_poll_vqs; i++) {
 		callbacks[i] = virtblk_done;
-		snprintf(vblk->vqs[i].name, VQ_NAME_LEN, "req.%d", i);
+		snprintf(vblk->vqs[i].name, VQ_NAME_LEN, "req.%u", i);
 		names[i] = vblk->vqs[i].name;
 	}
 
 	for (; i < num_vqs; i++) {
 		callbacks[i] = NULL;
-		snprintf(vblk->vqs[i].name, VQ_NAME_LEN, "req_poll.%d", i);
+		snprintf(vblk->vqs[i].name, VQ_NAME_LEN, "req_poll.%u", i);
 		names[i] = vblk->vqs[i].name;
 	}
 
-- 
2.43.0

