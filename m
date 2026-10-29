Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.169.97
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793277714;
	b=zUOKLS9XVOfysFHna0K6StLhNK7UoeTpuNkT23JTDgqeoW8Ny3CJAMNT2X2dKGZcUrMk
	 2WOG3EPLu4p4nDs7qk27UOnPe27KVgTNhSPOJImBu0jsDEVf6vtpGySQZkxWakkmHcKPL
	 LrpvqEnQ2y12SJYA3cKKZQJGTyoTUXm8DbfQKEA7J6W/f70WhNmt93w4PaCzJlbFvAsvi
	 eEs7Yhtf0IvfdfLp61XFDQtHVB4K6x6iUCVy2yYC7qNvBLbSMdMadr60cUvMkaA4/8FuU
	 TzqeoFxOp2d5yVKolqEYWdMfNbHOdir+V2MvSU4bRCu+zNjvZUbdNGV7Rc+TuYRabKA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793277714;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-ZohoMailClient;
	bh=yL5B9w2fd33NoSP+kcRsaKmbMe4jGgNs82wbIhiis7g=;
	b=cgRsIN439FPzfZo8pls851ePDKe7CY3yTCittL8WVkBfDAFunZ+ytQxYNx0Ck7JcBxH6
	 NiIr1m0BOXhrs+d8vYLeLM4Gw20F+7blM9n96O4nXuPiwj+r7wXh2iEmBEB9lwpj7lN4W
	 EQNWPG2zeAF6McLqpUkCeV12jgSWQAS8WB6OUUq0iuL7EqSSA8F2jDfLSzh6iAvDL5Wul
	 BcrMb0j/RKC0IwNIfjPZTG+SUQ7OpJCuNDqoSdMqbesgUZbdZH1kclv5iKS4oMNWQatbp
	 9DW4oEnAsP1roP30TVIwy86MooQkcSXLqE3tGGj2vZMDJXeLim55frhZROdOrndseVA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zohomail.eu;
	spf=pass smtp.mailfrom=zohomail.eu;
	dkim=pass header.d=zohomail.eu header.i=@zohomail.eu header.a=rsa-sha256 header.s=zoho header.b=NHWjp1jG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.169.97
Received: from sender-pp-o97.zoho.eu (sender-pp-o97.zoho.eu [136.143.169.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136E2606A31A
	for <virtualization@lists.linux.dev>; Thu, 29 Oct 2026 12:41:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 136E2606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=zohomail.eu header.i=@zohomail.eu header.a=rsa-sha256 header.s=zoho header.b=NHWjp1jG
ARC-Seal: i=1; a=rsa-sha256; t=1793277700; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=NN+BpUhje+RSB6yukgnrLYY9dCC8ggRPVuaWsr1EEEGUu68TdlLcEAtK2xEtZo+ohZ5ewi4Hum8sxSvSakyUlWfw/WLG/Aws0li/OhlMPxixzXHTxDqsQvBA80RbtaLYgO6G7Dq3GnFPRbyHeuPDjrmx7+gsxwcGHREuZPeGcIs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1793277700; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=yL5B9w2fd33NoSP+kcRsaKmbMe4jGgNs82wbIhiis7g=; 
	b=kf6trDP4RF87vm+oqf7S2LmwGDv1F90r95pdxh32h4dlXaIqKadO6eVsqeXyfu4SCWRH0kW3WtrLKzs1zn5hihss28UU0biqrJ2Ac/Y6kBRp1B5JySL4RkhGPXZvc3ZYtnPx72W9zSyKJ1JNv7ggh2EperVOkYBmlKSnyMVT/sU=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=zohomail.eu;
	spf=pass  smtp.mailfrom=harukak@zohomail.eu;
	dmarc=pass header.from=<harukak@zohomail.eu>
DKIM-Signature: a=rsa-sha256; b=NHWjp1jGfK/Ur+0Ss4G99PuFNuTWQE8EjZ1fsgetR9Ee/pYS4xsuKGK0dwYz2gf1s7rjLMhyxkUyZ/5Ewa8x8/zasJ+cc5GuNIrY50wft+51LVcyrizGNthPtpvinWBU2A2rz2nkykgeoCc3LuzUu2xYudkogcPp2YqnfnKHyyI=; c=relaxed/relaxed; s=zoho; d=zohomail.eu; v=1; bh=yL5B9w2fd33NoSP+kcRsaKmbMe4jGgNs82wbIhiis7g=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zoho.eu with SMTPS id 1793277698427206.32998434140995;
	Thu, 29 Oct 2026 13:41:38 +0100 (CET)
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
Subject: [PATCH v2 1/2] rpmb: stop the routing after unregister
Date: Thu, 29 Oct 2026 21:41:31 +0900
Message-ID: <20261029124132.2354314-2-harukak@zohomail.eu>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261029124132.2354314-1-harukak@zohomail.eu>
References: <20261029124132.2354314-1-harukak@zohomail.eu>
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

