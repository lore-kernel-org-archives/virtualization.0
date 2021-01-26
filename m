Return-Path: <SRS0=+Z4V=G5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FBE7C433E0
	for <virtualization@archiver.kernel.org>; Tue, 26 Jan 2021 19:50:52 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05B3822B3B
	for <virtualization@archiver.kernel.org>; Tue, 26 Jan 2021 19:50:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05B3822B3B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id A9757867D5;
	Tue, 26 Jan 2021 19:50:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KzE6aPF1BtCf; Tue, 26 Jan 2021 19:50:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 85B25867CF;
	Tue, 26 Jan 2021 19:50:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6EED9C08A1;
	Tue, 26 Jan 2021 19:50:50 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CBED1C013A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jan 2021 19:50:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id B93A586FDC
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jan 2021 19:50:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id My0GQP11IDFR
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jan 2021 19:50:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 42BFB86FC4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jan 2021 19:50:49 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id A0DB222B2C;
 Tue, 26 Jan 2021 19:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1611690648;
 bh=/6ngywS810oXL2ZA1A4zcs8uV/FXPP53uDQM5zBbkwM=;
 h=From:To:Cc:Subject:Date:From;
 b=nac9SDFmG9oX4kG01dO+elCsbd182MDOZNKBY25QVfMXGNtTi2SRohLDsEvkXLyLX
 JQeI/D7hch3yS7BQP1yGU5/0ES3eaGXsd7pyXOeJFb7Wq+DdmCxwiGddsUD86o9U29
 ZK5HG0LZSIS27WlJ0ACtqd7CvehtAyqdTUhbHHy8Cw9bvbNBMUXSfVisB1BSrDR0ns
 LsJmwNl32NfluNr+HJiFMIMDe//5g5e1P8MvXgDQGQjT3zko6g26EUb5gha/nLgXGP
 7w0wks0rLmp+9X2RLeETkn7r8M1RVYhknuxWKoqm8Hq0aIgDFK9DMwM87ySNsUXFo6
 OGKZB0giQ1gtw==
From: Bjorn Helgaas <helgaas@kernel.org>
To: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Dave Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Daniel Vetter <daniel@ffwll.ch>, Luca Coelho <luciano.coelho@intel.com>,
 Kalle Valo <kvalo@codeaurora.org>,
 "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH] Fix "ordering" comment typos
Date: Tue, 26 Jan 2021 13:50:42 -0600
Message-Id: <20210126195042.2909405-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: linux-pci@vger.kernel.org, linux-s390@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, linux-wireless@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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

From: Bjorn Helgaas <bhelgaas@google.com>

Fix comment typos in "ordering".

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/s390/include/asm/facility.h             | 2 +-
 drivers/gpu/drm/qxl/qxl_drv.c                | 2 +-
 drivers/net/wireless/intel/iwlwifi/fw/file.h | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)


Unless somebody objects, I'll just merge these typo fixes via the PCI tree.


diff --git a/arch/s390/include/asm/facility.h b/arch/s390/include/asm/facility.h
index 68c476b20b57..91b5d714d28f 100644
--- a/arch/s390/include/asm/facility.h
+++ b/arch/s390/include/asm/facility.h
@@ -44,7 +44,7 @@ static inline int __test_facility(unsigned long nr, void *facilities)
 }
 
 /*
- * The test_facility function uses the bit odering where the MSB is bit 0.
+ * The test_facility function uses the bit ordering where the MSB is bit 0.
  * That makes it easier to query facility bits with the bit number as
  * documented in the Principles of Operation.
  */
diff --git a/drivers/gpu/drm/qxl/qxl_drv.c b/drivers/gpu/drm/qxl/qxl_drv.c
index 6e7f16f4cec7..dab190a547cc 100644
--- a/drivers/gpu/drm/qxl/qxl_drv.c
+++ b/drivers/gpu/drm/qxl/qxl_drv.c
@@ -141,7 +141,7 @@ static void qxl_drm_release(struct drm_device *dev)
 
 	/*
 	 * TODO: qxl_device_fini() call should be in qxl_pci_remove(),
-	 * reodering qxl_modeset_fini() + qxl_device_fini() calls is
+	 * reordering qxl_modeset_fini() + qxl_device_fini() calls is
 	 * non-trivial though.
 	 */
 	qxl_modeset_fini(qdev);
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/file.h b/drivers/net/wireless/intel/iwlwifi/fw/file.h
index 597bc88479ba..04fbfe5cbeb0 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/file.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/file.h
@@ -866,7 +866,7 @@ struct iwl_fw_dbg_trigger_time_event {
  * tx_bar: tid bitmap to configure on what tid the trigger should occur
  *	when a BAR is send (for an Rx BlocAck session).
  * frame_timeout: tid bitmap to configure on what tid the trigger should occur
- *	when a frame times out in the reodering buffer.
+ *	when a frame times out in the reordering buffer.
  */
 struct iwl_fw_dbg_trigger_ba {
 	__le16 rx_ba_start;
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
