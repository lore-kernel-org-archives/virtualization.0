Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85339C129
	for <virtualization@lists.linux.dev>; Fri, 14 Jun 2024 14:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718375881; cv=none; b=Z3hB8U1nbB1uE/NhYGawYpEqQdO/zRnBrWr1XXrNjmGrQqMMdeOo22coZtZQiqtWkvrZ3ubxxELuYRnXXjJxFb5ca57DQI79q4HqaH03b99ZfoIzbProWmCjCF80/WM0u0scyC6I+Em/+38jsfdcKElVBGGl8yDbNtHAF+SYJvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718375881; c=relaxed/simple;
	bh=zRcSTM/jhvBjnbHtwwSwnO+RyKYuFmGLajopZybpesk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=MOUzZUH3TNQIb4ufaYdUtFg5//zBmkCpsznFFEAsu2gOnNu9KzeJuwr9VQRL/5yBkD24TunVMwM6kpHlZ2N8v9M/EH9gNKqnagYxcSmq8o9hjkQkSnwPMkYgVHDVSwvBd8JhtISKUjmOq3vJSn16RhfTdMB7GUztEnfFgMveWhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jAlNzZwX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jAlNzZwX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718375878;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ma55eji0wwByhy1PlNAJaDlIbtX5hUNyQUsxW6m6B4Y=;
	b=jAlNzZwXKp7WdgY7JpuABx3B+WONx1gNuVFUcwc7IuMgq7le3q9EKBWTEZxTe5cAI53HbD
	LYTGBJlYx8wlOP1rY+3S2zZTCUZeGDWW1xJxayKV2LQp/ZxxFj5zBWDRqBThRNjvHhmS+W
	bTlx+BVuOWFL7dMwdL+ab6yqc3OY9mQ=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-313-xDBYXJewMq6lSip7JBkEqw-1; Fri, 14 Jun 2024 10:37:56 -0400
X-MC-Unique: xDBYXJewMq6lSip7JBkEqw-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-52c8ddc2ef9so1872251e87.1
        for <virtualization@lists.linux.dev>; Fri, 14 Jun 2024 07:37:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718375875; x=1718980675;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ma55eji0wwByhy1PlNAJaDlIbtX5hUNyQUsxW6m6B4Y=;
        b=NUdf6qCFoJIqhQqb5bnkeNqA5nwpMZAbYWgU01UHrEt0fYKumVgvrb/OviTDyvv1z4
         363NnJUMk1M9PZn50tbewPvbdwdV4m/7gpptUBVfFZWR0UCVW3QXME4YZEfzRN8YGQna
         R5jkPOibPHMYpMAu1Fp1QgTKA/5nEFW8saNWXIROfCKHH6tpnOGrw7W+vR8NWiw56R/s
         0kPLjQITiarWbKIO6i5W5/3grNEMdvIu4O2vP1c/+Q0HvH2RVgsIbeZg6pphQV3fZu6s
         i4e0CY7altxj0ttdOz2D0tynZ4PdywCi/xJkC2PL61jQMOu+iLrOZSe0pfdYYAFx3KXo
         17Lg==
X-Forwarded-Encrypted: i=1; AJvYcCXaE4ULwkqzQZit5u55zluw48HXbRji91K3wuo9WHMQtpcvq+Djo2o5AEb1MwpLb/aG+/insrtpHrRA4Gpmg6+LAzrEvJOaHl1LgqD1vfY=
X-Gm-Message-State: AOJu0Yy8dyP5QzX77b/MvUnig0ASufEcXr70p53PJrED9FUPAMjirkAp
	smPw9Ehy2Cz79wqs7+2ea9bkehXScpXz0KAT3VDYBX93V1PlIn2N839oVn3QIbOM02HhbRzoVs1
	jkk+QY/z8SUQ2ALKV77yJId+30cuAB7rOhY6lb99roPy6Sg63IwRE6Atmb5GhaI/D
X-Received: by 2002:a05:6512:1386:b0:52c:823f:2a10 with SMTP id 2adb3069b0e04-52ca6e56edfmr2747329e87.1.1718375875237;
        Fri, 14 Jun 2024 07:37:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFak61X5Q4K8Fy3vqgh4FnlQ8USF63/URwCi1pVyOdl1kZeb7CjFn+k73mvZyYTw9AmJzOfKQ==
X-Received: by 2002:a05:6512:1386:b0:52c:823f:2a10 with SMTP id 2adb3069b0e04-52ca6e56edfmr2747312e87.1.1718375874854;
        Fri, 14 Jun 2024 07:37:54 -0700 (PDT)
Received: from sgarzare-redhat ([147.229.117.1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56da4486sm191157266b.1.2024.06.14.07.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 07:37:54 -0700 (PDT)
Date: Fri, 14 Jun 2024 16:37:51 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Luigi Leonardi <luigi.leonardi@outlook.com>
Cc: edumazet@google.com, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, kuba@kernel.org, kvm@vger.kernel.org, stefanha@redhat.com, 
	pabeni@redhat.com, davem@davemloft.net, Marco Pinna <marco.pinn95@gmail.com>
Subject: Re: [PATCH net-next 2/2] vsock/virtio: avoid enqueue packets when
 work queue is empty
Message-ID: <2ytwqkmnmp3ebdnhioevunpkyfe5nh2lcpitzggqeu4ptao7ry@ivxkicurl5ft>
References: <20240614135543.31515-1-luigi.leonardi@outlook.com>
 <AS2P194MB21706E349197C1466937052C9AC22@AS2P194MB2170.EURP194.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <AS2P194MB21706E349197C1466937052C9AC22@AS2P194MB2170.EURP194.PROD.OUTLOOK.COM>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Fri, Jun 14, 2024 at 03:55:43PM GMT, Luigi Leonardi wrote:
>From: Marco Pinna <marco.pinn95@gmail.com>
>
>This introduces an optimization in virtio_transport_send_pkt:
>when the work queue (send_pkt_queue) is empty the packet is
>put directly in the virtqueue reducing latency.
>
>In the following benchmark (pingpong mode) the host sends
>a payload to the guest and waits for the same payload back.
>
>Tool: Fio version 3.37-56
>Env: Phys host + L1 Guest
>Payload: 4k
>Runtime-per-test: 50s
>Mode: pingpong (h-g-h)
>Test runs: 50
>Type: SOCK_STREAM
>
>Before (Linux 6.8.11)
>------
>mean(1st percentile):     722.45 ns
>mean(overall):           1686.23 ns
>mean(99th percentile):  35379.27 ns
>
>After
>------
>mean(1st percentile):     602.62 ns
>mean(overall):           1248.83 ns
>mean(99th percentile):  17557.33 ns

Cool, thanks for this improvement!
Can you also report your host CPU detail?

>
>Co-developed-by: Luigi Leonardi <luigi.leonardi@outlook.com>
>Signed-off-by: Luigi Leonardi <luigi.leonardi@outlook.com>
>Signed-off-by: Marco Pinna <marco.pinn95@gmail.com>
>---
> net/vmw_vsock/virtio_transport.c | 32 ++++++++++++++++++++++++++++++--
> 1 file changed, 30 insertions(+), 2 deletions(-)
>
>diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>index c930235ecaec..e89bf87282b2 100644
>--- a/net/vmw_vsock/virtio_transport.c
>+++ b/net/vmw_vsock/virtio_transport.c
>@@ -214,7 +214,9 @@ virtio_transport_send_pkt(struct sk_buff *skb)
> {
> 	struct virtio_vsock_hdr *hdr;
> 	struct virtio_vsock *vsock;
>+	bool use_worker = true;
> 	int len = skb->len;
>+	int ret = -1;

Please define ret in the block we use it. Also, we don't need to initialize it.

>
> 	hdr = virtio_vsock_hdr(skb);
>
>@@ -235,8 +237,34 @@ virtio_transport_send_pkt(struct sk_buff *skb)
> 	if (virtio_vsock_skb_reply(skb))
> 		atomic_inc(&vsock->queued_replies);
>
>-	virtio_vsock_skb_queue_tail(&vsock->send_pkt_queue, skb);
>-	queue_work(virtio_vsock_workqueue, &vsock->send_pkt_work);
>+	/* If the send_pkt_queue is empty there is no need to enqueue the packet.

We should clarify which queue. I mean we are always queueing the packet
somewhere, or in the internal queue for the worker or in the virtqueue,
so this comment is not really clear.

>+	 * Just put it on the ringbuff using virtio_transport_send_skb.

ringbuff? Do you mean virtqueue?

>+	 */
>+

we can avoid this empty line.

>+	if (skb_queue_empty_lockless(&vsock->send_pkt_queue)) {
>+		bool restart_rx = false;
>+		struct virtqueue *vq;

... `int ret;` here.

>+
>+		mutex_lock(&vsock->tx_lock);
>+
>+		vq = vsock->vqs[VSOCK_VQ_TX];
>+
>+		ret = virtio_transport_send_skb(skb, vq, vsock, &restart_rx);

Ah, at the end we don't need `ret` at all.

What about just `if (!virtio_transport_send_skb())`?

>+		if (ret == 0) {
>+			use_worker = false;
>+			virtqueue_kick(vq);
>+		}
>+
>+		mutex_unlock(&vsock->tx_lock);
>+
>+		if (restart_rx)
>+			queue_work(virtio_vsock_workqueue, &vsock->rx_work);
>+	}
>+
>+	if (use_worker) {
>+		virtio_vsock_skb_queue_tail(&vsock->send_pkt_queue, skb);
>+		queue_work(virtio_vsock_workqueue, &vsock->send_pkt_work);
>+	}
>
> out_rcu:
> 	rcu_read_unlock();
>-- 
>2.45.2
>

