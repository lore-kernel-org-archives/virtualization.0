Return-Path: <SRS0=kV/H=HN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8CADC433DB
	for <virtualization@archiver.kernel.org>; Thu, 11 Feb 2021 16:25:33 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3191C64E92
	for <virtualization@archiver.kernel.org>; Thu, 11 Feb 2021 16:25:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3191C64E92
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E807C86F0B;
	Thu, 11 Feb 2021 16:25:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Xrd-xqCz0W_7; Thu, 11 Feb 2021 16:25:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 62C1886EE8;
	Thu, 11 Feb 2021 16:25:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 49013C0891;
	Thu, 11 Feb 2021 16:25:32 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 40A09C013A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Feb 2021 16:25:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 3B1FD87466
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Feb 2021 16:25:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bLf6qewoqTND
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Feb 2021 16:25:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 96CAC8744D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Feb 2021 16:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1613060728;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=XQoevciACwPLARu60eJww58zrFl7HrSfeZVa0fo4e3M=;
 b=JO56rE8ZPnoxUB05mKi5BX+ISqk8PXYo6zGEyF62IinRpEwzi0bpNx/eBvTlTnWYGCHxrN
 nLy/LduycIjvjaHdOJ96DvqKArHVJPMAKZNUsiBV8EHv2w0NxStyrXl41n29yfmRk8eA5p
 16wBLdBrRhMBUk1KVx4Wn5XYe92wPQs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-598-KCaMI8aPOtSm_ZngdVRuxA-1; Thu, 11 Feb 2021 11:25:24 -0500
X-MC-Unique: KCaMI8aPOtSm_ZngdVRuxA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6AB3D1005501;
 Thu, 11 Feb 2021 16:25:22 +0000 (UTC)
Received: from steredhat.redhat.com (ovpn-113-187.ams2.redhat.com
 [10.36.113.187])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C6CEA5C1BD;
 Thu, 11 Feb 2021 16:25:20 +0000 (UTC)
From: Stefano Garzarella <sgarzare@redhat.com>
To: stable@vger.kernel.org
Subject: [PATCH for 5.10] vdpa_sim: fix param validation in
 vdpasim_get_config()
Date: Thu, 11 Feb 2021 17:25:19 +0100
Message-Id: <20210211162519.215418-1-sgarzare@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Cc: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Eli Cohen <elic@nvidia.com>
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

Commit 65b709586e222fa6ffd4166ac7fdb5d5dad113ee upstream.

Before this patch, if 'offset + len' was equal to
sizeof(struct virtio_net_config), the entire buffer wasn't filled,
returning incorrect values to the caller.

Since 'vdpasim->config' type is 'struct virtio_net_config', we can
safely copy its content under this condition.

Commit 65b709586e22 ("vdpa_sim: add get_config callback in
vdpasim_dev_attr") unintentionally solved it upstream while
refactoring vdpa_sim.c to support multiple devices. But we don't want
to backport it to stable branches as it contains many changes.

Fixes: 2c53d0f64c06 ("vdpasim: vDPA device simulator")
Cc: <stable@vger.kernel.org> # 5.10.x
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index 6a90fdb9cbfc..8ca178d7b02f 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -572,7 +572,7 @@ static void vdpasim_get_config(struct vdpa_device *vdpa, unsigned int offset,
 {
 	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
 
-	if (offset + len < sizeof(struct virtio_net_config))
+	if (offset + len <= sizeof(struct virtio_net_config))
 		memcpy(buf, (u8 *)&vdpasim->config + offset, len);
 }
 
-- 
2.29.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
