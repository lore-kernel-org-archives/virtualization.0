Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F278C433EF
	for <virtualization@archiver.kernel.org>; Fri, 10 Jun 2022 09:47:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EC7E0842E3;
	Fri, 10 Jun 2022 09:47:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XiRxqOsPb-NF; Fri, 10 Jun 2022 09:47:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B53A2842D5;
	Fri, 10 Jun 2022 09:47:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 915B6C0039;
	Fri, 10 Jun 2022 09:47:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2C3F3C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Jun 2022 09:47:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1539F419B1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Jun 2022 09:47:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VXGb5qVtSuCz
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Jun 2022 09:47:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1BCB541994
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Jun 2022 09:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1654854462;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Iej305ZrS3cI+u8eOot8avD0go/WsD4iT9qMHnSK6K8=;
 b=dX/MWqZKrD/f+pAA4XrZ45DAUOB469+x9OJkgG140EU8YsUzAjDdYC03InuLwHdSBwmNNW
 A7Ge3U6ySIhNSOb6qepEJWwr/kqXMrEhEc++uHbT4+FWHoFPPHLuDt6+ied0p0tZ9fK9b3
 qx970TCtde4Xr8m0rangs+XSH4Im/YY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-424-CD6ZHAqePD205X0fXSOnrQ-1; Fri, 10 Jun 2022 05:47:41 -0400
X-MC-Unique: CD6ZHAqePD205X0fXSOnrQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C9E8D801E67;
 Fri, 10 Jun 2022 09:47:40 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.193.213])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2B05818EA7;
 Fri, 10 Jun 2022 09:47:38 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v1] drivers/virtio: Clarify CONFIG_VIRTIO_MEM for unsupported
 architectures
Date: Fri, 10 Jun 2022 11:47:37 +0200
Message-Id: <20220610094737.65254-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
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

Let's make it clearer that simply unlocking CONFIG_VIRTIO_MEM on an
architecture is most probably not sufficient to have it working as
expected.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Gavin Shan <gshan@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/Kconfig | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
index b5adf6abd241..f86b6a988b63 100644
--- a/drivers/virtio/Kconfig
+++ b/drivers/virtio/Kconfig
@@ -115,9 +115,11 @@ config VIRTIO_MEM
 	 This driver provides access to virtio-mem paravirtualized memory
 	 devices, allowing to hotplug and hotunplug memory.
 
-	 This driver was only tested under x86-64 and arm64, but should
-	 theoretically work on all architectures that support memory hotplug
-	 and hotremove.
+	 This driver currently only supports x86-64 and arm64. Although it
+	 should compile on other architectures that implement memory
+	 hot(un)plug, architecture-specific and/or common
+	 code changes may be required for virtio-mem, kdump and kexec to work as
+	 expected.
 
 	 If unsure, say M.
 
-- 
2.35.3

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
