Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B4C5ECAAD4
	for <virtualization@archiver.kernel.org>; Mon, 29 Aug 2022 07:34:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0C24C404A1;
	Mon, 29 Aug 2022 07:34:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0C24C404A1
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Gk5lcrC+
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NerbELdE2XGl; Mon, 29 Aug 2022 07:34:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9E568400D3;
	Mon, 29 Aug 2022 07:34:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9E568400D3
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 60C72C0032;
	Mon, 29 Aug 2022 07:34:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EEACBC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Aug 2022 07:34:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B5B2960B77
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Aug 2022 07:34:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B5B2960B77
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Gk5lcrC+
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HXC8q9fr-tbi
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Aug 2022 07:34:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0E23560B10
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0E23560B10
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Aug 2022 07:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1661758488;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=ivp8SkSbzWYeukb9RmMR/+ypBwoHgCA1ggb1pX9wCGY=;
 b=Gk5lcrC+7jmygkyFrwqu1L23/5QSIyOiphSuh3ybUl58iX0PT7pqwVgIjHzL3WS5jLKord
 GpXJIf3m1Jk8KK+nckeWG3viBoY1t9pMiNZjKpHcIxGQjuzqCcJutKAGyZCy+Ql/HoA/D7
 GC786MKzkf/gC3z6n9fh6LQY4AERubs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-433-XdSkkRb2Pn6saeyjF857mA-1; Mon, 29 Aug 2022 03:34:43 -0400
X-MC-Unique: XdSkkRb2Pn6saeyjF857mA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1E77B185A7B2;
 Mon, 29 Aug 2022 07:34:43 +0000 (UTC)
Received: from max-t490s.redhat.com (unknown [10.39.208.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BAA65492C3B;
 Mon, 29 Aug 2022 07:34:40 +0000 (UTC)
From: Maxime Coquelin <maxime.coquelin@redhat.com>
To: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 elic@nvidia.com, guanjun@linux.alibaba.com, parav@nvidia.com,
 gautam.dawar@xilinx.com, dan.carpenter@oracle.com, xieyongji@bytedance.com,
 jasowang@redhat.com, mst@redhat.com
Subject: [PATCH v2] vduse: prevent uninitialized memory accesses
Date: Mon, 29 Aug 2022 09:34:24 +0200
Message-Id: <20220829073424.5677-1-maxime.coquelin@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>, stable@vger.kernel.org
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

If the VDUSE application provides a smaller config space
than the driver expects, the driver may use uninitialized
memory from the stack.

This patch prevents it by initializing the buffer passed by
the driver to store the config value.

This fix addresses CVE-2022-2308.

Cc: xieyongji@bytedance.com
Cc: stable@vger.kernel.org # v5.15+
Fixes: c8a6153b6c59 ("vduse: Introduce VDUSE - vDPA Device in Userspace")

Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 41c0b29739f1..35dceee3ed56 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -673,10 +673,15 @@ static void vduse_vdpa_get_config(struct vdpa_device *vdpa, unsigned int offset,
 {
 	struct vduse_dev *dev = vdpa_to_vduse(vdpa);
 
-	if (offset > dev->config_size ||
-	    len > dev->config_size - offset)
+	/* Initialize the buffer in case of partial copy. */
+	memset(buf, 0, len);
+
+	if (offset > dev->config_size)
 		return;
 
+	if (len > dev->config_size - offset)
+		len = dev->config_size - offset;
+
 	memcpy(buf, dev->config + offset, len);
 }
 
-- 
2.37.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
