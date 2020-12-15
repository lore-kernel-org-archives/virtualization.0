Return-Path: <SRS0=Oc7+=FT=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58E33C4361B
	for <virtualization@archiver.kernel.org>; Tue, 15 Dec 2020 14:43:23 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 023D622516
	for <virtualization@archiver.kernel.org>; Tue, 15 Dec 2020 14:43:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 023D622516
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 2BD9487685;
	Tue, 15 Dec 2020 14:43:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 24ZvOd+MccT7; Tue, 15 Dec 2020 14:43:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 3520687684;
	Tue, 15 Dec 2020 14:43:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1E5CBC1DA2;
	Tue, 15 Dec 2020 14:43:17 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 20B40C013B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Dec 2020 14:43:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 0B25186700
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Dec 2020 14:43:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iT7tZPA2FsvQ
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Dec 2020 14:43:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 1C2B786B33
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Dec 2020 14:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1608043392;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k4tojkWY82l70KdB/Lsr4k2Y/bngWEncji8Wtqxzzm8=;
 b=CgQJPJlXpRZsC7+8/tQR23TOO9U36CSyqJkU4rByuljBk8/Ru9S8wE/3kxHPxIb7PhZ7K7
 PzInDN5FHd4Z9elKXGwOBvYdzKG2U96MZ/wft1T4Ocp2peeBR099IpWcoxONHscnCtPoZG
 hP1LIcWo5A6t4hdiR4ICUf0r7sPC9JU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-101-WHmata_vMEudmxpj7cBJAg-1; Tue, 15 Dec 2020 09:43:11 -0500
X-MC-Unique: WHmata_vMEudmxpj7cBJAg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ACFAD1842142;
 Tue, 15 Dec 2020 14:43:09 +0000 (UTC)
Received: from steredhat.redhat.com (ovpn-115-49.ams2.redhat.com
 [10.36.115.49])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1CEDB100164C;
 Tue, 15 Dec 2020 14:43:06 +0000 (UTC)
From: Stefano Garzarella <sgarzare@redhat.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH v4 01/18] vdpa: remove unnecessary 'default n' in Kconfig
 entries
Date: Tue, 15 Dec 2020 15:42:39 +0100
Message-Id: <20201215144256.155342-2-sgarzare@redhat.com>
In-Reply-To: <20201215144256.155342-1-sgarzare@redhat.com>
References: <20201215144256.155342-1-sgarzare@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Cc: Laurent Vivier <lvivier@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Randy Dunlap <rdunlap@infradead.org>,
 linux-kernel@vger.kernel.org, Shahaf Shuler <shahafs@nvidia.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eli Cohen <elic@nvidia.com>,
 Oren Duer <oren@nvidia.com>
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

'default n' is not necessary since it is already the default when
nothing is specified.

Suggested-by: Jason Wang <jasowang@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 drivers/vdpa/Kconfig | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/vdpa/Kconfig b/drivers/vdpa/Kconfig
index 6caf539091e5..2c892e890b9e 100644
--- a/drivers/vdpa/Kconfig
+++ b/drivers/vdpa/Kconfig
@@ -14,7 +14,6 @@ config VDPA_SIM
 	select DMA_OPS
 	select VHOST_RING
 	select GENERIC_NET_UTILS
-	default n
 	help
 	  vDPA networking device simulator which loop TX traffic back
 	  to RX. This device is used for testing, prototyping and
@@ -23,7 +22,6 @@ config VDPA_SIM
 config IFCVF
 	tristate "Intel IFC VF vDPA driver"
 	depends on PCI_MSI
-	default n
 	help
 	  This kernel module can drive Intel IFC VF NIC to offload
 	  virtio dataplane traffic to hardware.
@@ -42,7 +40,6 @@ config MLX5_VDPA_NET
 	tristate "vDPA driver for ConnectX devices"
 	select MLX5_VDPA
 	depends on MLX5_CORE
-	default n
 	help
 	  VDPA network driver for ConnectX6 and newer. Provides offloading
 	  of virtio net datapath such that descriptors put on the ring will
-- 
2.26.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
