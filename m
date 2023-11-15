Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8447A171A4
	for <virtualization@lists.linux-foundation.org>; Wed, 15 Nov 2023 11:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EGO3VCJH"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 100DE40525
	for <virtualization@lists.linux-foundation.org>; Wed, 15 Nov 2023 11:09:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 100DE40525
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EGO3VCJH
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XgKL_n7BRw9D
	for <virtualization@lists.linux-foundation.org>;
	Wed, 15 Nov 2023 11:09:01 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D8F8A4051A
	for <virtualization@lists.linux-foundation.org>; Wed, 15 Nov 2023 11:09:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D8F8A4051A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700046539;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zDBT66qXHQHw50FZVm9tIKPyXDoNqaIeneC9a2eHcLs=;
	b=EGO3VCJH7mcVtwt1IpNsBvk3L9XPKA9+X7XZQVRBAUp+jSN7Wne7xauXKlmFhKrDScMUe/
	zmxwubgKX0/tI2Yp3K38ljT/8dVX5DT1AaJ4ZnZh3oyaUKDA/HkU0H6bEejY2d4uMsNfeh
	txb7wOPV8A9e5mFne+fquQpX5L9+5QQ=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-gc5kdoXnOTyo3HDRkZVXxA-1; Wed, 15 Nov 2023 06:08:57 -0500
X-MC-Unique: gc5kdoXnOTyo3HDRkZVXxA-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-9d30a6a67abso445031966b.2
        for <virtualization@lists.linux-foundation.org>; Wed, 15 Nov 2023 03:08:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700046536; x=1700651336;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zDBT66qXHQHw50FZVm9tIKPyXDoNqaIeneC9a2eHcLs=;
        b=VBFc82pr/eur5fkIcznccHbL0Rhx6AOyAqx7qB6GJTTEqEsy5Hm0OT2e+c8InpbNN2
         o0WKLYAKKKRi24T1Cuy9Crwt9uihsf2b6ofTd5Us0OUai9OQxZHsCugnRDzQNg1fE+IU
         aJVCqS91TxhtEGfMjrJiwp6+Rmw97vFK+Vge5xc5vUervSHPD4WXEvrHTqBRNnBHd68Q
         DAuM6Y7OnJDRnQ5cmv+TD28OJ8XUC6k3KMpEWf9WCkM8wX2nzkZ351qkbICNdPn5tiH9
         TvFpJTixepqFyuF3VLvL/vUW6QmpvtWqml9dwafMM7jlcqZ2PUJ4I36PwfOFieSPk58K
         SAQA==
X-Gm-Message-State: AOJu0YzF+oEF7VvFtbcp+TDda7BVC3OuF3aJywYWE7BTuBiQLDQufbi5
	3Lh2wLq0zkLYjwKTtUw46Jow6vta/+M7V/8FodQDuxtDpD/KPON7yRvzXc2z1vAbV5/3KhNU2v8
	WX4zP+Dka4CvsDDAYR91E6Pn04AotIsxeBM/D2Og5jA==
X-Received: by 2002:a05:6402:40cb:b0:53f:bb1e:ce39 with SMTP id z11-20020a05640240cb00b0053fbb1ece39mr11478728edb.34.1700046536091;
        Wed, 15 Nov 2023 03:08:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGsq1ynZRIuY+ajEh3UBWfLCL9drgoil/i4ZVS1lkVBo2HzBBwaSNuBLnpqx9eRR/znFXxIrA==
X-Received: by 2002:a05:6402:40cb:b0:53f:bb1e:ce39 with SMTP id z11-20020a05640240cb00b0053fbb1ece39mr11478699edb.34.1700046535589;
        Wed, 15 Nov 2023 03:08:55 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-199.retail.telecomitalia.it. [79.46.200.199])
        by smtp.gmail.com with ESMTPSA id t23-20020a50d717000000b005470cacc4bfsm6357529edi.84.2023.11.15.03.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 03:08:55 -0800 (PST)
Date: Wed, 15 Nov 2023 12:08:52 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@sberdevices.ru, 
	oxffffaa@gmail.com
Subject: Re: [RFC PATCH v1 1/2] virtio/vsock: send credit update during
 setting SO_RCVLOWAT
Message-ID: <6owgy5zo5lmx3w2vsu6ux552olyuq4lnqzrawngc3gmi5fonn6@6emsez7krq7f>
References: <20231108072004.1045669-1-avkrasnov@salutedevices.com>
 <20231108072004.1045669-2-avkrasnov@salutedevices.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20231108072004.1045669-2-avkrasnov@salutedevices.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Wed, Nov 08, 2023 at 10:20:03AM +0300, Arseniy Krasnov wrote:
>This adds sending credit update message when SO_RCVLOWAT is updated and
>it is bigger than number of bytes in rx queue. It is needed, because
>'poll()' will wait until number of bytes in rx queue will be not smaller
>than SO_RCVLOWAT, so kick sender to send more data. Otherwise mutual
>hungup for tx/rx is possible: sender waits for free space and receiver
>is waiting data in 'poll()'.
>
>Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
>---
> drivers/vhost/vsock.c                   |  2 ++
> include/linux/virtio_vsock.h            |  1 +
> net/vmw_vsock/virtio_transport.c        |  2 ++
> net/vmw_vsock/virtio_transport_common.c | 31 +++++++++++++++++++++++++
> net/vmw_vsock/vsock_loopback.c          |  2 ++
> 5 files changed, 38 insertions(+)
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
>index e22c81435ef7..88a58163046e 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -1676,6 +1676,37 @@ int virtio_transport_read_skb(struct vsock_sock *vsk, skb_read_actor_t recv_acto
> }
> EXPORT_SYMBOL_GPL(virtio_transport_read_skb);
>
>+int virtio_transport_set_rcvlowat(struct vsock_sock *vsk, int val)
>+{
>+	struct virtio_vsock_sock *vvs = vsk->trans;
>+	bool send_update = false;

I'd declare this not initialized.

>+
>+	spin_lock_bh(&vvs->rx_lock);
>+
>+	/* If number of available bytes is less than new
>+	 * SO_RCVLOWAT value, kick sender to send more
>+	 * data, because sender may sleep in its 'send()'
>+	 * syscall waiting for enough space at our side.
>+	 */
>+	if (vvs->rx_bytes < val)
>+		send_update = true;

Then here just:
	send_update = vvs->rx_bytes < val;

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
>+	WRITE_ONCE(sk_vsock(vsk)->sk_rcvlowat, val ? : 1);

Not in this patch, but what about doing this in vsock_set_rcvlowat() in 
af_vsock.c?

I mean avoid to return if `transport->set_rcvlowat(vsk, val)` is
successfully, so set sk_rcvlowat in a single point.

The rest LGTM!

Stefano

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
>-- 2.25.1
>

