Return-Path: <SRS0=ivLu=BN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5770C433E0
	for <virtualization@archiver.kernel.org>; Mon,  3 Aug 2020 12:04:46 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 921C020678
	for <virtualization@archiver.kernel.org>; Mon,  3 Aug 2020 12:04:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 921C020678
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 4F2E18681A;
	Mon,  3 Aug 2020 12:04:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5KRRdNu51jKK; Mon,  3 Aug 2020 12:04:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 23E1F8680D;
	Mon,  3 Aug 2020 12:04:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 06E4AC0051;
	Mon,  3 Aug 2020 12:04:42 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7A529C004C
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Aug 2020 12:04:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 62B2185AF1
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Aug 2020 12:04:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tlA57131XyNj
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Aug 2020 12:04:38 +0000 (UTC)
X-Greylist: delayed 00:15:46 by SQLgrey-1.7.6
Received: from mxct.zte.com.cn (out1.zte.com.cn [202.103.147.172])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id B0E1D85A96
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Aug 2020 12:04:38 +0000 (UTC)
Received: from mse-fl1.zte.com.cn (unknown [10.30.14.238])
 by Forcepoint Email with ESMTPS id 6D3A3CCBE0C8360DBA6B;
 Mon,  3 Aug 2020 19:48:47 +0800 (CST)
Received: from notes_smtp.zte.com.cn (notessmtp.zte.com.cn [10.30.1.239])
 by mse-fl1.zte.com.cn with ESMTP id 073BmjGR014618;
 Mon, 3 Aug 2020 19:48:45 +0800 (GMT-8)
 (envelope-from wang.yi59@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
 by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
 with ESMTP id 2020080319485078-4487275 ;
 Mon, 3 Aug 2020 19:48:50 +0800 
From: Yi Wang <wang.yi59@zte.com.cn>
To: mst@redhat.com
Subject: [PATCH] virtio_pci_modern: Fix the comment of
 virtio_pci_find_capability()
Date: Mon, 3 Aug 2020 19:52:24 +0800
Message-Id: <1596455545-43556-1-git-send-email-wang.yi59@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release
 8.5.3FP6|November 21, 2013) at 2020-08-03 19:48:50,
 Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2020-08-03 19:48:46, Serialize complete at 2020-08-03 19:48:46
X-MAIL: mse-fl1.zte.com.cn 073BmjGR014618
Cc: wang.yi59@zte.com.cn, wang.liang82@zte.com.cn, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, xue.zhihong@zte.com.cn,
 Liao Pingfang <liao.pingfang@zte.com.cn>
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

From: Liao Pingfang <liao.pingfang@zte.com.cn>

Fix the comment of virtio_pci_find_capability() by adding missing comment
for the last parameter: bars.

Fixes: 59a5b0f7bf74 ("virtio-pci: alloc only resources actually used.")
Signed-off-by: Liao Pingfang <liao.pingfang@zte.com.cn>
Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
---
 drivers/virtio/virtio_pci_modern.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index db93cedd262f..9bdc6f68221f 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -481,6 +481,7 @@ static const struct virtio_config_ops virtio_pci_config_ops = {
  * @dev: the pci device
  * @cfg_type: the VIRTIO_PCI_CAP_* value we seek
  * @ioresource_types: IORESOURCE_MEM and/or IORESOURCE_IO.
+ * @bars: the bitmask of BARs
  *
  * Returns offset of the capability, or 0.
  */
-- 
2.26.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
