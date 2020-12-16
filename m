Return-Path: <SRS0=2z8p=FU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2208BC4361B
	for <virtualization@archiver.kernel.org>; Wed, 16 Dec 2020 06:50:09 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBEBB23370
	for <virtualization@archiver.kernel.org>; Wed, 16 Dec 2020 06:50:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBEBB23370
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 82F2387355;
	Wed, 16 Dec 2020 06:50:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wPWNFws25oBu; Wed, 16 Dec 2020 06:50:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 1EB7D8734B;
	Wed, 16 Dec 2020 06:50:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 15750C0893;
	Wed, 16 Dec 2020 06:50:08 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6BD1EC013B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Dec 2020 06:50:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 5AC3086746
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Dec 2020 06:50:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id puiOQiek0iLU
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Dec 2020 06:50:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id A746A865AB
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Dec 2020 06:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1608101404;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qec1O4Z5wG2P97LtrHHfJdT6ZAPwYeTAYdFi8D5KI2U=;
 b=iblKrY+N0k/7fmVYg7MGMD92VC6m0K9a1M/MMdrGL/9DdlGONl4CZ1VS0lohXAv6QkOyI+
 P8SKMnYzQAfxjATULaxFf7kN7mWJm4NBNbWdUabAViMp4V/IEHIU7Ue5KlxCKMA5DrlaEI
 dQ0hLrFfmkiqXXsLq7PCHQjyg3gwdqM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-502-PMZrlp1qPJiIOCCbzR0k-A-1; Wed, 16 Dec 2020 01:50:02 -0500
X-MC-Unique: PMZrlp1qPJiIOCCbzR0k-A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4BDBA107ACE3;
 Wed, 16 Dec 2020 06:50:01 +0000 (UTC)
Received: from jason-ThinkPad-X1-Carbon-6th.redhat.com
 (ovpn-12-210.pek2.redhat.com [10.72.12.210])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DCE6A10013C1;
 Wed, 16 Dec 2020 06:49:56 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH 13/21] vhost-vdpa: introduce uAPI to get the number of address
 spaces
Date: Wed, 16 Dec 2020 14:48:10 +0800
Message-Id: <20201216064818.48239-14-jasowang@redhat.com>
In-Reply-To: <20201216064818.48239-1-jasowang@redhat.com>
References: <20201216064818.48239-1-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Cc: kvm@vger.kernel.org, lulu@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 eperezma@redhat.com, stefanha@redhat.com, eli@mellanox.com,
 lingshan.zhu@intel.com, rob.miller@broadcom.com
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

This patch introduces the uAPI for getting the number of address
spaces supported by this vDPA device.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/vdpa.c       | 3 +++
 include/uapi/linux/vhost.h | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index 1ba5901b28e7..bff8aa214f78 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -540,6 +540,9 @@ static long vhost_vdpa_unlocked_ioctl(struct file *filep,
 		r = copy_to_user(argp, &v->vdpa->ngroups,
 				 sizeof(v->vdpa->ngroups));
 		break;
+	case VHOST_VDPA_GET_AS_NUM:
+		r = copy_to_user(argp, &v->vdpa->nas, sizeof(v->vdpa->nas));
+		break;
 	case VHOST_SET_LOG_BASE:
 	case VHOST_SET_LOG_FD:
 		r = -ENOIOCTLCMD;
diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
index 8a4e6e426bbf..8762911a3cb8 100644
--- a/include/uapi/linux/vhost.h
+++ b/include/uapi/linux/vhost.h
@@ -148,4 +148,6 @@
 /* Get the number of virtqueue groups. */
 #define VHOST_VDPA_GET_GROUP_NUM	_IOR(VHOST_VIRTIO, 0x79, unsigned int)
 
+/* Get the number of address spaces. */
+#define VHOST_VDPA_GET_AS_NUM		_IOR(VHOST_VIRTIO, 0x7A, unsigned int)
 #endif
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
