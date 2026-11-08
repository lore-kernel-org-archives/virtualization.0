Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.56.87.5
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794159694;
	b=h7wr+IcMruhvUarOu1SgmnFo6Ttd7/LPrunqj5eiz6a3w+jTSKek6Iscplx9J7k9zQnv
	 XGbCyngMMDG4QBveZYGGfqV+XG2FO67OzjbCanNQ2iYl2I7geKltF+qh79+JpWRN1QI0g
	 T7c/JvryNmN8BE1shpPUy0czfMRBYOa6pLE5cACx5bZ3xGbB3SxngBVC1pqEpGCPNYK9L
	 ksHtwpqE/870qSd9hAOHT8XBnYAX/qUO12XQHyqM0PAUnbsnZTE+Z9S1XVTWObMnLikK4
	 HDXwIh7YQLZFY8HwTm73zQL7xq/b3RaMhm25JxAlo51ijxfui4h9p2H//UQqTguxtyg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794159694;
	h=DMARC-Filter:DKIM-Signature:Received:DKIM-Signature:Received:From:
	 Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-Source:X-Source-Args:
	 X-Source-Dir:X-SGantispam-id:X-AntiAbuse:AntiSpam-DLS:AntiSpam-DLSP:
	 AntiSpam-DLSRS:AntiSpam-TS:CFBL-Address:CFBL-Feedback-ID;
	bh=GuCEUk+D57C1uh6zVqLkb4f3+lp4MzyMcZvNcQqPZDg=;
	b=BDjFhuZisLfSnWaOYeB/qQN1tv3Rmpq7HkwIFeFmLJu5MOTqGXMJcUJIQ56fJ6V3JYKQ
	 UhnmOeklmNzv+aY514jEnLVNdRpQEcRjxpp6fanMj41m3cVoG86hnIcdeQY40GqhvbHBX
	 RxOFrb/UrLwrLJNPeTO7ULumsezQaykYAg4RZcP74wQZ6kDvej7JCWI+rmapx3iDdXbCc
	 9pzQDXxil/DcYdVGhOepMnW5yjmv/HCfqEvsKkRW4Lz41rXYDudeUAMHC+wUSmE172UxW
	 UGIOAG83UywZsCRIiSARx+INKw7+ejaUum4ES0HRpQxnzXnSQKxxAdOfePdfo/Y3v+w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valla.it;
	spf=pass smtp.mailfrom=valla.it;
	dkim=pass header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.a=rsa-sha256 header.s=default header.b="mRAsCV/I";
	dkim=pass header.d=valla.it header.i=@valla.it header.a=rsa-sha256 header.s=default header.b=epkPDNn0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.56.87.5
Received: from delivery.antispam.mailspamprotection.com (delivery.antispam.mailspamprotection.com [185.56.87.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF915606A31C
	for <virtualization@lists.linux.dev>; Sun,  8 Nov 2026 17:41:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF915606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valla.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.a=rsa-sha256 header.s=default header.b=mRAsCV/I;
	dkim=pass (1024-bit key, unprotected) header.d=valla.it header.i=@valla.it header.a=rsa-sha256 header.s=default header.b=epkPDNn0
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=outgoing.instance-europe-west4-4zq2.prod.antispam.mailspamprotection.com; s=arckey; t=1794159693;
	 b=oQuyyMHXNq4Lx3RgQAOiI+68cpyz8MXSD8lYV+gIC9G0rShzDXU5OEWhKDRgRE1fotlKI2sLhX
	  YkyTtsFnn0e6RBcOTN/AbP6r21192IVDGMj+zeqn2ZoMlrCrjx82qeWIlpfHdCg4BdNAkNLCa8
	  CB3S4+JUb6aGgTeOopYjp0Lf+YnUpd6A75fSijbC3Ew4nLx6cOuimr5iAYiiYcSXEQ9cYLTQrN
	  r48W0kr1Cyttd8MDDQW8wATll2m9vf9WH0v6Qr7Zxj07PtQroVolI8K2w7VuKFOG3zDYHwhiYR
	  vj56wC8F4wSV1Z+Fov2AW0f9PhjgfJ88HXpG8Yw4ajxyiw==;
ARC-Authentication-Results: i=1; outgoing.instance-europe-west4-4zq2.prod.antispam.mailspamprotection.com; smtp.remote-ip=35.214.173.214;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=outgoing.instance-europe-west4-4zq2.prod.antispam.mailspamprotection.com; s=arckey; t=1794159693;
	bh=f6VW1MvnrvYMrfcCLmWVZetubLXwndYussOEkJ8pShI=;
	h=Cc:To:Message-ID:Content-Transfer-Encoding:Content-Type:MIME-Version:
	  Subject:Date:From:DKIM-Signature:DKIM-Signature;
	b=nVZIhHXa7iCp+9j99ESm5G7n5SJsh7Yqb9MBc5D+VVajn0z9/ZOGB5/4gY9f1wh4p2tCoQoM05
	  JzVjToxPc9sA2RIMuXBC2Nj/PXtg/AmPK65jAoFLqS3YN+41m04eJNZPcd6KS1d7Bi5fLHATPQ
	  UCWm8g5SY0DTk7+YMoIwznOI72Z79jlJa059BMIr+h/dDbhMBwyBGwLe1eJQJoiTq3dnf/3Mpk
	  4udRR+nxuHv5nX6aeBKOhgvv4CkcPY3ihv4RqxoeL6xPjinShLRR7pKtcK/LFx2PaRo0GE28q6
	  yn6ISasnttgxFXd1OWp/bP+tvFr0YK9000kM0o/rUmvn1w==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
	:Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject
	:Date:From:Reply-To:List-Unsubscribe;
	bh=GuCEUk+D57C1uh6zVqLkb4f3+lp4MzyMcZvNcQqPZDg=; b=mRAsCV/IMTdLlXOp4tgU1+EZQr
	OsJH+3kC6HMUN990EnpJnexXSjCZwt2d5haE8z0SYDSc/OMAYXHFHNactQ0z7V5W9nltY3otD9rt3
	MwSXG1HUdMdvlRS4stA+a1ZuaGtxn83wYjgPzrX9V+7E2jqWoPJno7YikUniqCvygdnM=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214] helo=esm19.siteground.biz)
	by instance-europe-west4-4zq2.prod.antispam.mailspamprotection.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <francesco@valla.it>)
	id 1xQ6tX-00000006zPC-1qlx
	for virtualization@lists.linux.dev;
	Sun, 08 Nov 2026 17:41:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
	s=default; h=Cc:To:Subject:Date:From:list-help:list-unsubscribe:
	list-subscribe:list-post:list-owner:list-archive;
	bh=GuCEUk+D57C1uh6zVqLkb4f3+lp4MzyMcZvNcQqPZDg=; b=epkPDNn0n1mGyBXyhhYFXxiiSB
	kOl0mAii8NQbLgzIAAK+rzOJcL7SQo08LqvUCSqk496EBOXWC2sL20l9OV8gfRCU1hzKJgiA73U96
	TNEB4SJ8lS+2vJrXxRCc20ybHCE5jBUcxu0JXAn2iTAsBLZP7N+R+R/RMAFuUHZVUpNc=;
Received: from [79.17.15.196] (port=60387 helo=[192.168.178.158])
	by esm19.siteground.biz with essmtpa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <francesco@valla.it>)
	id 1xQ6tT-00000000EOl-31vG;
	Sun, 08 Nov 2026 17:41:27 +0000
From: Francesco Valla <francesco@valla.it>
Date: Sun, 08 Nov 2026 18:41:17 +0100
Subject: [PATCH] spi: virtio: move teardown to .remove()
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261108-spi_virtio_remove-v1-1-fda5f0996290@valla.it>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqDMBBA0avIrBtIgrahV5ESNE7rCDUyo0EQ7
 27U5Vv8v4EgEwq8iw0YEwnFMcM8Cgh9M/5QUZcNVtunMdopmcgn4pmiZ/zHhMoF66pGd+XLVpC
 7ifFL6/WsP7dlaQcM8zmCfT8A9Kn3Z3UAAAA=
X-Change-ID: 20261108-spi_virtio_remove-8c285a0d4725
To: Mark Brown <broonie@kernel.org>
Cc: virtualization@lists.linux.dev, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Francesco Valla <francesco@valla.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2813; i=francesco@valla.it;
 h=from:subject:message-id; bh=f6VW1MvnrvYMrfcCLmWVZetubLXwndYussOEkJ8pShI=;
 b=owGbwMvMwCX2aH1OUIzHTgbG02pJDFkftjjl+K7q3WhZ8XnW0iO7mT6kTuUKfaRSdrA2uslFb
 ZeteubFjlIWBjEuBlkxRZaQdTfu7Zlr/i1tA+MjmDmsTCBDGLg4BWAiGW8ZGb4aX3+5jD8l7dTr
 sKDHjA37tkx9Inh8Hr+wr5/qml2Kl/Yx/FN0vlzMdfz7j2dJ+5se3Jpj8f36fy/bjMqWHy1XLq6
 okuMDAA==
X-Developer-Key: i=francesco@valla.it; a=openpgp;
 fpr=CC70CBC9AA13257C6CCED8669601767CA07CA0EA
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - esm19.siteground.biz
X-AntiAbuse: Original Domain - lists.linux.dev
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - valla.it
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-SGantispam-id: 149683644b4495b2c01ebd825e019e5f
X-AntiAbuse: ID - 149683644b4495b2c01ebd825e019e5f
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1xQ6tX-00000006zPC-1qlx-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-4zq2.prod.antispam.mailspamprotection.com;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none

The .remove() callback is not marked as optional for a virtio_driver,
and thus a missing one is a bug. Moreover, the virtio framework expects
a driver to reset the device it controls during teardown and explicitly
checks for this reading the device status and WARNing in case it is
still running. Any devm cleanup action gets however called after that
check, leading to the WARN_ON condition to always be true for
spi-virtio; thus, an empty remove() is not an option.

Move the cleanup actions to the .remove() callback of the driver and
adapt the surrounding code to the new behavior.

Fixes: f98cabe3f6cf ("SPI: Add virtio SPI driver")
Signed-off-by: Francesco Valla <francesco@valla.it>
---
 drivers/spi/spi-virtio.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-virtio.c b/drivers/spi/spi-virtio.c
index 26f9711c99b3..2eeb79ff5aa2 100644
--- a/drivers/spi/spi-virtio.c
+++ b/drivers/spi/spi-virtio.c
@@ -315,10 +315,8 @@ static int virtio_spi_find_vqs(struct virtio_spi_priv *priv)
 }
 
 /* Function must not be called before virtio_spi_find_vqs() has been run */
-static void virtio_spi_del_vq(void *data)
+static void virtio_spi_del_vq(struct virtio_device *vdev)
 {
-	struct virtio_device *vdev = data;
-
 	virtio_reset_device(vdev);
 	vdev->config->del_vqs(vdev);
 }
@@ -347,21 +345,26 @@ static int virtio_spi_probe(struct virtio_device *vdev)
 	if (ret)
 		return dev_err_probe(&vdev->dev, ret, "Cannot setup virtqueues\n");
 
-	/* Register cleanup for virtqueues using devm */
-	ret = devm_add_action_or_reset(&vdev->dev, virtio_spi_del_vq, vdev);
-	if (ret)
-		return dev_err_probe(&vdev->dev, ret, "Cannot register virtqueue cleanup\n");
-
 	virtio_device_ready(vdev);
 
-	/* Use devm version to register controller */
-	ret = devm_spi_register_controller(&vdev->dev, ctrl);
-	if (ret)
+	ret = spi_register_controller(ctrl);
+	if (ret) {
+		virtio_spi_del_vq(vdev);
 		return dev_err_probe(&vdev->dev, ret, "Cannot register controller\n");
+	}
 
 	return 0;
 }
 
+static void virtio_spi_remove(struct virtio_device *vdev)
+{
+	struct spi_controller *ctrl = dev_get_drvdata(&vdev->dev);
+
+	spi_unregister_controller(ctrl);
+
+	virtio_spi_del_vq(vdev);
+}
+
 static int virtio_spi_freeze(struct device *dev)
 {
 	struct spi_controller *ctrl = dev_get_drvdata(dev);
@@ -415,6 +418,7 @@ static struct virtio_driver virtio_spi_driver = {
 	},
 	.id_table = virtio_spi_id_table,
 	.probe = virtio_spi_probe,
+	.remove = virtio_spi_remove,
 };
 module_virtio_driver(virtio_spi_driver);
 

---
base-commit: fa4ad798f6f681031775266044ba1b0cf3c670bd
change-id: 20261108-spi_virtio_remove-8c285a0d4725

Best regards,
--  
Francesco Valla <francesco@valla.it>

