Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 733C0C433EF
	for <virtualization@archiver.kernel.org>; Thu, 28 Apr 2022 13:23:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0C05840B95;
	Thu, 28 Apr 2022 13:23:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eiVguWMik3bn; Thu, 28 Apr 2022 13:23:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 91D88401C5;
	Thu, 28 Apr 2022 13:22:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 661A2C0039;
	Thu, 28 Apr 2022 13:22:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CED0EC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 13:22:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AE06560E9D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 13:22:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kWIQ88G5GVdZ
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 13:22:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E434760BB2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 13:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1651152175;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a14xq4pv5r/FkYeXeUtrnJ56gM2JRtUzYDAyxUxKyXw=;
 b=N+hUg0xtn10zg4CVSxK865MFQtaqYNBJuUM4OspbPSywZMxZRzTeHFBrVoRp6UWRNL/q0s
 08BpjB+4xbLPlJyAXT/Wy0LRdxXgwA71IoRAxvnPIIl0GPbit5UuQ1dgf6QVd+aWtag9df
 QEKRRGaLoSGUykmuhRBSd/siXenF2sI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-216-sPMFwa72MTi3W2sF9t2Ekw-1; Thu, 28 Apr 2022 09:22:49 -0400
X-MC-Unique: sPMFwa72MTi3W2sF9t2Ekw-1
Received: by mail-wr1-f69.google.com with SMTP id
 s8-20020adf9788000000b0020adb01dc25so1923800wrb.20
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 06:22:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=a14xq4pv5r/FkYeXeUtrnJ56gM2JRtUzYDAyxUxKyXw=;
 b=iGpE/6NWamps+Si3LRioSK1ZlnmfY7ClOxLeeIrLMRD5Eq67nGJ+0Tx5kRtAXBExQD
 DNDnytn3vHndLr1rT+JH5nh7k8Lg2vkIyqqmqc5KECop6+mY/YXhdXpPG5tKI+yoTviW
 oSRr3FVC6QcTSk6+jC0uY2A64xkmr1p+iAkLr2fxhAKr/eEXChcMmT2uPl+IhUIsMYT/
 uyYaHsFG9HrRVgtW55mVSs2Q/hxoTDepaPCxIw2bRGQ5qhNePV5m45AIifckpUFAU11N
 FAebbFtNQcpw3tRtCLo9eMmdwDKLekO/rxXE7h1FAg09xTLq3dQdT7SYRigkf1FYS7Mu
 yoHw==
X-Gm-Message-State: AOAM531/r35DjrOD0rq6jixtFVNk42c5PIHZOn6uRLOIjHOEgpWxZMJg
 DG3v0R04if+VB7kTzsCVYxTHrhlmczkICJ9MylYooEp7UUVUrVUIWnjxb7Yvb6E6JXaf13IHwhF
 nPzV91KWA776JsWHAuN091VW6RHlZl3CjZxxd1Cpr5Q==
X-Received: by 2002:a05:600c:502b:b0:38f:f7c6:3609 with SMTP id
 n43-20020a05600c502b00b0038ff7c63609mr31169275wmr.15.1651152168730; 
 Thu, 28 Apr 2022 06:22:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwQVnCQJ38EwfNhzDeSYDCstkye3h+BWbMt9XxC8erbs+iXajlC/fBdW5XhbJa/npUVsWgZzw==
X-Received: by 2002:a05:600c:502b:b0:38f:f7c6:3609 with SMTP id
 n43-20020a05600c502b00b0038ff7c63609mr31169254wmr.15.1651152168532; 
 Thu, 28 Apr 2022 06:22:48 -0700 (PDT)
Received: from step1.redhat.com (host-87-11-6-234.retail.telecomitalia.it.
 [87.11.6.234]) by smtp.gmail.com with ESMTPSA id
 f7-20020a05600c4e8700b00393f1393abfsm4680978wmq.41.2022.04.28.06.22.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Apr 2022 06:22:47 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Subject: [PATCH net-next 2/2] vsock/virtio: add support for device
 suspend/resume
Date: Thu, 28 Apr 2022 15:22:41 +0200
Message-Id: <20220428132241.152679-3-sgarzare@redhat.com>
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

Implement .freeze and .restore callbacks of struct virtio_driver
to support device suspend/resume.

During suspension all connected sockets are reset and VQs deleted.
During resume the VQs are re-initialized.

Reported by: Vilas R K <vilas.r.k@intel.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 net/vmw_vsock/virtio_transport.c | 47 ++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index 31f4f6f40614..ad64f403536a 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -743,6 +743,49 @@ static void virtio_vsock_remove(struct virtio_device *vdev)
 	kfree(vsock);
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int virtio_vsock_freeze(struct virtio_device *vdev)
+{
+	struct virtio_vsock *vsock = vdev->priv;
+
+	mutex_lock(&the_virtio_vsock_mutex);
+
+	rcu_assign_pointer(the_virtio_vsock, NULL);
+	synchronize_rcu();
+
+	virtio_vsock_vqs_del(vsock);
+
+	mutex_unlock(&the_virtio_vsock_mutex);
+
+	return 0;
+}
+
+static int virtio_vsock_restore(struct virtio_device *vdev)
+{
+	struct virtio_vsock *vsock = vdev->priv;
+	int ret;
+
+	mutex_lock(&the_virtio_vsock_mutex);
+
+	/* Only one virtio-vsock device per guest is supported */
+	if (rcu_dereference_protected(the_virtio_vsock,
+				lockdep_is_held(&the_virtio_vsock_mutex))) {
+		ret = -EBUSY;
+		goto out;
+	}
+
+	ret = virtio_vsock_vqs_init(vsock);
+	if (ret < 0)
+		goto out;
+
+	rcu_assign_pointer(the_virtio_vsock, vsock);
+
+out:
+	mutex_unlock(&the_virtio_vsock_mutex);
+	return ret;
+}
+#endif /* CONFIG_PM_SLEEP */
+
 static struct virtio_device_id id_table[] = {
 	{ VIRTIO_ID_VSOCK, VIRTIO_DEV_ANY_ID },
 	{ 0 },
@@ -760,6 +803,10 @@ static struct virtio_driver virtio_vsock_driver = {
 	.id_table = id_table,
 	.probe = virtio_vsock_probe,
 	.remove = virtio_vsock_remove,
+#ifdef CONFIG_PM_SLEEP
+	.freeze = virtio_vsock_freeze,
+	.restore = virtio_vsock_restore,
+#endif
 };
 
 static int __init virtio_vsock_init(void)
-- 
2.35.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
