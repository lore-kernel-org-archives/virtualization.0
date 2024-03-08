Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109B054BC9
	for <virtualization@lists.linux.dev>; Fri,  8 Mar 2024 08:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709887926; cv=none; b=FwTBnETjTM+RXfGo9yftu2dkW0Y8aqZr/kwCDWBu0cNNX5LrpABVNsjnPWHgDKlxxrWTxNOZqqTj7CtmXb7XfmqSEGlMO4F6+OjSPA6h/Cgphhl8vm2FnBfnN6uKDwpvQwvOfgrrFLoGeH1/DdVmdDpI0Q7Jlx/zykwMee2UpQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709887926; c=relaxed/simple;
	bh=MvSY8r1Krx1rKfGPGF2tqqKGuMEPrCCpu4pYJDPsdCs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MQKf7fddZknfvbJ/noPZ1eJPJF7nhH2hou5totdpHVFfcOF2hm3XjaeLiJz/wzyHZ1ZkChkYvg33UZXcgeMONT86klVI24VGVzk6i3lhvKvGOYpLh9GAFkKoUoOpLBBydCCYff9e0YMslLy9MXaa+Y1CLtk1cr63EEjGJbZ7ua0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1riVxI-00072X-DG; Fri, 08 Mar 2024 09:51:52 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1riVxH-0056Nu-0R; Fri, 08 Mar 2024 09:51:51 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1riVxG-00246L-31;
	Fri, 08 Mar 2024 09:51:50 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	virtualization@lists.linux.dev,
	kernel@pengutronix.de
Subject: [PATCH] virtio-mmio: Convert to platform remove callback returning void
Date: Fri,  8 Mar 2024 09:51:20 +0100
Message-ID:  <ef71f955531d5e41b20d801e1149bb08d155679a.1709886922.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1788; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=MvSY8r1Krx1rKfGPGF2tqqKGuMEPrCCpu4pYJDPsdCs=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBl6tGNVhx6jfBloi39sSQ5Y007kLE1vRoD3PelZ cPtz0Z5w/OJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZerRjQAKCRCPgPtYfRL+ TlMKCACvXe3ahdI6IkkW9mn6HBvkCNTW20T1bZ/xn1CmjAX0GqTv9xHDJE1H4jlry6NdkCgZBVH +jfnGRsH5ap/6/UaZUgxAP6aoFlgtKjrObJV9BlfRmotbiGYBlnKsvzCo0x5/FRBZjBfM4Dvkyv bjuSNoHUwquQBQzl7IUgd8WDWtxQs/4g9eAfvIr+Sb4nmzbLRnBEMpEIlda4563ot/0Lp5GNO/J Q2ODayXHXE0EcBAmWJItVotxiYJ4/9TRmuui/5Xu4pavW1wHkHFh8sIr8Nu1BQE6+47Kgodlbx2 Q2rMjwsWZ/8eszwRVm1hEOrS8GnHs0cjPEPYlr983l0LYYyx
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: virtualization@lists.linux.dev

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is ignored (apart
from emitting a warning) and this typically results in resource leaks.

To improve here there is a quest to make the remove callback return
void. In the first step of this quest all drivers are converted to
.remove_new(), which already returns void. Eventually after all drivers
are converted, .remove_new() will be renamed to .remove().

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/virtio/virtio_mmio.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index 59892a31cf76..173596589c71 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -696,12 +696,10 @@ static int virtio_mmio_probe(struct platform_device *pdev)
 	return rc;
 }
 
-static int virtio_mmio_remove(struct platform_device *pdev)
+static void virtio_mmio_remove(struct platform_device *pdev)
 {
 	struct virtio_mmio_device *vm_dev = platform_get_drvdata(pdev);
 	unregister_virtio_device(&vm_dev->vdev);
-
-	return 0;
 }
 
 
@@ -847,7 +845,7 @@ MODULE_DEVICE_TABLE(acpi, virtio_mmio_acpi_match);
 
 static struct platform_driver virtio_mmio_driver = {
 	.probe		= virtio_mmio_probe,
-	.remove		= virtio_mmio_remove,
+	.remove_new	= virtio_mmio_remove,
 	.driver		= {
 		.name	= "virtio-mmio",
 		.of_match_table	= virtio_mmio_match,

base-commit: 8ffc8b1bbd505e27e2c8439d326b6059c906c9dd
-- 
2.43.0

