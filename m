Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F7C9C19F2A
	for <virtualization@archiver.kernel.org>; Thu, 11 Aug 2022 12:52:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1604E610D2;
	Thu, 11 Aug 2022 12:52:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1604E610D2
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HFnYWFvr
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id w9P8Rsm8CG0w; Thu, 11 Aug 2022 12:52:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 89A13610C5;
	Thu, 11 Aug 2022 12:52:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 89A13610C5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 576DBC0033;
	Thu, 11 Aug 2022 12:52:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B1FF0C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Aug 2022 12:52:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7BF594014D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Aug 2022 12:52:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7BF594014D
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=HFnYWFvr
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tXtYAvTgxvIe
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Aug 2022 12:52:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 18C0E403E0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 18C0E403E0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Aug 2022 12:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660222324;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=fZR1rg29jmUTn0ZaHr80FrLXJcO6qark0sdTnOhFYqg=;
 b=HFnYWFvrW0S1b8SA++vbvHv6cX+cebH6rqoqjHPwZiDE/YuHxJJbIF8Fu7MorqbBNGkDbN
 iAritYp9Om/J/Hx9a2hQabwEaHYzlUICaY1Tr2VAjiMCZnz4LO7+Jq858ENNFHMUD7e1Lm
 yuVFSYvwS5p5n4lzX9ZFoIAWM2DT4Ls=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-79-PU_CTHSfNzavdl_GtK6cWg-1; Thu, 11 Aug 2022 08:52:03 -0400
X-MC-Unique: PU_CTHSfNzavdl_GtK6cWg-1
Received: by mail-ed1-f70.google.com with SMTP id
 y16-20020a056402359000b0043db5186943so10830416edc.3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Aug 2022 05:52:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc;
 bh=fZR1rg29jmUTn0ZaHr80FrLXJcO6qark0sdTnOhFYqg=;
 b=NaN8FNrz6GjW0azY2LVQIr1J+hivS1v7p0o8iXHPNwHwbCKDVaXkEtP8ruwN6vf487
 b+u3UvpJ0hgVercr5g1VsPjST79pQdcOVcWqtwYCMQPfskoMsTFSKaxSLDno8IlG4TXt
 d5YgTGqqPAjN0sajcdyLPhB2VZizEHNMBS9tsldfOSTv8fZM2+Otdo65bzzF76qcst3q
 ibgC0EVpDSbEqvTdaBugZ0L/bWwjBxMqXPCZ86uvFbdfXK79RlvXsiklh2U+oJeeZHC6
 HYmjGolcwjwH6M3jM2W38+HtJICPdS5giS/KfgTnFNK0OOwBskIZTrIfr+1+OhwRbzlt
 TKvA==
X-Gm-Message-State: ACgBeo2svkD9G19kPpNKEZDpWOcgMf4j7mX6xMRktHOLwzHfGOx0zi/c
 NV2d6JHb6E5qxnSh8iFYUgPXRZgkuM5lvRAs7fWoHPh5Umr4iKreBvs1qsTnRz6oFRUs+PORnEZ
 a7JXUYl+wrs+jJ4aVTWKrurUaScHzIz5xziaLADiWgg==
X-Received: by 2002:a05:6402:424e:b0:43d:9d9f:38f9 with SMTP id
 g14-20020a056402424e00b0043d9d9f38f9mr30995447edb.411.1660222322560; 
 Thu, 11 Aug 2022 05:52:02 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4Uonm4Tt4dUrVuSW7DOj4CixZE71gE99A8Xg5JVQuHVDIdMz6RS86ZeW5EQJ50fie/SzlXCQ==
X-Received: by 2002:a05:6402:424e:b0:43d:9d9f:38f9 with SMTP id
 g14-20020a056402424e00b0043d9d9f38f9mr30995425edb.411.1660222322396; 
 Thu, 11 Aug 2022 05:52:02 -0700 (PDT)
Received: from redhat.com ([2.52.152.113]) by smtp.gmail.com with ESMTPSA id
 w21-20020a170906131500b0072ab06bf296sm3424029ejb.23.2022.08.11.05.51.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Aug 2022 05:52:01 -0700 (PDT)
Date: Thu, 11 Aug 2022 08:51:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] virtio_net: fix endian-ness for RSS
Message-ID: <20220811125156.293825-1-mst@redhat.com>
MIME-Version: 1.0
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Andrew Melnychenko <andrew@daynix.com>, netdev@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>
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

Using native endian-ness for device supplied fields is wrong
on BE platforms. Sparse warns about this.

Fixes: 91f41f01d219 ("drivers/net/virtio_net: Added RSS hash report.")
Cc: "Andrew Melnychenko" <andrew@daynix.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/net/virtio_net.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index d9c434b00e9b..6e9868c860bc 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1208,7 +1208,7 @@ static void virtio_skb_set_hash(const struct virtio_net_hdr_v1_hash *hdr_hash,
 	if (!hdr_hash || !skb)
 		return;
 
-	switch ((int)hdr_hash->hash_report) {
+	switch (__le16_to_cpu(hdr_hash->hash_report)) {
 	case VIRTIO_NET_HASH_REPORT_TCPv4:
 	case VIRTIO_NET_HASH_REPORT_UDPv4:
 	case VIRTIO_NET_HASH_REPORT_TCPv6:
@@ -1226,7 +1226,7 @@ static void virtio_skb_set_hash(const struct virtio_net_hdr_v1_hash *hdr_hash,
 	default:
 		rss_hash_type = PKT_HASH_TYPE_NONE;
 	}
-	skb_set_hash(skb, (unsigned int)hdr_hash->hash_value, rss_hash_type);
+	skb_set_hash(skb, __le32_to_cpu(hdr_hash->hash_value), rss_hash_type);
 }
 
 static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
