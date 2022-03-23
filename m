Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06841C4332F
	for <virtualization@archiver.kernel.org>; Wed, 23 Mar 2022 17:36:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 87FE884A5A;
	Wed, 23 Mar 2022 17:36:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cRzcE3QoI5ES; Wed, 23 Mar 2022 17:36:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3F16184A31;
	Wed, 23 Mar 2022 17:36:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 18ABCC001A;
	Wed, 23 Mar 2022 17:36:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 88DC7C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 17:36:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 745F984A3D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 17:36:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TzzI1Xm-8pQ6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 17:36:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3232A84A4E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 17:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1648057001;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=badQ4iNux1pPz/7wSA5tFhWc+QQEkhPUp5sQLckQMkQ=;
 b=Smn0FCOWu3okH54sFJehYNUWOFHjQ5Kbcrbc8UO5U+olUKta9QyvbsyRL2uPMV7BLCP8z5
 SfnzPsPIcNOhGE9zX60T8432a3UXEvl2K9J/U98zvsWtm6I5Oe6Nw0tfT295dcNjf4AcGK
 EIW+fb3pYvGscC261yglz07Gz7AHsUM=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-14-Z4wisagrOY2bcBhSK_QtPg-1; Wed, 23 Mar 2022 13:36:39 -0400
X-MC-Unique: Z4wisagrOY2bcBhSK_QtPg-1
Received: by mail-qk1-f199.google.com with SMTP id
 w200-20020a3762d1000000b0067d2149318dso1483861qkb.1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 10:36:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=badQ4iNux1pPz/7wSA5tFhWc+QQEkhPUp5sQLckQMkQ=;
 b=iAGDzES2pZcTOaDPlbX+6hw76A3r/WXNDQyEgYR8tq2nRPh+v3OJLHT0UxXidEO7m0
 guXM8deYiY2JPRZU4tiO64RJavSFHyaTAYVQ2JEML38U5QVUFbRw4urE2PIS+0dI+g40
 omPEvPytmTHDCofFeNnREeNn8oZP9wmbBj4a1Lq4GPWw0RnlI2sGx8/2Q3+wJRu/cJEQ
 Na+hT2522jaiFv3OP08pTkwPmCgb/cVg1hmrNjuoG5LPkUjvNxW/Z0PdlpOERz+Spusf
 b6RhsHn8fwFCTaNJxRuxJ+kvOtDiQ/KFj/hxhvJDTSFG5aqD4M+YqhAWJI6/IdIRqgQl
 /pBw==
X-Gm-Message-State: AOAM531OsNpoOVnpcIyZlvS9rh8X01ghl06jvfoggASXZkS/y2gKRa7k
 Q9T4PsXDd9uW94E0blYLbdWjfEiVroOzWFk+MRPlNueF6RCLc8Lxac3mp6U9vE4FJOZkz5dFF6e
 3X6f2mIHpSzp+dLJv94BsS7r3Wt3Hl376ZTSuggppug==
X-Received: by 2002:ae9:ed96:0:b0:67e:c89e:480a with SMTP id
 c144-20020ae9ed96000000b0067ec89e480amr718880qkg.274.1648056999446; 
 Wed, 23 Mar 2022 10:36:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJydhjsyMjk7m4UHfPJYXhDmCRpm61QiwyPkqiHwWTFXbdWyL3aM7kxuaIS4gs2HZKKewMIaMg==
X-Received: by 2002:ae9:ed96:0:b0:67e:c89e:480a with SMTP id
 c144-20020ae9ed96000000b0067ec89e480amr718839qkg.274.1648056998815; 
 Wed, 23 Mar 2022 10:36:38 -0700 (PDT)
Received: from step1.redhat.com (host-87-12-25-114.business.telecomitalia.it.
 [87.12.25.114]) by smtp.gmail.com with ESMTPSA id
 h14-20020a05622a170e00b002e1a65754d8sm476127qtk.91.2022.03.23.10.36.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Mar 2022 10:36:38 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Subject: [PATCH net v3 2/3] vsock/virtio: read the negotiated features before
 using VQs
Date: Wed, 23 Mar 2022 18:36:24 +0100
Message-Id: <20220323173625.91119-3-sgarzare@redhat.com>
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

Complete the driver configuration, reading the negotiated features,
before using the VQs in the virtio_vsock_probe().

Fixes: 53efbba12cc7 ("virtio/vsock: enable SEQPACKET for transport")
Suggested-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 net/vmw_vsock/virtio_transport.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index 3e5513934c9f..3954d3be9083 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -622,6 +622,9 @@ static int virtio_vsock_probe(struct virtio_device *vdev)
 	INIT_WORK(&vsock->event_work, virtio_transport_event_work);
 	INIT_WORK(&vsock->send_pkt_work, virtio_transport_send_pkt_work);
 
+	if (virtio_has_feature(vdev, VIRTIO_VSOCK_F_SEQPACKET))
+		vsock->seqpacket_allow = true;
+
 	vdev->priv = vsock;
 
 	mutex_lock(&vsock->tx_lock);
@@ -638,9 +641,6 @@ static int virtio_vsock_probe(struct virtio_device *vdev)
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
