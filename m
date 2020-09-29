Return-Path: <SRS0=hez8=DG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE0F9C2D0A8
	for <virtualization@archiver.kernel.org>; Tue, 29 Sep 2020 02:00:35 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C28F2076D
	for <virtualization@archiver.kernel.org>; Tue, 29 Sep 2020 02:00:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="falqCPFR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C28F2076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1417786676;
	Tue, 29 Sep 2020 02:00:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7MLDxsza6F4Y; Tue, 29 Sep 2020 02:00:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 0284384B82;
	Tue, 29 Sep 2020 02:00:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B202AC0891;
	Tue, 29 Sep 2020 02:00:31 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 36155C016F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Sep 2020 02:00:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 1F0E986174
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Sep 2020 02:00:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fLRSSZSMI9eE
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Sep 2020 02:00:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com
 [209.85.215.193])
 by whitealder.osuosl.org (Postfix) with ESMTPS id D32A684B82
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Sep 2020 02:00:28 +0000 (UTC)
Received: by mail-pg1-f193.google.com with SMTP id 34so2524428pgo.13
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Sep 2020 19:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=KZ5xri8CQiZYZj5fH/BoFFdOUERtgpkqpdPrf8thG10=;
 b=falqCPFRNf4yuXs1tPP0AWaCUb9J9ze+NW/b219ZjILt2GTS3g3X0Jv0vSqGL1URZz
 Avazh/aSyNL0TEww1UyaGRV2bKrxl/tCnWZZ+CoZgXU+UwX0juTHPqgyUfSlkaGZrHTc
 AenTdX/6qPw6U2hJN0+5/9qH8wExSDe2Ln47DS1SVeHhgmDjvgatN2/rizaGrkiJR3MS
 QedeszadGVIroIVVa4osksE8agcll8/mGdbrW/wWNC5MSL9Xjd0H/53lL0oX5GMlLSg7
 aErt073q2Oz8YTIVQFz4hFIwXYqxf9IRICfn3ehyIuTq8qhom0uyl7bh8vpwZMjpUR/E
 J3Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=KZ5xri8CQiZYZj5fH/BoFFdOUERtgpkqpdPrf8thG10=;
 b=JGtj//wvBGqBAerdEirDpTu6CfyL6RhO31Wqm/b7nZniOTzDe7rIFU3leGoegPKgKK
 5hvcoB3SCapFIKyQCRxNposFlHKWggDOnU0JXq8uZGH8JnwWRjLCJjl5LxmuSLmIsYFo
 47vxaqE1nkeXGpaU17yR92k184rs8O4pHxKLx8QrEcyE/JSxu0Omp8+qcN0vi5/Wmnca
 5kWE8TBRYHeLrU45v/+rexrBwEHIT7V/jIbVZzTNFxCuF9qZGBGlhNMhrAak+ky52wBo
 JZC1e/Bmg0+shG7nxz+tV4Mi0mBC793NnHHRyY+3yF2l0niK7dmQQdym6DZ5X10H7hCv
 FPvQ==
X-Gm-Message-State: AOAM5325ZS/N2hI6GTekKHiVpGr0qUMW4GHqekpgrwEbBLz3fdjiqXJY
 ACY4YPnJb+mqgtP7y3uPgM8=
X-Google-Smtp-Source: ABdhPJwS7R20w5F0VpaYUmjll5GcEfWdzUhSgZ4eWTqyCvOG1XTY5MXYyKKK6VNYsyF84hW4pidqkg==
X-Received: by 2002:a63:801:: with SMTP id 1mr1497724pgi.48.1601344828521;
 Mon, 28 Sep 2020 19:00:28 -0700 (PDT)
Received: from localhost.localdomain ([50.236.19.102])
 by smtp.gmail.com with ESMTPSA id e21sm2567486pgi.91.2020.09.28.19.00.18
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 28 Sep 2020 19:00:27 -0700 (PDT)
From: xiangxia.m.yue@gmail.com
To: jasowang@redhat.com,
	mst@redhat.com,
	willemb@google.com
Subject: [PATCH net v2] virtio-net: don't disable guest csum when disable LRO
Date: Tue, 29 Sep 2020 09:58:06 +0800
Message-Id: <20200929015806.19171-1-xiangxia.m.yue@gmail.com>
X-Mailer: git-send-email 2.15.0
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org
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

Fixes: a02e8964eaf9 ("virtio-net: ethtool configurable LRO")
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Willem de Bruijn <willemb@google.com>
Signed-off-by: Tonghao Zhang <xiangxia.m.yue@gmail.com>
---
v2:
* change the fix-tag
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
