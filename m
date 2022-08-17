Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BF04C25B08
	for <virtualization@archiver.kernel.org>; Wed, 17 Aug 2022 22:20:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CD3A860597;
	Wed, 17 Aug 2022 22:20:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CD3A860597
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WrM0IY3T
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xBPWmk8hNDXE; Wed, 17 Aug 2022 22:20:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0E9B960B9B;
	Wed, 17 Aug 2022 22:20:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0E9B960B9B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DF3D3C0032;
	Wed, 17 Aug 2022 22:20:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ED8B8C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Aug 2022 22:20:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B070541A4F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Aug 2022 22:20:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B070541A4F
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=WrM0IY3T
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1ZNq9zO12xwf
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Aug 2022 22:20:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3E3B5418F1
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3E3B5418F1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Aug 2022 22:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660774802;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=tgD0w40ykfLq0hhWVAK/Qtzoj+JD36KjwjjFiVONT2U=;
 b=WrM0IY3TeZouhSuV3ksqGVo5tsNMcFds8jxUWYFEFjhVo5C2ERjU3AiBDbr65I4tRLu0yt
 9WaaH8LZFO8SB5no0Tx9Oe0UOJRYs+qEZqitLeoUME5+ktteO4cA0bp/rnnkxWK/ArkK1v
 7d+NemUZp+9/vhbgIHVyv5b77uE6TPg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-659-nPetUFiwNy-eSdFWlUC4Lg-1; Wed, 17 Aug 2022 18:19:59 -0400
X-MC-Unique: nPetUFiwNy-eSdFWlUC4Lg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5F23C101A588;
 Wed, 17 Aug 2022 22:19:59 +0000 (UTC)
Received: from localhost (unknown [10.39.192.60])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C1D16492C3B;
 Wed, 17 Aug 2022 22:19:58 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH] Documentation: add basic information on vDPA
Date: Wed, 17 Aug 2022 18:19:56 -0400
Message-Id: <20220817221956.1149183-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
Cc: linux-kernel@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
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

The vDPA driver framework is largely undocumented. Add a basic page that
describes what vDPA is, where to get more information, and how to use
the simulator for testing.

In the future it would be nice to add an overview of the driver API as
well as comprehensive doc comments.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 Documentation/driver-api/index.rst |  1 +
 Documentation/driver-api/vdpa.rst  | 40 ++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+)
 create mode 100644 Documentation/driver-api/vdpa.rst

diff --git a/Documentation/driver-api/index.rst b/Documentation/driver-api/index.rst
index d3a58f77328e..e307779568d4 100644
--- a/Documentation/driver-api/index.rst
+++ b/Documentation/driver-api/index.rst
@@ -103,6 +103,7 @@ available subsections can be seen below.
    switchtec
    sync_file
    tty/index
+   vdpa
    vfio-mediated-device
    vfio
    vfio-pci-device-specific-driver-acceptance
diff --git a/Documentation/driver-api/vdpa.rst b/Documentation/driver-api/vdpa.rst
new file mode 100644
index 000000000000..75c666548e1d
--- /dev/null
+++ b/Documentation/driver-api/vdpa.rst
@@ -0,0 +1,40 @@
+====================================
+vDPA - VIRTIO Data Path Acceleration
+====================================
+
+The vDPA driver framework can be used to implement VIRTIO devices that are
+backed by physical hardware or by software. While the device's data path
+complies with the VIRTIO specification, the control path is driver-specific and
+a netlink interface exists for instantiating devices.
+
+vDPA devices can be attached to the kernel's VIRTIO device drivers or exposed
+to userspace emulators/virtualizers such as QEMU through vhost.
+
+The driver API is not documented beyond the doc comments in <linux/vdpa.h>. The
+netlink API is not documented beyond the doc comments in <linux/uapi/vdpa.h>.
+The existing vDPA drivers serve as reference code for those wishing to develop
+their own drivers.
+
+See https://vdpa-dev.gitlab.io/ for more information about vDPA.
+
+Questions can be sent to the virtualization@lists.linux-foundation.org mailing
+list.
+
+Device simulators
+-----------------
+
+There are software vDPA device simulators for testing, prototyping, and
+development purposes. The simulators do not require physical hardware.
+
+Available simulators include:
+
+- `vdpa_sim_net` implements a virtio-net loopback device.
+- `vdpa_sim_blk` implements a memory-backed virtio-blk device.
+
+To use `vdpa_sim_blk` through vhost::
+
+  # modprobe vhost_vdpa
+  # modprobe vdpa_sim_blk
+  # vdpa dev add name vdpa-blk1 mgmtdev vdpasim_blk
+  ...use /dev/vhost-dev-0...
+  # vdpa dev del vdpa-blk1
-- 
2.37.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
