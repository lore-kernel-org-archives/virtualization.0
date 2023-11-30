Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0035347B2
	for <virtualization@lists.linux-foundation.org>; Thu, 30 Nov 2023 08:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DLjkV28t"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 66C34416C7
	for <virtualization@lists.linux-foundation.org>; Thu, 30 Nov 2023 08:39:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 66C34416C7
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DLjkV28t
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LUwmIQd7Z-n8
	for <virtualization@lists.linux-foundation.org>;
	Thu, 30 Nov 2023 08:39:05 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 125F4416B6
	for <virtualization@lists.linux-foundation.org>; Thu, 30 Nov 2023 08:39:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 125F4416B6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701333543;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AuNrzCx4xahsS/7j/jwf4UTh/OtxU2ehfXj/9UH3fEA=;
	b=DLjkV28tpkpl9aK8LMmiTMlbzqGfcv0yU+zLSpe2H9TCyzD7iiw2vpZQAPyiXF6kGkZrZi
	xr3XY8UYswOuSvsCsWtumdehDW+RR4e8SXpcLeZWAKOGZbJ4brzcOxcPc4SORX+G/o9+0/
	zsbdVv+MgXWYDxEJbUt2iPdTbbI+X1Y=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-410-Dt2HdNL8PrmhohokT2qQdA-1; Thu, 30 Nov 2023 03:39:02 -0500
X-MC-Unique: Dt2HdNL8PrmhohokT2qQdA-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2c9b9837ce8so7022831fa.3
        for <virtualization@lists.linux-foundation.org>; Thu, 30 Nov 2023 00:39:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701333541; x=1701938341;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AuNrzCx4xahsS/7j/jwf4UTh/OtxU2ehfXj/9UH3fEA=;
        b=WwllEjvmIVx6JV0lfDSUAe8w2VCX4gjP3hT2SsgNONephE5e0l+vOyDcqbUNBfc1I8
         ymYUsrvjCOX0TLqWyFvLXVvMEZgyeyMlRWv3sIKOpH7lVizPbE38N2GZ00SpQ9mM8zVQ
         tB0EmJxXqKlJqAmFfe7Y7KHml3FEDU0iFDWbhxcM+ztHI+gAnMUv2E6Er51zEOWd/rj5
         XBmIx5TzCeX+0rbk7oyWQ0pYhVuiDFuNxA9Ro12xSGOt+Cz7fDEP+Pq95qmZ95EmnPQz
         RSzqDA0a1jIDidrwEPxGnxiA1j6FGy7Pod05jF9vEwn9st0AxHvKpxA6qvv897fqKP1g
         bByQ==
X-Gm-Message-State: AOJu0Yx4E+sdTeZdA/u448GoNIjhHDO5eMaHghkHzjSn7awTM6IN9y30
	XKOGksZaxT3Ij9efxfGEQOodJOZT6M/lLS2dmNtmTs1HHWc/AT9hhzpIqe0DAUPjz7h9ZnF/K7g
	qEb7vpzAENKsZAqd2NaTX1AKaaV/LhXJ0DPYB/JuDFQ==
X-Received: by 2002:a2e:9954:0:b0:2c9:ba2f:ac73 with SMTP id r20-20020a2e9954000000b002c9ba2fac73mr3934598ljj.16.1701333540785;
        Thu, 30 Nov 2023 00:39:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGqjjOHOs1PQiUSVLZnqTmub+NdORBII7kxiTreMC5zM9NYNdp4AleI9xrrM5E0kPgB2RzjPA==
X-Received: by 2002:a2e:9954:0:b0:2c9:ba2f:ac73 with SMTP id r20-20020a2e9954000000b002c9ba2fac73mr3934567ljj.16.1701333540119;
        Thu, 30 Nov 2023 00:39:00 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-199.retail.telecomitalia.it. [79.46.200.199])
        by smtp.gmail.com with ESMTPSA id v13-20020adfedcd000000b003331bd6f58esm869261wro.69.2023.11.30.00.38.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 00:38:59 -0800 (PST)
Date: Thu, 30 Nov 2023 09:38:54 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@sberdevices.ru, 
	oxffffaa@gmail.com
Subject: Re: [RFC PATCH v4 2/3] virtio/vsock: send credit update during
 setting SO_RCVLOWAT
Message-ID: <cdgg4rtr6t3ez7l7vbgngmeitsmrplwg7vgpebodrxkpouh4yn@yb4aug7zergh>
References: <20231129212519.2938875-1-avkrasnov@salutedevices.com>
 <20231129212519.2938875-3-avkrasnov@salutedevices.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20231129212519.2938875-3-avkrasnov@salutedevices.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Thu, Nov 30, 2023 at 12:25:18AM +0300, Arseniy Krasnov wrote:
>Send credit update message when SO_RCVLOWAT is updated and it is bigger
>than number of bytes in rx queue. It is needed, because 'poll()' will
>wait until number of bytes in rx queue will be not smaller than
>SO_RCVLOWAT, so kick sender to send more data. Otherwise mutual hungup
>for tx/rx is possible: sender waits for free space and receiver is
>waiting data in 'poll()'.
>
>Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
>---
> Changelog:
> v1 -> v2:
>  * Update commit message by removing 'This patch adds XXX' manner.
>  * Do not initialize 'send_update' variable - set it directly during
>    first usage.
> v3 -> v4:
>  * Fit comment in 'virtio_transport_notify_set_rcvlowat()' to 80 chars.
>
> drivers/vhost/vsock.c                   |  3 ++-
> include/linux/virtio_vsock.h            |  1 +
> net/vmw_vsock/virtio_transport.c        |  3 ++-
> net/vmw_vsock/virtio_transport_common.c | 27 +++++++++++++++++++++++++
> net/vmw_vsock/vsock_loopback.c          |  3 ++-
> 5 files changed, 34 insertions(+), 3 deletions(-)
>
>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>index f75731396b7e..c5e58a60a546 100644
>--- a/drivers/vhost/vsock.c
>+++ b/drivers/vhost/vsock.c
>@@ -449,8 +449,9 @@ static struct virtio_transport vhost_transport = {
> 		.notify_send_pre_enqueue  = virtio_transport_notify_send_pre_enqueue,
> 		.notify_send_post_enqueue = virtio_transport_notify_send_post_enqueue,
> 		.notify_buffer_size       = virtio_transport_notify_buffer_size,
>+		.notify_set_rcvlowat      = virtio_transport_notify_set_rcvlowat,
>
>-		.read_skb = virtio_transport_read_skb,
>+		.read_skb = virtio_transport_read_skb

I think it is better to avoid this change, so when we will need to add
new callbacks, we don't need to edit this line again.

Please avoid it also in the other place in this patch.

The rest LGTM.

Thanks,
Stefano

> 	},
>
> 	.send_pkt = vhost_transport_send_pkt,
>diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
>index ebb3ce63d64d..c82089dee0c8 100644
>--- a/include/linux/virtio_vsock.h
>+++ b/include/linux/virtio_vsock.h
>@@ -256,4 +256,5 @@ void virtio_transport_put_credit(struct 
>virtio_vsock_sock *vvs, u32 credit);
> void virtio_transport_deliver_tap_pkt(struct sk_buff *skb);
> int virtio_transport_purge_skbs(void *vsk, struct sk_buff_head *list);
> int virtio_transport_read_skb(struct vsock_sock *vsk, skb_read_actor_t read_actor);
>+int virtio_transport_notify_set_rcvlowat(struct vsock_sock *vsk, int val);
> #endif /* _LINUX_VIRTIO_VSOCK_H */
>diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>index af5bab1acee1..8b7bb7ca8ea5 100644
>--- a/net/vmw_vsock/virtio_transport.c
>+++ b/net/vmw_vsock/virtio_transport.c
>@@ -537,8 +537,9 @@ static struct virtio_transport virtio_transport = {
> 		.notify_send_pre_enqueue  = virtio_transport_notify_send_pre_enqueue,
> 		.notify_send_post_enqueue = virtio_transport_notify_send_post_enqueue,
> 		.notify_buffer_size       = virtio_transport_notify_buffer_size,
>+		.notify_set_rcvlowat      = virtio_transport_notify_set_rcvlowat,
>
>-		.read_skb = virtio_transport_read_skb,
>+		.read_skb = virtio_transport_read_skb
> 	},
>
> 	.send_pkt = virtio_transport_send_pkt,
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index f6dc896bf44c..1cb556ad4597 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -1684,6 +1684,33 @@ int virtio_transport_read_skb(struct vsock_sock 
>*vsk, skb_read_actor_t recv_acto
> }
> EXPORT_SYMBOL_GPL(virtio_transport_read_skb);
>
>+int virtio_transport_notify_set_rcvlowat(struct vsock_sock *vsk, int val)
>+{
>+	struct virtio_vsock_sock *vvs = vsk->trans;
>+	bool send_update;
>+
>+	spin_lock_bh(&vvs->rx_lock);
>+
>+	/* If number of available bytes is less than new SO_RCVLOWAT value,
>+	 * kick sender to send more data, because sender may sleep in its
>+	 * 'send()' syscall waiting for enough space at our side.
>+	 */
>+	send_update = vvs->rx_bytes < val;
>+
>+	spin_unlock_bh(&vvs->rx_lock);
>+
>+	if (send_update) {
>+		int err;
>+
>+		err = virtio_transport_send_credit_update(vsk);
>+		if (err < 0)
>+			return err;
>+	}
>+
>+	return 0;
>+}
>+EXPORT_SYMBOL_GPL(virtio_transport_notify_set_rcvlowat);
>+
> MODULE_LICENSE("GPL v2");
> MODULE_AUTHOR("Asias He");
> MODULE_DESCRIPTION("common code for virtio vsock");
>diff --git a/net/vmw_vsock/vsock_loopback.c b/net/vmw_vsock/vsock_loopback.c
>index 048640167411..454f69838c2a 100644
>--- a/net/vmw_vsock/vsock_loopback.c
>+++ b/net/vmw_vsock/vsock_loopback.c
>@@ -96,8 +96,9 @@ static struct virtio_transport loopback_transport = {
> 		.notify_send_pre_enqueue  = virtio_transport_notify_send_pre_enqueue,
> 		.notify_send_post_enqueue = virtio_transport_notify_send_post_enqueue,
> 		.notify_buffer_size       = virtio_transport_notify_buffer_size,
>+		.notify_set_rcvlowat      = virtio_transport_notify_set_rcvlowat,
>
>-		.read_skb = virtio_transport_read_skb,
>+		.read_skb = virtio_transport_read_skb
> 	},
>
> 	.send_pkt = vsock_loopback_send_pkt,
>-- 
>2.25.1
>

