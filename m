Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AFE3C07E9D
	for <virtualization@archiver.kernel.org>; Mon, 26 Sep 2022 13:18:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 828A260F80;
	Mon, 26 Sep 2022 13:18:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 828A260F80
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bfAofHbQ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id U-CEPfvDK8gB; Mon, 26 Sep 2022 13:18:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B93E760F90;
	Mon, 26 Sep 2022 13:18:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B93E760F90
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9CC76C0033;
	Mon, 26 Sep 2022 13:18:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0A04DC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Sep 2022 13:18:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B53F560F72
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Sep 2022 13:18:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B53F560F72
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bmUtGBwUSmFl
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Sep 2022 13:18:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B367260672
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B367260672
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Sep 2022 13:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1664198283;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LtpLVF78yaQ8akL0eEAs7+Z0svwvAfFmddP3iRQwkjc=;
 b=bfAofHbQn9pOaAefG1DJxnTqxuPKTeraNDC2ZWVQsRiCROA7pygeF2QdKMw5TbfgjJs7se
 qlXjOOXr/V2Bffpe36bwP+HN53Uv8J48CykC8h0Zc8fmc9xMYKYBY5JUxIYwZEIdeNgZzN
 dFr2q5mHMLlFD3VEQ+oTPlsum8j28z0=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-533-UUr-YTmPNei0Za-Nczg1ng-1; Mon, 26 Sep 2022 09:18:02 -0400
X-MC-Unique: UUr-YTmPNei0Za-Nczg1ng-1
Received: by mail-qv1-f71.google.com with SMTP id
 nn9-20020a056214358900b004ac7136c9a3so3781636qvb.16
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Sep 2022 06:18:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
 bh=LtpLVF78yaQ8akL0eEAs7+Z0svwvAfFmddP3iRQwkjc=;
 b=OBVEHpN+MHuVovr9ylw7K9QWThsWwXwEDJtchS0cmM8peXSNz0Q2LphA5ff+haFwum
 fXkuaw7ClfI5RvfgBlqpolMEGRWWhdvz+ZWL4utXJQHivh6HEbDuzRttpdioaA2wuAtV
 bC8JnVHsNATlqGWk2C2N5SowbzuV68sTBHHs0MtySBmzkeH19cBEtsIqVh440FWN3/J4
 67qbO2/vhs3246L112G5n+dklPN/DSrCuJWVL3mjYlFQbEvYlhC9q/I6b5ALd71t9E3E
 9Mr5kFRhvQCbXySug8vBkTojYnniFafRwIyzvpaldMAlFEV5hK0ZN3syY798R0Vbd4hi
 1PrQ==
X-Gm-Message-State: ACrzQf1rFxmn5gFZQBeMuMOXlzz7ZdWgOunvhULSfeaOh/a0ol1H2+ai
 0yMQA+7EXhJzn7fN+P4wErxrAgHhM9eydBEPnbAVefBG+e1TLsCcEcHMMQ3J3aZRTPOVqTrcho5
 MUWo/s2oj7BepyantnjxdlSxiza4ykWvZq1n0nDBHeA==
X-Received: by 2002:a05:622a:654:b0:35c:f6e6:76b7 with SMTP id
 a20-20020a05622a065400b0035cf6e676b7mr17820464qtb.365.1664198278781; 
 Mon, 26 Sep 2022 06:17:58 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4X2VsELTxq8A6XavJEjjHhj8YKH3iZ07B183UX0OdOkc1HRRewWyFvSFtXrHzQS3LMX97ORg==
X-Received: by 2002:a05:622a:654:b0:35c:f6e6:76b7 with SMTP id
 a20-20020a05622a065400b0035cf6e676b7mr17820441qtb.365.1664198278498; 
 Mon, 26 Sep 2022 06:17:58 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-222.retail.telecomitalia.it.
 [79.46.200.222]) by smtp.gmail.com with ESMTPSA id
 bm17-20020a05620a199100b006c73c3d288esm11765046qkb.131.2022.09.26.06.17.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Sep 2022 06:17:57 -0700 (PDT)
Date: Mon, 26 Sep 2022 15:17:51 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobby.eshleman@gmail.com>
Subject: Re: [PATCH 4/6] virtio/vsock: add VIRTIO_VSOCK_F_DGRAM feature bit
Message-ID: <20220926131751.pdlc5mbx6gxqlmkx@sgarzare-redhat>
References: <cover.1660362668.git.bobby.eshleman@bytedance.com>
 <3d1f32c4da81f8a0870e126369ba12bc8c4ad048.1660362668.git.bobby.eshleman@bytedance.com>
MIME-Version: 1.0
In-Reply-To: <3d1f32c4da81f8a0870e126369ba12bc8c4ad048.1660362668.git.bobby.eshleman@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Bobby Eshleman <bobbyeshleman@gmail.com>,
 Cong Wang <cong.wang@bytedance.com>,
 Bobby Eshleman <bobby.eshleman@bytedance.com>,
 Jiang Wang <jiang.wang@bytedance.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, kvm@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Mon, Aug 15, 2022 at 10:56:07AM -0700, Bobby Eshleman wrote:
>This commit adds a feature bit for virtio vsock to support datagrams.
>
>Signed-off-by: Jiang Wang <jiang.wang@bytedance.com>
>Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
>---
> drivers/vhost/vsock.c             | 3 ++-
> include/uapi/linux/virtio_vsock.h | 1 +
> net/vmw_vsock/virtio_transport.c  | 8 ++++++--
> 3 files changed, 9 insertions(+), 3 deletions(-)
>
>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>index b20ddec2664b..a5d1bdb786fe 100644
>--- a/drivers/vhost/vsock.c
>+++ b/drivers/vhost/vsock.c
>@@ -32,7 +32,8 @@
> enum {
> 	VHOST_VSOCK_FEATURES = VHOST_FEATURES |
> 			       (1ULL << VIRTIO_F_ACCESS_PLATFORM) |
>-			       (1ULL << VIRTIO_VSOCK_F_SEQPACKET)
>+			       (1ULL << VIRTIO_VSOCK_F_SEQPACKET) |
>+			       (1ULL << VIRTIO_VSOCK_F_DGRAM)
> };
>
> enum {
>diff --git a/include/uapi/linux/virtio_vsock.h b/include/uapi/linux/virtio_vsock.h
>index 64738838bee5..857df3a3a70d 100644
>--- a/include/uapi/linux/virtio_vsock.h
>+++ b/include/uapi/linux/virtio_vsock.h
>@@ -40,6 +40,7 @@
>
> /* The feature bitmap for virtio vsock */
> #define VIRTIO_VSOCK_F_SEQPACKET	1	/* SOCK_SEQPACKET supported */
>+#define VIRTIO_VSOCK_F_DGRAM		2	/* Host support dgram vsock */

We already allocated bit 2 for F_NO_IMPLIED_STREAM , so we should use 3:
https://github.com/oasis-tcs/virtio-spec/blob/26ed30ccb049fd51d6e20aad3de2807d678edb3a/virtio-vsock.tex#L22
(I'll send patches to implement F_STREAM and F_NO_IMPLIED_STREAM 
negotiation soon).

As long as it's RFC it's fine to introduce F_DGRAM, but we should first 
change virtio-spec before merging this series.

About the patch, we should only negotiate the new feature when we really 
have DGRAM support. So, it's better to move this patch after adding 
support for datagram.

Thanks,
Stefano

>
> struct virtio_vsock_config {
> 	__le64 guest_cid;
>diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>index c6212eb38d3c..073314312683 100644
>--- a/net/vmw_vsock/virtio_transport.c
>+++ b/net/vmw_vsock/virtio_transport.c
>@@ -35,6 +35,7 @@ static struct virtio_transport virtio_transport; /* 
>forward declaration */
> struct virtio_vsock {
> 	struct virtio_device *vdev;
> 	struct virtqueue *vqs[VSOCK_VQ_MAX];
>+	bool has_dgram;
>
> 	/* Virtqueue processing is deferred to a workqueue */
> 	struct work_struct tx_work;
>@@ -709,7 +710,6 @@ static int virtio_vsock_probe(struct virtio_device *vdev)
> 	}
>
> 	vsock->vdev = vdev;
>-
> 	vsock->rx_buf_nr = 0;
> 	vsock->rx_buf_max_nr = 0;
> 	atomic_set(&vsock->queued_replies, 0);
>@@ -726,6 +726,9 @@ static int virtio_vsock_probe(struct virtio_device *vdev)
> 	if (virtio_has_feature(vdev, VIRTIO_VSOCK_F_SEQPACKET))
> 		vsock->seqpacket_allow = true;
>
>+	if (virtio_has_feature(vdev, VIRTIO_VSOCK_F_DGRAM))
>+		vsock->has_dgram = true;
>+
> 	vdev->priv = vsock;
>
> 	ret = virtio_vsock_vqs_init(vsock);
>@@ -820,7 +823,8 @@ static struct virtio_device_id id_table[] = {
> };
>
> static unsigned int features[] = {
>-	VIRTIO_VSOCK_F_SEQPACKET
>+	VIRTIO_VSOCK_F_SEQPACKET,
>+	VIRTIO_VSOCK_F_DGRAM
> };
>
> static struct virtio_driver virtio_vsock_driver = {
>-- 
>2.35.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
