Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77FBEC433FE
	for <virtualization@archiver.kernel.org>; Fri, 26 Nov 2021 02:30:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 14A96403E0;
	Fri, 26 Nov 2021 02:30:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HiuqIRCSXf3Y; Fri, 26 Nov 2021 02:30:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id A6FA1403BB;
	Fri, 26 Nov 2021 02:30:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 835E0C001C;
	Fri, 26 Nov 2021 02:30:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2F3CBC000A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Nov 2021 02:30:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1EC00827A5
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Nov 2021 02:30:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SGOxFjyA1g0t
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Nov 2021 02:30:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 74C9082779
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Nov 2021 02:30:40 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 01FDE6115C;
 Fri, 26 Nov 2021 02:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1637893840;
 bh=XJ13SsNbvf1d8FdpbFQKVrFqK8TxFEvAgwIr4woQDBo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=WywilHjNtDhNCWvpZukiV5SM/1uc2gRhkd1g1HuhamFXhJgoxaMyFhUwV2k1WIr/Z
 O+pQHM7CJVL5xUiAzV9Egn4kktqW62Ct+wLX0QjH19xJCVE/RYTXzmwZsGLkyF6Uny
 y8CbmWQo+0TbfA5yX7mAqxlFrWGD21MnKckQWNr6aJPJTSXPezXaSYZeUjN/R/CEwO
 ANSSqriHUnKi4rm0RB6NVwru3cAPJruAse7OxWfAjcyXpCJ/RzSRA9gBtNzc3vP7Ud
 z7PpUV/nOPjxnifDLGCxANC1reKTaEI5U/xLYDp4/b+fHVuY+9HOgUpmOtU4b69QKz
 LBXAjEfTuSDNQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 3/4] virtio-mem: support
 VIRTIO_MEM_F_UNPLUGGED_INACCESSIBLE
Date: Thu, 25 Nov 2021 21:30:33 -0500
Message-Id: <20211126023034.440961-3-sashal@kernel.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211126023034.440961-1-sashal@kernel.org>
References: <20211126023034.440961-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Cc: Sasha Levin <sashal@kernel.org>,
 Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
 Wei Yang <richard.weiyang@linux.alibaba.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux-foundation.org,
 Sebastien Boeuf <sebastien.boeuf@intel.com>,
 Marek Kedzierski <mkedzier@redhat.com>, Hui Zhu <teawater@gmail.com>
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

From: David Hildenbrand <david@redhat.com>

[ Upstream commit 61082ad6a6e1f999eef7e7e90046486c87933b1e ]

The initial virtio-mem spec states that while unplugged memory should not
be read, the device still has to allow for reading unplugged memory inside
the usable region. The primary motivation for this default handling was
to simplify bringup of virtio-mem, because there were corner cases where
Linux might have accidentially read unplugged memory inside added Linux
memory blocks.

In the meantime, we:
1. Removed /dev/kmem in commit bbcd53c96071 ("drivers/char: remove
   /dev/kmem for good")
2. Disallowed access to virtio-mem device memory via /dev/mem in
   commit 2128f4e21aa2 ("virtio-mem: disallow mapping virtio-mem memory via
   /dev/mem")
3. Sanitized access to virtio-mem device memory via /proc/kcore in
   commit 0daa322b8ff9 ("fs/proc/kcore: don't read offline sections,
   logically offline pages and hwpoisoned pages")
4. Sanitized access to virtio-mem device memory via /proc/vmcore in
   commit ce2814622e84 ("virtio-mem: kdump mode to sanitize /proc/vmcore
   access")

"Accidential" access to unplugged memory is no longer possible; we can
support the new VIRTIO_MEM_F_UNPLUGGED_INACCESSIBLE feature that will be
required by some hypervisors implementing virtio-mem in the near future.

Acked-by: Michael S. Tsirkin <mst@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Marek Kedzierski <mkedzier@redhat.com>
Cc: Hui Zhu <teawater@gmail.com>
Cc: Sebastien Boeuf <sebastien.boeuf@intel.com>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Cc: Wei Yang <richard.weiyang@linux.alibaba.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/virtio/virtio_mem.c     | 1 +
 include/uapi/linux/virtio_mem.h | 9 ++++++---
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index 181e2f18beae5..1afdd8ca00bbb 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -1925,6 +1925,7 @@ static unsigned int virtio_mem_features[] = {
 #if defined(CONFIG_NUMA) && defined(CONFIG_ACPI_NUMA)
 	VIRTIO_MEM_F_ACPI_PXM,
 #endif
+	VIRTIO_MEM_F_UNPLUGGED_INACCESSIBLE,
 };
 
 static const struct virtio_device_id virtio_mem_id_table[] = {
diff --git a/include/uapi/linux/virtio_mem.h b/include/uapi/linux/virtio_mem.h
index 70e01c687d5eb..e9122f1d0e0cb 100644
--- a/include/uapi/linux/virtio_mem.h
+++ b/include/uapi/linux/virtio_mem.h
@@ -68,9 +68,10 @@
  * explicitly triggered (VIRTIO_MEM_REQ_UNPLUG).
  *
  * There are no guarantees what will happen if unplugged memory is
- * read/written. Such memory should, in general, not be touched. E.g.,
- * even writing might succeed, but the values will simply be discarded at
- * random points in time.
+ * read/written. In general, unplugged memory should not be touched, because
+ * the resulting action is undefined. There is one exception: without
+ * VIRTIO_MEM_F_UNPLUGGED_INACCESSIBLE, unplugged memory inside the usable
+ * region can be read, to simplify creation of memory dumps.
  *
  * It can happen that the device cannot process a request, because it is
  * busy. The device driver has to retry later.
@@ -87,6 +88,8 @@
 
 /* node_id is an ACPI PXM and is valid */
 #define VIRTIO_MEM_F_ACPI_PXM		0
+/* unplugged memory must not be accessed */
+#define VIRTIO_MEM_F_UNPLUGGED_INACCESSIBLE	1
 
 
 /* --- virtio-mem: guest -> host requests --- */
-- 
2.33.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
