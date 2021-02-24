Return-Path: <SRS0=cI1G=H2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF4BC433E6
	for <virtualization@archiver.kernel.org>; Wed, 24 Feb 2021 06:19:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 140EA64DF5
	for <virtualization@archiver.kernel.org>; Wed, 24 Feb 2021 06:19:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 140EA64DF5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 919AE43088;
	Wed, 24 Feb 2021 06:19:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6ghOqJtmjDhV; Wed, 24 Feb 2021 06:19:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3D1084307B;
	Wed, 24 Feb 2021 06:19:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A986AC0013;
	Wed, 24 Feb 2021 06:19:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A190BC0001
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 06:19:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5312981CAF
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 06:19:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2w54sKM2zVAr
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 06:19:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from hqnvemgate25.nvidia.com (hqnvemgate25.nvidia.com
 [216.228.121.64])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A76B083C2E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 06:19:01 +0000 (UTC)
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B6035efd50001>; Tue, 23 Feb 2021 22:19:01 -0800
Received: from sw-mtx-036.mtx.labs.mlnx (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Wed, 24 Feb 2021 06:19:00 +0000
From: Parav Pandit <parav@nvidia.com>
To: <virtualization@lists.linux-foundation.org>
Subject: [PATCH linux-next 1/9] vdpa_sim: Consider read only supported
 features instead of current
Date: Wed, 24 Feb 2021 08:18:36 +0200
Message-ID: <20210224061844.137776-2-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210224061844.137776-1-parav@nvidia.com>
References: <20210224061844.137776-1-parav@nvidia.com>
MIME-Version: 1.0
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1614147541; bh=KOYr7eMvp0GDENfmqdH1RyEDD6fRTZ84iyRQRRt6lIc=;
 h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
 References:MIME-Version:Content-Transfer-Encoding:Content-Type:
 X-Originating-IP:X-ClientProxiedBy;
 b=qKGPz75025XC4tlVvqqMFBEL8/FH+EI0AvOL8EJSaRE4yD7WBH/CgZGd8ENEGQg6G
 v6SJeltjXrmNj7Mk3OinF1ECtNOTBqmxFi2XSrpuczAmy7r+MFdjcD5o+dIrRz98tQ
 rKH/pnLbf5JlcocZ2KQ7PKCpuBAa9Dk0G7kNishl1rv8B9oF3o/zlbqKy36gqWrUtP
 RfkPm/fHk4E8vAYE/R8PSAA6IRsnFQwUvCgqCxM70e1TRb9Rh0lJq6nQOIOQCl5gaV
 79jFG4UfQ2a1xgG4Q98m4lQSehWtZG7nLTUmCYjaSO+sxXxX5JVoPE4UJimkLs8Xkk
 yt5AWUD7W9tRg==
Cc: Eli Cohen <elic@nvidia.com>, mst@redhat.com
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

To honor VIRTIO_F_VERSION_1 feature bit, during endianness detection,
consider the read only supported features bit instead of current
features bit which can be modified by the driver.

This enables vdpa_sim_net driver to invoke cpu_to_vdpasim16() early
enough just after vdpasim device creation in subsequent patch.

Signed-off-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Eli Cohen <elic@nvidia.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.h b/drivers/vdpa/vdpa_sim/vdpa_sim.h
index 6d75444f9948..176d641a0939 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.h
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.h
@@ -11,6 +11,7 @@
 #include <linux/virtio_byteorder.h>
 #include <linux/vhost_iotlb.h>
 #include <uapi/linux/virtio_config.h>
+#include <linux/bits.h>
 
 #define VDPASIM_FEATURES	((1ULL << VIRTIO_F_ANY_LAYOUT) | \
 				 (1ULL << VIRTIO_F_VERSION_1)  | \
@@ -71,7 +72,8 @@ struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *attr);
 static inline bool vdpasim_is_little_endian(struct vdpasim *vdpasim)
 {
 	return virtio_legacy_is_little_endian() ||
-		(vdpasim->features & (1ULL << VIRTIO_F_VERSION_1));
+		(vdpasim->dev_attr.supported_features &
+		 BIT_ULL(VIRTIO_F_VERSION_1));
 }
 
 static inline u16 vdpasim16_to_cpu(struct vdpasim *vdpasim, __virtio16 val)
-- 
2.26.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
