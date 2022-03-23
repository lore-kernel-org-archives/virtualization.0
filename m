Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FBCFC433FE
	for <virtualization@archiver.kernel.org>; Wed, 23 Mar 2022 08:50:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4E13A40BEA;
	Wed, 23 Mar 2022 08:50:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id V594WWsOuJXu; Wed, 23 Mar 2022 08:50:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id EDCAA40291;
	Wed, 23 Mar 2022 08:50:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C1EEEC0012;
	Wed, 23 Mar 2022 08:50:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0D687C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 08:50:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E16FF40B58
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 08:50:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id S9otMzvZuVA9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 08:50:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 12033401D2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 08:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1648025405;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VkoZGCDazaob935cf0K6/xqwp1grV8y7vA1EUagsdw8=;
 b=IWwtPvlv1wEkVZ/mC90WH01qL2/dgDQLpVzJaHmBQm4yQIDrKagtrrDq4ljTpEy+7AIuiZ
 GVi4+e0cajotmJTgOTLDA07CDrxa1ztmD1o19qO5D+PcuqG0uGUq8iULwV+5OjW1h9jAKN
 Ekxrg1jpZsASbjysHUO+9lfbi7iGmFY=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-322-eVG1YWz9Og6aEj5r2ikYCw-1; Wed, 23 Mar 2022 04:50:04 -0400
X-MC-Unique: eVG1YWz9Og6aEj5r2ikYCw-1
Received: by mail-qk1-f198.google.com with SMTP id
 bj2-20020a05620a190200b005084968bb24so536932qkb.23
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 01:50:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=VkoZGCDazaob935cf0K6/xqwp1grV8y7vA1EUagsdw8=;
 b=okzL43+Pp31gS+dPeArD/KKUddr0pRRL7xanGJoTvGDYFbIiCzbPH07b46gTKD/P2X
 GLqyGWaw3ZHa+2mFvG8EBa1B0TMBUGUe2Jl6tAr2K9MRJJ/TEBf3/UyWdvkT7x/JtyLr
 rrtnSCB5m7qZ2JvItFOd0UZWqSm+VcVVWAy14N/W4Omo/zWaiI1yfAu7iCqJ7gYtxOnZ
 A4Qmlno/hFAI2F19YvSzR2QAn8YUjVCUkRvh/jGVWzvD1e2tJuw/+kA1dp4DZqVH1i9+
 lW+ZNWRzc45dBAcaN3sEFiGvb2fWewCK9cg7+XzcQDPpVE/kXNRXmRyHGwedXrttaBV2
 KBlA==
X-Gm-Message-State: AOAM531qgte9Nt0xdKZBj5K9CQFSu4KCrVl9tVkr516yEG1KvGw250gG
 UmDYnVm3NUOApXY4qrQIA2FIjneLs2bSNVf6zUysFNlZO9d5Eo0Snnxz+cm2xRIgua7l9zzH4CD
 wXZ92U96/U9Yd61yPlDAX9dcrQUPdd+O5iZekEk39sg==
X-Received: by 2002:a05:620a:1a92:b0:67d:b2c2:8311 with SMTP id
 bl18-20020a05620a1a9200b0067db2c28311mr17908324qkb.594.1648025404182; 
 Wed, 23 Mar 2022 01:50:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJylURIbsHFC5CVM0PxCcg9Ie4RCz+seln0B3QhsU0NKbzEwgOSb1+E5im+z84ivzzgUFUDiHg==
X-Received: by 2002:a05:620a:1a92:b0:67d:b2c2:8311 with SMTP id
 bl18-20020a05620a1a9200b0067db2c28311mr17908319qkb.594.1648025404003; 
 Wed, 23 Mar 2022 01:50:04 -0700 (PDT)
Received: from step1.redhat.com (host-87-12-25-114.business.telecomitalia.it.
 [87.12.25.114]) by smtp.gmail.com with ESMTPSA id
 j188-20020a3755c5000000b0067d1c76a09fsm10640609qkb.74.2022.03.23.01.50.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Mar 2022 01:50:03 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Subject: [PATCH net v2 1/3] vsock/virtio: enable VQs early on probe
Date: Wed, 23 Mar 2022 09:49:52 +0100
Message-Id: <20220323084954.11769-2-sgarzare@redhat.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220323084954.11769-1-sgarzare@redhat.com>
References: <20220323084954.11769-1-sgarzare@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Asias He <asias@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Arseny Krasnov <arseny.krasnov@kaspersky.com>, Paolo Abeni <pabeni@redhat.com>,
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

virtio spec requires drivers to set DRIVER_OK before using VQs.
This is set automatically after probe returns, but virtio-vsock
driver uses VQs in the probe function to fill rx and event VQs
with new buffers.

Let's fix this, calling virtio_device_ready() before using VQs
in the probe function.

Fixes: 0ea9e1d3a9e3 ("VSOCK: Introduce virtio_transport.ko")
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 net/vmw_vsock/virtio_transport.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index 5afc194a58bb..b1962f8cd502 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -622,6 +622,8 @@ static int virtio_vsock_probe(struct virtio_device *vdev)
 	INIT_WORK(&vsock->event_work, virtio_transport_event_work);
 	INIT_WORK(&vsock->send_pkt_work, virtio_transport_send_pkt_work);
 
+	virtio_device_ready(vdev);
+
 	mutex_lock(&vsock->tx_lock);
 	vsock->tx_run = true;
 	mutex_unlock(&vsock->tx_lock);
-- 
2.35.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
