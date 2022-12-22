Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6248C4167B
	for <virtualization@archiver.kernel.org>; Thu, 22 Dec 2022 05:01:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 39473403C2;
	Thu, 22 Dec 2022 05:01:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 39473403C2
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JYZf7vy9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3FtPDzD71kQ7; Thu, 22 Dec 2022 05:01:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B343240385;
	Thu, 22 Dec 2022 05:01:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B343240385
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9AABFC0071;
	Thu, 22 Dec 2022 05:01:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8F863C0071
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Dec 2022 05:01:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 69CEA8202A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Dec 2022 05:01:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 69CEA8202A
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=JYZf7vy9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2WBOz6BeisEe
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Dec 2022 05:01:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AEAAF8201A
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AEAAF8201A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Dec 2022 05:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1671685273;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rgUs5kldoyEdjYJksPr3TrwRDSigjzyb5OPBQ9Ca66Q=;
 b=JYZf7vy9egZZ5sqKB06C2UTYiiLtLaDq6o+au0yYWTyJM/+NShvW3p4r8RffKZlqizIUA0
 LEaVi/zjEavQo7s2A4vCKdiZ6g5DFl4wUYz3ERkn/z4qsG3KufaG8ELCV03DJ3sBsPc1tV
 bTnL9YHAxKi/5mAJzAbVzJSOFPVsJYQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-619-fsVfP8CGMsWlCeS8wOnn7A-1; Thu, 22 Dec 2022 00:01:10 -0500
X-MC-Unique: fsVfP8CGMsWlCeS8wOnn7A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 05A3D8588E4;
 Thu, 22 Dec 2022 05:01:10 +0000 (UTC)
Received: from localhost.localdomain (ovpn-13-15.pek2.redhat.com [10.72.13.15])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5219D40C2064;
 Thu, 22 Dec 2022 05:01:06 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH V2 3/4] vdpa_sim: support vendor statistics
Date: Thu, 22 Dec 2022 13:00:51 +0800
Message-Id: <20221222050052.20785-4-jasowang@redhat.com>
In-Reply-To: <20221222050052.20785-1-jasowang@redhat.com>
References: <20221222050052.20785-1-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Cc: eperezma@redhat.com, virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org
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

This patch adds a new config ops callback to allow individual
simulator to implement the vendor stats callback.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim.c | 14 ++++++++++++++
 drivers/vdpa/vdpa_sim/vdpa_sim.h |  3 +++
 2 files changed, 17 insertions(+)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index 55aaa023a6e2..ed3147f1877a 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -426,6 +426,18 @@ static int vdpasim_get_vq_state(struct vdpa_device *vdpa, u16 idx,
 	return 0;
 }
 
+static int vdpasim_get_vq_stats(struct vdpa_device *vdpa, u16 idx,
+				struct sk_buff *msg,
+				struct netlink_ext_ack *extack)
+{
+	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
+
+	if (vdpasim->dev_attr.get_stats)
+		return vdpasim->dev_attr.get_stats(vdpasim, idx,
+						   msg, extack);
+	return -EOPNOTSUPP;
+}
+
 static u32 vdpasim_get_vq_align(struct vdpa_device *vdpa)
 {
 	return VDPASIM_QUEUE_ALIGN;
@@ -710,6 +722,7 @@ static const struct vdpa_config_ops vdpasim_config_ops = {
 	.set_vq_ready           = vdpasim_set_vq_ready,
 	.get_vq_ready           = vdpasim_get_vq_ready,
 	.set_vq_state           = vdpasim_set_vq_state,
+	.get_vendor_vq_stats    = vdpasim_get_vq_stats,
 	.get_vq_state           = vdpasim_get_vq_state,
 	.get_vq_align           = vdpasim_get_vq_align,
 	.get_vq_group           = vdpasim_get_vq_group,
@@ -743,6 +756,7 @@ static const struct vdpa_config_ops vdpasim_batch_config_ops = {
 	.set_vq_ready           = vdpasim_set_vq_ready,
 	.get_vq_ready           = vdpasim_get_vq_ready,
 	.set_vq_state           = vdpasim_set_vq_state,
+	.get_vendor_vq_stats    = vdpasim_get_vq_stats,
 	.get_vq_state           = vdpasim_get_vq_state,
 	.get_vq_align           = vdpasim_get_vq_align,
 	.get_vq_group           = vdpasim_get_vq_group,
diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.h b/drivers/vdpa/vdpa_sim/vdpa_sim.h
index 51c070a543f1..d2a08c0abad7 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.h
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.h
@@ -48,6 +48,9 @@ struct vdpasim_dev_attr {
 	work_func_t work_fn;
 	void (*get_config)(struct vdpasim *vdpasim, void *config);
 	void (*set_config)(struct vdpasim *vdpasim, const void *config);
+	int (*get_stats)(struct vdpasim *vdpasim, u16 idx,
+			 struct sk_buff *msg,
+			 struct netlink_ext_ack *extack);
 };
 
 /* State of each vdpasim device */
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
