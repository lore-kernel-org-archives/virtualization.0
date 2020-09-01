Return-Path: <SRS0=JuYR=CK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C260C2BD11
	for <virtualization@archiver.kernel.org>; Tue,  1 Sep 2020 15:58:19 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDCCA206FA
	for <virtualization@archiver.kernel.org>; Tue,  1 Sep 2020 15:58:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Gd9YLKEU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDCCA206FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 49ED1203D2;
	Tue,  1 Sep 2020 15:58:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SZsl2GbPO7R6; Tue,  1 Sep 2020 15:58:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 6DA7121538;
	Tue,  1 Sep 2020 15:58:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3E326C0051;
	Tue,  1 Sep 2020 15:58:15 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CA863C0051
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Sep 2020 15:58:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 9847986396
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Sep 2020 15:58:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id d8eBaPm0hl0g
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Sep 2020 15:58:12 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 7004586432
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Sep 2020 15:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=YMlFrJEyBw+GGxYkmnybpKhHqx0sfDNv5s7PaPhHxwU=; b=Gd9YLKEUh+L4SFkaUhbHG3M8dD
 CML4P2q8lRLBgi2V/zqNZbsMdET9SOcLwrXiQhlC89FsEOhv4JJUVlczC5tz1NVFJGPZUGNw0mpN5
 qzMVcmbfdKTrImeYfVqLp70KKyuHY1d2ubXJy5DbmFDTX/vqy+og9g1EbJ/6WSVHl1eU8SSA2z/HI
 ytc8BoebmRFkeg1tryurIuFiGvIV6ETH0Mg6xVt+XrjRDBbOJe+pEs56+koko8zHmKVzoDwGo8HoE
 qpYFiFPkZtW/ERm5Tm+y4EKezU04PHf7JUWHAb6eJCibEvzWG7ZWLoJFdHCtl/sk7HYfM9oltIJYO
 AW3zTaqw==;
Received: from [2001:4bb8:18c:45ba:2f95:e5:ca6b:9b4a] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kD8fZ-0004Qh-74; Tue, 01 Sep 2020 15:58:01 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6/9] nvme: opencode revalidate_disk in nvme_validate_ns
Date: Tue,  1 Sep 2020 17:57:45 +0200
Message-Id: <20200901155748.2884-7-hch@lst.de>
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

Keep control in the NVMe driver instead of going through an indirect
call back into ->revalidate_disk.  Also reorder the function a bit to be
easier to follow with the additional code.

And now that we have removed all callers of revalidate_disk() in the nvme
code, ->revalidate_disk is only called from the open code when first
opening the device.  Which is of course totally pointless as we have
a valid size since the initial scan, and will get an updated view
through the asynchronous notifiation everytime the size changes.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index bc18523774b4be..9428e7deb68b09 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2323,7 +2323,6 @@ static const struct block_device_operations nvme_fops = {
 	.open		= nvme_open,
 	.release	= nvme_release,
 	.getgeo		= nvme_getgeo,
-	.revalidate_disk= nvme_revalidate_disk,
 	.report_zones	= nvme_report_zones,
 	.pr_ops		= &nvme_pr_ops,
 };
@@ -4020,14 +4019,19 @@ static void nvme_ns_remove_by_nsid(struct nvme_ctrl *ctrl, u32 nsid)
 static void nvme_validate_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 {
 	struct nvme_ns *ns;
+	int ret;
 
 	ns = nvme_find_get_ns(ctrl, nsid);
-	if (ns) {
-		if (revalidate_disk(ns->disk))
-			nvme_ns_remove(ns);
-		nvme_put_ns(ns);
-	} else
+	if (!ns) {
 		nvme_alloc_ns(ctrl, nsid);
+		return;
+	}
+
+	ret = nvme_revalidate_disk(ns->disk);
+	revalidate_disk_size(ns->disk, ret == 0);
+	if (ret)
+		nvme_ns_remove(ns);
+	nvme_put_ns(ns);
 }
 
 static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
-- 
2.28.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
