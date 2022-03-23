Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73095C43217
	for <virtualization@archiver.kernel.org>; Wed, 23 Mar 2022 08:50:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1FF5341A43;
	Wed, 23 Mar 2022 08:50:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HUlWxF4BuYLL; Wed, 23 Mar 2022 08:50:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id ACF1341A4A;
	Wed, 23 Mar 2022 08:50:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0556AC0085;
	Wed, 23 Mar 2022 08:50:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 022B3C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 08:50:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D33B88496E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 08:50:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PiGVROvIu_7Z
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 08:50:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 35B578496F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 08:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1648025409;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2tskzl0i4fBaGQ2SA9UFWp+uERMa68xRFlfoMwtqOtQ=;
 b=f1vjWyGKTV8YNupHUvzhvtfqRXy2Uf/WNrQPLTQTcEg9Psfd1DQ4F9/yZFlDoUz3W+Q2aF
 660gEJCjl5GgWnuVKFnfPzNN6kMk+0KbBL11zMpBIWL5oieAsOwMYlrphx2pGN4Xzux3x9
 4/Q5QjqRwwSFtp3imP0TwnTXkTwgNq0=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-50-VXbN7sZINFOPQ3Q-GmrxZg-1; Wed, 23 Mar 2022 04:50:08 -0400
X-MC-Unique: VXbN7sZINFOPQ3Q-GmrxZg-1
Received: by mail-qk1-f197.google.com with SMTP id
 195-20020a3707cc000000b0067b0c849285so565121qkh.5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 01:50:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2tskzl0i4fBaGQ2SA9UFWp+uERMa68xRFlfoMwtqOtQ=;
 b=Y1n66gpfTPh+LXTchBnvuDYRfr9dupDMJ/Tmk2MGGTIHUvEgnemGhNLmwALwgJEHAk
 FM29YWRgWyEeEfN8tZPmQPd3tHq8vP+O2UUIcaC/boy6Suwlf+nzsvQXBXK+IBWD6VSd
 5KKUuhNYJdj0btuQm10AyOaqAZGZP2l4lOmu6GbYxSSWuBFtm0Q5n440fLB3YYX2djoB
 QfCLH5jxK5j279zZiQpwGp6NCTqNybCCftG7bQATaSuTAzgd0Y4b4CBDCLmd29wK+FHB
 UO+FpE/vPNz70f4Hz5x0SZHl6BV3s7l9xvXjW5BHl1r/zE4K7qTc2wNijxXU4eaPEL4i
 iqAw==
X-Gm-Message-State: AOAM531+YUJevTU/7Qj/qNceL+SvxHmMwBtDZMu7YF4eIKoV6GBMwyyt
 4Ql6nx12hTf7JXcaV00uiqP3ZPs6gLLwTztjZjf8v8YRQcchAVy8qYRpDFIykvnjngh+b0JrwUF
 aLlhq4ZcETp1PrqtfMrALfVLvqi/rvhP3+W6to+YKmw==
X-Received: by 2002:a05:620a:24cd:b0:67d:5f50:ef41 with SMTP id
 m13-20020a05620a24cd00b0067d5f50ef41mr18012801qkn.568.1648025407747; 
 Wed, 23 Mar 2022 01:50:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwwKKClidIuo6B0OT0d5+9jRGkHIXrwcI73KaPwBD6CWDKidHKCMTHM2A18yH6e8LMQdxDzAg==
X-Received: by 2002:a05:620a:24cd:b0:67d:5f50:ef41 with SMTP id
 m13-20020a05620a24cd00b0067d5f50ef41mr18012795qkn.568.1648025407541; 
 Wed, 23 Mar 2022 01:50:07 -0700 (PDT)
Received: from step1.redhat.com (host-87-12-25-114.business.telecomitalia.it.
 [87.12.25.114]) by smtp.gmail.com with ESMTPSA id
 j188-20020a3755c5000000b0067d1c76a09fsm10640609qkb.74.2022.03.23.01.50.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Mar 2022 01:50:06 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Subject: [PATCH net v2 2/3] vsock/virtio: initialize vdev->priv before using
 VQs
Date: Wed, 23 Mar 2022 09:49:53 +0100
Message-Id: <20220323084954.11769-3-sgarzare@redhat.com>
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

When we fill VQs with empty buffers and kick the host, it may send
an interrupt. `vdev->priv` must be initialized before this since it
is used in the virtqueue callback.

Fixes: 0deab087b16a ("vsock/virtio: use RCU to avoid use-after-free on the_virtio_vsock")
Suggested-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 net/vmw_vsock/virtio_transport.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index b1962f8cd502..fff67ad39087 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -622,6 +622,7 @@ static int virtio_vsock_probe(struct virtio_device *vdev)
 	INIT_WORK(&vsock->event_work, virtio_transport_event_work);
 	INIT_WORK(&vsock->send_pkt_work, virtio_transport_send_pkt_work);
 
+	vdev->priv = vsock;
 	virtio_device_ready(vdev);
 
 	mutex_lock(&vsock->tx_lock);
@@ -641,7 +642,6 @@ static int virtio_vsock_probe(struct virtio_device *vdev)
 	if (virtio_has_feature(vdev, VIRTIO_VSOCK_F_SEQPACKET))
 		vsock->seqpacket_allow = true;
 
-	vdev->priv = vsock;
 	rcu_assign_pointer(the_virtio_vsock, vsock);
 
 	mutex_unlock(&the_virtio_vsock_mutex);
-- 
2.35.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
