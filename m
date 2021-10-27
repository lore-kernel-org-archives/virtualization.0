Return-Path: <SRS0=5D8L=PP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94391C433F5
	for <virtualization@archiver.kernel.org>; Wed, 27 Oct 2021 02:21:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FA4E60F90
	for <virtualization@archiver.kernel.org>; Wed, 27 Oct 2021 02:21:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4FA4E60F90
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 23A2D81765;
	Wed, 27 Oct 2021 02:21:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0GuGvIQjJ8gK; Wed, 27 Oct 2021 02:21:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9F9338174C;
	Wed, 27 Oct 2021 02:21:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7AC41C0012;
	Wed, 27 Oct 2021 02:21:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D4E37C000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 02:21:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C527681765
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 02:21:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oyrT-1Bxtwwo
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 02:21:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3870880EC8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 02:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635301298;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oAUHS9ZYbyH+gY1nGB/VU6/S0d+NWeLrZAB0xQ5OIdc=;
 b=C8QzA+qFFz6kqRRBQAQdjpNc5hspr8jMkt2OM3xyBnHa1o1fpBhg5lWiLTu2j4Ttj3Pa88
 623Dc/b97QEhPXF/v1wEHhytfsqpfMD8jq/zW2gLfsN/SvXf+IkUyKhQj91sn3RwgTLMZi
 bDfclxUcL9BfjPPrHvo5hSBwU3IXSxk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-278-VCKtKa4gMmKs6LtSic_IfQ-1; Tue, 26 Oct 2021 22:21:34 -0400
X-MC-Unique: VCKtKa4gMmKs6LtSic_IfQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 789FD112A0A0;
 Wed, 27 Oct 2021 02:21:33 +0000 (UTC)
Received: from localhost.localdomain (ovpn-13-228.pek2.redhat.com
 [10.72.13.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D392219729;
 Wed, 27 Oct 2021 02:21:30 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	virtualization@lists.linux-foundation.org
Subject: [PATCH V5 3/4] virtio-blk: don't let virtio core to validate used
 length
Date: Wed, 27 Oct 2021 10:21:06 +0800
Message-Id: <20211027022107.14357-4-jasowang@redhat.com>
In-Reply-To: <20211027022107.14357-1-jasowang@redhat.com>
References: <20211027022107.14357-1-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Cc: f.hetzelt@tu-berlin.de, linux-kernel@vger.kernel.org, david.kaplan@amd.com,
 konrad.wilk@oracle.com
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

We never tries to use used length, so the patch prevents the virtio
core from validating used length.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/block/virtio_blk.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index c7d05ff24084..36d645ec5002 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -1041,6 +1041,7 @@ static struct virtio_driver virtio_blk = {
 	.feature_table_size		= ARRAY_SIZE(features),
 	.feature_table_legacy		= features_legacy,
 	.feature_table_size_legacy	= ARRAY_SIZE(features_legacy),
+	.suppress_used_validation	= true,
 	.driver.name			= KBUILD_MODNAME,
 	.driver.owner			= THIS_MODULE,
 	.id_table			= id_table,
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
