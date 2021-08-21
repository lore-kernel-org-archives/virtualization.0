Return-Path: <SRS0=oUUb=NM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA51DC4338F
	for <virtualization@archiver.kernel.org>; Sat, 21 Aug 2021 12:34:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A80576121E
	for <virtualization@archiver.kernel.org>; Sat, 21 Aug 2021 12:34:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A80576121E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baidu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 54F6C40405;
	Sat, 21 Aug 2021 12:34:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zq3L1ezJL-Fu; Sat, 21 Aug 2021 12:33:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D845F403F4;
	Sat, 21 Aug 2021 12:33:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ACE78C001A;
	Sat, 21 Aug 2021 12:33:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 30F90C000E
 for <virtualization@lists.linux-foundation.org>;
 Sat, 21 Aug 2021 12:33:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 23E3B80F7D
 for <virtualization@lists.linux-foundation.org>;
 Sat, 21 Aug 2021 12:33:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kd7wHl2t07T1
 for <virtualization@lists.linux-foundation.org>;
 Sat, 21 Aug 2021 12:33:56 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from baidu.com (mx21.baidu.com [220.181.3.85])
 by smtp1.osuosl.org (Postfix) with ESMTP id C96AB80F6F
 for <virtualization@lists.linux-foundation.org>;
 Sat, 21 Aug 2021 12:33:49 +0000 (UTC)
Received: from BJHW-Mail-Ex12.internal.baidu.com (unknown [10.127.64.35])
 by Forcepoint Email with ESMTPS id 006E2AF749E98B88988C;
 Sat, 21 Aug 2021 20:33:41 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BJHW-Mail-Ex12.internal.baidu.com (10.127.64.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Sat, 21 Aug 2021 20:33:41 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.62.17) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Sat, 21 Aug 2021 20:33:34 +0800
From: Cai Huoqing <caihuoqing@baidu.com>
To: <mst@redhat.com>, <jasowang@redhat.com>, <pbonzini@redhat.com>,
 <stefanha@redhat.com>
Subject: [PATCH] vhost scsi: Convert to SPDX identifier
Date: Sat, 21 Aug 2021 20:33:20 +0800
Message-ID: <20210821123320.734-1-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.32.0.windows.2
MIME-Version: 1.0
X-Originating-IP: [172.31.62.17]
X-ClientProxiedBy: BJHW-Mail-Ex11.internal.baidu.com (10.127.64.34) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
X-Baidu-BdMsfe-DateCheck: 1_BJHW-Mail-Ex12_2021-08-21 20:33:41:971
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
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

use SPDX-License-Identifier instead of a verbose license text

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
---
 drivers/vhost/scsi.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index 46f897e41217..532e204f2b1b 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -1,24 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*******************************************************************************
  * Vhost kernel TCM fabric driver for virtio SCSI initiators
  *
  * (C) Copyright 2010-2013 Datera, Inc.
  * (C) Copyright 2010-2012 IBM Corp.
  *
- * Licensed to the Linux Foundation under the General Public License (GPL) version 2.
- *
  * Authors: Nicholas A. Bellinger <nab@daterainc.com>
  *          Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
  ****************************************************************************/
 
 #include <linux/module.h>
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
