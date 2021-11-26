Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9827AC433EF
	for <virtualization@archiver.kernel.org>; Fri, 26 Nov 2021 16:48:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 42C8A82A83;
	Fri, 26 Nov 2021 16:48:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dkd4iimI5Vfx; Fri, 26 Nov 2021 16:48:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E255982A0E;
	Fri, 26 Nov 2021 16:48:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CA5C2C001E;
	Fri, 26 Nov 2021 16:48:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BBB7DC0012
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Nov 2021 16:48:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9E0FE82A2E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Nov 2021 16:48:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id a8qVOY5kcbz2
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Nov 2021 16:48:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0477C829B6
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Nov 2021 16:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1637945289;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7PsJG6PvKljGFJ8TWs32flKxNSDrPXqWSYzJh9yh3yU=;
 b=Iu4rGXDvgLfRbiMoHFicAG3AYeKbZ4sy/Sgz76sRYetYF8kdUv60utocXIEeC+bFw2cM/e
 MoU87nBCzZ/Gh3Su9sDBWq+RrCsyb0Y+lXN/JEWFRNzEXJ74cZRKXlmhRLDZ27YyA3dlUA
 To/jLkeD+GOH+k6J0g6tK0Z4iHToK8w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-377-3C0hKvQnM928kaGkzUdfvQ-1; Fri, 26 Nov 2021 11:48:04 -0500
X-MC-Unique: 3C0hKvQnM928kaGkzUdfvQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 468DA1853022;
 Fri, 26 Nov 2021 16:48:03 +0000 (UTC)
Received: from steredhat.redhat.com (unknown [10.39.193.110])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CB4A667840;
 Fri, 26 Nov 2021 16:48:01 +0000 (UTC)
From: Stefano Garzarella <sgarzare@redhat.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH v2 1/2] docs: document sysfs ABI for vDPA bus
Date: Fri, 26 Nov 2021 17:47:52 +0100
Message-Id: <20211126164753.181829-2-sgarzare@redhat.com>
In-Reply-To: <20211126164753.181829-1-sgarzare@redhat.com>
References: <20211126164753.181829-1-sgarzare@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Cc: linux-kernel@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
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

Add missing documentation of sysfs ABI for vDPA bus in
the new Documentation/ABI/testing/sysfs-bus-vdpa file.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 Documentation/ABI/testing/sysfs-bus-vdpa | 37 ++++++++++++++++++++++++
 MAINTAINERS                              |  1 +
 2 files changed, 38 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-vdpa

diff --git a/Documentation/ABI/testing/sysfs-bus-vdpa b/Documentation/ABI/testing/sysfs-bus-vdpa
new file mode 100644
index 000000000000..4e55761a39df
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-vdpa
@@ -0,0 +1,37 @@
+What:		/sys/bus/vdpa/driver_autoprobe
+Date:		March 2020
+Contact:	virtualization@lists.linux-foundation.org
+Description:
+		This file determines whether new devices are immediately bound
+		to a driver after the creation. It initially contains 1, which
+		means the kernel automatically binds devices to a compatible
+		driver immediately after they are created.
+
+		Writing "0" to this file disable this feature, any other string
+		enable it.
+
+What:		/sys/bus/vdpa/driver_probe
+Date:		March 2020
+Contact:	virtualization@lists.linux-foundation.org
+Description:
+		Writing a device name to this file will cause the kernel binds
+		devices to a compatible driver.
+
+		This can be useful when /sys/bus/vdpa/driver_autoprobe is
+		disabled.
+
+What:		/sys/bus/vdpa/drivers/.../bind
+Date:		March 2020
+Contact:	virtualization@lists.linux-foundation.org
+Description:
+		Writing a device name to this file will cause the driver to
+		attempt to bind to the device. This is useful for overriding
+		default bindings.
+
+What:		/sys/bus/vdpa/drivers/.../unbind
+Date:		March 2020
+Contact:	virtualization@lists.linux-foundation.org
+Description:
+		Writing a device name to this file will cause the driver to
+		attempt to unbind from the device. This may be useful when
+		overriding default bindings.
diff --git a/MAINTAINERS b/MAINTAINERS
index 5250298d2817..36ea80b4ba63 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20104,6 +20104,7 @@ M:	"Michael S. Tsirkin" <mst@redhat.com>
 M:	Jason Wang <jasowang@redhat.com>
 L:	virtualization@lists.linux-foundation.org
 S:	Maintained
+F:	Documentation/ABI/testing/sysfs-bus-vdpa
 F:	Documentation/devicetree/bindings/virtio/
 F:	drivers/block/virtio_blk.c
 F:	drivers/crypto/virtio/
-- 
2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
