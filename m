Return-Path: <SRS0=OlB3=FH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59F19C433FE
	for <virtualization@archiver.kernel.org>; Thu,  3 Dec 2020 17:05:33 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1D1F207AE
	for <virtualization@archiver.kernel.org>; Thu,  3 Dec 2020 17:05:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1D1F207AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 138788773C;
	Thu,  3 Dec 2020 17:05:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id suhT8OcXAWUA; Thu,  3 Dec 2020 17:05:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 921D3876FA;
	Thu,  3 Dec 2020 17:05:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7D036C163C;
	Thu,  3 Dec 2020 17:05:29 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3FC93C0FA7
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Dec 2020 17:05:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 2C05686F13
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Dec 2020 17:05:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3xc02L0u5YZi
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Dec 2020 17:05:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id F3B6E86EE4
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Dec 2020 17:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1607015125;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aE3CJWv12p3c45pgVJgnnZEAR7LVIJzz6cumFBh2UmM=;
 b=hkAEI1AeMKNPnsNOgxYB64mx7BLLlp6524Ptue2N7A9YYTJ3IRY8DcWzQZ/SZB0ZJU/NqR
 4ZrtVcyr9WLkDDAhYBos63+rDf5AtYGUZXnk2qsj0jQSkWvMUv7uJhNApMNY7as757FhFc
 /i2FafPt19zN1hOXzxKCIxng4BGQ760=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-168-swkHTwh4PRqmK73FoUgZwA-1; Thu, 03 Dec 2020 12:05:21 -0500
X-MC-Unique: swkHTwh4PRqmK73FoUgZwA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5ED9F800D55;
 Thu,  3 Dec 2020 17:05:20 +0000 (UTC)
Received: from steredhat.redhat.com (ovpn-113-142.ams2.redhat.com
 [10.36.113.142])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 144555D6AC;
 Thu,  3 Dec 2020 17:05:17 +0000 (UTC)
From: Stefano Garzarella <sgarzare@redhat.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH v3 02/19] vdpa_sim: remove unnecessary headers inclusion
Date: Thu,  3 Dec 2020 18:04:54 +0100
Message-Id: <20201203170511.216407-3-sgarzare@redhat.com>
In-Reply-To: <20201203170511.216407-1-sgarzare@redhat.com>
References: <20201203170511.216407-1-sgarzare@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Cc: Laurent Vivier <lvivier@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 Shahaf Shuler <shahafs@nvidia.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Eli Cohen <elic@nvidia.com>, Oren Duer <oren@nvidia.com>
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

Some headers are not necessary, so let's remove them to do
some cleaning.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
v3:
- avoided to remove some headers with structures and functions directly
  used (device.h, slab.h, virtio_byteorder.h)[Jason]
---
 drivers/vdpa/vdpa_sim/vdpa_sim.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index 6a90fdb9cbfc..b08f28d20d8d 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -7,20 +7,10 @@
  *
  */
 
-#include <linux/init.h>
 #include <linux/module.h>
 #include <linux/device.h>
-#include <linux/kernel.h>
-#include <linux/fs.h>
-#include <linux/poll.h>
 #include <linux/slab.h>
-#include <linux/sched.h>
-#include <linux/wait.h>
-#include <linux/uuid.h>
-#include <linux/iommu.h>
 #include <linux/dma-map-ops.h>
-#include <linux/sysfs.h>
-#include <linux/file.h>
 #include <linux/etherdevice.h>
 #include <linux/vringh.h>
 #include <linux/vdpa.h>
-- 
2.26.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
