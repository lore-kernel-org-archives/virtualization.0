Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.169.97
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793367025;
	b=tq2xA6D4yRwTMp2kD90Z0/r1HOtxC5WhGAiYqjz+/1hvRmZ4oZa/gA69+PErqOcrLYY5
	 xB0gmSEKwEPEaokWqBdr9+8OF2TJuHt9BI0/GTNFbt+iv3Wz9iW7/x70e2peRMKBJsJbe
	 dFc0aY2vP327S68AiA0ov1+B7LmxVUc5PwOmBVlUbQNTgqlE1EUYl+s0TbKzKVt1u2Xid
	 ui9+l46fjI4hE4gJ9WIOo0ayNjbynmAhK4U+e5xXBQWWrmiUV2a+h0nlpM5pFO0yi7wz5
	 4RAOHb9CQhLdGu3Bc43j9lefUYqR8FWDBQLeI9CbS/dcEbO5w3Q/iYvVdUdsLi3b4kQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793367025;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-ZohoMailClient;
	bh=yL5B9w2fd33NoSP+kcRsaKmbMe4jGgNs82wbIhiis7g=;
	b=rBdFiHSqgMlBn21vVmoqmAVcTb8GPSSlwC8ldnGToRc5Tr2HAWtHIa2w/zy7eb6bqMO+
	 Y+w+o+3rDrLbh64iwH61Lsa4ad1u2UXlaRjjj+jsNK3RO0iqZZZhLI2/cp9T5nhwfcrN7
	 J+0P1/dGW1CO1b7AoKS0CfZptrlFjQG8htc99/Q9VRLEK+zBPrKp40EOuKXc2FWaRVXv+
	 BCub/wQAYpEhoYjVEVU7i1p7DVrPScfs2VVktf6GSuFnkNOpEEv25l/229WQbc0qty7i2
	 42oNDPqSfrTz6VgM4LyjjAgNbne9Ybh7Cd3MYhUxslrp+SYUxLCov3Q4WymeBRlPwfw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zohomail.eu;
	spf=pass smtp.mailfrom=zohomail.eu;
	dkim=pass header.d=zohomail.eu header.i=@zohomail.eu header.a=rsa-sha256 header.s=zoho header.b="X6O/iXJf";
	arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.169.97
Received: from sender-pp-o97.zoho.eu (sender-pp-o97.zoho.eu [136.143.169.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE5E606A324
	for <virtualization@lists.linux.dev>; Fri, 30 Oct 2026 13:30:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6DE5E606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=zohomail.eu header.i=@zohomail.eu header.a=rsa-sha256 header.s=zoho header.b=X6O/iXJf
ARC-Seal: i=1; a=rsa-sha256; t=1793367009; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=IF5hD8IDyBnZq/6+I/nMLfEQsh5YkJwy8dU5EC/uUPQwEwp2VA/IyS4x0vwoBRl95kyJPvwYfnNehfoKnYam/6iOdjg5k36vMekkLK4MjktsKx6WC81Qmp5LDLheKaTw8pcOzRy9L9kBKViCWevJyvj0qD0fIGu8uYuA5+WNRZo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1793367009; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=yL5B9w2fd33NoSP+kcRsaKmbMe4jGgNs82wbIhiis7g=; 
	b=hq24cMlQP1tQlQ2ZZhDxNAT835zmRCxc/IryVqm2r7+hx+/Go1lgxlaiitmR97KfpfBKGtbuxJMLvDtKolDUcLd7fCsTrs24q/1JM7J4pzBFkMW4sBD1JJrjoRQ6ghy3ESDEA9Sxs8l39cdAcp/SU793/0590Mn7aAjGYNwFOLM=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=zohomail.eu;
	spf=pass  smtp.mailfrom=harukak@zohomail.eu;
	dmarc=pass header.from=<harukak@zohomail.eu>
DKIM-Signature: a=rsa-sha256; b=X6O/iXJfSk+HRQv4nN94agTdPYyTloIEfdVTNmVsuwixzoGOuRkL9aZqzoEAkswCHKZelsAsHmLYaHUmdM/qXB18udMiwOqmUGtKVzKCoi9W7VKosRNxiR00JOoWxfCMIznCEipUttblDIlZyNARKK2YZNWEsu0UKTy4IoS63WU=; c=relaxed/relaxed; s=zoho; d=zohomail.eu; v=1; bh=yL5B9w2fd33NoSP+kcRsaKmbMe4jGgNs82wbIhiis7g=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zoho.eu with SMTPS id 1793367006510399.5040981229382;
	Fri, 30 Oct 2026 14:30:06 +0100 (CET)
From: Haruka Kuze <harukak@zohomail.eu>
To: Jens Wiklander <jenswi@kernel.org>,
	"Michael S . Tsirkin" <mst@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jason Wang <jasowangio@gmail.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Sumit Garg <sumit.garg@kernel.org>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Tomas Winkler <tomas.winkler@sandisk.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Harald Mommer <harald.mommer@oss.qualcomm.com>,
	virtualization@lists.linux.dev,
	op-tee@lists.trustedfirmware.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] rpmb: stop the routing after unregister
Date: Fri, 30 Oct 2026 22:29:59 +0900
Message-ID: <20261030133000.24147-2-harukak@zohomail.eu>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261030133000.24147-1-harukak@zohomail.eu>
References: <20261030133000.24147-1-harukak@zohomail.eu>
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
X-ZohoMailClient: External

From: Haruka Kuze <harukak@zohomail.eu>

OP-TEE has a reference of RPMB device it used. So, it can route
frames through the device after rpmb_dev_unregister() is called.
Therefore, the parent device passed to route_frames() can be
already freed, for example, mmc_blk_remove_rpmb_part() drops the
last reference after rpmb unregister.

This patch clears the route_frames when the device is going to
be removed by getting new rwsem and makes rpmb_route_frames()
return -ENODEV if the device is gone.

Fixes: 1e9046e3a154 ("rpmb: add Replay Protected Memory Block (RPMB) subsystem")
Assisted-by: LLM
Signed-off-by: Haruka Kuze <harukak@zohomail.eu>
---
 drivers/misc/rpmb-core.c | 14 +++++++++++++-
 include/linux/rpmb.h     |  4 ++++
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/rpmb-core.c b/drivers/misc/rpmb-core.c
index ecf14acf230a..0ae018d1a276 100644
--- a/drivers/misc/rpmb-core.c
+++ b/drivers/misc/rpmb-core.c
@@ -45,7 +45,7 @@ EXPORT_SYMBOL_GPL(rpmb_dev_put);
  * @rsp:	rpmb response frames
  * @rsp_len:	length of rpmb response frames in bytes
  *
- * Returns: < 0 on failure
+ * Returns: < 0 on failure, -ENODEV if the device has been unregistered
  */
 int rpmb_route_frames(struct rpmb_dev *rdev, u8 *req,
 		      unsigned int req_len, u8 *rsp, unsigned int rsp_len)
@@ -53,6 +53,10 @@ int rpmb_route_frames(struct rpmb_dev *rdev, u8 *req,
 	if (!req || !req_len || !rsp || !rsp_len)
 		return -EINVAL;
 
+	guard(rwsem_read)(&rdev->lock);
+	if (!rdev->descr.route_frames)
+		return -ENODEV;
+
 	return rdev->descr.route_frames(rdev->dev.parent, req, req_len,
 					rsp, rsp_len);
 }
@@ -126,6 +130,10 @@ EXPORT_SYMBOL_GPL(rpmb_interface_unregister);
  * This function should be called from the release function of the
  * underlying device used when the RPMB device was registered.
  *
+ * Once this returns, rpmb_route_frames() no longer calls into
+ * the driver, even though the users might still hold a reference
+ * to the RPMB dev.
+ *
  * Returns: < 0 on failure
  */
 int rpmb_dev_unregister(struct rpmb_dev *rdev)
@@ -133,6 +141,9 @@ int rpmb_dev_unregister(struct rpmb_dev *rdev)
 	if (!rdev)
 		return -EINVAL;
 
+	scoped_guard(rwsem_write, &rdev->lock)
+		rdev->descr.route_frames = NULL;
+
 	device_del(&rdev->dev);
 
 	rpmb_dev_put(rdev);
@@ -165,6 +176,7 @@ struct rpmb_dev *rpmb_dev_register(struct device *dev,
 	if (!rdev)
 		return ERR_PTR(-ENOMEM);
 	rdev->descr = *descr;
+	init_rwsem(&rdev->lock);
 	rdev->descr.dev_id = kmemdup(descr->dev_id, descr->dev_id_len,
 				     GFP_KERNEL);
 	if (!rdev->descr.dev_id) {
diff --git a/include/linux/rpmb.h b/include/linux/rpmb.h
index ed3f8e431eff..0a976572d1cd 100644
--- a/include/linux/rpmb.h
+++ b/include/linux/rpmb.h
@@ -7,6 +7,7 @@
 #define __RPMB_H__
 
 #include <linux/device.h>
+#include <linux/rwsem.h>
 #include <linux/types.h>
 
 /**
@@ -51,12 +52,15 @@ struct rpmb_descr {
  * @id               : device_id
  * @list_node        : linked list node
  * @descr            : RPMB description
+ * @lock             : protect @descr.route_frames which is cleared when this
+ *                     device is unregistered
  */
 struct rpmb_dev {
 	struct device dev;
 	int id;
 	struct list_head list_node;
 	struct rpmb_descr descr;
+	struct rw_semaphore lock;
 };
 
 #define to_rpmb_dev(x)		container_of((x), struct rpmb_dev, dev)
-- 
2.55.0

