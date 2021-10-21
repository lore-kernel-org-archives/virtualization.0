Return-Path: <SRS0=rBDE=PJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E220CC433EF
	for <virtualization@archiver.kernel.org>; Thu, 21 Oct 2021 09:48:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 941C6610CF
	for <virtualization@archiver.kernel.org>; Thu, 21 Oct 2021 09:48:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 941C6610CF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 481A860ECF;
	Thu, 21 Oct 2021 09:48:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jR7IPTI41Fy7; Thu, 21 Oct 2021 09:48:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id BD0CB60EC7;
	Thu, 21 Oct 2021 09:47:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 90B4CC001C;
	Thu, 21 Oct 2021 09:47:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0F7B8C0011
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 09:47:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 90FA760ED1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 09:47:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ga5-eeE_7kNz
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 09:47:54 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5617560EC7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 09:47:54 +0000 (UTC)
Received: by mail-pl1-x632.google.com with SMTP id i1so1529406plr.13
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 02:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=sd5Y+VXeLt/FwNc/kQF5A+l+7MoB453D2YckJ5POEAk=;
 b=Mg7MAO9RbrYTNzaZd0RPXaZLUXYte3Dqkll6oIYZjUo/xY1EEh7BfMvYeT2hQCiCdr
 ygjX09T1dztEst8zd4ft+Zng4XwB4IHsXbbg6rmjkejjYZAKTVfvzHePqJ5s1XaliIIy
 pzxYky1sJHEBR+TYqhqnOJ4gvDtnf0Q5lqDaNaQ0ZqHaJX0Upee/PIPGpGRUoy3RFtwo
 tuinVL15Rabsre1CcS3tccq5BiJY9Gmw0guDdvTxhxdD08G58wJ3X1M/JirsuCG/+4Nu
 pw0Dp2RGVISWjzdMjwaEXoBJqi/9M/eYqlPxxdMPl1ql+cYpBUcj/NuuN3mPN8Pqd9hy
 3aCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=sd5Y+VXeLt/FwNc/kQF5A+l+7MoB453D2YckJ5POEAk=;
 b=QEbGSr2IgjkP1nZHhZ/6SOdJ9V0+b0BZ0fKukZpk04WEKWCSpldkrzZqUNyNaOB5GQ
 jKnRKyqw1ss/Z+lTzm2eVPnoF+jTGhZ5WSVJKIlc7bpSzP+FyghU0F5/sJJVKZ/gHczK
 yh4aQftfJny+BlWr7pb5MlsaSsQR+vtmNmiePIAtC0n97P5jipB499xjo495ch6wdFHU
 jzZ6HHVxQ9gZ0FC4d0tGfYuJbGPhyXlzaYeTfmETFIWx0StEVAHxajwg2SePhvjjtzm/
 lrarB6UBUrXOI8vpsncNeQ7MwHIumn3U5F9U8YDtdHu5M/buxFOEuDn5KR9KyaCrMNTt
 iCAA==
X-Gm-Message-State: AOAM5334/sPCw44eTWkAjsI5vKLH3E6EA42E83i4rrGYxvqLTBOT11c7
 W3gDKTs4j51CvkOxMYwhOsVEEA==
X-Google-Smtp-Source: ABdhPJxc9xBoO9xQmdAhtcq9YKRyV6thPeqr+m8xLu2ELG8bCOYYVGw4LiWcUKdO7d3W/DlLOSOpAw==
X-Received: by 2002:a17:90b:3ec8:: with SMTP id
 rm8mr5658064pjb.100.1634809673507; 
 Thu, 21 Oct 2021 02:47:53 -0700 (PDT)
Received: from localhost ([106.201.113.61])
 by smtp.gmail.com with ESMTPSA id s25sm5259382pfm.138.2021.10.21.02.47.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Oct 2021 02:47:52 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Wolfram Sang <wsa@kernel.org>, Jie Deng <jie.deng@intel.com>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Subject: [PATCH] i2c: virtio: Add support for zero-length requests
Date: Thu, 21 Oct 2021 15:17:49 +0530
Message-Id: <7c58868cd26d2fc4bd82d0d8b0dfb55636380110.1634808714.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
MIME-Version: 1.0
Cc: Arnd Bergmann <arnd@kernel.org>,
 Vincent Whitchurch <vincent.whitchurch@axis.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, cohuck@redhat.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-i2c@vger.kernel.org, stratos-dev@op-lists.linaro.org
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

The virtio specification received a new mandatory feature
(VIRTIO_I2C_F_ZERO_LENGTH_REQUEST) for zero length requests. Fail if the
feature isn't offered by the device.

For each read-request, set the VIRTIO_I2C_FLAGS_M_RD flag, as required
by the VIRTIO_I2C_F_ZERO_LENGTH_REQUEST feature.

This allows us to support zero length requests, like SMBUS Quick, where
the buffer need not be sent anymore.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
Hi Wolfram,

Please do not apply this until the spec changes [1] are merged, sending it early
to get review done. I will ping you later once the spec is merged.

[1] https://lists.oasis-open.org/archives/virtio-dev/202110/msg00109.html

 drivers/i2c/busses/i2c-virtio.c | 56 ++++++++++++++++++---------------
 include/uapi/linux/virtio_i2c.h |  6 ++++
 2 files changed, 36 insertions(+), 26 deletions(-)

diff --git a/drivers/i2c/busses/i2c-virtio.c b/drivers/i2c/busses/i2c-virtio.c
index f10a603b13fb..1ed4daa918a0 100644
--- a/drivers/i2c/busses/i2c-virtio.c
+++ b/drivers/i2c/busses/i2c-virtio.c
@@ -62,35 +62,33 @@ static int virtio_i2c_prepare_reqs(struct virtqueue *vq,
 	for (i = 0; i < num; i++) {
 		int outcnt = 0, incnt = 0;
 
-		/*
-		 * We don't support 0 length messages and so filter out
-		 * 0 length transfers by using i2c_adapter_quirks.
-		 */
-		if (!msgs[i].len)
-			break;
-
 		/*
 		 * Only 7-bit mode supported for this moment. For the address
 		 * format, Please check the Virtio I2C Specification.
 		 */
 		reqs[i].out_hdr.addr = cpu_to_le16(msgs[i].addr << 1);
 
+		if (msgs[i].flags & I2C_M_RD)
+			reqs[i].out_hdr.flags |= cpu_to_le32(VIRTIO_I2C_FLAGS_M_RD);
+
 		if (i != num - 1)
-			reqs[i].out_hdr.flags = cpu_to_le32(VIRTIO_I2C_FLAGS_FAIL_NEXT);
+			reqs[i].out_hdr.flags |= cpu_to_le32(VIRTIO_I2C_FLAGS_FAIL_NEXT);
 
 		sg_init_one(&out_hdr, &reqs[i].out_hdr, sizeof(reqs[i].out_hdr));
 		sgs[outcnt++] = &out_hdr;
 
-		reqs[i].buf = i2c_get_dma_safe_msg_buf(&msgs[i], 1);
-		if (!reqs[i].buf)
-			break;
+		if (msgs[i].len) {
+			reqs[i].buf = i2c_get_dma_safe_msg_buf(&msgs[i], 1);
+			if (!reqs[i].buf)
+				break;
 
-		sg_init_one(&msg_buf, reqs[i].buf, msgs[i].len);
+			sg_init_one(&msg_buf, reqs[i].buf, msgs[i].len);
 
-		if (msgs[i].flags & I2C_M_RD)
-			sgs[outcnt + incnt++] = &msg_buf;
-		else
-			sgs[outcnt++] = &msg_buf;
+			if (msgs[i].flags & I2C_M_RD)
+				sgs[outcnt + incnt++] = &msg_buf;
+			else
+				sgs[outcnt++] = &msg_buf;
+		}
 
 		sg_init_one(&in_hdr, &reqs[i].in_hdr, sizeof(reqs[i].in_hdr));
 		sgs[outcnt + incnt++] = &in_hdr;
@@ -191,7 +189,7 @@ static int virtio_i2c_setup_vqs(struct virtio_i2c *vi)
 
 static u32 virtio_i2c_func(struct i2c_adapter *adap)
 {
-	return I2C_FUNC_I2C | (I2C_FUNC_SMBUS_EMUL & ~I2C_FUNC_SMBUS_QUICK);
+	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
 }
 
 static struct i2c_algorithm virtio_algorithm = {
@@ -199,15 +197,16 @@ static struct i2c_algorithm virtio_algorithm = {
 	.functionality = virtio_i2c_func,
 };
 
-static const struct i2c_adapter_quirks virtio_i2c_quirks = {
-	.flags = I2C_AQ_NO_ZERO_LEN,
-};
-
 static int virtio_i2c_probe(struct virtio_device *vdev)
 {
 	struct virtio_i2c *vi;
 	int ret;
 
+	if (!virtio_has_feature(vdev, VIRTIO_I2C_F_ZERO_LENGTH_REQUEST)) {
+		dev_err(&vdev->dev, "Zero-length request feature is mandatory\n");
+		return -EINVAL;
+	}
+
 	vi = devm_kzalloc(&vdev->dev, sizeof(*vi), GFP_KERNEL);
 	if (!vi)
 		return -ENOMEM;
@@ -225,7 +224,6 @@ static int virtio_i2c_probe(struct virtio_device *vdev)
 	snprintf(vi->adap.name, sizeof(vi->adap.name),
 		 "i2c_virtio at virtio bus %d", vdev->index);
 	vi->adap.algo = &virtio_algorithm;
-	vi->adap.quirks = &virtio_i2c_quirks;
 	vi->adap.dev.parent = &vdev->dev;
 	vi->adap.dev.of_node = vdev->dev.of_node;
 	i2c_set_adapdata(&vi->adap, vi);
@@ -270,11 +268,17 @@ static int virtio_i2c_restore(struct virtio_device *vdev)
 }
 #endif
 
+static const unsigned int features[] = {
+	VIRTIO_I2C_F_ZERO_LENGTH_REQUEST,
+};
+
 static struct virtio_driver virtio_i2c_driver = {
-	.id_table	= id_table,
-	.probe		= virtio_i2c_probe,
-	.remove		= virtio_i2c_remove,
-	.driver	= {
+	.feature_table		= features,
+	.feature_table_size	= ARRAY_SIZE(features),
+	.id_table		= id_table,
+	.probe			= virtio_i2c_probe,
+	.remove			= virtio_i2c_remove,
+	.driver			= {
 		.name	= "i2c_virtio",
 	},
 #ifdef CONFIG_PM_SLEEP
diff --git a/include/uapi/linux/virtio_i2c.h b/include/uapi/linux/virtio_i2c.h
index 7c6a6fc01ad6..acf3b6069136 100644
--- a/include/uapi/linux/virtio_i2c.h
+++ b/include/uapi/linux/virtio_i2c.h
@@ -11,9 +11,15 @@
 #include <linux/const.h>
 #include <linux/types.h>
 
+/* Virtio I2C Feature bits */
+#define VIRTIO_I2C_F_ZERO_LENGTH_REQUEST	0
+
 /* The bit 0 of the @virtio_i2c_out_hdr.@flags, used to group the requests */
 #define VIRTIO_I2C_FLAGS_FAIL_NEXT	_BITUL(0)
 
+/* The bit 1 of the @virtio_i2c_out_hdr.@flags, used to mark a buffer as read */
+#define VIRTIO_I2C_FLAGS_M_RD		_BITUL(1)
+
 /**
  * struct virtio_i2c_out_hdr - the virtio I2C message OUT header
  * @addr: the controlled device address
-- 
2.31.1.272.g89b43f80a514

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
