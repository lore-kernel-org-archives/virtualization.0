Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BD8FC433EF
	for <virtualization@archiver.kernel.org>; Tue, 22 Mar 2022 10:38:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4577D41760;
	Tue, 22 Mar 2022 10:38:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rlRBHk6eewfW; Tue, 22 Mar 2022 10:38:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D89E84175E;
	Tue, 22 Mar 2022 10:38:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B86ABC001A;
	Tue, 22 Mar 2022 10:38:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0AC61C000B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Mar 2022 10:38:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E404A401FB
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Mar 2022 10:38:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3EJVS0kE8Ism
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Mar 2022 10:38:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EA7D1400B9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Mar 2022 10:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1647945515;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=VkoZGCDazaob935cf0K6/xqwp1grV8y7vA1EUagsdw8=;
 b=Y3gUDPWkKJh2Ez1YEcW2BIJgk/10rVecFGcwF7bXMwKy2bpyu2jBXBYbSmvh9Nv8g+/CZi
 p9N2DShDRdrh6vA2/7BXrFm83SuoDpGsoKYNqtBH7ezfv0hyqDUhZZxV0gLwMcbrYfzxpN
 tRRFYS2Q06EPBlbfVyZEqU06K5o+dE4=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-54-U3y6No-eMQGBrp4MRfFYmQ-1; Tue, 22 Mar 2022 06:38:34 -0400
X-MC-Unique: U3y6No-eMQGBrp4MRfFYmQ-1
Received: by mail-qk1-f198.google.com with SMTP id
 c19-20020a05620a0cf300b005f17891c015so11459545qkj.18
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Mar 2022 03:38:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=VkoZGCDazaob935cf0K6/xqwp1grV8y7vA1EUagsdw8=;
 b=sMjyqS2pLG7BwhiIbuDVyQAhwOPI7HMaz2Sog/ryUNG+ap5MqqGxLrLTuQD9KakyWn
 rBCZtsmyQOEoPITZmdobwlalV5uM0bvi727x7lyRoRuV1u9ckhHADYm5jI1md3ustuuR
 in+HeMLEj9nCy+nlOsRmzJn/2M1+O1lKEhG/BSskwZHVZFVUB3Fd/7NSTWGEU9Fxxhr/
 2NNuXuI6xEhqcM892MJzhXqIoOfMFHaOnEo8WwV03AAAliigw45CcPvvzRFhIZGyMHX5
 7DFCLB+f3yS+7meqbFyXE0cCm3TeX4ESvogh90Y7ZQzxDrvhA5s/mXNLK0Pi64dbdDmI
 AupQ==
X-Gm-Message-State: AOAM532tvL+RYUbP/M8EfQ1rg6vCw1kby/li2kjXZO2Q683TbrTRFLj8
 fe8542kzfF6ZIq1Ww3QmbrC91mGjHnyCq4QMbkahHneWel2Css72q1qHTBYMWKtLwpeWJwCzlkq
 CC1OQkwHvQBVXPw+iUq9Zwbk44bZ2AGf46yWmQTylBg==
X-Received: by 2002:a05:6214:29ca:b0:441:1f8c:e58d with SMTP id
 gh10-20020a05621429ca00b004411f8ce58dmr7306564qvb.111.1647945514092; 
 Tue, 22 Mar 2022 03:38:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz4XnbEotBgwmm8Kokd0VkMAvlrSAfcDAHK9dNDeWtrOWpekkIQX4QyQevtVagOHVlC3sFqKg==
X-Received: by 2002:a05:6214:29ca:b0:441:1f8c:e58d with SMTP id
 gh10-20020a05621429ca00b004411f8ce58dmr7306547qvb.111.1647945513838; 
 Tue, 22 Mar 2022 03:38:33 -0700 (PDT)
Received: from step1.redhat.com ([87.12.25.114])
 by smtp.gmail.com with ESMTPSA id
 q123-20020a378e81000000b0067eb3d6f605sm1532443qkd.0.2022.03.22.03.38.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Mar 2022 03:38:33 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Subject: [PATCH net] vsock/virtio: enable VQs early on probe
Date: Tue, 22 Mar 2022 11:38:23 +0100
Message-Id: <20220322103823.83411-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Asias He <asias@redhat.com>, Paolo Abeni <pabeni@redhat.com>,
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
