Return-Path: <SRS0=+sHN=K4=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 843C0C47080
	for <virtualization@archiver.kernel.org>; Wed,  2 Jun 2021 02:11:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BAA4610CB
	for <virtualization@archiver.kernel.org>; Wed,  2 Jun 2021 02:11:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BAA4610CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 157F9607F1;
	Wed,  2 Jun 2021 02:11:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mjXcRDuS7vJZ; Wed,  2 Jun 2021 02:11:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id B090D6079E;
	Wed,  2 Jun 2021 02:11:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 81C3EC000D;
	Wed,  2 Jun 2021 02:11:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A356AC0001
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 02:11:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 854C5607BA
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 02:11:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QkzF7bjHGHhx
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 02:11:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BAF7B6079E
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 02:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622599864;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WrB6mvofF/eyGV52SKIt7JTVB1esFhxct19/WhmLXiU=;
 b=N6ctwrh4HSWz1htG/Bkd5fDb1/kMPtNVFCW1ckdCDUdM1RerBJELq3G+xQtkkYmQdWFGjn
 /cDqi2mJTtMJcyWrzvUT6xiKB8PGGvx9TfS0V14bu/plUrXfBidhKbbVYZxqetK6mxXYcQ
 uRxqGbnn5qvQcpoxpdZHLwMInnkZWS4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-589-QUMcm96xNXuVvu3xnwUhLw-1; Tue, 01 Jun 2021 22:11:03 -0400
X-MC-Unique: QUMcm96xNXuVvu3xnwUhLw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0E7C6180FD6D;
 Wed,  2 Jun 2021 02:11:02 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-99.pek2.redhat.com [10.72.12.99])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 96EAD5D6CF;
 Wed,  2 Jun 2021 02:10:59 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com, jasowang@redhat.com,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH V2 3/4] vp_vdpa: allow set vq state to initial state after
 reset
Date: Wed,  2 Jun 2021 10:10:42 +0800
Message-Id: <20210602021043.39201-4-jasowang@redhat.com>
In-Reply-To: <20210602021043.39201-1-jasowang@redhat.com>
References: <20210602021043.39201-1-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Cc: eli@mellanox.com
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

We used to fail the set_vq_state() since it was not supported yet by
the virtio spec. But if the bus tries to set the state which is equal
to the device initial state after reset, we can let it go.

This is a must for virtio_vdpa() to set vq state during probe which is
required for some vDPA parents.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vdpa/virtio_pci/vp_vdpa.c | 42 ++++++++++++++++++++++++++++---
 1 file changed, 39 insertions(+), 3 deletions(-)

diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pci/vp_vdpa.c
index c76ebb531212..18bf4a422772 100644
--- a/drivers/vdpa/virtio_pci/vp_vdpa.c
+++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
@@ -210,13 +210,49 @@ static int vp_vdpa_get_vq_state(struct vdpa_device *vdpa, u16 qid,
 	return -EOPNOTSUPP;
 }
 
+static int vp_vdpa_set_vq_state_split(struct vdpa_device *vdpa,
+				      const struct vdpa_vq_state *state)
+{
+	const struct vdpa_vq_state_split *split = &state->split;
+
+	if (split->avail_index == 0)
+		return 0;
+
+	return -EOPNOTSUPP;
+}
+
+static int vp_vdpa_set_vq_state_packed(struct vdpa_device *vdpa,
+				       const struct vdpa_vq_state *state)
+{
+	const struct vdpa_vq_state_packed *packed = &state->packed;
+
+	if (packed->last_avail_counter == 1 &&
+	    packed->last_avail_idx == 0 &&
+	    packed->last_used_counter == 1 &&
+	    packed->last_used_idx == 0)
+		return 0;
+
+	return -EOPNOTSUPP;
+}
+
 static int vp_vdpa_set_vq_state(struct vdpa_device *vdpa, u16 qid,
 				const struct vdpa_vq_state *state)
 {
-	/* Note that this is not supported by virtio specification, so
-	 * we return -ENOPOTSUPP here. This means we can't support live
-	 * migration, vhost device start/stop.
+	struct virtio_pci_modern_device *mdev = vdpa_to_mdev(vdpa);
+
+	/* Note that this is not supported by virtio specification.
+	 * But if the state is by chance equal to the device initial
+	 * state, we can let it go.
 	 */
+	if ((vp_modern_get_status(mdev) & VIRTIO_CONFIG_S_FEATURES_OK) &&
+	    !vp_modern_get_queue_enable(mdev, qid)) {
+		if (vp_modern_get_driver_features(mdev) &
+		    BIT_ULL(VIRTIO_F_RING_PACKED))
+			return vp_vdpa_set_vq_state_packed(vdpa, state);
+		else
+			return vp_vdpa_set_vq_state_split(vdpa,	state);
+	}
+
 	return -EOPNOTSUPP;
 }
 
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
