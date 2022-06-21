Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98F79C43334
	for <virtualization@archiver.kernel.org>; Tue, 21 Jun 2022 11:42:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2AB7F419C7;
	Tue, 21 Jun 2022 11:42:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2AB7F419C7
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernkonzept.com header.i=@kernkonzept.com header.a=rsa-sha256 header.s=mx1 header.b=kMBGSmVw
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zKE-JNswD5FQ; Tue, 21 Jun 2022 11:42:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 6F65541977;
	Tue, 21 Jun 2022 11:42:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6F65541977
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 45AAFC0032;
	Tue, 21 Jun 2022 11:42:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 55E78C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Jun 2022 11:42:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 22AC661063
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Jun 2022 11:42:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 22AC661063
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernkonzept.com header.i=@kernkonzept.com
 header.a=rsa-sha256 header.s=mx1 header.b=kMBGSmVw
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MSuspNcJMCcO
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Jun 2022 11:42:49 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 735386103C
Received: from mx.kernkonzept.com (serv1.kernkonzept.com
 [IPv6:2a01:4f8:1c1c:b490::2])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 735386103C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Jun 2022 11:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=kernkonzept.com; s=mx1; h=Content-Transfer-Encoding:MIME-Version:References
 :In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=LcqlgrS7zj13sDDduNZ2hZFqVURpCBy3Ki4wyCilt+Q=; b=kMBGSmVw3QnKKa6d3FhfEYQw75
 2TAOzLxlIbjHi+qMYl0ePadqRiBOW4EcqIx5L2SrHR1B8lj/fPJEVvekkzbYSukNRj1j25DrNvF0q
 eC5LFrhAHq5CWgg1WNhPFmFFbPCQRrmrx9HEF5B1qbiFYNKgSt1RhtdxbmV7GNKQT/G16S1WhG57U
 GkxwmduqFmF9D+XpnWQuemMZlZavWU5fitl4ODVsDtF7uyAKMtEc0INWvLcgyGTJunsoHTqwUUykO
 5tdz2Xxm+Yvl9Am12r3J5g223E7lMCjMmnmqPLXTyN2Zcpn2dWyLZmWtJx9q6B/3MVZqUFyE9jmHP
 VyVJT99A==;
Received: from [10.22.3.24] (helo=kernkonzept.com)
 by mx.kernkonzept.com with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2)
 id 1o3blp-005hKr-CO; Tue, 21 Jun 2022 13:10:09 +0200
From: Stephan Gerhold <stephan.gerhold@kernkonzept.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>
Subject: [PATCH 2/2] virtio_mmio: Restore guest page size on resume
Date: Tue, 21 Jun 2022 13:06:21 +0200
Message-Id: <20220621110621.3638025-3-stephan.gerhold@kernkonzept.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220621110621.3638025-1-stephan.gerhold@kernkonzept.com>
References: <20220621110621.3638025-1-stephan.gerhold@kernkonzept.com>
MIME-Version: 1.0
Cc: Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
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

Virtio devices might lose their state when the VMM is restarted
after a suspend to disk (hibernation) cycle. This means that the
guest page size register must be restored for the virtio_mmio legacy
interface, since otherwise the virtio queues are not functional.

This is particularly problematic for QEMU that currently still defaults
to using the legacy interface for virtio_mmio. Write the guest page
size register again in virtio_mmio_restore() to make legacy virtio_mmio
devices work correctly after hibernation.

Signed-off-by: Stephan Gerhold <stephan.gerhold@kernkonzept.com>
---
 drivers/virtio/virtio_mmio.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index 980dffd69586..083ff1eb743d 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -569,6 +569,9 @@ static int virtio_mmio_restore(struct device *dev)
 {
 	struct virtio_mmio_device *vm_dev = dev_get_drvdata(dev);
 
+	if (vm_dev->version == 1)
+		writel(PAGE_SIZE, vm_dev->base + VIRTIO_MMIO_GUEST_PAGE_SIZE);
+
 	return virtio_device_restore(&vm_dev->vdev);
 }
 
-- 
2.30.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
