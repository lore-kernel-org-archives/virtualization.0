Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D175DC433EF
	for <virtualization@archiver.kernel.org>; Mon, 22 Nov 2021 09:32:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 696C46063A;
	Mon, 22 Nov 2021 09:32:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zgzFcsRIsqP3; Mon, 22 Nov 2021 09:32:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 603D060663;
	Mon, 22 Nov 2021 09:32:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 42273C001E;
	Mon, 22 Nov 2021 09:32:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 37E55C0012
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Nov 2021 09:32:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 25A08402BC
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Nov 2021 09:32:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4fj7Goh888wG
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Nov 2021 09:32:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 750CA403E3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Nov 2021 09:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1637573528;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=belxqpIEPM8b5ddVw8XKTj7NYwBuhVnMMeNM/xGD1js=;
 b=EmHpjYzrwpEm0HtcjiRdqU6j3iaHxYY6ckHVZwVP40wAxBdsJNO0uuZHKT9irqEt/GW69t
 WQbMmxyjzFRCPIxpsgRzyF1WD5P/i/F46n+dtiA7M2ZF6IaZbG9ybU8TMWKIMg6cogR8um
 YI687xxpOqXyjs+VkqrQo2XaPBfdx2c=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-24-5sEamsJpOkqWBJEhpcjH6A-1; Mon, 22 Nov 2021 04:32:06 -0500
X-MC-Unique: 5sEamsJpOkqWBJEhpcjH6A-1
Received: by mail-ed1-f69.google.com with SMTP id
 v9-20020a50d849000000b003dcb31eabaaso14319167edj.13
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Nov 2021 01:32:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=belxqpIEPM8b5ddVw8XKTj7NYwBuhVnMMeNM/xGD1js=;
 b=TFa2+eUKyvc/rsR+hDimilcDVyDQlefw6/on85Vh8CHUk3dBE0S0GNnX3FvcoXEwBq
 hxbihE/sTpTn/7ixUz2w4hDHcbE2N8sL3wYm2rdYKC78bnMZtvUylM8v9fF+KwnDKeFd
 pjU5uAF1TnSmNn9Wvgs4zYSBp2FuxYMzNyXIqJ+Lyv7Lathc6uaSHNeYC9m62Au48grO
 tTraHMAXSGTpr0ttbVAuT5Q/L75TPCxEbewROqV77SJG3viinlQrP0M5Wu5wDinfYFHS
 xsAvu8sNr7STQSiCb7cWpWe/l9T5qZVpuZH87ZHWmK+pB/UYwEEos7c7Aap+4mfr77RM
 subw==
X-Gm-Message-State: AOAM531MAsyMRgx87YO871NsD0LRjJZc+CTiKvg2HM1WGfDjHYqceJri
 OFF8nMfrTD/SWIvVNHw+rgjPaea73hiIiMdkMQSRfCpTS8F24/Qj8mr2hMbAvsbVSgZ0tTxssTA
 0+YM0JbG2tKlIlC6pBadzoPj+hLy/hTTMOpE+8W9Rfw==
X-Received: by 2002:a17:906:b2d0:: with SMTP id
 cf16mr38631565ejb.52.1637573525285; 
 Mon, 22 Nov 2021 01:32:05 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwaDt8hngfWzHfFUTs49+2toJfr7BA5IoCX89wF8FGrB5kAMe2yz7xlpf9wWvnAeYerGQlgwg==
X-Received: by 2002:a17:906:b2d0:: with SMTP id
 cf16mr38631543ejb.52.1637573525115; 
 Mon, 22 Nov 2021 01:32:05 -0800 (PST)
Received: from redhat.com ([2.55.128.84])
 by smtp.gmail.com with ESMTPSA id jg32sm3539120ejc.43.2021.11.22.01.32.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Nov 2021 01:32:04 -0800 (PST)
Date: Mon, 22 Nov 2021 04:32:01 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] vsock/virtio: suppress used length validation
Message-ID: <20211122093036.285952-1-mst@redhat.com>
MIME-Version: 1.0
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: david.kaplan@amd.com, kvm@vger.kernel.org, konrad.wilk@oracle.com,
 netdev@vger.kernel.org, f.hetzelt@tu-berlin.de,
 virtualization@lists.linux-foundation.org, Halil Pasic <pasic@linux.ibm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
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

It turns out that vhost vsock violates the virtio spec
by supplying the out buffer length in the used length
(should just be the in length).
As a result, attempts to validate the used length fail with:
vmw_vsock_virtio_transport virtio1: tx: used len 44 is larger than in buflen 0

Since vsock driver does not use the length fox tx and
validates the length before use for rx, it is safe to
suppress the validation in virtio core for this driver.

Reported-by: Halil Pasic <pasic@linux.ibm.com>
Fixes: 939779f5152d ("virtio_ring: validate used buffer length")
Cc: "Jason Wang" <jasowang@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 net/vmw_vsock/virtio_transport.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index 4f7c99dfd16c..3f82b2f1e6dd 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -731,6 +731,7 @@ static unsigned int features[] = {
 static struct virtio_driver virtio_vsock_driver = {
 	.feature_table = features,
 	.feature_table_size = ARRAY_SIZE(features),
+	.suppress_used_validation = true,
 	.driver.name = KBUILD_MODNAME,
 	.driver.owner = THIS_MODULE,
 	.id_table = id_table,
-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
