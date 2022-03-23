Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18771C433EF
	for <virtualization@archiver.kernel.org>; Wed, 23 Mar 2022 08:50:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C0B26612EE;
	Wed, 23 Mar 2022 08:50:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2tflMKGWYzYB; Wed, 23 Mar 2022 08:50:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5F894612EA;
	Wed, 23 Mar 2022 08:50:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3794DC0012;
	Wed, 23 Mar 2022 08:50:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CFFFFC000B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 08:50:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C013141A5C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 08:50:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fgGnsc_WSU6y
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 08:50:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 269A441A5B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 08:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1648025415;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OgA1lCzF0b4XjouCMdWAekLZD2KK/T/B0hpIucmcAvY=;
 b=HwTES7adOedhXGHnwOpUNCkxNhVrQternbbqEowbKcfzElrVgMouCyzStGLv6Glv5YFDIg
 m/wqF+/Xyjzj1lkUNtQBRhriSr9zGLx/YIhmMQ/EV9YJtXN8BaBHKRHt89LNhfHaLG9bPz
 DygDet87vwZcdi4gKvE+VSOSEBlgDHo=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-493-EAomk7KGM9eM9iNdVe7aOw-1; Wed, 23 Mar 2022 04:50:12 -0400
X-MC-Unique: EAomk7KGM9eM9iNdVe7aOw-1
Received: by mail-qk1-f197.google.com with SMTP id
 207-20020a3703d8000000b0067b14f0844dso538704qkd.22
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 01:50:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=OgA1lCzF0b4XjouCMdWAekLZD2KK/T/B0hpIucmcAvY=;
 b=Ntx0s2OzOPyOCVnK2OVv/KAOsDuRvQ0WlTrEZb9RJW6zgI6WA4PEWlUtjiAoyDx0do
 DWCtC0nnqbwT5yhc37F77LjGnXfMUNokxVqSJHRjCbsnr81xMC2RmdxP55nbDGR1oCIP
 1Ha5qv6HfvaOr9u5ssVLg5uokPAoECNfYqF5tgg+AvX+yIAjUsEQxQq1IEhdA63mjhHK
 033ISoWj9bqVyFGQmsj9I+KW4W9j+gO8utH+cGEzfRTRyzs3CoOf1jrMhNKaSu/cjEo2
 hsFPvtDhsj11bkP016Ts32qXY++bu8CMaon16ojoUJXoQidzeSEeSVtWy1zY1qg+RG7Q
 YUcA==
X-Gm-Message-State: AOAM531jYDLH2PmMG2a1ZmhJ3g0/eMRM4mVgAL5AwLTkG/VE8thmqzJ6
 OuXFVyb3+CJjg0tNnvtoJFdA+Zfn8gWQIjKTxCCZhHxq+8bkWXkPUq4p3I2+HbHilA97A2FjxN/
 SOvC4ZJgnNVpmvoiPImdJnl6+T5c2DZYNsWbyhn22AA==
X-Received: by 2002:a05:620a:370a:b0:67d:5f35:900f with SMTP id
 de10-20020a05620a370a00b0067d5f35900fmr17592013qkb.767.1648025411591; 
 Wed, 23 Mar 2022 01:50:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzzyPK4ZKA2MkSsVUsQecAaz7gloEHvd5w3N1Q/3d1hjdf5Wr4EaGY3ikaTT6b++I1clHGznQ==
X-Received: by 2002:a05:620a:370a:b0:67d:5f35:900f with SMTP id
 de10-20020a05620a370a00b0067d5f35900fmr17591997qkb.767.1648025411363; 
 Wed, 23 Mar 2022 01:50:11 -0700 (PDT)
Received: from step1.redhat.com (host-87-12-25-114.business.telecomitalia.it.
 [87.12.25.114]) by smtp.gmail.com with ESMTPSA id
 j188-20020a3755c5000000b0067d1c76a09fsm10640609qkb.74.2022.03.23.01.50.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Mar 2022 01:50:10 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Subject: [PATCH net v2 3/3] vsock/virtio: read the negotiated features before
 using VQs
Date: Wed, 23 Mar 2022 09:49:54 +0100
Message-Id: <20220323084954.11769-4-sgarzare@redhat.com>
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

Complete the driver configuration, reading the negotiated features,
before using the VQs and tell the device that the driver is ready in
the virtio_vsock_probe().

Fixes: 53efbba12cc7 ("virtio/vsock: enable SEQPACKET for transport")
Suggested-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 net/vmw_vsock/virtio_transport.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index fff67ad39087..1244e7cf585b 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -622,6 +622,9 @@ static int virtio_vsock_probe(struct virtio_device *vdev)
 	INIT_WORK(&vsock->event_work, virtio_transport_event_work);
 	INIT_WORK(&vsock->send_pkt_work, virtio_transport_send_pkt_work);
 
+	if (virtio_has_feature(vdev, VIRTIO_VSOCK_F_SEQPACKET))
+		vsock->seqpacket_allow = true;
+
 	vdev->priv = vsock;
 	virtio_device_ready(vdev);
 
@@ -639,9 +642,6 @@ static int virtio_vsock_probe(struct virtio_device *vdev)
 	vsock->event_run = true;
 	mutex_unlock(&vsock->event_lock);
 
-	if (virtio_has_feature(vdev, VIRTIO_VSOCK_F_SEQPACKET))
-		vsock->seqpacket_allow = true;
-
 	rcu_assign_pointer(the_virtio_vsock, vsock);
 
 	mutex_unlock(&the_virtio_vsock_mutex);
-- 
2.35.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
