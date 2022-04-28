Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47A0DC43219
	for <virtualization@archiver.kernel.org>; Thu, 28 Apr 2022 13:22:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D937540B54;
	Thu, 28 Apr 2022 13:22:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hTw3KWHmxWRA; Thu, 28 Apr 2022 13:22:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4FFAF401C5;
	Thu, 28 Apr 2022 13:22:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 37E49C0039;
	Thu, 28 Apr 2022 13:22:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 039A2C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 13:22:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D71F24175D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 13:22:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7G3_kx5UvmKm
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 13:22:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BB8B04173D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 13:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1651152169;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W6dlhZBY+AtMsp+AcyPDmHg9swfew9GIgRtcUZ3Lw40=;
 b=ERGRWPExNBg0Pvy0b1aC2RyZ9uCcm09vBbygDZnBwciKtm+n9Ib9QUd7nZLGQGTrh5QajR
 ncKogxSpXRWn6zXHwX6Wi8ji3XWCbMPZ7bjRh2m63jTc/GtG5QbdL6yqhUqbdGBS71SlNQ
 Mwl0kEKBSIi081bEWFfOIPEaHIMq3F8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-66-29FR4SlPNHu1_KnQfzOVvw-1; Thu, 28 Apr 2022 09:22:47 -0400
X-MC-Unique: 29FR4SlPNHu1_KnQfzOVvw-1
Received: by mail-wr1-f70.google.com with SMTP id
 w4-20020adfbac4000000b0020acba4b779so1933910wrg.22
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 06:22:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=W6dlhZBY+AtMsp+AcyPDmHg9swfew9GIgRtcUZ3Lw40=;
 b=Wx3E8TZNm9Nox06Tn3E9hbGO+uKlkOwyHSkOK3mVyn39kPfk0o9NHHDQBqtEN+nlMB
 7acNfdFv+FJoVGamAb6gJEqH2sJyUqlY3Wx35zuaF8efx6niCz6j8XxgYJj0iem2Rt84
 P6lOSRrMwW2e25SPWJ58NVkob7xLnkviZpECJuVnyW7G+ZwFaO5SPh1h7DIiRa5jpVB+
 qE3n3g/3vwhR2sygKoJKxqTmn3ApOb+pHbZKFJ03bJmEO4Y21toK8yEnbRBWSYSZqEvR
 iKPAhXYdCTYl/020MuDfajkMZuX+KQ/4y+JpmwXONnImk7JpRH1FN2QPsD0z4nLlisA/
 D+VQ==
X-Gm-Message-State: AOAM530Orh1pcApsIeZYOt420DUkAr4KjgNodHVvpFl9xEnGnUgtQOyz
 tO2z+LDb6kK+I31mNVV9465IjZLFDjzUqOb764IvgqnzLk1YpeuW17ZhHEkeEa/wCTRhd+j+1ck
 0Uz7bO9nF+ZyomAvUJYXS8mokcFEpFmw3uUDQ7DHWOA==
X-Received: by 2002:a05:6000:510:b0:203:e469:f0a3 with SMTP id
 a16-20020a056000051000b00203e469f0a3mr26951294wrf.710.1651152166431; 
 Thu, 28 Apr 2022 06:22:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxYAkm50ZItGhHTzdsIHOIHFbRvU2OlAJNnEs3e9LhZU6vcKw9GOx6UJGzwm9gFfHP9K8b2vw==
X-Received: by 2002:a05:6000:510:b0:203:e469:f0a3 with SMTP id
 a16-20020a056000051000b00203e469f0a3mr26951279wrf.710.1651152166162; 
 Thu, 28 Apr 2022 06:22:46 -0700 (PDT)
Received: from step1.redhat.com (host-87-11-6-234.retail.telecomitalia.it.
 [87.11.6.234]) by smtp.gmail.com with ESMTPSA id
 f7-20020a05600c4e8700b00393f1393abfsm4680978wmq.41.2022.04.28.06.22.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Apr 2022 06:22:45 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Subject: [PATCH net-next 1/2] vsock/virtio: factor our the code to initialize
 and delete VQs
Date: Thu, 28 Apr 2022 15:22:40 +0200
Message-Id: <20220428132241.152679-2-sgarzare@redhat.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220428132241.152679-1-sgarzare@redhat.com>
References: <20220428132241.152679-1-sgarzare@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Vilas R K <vilas.r.k@intel.com>, Paolo Abeni <pabeni@redhat.com>,
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

Add virtio_vsock_vqs_init() and virtio_vsock_vqs_del() with the code
that was in virtio_vsock_probe() and virtio_vsock_remove to initialize
and delete VQs.

These new functions will be used in the next commit to support device
suspend/resume

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 net/vmw_vsock/virtio_transport.c | 150 +++++++++++++++++--------------
 1 file changed, 84 insertions(+), 66 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index ba1c8cc0c467..31f4f6f40614 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -566,67 +566,28 @@ static void virtio_transport_rx_work(struct work_struct *work)
 	mutex_unlock(&vsock->rx_lock);
 }
 
-static int virtio_vsock_probe(struct virtio_device *vdev)
+static int virtio_vsock_vqs_init(struct virtio_vsock *vsock)
 {
-	vq_callback_t *callbacks[] = {
-		virtio_vsock_rx_done,
-		virtio_vsock_tx_done,
-		virtio_vsock_event_done,
-	};
+	struct virtio_device *vdev = vsock->vdev;
 	static const char * const names[] = {
 		"rx",
 		"tx",
 		"event",
 	};
-	struct virtio_vsock *vsock = NULL;
+	vq_callback_t *callbacks[] = {
+		virtio_vsock_rx_done,
+		virtio_vsock_tx_done,
+		virtio_vsock_event_done,
+	};
 	int ret;
 
-	ret = mutex_lock_interruptible(&the_virtio_vsock_mutex);
-	if (ret)
-		return ret;
-
-	/* Only one virtio-vsock device per guest is supported */
-	if (rcu_dereference_protected(the_virtio_vsock,
-				lockdep_is_held(&the_virtio_vsock_mutex))) {
-		ret = -EBUSY;
-		goto out;
-	}
-
-	vsock = kzalloc(sizeof(*vsock), GFP_KERNEL);
-	if (!vsock) {
-		ret = -ENOMEM;
-		goto out;
-	}
-
-	vsock->vdev = vdev;
-
-	ret = virtio_find_vqs(vsock->vdev, VSOCK_VQ_MAX,
-			      vsock->vqs, callbacks, names,
+	ret = virtio_find_vqs(vdev, VSOCK_VQ_MAX, vsock->vqs, callbacks, names,
 			      NULL);
 	if (ret < 0)
-		goto out;
+		return ret;
 
 	virtio_vsock_update_guest_cid(vsock);
 
-	vsock->rx_buf_nr = 0;
-	vsock->rx_buf_max_nr = 0;
-	atomic_set(&vsock->queued_replies, 0);
-
-	mutex_init(&vsock->tx_lock);
-	mutex_init(&vsock->rx_lock);
-	mutex_init(&vsock->event_lock);
-	spin_lock_init(&vsock->send_pkt_list_lock);
-	INIT_LIST_HEAD(&vsock->send_pkt_list);
-	INIT_WORK(&vsock->rx_work, virtio_transport_rx_work);
-	INIT_WORK(&vsock->tx_work, virtio_transport_tx_work);
-	INIT_WORK(&vsock->event_work, virtio_transport_event_work);
-	INIT_WORK(&vsock->send_pkt_work, virtio_transport_send_pkt_work);
-
-	if (virtio_has_feature(vdev, VIRTIO_VSOCK_F_SEQPACKET))
-		vsock->seqpacket_allow = true;
-
-	vdev->priv = vsock;
-
 	virtio_device_ready(vdev);
 
 	mutex_lock(&vsock->tx_lock);
@@ -643,30 +604,15 @@ static int virtio_vsock_probe(struct virtio_device *vdev)
 	vsock->event_run = true;
 	mutex_unlock(&vsock->event_lock);
 
-	rcu_assign_pointer(the_virtio_vsock, vsock);
-
-	mutex_unlock(&the_virtio_vsock_mutex);
-
 	return 0;
-
-out:
-	kfree(vsock);
-	mutex_unlock(&the_virtio_vsock_mutex);
-	return ret;
 }
 
-static void virtio_vsock_remove(struct virtio_device *vdev)
+static void virtio_vsock_vqs_del(struct virtio_vsock *vsock)
 {
-	struct virtio_vsock *vsock = vdev->priv;
+	struct virtio_device *vdev = vsock->vdev;
 	struct virtio_vsock_pkt *pkt;
 
-	mutex_lock(&the_virtio_vsock_mutex);
-
-	vdev->priv = NULL;
-	rcu_assign_pointer(the_virtio_vsock, NULL);
-	synchronize_rcu();
-
-	/* Reset all connected sockets when the device disappear */
+	/* Reset all connected sockets when the VQs disappear */
 	vsock_for_each_connected_socket(&virtio_transport.transport,
 					virtio_vsock_reset_sock);
 
@@ -711,6 +657,78 @@ static void virtio_vsock_remove(struct virtio_device *vdev)
 
 	/* Delete virtqueues and flush outstanding callbacks if any */
 	vdev->config->del_vqs(vdev);
+}
+
+static int virtio_vsock_probe(struct virtio_device *vdev)
+{
+	struct virtio_vsock *vsock = NULL;
+	int ret;
+
+	ret = mutex_lock_interruptible(&the_virtio_vsock_mutex);
+	if (ret)
+		return ret;
+
+	/* Only one virtio-vsock device per guest is supported */
+	if (rcu_dereference_protected(the_virtio_vsock,
+				lockdep_is_held(&the_virtio_vsock_mutex))) {
+		ret = -EBUSY;
+		goto out;
+	}
+
+	vsock = kzalloc(sizeof(*vsock), GFP_KERNEL);
+	if (!vsock) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	vsock->vdev = vdev;
+
+	vsock->rx_buf_nr = 0;
+	vsock->rx_buf_max_nr = 0;
+	atomic_set(&vsock->queued_replies, 0);
+
+	mutex_init(&vsock->tx_lock);
+	mutex_init(&vsock->rx_lock);
+	mutex_init(&vsock->event_lock);
+	spin_lock_init(&vsock->send_pkt_list_lock);
+	INIT_LIST_HEAD(&vsock->send_pkt_list);
+	INIT_WORK(&vsock->rx_work, virtio_transport_rx_work);
+	INIT_WORK(&vsock->tx_work, virtio_transport_tx_work);
+	INIT_WORK(&vsock->event_work, virtio_transport_event_work);
+	INIT_WORK(&vsock->send_pkt_work, virtio_transport_send_pkt_work);
+
+	if (virtio_has_feature(vdev, VIRTIO_VSOCK_F_SEQPACKET))
+		vsock->seqpacket_allow = true;
+
+	vdev->priv = vsock;
+
+	ret = virtio_vsock_vqs_init(vsock);
+	if (ret < 0)
+		goto out;
+
+	rcu_assign_pointer(the_virtio_vsock, vsock);
+
+	mutex_unlock(&the_virtio_vsock_mutex);
+
+	return 0;
+
+out:
+	kfree(vsock);
+	mutex_unlock(&the_virtio_vsock_mutex);
+	return ret;
+}
+
+static void virtio_vsock_remove(struct virtio_device *vdev)
+{
+	struct virtio_vsock *vsock = vdev->priv;
+
+	mutex_lock(&the_virtio_vsock_mutex);
+
+	vdev->priv = NULL;
+	rcu_assign_pointer(the_virtio_vsock, NULL);
+	synchronize_rcu();
+
+	virtio_vsock_vqs_del(vsock);
 
 	/* Other works can be queued before 'config->del_vqs()', so we flush
 	 * all works before to free the vsock object to avoid use after free.
-- 
2.35.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
