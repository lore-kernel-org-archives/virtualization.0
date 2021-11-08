Return-Path: <SRS0=GFjK=P3=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EDA0C433F5
	for <virtualization@archiver.kernel.org>; Mon,  8 Nov 2021 20:27:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35B9A619E5
	for <virtualization@archiver.kernel.org>; Mon,  8 Nov 2021 20:27:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 35B9A619E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=csail.mit.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EB92440300;
	Mon,  8 Nov 2021 20:27:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oJbXPgEzVKvp; Mon,  8 Nov 2021 20:27:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9094D402F8;
	Mon,  8 Nov 2021 20:26:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6ADC7C0019;
	Mon,  8 Nov 2021 20:26:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 786FCC000E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Nov 2021 20:26:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 62C91400C4
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Nov 2021 20:26:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eWjUUa5WYsT0
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Nov 2021 20:26:56 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from outgoing-stata.csail.mit.edu (outgoing-stata.csail.mit.edu
 [128.30.2.210])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4B8A0400A6
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Nov 2021 20:26:56 +0000 (UTC)
Received: from [128.177.79.46] (helo=[10.118.101.22])
 by outgoing-stata.csail.mit.edu with esmtpsa
 (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256) (Exim 4.82)
 (envelope-from <srivatsa@csail.mit.edu>)
 id 1mkBEE-000DLY-2j; Mon, 08 Nov 2021 15:26:54 -0500
Subject: [PATCH 2/2] MAINTAINERS: Mark VMware mailing list entries as private
From: "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
To: jgross@suse.com, x86@kernel.org, pv-drivers@vmware.com
Date: Mon, 08 Nov 2021 12:30:07 -0800
Message-ID: <163640339370.62866.3435211389009241865.stgit@srivatsa-dev>
In-Reply-To: <163640336232.62866.489924062999332446.stgit@srivatsa-dev>
References: <163640336232.62866.489924062999332446.stgit@srivatsa-dev>
User-Agent: StGit/0.21
MIME-Version: 1.0
Cc: amakhalov@vmware.com, Ronak Doshi <doshir@vmware.com>,
 linux-scsi@vger.kernel.org, anishs@vmware.com,
 Vishal Bhakta <vbhakta@vmware.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux-foundation.org, keerthanak@vmware.com,
 linux-rdma@vger.kernel.org, linux-graphics-maintainer@vmware.com,
 linux-input@vger.kernel.org, Nadav Amit <namit@vmware.com>,
 Zack Rusin <zackr@vmware.com>
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

From: Srivatsa S. Bhat (VMware) <srivatsa@csail.mit.edu>

VMware mailing lists in the MAINTAINERS file are private lists meant
for VMware-internal review/notification for patches to the respective
subsystems. So, in an earlier discussion [1][2], it was recommended to
mark them as such. Update all the remaining VMware mailing list
references to use that format -- "L: list@address (private)".

[1]. https://lore.kernel.org/r/YPfp0Ff6KuyPlyrc@kroah.com
[2]. https://lore.kernel.org/r/1626861766-11115-1-git-send-email-jhansen@vmware.com

Signed-off-by: Srivatsa S. Bhat (VMware) <srivatsa@csail.mit.edu>
Cc: Nadav Amit <namit@vmware.com>
Cc: Vivek Thampi <vithampi@vmware.com>
Cc: Vishal Bhakta <vbhakta@vmware.com>
Cc: Ronak Doshi <doshir@vmware.com>
Cc: pv-drivers@vmware.com
Cc: linux-graphics-maintainer@vmware.com
Cc: dri-devel@lists.freedesktop.org
Cc: linux-rdma@vger.kernel.org
Cc: linux-scsi@vger.kernel.org
Cc: netdev@vger.kernel.org
Cc: linux-input@vger.kernel.org
Acked-by: Zack Rusin <zackr@vmware.com>
---

 MAINTAINERS |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 118cf8170d02..3e92176e68fb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6134,8 +6134,8 @@ T:	git git://anongit.freedesktop.org/drm/drm-misc
 F:	drivers/gpu/drm/vboxvideo/
 
 DRM DRIVER FOR VMWARE VIRTUAL GPU
-M:	"VMware Graphics" <linux-graphics-maintainer@vmware.com>
 M:	Zack Rusin <zackr@vmware.com>
+L:	linux-graphics-maintainer@vmware.com (private)
 L:	dri-devel@lists.freedesktop.org
 S:	Supported
 T:	git git://anongit.freedesktop.org/drm/drm-misc
@@ -20032,7 +20032,7 @@ F:	tools/testing/vsock/
 
 VMWARE BALLOON DRIVER
 M:	Nadav Amit <namit@vmware.com>
-M:	"VMware, Inc." <pv-drivers@vmware.com>
+L:	pv-drivers@vmware.com (private)
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
 F:	drivers/misc/vmw_balloon.c
@@ -20050,14 +20050,14 @@ F:	arch/x86/kernel/cpu/vmware.c
 
 VMWARE PVRDMA DRIVER
 M:	Adit Ranadive <aditr@vmware.com>
-M:	VMware PV-Drivers <pv-drivers@vmware.com>
+L:	pv-drivers@vmware.com (private)
 L:	linux-rdma@vger.kernel.org
 S:	Maintained
 F:	drivers/infiniband/hw/vmw_pvrdma/
 
 VMware PVSCSI driver
 M:	Vishal Bhakta <vbhakta@vmware.com>
-M:	VMware PV-Drivers <pv-drivers@vmware.com>
+L:	pv-drivers@vmware.com (private)
 L:	linux-scsi@vger.kernel.org
 S:	Maintained
 F:	drivers/scsi/vmw_pvscsi.c
@@ -20065,7 +20065,7 @@ F:	drivers/scsi/vmw_pvscsi.h
 
 VMWARE VIRTUAL PTP CLOCK DRIVER
 M:	Vivek Thampi <vithampi@vmware.com>
-M:	"VMware, Inc." <pv-drivers@vmware.com>
+L:	pv-drivers@vmware.com (private)
 L:	netdev@vger.kernel.org
 S:	Supported
 F:	drivers/ptp/ptp_vmw.c
@@ -20079,8 +20079,8 @@ S:	Maintained
 F:	drivers/misc/vmw_vmci/
 
 VMWARE VMMOUSE SUBDRIVER
-M:	"VMware Graphics" <linux-graphics-maintainer@vmware.com>
-M:	"VMware, Inc." <pv-drivers@vmware.com>
+L:	linux-graphics-maintainer@vmware.com (private)
+L:	pv-drivers@vmware.com (private)
 L:	linux-input@vger.kernel.org
 S:	Maintained
 F:	drivers/input/mouse/vmmouse.c
@@ -20088,7 +20088,7 @@ F:	drivers/input/mouse/vmmouse.h
 
 VMWARE VMXNET3 ETHERNET DRIVER
 M:	Ronak Doshi <doshir@vmware.com>
-M:	pv-drivers@vmware.com
+L:	pv-drivers@vmware.com (private)
 L:	netdev@vger.kernel.org
 S:	Maintained
 F:	drivers/net/vmxnet3/

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
