Return-Path: <SRS0=0GV8=DF=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A2D1C2D0A8
	for <virtualization@archiver.kernel.org>; Mon, 28 Sep 2020 03:42:03 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDCA020B80
	for <virtualization@archiver.kernel.org>; Mon, 28 Sep 2020 03:42:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DnEINd7v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDCA020B80
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 65367854DB;
	Mon, 28 Sep 2020 03:42:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WbcxrMgQDz5d; Mon, 28 Sep 2020 03:42:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E1795854AF;
	Mon, 28 Sep 2020 03:42:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CF73CC0890;
	Mon, 28 Sep 2020 03:42:01 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 904EAC016F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Sep 2020 03:42:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 8651B86FA1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Sep 2020 03:42:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OZDUAmW2eeFZ
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Sep 2020 03:41:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-vs1-f65.google.com (mail-vs1-f65.google.com
 [209.85.217.65])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 765A887015
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Sep 2020 03:41:58 +0000 (UTC)
Received: by mail-vs1-f65.google.com with SMTP id a16so4985349vsp.12
 for <virtualization@lists.linux-foundation.org>;
 Sun, 27 Sep 2020 20:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=m9EtepEtVt3TGlrTSs3377Oy1G+hujBB1naLBHmKEMY=;
 b=DnEINd7vTZp2MLZJHSmRkhflGn+dhLAi3Stpt5pp2JgymWDTlLtnGvsGM7uelINWA3
 Fj9EydJQSa7/r+BF03qQSU2i5Et/CiWDuLPSQNFk+tHaFXx0078GoJ6BZFIV884YDdqi
 Nmtj6gHk9GibPyJeTJ4veZZXTZ4xYO6oKce1ROLNRIuyijJeLBMZ748rzp6jX8pOuJWQ
 2VkKx+Ug0cMPmOR3p96hWUZpdPL1H2coYSf0mNVP4+/izyBNzt13TFyfZLIZN5Psqmws
 ALncHlvaXJp7k7hDWeArk46isDQ6LJ3TOGxSVgzl1Mq/i0FinK+98pEltVYRHB9dev/D
 RxlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=m9EtepEtVt3TGlrTSs3377Oy1G+hujBB1naLBHmKEMY=;
 b=IRW/xquvf0xgN5o4kimOik3daixctp65/r+wTQIR8vM6Y0kopURCCWVRIXzT9R2Cs2
 8bNNFmefzA0g8kjku6IpggMqK9ZzxzMbWqj3FKxr5Xw7bmqdJ6rjGChTFHfOp0bxc1+n
 BAYFTAW+KL7ibAoHJ7eADxFE2lucFW4zPsi9qXpMAF8jlObYBKun8qufJCs4xv7a+KHp
 65hrChSMMyEM9WO6H0/9v4rOplTA1KUud+MPLqE/GnBqxI5rfDBRfu/QtCozZ4AWAUfG
 IxPQ7b0eM0iErMuA2k7FLQLaLodvZLjRcXFMSKm4d9m4jNYZ8GAwKB47o5IdV5hEJ8bU
 hpfA==
X-Gm-Message-State: AOAM530rVTZkwUlVfDGhP1IKyr77IYVN+lIY66kuRDyUKW9ji5jczQgF
 5UNO8F7ekED5KnzmmEXweeo=
X-Google-Smtp-Source: ABdhPJyH04luJ1UTcCe5FefXF8GSyZT+ghdCCiFnxbXOZwhxxncbiFm+7K9a9+Db4daXaBfejL7Esw==
X-Received: by 2002:a67:ea4e:: with SMTP id r14mr3944866vso.37.1601264517494; 
 Sun, 27 Sep 2020 20:41:57 -0700 (PDT)
Received: from localhost.localdomain ([50.236.19.102])
 by smtp.gmail.com with ESMTPSA id e3sm1363499vsa.8.2020.09.27.20.41.51
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 27 Sep 2020 20:41:56 -0700 (PDT)
From: xiangxia.m.yue@gmail.com
To: jasowang@redhat.com,
	mst@redhat.com
Subject: [PATCH 1/2] virtio-net: don't disable guest csum when disable LRO
Date: Mon, 28 Sep 2020 11:39:14 +0800
Message-Id: <20200928033915.82810-1-xiangxia.m.yue@gmail.com>
X-Mailer: git-send-email 2.15.0
Cc: netdev@vger.kernel.org, Willem de Bruijn <willemb@google.com>,
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

From: Tonghao Zhang <xiangxia.m.yue@gmail.com>

Open vSwitch and Linux bridge will disable LRO of the interface
when this interface added to them. Now when disable the LRO, the
virtio-net csum is disable too. That drops the forwarding performance.

Fixes: e59ff2c49ae1 ("virtio-net: disable guest csum during XDP set")
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Willem de Bruijn <willemb@google.com>
Signed-off-by: Tonghao Zhang <xiangxia.m.yue@gmail.com>
---
 drivers/net/virtio_net.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 7145c83c6c8c..21b71148c532 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -63,6 +63,11 @@ static const unsigned long guest_offloads[] = {
 	VIRTIO_NET_F_GUEST_CSUM
 };
 
+#define GUEST_OFFLOAD_LRO_MASK ((1ULL << VIRTIO_NET_F_GUEST_TSO4) | \
+				(1ULL << VIRTIO_NET_F_GUEST_TSO6) | \
+				(1ULL << VIRTIO_NET_F_GUEST_ECN)  | \
+				(1ULL << VIRTIO_NET_F_GUEST_UFO))
+
 struct virtnet_stat_desc {
 	char desc[ETH_GSTRING_LEN];
 	size_t offset;
@@ -2531,7 +2536,8 @@ static int virtnet_set_features(struct net_device *dev,
 		if (features & NETIF_F_LRO)
 			offloads = vi->guest_offloads_capable;
 		else
-			offloads = 0;
+			offloads = vi->guest_offloads_capable &
+				   ~GUEST_OFFLOAD_LRO_MASK;
 
 		err = virtnet_set_guest_offloads(vi, offloads);
 		if (err)
-- 
2.23.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
