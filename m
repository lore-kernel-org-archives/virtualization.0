Return-Path: <SRS0=5KLU=JN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F4BC4363E
	for <virtualization@archiver.kernel.org>; Fri, 16 Apr 2021 09:01:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1ACE6100C
	for <virtualization@archiver.kernel.org>; Fri, 16 Apr 2021 09:01:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1ACE6100C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 905C840375;
	Fri, 16 Apr 2021 09:01:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id B5JFSHZnUEfB; Fri, 16 Apr 2021 09:01:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1E77B4067D;
	Fri, 16 Apr 2021 09:01:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AA68BC0013;
	Fri, 16 Apr 2021 09:01:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4F37EC000A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Apr 2021 09:00:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A69F160DD0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Apr 2021 09:00:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5HbqpepZRK04
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Apr 2021 09:00:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AFDBA6066C
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Apr 2021 09:00:55 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 3A913AF33;
 Fri, 16 Apr 2021 09:00:54 +0000 (UTC)
From: Thomas Zimmermann <tzimmermann@suse.de>
To: daniel@ffwll.ch, airlied@linux.ie, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, kraxel@redhat.com, corbet@lwn.net, lgirdwood@gmail.com,
 broonie@kernel.org, sam@ravnborg.org, robh@kernel.org,
 emil.l.velikov@gmail.com, geert+renesas@glider.be, hdegoede@redhat.com,
 bluescreen_avenger@verizon.net, gregkh@linuxfoundation.org
Subject: [PATCH v4 6/9] drm/simpledrm: Initialize framebuffer data from
 device-tree node
Date: Fri, 16 Apr 2021 11:00:45 +0200
Message-Id: <20210416090048.11492-7-tzimmermann@suse.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210416090048.11492-1-tzimmermann@suse.de>
References: <20210416090048.11492-1-tzimmermann@suse.de>
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

A firmware framebuffer might also be specified via device-tree files. If
no device platform data is given, try the DT device node.

v2:
	* add Device Tree match table
	* clean-up parser wrappers

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Tested-by: nerdopolis <bluescreen_avenger@verizon.net>
---
 drivers/gpu/drm/tiny/simpledrm.c | 89 ++++++++++++++++++++++++++++++++
 1 file changed, 89 insertions(+)

diff --git a/drivers/gpu/drm/tiny/simpledrm.c b/drivers/gpu/drm/tiny/simpledrm.c
index 64e8a8581d9a..53d6bec7d0b2 100644
--- a/drivers/gpu/drm/tiny/simpledrm.c
+++ b/drivers/gpu/drm/tiny/simpledrm.c
@@ -114,6 +114,74 @@ simplefb_get_format_pd(struct drm_device *dev,
 	return simplefb_get_validated_format(dev, pd->format);
 }
 
+static int
+simplefb_read_u32_of(struct drm_device *dev, struct device_node *of_node,
+		     const char *name, u32 *value)
+{
+	int ret = of_property_read_u32(of_node, name, value);
+
+	if (ret)
+		drm_err(dev, "simplefb: cannot parse framebuffer %s: error %d\n",
+			name, ret);
+	return ret;
+}
+
+static int
+simplefb_read_string_of(struct drm_device *dev, struct device_node *of_node,
+			const char *name, const char **value)
+{
+	int ret = of_property_read_string(of_node, name, value);
+
+	if (ret)
+		drm_err(dev, "simplefb: cannot parse framebuffer %s: error %d\n",
+			name, ret);
+	return ret;
+}
+
+static int
+simplefb_get_width_of(struct drm_device *dev, struct device_node *of_node)
+{
+	u32 width;
+	int ret = simplefb_read_u32_of(dev, of_node, "width", &width);
+
+	if (ret)
+		return ret;
+	return simplefb_get_validated_int0(dev, "width", width);
+}
+
+static int
+simplefb_get_height_of(struct drm_device *dev, struct device_node *of_node)
+{
+	u32 height;
+	int ret = simplefb_read_u32_of(dev, of_node, "height", &height);
+
+	if (ret)
+		return ret;
+	return simplefb_get_validated_int0(dev, "height", height);
+}
+
+static int
+simplefb_get_stride_of(struct drm_device *dev, struct device_node *of_node)
+{
+	u32 stride;
+	int ret = simplefb_read_u32_of(dev, of_node, "stride", &stride);
+
+	if (ret)
+		return ret;
+	return simplefb_get_validated_int(dev, "stride", stride);
+}
+
+static const struct drm_format_info *
+simplefb_get_format_of(struct drm_device *dev, struct device_node *of_node)
+{
+	const char *format;
+	int ret = simplefb_read_string_of(dev, of_node, "format", &format);
+
+	if (ret)
+		return ERR_PTR(ret);
+	return simplefb_get_validated_format(dev, format);
+}
+
 /*
  * Simple Framebuffer device
  */
@@ -166,6 +234,7 @@ static int simpledrm_device_init_fb(struct simpledrm_device *sdev)
 	struct drm_device *dev = &sdev->dev;
 	struct platform_device *pdev = sdev->pdev;
 	const struct simplefb_platform_data *pd = dev_get_platdata(&pdev->dev);
+	struct device_node *of_node = pdev->dev.of_node;
 
 	if (pd) {
 		width = simplefb_get_width_pd(dev, pd);
@@ -180,6 +249,19 @@ static int simpledrm_device_init_fb(struct simpledrm_device *sdev)
 		format = simplefb_get_format_pd(dev, pd);
 		if (IS_ERR(format))
 			return PTR_ERR(format);
+	} else if (of_node) {
+		width = simplefb_get_width_of(dev, of_node);
+		if (width < 0)
+			return width;
+		height = simplefb_get_height_of(dev, of_node);
+		if (height < 0)
+			return height;
+		stride = simplefb_get_stride_of(dev, of_node);
+		if (stride < 0)
+			return stride;
+		format = simplefb_get_format_of(dev, of_node);
+		if (IS_ERR(format))
+			return PTR_ERR(format);
 	} else {
 		drm_err(dev, "no simplefb configuration found\n");
 		return -ENODEV;
@@ -534,9 +616,16 @@ static int simpledrm_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id simpledrm_of_match_table[] = {
+	{ .compatible = "simple-framebuffer", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, simpledrm_of_match_table);
+
 static struct platform_driver simpledrm_platform_driver = {
 	.driver = {
 		.name = "simple-framebuffer", /* connect to sysfb */
+		.of_match_table = simpledrm_of_match_table,
 	},
 	.probe = simpledrm_probe,
 	.remove = simpledrm_remove,
-- 
2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
