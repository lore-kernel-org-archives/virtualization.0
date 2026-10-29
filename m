Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.169.97
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793261622;
	b=f/IjTOwvXWz2XAz/LTJUyQiBN00GYOuiA/kDPnz+eUeEJIUDIEVX2dOjGyVtBp+nuc3o
	 UGSnhG72VQ9LjiGC26h8LDxZLft4ee6dNZZfPnnWh6rDUfdiWrMRW9cLQGNYxNZwGEpLZ
	 knHPpy91Kj5kHEfWziiLTzGNCVOmCMkD2yb2KUFynMq++vn57uV4F+2HW75kQ2KDPJ5DK
	 J+3qTONmrM3foBKL/oAhPmP/Wi4WMdgraL0lzgn4ajDLecfk0Tc5/HkbJrOik8e+ZYJ/4
	 m3qYTVHr2vPQLzrM8RGcfpoFP8id5TqHc/x96XQOUKtEvkUa/jnxulh7BOLcVZ5S37Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793261622;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-ZohoMailClient;
	bh=Ydap92QocmwyU9V7T7zPNoS+1ppH35flYM0aoofe83s=;
	b=O+hd7Q/XPP8usBP97fx8DcEUCkxMveXW9SCZj+nmubs5lZbXqa8+9gGMDpjVnJbs5MJN
	 9LyCu5sdXMeHlzXTtZbHL1qRr7YCjWh4lair+gXAu+DL/zSQ2PkI3QXH8wA9KkqPw9md+
	 EVQGaXxA/ZWT3OFH3wd3UlNr62FhcP8dxqLKiUW9l+6xIAqn57X/vgPB7fMO9IbQ8v4ym
	 EHufbmkPlCd5Z9bJEUD88lXzQLTVDeMx1Z6cTZf/nYBHLQijCkVqyJ7QGfPn6CGkZLoQ9
	 a63SrDo+ldoWR3EO5EHUgB0Hc1b1V+LsfV9wd7nxfgMDVmiyCu+XLXJWqeIUVioEsQg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zohomail.eu;
	spf=pass smtp.mailfrom=zohomail.eu;
	dkim=pass header.d=zohomail.eu header.i=@zohomail.eu header.a=rsa-sha256 header.s=zoho header.b=DiH8817y;
	arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.169.97
Received: from sender-pp-o97.zoho.eu (sender-pp-o97.zoho.eu [136.143.169.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D781E606A31A
	for <virtualization@lists.linux.dev>; Thu, 29 Oct 2026 08:13:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D781E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=zohomail.eu header.i=@zohomail.eu header.a=rsa-sha256 header.s=zoho header.b=DiH8817y
ARC-Seal: i=1; a=rsa-sha256; t=1793261606; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=ImD7aTbOfNqhAvAT88wybLIlUVFovdqUi6ZZTwlwf9PSzwzTWXxCv2hKd6+ZaRExVB6TTWvJndC5GGYnLjVFEqBT9dSS9+cfEqH7r7mFPFUxTKH2NiMx8aWc60TVY9+mfFdV9FFOfXakd2A+soSt+e1PiV7L8t2VQ9m6rgwFPok=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1793261606; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Ydap92QocmwyU9V7T7zPNoS+1ppH35flYM0aoofe83s=; 
	b=WyLxnI1s8uowwTtc/5IxGRApwGrO9nLaCyNOlHDxsJwKv57EIsPiLlQHmWUr+k8sWG36jtBt4p4NRyiulVa8kaulZCh4e+5TP+pII4wd1LUiuglAK5/IW/Mpx3gAIdffKMIqX33Dpc6ixsZiHq+fkf2URrBXynk4+DgOavzeDoA=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=zohomail.eu;
	spf=pass  smtp.mailfrom=harukak@zohomail.eu;
	dmarc=pass header.from=<harukak@zohomail.eu>
DKIM-Signature: a=rsa-sha256; b=DiH8817yPvTnyoluoTzODXVQ/86Lqw3T0i56bk7PdopguWdZOJThsRRs0fQ+Tg9sgToyFe3WDIIfzgu2/D7phBt5G5TjHQZV0u8h6diah9RjQpwGQnYN3dQad3j56wqPVj5fkklBu94aPCCu5nYA2krWsF/lbj8BYK8rcY+bbIg=; c=relaxed/relaxed; s=zoho; d=zohomail.eu; v=1; bh=Ydap92QocmwyU9V7T7zPNoS+1ppH35flYM0aoofe83s=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zoho.eu with SMTPS id 1793261604462290.4820452678574;
	Thu, 29 Oct 2026 09:13:24 +0100 (CET)
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
Subject: [PATCH 1/2] rpmb: stop the routing after unregister
Date: Thu, 29 Oct 2026 17:13:16 +0900
Message-ID: <20261029081317.2264887-2-harukak@zohomail.eu>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261029081317.2264887-1-harukak@zohomail.eu>
References: <20261029081317.2264887-1-harukak@zohomail.eu>
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
 drivers/misc/rpmb-core.c | 22 +++++++++++++++++++---
 include/linux/rpmb.h     |  4 ++++
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/rpmb-core.c b/drivers/misc/rpmb-core.c
index ecf14acf230a..0538871af584 100644
--- a/drivers/misc/rpmb-core.c
+++ b/drivers/misc/rpmb-core.c
@@ -45,16 +45,23 @@ EXPORT_SYMBOL_GPL(rpmb_dev_put);
  * @rsp:	rpmb response frames
  * @rsp_len:	length of rpmb response frames in bytes
  *
- * Returns: < 0 on failure
+ * Returns: < 0 on failure, -ENODEV if the device has been unregistered
  */
 int rpmb_route_frames(struct rpmb_dev *rdev, u8 *req,
 		      unsigned int req_len, u8 *rsp, unsigned int rsp_len)
 {
+	int ret = -ENODEV;
+
 	if (!req || !req_len || !rsp || !rsp_len)
 		return -EINVAL;
 
-	return rdev->descr.route_frames(rdev->dev.parent, req, req_len,
-					rsp, rsp_len);
+	down_read(&rdev->lock);
+	if (rdev->descr.route_frames)
+		ret = rdev->descr.route_frames(rdev->dev.parent, req, req_len,
+					       rsp, rsp_len);
+	up_read(&rdev->lock);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(rpmb_route_frames);
 
@@ -126,6 +133,10 @@ EXPORT_SYMBOL_GPL(rpmb_interface_unregister);
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
@@ -133,6 +144,10 @@ int rpmb_dev_unregister(struct rpmb_dev *rdev)
 	if (!rdev)
 		return -EINVAL;
 
+	down_write(&rdev->lock);
+	rdev->descr.route_frames = NULL;
+	up_write(&rdev->lock);
+
 	device_del(&rdev->dev);
 
 	rpmb_dev_put(rdev);
@@ -165,6 +180,7 @@ struct rpmb_dev *rpmb_dev_register(struct device *dev,
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

