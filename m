Return-Path: <SRS0=Mk6X=PT=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58CF7C433F5
	for <virtualization@archiver.kernel.org>; Sun, 31 Oct 2021 05:00:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC58960EB4
	for <virtualization@archiver.kernel.org>; Sun, 31 Oct 2021 05:00:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CC58960EB4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 303D34018B;
	Sun, 31 Oct 2021 05:00:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DAavEnkNzRSV; Sun, 31 Oct 2021 05:00:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 91CC740167;
	Sun, 31 Oct 2021 05:00:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 69E18C0019;
	Sun, 31 Oct 2021 05:00:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DC23FC000E
 for <virtualization@lists.linux-foundation.org>;
 Sun, 31 Oct 2021 05:00:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B895060783
 for <virtualization@lists.linux-foundation.org>;
 Sun, 31 Oct 2021 05:00:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=daynix-com.20210112.gappssmtp.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gznUxZgZqLSg
 for <virtualization@lists.linux-foundation.org>;
 Sun, 31 Oct 2021 05:00:12 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C86B160653
 for <virtualization@lists.linux-foundation.org>;
 Sun, 31 Oct 2021 05:00:10 +0000 (UTC)
Received: by mail-lj1-x22d.google.com with SMTP id k22so2197222ljk.5
 for <virtualization@lists.linux-foundation.org>;
 Sat, 30 Oct 2021 22:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=RHYmDW4cj0b+fRWrxsqrvdCtE0TQdE4s+Q6FmaiNSFo=;
 b=jGdm0HMDHcggaMA20etNZfrVF20o5nK2DA3HYz/PNoVCj39osaITLJy3tn+/SNXhMW
 lJjnN10zEDklxTMLl3ShHUYptdNCmcR0WCKA59aDM+H+p19MjjQPpCQjsak3RK6Cuaya
 BEqED0slWnrYBzQa43SUW7PaxpVT5OUoJnKlNj1hXlm1Lc1BJvJr8EF0W4/ssZaTaKRu
 DDlyEHNKxs7x3ks2OdqsSR0hYigzzQM7QXe4keUt4hhm3bcyNBWUALAlqKQD1cGTWaGQ
 LJ2dNTyZmTBsWGA8p63AId0hadl0ddQruU0fRm5SA4/gYwMzmR2lADl5I8+ZtakJ21Yv
 hLDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=RHYmDW4cj0b+fRWrxsqrvdCtE0TQdE4s+Q6FmaiNSFo=;
 b=wAOYRXoRTh8Z3/M80PjSFYjFgZAldVnljoFjtMvXLSzLv40z/fSQ9ZiEy0NpgrqqEv
 qEdk82fYklQ8vSv2Y1ANyUEigPZ3F2HlwfHm4qUCcFWYNhAfe9ILvbW1Csk2sBmfZfao
 e+TIs0HWWYUgNLh7imKriVNnYTOc6DOlBs41VwhqKhkw/x45+uzrNhT3S5YAgrHyBX2P
 Ky4FpSNqiy+amS6cvlYJ5u7+b0hanfeVKLs2gHV20ayuAh8JvZbg+ET508P6Ma2FB/Q6
 O9mZ5SwlFIwMQhL1rnV/xmzhWWaaolntQ8CWKS3pOzb/+K+olTLL6nm7TwGS50FV+EXk
 GwCQ==
X-Gm-Message-State: AOAM531O6nPyTWQT3qpfRdZ61O9pvX2aTvdSR1LeXtml68kWg4WLu3fN
 0KA57cDvtqwxjp9g/e8tOzCdCg==
X-Google-Smtp-Source: ABdhPJy51ImB5QnAwuNncoRDWpRUz75eZpfxmMKHik9fgjLWnlVke1HtCOQ2gW3SrAxudUpknxNK+g==
X-Received: by 2002:a2e:a812:: with SMTP id l18mr22358757ljq.487.1635656408266; 
 Sat, 30 Oct 2021 22:00:08 -0700 (PDT)
Received: from navi.cosmonova.net.ua ([95.67.24.131])
 by smtp.gmail.com with ESMTPSA id v26sm444766lfo.125.2021.10.30.22.00.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 Oct 2021 22:00:07 -0700 (PDT)
From: Andrew Melnychenko <andrew@daynix.com>
To: mst@redhat.com, jasowang@redhat.com, davem@davemloft.net, kuba@kernel.org
Subject: [RFC PATCH 1/4] drivers/net/virtio_net: Fixed vheader to use v1.
Date: Sun, 31 Oct 2021 06:59:56 +0200
Message-Id: <20211031045959.143001-2-andrew@daynix.com>
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

The header v1 provides additional info about RSS.
Added changes to computing proper header length.
In the next patches, the header may contain RSS hash info
for the hash population.

Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
---
 drivers/net/virtio_net.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 4ad25a8b0870..b72b21ac8ebd 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -240,13 +240,13 @@ struct virtnet_info {
 };
 
 struct padded_vnet_hdr {
-	struct virtio_net_hdr_mrg_rxbuf hdr;
+	struct virtio_net_hdr_v1_hash hdr;
 	/*
 	 * hdr is in a separate sg buffer, and data sg buffer shares same page
 	 * with this header sg. This padding makes next sg 16 byte aligned
 	 * after the header.
 	 */
-	char padding[4];
+	char padding[12];
 };
 
 static bool is_xdp_frame(void *ptr)
@@ -1636,7 +1636,7 @@ static int xmit_skb(struct send_queue *sq, struct sk_buff *skb)
 	const unsigned char *dest = ((struct ethhdr *)skb->data)->h_dest;
 	struct virtnet_info *vi = sq->vq->vdev->priv;
 	int num_sg;
-	unsigned hdr_len = vi->hdr_len;
+	unsigned int hdr_len = vi->hdr_len;
 	bool can_push;
 
 	pr_debug("%s: xmit %p %pM\n", vi->dev->name, skb, dest);
-- 
2.33.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
