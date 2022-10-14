Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90E2EC4332F
	for <virtualization@archiver.kernel.org>; Fri, 14 Oct 2022 04:20:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1C72883FC3;
	Fri, 14 Oct 2022 04:20:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1C72883FC3
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Jjpof4RW
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1-l9cVxgBjwF; Fri, 14 Oct 2022 04:20:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 46E2083FB9;
	Fri, 14 Oct 2022 04:20:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 46E2083FB9
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F3CCDC0033;
	Fri, 14 Oct 2022 04:20:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 16C23C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Oct 2022 04:20:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DFFF660D4C
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Oct 2022 04:20:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DFFF660D4C
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Jjpof4RW
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ArMPKDYoVnfF
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Oct 2022 04:20:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7CABA60A8B
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7CABA60A8B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Oct 2022 04:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1665721251;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=HnSURpZm+VRo/jWoSn4Tgay2ffXUBOQESxlPLKKSxGM=;
 b=Jjpof4RWJnc99MSD1DmewmgoItO9Oyauwvfrbh5OVOWS5OTkbCHnlRu4OsBAwYqHD1SrSX
 Hgb+GULQ4K64c5FQlBk0aHDTqyk3bV9Bj1027uqwu5/maUJW6Stny461yZTdH78PeqeE3d
 k1MEmmaV5VAj5ESjj+zgmQ19oeLwjWA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-574-h_Ui7k8wPmmjl_qv7bpchw-1; Fri, 14 Oct 2022 00:20:46 -0400
X-MC-Unique: h_Ui7k8wPmmjl_qv7bpchw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 30B34185A794;
 Fri, 14 Oct 2022 04:20:46 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-249.pek2.redhat.com
 [10.72.12.249])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7ED081121320;
 Fri, 14 Oct 2022 04:20:39 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	corbet@lwn.net
Subject: [RFC PATCH] virtio: document virtio hardening status and TODO
Date: Fri, 14 Oct 2022 12:20:37 +0800
Message-Id: <20221014042037.23639-1-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Cc: otubo@redhat.com, liuwe@microsoft.com, linux-doc@vger.kernel.org,
 cohuck@redhat.com, linux-kernel@vger.kernel.org, mikelley@microsoft.com,
 andavis@redhat.com, stefanha@redhat.com, kkashanjat@microsoft.com,
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

This patch summarizes the status of hardening and TODO of hardening
virtio core and drivers.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 Documentation/security/virtio/core.rst | 49 ++++++++++++++++++++++++++
 MAINTAINERS                            |  1 +
 2 files changed, 50 insertions(+)
 create mode 100644 Documentation/security/virtio/core.rst

diff --git a/Documentation/security/virtio/core.rst b/Documentation/security/virtio/core.rst
new file mode 100644
index 000000000000..b8baa104d7c8
--- /dev/null
+++ b/Documentation/security/virtio/core.rst
@@ -0,0 +1,49 @@
+================
+Virtio hardening
+================
+
+The virtio core and drivers should not trust the devices. This means
+all kinds of input from the device must be validated before being
+used. This document summarizes the current status and TODO for this
+validation/hardening efforts.
+
+
+Status
+======
+
+The virtio core and drivers has done some basic hardening:
+
+* Config callback hardening: The core makes sure the config interrupt
+  callbacks are enabled after the driver is ready and disable before
+  the driver is removed.
+
+* Descriptor ring hardening: The metadata of a descriptor were copied
+  and stored in a driver private memory that can not be accessed by the
+  device. The eliminates the device triggerable behaviours through the
+  descriptor ring.
+
+* Device configuration space validation: Some of the virtio drivers
+  validates the fields of device configuration space before try to use
+  them.
+
+
+TODO
+====
+
+* Input buffer length validation: The virtio core needs to validate
+  the input buffer length validation before passing them to individual
+  virtio drivers.
+
+* Virtqueue callback hardening: The virtio core (or with the help of
+  the drivers) should guarantee that the virtqueue callbacks should not
+  be triggered before the driver is ready or after the driver is
+  removed.
+
+* Transport specific data validation: The virtio transport driver should
+  validate the virtio transport specific data provided by the device
+  before trying to use them in the probing.
+
+* Device specific validation: Driver should validate the device specific
+  metadata before being used by a specific subsystem.
+
+
diff --git a/MAINTAINERS b/MAINTAINERS
index 673b9f9b8d8a..b33cc5c751c1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21516,6 +21516,7 @@ S:	Maintained
 F:	Documentation/ABI/testing/sysfs-bus-vdpa
 F:	Documentation/ABI/testing/sysfs-class-vduse
 F:	Documentation/devicetree/bindings/virtio/
+F:	Documentation/security/virtio/core.rst
 F:	drivers/block/virtio_blk.c
 F:	drivers/crypto/virtio/
 F:	drivers/net/virtio_net.c
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
