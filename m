Return-Path: <SRS0=TY3O=PA=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEA86C433F5
	for <virtualization@archiver.kernel.org>; Tue, 12 Oct 2021 06:53:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0E3661040
	for <virtualization@archiver.kernel.org>; Tue, 12 Oct 2021 06:53:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B0E3661040
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 86E1540273;
	Tue, 12 Oct 2021 06:53:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NYMObKuNqBqO; Tue, 12 Oct 2021 06:53:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id F2B1F402DB;
	Tue, 12 Oct 2021 06:53:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CAA11C0020;
	Tue, 12 Oct 2021 06:53:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B65B9C001E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Oct 2021 06:53:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8F44C80F82
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Oct 2021 06:53:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id p8u4xjTO_oSW
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Oct 2021 06:53:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E428880E5F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Oct 2021 06:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634021595;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j/QbFmrEsChXEIMzJ7DSys3s2nwcppdzH8aCGPBxMJA=;
 b=dHVdLmp8Mi9yhIk43/VdKE5gRXEerUWQRplJEl1WwuTXAQWfNTukdg04wnU3ZDHzO1/kB+
 ZItABswRRavg6zQfTWrdIYTOEX/o8hHYdfqczxLxtGNniduZvVLIW7FG0wEmrEbGjrifkk
 jN7Vz/5X2Y7ySAwWLkuFfSEAUykzLFk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-469-8OP0pBBSOC29e6d-W96EvQ-1; Tue, 12 Oct 2021 02:53:11 -0400
X-MC-Unique: 8OP0pBBSOC29e6d-W96EvQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0B17210144FB;
 Tue, 12 Oct 2021 06:52:47 +0000 (UTC)
Received: from localhost.localdomain (ovpn-13-111.pek2.redhat.com
 [10.72.13.111])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 48BC05F4E0;
 Tue, 12 Oct 2021 06:52:43 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH V2 04/12] virtio_console: validate max_nr_ports before trying
 to use it
Date: Tue, 12 Oct 2021 14:52:19 +0800
Message-Id: <20211012065227.9953-5-jasowang@redhat.com>
In-Reply-To: <20211012065227.9953-1-jasowang@redhat.com>
References: <20211012065227.9953-1-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Cc: f.hetzelt@tu-berlin.de, david.kaplan@amd.com, Amit Shah <amit@kernel.org>,
 konrad.wilk@oracle.com, linux-kernel@vger.kernel.org,
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

We calculate nr_ports based on the max_nr_ports:

nr_queues = use_multiport(portdev) ? (nr_ports + 1) * 2 : 2;

If the device advertises a large max_nr_ports, we will end up with a
integer overflow. Fixing this by validating the max_nr_ports
advertised by the device in .validate() and clear the MULTIPORT is
it's greater than 0x8000 (which is guaranteed be safe).

Cc: Amit Shah <amit@kernel.org>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/char/virtio_console.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index daeed31df622..ef13763699c0 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -28,6 +28,7 @@
 #include "../tty/hvc/hvc_console.h"
 
 #define is_rproc_enabled IS_ENABLED(CONFIG_REMOTEPROC)
+#define VIRTCONS_MAX_PORTS 0x8000
 
 /*
  * This is a global struct for storing common data for all the devices
@@ -1981,6 +1982,8 @@ static void virtcons_remove(struct virtio_device *vdev)
 
 static int virtcons_validate(struct virtio_device *vdev)
 {
+	u32 max_nr_ports;
+
 	if (is_rproc_serial(vdev)) {
 		/* Don't test F_SIZE at all if we're rproc: not a
 		 * valid feature! */
@@ -1999,6 +2002,13 @@ static int virtcons_validate(struct virtio_device *vdev)
 		return -EINVAL;
 	}
 
+	if (virtio_cread_feature(vdev, VIRTIO_CONSOLE_F_MULTIPORT,
+				 struct virtio_console_config, max_nr_ports,
+				 &max_nr_ports) == 0) {
+		if (max_nr_ports == 0 || max_nr_ports > VIRTCONS_MAX_PORTS)
+			__virtio_clear_bit(vdev, VIRTIO_CONSOLE_F_MULTIPORT);
+	}
+
 	return 0;
 }
 
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
