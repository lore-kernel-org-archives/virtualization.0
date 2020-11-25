Return-Path: <SRS0=EQvy=E7=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C895CC56202
	for <virtualization@archiver.kernel.org>; Wed, 25 Nov 2020 13:18:23 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D80F9206E5
	for <virtualization@archiver.kernel.org>; Wed, 25 Nov 2020 13:18:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D80F9206E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=opensynergy.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 553FA86F95;
	Wed, 25 Nov 2020 13:18:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Uc9AiUWlWPzw; Wed, 25 Nov 2020 13:18:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9E60985C4C;
	Wed, 25 Nov 2020 13:18:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7FE8EC163C;
	Wed, 25 Nov 2020 13:18:19 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 44BA2C0052
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Nov 2020 13:18:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 25C282DEC9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Nov 2020 13:18:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LI46Ezkr+kiz
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Nov 2020 13:18:14 +0000 (UTC)
X-Greylist: delayed 00:08:43 by SQLgrey-1.7.6
Received: from plasma4.jpberlin.de (plasma4.jpberlin.de [80.241.57.33])
 by silver.osuosl.org (Postfix) with ESMTPS id 2AED320405
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Nov 2020 13:18:13 +0000 (UTC)
Received: from spamfilter06.heinlein-hosting.de
 (spamfilter06.heinlein-hosting.de [80.241.56.125])
 by plasma.jpberlin.de (Postfix) with ESMTP id D2786AB8BD;
 Wed, 25 Nov 2020 14:09:26 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from plasma.jpberlin.de ([80.241.56.68])
 by spamfilter06.heinlein-hosting.de (spamfilter06.heinlein-hosting.de
 [80.241.56.125]) (amavisd-new, port 10030)
 with ESMTP id Do3T6i8jw2_u; Wed, 25 Nov 2020 14:09:25 +0100 (CET)
Received: from webmail.opensynergy.com (unknown [217.66.60.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (Client CN "*.opensynergy.com",
 Issuer "Starfield Secure Certificate Authority - G2" (not verified))
 (Authenticated sender: opensynergy@jpberlin.de)
 by plasma.jpberlin.de (Postfix) with ESMTPSA id 6E4CFAAC9A;
 Wed, 25 Nov 2020 14:09:24 +0100 (CET)
From: Vasyl Vavrychuk <vasyl.vavrychuk@opensynergy.com>
To: <linux-input@vger.kernel.org>, <virtualization@lists.linux-foundation.org>
Subject: [PATCH] virtio-input: add multi-touch support
Date: Wed, 25 Nov 2020 15:09:02 +0200
Message-ID: <20201125130902.10185-1-vasyl.vavrychuk@opensynergy.com>
MIME-Version: 1.0
X-ClientProxiedBy: SR-MAIL-02.open-synergy.com (10.26.10.22) To
 SR-MAIL-01.open-synergy.com (10.26.10.21)
X-MBO-SPAM-Probability: 
X-Rspamd-Score: -4.61 / 15.00 / 15.00
X-Rspamd-Queue-Id: D2786AB8BD
X-Rspamd-UID: 7b76c8
Cc: Vasyl Vavrychuk <vasyl.vavrychuk@opensynergy.com>,
 Henrik Rydberg <rydberg@bitmath.org>,
 CROMBEZ Mathias <mathias.crombez@faurecia.com>
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

From: Mathias Crombez <mathias.crombez@faurecia.com>

Without multi-touch slots allocated, ABS_MT_SLOT events will be lost by
input_handle_abs_event.

Signed-off-by: Mathias Crombez <mathias.crombez@faurecia.com>
Signed-off-by: Vasyl Vavrychuk <vasyl.vavrychuk@opensynergy.com>
Tested-by: Vasyl Vavrychuk <vasyl.vavrychuk@opensynergy.com>
---
 drivers/virtio/Kconfig        | 11 +++++++++++
 drivers/virtio/virtio_input.c |  8 ++++++++
 2 files changed, 19 insertions(+)

diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
index 7b41130d3f35..2cfd5b01d96d 100644
--- a/drivers/virtio/Kconfig
+++ b/drivers/virtio/Kconfig
@@ -111,6 +111,17 @@ config VIRTIO_INPUT

         If unsure, say M.

+config VIRTIO_INPUT_MULTITOUCH_SLOTS
+       depends on VIRTIO_INPUT
+       int "Number of multitouch slots"
+       range 0 64
+       default 10
+       help
+        Define the number of multitouch slots used. Default to 10.
+        This parameter is unused if there is no multitouch capability.
+
+        0 will disable the feature.
+
 config VIRTIO_MMIO
        tristate "Platform bus driver for memory mapped virtio devices"
        depends on HAS_IOMEM && HAS_DMA
diff --git a/drivers/virtio/virtio_input.c b/drivers/virtio/virtio_input.c
index f1f6208edcf5..13f3d90e6c30 100644
--- a/drivers/virtio/virtio_input.c
+++ b/drivers/virtio/virtio_input.c
@@ -7,6 +7,7 @@

 #include <uapi/linux/virtio_ids.h>
 #include <uapi/linux/virtio_input.h>
+#include <linux/input/mt.h>

 struct virtio_input {
        struct virtio_device       *vdev;
@@ -205,6 +206,7 @@ static int virtinput_probe(struct virtio_device *vdev)
        unsigned long flags;
        size_t size;
        int abs, err;
+       bool is_mt = false;

        if (!virtio_has_feature(vdev, VIRTIO_F_VERSION_1))
                return -ENODEV;
@@ -287,9 +289,15 @@ static int virtinput_probe(struct virtio_device *vdev)
                for (abs = 0; abs < ABS_CNT; abs++) {
                        if (!test_bit(abs, vi->idev->absbit))
                                continue;
+                       if (input_is_mt_value(abs))
+                               is_mt = true;
                        virtinput_cfg_abs(vi, abs);
                }
        }
+       if (is_mt)
+               input_mt_init_slots(vi->idev,
+                                   CONFIG_VIRTIO_INPUT_MULTITOUCH_SLOTS,
+                                   INPUT_MT_DIRECT);

        virtio_device_ready(vdev);
        vi->ready = true;
--
2.23.0


Please mind our privacy notice<https://www.opensynergy.com/datenschutzerklaerung/privacy-notice-for-business-partners-pursuant-to-article-13-of-the-general-data-protection-regulation-gdpr/> pursuant to Art. 13 GDPR. // Unsere Hinweise zum Datenschutz gem. Art. 13 DSGVO finden Sie hier.<https://www.opensynergy.com/de/datenschutzerklaerung/datenschutzhinweise-fuer-geschaeftspartner-gem-art-13-dsgvo/>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
