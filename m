Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25CF7C433FE
	for <virtualization@archiver.kernel.org>; Wed, 23 Mar 2022 17:36:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CBD47613ED;
	Wed, 23 Mar 2022 17:36:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7lRn6dfsOFkX; Wed, 23 Mar 2022 17:36:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7DE85613F8;
	Wed, 23 Mar 2022 17:36:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6717CC001A;
	Wed, 23 Mar 2022 17:36:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2807FC000B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 17:36:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BAD2A40510
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 17:36:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id edOGqNLgbV5h
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 17:36:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E805E40C49
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 17:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1648057004;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xWGdi1UqdjNcgIoNh0luPYt8s0RItagontqZa8O7xH4=;
 b=erXsHocKMRzMzKb5CAMVfIKAWERmKyn1E3sZbgaPYQXR3BgO27ZLQvezFZkrE2/IoniPWL
 7pErdMcV5WT8tI2Jux3vL9mU+/4ZqrM52yT7IdFu3mj0q8YxmrJcX8EPWIDutQfMC3e9oY
 nqy0egDVyZbKm7iGwVCiZXLsg1+ASJ8=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-298-fEbRgOqFMguFnniGXrJlWg-1; Wed, 23 Mar 2022 13:36:43 -0400
X-MC-Unique: fEbRgOqFMguFnniGXrJlWg-1
Received: by mail-qv1-f69.google.com with SMTP id
 z2-20020a056214060200b00440d1bc7815so1795050qvw.1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 10:36:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xWGdi1UqdjNcgIoNh0luPYt8s0RItagontqZa8O7xH4=;
 b=u4OtpXT0Lz1yFbjz5yUqo2e3Emyvzcsvkzg/EuhSCcmbwARW8Ilj6pXNJy/3rLgN4h
 Nqs/fj2715+JNZAfv07Z1/8nkprIftY1PpCmUoLUjcacFZSmw5EER6HUYxXe7mcqMyFt
 hlGENAg9TRH7X2UTTdNw0FvBrqn2EOpxaUktmkY/MOIkk2H7O19vTFR1h0xzakbcKro6
 z410H9B47B62Pbyov8eDVYlFRC74yKwu+mjHawtl/iMsSr6SizEJkVnI0jfZye6Jd6yN
 NJR1o91/q1bukFHUhF4MUcr8FMlcSOT/yOvy9sYbedA0y0JkwZhnfu9FVdxrExo44sVy
 c+Yg==
X-Gm-Message-State: AOAM532BlCl5GTgLACjipdWzAMFgQ1DFRz1JUmQsSauWiZMUZIK/Cvtv
 US+MI3TSQv6KzOjQb2MJ24/FsSqv/PFuwsvC31BNvhVuFepKP9msfUO6fgFdozrMkl3I+rsldUZ
 U9Yb6GhnaKWKV2Uw/Fr9Klf7RpiX80V0nG6EWqLj34A==
X-Received: by 2002:ac8:5dcf:0:b0:2e1:baf1:502d with SMTP id
 e15-20020ac85dcf000000b002e1baf1502dmr806274qtx.635.1648057003041; 
 Wed, 23 Mar 2022 10:36:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxTpPllZkLf2utvzNGXglhcnTlOLeIMc4F/54ZX4LmPDik4Rh6CKZ6+/p5IKQ52dEZjvQk8DA==
X-Received: by 2002:ac8:5dcf:0:b0:2e1:baf1:502d with SMTP id
 e15-20020ac85dcf000000b002e1baf1502dmr806235qtx.635.1648057002476; 
 Wed, 23 Mar 2022 10:36:42 -0700 (PDT)
Received: from step1.redhat.com (host-87-12-25-114.business.telecomitalia.it.
 [87.12.25.114]) by smtp.gmail.com with ESMTPSA id
 h14-20020a05622a170e00b002e1a65754d8sm476127qtk.91.2022.03.23.10.36.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Mar 2022 10:36:41 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Subject: [PATCH net v3 3/3] vsock/virtio: enable VQs early on probe
Date: Wed, 23 Mar 2022 18:36:25 +0100
Message-Id: <20220323173625.91119-4-sgarzare@redhat.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220323173625.91119-1-sgarzare@redhat.com>
References: <20220323173625.91119-1-sgarzare@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 "David S. Miller" <davem@davemloft.net>, Stefan Hajnoczi <stefanha@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, Asias He <asias@redhat.com>,
 Paolo Abeni <pabeni@redhat.com>, Arseny Krasnov <arseny.krasnov@kaspersky.com>
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
index 3954d3be9083..ba1c8cc0c467 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -627,6 +627,8 @@ static int virtio_vsock_probe(struct virtio_device *vdev)
 
 	vdev->priv = vsock;
 
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
