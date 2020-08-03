Return-Path: <SRS0=ivLu=BN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 388E2C433DF
	for <virtualization@archiver.kernel.org>; Mon,  3 Aug 2020 21:00:12 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A7A022C9F
	for <virtualization@archiver.kernel.org>; Mon,  3 Aug 2020 21:00:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pl4VfI16"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A7A022C9F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id E990B864D7;
	Mon,  3 Aug 2020 21:00:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Nv5RQA9JX7iH; Mon,  3 Aug 2020 21:00:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 4D8978651E;
	Mon,  3 Aug 2020 21:00:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 38ADDC0050;
	Mon,  3 Aug 2020 21:00:11 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4708EC004C
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Aug 2020 21:00:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 371908651E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Aug 2020 21:00:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HXnFfiElC0wH
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Aug 2020 21:00:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 9243086566
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Aug 2020 21:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596488408;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8bq9rXUCTGSN68YwCNXz85TMhgq9vmhl8kPAax2zSMY=;
 b=Pl4VfI16ISJzhEc6tDzwQP33J/CY/u7EwEGFQ4pcLnq3oQL9higv6IontbLeJVyzmLuIju
 8GQfNLMFZCmhSvpoiBxP1Tv5pGllMYnopeIKvrn3RreNo2aeqltXEUbENFZAkfvFOqTrzC
 nmUb7iLbxdJ3PeuWZOwRmjdAitDkD5g=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-183-u2P8SJvFN9KLb992vA1eOQ-1; Mon, 03 Aug 2020 17:00:07 -0400
X-MC-Unique: u2P8SJvFN9KLb992vA1eOQ-1
Received: by mail-qk1-f197.google.com with SMTP id a186so10825415qke.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 03 Aug 2020 14:00:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=8bq9rXUCTGSN68YwCNXz85TMhgq9vmhl8kPAax2zSMY=;
 b=tFN1PtUNtGhUiKM9UnTNhYFEsIyiseWY1CRdCWAkkUhMo2XBkoUiCQN2LUJ3CucD6T
 sD5hOKI8inGPkxNk3KOUQezRTuxiPKSwudjoCojoRbr3/M4H+FA2uRHxoz30St7rcv5F
 TA3/1iRtYwLG0PeUX5ZO05pztlb64S5vO5rpp3fclK0RTWLZo/7nJzntO9Dq4sTkgM3o
 ZTjPBEFGsJUAURGFz6VYSyl8KDt0Xj2QPxFaK7KVBlVwTfrR9hNeDBj4MbGCTKaXp4ej
 D0WLTiVK0AJ0NUof7MJiGsOPCmDgxDPzzXNOqzpCOVVZtsWBsTkWaJOKdHg/ir4odONs
 X6aw==
X-Gm-Message-State: AOAM532UVYjyybvv2x6xkDc+hukjptlTS1v+oRMjff4mJQ5KgUQNoYc5
 V7OfXGdF2vvpY3oucJveElJk4LdTcTxvvtrbu/NxEbIilczTsQEF8p2x5recc8WlmSGEpjAL+VQ
 cIqA37lDdUF9crjEmRHVcz1lAO7Z6DIBn6AFwP6CrVQ==
X-Received: by 2002:a05:620a:1034:: with SMTP id
 a20mr18018693qkk.88.1596488406605; 
 Mon, 03 Aug 2020 14:00:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzZ4xACpDy2QuhLtURPr5OaRyOxNfQsRP3NRt54g2pzfNFf4aofKomQafv01c0VtrayvMamMQ==
X-Received: by 2002:a05:620a:1034:: with SMTP id
 a20mr18018682qkk.88.1596488406387; 
 Mon, 03 Aug 2020 14:00:06 -0700 (PDT)
Received: from redhat.com (bzq-79-177-102-128.red.bezeqint.net.
 [79.177.102.128])
 by smtp.gmail.com with ESMTPSA id m15sm22165480qta.6.2020.08.03.14.00.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2020 14:00:05 -0700 (PDT)
Date: Mon, 3 Aug 2020 17:00:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2 18/24] mlxbf-tmfifo: sparse tags for config access
Message-ID: <20200803205814.540410-19-mst@redhat.com>
References: <20200803205814.540410-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200803205814.540410-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Vadim Pasternak <vadimp@mellanox.com>, platform-driver-x86@vger.kernel.org,
 Darren Hart <dvhart@infradead.org>, virtualization@lists.linux-foundation.org,
 Andy Shevchenko <andy@infradead.org>
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

mlxbf-tmfifo accesses config space using native types -
which works for it since the legacy virtio native types.

This will break if it ever needs to support modern virtio,
so with new tags previously introduced for virtio net config,
sparse now warns for this in drivers.

Since this is a legacy only device, fix it up using
virtio_legacy_is_little_endian for now.

No functional changes.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/platform/mellanox/mlxbf-tmfifo.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/mellanox/mlxbf-tmfifo.c b/drivers/platform/mellanox/mlxbf-tmfifo.c
index 5739a9669b29..bbc4e71a16ff 100644
--- a/drivers/platform/mellanox/mlxbf-tmfifo.c
+++ b/drivers/platform/mellanox/mlxbf-tmfifo.c
@@ -625,7 +625,10 @@ static void mlxbf_tmfifo_rxtx_header(struct mlxbf_tmfifo_vring *vring,
 			vdev_id = VIRTIO_ID_NET;
 			hdr_len = sizeof(struct virtio_net_hdr);
 			config = &fifo->vdev[vdev_id]->config.net;
-			if (ntohs(hdr.len) > config->mtu +
+			/* A legacy-only interface for now. */
+			if (ntohs(hdr.len) >
+			    __virtio16_to_cpu(virtio_legacy_is_little_endian(),
+					      config->mtu) +
 			    MLXBF_TMFIFO_NET_L2_OVERHEAD)
 				return;
 		} else {
@@ -1231,8 +1234,12 @@ static int mlxbf_tmfifo_probe(struct platform_device *pdev)
 
 	/* Create the network vdev. */
 	memset(&net_config, 0, sizeof(net_config));
-	net_config.mtu = ETH_DATA_LEN;
-	net_config.status = VIRTIO_NET_S_LINK_UP;
+
+	/* A legacy-only interface for now. */
+	net_config.mtu = __cpu_to_virtio16(virtio_legacy_is_little_endian(),
+					   ETH_DATA_LEN);
+	net_config.status = __cpu_to_virtio16(virtio_legacy_is_little_endian(),
+					      VIRTIO_NET_S_LINK_UP);
 	mlxbf_tmfifo_get_cfg_mac(net_config.mac);
 	rc = mlxbf_tmfifo_create_vdev(dev, fifo, VIRTIO_ID_NET,
 				      MLXBF_TMFIFO_NET_FEATURES, &net_config,
-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
