Return-Path: <SRS0=R3N6=DT=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7058EC43457
	for <virtualization@archiver.kernel.org>; Mon, 12 Oct 2020 12:54:35 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A23B21BE5
	for <virtualization@archiver.kernel.org>; Mon, 12 Oct 2020 12:54:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IZ/wXXsD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A23B21BE5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id BEB5F86A4E;
	Mon, 12 Oct 2020 12:54:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id StrSovf5tF0T; Mon, 12 Oct 2020 12:54:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 226E586A51;
	Mon, 12 Oct 2020 12:54:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0BCFEC07FF;
	Mon, 12 Oct 2020 12:54:34 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B15ABC0051
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Oct 2020 12:54:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id A0453873D5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Oct 2020 12:54:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id f8HQgPs-PinA
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Oct 2020 12:54:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 17F66873AF
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Oct 2020 12:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602507271;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UXluXxgVdZ1Q2vjxVm/NRlcU8ef+xQKUslYtIQfW6Qc=;
 b=IZ/wXXsDa31bYG6UoNS9CpFL+uhVwziJSkvov9n1PodWcLbTzq2o4HxinMbVRho9ERttdw
 ChQXwCp3VUfIzFRNcMYf/F51akgYLEP/fxUf0AW1yHQHwPL8lub72wJ4ogRPnfz0+0lwKZ
 TfGNAmtWGdEgzwvR+sanAtyCA2xtiL4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-208-xsC7pkQ8Mmm8uZ3wObNXAA-1; Mon, 12 Oct 2020 08:54:29 -0400
X-MC-Unique: xsC7pkQ8Mmm8uZ3wObNXAA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CB0291084D63;
 Mon, 12 Oct 2020 12:54:27 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-251.ams2.redhat.com [10.36.113.251])
 by smtp.corp.redhat.com (Postfix) with ESMTP id ED4DC60C07;
 Mon, 12 Oct 2020 12:54:16 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v1 05/29] virtio-mem: generalize check for added memory
Date: Mon, 12 Oct 2020 14:52:59 +0200
Message-Id: <20201012125323.17509-6-david@redhat.com>
In-Reply-To: <20201012125323.17509-1-david@redhat.com>
References: <20201012125323.17509-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>
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

Let's check by traversing busy system RAM resources instead, to avoid
relying on memory block states.

Don't use walk_system_ram_range(), as that works on pages and we want to
use the bare addresses we have easily at hand.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/virtio_mem.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index b3eebac7191f..6bbd1cfd10d3 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -1749,6 +1749,20 @@ static void virtio_mem_delete_resource(struct virtio_mem *vm)
 	vm->parent_resource = NULL;
 }
 
+static int virtio_mem_range_has_system_ram(struct resource *res, void *arg)
+{
+	return 1;
+}
+
+static bool virtio_mem_has_memory_added(struct virtio_mem *vm)
+{
+	const unsigned long flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
+
+	return walk_iomem_res_desc(IORES_DESC_NONE, flags, vm->addr,
+				   vm->addr + vm->region_size, NULL,
+				   virtio_mem_range_has_system_ram) == 1;
+}
+
 static int virtio_mem_probe(struct virtio_device *vdev)
 {
 	struct virtio_mem *vm;
@@ -1870,10 +1884,7 @@ static void virtio_mem_remove(struct virtio_device *vdev)
 	 * the system. And there is no way to stop the driver/device from going
 	 * away. Warn at least.
 	 */
-	if (vm->nb_mb_state[VIRTIO_MEM_MB_STATE_OFFLINE] ||
-	    vm->nb_mb_state[VIRTIO_MEM_MB_STATE_OFFLINE_PARTIAL] ||
-	    vm->nb_mb_state[VIRTIO_MEM_MB_STATE_ONLINE] ||
-	    vm->nb_mb_state[VIRTIO_MEM_MB_STATE_ONLINE_PARTIAL]) {
+	if (virtio_mem_has_memory_added(vm)) {
 		dev_warn(&vdev->dev, "device still has system memory added\n");
 	} else {
 		virtio_mem_delete_resource(vm);
-- 
2.26.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
