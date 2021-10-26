Return-Path: <SRS0=tl6X=PO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8CF6C433EF
	for <virtualization@archiver.kernel.org>; Tue, 26 Oct 2021 07:20:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 603CD60ED4
	for <virtualization@archiver.kernel.org>; Tue, 26 Oct 2021 07:20:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 603CD60ED4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 338E5608E2;
	Tue, 26 Oct 2021 07:20:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XOB5Sx31xnn6; Tue, 26 Oct 2021 07:20:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E46F560625;
	Tue, 26 Oct 2021 07:20:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BF2A8C0019;
	Tue, 26 Oct 2021 07:20:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DE1B7C000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 07:20:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BFEEF404CB
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 07:20:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id matuaBANW27q
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 07:20:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2B0F1404CA
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 07:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635232819;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uja7m66OQ8RhYU+vAO++rPLkxu0xATaaUuXmeqidL70=;
 b=g9ihz80vSlZgfwOrjXBMx+AasREmKW/po4M3FEANUEx7Dbvxw9G8Tui68QYMJiQ+xlfHFu
 LMO9NgTmtsfd+c1BohniSdfcKzw4L0i66jEUOMeEd+Zc4leYIlsDEPTx4RVQd8BCMYAg/S
 HKZdpKBA2rwnEYEWC6aM+NmunL5suGw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-124-1K8_92oDPu2t3BuISeN73A-1; Tue, 26 Oct 2021 03:20:15 -0400
X-MC-Unique: 1K8_92oDPu2t3BuISeN73A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8BB4610A8E01;
 Tue, 26 Oct 2021 07:20:14 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-80.pek2.redhat.com [10.72.12.80])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B3EE919C79;
 Tue, 26 Oct 2021 07:20:11 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	virtualization@lists.linux-foundation.org
Subject: [PATCH V4 2/4] virtio-net: don't let virtio core to validate used
 length
Date: Tue, 26 Oct 2021 15:19:58 +0800
Message-Id: <20211026072000.8699-3-jasowang@redhat.com>
In-Reply-To: <20211026072000.8699-1-jasowang@redhat.com>
References: <20211026072000.8699-1-jasowang@redhat.com>
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

For RX virtuqueue, the used length is validated in all the three paths
(big, small and mergeable). For control vq, we never tries to use used
length. So this patch forbids the core to validate the used length.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/virtio_net.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 6d8c8745bf24..7c43bfc1ce44 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3385,6 +3385,7 @@ static struct virtio_driver virtio_net_driver = {
 	.feature_table_size = ARRAY_SIZE(features),
 	.feature_table_legacy = features_legacy,
 	.feature_table_size_legacy = ARRAY_SIZE(features_legacy),
+	.suppress_used_validation = true,
 	.driver.name =	KBUILD_MODNAME,
 	.driver.owner =	THIS_MODULE,
 	.id_table =	id_table,
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
