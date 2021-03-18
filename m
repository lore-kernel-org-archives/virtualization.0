Return-Path: <SRS0=KYCx=IQ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95056C4332D
	for <virtualization@archiver.kernel.org>; Thu, 18 Mar 2021 10:29:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CD4064E89
	for <virtualization@archiver.kernel.org>; Thu, 18 Mar 2021 10:29:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CD4064E89
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5EE846FA1E;
	Thu, 18 Mar 2021 10:29:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CvT9yxJMnCrT; Thu, 18 Mar 2021 10:29:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id D8A256FACD;
	Thu, 18 Mar 2021 10:29:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 09E11C0018;
	Thu, 18 Mar 2021 10:29:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1F567C0001
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Mar 2021 10:29:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 91C57606B1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Mar 2021 10:29:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id adPlg2QY2cbn
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Mar 2021 10:29:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9E7526F9AF
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Mar 2021 10:29:31 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 105C4AD6D;
 Thu, 18 Mar 2021 10:29:30 +0000 (UTC)
From: Thomas Zimmermann <tzimmermann@suse.de>
To: daniel@ffwll.ch, airlied@linux.ie, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, kraxel@redhat.com, corbet@lwn.net, lgirdwood@gmail.com,
 broonie@kernel.org, sam@ravnborg.org, robh@kernel.org,
 emil.l.velikov@gmail.com, geert+renesas@glider.be, hdegoede@redhat.com,
 bluescreen_avenger@verizon.net
Subject: [PATCH v2 08/10] drm/simpledrm: Acquire clocks from DT device node
Date: Thu, 18 Mar 2021 11:29:19 +0100
Message-Id: <20210318102921.21536-9-tzimmermann@suse.de>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210318102921.21536-1-tzimmermann@suse.de>
References: <20210318102921.21536-1-tzimmermann@suse.de>
MIME-Version: 1.0
Cc: virtualization@lists.linux-foundation.org,
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org,
 linux-doc@vger.kernel.org
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

Make sure required hardware clocks are enabled while the firmware
framebuffer is in use.

The basic code has been taken from the simplefb driver and adapted
to DRM. Clocks are released automatically via devres helpers.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Tested-by: nerdopolis <bluescreen_avenger@verizon.net>
---
 drivers/gpu/drm/tiny/simpledrm.c | 108 +++++++++++++++++++++++++++++++
 1 file changed, 108 insertions(+)

diff --git a/drivers/gpu/drm/tiny/simpledrm.c b/drivers/gpu/drm/tiny/simpledrm.c
index c9cef2b50de6..10ca3373b61f 100644
--- a/drivers/gpu/drm/tiny/simpledrm.c
+++ b/drivers/gpu/drm/tiny/simpledrm.c
@@ -1,5 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
+#include <linux/clk.h>
+#include <linux/of_clk.h>
 #include <linux/platform_data/simplefb.h>
 #include <linux/platform_device.h>
 
@@ -190,6 +192,12 @@ struct simpledrm_device {
 	struct drm_device dev;
 	struct platform_device *pdev;
 
+	/* clocks */
+#if defined CONFIG_OF && defined CONFIG_COMMON_CLK
+	unsigned int clk_count;
+	struct clk **clks;
+#endif
+
 	/* simplefb settings */
 	struct drm_display_mode mode;
 	const struct drm_format_info *format;
@@ -211,6 +219,103 @@ static struct simpledrm_device *simpledrm_device_of_dev(struct drm_device *dev)
 	return container_of(dev, struct simpledrm_device, dev);
 }
 
+/*
+ * Hardware
+ */
+
+#if defined CONFIG_OF && defined CONFIG_COMMON_CLK
+/*
+ * Clock handling code.
+ *
+ * Here we handle the clocks property of our "simple-framebuffer" dt node.
+ * This is necessary so that we can make sure that any clocks needed by
+ * the display engine that the bootloader set up for us (and for which it
+ * provided a simplefb dt node), stay up, for the life of the simplefb
+ * driver.
+ *
+ * When the driver unloads, we cleanly disable, and then release the clocks.
+ *
+ * We only complain about errors here, no action is taken as the most likely
+ * error can only happen due to a mismatch between the bootloader which set
+ * up simplefb, and the clock definitions in the device tree. Chances are
+ * that there are no adverse effects, and if there are, a clean teardown of
+ * the fb probe will not help us much either. So just complain and carry on,
+ * and hope that the user actually gets a working fb at the end of things.
+ */
+
+static void simpledrm_device_release_clocks(void *res)
+{
+	struct simpledrm_device *sdev = simpledrm_device_of_dev(res);
+	unsigned int i;
+
+	for (i = 0; i < sdev->clk_count; ++i) {
+		if (sdev->clks[i]) {
+			clk_disable_unprepare(sdev->clks[i]);
+			clk_put(sdev->clks[i]);
+		}
+	}
+}
+
+static int simpledrm_device_init_clocks(struct simpledrm_device *sdev)
+{
+	struct drm_device *dev = &sdev->dev;
+	struct platform_device *pdev = sdev->pdev;
+	struct device_node *of_node = pdev->dev.of_node;
+	struct clk *clock;
+	unsigned int i;
+	int ret;
+
+	if (dev_get_platdata(&pdev->dev) || !of_node)
+		return 0;
+
+	sdev->clk_count = of_clk_get_parent_count(of_node);
+	if (!sdev->clk_count)
+		return 0;
+
+	sdev->clks = drmm_kzalloc(dev, sdev->clk_count * sizeof(sdev->clks[0]),
+				  GFP_KERNEL);
+	if (!sdev->clks)
+		return -ENOMEM;
+
+	for (i = 0; i < sdev->clk_count; ++i) {
+		clock = of_clk_get(of_node, i);
+		if (IS_ERR(clock)) {
+			ret = PTR_ERR(clock);
+			if (ret == -EPROBE_DEFER)
+				goto err;
+			drm_err(dev, "clock %u not found: %d\n", i, ret);
+			continue;
+		}
+		ret = clk_prepare_enable(clock);
+		if (ret) {
+			drm_err(dev, "failed to enable clock %u: %d\n",
+				i, ret);
+			clk_put(clock);
+		}
+		sdev->clks[i] = clock;
+	}
+
+	return devm_add_action_or_reset(&pdev->dev,
+					simpledrm_device_release_clocks,
+					sdev);
+
+err:
+	while (i) {
+		--i;
+		if (sdev->clks[i]) {
+			clk_disable_unprepare(sdev->clks[i]);
+			clk_put(sdev->clks[i]);
+		}
+	}
+	return ret;
+}
+#else
+static int simpledrm_device_init_clocks(struct simpledrm_device *sdev)
+{
+	return 0;
+}
+#endif
+
 /*
  *  Simplefb settings
  */
@@ -534,6 +639,9 @@ simpledrm_device_create(struct drm_driver *drv, struct platform_device *pdev)
 		return ERR_CAST(sdev);
 	sdev->pdev = pdev;
 
+	ret = simpledrm_device_init_clocks(sdev);
+	if (ret)
+		return ERR_PTR(ret);
 	ret = simpledrm_device_init_fb(sdev);
 	if (ret)
 		return ERR_PTR(ret);
-- 
2.30.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
