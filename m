Return-Path: <SRS0=ivLu=BN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96704C433E1
	for <virtualization@archiver.kernel.org>; Mon,  3 Aug 2020 21:00:26 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A7FA22C9F
	for <virtualization@archiver.kernel.org>; Mon,  3 Aug 2020 21:00:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I2Cy6OZF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A7FA22C9F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 2DC602094E;
	Mon,  3 Aug 2020 21:00:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SH2JcnOjHSrx; Mon,  3 Aug 2020 21:00:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id B3962204C7;
	Mon,  3 Aug 2020 21:00:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9C639C0050;
	Mon,  3 Aug 2020 21:00:22 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B73D9C004C
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Aug 2020 21:00:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id B277E85B0D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Aug 2020 21:00:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FmxJ3HXFSlET
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Aug 2020 21:00:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com
 [205.139.110.61])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 31F04844C9
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Aug 2020 21:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596488420;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=f1A99Kan+ToYvUmOMuODkd0BFkRSjBNq3WkT2nA5570=;
 b=I2Cy6OZFp44adUcSURPKsc2f308oqyHjBVbCF86tsq9zgdzWGr2757+z7888M6qjHFWpXd
 F4SNu6cg0fdfb0DjLU+qbBUWLK69LtYVJlt4ScUYhLO22EX9Sf5FWHpB/irckFQuaOsZKT
 AjB6qe0WS4AcODfnwhzh+cxf7z9gbdA=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-434-dJKTG4fQO1q8GmzmQ32X8A-1; Mon, 03 Aug 2020 17:00:16 -0400
X-MC-Unique: dJKTG4fQO1q8GmzmQ32X8A-1
Received: by mail-qk1-f199.google.com with SMTP id d6so27004001qkg.6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 03 Aug 2020 14:00:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=f1A99Kan+ToYvUmOMuODkd0BFkRSjBNq3WkT2nA5570=;
 b=lA+7145mzimNr01W6LOaZFRpGZZgcVJo2jpzqnCehi+Zx7z/dj5f33gonRATMBWNDW
 6Gs5GeFBaiiYVp18vkkcS0Os0RB2wyi+zsvUZws+bYYYPRPuHKwaIQmQtnKbuMlmaoPQ
 DVs2/D5yQFyUGenjmoF/Puk1r1f+Xg4v2y2bJ8qFZQFhvRcB7OPcLlCZsT3sZm6lhGJq
 wCS9iLqoZ+USVO3S906XhET8Jom6auDftIFLmcF469iDX0DfpfFKnQ0vHyiaOIgNixxZ
 7vqMcYqpKaOSDlBcPrStFEaTmrtIZUvdcReTqlB9IEmHCAgkZtUYWLR1ob1m2cPL2Kl6
 rJfw==
X-Gm-Message-State: AOAM532aL+TkK4YVRA/jHR7b5AytbFU+WDRp/XIQoMeKKIuAEH7snECf
 myRz4RQpkr2uypjewr5vVIexVXObLYR278dyew2VES419q8Ro9OAHHZTIi4zbgcfnEPkvSEtPUn
 FzVDzEsETy+HWb/cgv45vXCi8w945uyaj5uGl4x5/Kw==
X-Received: by 2002:ae9:f409:: with SMTP id y9mr17081840qkl.383.1596488415774; 
 Mon, 03 Aug 2020 14:00:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyOLsF2kRKHhVMrVuK1ExTkYEV3u00bvHZC77i72ooYLjKbjM4TmW/w7ndizuS2cvXbLFA8ag==
X-Received: by 2002:ae9:f409:: with SMTP id y9mr17081819qkl.383.1596488415580; 
 Mon, 03 Aug 2020 14:00:15 -0700 (PDT)
Received: from redhat.com (bzq-79-177-102-128.red.bezeqint.net.
 [79.177.102.128])
 by smtp.gmail.com with ESMTPSA id x137sm20654324qkb.47.2020.08.03.14.00.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2020 14:00:15 -0700 (PDT)
Date: Mon, 3 Aug 2020 17:00:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2 20/24] vhost/vdpa: switch to new helpers
Message-ID: <20200803205814.540410-21-mst@redhat.com>
References: <20200803205814.540410-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200803205814.540410-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: netdev@vger.kernel.org, kvm@vger.kernel.org,
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

For new helpers handling legacy features to be effective,
vhost needs to invoke them. Tie them in.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/vhost/vdpa.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index 18869a35d408..3674404688f5 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -118,9 +118,8 @@ static irqreturn_t vhost_vdpa_config_cb(void *private)
 static void vhost_vdpa_reset(struct vhost_vdpa *v)
 {
 	struct vdpa_device *vdpa = v->vdpa;
-	const struct vdpa_config_ops *ops = vdpa->config;
 
-	ops->set_status(vdpa, 0);
+	vdpa_reset(vdpa);
 }
 
 static long vhost_vdpa_get_device_id(struct vhost_vdpa *v, u8 __user *argp)
@@ -196,7 +195,6 @@ static long vhost_vdpa_get_config(struct vhost_vdpa *v,
 				  struct vhost_vdpa_config __user *c)
 {
 	struct vdpa_device *vdpa = v->vdpa;
-	const struct vdpa_config_ops *ops = vdpa->config;
 	struct vhost_vdpa_config config;
 	unsigned long size = offsetof(struct vhost_vdpa_config, buf);
 	u8 *buf;
@@ -209,7 +207,7 @@ static long vhost_vdpa_get_config(struct vhost_vdpa *v,
 	if (!buf)
 		return -ENOMEM;
 
-	ops->get_config(vdpa, config.off, buf, config.len);
+	vdpa_get_config(vdpa, config.off, buf, config.len);
 
 	if (copy_to_user(c->buf, buf, config.len)) {
 		kvfree(buf);
@@ -282,7 +280,7 @@ static long vhost_vdpa_set_features(struct vhost_vdpa *v, u64 __user *featurep)
 	if (features & ~vhost_vdpa_features[v->virtio_id])
 		return -EINVAL;
 
-	if (ops->set_features(vdpa, features))
+	if (vdpa_set_features(vdpa, features))
 		return -EINVAL;
 
 	return 0;
-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
