Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F84DC433F5
	for <virtualization@archiver.kernel.org>; Fri, 21 Jan 2022 15:31:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2A84C404D7;
	Fri, 21 Jan 2022 15:31:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NnYN5BGq9N6x; Fri, 21 Jan 2022 15:31:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 13F3A4011C;
	Fri, 21 Jan 2022 15:31:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D715EC0039;
	Fri, 21 Jan 2022 15:31:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9779DC002F
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Jan 2022 15:31:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 85AC660F96
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Jan 2022 15:31:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YzSWCIkHbcWT
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Jan 2022 15:31:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 443F860F7B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Jan 2022 15:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1642779083;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=OtUoNHq7A4SE6zFtDfLA7te7a+Lq28AP0hpcNcpECag=;
 b=Z+etQ63oLPqlrTGBDCPW6bZBR9/ANCb5GIUYNdtQKvZA0dJC89sQ4LMW00BAAugrWu8TXb
 ZMGDcNPfuXb1qTLbxykR80ueWZjBU2/XHsmbhZX19uw/mReH/N6rbYSQsZwXx5Qtww37Je
 5K0ny69wg5ChgcIapnz3Oeo7eOXlnvw=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-316-OqrGok07MaGFPZaETGHBtw-1; Fri, 21 Jan 2022 10:31:22 -0500
X-MC-Unique: OqrGok07MaGFPZaETGHBtw-1
Received: by mail-pg1-f200.google.com with SMTP id
 o18-20020a637312000000b0034cf7392a50so5230859pgc.20
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Jan 2022 07:31:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=OtUoNHq7A4SE6zFtDfLA7te7a+Lq28AP0hpcNcpECag=;
 b=M5GFi9ZwSpOCriHjAkcZIu6+G4hCNmk1b5yXM9UlZJich64+ZPSyEJGLU2bmNjTGvd
 JfyFtCB4aeaUkhTMNItlS10wYAyjdR/R926YvRKMR7mKSZQFhlbhT5cREAWSS/z/viq9
 I7qp3GTqFr3B2igjwkptYG6r/cOJOPbtY5NY1+xkr/T9lzTsch8uiQcs8NQSBhSmL9CX
 d6LXPTmbwoQeHNb6xDR3UJHgncn2bGFwMCniSbTPCg/Ze9L+gB7V9gqdCxeX36K+Vdeq
 Mer65hYUBUpNJJ1Z2MlSqqHJh2e659eS6ouUywU/QjHHSM0J9Hoaf0AMLEhY/zQs8l2V
 N8wQ==
X-Gm-Message-State: AOAM5317SJqGkA6QhovuSG0SOa6cHybXM1c6drS6oyWkpEoW5C9TWUfF
 5BORMUDooKmU6fQ/z9yowNdGeuFlm6YBNrIQ9jvO041hvf2pHc9J+8pcn4yknmBt43rHSUyCgvK
 g3WazrEyL4isKkPGkM8ACVISjs/9mGAIIBkBzBQa3KQsZ0msWJqIi0JNSX1tFpBaJW00mu3ye1+
 EJiWzWS0ngwGvVgFXuvQ==
X-Received: by 2002:a62:ab03:0:b0:4c6:419e:f8f2 with SMTP id
 p3-20020a62ab03000000b004c6419ef8f2mr4067822pff.4.1642779080452; 
 Fri, 21 Jan 2022 07:31:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx6q0reQiVxMv8WMVszJ9f1J1yC2BTK8uM93yxVR4UChzktBXihhcIJ52HJnaO4J45jUP3f6A==
X-Received: by 2002:a62:ab03:0:b0:4c6:419e:f8f2 with SMTP id
 p3-20020a62ab03000000b004c6419ef8f2mr4067798pff.4.1642779080064; 
 Fri, 21 Jan 2022 07:31:20 -0800 (PST)
Received: from steredhat.redhat.com
 (host-95-238-125-214.retail.telecomitalia.it. [95.238.125.214])
 by smtp.gmail.com with ESMTPSA id s6sm5394612pgk.44.2022.01.21.07.31.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Jan 2022 07:31:18 -0800 (PST)
From: Stefano Garzarella <sgarzare@redhat.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH v2] vhost: cache avail index in vhost_enable_notify()
Date: Fri, 21 Jan 2022 16:31:08 +0100
Message-Id: <20220121153108.187291-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>
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

In vhost_enable_notify() we enable the notifications and we read
the avail index to check if new buffers have become available in
the meantime.

We are not caching the avail index, so when the device will call
vhost_get_vq_desc(), it will find the old value in the cache and
it will read the avail index again.

It would be better to refresh the cache every time we read avail
index, so let's change vhost_enable_notify() caching the value in
`avail_idx` and compare it with `last_avail_idx` to check if there
are new buffers available.

We don't expect a significant performance boost because
the above path is not very common, indeed vhost_enable_notify()
is often called with unlikely(), expecting that avail index has
not been updated.

We ran virtio-test/vhost-test and noticed minimal improvement as
expected. To stress the patch more, we modified vhost_test.ko to
call vhost_enable_notify()/vhost_disable_notify() on every cycle
when calling vhost_get_vq_desc(); in this case we observed a more
evident improvement, with a reduction of the test execution time
of about 3.7%.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
v2
- added performance info in the commit description [MST]
---
 drivers/vhost/vhost.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 59edb5a1ffe2..07363dff559e 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -2543,8 +2543,9 @@ bool vhost_enable_notify(struct vhost_dev *dev, struct vhost_virtqueue *vq)
 		       &vq->avail->idx, r);
 		return false;
 	}
+	vq->avail_idx = vhost16_to_cpu(vq, avail_idx);
 
-	return vhost16_to_cpu(vq, avail_idx) != vq->avail_idx;
+	return vq->avail_idx != vq->last_avail_idx;
 }
 EXPORT_SYMBOL_GPL(vhost_enable_notify);
 
-- 
2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
