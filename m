Return-Path: <SRS0=R3N6=DT=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3EDBC43457
	for <virtualization@archiver.kernel.org>; Mon, 12 Oct 2020 19:03:08 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65B6221D81
	for <virtualization@archiver.kernel.org>; Mon, 12 Oct 2020 19:03:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WJXwbpDh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65B6221D81
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 3FB0D22817;
	Mon, 12 Oct 2020 19:03:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JLRABZqHyrXi; Mon, 12 Oct 2020 19:03:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 259EB2155B;
	Mon, 12 Oct 2020 19:03:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EC051C0052;
	Mon, 12 Oct 2020 19:03:02 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6F533C0051
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Oct 2020 19:03:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 6043786A91
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Oct 2020 19:03:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1QasPCW4nXbx
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Oct 2020 19:03:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by whitealder.osuosl.org (Postfix) with ESMTPS id D7B4C867DF
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Oct 2020 19:03:00 +0000 (UTC)
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 68C8921582;
 Mon, 12 Oct 2020 19:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1602529380;
 bh=BYbbrFgph4SjLhGZw4fINy6lmVuypEQSdT6k9nzquQc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=WJXwbpDh/qNsdNwUz5wCM7EnSLBrpIEXEki7sMBgNrJrL36+0sYlnYl9RT8Jv6KkF
 iCm535JwpGIO3GNbGqN2mOGk7rnCXf+4VcapVjoRk1cvd9IkpaQiXB1urugrVRyy96
 aUxD2NQIwyzJDe/yVpMSQulhzQ7nwaEEaRCjqVKM=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.8 16/24] vhost vdpa: fix vhost_vdpa_open error
 handling
Date: Mon, 12 Oct 2020 15:02:31 -0400
Message-Id: <20201012190239.3279198-16-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201012190239.3279198-1-sashal@kernel.org>
References: <20201012190239.3279198-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Cc: Sasha Levin <sashal@kernel.org>, kvm@vger.kernel.org,
 "Michael S . Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Mike Christie <michael.christie@oracle.com>
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

From: Mike Christie <michael.christie@oracle.com>

[ Upstream commit 37787e9f81e2e586b526ff5c29c94e4f41513e80 ]

We must free the vqs array in the open failure path, because
vhost_vdpa_release will not be called.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
Link: https://lore.kernel.org/r/1600712588-9514-2-git-send-email-michael.christie@oracle.com
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/vhost/vdpa.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index a54b60d6623f0..13cdf38f8578a 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -760,6 +760,7 @@ static int vhost_vdpa_open(struct inode *inode, struct file *filep)
 
 err_init_iotlb:
 	vhost_dev_cleanup(&v->vdev);
+	kfree(vqs);
 err:
 	atomic_dec(&v->opened);
 	return r;
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
