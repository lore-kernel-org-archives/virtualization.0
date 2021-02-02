Return-Path: <SRS0=DeSX=HE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_RED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54294C433DB
	for <virtualization@archiver.kernel.org>; Tue,  2 Feb 2021 00:19:34 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B79E864E46
	for <virtualization@archiver.kernel.org>; Tue,  2 Feb 2021 00:19:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B79E864E46
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 794B0833F1;
	Tue,  2 Feb 2021 00:19:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sL4cXw24i7vg; Tue,  2 Feb 2021 00:19:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E0CEA82473;
	Tue,  2 Feb 2021 00:19:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BEB18C0174;
	Tue,  2 Feb 2021 00:19:32 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6780AC013A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Feb 2021 00:19:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 4E3E086F5C
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Feb 2021 00:19:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MOM6d8dTeeyz
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Feb 2021 00:19:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 8FAA286EB1
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Feb 2021 00:19:30 +0000 (UTC)
IronPort-SDR: ft75WJCB9St9ImQ39facW/i7eUhUmJx4tb6jLQFlSpjcNg3wv7SlNWI06LU4NZpzHfrMm/be3B
 NJwQiPgfujzw==
X-IronPort-AV: E=McAfee;i="6000,8403,9882"; a="168453443"
X-IronPort-AV: E=Sophos;i="5.79,393,1602572400"; d="scan'208";a="168453443"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Feb 2021 16:19:28 -0800
IronPort-SDR: 0el/ZUFk2oKZckT92Xih4Vw1AKkdg8qJ1n/L+8UYAMOCSKxgvGMphrbZkj4Mw7Cf38P0W1qH62
 VGks2eAzFX6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,393,1602572400"; d="scan'208";a="432589261"
Received: from unknown (HELO coxu-arch-shz.sh.intel.com) ([10.239.160.26])
 by orsmga001.jf.intel.com with ESMTP; 01 Feb 2021 16:19:26 -0800
From: Colin Xu <colin.xu@intel.com>
To: kraxel@redhat.com,
	mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH V2] virtio_input: Prevent EV_MSC/MSC_TIMESTAMP loop storm for
 MT.
Date: Tue,  2 Feb 2021 08:19:23 +0800
Message-Id: <20210202001923.6227-1-colin.xu@intel.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

In 'commit 29cc309d8bf1 ("HID: hid-multitouch: forward MSC_TIMESTAMP")',
EV_MSC/MSC_TIMESTAMP is added to each before EV_SYN event. EV_MSC is
configured as INPUT_PASS_TO_ALL.
In case of a touch device which report MSC_TIMESTAMP:
  BE pass EV_MSC/MSC_TIMESTAMP to FE on receiving event from evdev.
  FE pass EV_MSC/MSC_TIMESTAMP back to BE.
  BE writes EV_MSC/MSC_TIMESTAMP to evdev due to INPUT_PASS_TO_ALL.
  BE receives extra EV_MSC/MSC_TIMESTAMP and pass to FE.
>>> Each new frame becomes larger and larger.

Disable EV_MSC/MSC_TIMESTAMP forwarding for MT.

V2: Rebase.

Signed-off-by: Colin Xu <colin.xu@intel.com>
---
 drivers/virtio/virtio_input.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/virtio/virtio_input.c b/drivers/virtio/virtio_input.c
index f1f6208edcf5..244965c20d9b 100644
--- a/drivers/virtio/virtio_input.c
+++ b/drivers/virtio/virtio_input.c
@@ -64,6 +64,21 @@ static int virtinput_send_status(struct virtio_input *vi,
 	unsigned long flags;
 	int rc;
 
+	/*
+	 * Since 29cc309d8bf1 (HID: hid-multitouch: forward MSC_TIMESTAMP),
+	 * EV_MSC/MSC_TIMESTAMP is added to each before EV_SYN event.
+	 * EV_MSC is configured as INPUT_PASS_TO_ALL.
+	 * In case of touch device:
+	 *   BE pass EV_MSC/MSC_TIMESTAMP to FE on receiving event from evdev.
+	 *   FE pass EV_MSC/MSC_TIMESTAMP back to BE.
+	 *   BE writes EV_MSC/MSC_TIMESTAMP to evdev due to INPUT_PASS_TO_ALL.
+	 *   BE receives extra EV_MSC/MSC_TIMESTAMP and pass to FE.
+	 *   >>> Each new frame becomes larger and larger.
+	 * Disable EV_MSC/MSC_TIMESTAMP forwarding for MT.
+	 */
+	if (vi->idev->mt && type == EV_MSC && code == MSC_TIMESTAMP)
+		return 0;
+
 	stsbuf = kzalloc(sizeof(*stsbuf), GFP_ATOMIC);
 	if (!stsbuf)
 		return -ENOMEM;
-- 
2.30.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
