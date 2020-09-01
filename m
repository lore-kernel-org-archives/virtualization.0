Return-Path: <SRS0=JuYR=CK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56F88C2BC0E
	for <virtualization@archiver.kernel.org>; Tue,  1 Sep 2020 15:58:17 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B005206EB
	for <virtualization@archiver.kernel.org>; Tue,  1 Sep 2020 15:58:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="k2qZddWw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B005206EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 0674386444;
	Tue,  1 Sep 2020 15:58:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id d0Gd5UUPHgrk; Tue,  1 Sep 2020 15:58:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8D5FC86366;
	Tue,  1 Sep 2020 15:58:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 77626C07FF;
	Tue,  1 Sep 2020 15:58:16 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1FA1EC0051
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Sep 2020 15:58:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 132CE86C02
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Sep 2020 15:58:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id u6DtFSDMKuli
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Sep 2020 15:58:14 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 0443486BFF
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Sep 2020 15:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=nRA6JK+4aMp60Yu0KbqG4/pNdu09ibxhHSJ5/A99bDI=; b=k2qZddWw1U3EZJUTGVu0rHSLJs
 W5NgwgDkMU4Tctn8sp6QDS8uXrMAVU8TzWoAL6ToIpC7KJoKBS+hR10VJaRx7HUlCrn23sdr2GXXV
 PivvROx3tTElb1yMRSSSuseDaTpRWJpVWM5KD/wTw/IT+YTPLspEFsL9wpeIKfruOS68OSavOcO3b
 eKoyZN9jt6fhjHPyiO1n+Ltd23usEmrStZ0nhKSCgpp0vMkbLWmtuxBHj1SB6Hdbonp7qcS/5sHw1
 h6xT9GKSHXVkxt4Y/hHRE/O0vpV4ONoMUaFGKU12gPJqvqq6SOLh88NGCQe1kbJ3s68Vas9hCHfw2
 AZ8ApNWw==;
Received: from [2001:4bb8:18c:45ba:2f95:e5:ca6b:9b4a] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kD8fa-0004R3-Ip; Tue, 01 Sep 2020 15:58:02 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 7/9] sd: open code revalidate_disk
Date: Tue,  1 Sep 2020 17:57:46 +0200
Message-Id: <20200901155748.2884-8-hch@lst.de>
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

Instead of calling revalidate_disk just do the work directly by
calling sd_revalidate_disk, and revalidate_disk_size where needed.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/scsi/sd.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 95018e650f2d0c..2bec8cd526164d 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -217,7 +217,7 @@ cache_type_store(struct device *dev, struct device_attribute *attr,
 			sd_print_sense_hdr(sdkp, &sshdr);
 		return -EINVAL;
 	}
-	revalidate_disk(sdkp->disk);
+	sd_revalidate_disk(sdkp->disk);
 	return count;
 }
 
@@ -1706,8 +1706,10 @@ static int sd_sync_cache(struct scsi_disk *sdkp, struct scsi_sense_hdr *sshdr)
 static void sd_rescan(struct device *dev)
 {
 	struct scsi_disk *sdkp = dev_get_drvdata(dev);
+	int ret;
 
-	revalidate_disk(sdkp->disk);
+	ret = sd_revalidate_disk(sdkp->disk);
+	revalidate_disk_size(sdkp->disk, ret == 0);
 }
 
 static int sd_ioctl(struct block_device *bdev, fmode_t mode,
-- 
2.28.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
