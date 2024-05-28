Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3F67347D
	for <virtualization@lists.linux.dev>; Tue, 28 May 2024 07:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716882760; cv=none; b=BoRzExsboOv/ctVlPj/p/vP8KyIqYYFHUtqFuBMeKazyLt5h/DzB3Eq+3ZSFYzN07JMEkNgLRFxrxn6HKUt2pYrNyGBeyVqg61AKIGaFXQ2N0ZilJBR8DKHZsz7111vncBb88lHRjLCQ86qJN1LkGZV9eui//JdLQaGCpoCC6Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716882760; c=relaxed/simple;
	bh=GfEulMx2KhtrizCd56h3xXWnS2UCVQN4StF4rpSymzQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I03dhNDjGLdfEXm3j2y1FtdnDFhl9Va8FPVrgpobUuZtXWzVBys/ip1sR3xDcSLk9jg1DwXg2E2ac+zrc0ZQg681cM70068A08dbqe0ILMMh1/4EcQKdDZ85N28dn2JHRBrXyCHkVxQYMEWcJS+oSTE4tSHpP/5t22A95CZZsuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=GDRg9ws3; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="GDRg9ws3"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1716882749; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=KdpOhLozJ8bbzcbkjkEZg/h/Suz653QXLD5WRKflAzk=;
	b=GDRg9ws3UVT2sUua2Xbx1eq8EnaiYjbEONvaCJkPfma4jlSaH2CPBoDyA2GnNfZtKSZPEhNpDYgkn09IfzwMEolJt0ZKI3dYjJXsSZJGGZs78VczTlF208bPkJMNph00tAaUWIFGDWBAwchg5p2TB35+aGJKkQZpd9dgkfPsWmQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067110;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0W7OsRbZ_1716882748;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W7OsRbZ_1716882748)
          by smtp.aliyun-inc.com;
          Tue, 28 May 2024 15:52:29 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: netdev@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Daniel Jurgens <danielj@nvidia.com>
Subject: [PATCH net 1/2] virtio_net: rename ret to err
Date: Tue, 28 May 2024 15:52:25 +0800
Message-Id: <20240528075226.94255-2-hengqi@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240528075226.94255-1-hengqi@linux.alibaba.com>
References: <20240528075226.94255-1-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The integer variable 'ret', denoting the return code, is mismatched with
the boolean return type of virtnet_send_command_reply(); hence, it is
renamed to 'err'.

The usage of 'ret' is deferred to the next patch.

Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 4a802c0ea2cb..6b0512a628e0 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2686,7 +2686,7 @@ static bool virtnet_send_command_reply(struct virtnet_info *vi, u8 class, u8 cmd
 {
 	struct scatterlist *sgs[5], hdr, stat;
 	u32 out_num = 0, tmp, in_num = 0;
-	int ret;
+	int err;
 
 	/* Caller should know better */
 	BUG_ON(!virtio_has_feature(vi->vdev, VIRTIO_NET_F_CTRL_VQ));
@@ -2710,10 +2710,10 @@ static bool virtnet_send_command_reply(struct virtnet_info *vi, u8 class, u8 cmd
 		sgs[out_num + in_num++] = in;
 
 	BUG_ON(out_num + in_num > ARRAY_SIZE(sgs));
-	ret = virtqueue_add_sgs(vi->cvq, sgs, out_num, in_num, vi, GFP_ATOMIC);
-	if (ret < 0) {
+	err = virtqueue_add_sgs(vi->cvq, sgs, out_num, in_num, vi, GFP_ATOMIC);
+	if (err < 0) {
 		dev_warn(&vi->vdev->dev,
-			 "Failed to add sgs for command vq: %d\n.", ret);
+			 "Failed to add sgs for command vq: %d\n.", err);
 		mutex_unlock(&vi->cvq_lock);
 		return false;
 	}
-- 
2.32.0.3.g01195cf9f

