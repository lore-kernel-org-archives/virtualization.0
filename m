Return-Path: <SRS0=66oW=FA=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A18CC63798
	for <virtualization@archiver.kernel.org>; Thu, 26 Nov 2020 14:50:43 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3CFD20B80
	for <virtualization@archiver.kernel.org>; Thu, 26 Nov 2020 14:50:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cAGHNITL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3CFD20B80
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 015EC2E24B;
	Thu, 26 Nov 2020 14:50:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9-7BhPL2JNuo; Thu, 26 Nov 2020 14:50:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id D560820384;
	Thu, 26 Nov 2020 14:50:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CE6D4C163C;
	Thu, 26 Nov 2020 14:50:38 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5BDBEC0052
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Nov 2020 14:50:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 253288742D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Nov 2020 14:50:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9XoJZiUhpEVY
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Nov 2020 14:50:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id F3930873BF
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Nov 2020 14:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1606402205;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1zvK0/c6AsO96m+71J44AElMimj9qzvzGUDws8vfK3s=;
 b=cAGHNITLvhzc6xo+U5XgYfjHWghn8skmzPRXviAbJkE/V3L8+ePXTiAq/p6po0jH3rl9TO
 fZeMlkFCIXJ+g96I9D3/CJY0mYd54vl/f4nUeubsOdGFedbII0B/AbLMatgn56Ru2Nmlo6
 9gNirHbNuei4dvbUnLhHMOEkAJZxCJA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-518-qupjO9QHPra-XuTaB7WDgA-1; Thu, 26 Nov 2020 09:50:03 -0500
X-MC-Unique: qupjO9QHPra-XuTaB7WDgA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ECDE3108E1A4;
 Thu, 26 Nov 2020 14:50:01 +0000 (UTC)
Received: from steredhat.redhat.com (ovpn-113-252.ams2.redhat.com
 [10.36.113.252])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D66AD19C66;
 Thu, 26 Nov 2020 14:49:59 +0000 (UTC)
From: Stefano Garzarella <sgarzare@redhat.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH v2 01/17] vdpa: remove unnecessary 'default n' in Kconfig
 entries
Date: Thu, 26 Nov 2020 15:49:34 +0100
Message-Id: <20201126144950.92850-2-sgarzare@redhat.com>
In-Reply-To: <20201126144950.92850-1-sgarzare@redhat.com>
References: <20201126144950.92850-1-sgarzare@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Cc: Laurent Vivier <lvivier@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Eli Cohen <elic@nvidia.com>
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
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 drivers/vdpa/Kconfig | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/vdpa/Kconfig b/drivers/vdpa/Kconfig
index 358f6048dd3c..4019ceb88181 100644
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
@@ -41,7 +39,6 @@ config MLX5_VDPA_NET
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
