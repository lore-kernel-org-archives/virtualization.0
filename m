Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99C944374
	for <virtualization@lists.linux.dev>; Fri, 28 Jun 2024 11:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719573399; cv=none; b=cL5e99PBSimbTsXkA19p+Q70mRE1YC9m5OzKkKUw9gaCbQ426CUYHyZFzu4wZmGV4XUgki6YoqIjtrKuqZyJXkwpvcIXZJ9eLZ1OiZ52fVtMtGncYYoQYebt3rfOaISfNr9QqKHISNSonVEc+JNXIDq2ZH4Zx/yYaMQ+/0Erm38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719573399; c=relaxed/simple;
	bh=cB2Lot4axGNas2OU5FTaj1NgaR3at77/54FACPAlKc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=E2DeUh6pnZb9fLLYGzb7fEqAnVVKGzz3T3YBemRuJ58iCTvcrhQpQAkstYf85fTEqRWyT8xa4uwmDtvTPqz8Wg5EJqkoERGKvdNKx6c4Ngo3jPNyE7I5xr7oP096nJWXLLKHxSbjxL8IseqTSzhmHeDbeW54cW1S7ZWAGQNjqC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K3lI5hSS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K3lI5hSS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719573396;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZlGqYCvpxUtS+VdKueIF34H2lavVthiHCNvJIyMxjQk=;
	b=K3lI5hSSLXEx+IjGLGjzOzbYFP9g128BNGV81cDeF46AM5SnTH2B9kAooY/jbUu3sEzpQL
	Aab+e8cI1hzzSUqoJtXkE8xaZ+c1HplWz+ycn/PUGr0nfIXk/HVomHIqIMycznWgeWGgH8
	9nCyYdW+GyEh6HkSRWW5RX6TtBEgV1s=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-41-l5WLCHF_P7ukPDddAD6d9w-1; Fri, 28 Jun 2024 07:16:35 -0400
X-MC-Unique: l5WLCHF_P7ukPDddAD6d9w-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-425643fb4fbso4421075e9.1
        for <virtualization@lists.linux.dev>; Fri, 28 Jun 2024 04:16:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719573392; x=1720178192;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZlGqYCvpxUtS+VdKueIF34H2lavVthiHCNvJIyMxjQk=;
        b=dI+39m60mBdJHY7fAg2khV/KlUW7z3l0IFv0w6EJT3cJQg8DOkmSRiCZzfgcCNKI/x
         v0pEAm4Ajfs14fHN4LXIyhM4iF7JJV5iM8+/opYi02odwhYo4CStouVfWbfctU1mvCTG
         ksW81Ef6kBGePxlPvdOBZcOkgqwt1nzccrYQgKGQC/VK6Uo9vmJNCuZap5DsDHbRB3ot
         SX2ieLVnb2snt7+GHbS4D7GlVosCrgOQD4f4hCcgMRtxttE4rNcHfKlqQY4nXHUG7Z1c
         S+I7u3oWoOkKEQHMu/4tE3tO+Dl62XEWWfSxGoc5Ml/YIhpNWOEJ6AXtOMdxNGXR4kJh
         5//A==
X-Forwarded-Encrypted: i=1; AJvYcCWmb/HRQZg3m5Hb3gIEHl3emx7KIrypFFNimUjsP/+MRDPq+Sbwk5KHXBLsvUSSuYJ0oSGAq4cbuvZQSzd80qZoqb678BegAhCVNcIj/1s=
X-Gm-Message-State: AOJu0YwG7KDR+nQdSWNDdoont12rzDgKKZrgFolLEBsCszoASeC31u6h
	S9xlRdr8ZE+rx4hLfU+VfGD77a/oUfZBuZtrG2cY7kfZy7gb8+RHImahOQ5Vx3Qh1Ph8n4VNC9D
	1b5wrDEhLAAvVagpIfqgaEZaUN1ZPFQuEudBtm2vdqwtbjha8xg5cK3hx4/qh0vTV
X-Received: by 2002:a05:600c:a29f:b0:425:5ea6:236 with SMTP id 5b1f17b1804b1-4255ea60371mr49513975e9.28.1719573391985;
        Fri, 28 Jun 2024 04:16:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEyPwfEwM5GqciNJwTRavZB5JFhzJ9CBQ2fFV7Dql3t6q6MFOInK4WYOf9EpanV+QVZr8fUGw==
X-Received: by 2002:a05:600c:a29f:b0:425:5ea6:236 with SMTP id 5b1f17b1804b1-4255ea60371mr49513745e9.28.1719573391339;
        Fri, 28 Jun 2024 04:16:31 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.134.173])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256b063485sm30356325e9.21.2024.06.28.04.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 04:16:30 -0700 (PDT)
Date: Fri, 28 Jun 2024 13:16:24 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: luigi.leonardi@outlook.com
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org
Subject: Re: [PATCH net-next v3 2/3] vsock/virtio: add SIOCOUTQ support for
 all virtio based transports
Message-ID: <7ejdsieevuooprdaprn2ymqqv5ssd2fntlp6tsodeu6pvnuvue@chzg6ww45bni>
References: <20240626-ioctl_next-v3-0-63be5bf19a40@outlook.com>
 <20240626-ioctl_next-v3-2-63be5bf19a40@outlook.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240626-ioctl_next-v3-2-63be5bf19a40@outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Wed, Jun 26, 2024 at 02:08:36PM GMT, Luigi Leonardi via B4 Relay wrote:
>From: Luigi Leonardi <luigi.leonardi@outlook.com>
>
>Introduce support for stream_bytes_unsent and seqpacket_bytes_unsent
>ioctl for virtio_transport, vhost_vsock and vsock_loopback.
>
>For all transports the unsent bytes counter is incremented
>in virtio_transport_get_credit.
>
>In the virtio_transport (G2H) the counter is decremented each
>time the host notifies the guest that it consumed the skbuffs.
>In vhost-vsock (H2G) the counter is decremented after the skbuff
>is queued in the virtqueue.
>In vsock_loopback the counter is decremented after the skbuff is
>dequeued.
>
>Signed-off-by: Luigi Leonardi <luigi.leonardi@outlook.com>
>---
> drivers/vhost/vsock.c                   |  4 +++-
> include/linux/virtio_vsock.h            |  7 +++++++
> net/vmw_vsock/virtio_transport.c        |  4 +++-
> net/vmw_vsock/virtio_transport_common.c | 35 +++++++++++++++++++++++++++++++++
> net/vmw_vsock/vsock_loopback.c          |  7 +++++++
> 5 files changed, 55 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>index ec20ecff85c7..dba8b3ea37bf 100644
>--- a/drivers/vhost/vsock.c
>+++ b/drivers/vhost/vsock.c
>@@ -244,7 +244,7 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
> 					restart_tx = true;
> 			}
>
>-			consume_skb(skb);
>+			virtio_transport_consume_skb_sent(skb, true);
> 		}
> 	} while(likely(!vhost_exceeds_weight(vq, ++pkts, total_len)));
> 	if (added)
>@@ -451,6 +451,8 @@ static struct virtio_transport vhost_transport = {
> 		.notify_buffer_size       = virtio_transport_notify_buffer_size,
> 		.notify_set_rcvlowat      = virtio_transport_notify_set_rcvlowat,
>
>+		.unsent_bytes             = virtio_transport_bytes_unsent,

The callback is named `unsent_bytes`, I'd use something similar also
in the function name, so `virtio_transport_unsent_bytes`, or the
opposite renaming the callback, as you prefer, but I'd use the same
for both.

>+
> 		.read_skb = virtio_transport_read_skb,
> 	},
>
>diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
>index c82089dee0c8..e74c12878213 100644
>--- a/include/linux/virtio_vsock.h
>+++ b/include/linux/virtio_vsock.h
>@@ -134,6 +134,8 @@ struct virtio_vsock_sock {
> 	u32 peer_fwd_cnt;
> 	u32 peer_buf_alloc;
>

Can you remove this extra empty line, so it's clear that it is
protected by tx_lock?

>+	size_t bytes_unsent;
>+
> 	/* Protected by rx_lock */
> 	u32 fwd_cnt;
> 	u32 last_fwd_cnt;
>@@ -193,6 +195,11 @@ s64 virtio_transport_stream_has_data(struct vsock_sock *vsk);
> s64 virtio_transport_stream_has_space(struct vsock_sock *vsk);
> u32 virtio_transport_seqpacket_has_data(struct vsock_sock *vsk);
>
>+size_t virtio_transport_bytes_unsent(struct vsock_sock *vsk);
>+
>+void virtio_transport_consume_skb_sent(struct sk_buff *skb,
>+				       bool consume);
>+
> int virtio_transport_do_socket_init(struct vsock_sock *vsk,
> 				 struct vsock_sock *psk);
> int
>diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>index 43d405298857..fc62d2818c2c 100644
>--- a/net/vmw_vsock/virtio_transport.c
>+++ b/net/vmw_vsock/virtio_transport.c
>@@ -311,7 +311,7 @@ static void virtio_transport_tx_work(struct work_struct *work)
>
> 		virtqueue_disable_cb(vq);
> 		while ((skb = virtqueue_get_buf(vq, &len)) != NULL) {
>-			consume_skb(skb);
>+			virtio_transport_consume_skb_sent(skb, true);
> 			added = true;
> 		}
> 	} while (!virtqueue_enable_cb(vq));
>@@ -540,6 +540,8 @@ static struct virtio_transport virtio_transport = {
> 		.notify_buffer_size       = virtio_transport_notify_buffer_size,
> 		.notify_set_rcvlowat      = virtio_transport_notify_set_rcvlowat,
>
>+		.unsent_bytes             = virtio_transport_bytes_unsent,
>+
> 		.read_skb = virtio_transport_read_skb,
> 	},
>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 16ff976a86e3..3a7fa36f306b 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -463,6 +463,26 @@ void virtio_transport_inc_tx_pkt(struct virtio_vsock_sock *vvs, struct sk_buff *
> }
> EXPORT_SYMBOL_GPL(virtio_transport_inc_tx_pkt);
>
>+void virtio_transport_consume_skb_sent(struct sk_buff *skb, bool consume)
>+{
>+	struct sock *s = skb->sk;
>+
>+	if (s && skb->len) {
>+		struct vsock_sock *vs = vsock_sk(s);
>+		struct virtio_vsock_sock *vvs;
>+
>+		vvs = vs->trans;
>+
>+		spin_lock_bh(&vvs->tx_lock);
>+		vvs->bytes_unsent -= skb->len;
>+		spin_unlock_bh(&vvs->tx_lock);
>+	}
>+
>+	if (consume)
>+		consume_skb(skb);
>+}
>+EXPORT_SYMBOL_GPL(virtio_transport_consume_skb_sent);
>+
> u32 virtio_transport_get_credit(struct virtio_vsock_sock *vvs, u32 credit)
> {
> 	u32 ret;
>@@ -475,6 +495,7 @@ u32 virtio_transport_get_credit(struct virtio_vsock_sock *vvs, u32 credit)
> 	if (ret > credit)
> 		ret = credit;
> 	vvs->tx_cnt += ret;
>+	vvs->bytes_unsent += ret;
> 	spin_unlock_bh(&vvs->tx_lock);
>
> 	return ret;
>@@ -488,6 +509,7 @@ void virtio_transport_put_credit(struct virtio_vsock_sock *vvs, u32 credit)
>
> 	spin_lock_bh(&vvs->tx_lock);
> 	vvs->tx_cnt -= credit;
>+	vvs->bytes_unsent -= credit;
> 	spin_unlock_bh(&vvs->tx_lock);
> }
> EXPORT_SYMBOL_GPL(virtio_transport_put_credit);
>@@ -1090,6 +1112,19 @@ void virtio_transport_destruct(struct vsock_sock *vsk)
> }
> EXPORT_SYMBOL_GPL(virtio_transport_destruct);
>
>+size_t virtio_transport_bytes_unsent(struct vsock_sock *vsk)
>+{
>+	struct virtio_vsock_sock *vvs = vsk->trans;
>+	size_t ret;
>+
>+	spin_lock_bh(&vvs->tx_lock);
>+	ret = vvs->bytes_unsent;
>+	spin_unlock_bh(&vvs->tx_lock);
>+
>+	return ret;
>+}
>+EXPORT_SYMBOL_GPL(virtio_transport_bytes_unsent);
>+
> static int virtio_transport_reset(struct vsock_sock *vsk,
> 				  struct sk_buff *skb)
> {
>diff --git a/net/vmw_vsock/vsock_loopback.c b/net/vmw_vsock/vsock_loopback.c
>index 6dea6119f5b2..9098613561e3 100644
>--- a/net/vmw_vsock/vsock_loopback.c
>+++ b/net/vmw_vsock/vsock_loopback.c
>@@ -98,6 +98,8 @@ static struct virtio_transport loopback_transport = {
> 		.notify_buffer_size       = virtio_transport_notify_buffer_size,
> 		.notify_set_rcvlowat      = virtio_transport_notify_set_rcvlowat,
>
>+		.unsent_bytes             = virtio_transport_bytes_unsent,
>+
> 		.read_skb = virtio_transport_read_skb,
> 	},
>
>@@ -123,6 +125,11 @@ static void vsock_loopback_work(struct work_struct *work)
> 	spin_unlock_bh(&vsock->pkt_queue.lock);
>
> 	while ((skb = __skb_dequeue(&pkts))) {
>+		/* Decrement the bytes_sent counter without deallocating skb
                                  ^
Should be `bytes_unsent` ?

>+		 * It is freed by the receiver.
>+		 */
>+		virtio_transport_consume_skb_sent(skb, false);
>+

nit: no need for this new empty line.

> 		virtio_transport_deliver_tap_pkt(skb);
> 		virtio_transport_recv_pkt(&loopback_transport, skb);
> 	}
>
>-- 
>2.45.2
>
>
>

