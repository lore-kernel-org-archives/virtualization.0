Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F84D125C3
	for <virtualization@lists.linux-foundation.org>; Wed, 29 Nov 2023 09:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CBEYAc3g"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6D611613AE
	for <virtualization@lists.linux-foundation.org>; Wed, 29 Nov 2023 09:01:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6D611613AE
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CBEYAc3g
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id T48RoaB2CUAb
	for <virtualization@lists.linux-foundation.org>;
	Wed, 29 Nov 2023 09:01:53 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8D3B760B89
	for <virtualization@lists.linux-foundation.org>; Wed, 29 Nov 2023 09:01:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8D3B760B89
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701248512;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zwc9ieluISalwFh3TyYZ4gcQacsA94sf6qSa2kEUESI=;
	b=CBEYAc3gmLlyBM/98d4pekrgZPBKZIg2CM/IerqtQUVidKwt0zqMX1jUanmFCbRK8ueW+S
	Y5++Hp6PyfET+SvYmLzCxVnzdBxZ8OuHSQE/Gp5f4s/wgG2CRITSjyX1Hzfu3tH0PdTK18
	Lo/5zdyDX4Slfk5FiZ7CFNcmGQetFoE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-7Lf9fSJXOeSUhEPpzRqDJA-1; Wed, 29 Nov 2023 04:01:51 -0500
X-MC-Unique: 7Lf9fSJXOeSUhEPpzRqDJA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-333127fecf9so865400f8f.2
        for <virtualization@lists.linux-foundation.org>; Wed, 29 Nov 2023 01:01:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701248510; x=1701853310;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zwc9ieluISalwFh3TyYZ4gcQacsA94sf6qSa2kEUESI=;
        b=o4T9/NfqFBRAE3IMoWR6lF8ASokwfgRMVf/ccv2RDE13u8UyTYSN5j6rUSYYo+YxZH
         6fQtJynlUrR/gxAW7lT7DIYIGJNN+hyih8tiF2aXuV46c9jU3SO/ktfXLBOa4UHSccao
         p8l8kDEG6FZeo8ovnQa1qgHc2dxPi39yfM2ooG36ertzH2U4TxtFnUHe+KOw8JP/LeXr
         55326ioccOVc8jz7iszbI/mNNhZ4XT+GHkU3mOdAib6wL28lM74MCX+ahaW2rpAAohCE
         u2taCPmjuBfCiwTaTXHBIGknBqexWpWRBcBeYpNuLGUUBlmx6PWInxJJG+MABoDbP87a
         ug7A==
X-Gm-Message-State: AOJu0YwyZgV6N3LFMbRPFKNhc5ef2V69zEPRXZkKzeMujpiF2eNPfhvk
	/wONCCES3WhYWNl5DGDlJuUm8Le/dmpsp9RwZ19G/IAfmxBmR6tzXfmIih9su/xzYjk4v2FZxuH
	ilFNvD8ZHtddfO3PYBZJswiwtSqxBADubH2OME3FPqw==
X-Received: by 2002:adf:b1d5:0:b0:332:c441:70aa with SMTP id r21-20020adfb1d5000000b00332c44170aamr13788915wra.26.1701248509930;
        Wed, 29 Nov 2023 01:01:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFP2F6dczPE089a3r9AZSuxONM+6MsCslUykG0rwB+wpDrF0PpgPS4SUfoLewfpzCdrG2iGkA==
X-Received: by 2002:adf:b1d5:0:b0:332:c441:70aa with SMTP id r21-20020adfb1d5000000b00332c44170aamr13788889wra.26.1701248509534;
        Wed, 29 Nov 2023 01:01:49 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-199.retail.telecomitalia.it. [79.46.200.199])
        by smtp.gmail.com with ESMTPSA id c14-20020a056000104e00b00332f95ab44esm10548348wrx.57.2023.11.29.01.01.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 01:01:48 -0800 (PST)
Date: Wed, 29 Nov 2023 10:01:43 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@sberdevices.ru, 
	oxffffaa@gmail.com
Subject: Re: [RFC PATCH v3 2/3] virtio/vsock: send credit update during
 setting SO_RCVLOWAT
Message-ID: <etuukjyedcdvkdxsql5qquvla6tuaaayph7vj2jdskqjwmkmoy@h2hkgjfyawyi>
References: <20231122180510.2297075-1-avkrasnov@salutedevices.com>
 <20231122180510.2297075-3-avkrasnov@salutedevices.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20231122180510.2297075-3-avkrasnov@salutedevices.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Wed, Nov 22, 2023 at 09:05:09PM +0300, Arseniy Krasnov wrote:
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
>
> drivers/vhost/vsock.c                   |  2 ++
> include/linux/virtio_vsock.h            |  1 +
> net/vmw_vsock/virtio_transport.c        |  2 ++
> net/vmw_vsock/virtio_transport_common.c | 28 +++++++++++++++++++++++++
> net/vmw_vsock/vsock_loopback.c          |  2 ++
> 5 files changed, 35 insertions(+)
>
>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>index f75731396b7e..ecfa5c11f5ee 100644
>--- a/drivers/vhost/vsock.c
>+++ b/drivers/vhost/vsock.c
>@@ -451,6 +451,8 @@ static struct virtio_transport vhost_transport = {
> 		.notify_buffer_size       = virtio_transport_notify_buffer_size,
>
> 		.read_skb = virtio_transport_read_skb,
>+
>+		.set_rcvlowat             = virtio_transport_set_rcvlowat

Since now we don't set it anymore in the callback, what about following
the notify_* callbacks and rename it in `notify_set_rcvlowat`?

Eventually I think we can rename it in the previous patch.

> 	},
>
> 	.send_pkt = vhost_transport_send_pkt,
>diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
>index ebb3ce63d64d..97dc1bebc69c 100644
>--- a/include/linux/virtio_vsock.h
>+++ b/include/linux/virtio_vsock.h
>@@ -256,4 +256,5 @@ void virtio_transport_put_credit(struct virtio_vsock_sock *vvs, u32 credit);
> void virtio_transport_deliver_tap_pkt(struct sk_buff *skb);
> int virtio_transport_purge_skbs(void *vsk, struct sk_buff_head *list);
> int virtio_transport_read_skb(struct vsock_sock *vsk, skb_read_actor_t read_actor);
>+int virtio_transport_set_rcvlowat(struct vsock_sock *vsk, int val);
> #endif /* _LINUX_VIRTIO_VSOCK_H */
>diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>index af5bab1acee1..cf3431189d0c 100644
>--- a/net/vmw_vsock/virtio_transport.c
>+++ b/net/vmw_vsock/virtio_transport.c
>@@ -539,6 +539,8 @@ static struct virtio_transport virtio_transport = {
> 		.notify_buffer_size       = virtio_transport_notify_buffer_size,
>
> 		.read_skb = virtio_transport_read_skb,
>+
>+		.set_rcvlowat             = virtio_transport_set_rcvlowat
> 	},
>
> 	.send_pkt = virtio_transport_send_pkt,
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index f6dc896bf44c..4acee21b4350 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -1684,6 +1684,34 @@ int virtio_transport_read_skb(struct vsock_sock *vsk, skb_read_actor_t recv_acto
> }
> EXPORT_SYMBOL_GPL(virtio_transport_read_skb);
>
>+int virtio_transport_set_rcvlowat(struct vsock_sock *vsk, int val)
>+{
>+	struct virtio_vsock_sock *vvs = vsk->trans;
>+	bool send_update;
>+
>+	spin_lock_bh(&vvs->rx_lock);
>+
>+	/* If number of available bytes is less than new
>+	 * SO_RCVLOWAT value, kick sender to send more
>+	 * data, because sender may sleep in its 'send()'
>+	 * syscall waiting for enough space at our side.
>+	 */

Let's try to use at least the full 80 characters so we can reduce the
lines in this comment block.

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
>+EXPORT_SYMBOL_GPL(virtio_transport_set_rcvlowat);
>+
> MODULE_LICENSE("GPL v2");
> MODULE_AUTHOR("Asias He");
> MODULE_DESCRIPTION("common code for virtio vsock");
>diff --git a/net/vmw_vsock/vsock_loopback.c b/net/vmw_vsock/vsock_loopback.c
>index 048640167411..388c157f6633 100644
>--- a/net/vmw_vsock/vsock_loopback.c
>+++ b/net/vmw_vsock/vsock_loopback.c
>@@ -98,6 +98,8 @@ static struct virtio_transport loopback_transport = {
> 		.notify_buffer_size       = virtio_transport_notify_buffer_size,
>
> 		.read_skb = virtio_transport_read_skb,
>+
>+		.set_rcvlowat             = virtio_transport_set_rcvlowat
> 	},
>
> 	.send_pkt = vsock_loopback_send_pkt,
>-- 
>2.25.1
>

