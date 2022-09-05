Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 896CDECAAD5
	for <virtualization@archiver.kernel.org>; Mon,  5 Sep 2022 04:53:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E0EAC401ED;
	Mon,  5 Sep 2022 04:53:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E0EAC401ED
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ch8PGtMP
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gWydomEAKvLT; Mon,  5 Sep 2022 04:53:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3A968401C7;
	Mon,  5 Sep 2022 04:53:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3A968401C7
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E6961C0032;
	Mon,  5 Sep 2022 04:53:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EEA07C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Sep 2022 04:53:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C01FF60E3F
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Sep 2022 04:53:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C01FF60E3F
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ch8PGtMP
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4a3AVwNKeJnh
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Sep 2022 04:53:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1041960A88
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1041960A88
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Sep 2022 04:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1662353630;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=m9dcPGbMHXaYmZUV3H1zsLHmGsdVHZV/OdAWS9Cd78s=;
 b=Ch8PGtMPd1C29HeMEUuhEBVAVs82gjmVAwEH/ZW4fu8e4xiA1u2FaxkAbtXFkmfgZWQSV3
 hCh0Kc+f0PpfyE1LNlFSiFAfWhB9c4SDMuqyakKivIGBcacvLLhD6HznBmxUI6n6GzMzb+
 hznOR9v/356dFPjGhJk39hqloie0rQ8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-144-dwOq394-M3KwOdNU4AR59g-1; Mon, 05 Sep 2022 00:53:48 -0400
X-MC-Unique: dwOq394-M3KwOdNU4AR59g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7F93A185A79C;
 Mon,  5 Sep 2022 04:53:48 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-129.pek2.redhat.com
 [10.72.12.129])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 51F421410F37;
 Mon,  5 Sep 2022 04:53:44 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com, jasowang@redhat.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Subject: [PATCH net] virtio-net: add cond_resched() to the command waiting loop
Date: Mon,  5 Sep 2022 12:53:41 +0800
Message-Id: <20220905045341.66191-1-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
Cc: netdev@vger.kernel.org, gautam.dawar@xilinx.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

Adding cond_resched() to the command waiting loop for a better
co-operation with the scheduler. This allows to give CPU a breath to
run other task(workqueue) instead of busy looping when preemption is
not allowed.

What's more important. This is a must for some vDPA parent to work
since control virtqueue is emulated via a workqueue for those parents.

Fixes: bda324fd037a ("vdpasim: control virtqueue support")
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/virtio_net.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index ece00b84e3a7..169368365d6a 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2000,8 +2000,10 @@ static bool virtnet_send_command(struct virtnet_info *vi, u8 class, u8 cmd,
 	 * into the hypervisor, so the request should be handled immediately.
 	 */
 	while (!virtqueue_get_buf(vi->cvq, &tmp) &&
-	       !virtqueue_is_broken(vi->cvq))
+	       !virtqueue_is_broken(vi->cvq)) {
+		cond_resched();
 		cpu_relax();
+	}
 
 	return vi->ctrl->status == VIRTIO_NET_OK;
 }
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
