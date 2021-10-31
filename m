Return-Path: <SRS0=Mk6X=PT=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11258C001B6
	for <virtualization@archiver.kernel.org>; Sun, 31 Oct 2021 05:00:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C691C60F02
	for <virtualization@archiver.kernel.org>; Sun, 31 Oct 2021 05:00:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C691C60F02
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6F07B80CE9;
	Sun, 31 Oct 2021 05:00:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FAPlNyJenk6t; Sun, 31 Oct 2021 05:00:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E7B2380D0A;
	Sun, 31 Oct 2021 05:00:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 50ED8C0035;
	Sun, 31 Oct 2021 05:00:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 210C0C0020
 for <virtualization@lists.linux-foundation.org>;
 Sun, 31 Oct 2021 05:00:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F3DDC40177
 for <virtualization@lists.linux-foundation.org>;
 Sun, 31 Oct 2021 05:00:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=daynix-com.20210112.gappssmtp.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id J8oZi1maE5FE
 for <virtualization@lists.linux-foundation.org>;
 Sun, 31 Oct 2021 05:00:16 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6F95A40106
 for <virtualization@lists.linux-foundation.org>;
 Sun, 31 Oct 2021 05:00:15 +0000 (UTC)
Received: by mail-lf1-x130.google.com with SMTP id j9so29646703lfu.7
 for <virtualization@lists.linux-foundation.org>;
 Sat, 30 Oct 2021 22:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Ac2A+saDFSrL4WFPXx7obgKV7OBZXWGHHh/Jb1Knu3A=;
 b=XgTo86nFEDxuYlBHZ8Ex/lUcNqT+IBUDagTX/h05JsJRbDmf/VD0AxXwlctC8yY7z8
 chpmci1SemrnUVfl5+TYJ0CSxhwqpS9LlVCL+GvnmyYIwUULAU+7Zad2Dmug2kbr3v4k
 z9aciBwNy7leyYcEexhVMZ5SwmfQRPV4YIR92ggSy5wOR2b/GPr886GWNQpHreb42WLc
 22snkjhagk+eVZ+Q+HnukV/oBhOEHtN1qd50nZWbc+VmTMVcaHMkGc8kpw0kfU/junUL
 0fB0ODvHK1NRvN+f+yOJ2R3iUgChJ+H7tx+wAZ8vHtp0oa7haGhsO5wajRozLRr1u0id
 zDZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Ac2A+saDFSrL4WFPXx7obgKV7OBZXWGHHh/Jb1Knu3A=;
 b=NjKqXEAPYcA1+ZLs44FZMYz/vzsOLhbd1rMHW2Myx9AL5VPt7fCQ51x8VvgRp19pvy
 rC3MrvJcCG+c+DaBwxdAkwMzY1rnmBhoK2dM0yr/omMpa1lQEh3fqpE/92p9kBD2+JVm
 j0Fr4M7GsGlmLwc93E2xdFlI+Gebk80E9TVI0E++HsGOc5QEYxaLkmIpE8Ua8VtwPfuG
 AGkMrY9bafjPAZnydrHN6knIo4LAoexRUAhpRL1Mwzamon365+NvfDjtfTS0n0sjqhig
 Y0baLzSyEqLYLKmfcBpOSKnhE4LHbmy4lFKViJZJrVWPA4GiW6baebYOcRfHkliNTEjz
 UrwA==
X-Gm-Message-State: AOAM531boTMJ9uYFy06UgV4h8Ylye0v9n7YcFZNecjMqWqNJlljBXylR
 LNyElWvL1Fi+EsNkt42FgXsJVHy3hdx2c1uL
X-Google-Smtp-Source: ABdhPJz2f0KObqWRUWYzUB5tvEZYrjAQO7kPeBXmXhuNvmt861oIX1XGH/g2l+H77FteOVLvylsvzQ==
X-Received: by 2002:a05:6512:1102:: with SMTP id
 l2mr20307442lfg.181.1635656409250; 
 Sat, 30 Oct 2021 22:00:09 -0700 (PDT)
Received: from navi.cosmonova.net.ua ([95.67.24.131])
 by smtp.gmail.com with ESMTPSA id v26sm444766lfo.125.2021.10.30.22.00.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 Oct 2021 22:00:08 -0700 (PDT)
From: Andrew Melnychenko <andrew@daynix.com>
To: mst@redhat.com, jasowang@redhat.com, davem@davemloft.net, kuba@kernel.org
Subject: [RFC PATCH 2/4] drivers/net/virtio_net: Changed mergeable buffer
 length calculation.
Date: Sun, 31 Oct 2021 06:59:57 +0200
Message-Id: <20211031045959.143001-3-andrew@daynix.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211031045959.143001-1-andrew@daynix.com>
References: <20211031045959.143001-1-andrew@daynix.com>
MIME-Version: 1.0
Cc: yan@daynix.com, netdev@vger.kernel.org, yuri.benditovich@daynix.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

Now minimal virtual header length is may include the entire v1 header
if the hash report were populated.

Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
---
 drivers/net/virtio_net.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index b72b21ac8ebd..abca2e93355d 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -393,7 +393,9 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
 	hdr_p = p;
 
 	hdr_len = vi->hdr_len;
-	if (vi->mergeable_rx_bufs)
+	if (vi->has_rss_hash_report)
+		hdr_padded_len = sizeof(struct virtio_net_hdr_v1_hash);
+	else if (vi->mergeable_rx_bufs)
 		hdr_padded_len = sizeof(*hdr);
 	else
 		hdr_padded_len = sizeof(struct padded_vnet_hdr);
@@ -1252,7 +1254,7 @@ static unsigned int get_mergeable_buf_len(struct receive_queue *rq,
 					  struct ewma_pkt_len *avg_pkt_len,
 					  unsigned int room)
 {
-	const size_t hdr_len = sizeof(struct virtio_net_hdr_mrg_rxbuf);
+	const size_t hdr_len = ((struct virtnet_info *)(rq->vq->vdev->priv))->hdr_len;
 	unsigned int len;
 
 	if (room)
@@ -2817,7 +2819,7 @@ static void virtnet_del_vqs(struct virtnet_info *vi)
  */
 static unsigned int mergeable_min_buf_len(struct virtnet_info *vi, struct virtqueue *vq)
 {
-	const unsigned int hdr_len = sizeof(struct virtio_net_hdr_mrg_rxbuf);
+	const unsigned int hdr_len = vi->hdr_len;
 	unsigned int rq_size = virtqueue_get_vring_size(vq);
 	unsigned int packet_len = vi->big_packets ? IP_MAX_MTU : vi->dev->max_mtu;
 	unsigned int buf_len = hdr_len + ETH_HLEN + VLAN_HLEN + packet_len;
-- 
2.33.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
