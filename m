Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99DA8C001DE
	for <virtualization@archiver.kernel.org>; Tue, 25 Jul 2023 15:39:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2A17540933;
	Tue, 25 Jul 2023 15:39:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2A17540933
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cMjl9gkA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id N4o6pZoS1SuW; Tue, 25 Jul 2023 15:39:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 50D724094C;
	Tue, 25 Jul 2023 15:39:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 50D724094C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2D22FC0071;
	Tue, 25 Jul 2023 15:39:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 27ADDC0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jul 2023 15:39:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1003B80EAC
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jul 2023 15:39:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1003B80EAC
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=cMjl9gkA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jLaVSRgHRTCQ
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jul 2023 15:39:42 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 35CE580E9A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jul 2023 15:39:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 35CE580E9A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690299581;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hl7TlGBY8KC9fCz4U38u+w32QQOwR9hjmIKn/+TtjDc=;
 b=cMjl9gkAVHQS6znURZHdxUbrCRWB2VZg4180WJm7zSNsqefsdor4+k2VIoIOA6v5z2uwIh
 D4ffOauDDzfX5OF8Ml+6+5zyywXjSPbez/kYSulXQST/0c5xxcJ4fWOU1uWHALbrfPHn/X
 TPs47lfWEy9Puec+HiFFIib3h2F+rus=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-310-LILSqf4RP8-wIXfQeZXdhw-1; Tue, 25 Jul 2023 11:39:36 -0400
X-MC-Unique: LILSqf4RP8-wIXfQeZXdhw-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-4055c2dd0ceso36053491cf.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jul 2023 08:39:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690299576; x=1690904376;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hl7TlGBY8KC9fCz4U38u+w32QQOwR9hjmIKn/+TtjDc=;
 b=D4QuBoga5kewOMmqqpz8A4lVbt1fHlqhtX5EKqCaNLbzq00eNaGeUdSkGBvmtov0Vj
 it/SQjNQ3miBSUWCNnCQAu66f3udk3F3Y+BlX6ZF9fwaPYFlquWVprC1JGH/Y8a9uMQ1
 /xgbgBxk0YnkvnwKmHeVRkTXo/emTA7fMjqlpCslUK9xr+H9Qi6Oi7/ssXMUYIUD+vad
 kbEstWQZQe0n/4HQN3n+rDPsXqmEXQ0tpFEThCPs/FrtbQpSSUG/zPrcUQGmLDk4lAtj
 0aejFU/jhmiICGDCWDFvTW5NHvxcVhyYXjRpImLvex3f/TZi2uvoE31L3R4Ev6O3dlWe
 80+g==
X-Gm-Message-State: ABy/qLYFA3+2rmXylKrMfPKRP72Fbs2NNgunwXLE9J6hvbpwTb6dZzbx
 diOHO9CiDvdRLwURgMVF9TOxu2dFejj2S7k45sDYS2zlE2mSxIdiII2skbw8lHzVp43LId3TqjP
 QXcQBXZ/0W8kZLhhsaF9k6tX4UzFZdzvIAJLqtYAM9g==
X-Received: by 2002:a05:622a:1013:b0:402:76e3:59f6 with SMTP id
 d19-20020a05622a101300b0040276e359f6mr3746334qte.9.1690299576274; 
 Tue, 25 Jul 2023 08:39:36 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFPTRjdLNSLA8c7aE0osG3x1L3hWBx5nQgehQrRb2Vj3GyGN/3UVxsy9bokM2ED6bC9iQzVnw==
X-Received: by 2002:a05:622a:1013:b0:402:76e3:59f6 with SMTP id
 d19-20020a05622a101300b0040276e359f6mr3746308qte.9.1690299576067; 
 Tue, 25 Jul 2023 08:39:36 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.153.113])
 by smtp.gmail.com with ESMTPSA id
 s21-20020ac85ed5000000b00403b44bc230sm4085933qtx.95.2023.07.25.08.39.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Jul 2023 08:39:35 -0700 (PDT)
Date: Tue, 25 Jul 2023 17:39:30 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v2 2/4] virtio/vsock: support MSG_PEEK for
 SOCK_SEQPACKET
Message-ID: <hwdcuy3wwlrirpgphlex6omdnrztz7hqhu4447nmqml5sjqx5x@7y45zuyto7yq>
References: <20230719192708.1775162-1-AVKrasnov@sberdevices.ru>
 <20230719192708.1775162-3-AVKrasnov@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <20230719192708.1775162-3-AVKrasnov@sberdevices.ru>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 oxffffaa@gmail.com, Eric Dumazet <edumazet@google.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, kernel@sberdevices.ru,
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

On Wed, Jul 19, 2023 at 10:27:06PM +0300, Arseniy Krasnov wrote:
>This adds support of MSG_PEEK flag for SOCK_SEQPACKET type of socket.
>Difference with SOCK_STREAM is that this callback returns either length
>of the message or error.
>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> net/vmw_vsock/virtio_transport_common.c | 63 +++++++++++++++++++++++--
> 1 file changed, 60 insertions(+), 3 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 2ee40574c339..352d042b130b 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -460,6 +460,63 @@ virtio_transport_stream_do_dequeue(struct vsock_sock *vsk,
> 	return err;
> }
>
>+static ssize_t
>+virtio_transport_seqpacket_do_peek(struct vsock_sock *vsk,
>+				   struct msghdr *msg)
>+{
>+	struct virtio_vsock_sock *vvs = vsk->trans;
>+	struct sk_buff *skb;
>+	size_t total, len;
>+
>+	spin_lock_bh(&vvs->rx_lock);
>+
>+	if (!vvs->msg_count) {
>+		spin_unlock_bh(&vvs->rx_lock);
>+		return 0;
>+	}
>+
>+	total = 0;
>+	len = msg_data_left(msg);
>+
>+	skb_queue_walk(&vvs->rx_queue, skb) {
>+		struct virtio_vsock_hdr *hdr;
>+
>+		if (total < len) {
>+			size_t bytes;
>+			int err;
>+
>+			bytes = len - total;
>+			if (bytes > skb->len)
>+				bytes = skb->len;
>+
>+			spin_unlock_bh(&vvs->rx_lock);
>+
>+			/* sk_lock is held by caller so no one else can dequeue.
>+			 * Unlock rx_lock since memcpy_to_msg() may sleep.
>+			 */
>+			err = memcpy_to_msg(msg, skb->data, bytes);
>+			if (err)
>+				return err;
>+
>+			spin_lock_bh(&vvs->rx_lock);
>+		}
>+
>+		total += skb->len;
>+		hdr = virtio_vsock_hdr(skb);
>+
>+		if (le32_to_cpu(hdr->flags) & VIRTIO_VSOCK_SEQ_EOM) {
>+			if (le32_to_cpu(hdr->flags) & VIRTIO_VSOCK_SEQ_EOR)
>+				msg->msg_flags |= MSG_EOR;
>+
>+			break;
>+		}
>+	}
>+
>+	spin_unlock_bh(&vvs->rx_lock);
>+
>+	return total;
>+}
>+
> static int virtio_transport_seqpacket_do_dequeue(struct vsock_sock *vsk,
> 						 struct msghdr *msg,
> 						 int flags)
>@@ -554,9 +611,9 @@ virtio_transport_seqpacket_dequeue(struct vsock_sock *vsk,
> 				   int flags)
> {
> 	if (flags & MSG_PEEK)
>-		return -EOPNOTSUPP;
>-
>-	return virtio_transport_seqpacket_do_dequeue(vsk, msg, flags);
>+		return virtio_transport_seqpacket_do_peek(vsk, msg);
>+	else
>+		return virtio_transport_seqpacket_do_dequeue(vsk, msg, flags);
> }
> EXPORT_SYMBOL_GPL(virtio_transport_seqpacket_dequeue);
>
>-- 
>2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
