Return-Path: <SRS0=JuYR=CK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C704C43461
	for <virtualization@archiver.kernel.org>; Tue,  1 Sep 2020 15:58:11 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3BE8206EB
	for <virtualization@archiver.kernel.org>; Tue,  1 Sep 2020 15:58:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BHj68uZe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3BE8206EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 9C2078708D;
	Tue,  1 Sep 2020 15:58:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id G92Wi9AcWMcF; Tue,  1 Sep 2020 15:58:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id EA2B98704F;
	Tue,  1 Sep 2020 15:58:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D9188C07FF;
	Tue,  1 Sep 2020 15:58:09 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E5979C0051
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Sep 2020 15:58:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id CDCB61FD90
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Sep 2020 15:58:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lbGF9mv--gm8
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Sep 2020 15:58:06 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by silver.osuosl.org (Postfix) with ESMTPS id 5DF111FD16
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Sep 2020 15:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=K5eIje+dXHxfLWtnzeoqBqIaTntBT6FnczHUHcmj9NM=; b=BHj68uZerC2AED+VGnjrkLa0Jh
 nsJRW5vm091mrlQN4jasrWRgCM1ySYUPiKOPMQFvHehK/MlKtnHTq4wA553107TmfoWBqjYusFfYX
 hdHxpzv+daxEQOnuXf6LklRx/LX2GKJBoWUUuYJ/y29nMBNvIIiiJqjuYtLUkOMxx5BP8xZfY/Z4A
 CFzRy/RgRKCcS7Au+4o2s+j98ZQ2HjaNhxqv/ZtdIfcmckO7GlAMLvRgJLn00q/4ttYSbN93Dmike
 0zdupPRWnfslW66yg0S9XJuGo14FgsCVoZ5MV+EfsKdkYr2KNA9ctgbrNlF6+GHh2s9ZqbM0SlrKW
 GAfzhSYQ==;
Received: from [2001:4bb8:18c:45ba:2f95:e5:ca6b:9b4a] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kD8fP-0004OY-KR; Tue, 01 Sep 2020 15:57:51 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/9] Documentation/filesystems/locking.rst: remove an
 incorrect sentence
Date: Tue,  1 Sep 2020 17:57:40 +0200
Message-Id: <20200901155748.2884-2-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901155748.2884-1-hch@lst.de>
References: <20200901155748.2884-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Cc: linux-raid@vger.kernel.org, linux-scsi@vger.kernel.org,
 "Martin K. Petersen" <martin.petersen@oracle.com>, linux-nvdimm@lists.01.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 Josef Bacik <josef@toxicpanda.com>, linux-block@vger.kernel.org,
 dm-devel@redhat.com, linux-fsdevel@vger.kernel.org,
 Dan Williams <dan.j.williams@intel.com>, nbd@other.debian.org,
 virtualization@lists.linux-foundation.org, ceph-devel@vger.kernel.org
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

unlock_native_capacity is never called from check_disk_change(), and
while revalidate_disk can be called from it, it can also be called
from two other places at the moment.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 Documentation/filesystems/locking.rst | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
index 64f94a18d97e75..c0f2c7586531b0 100644
--- a/Documentation/filesystems/locking.rst
+++ b/Documentation/filesystems/locking.rst
@@ -488,9 +488,6 @@ getgeo:			no
 swap_slot_free_notify:	no	(see below)
 ======================= ===================
 
-unlock_native_capacity and revalidate_disk are called only from
-check_disk_change().
-
 swap_slot_free_notify is called with swap_lock and sometimes the page lock
 held.
 
-- 
2.28.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
