Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603FA1A76C1
	for <virtualization@lists.linux.dev>; Wed, 31 Jul 2024 07:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722411603; cv=none; b=h0xIMdv36FRkBCrOx9gRXBN7R4rbBVh5D0QsIA2xxzHy5zwpYVbtGW8lksNQYi+r/Q1YP1DVqFIIdX73t0HD2j2BeltontZeFV8DcNN/zgharHUheOu+mzFczU6LqBUBuelvFBSVIgoanvKtXHIygN23ySfoXMee0HqyUthEE58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722411603; c=relaxed/simple;
	bh=BaxCt27OZsHcMWoUAgXJmK2Vffoa7dbbJn3AJYpv87s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=myuV+MPyZlZUgpikncc+1XBrYJhJdFb1DhFw4hSBKvUdGQgEqsTPGsTm97RF8hEFVgDbRzMWd+X63R3lcgyubuYfXOiBiKtLEB6tt5RpEc78PZjrXed6+CTVAD2tjdJBB+wd+JYs6Qu91h4oMle7IkgKRPzDdS0RR6plZKgJIs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S1Dc/DDP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S1Dc/DDP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722411600;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BHg5YCh5BA7hqCWyo1rRiqsfxT+DXFPGHFeuupOZS4M=;
	b=S1Dc/DDPXRar//2tmceqEJUqj6JqWl8hk+F12JHQ8hbkeYHG4toNImdk1pVYt4HhzY4Dao
	TLxOXmuR7tdn2jqalt4m9KkSTLuhCuBReNkEVJ23ayWVlo9T/yY7Z++fiqANsXYh+8qJKK
	XnFDKKJX6pxJiEdElbsZcP8wFouWmiY=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-210-J4M56yl4OUmpwJXwCQl0RQ-1; Wed, 31 Jul 2024 03:39:57 -0400
X-MC-Unique: J4M56yl4OUmpwJXwCQl0RQ-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2ef2a44c3dfso45369441fa.1
        for <virtualization@lists.linux.dev>; Wed, 31 Jul 2024 00:39:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722411596; x=1723016396;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BHg5YCh5BA7hqCWyo1rRiqsfxT+DXFPGHFeuupOZS4M=;
        b=CQ+5nLq/9ThvnBeQZHLw2ic6JQOt58Es79fGTeHZ4Bx4XFpPjU4Zli2lj+yTL1opLd
         o0InW9AXl8N0xRljF0HKqxXjDoqrpA9kxaCIhm896LfJADqTpO+Hwk7IfRm3HO+tA/fR
         25vRgHgSie8JqzbG2EqOVXSnQYF6f/V+NminK8ax9v9g4iGQQRN0AiYvE2RmkcEBaMDY
         UnLKcaRKu3Rtppyk6v5qhNKUAROJRVekjtb522trX+ducOaCt/P1etTvQ0Bb10WVQ6Cl
         GzwMN1K95Y6RYHiTYqq5cw53f9U99QHjsktBoj1N5bdK8YVpNWbC9HHvxms9RwFA0iij
         71Rg==
X-Forwarded-Encrypted: i=1; AJvYcCU+heTA9qi9KMLzlrJ1tCj+ssHIQgPuzqvTaW/SIRuagFuROtxyribxun1l+aDzQ7+bT958IM9dgpJ0v2+zQiSc2lTqH2qnR0qngOzJ1CQ=
X-Gm-Message-State: AOJu0Yw7FymYV5oHSWX/sV1o52yt3Pe+1URmoCoZrV1uFTiIKPYXrPc3
	kWL/CFpNjkgr8pNbpy2T0v6amLOjfPoWFJ9lQ0U926RD32BLb2j9Fke7MBG7hmU/Ia1kb4zX4YE
	rv3RZzFKGviK5d8vD/x4N6t7HS/YsD6tJ9ij3VkPQnyGonUCroNe3VZ0vJ8yT0ZF+
X-Received: by 2002:a2e:9687:0:b0:2ef:23ec:9357 with SMTP id 38308e7fff4ca-2f12ea9b35bmr88693031fa.0.1722411596255;
        Wed, 31 Jul 2024 00:39:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQrkoDxw+l0VIlIR0+Qgk+955MiL63klXTLU5DFu/vj4R5NQt4RkfZvM7Q37gJtl9EWRqz2w==
X-Received: by 2002:a2e:9687:0:b0:2ef:23ec:9357 with SMTP id 38308e7fff4ca-2f12ea9b35bmr88692741fa.0.1722411595293;
        Wed, 31 Jul 2024 00:39:55 -0700 (PDT)
Received: from sgarzare-redhat (host-82-57-51-79.retail.telecomitalia.it. [82.57.51.79])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282bb6403bsm10938855e9.35.2024.07.31.00.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 00:39:54 -0700 (PDT)
Date: Wed, 31 Jul 2024 09:39:50 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: luigi.leonardi@outlook.com
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Marco Pinna <marco.pinn95@gmail.com>
Subject: Re: [PATCH net-next v4 2/2] vsock/virtio: avoid queuing packets when
 intermediate queue is empty
Message-ID: <yrw4u5lwsiovb36i2vhc7qtwcai2us5uoqhb5zpabfqgxp267g@nmqtvj4oqndc>
References: <20240730-pinna-v4-0-5c9179164db5@outlook.com>
 <20240730-pinna-v4-2-5c9179164db5@outlook.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240730-pinna-v4-2-5c9179164db5@outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, Jul 30, 2024 at 09:47:32PM GMT, Luigi Leonardi via B4 Relay wrote:
>From: Luigi Leonardi <luigi.leonardi@outlook.com>
>
>When the driver needs to send new packets to the device, it always
>queues the new sk_buffs into an intermediate queue (send_pkt_queue)
>and schedules a worker (send_pkt_work) to then queue them into the
>virtqueue exposed to the device.
>
>This increases the chance of batching, but also introduces a lot of
>latency into the communication. So we can optimize this path by
>adding a fast path to be taken when there is no element in the
>intermediate queue, there is space available in the virtqueue,
>and no other process that is sending packets (tx_lock held).
>
>The following benchmarks were run to check improvements in latency and
>throughput. The test bed is a host with Intel i7-10700KF CPU @ 3.80GHz
>and L1 guest running on QEMU/KVM with vhost process and all vCPUs
>pinned individually to pCPUs.
>
>- Latency
>   Tool: Fio version 3.37-56
>   Mode: pingpong (h-g-h)
>   Test runs: 50
>   Runtime-per-test: 50s
>   Type: SOCK_STREAM
>
>In the following fio benchmark (pingpong mode) the host sends
>a payload to the guest and waits for the same payload back.
>
>fio process pinned both inside the host and the guest system.
>
>Before: Linux 6.9.8
>
>Payload 64B:
>
>	1st perc.	overall		99th perc.
>Before	12.91		16.78		42.24		us
>After	9.77		13.57		39.17		us
>
>Payload 512B:
>
>	1st perc.	overall		99th perc.
>Before	13.35		17.35		41.52		us
>After	10.25		14.11		39.58		us
>
>Payload 4K:
>
>	1st perc.	overall		99th perc.
>Before	14.71		19.87		41.52		us
>After	10.51		14.96		40.81		us
>
>- Throughput
>   Tool: iperf-vsock
>
>The size represents the buffer length (-l) to read/write
>P represents the number of parallel streams
>
>P=1
>	4K	64K	128K
>Before	6.87	29.3	29.5 Gb/s
>After	10.5	39.4	39.9 Gb/s
>
>P=2
>	4K	64K	128K
>Before	10.5	32.8	33.2 Gb/s
>After	17.8	47.7	48.5 Gb/s
>
>P=4
>	4K	64K	128K
>Before	12.7	33.6	34.2 Gb/s
>After	16.9	48.1	50.5 Gb/s

Great improvement! Thanks again for this work!

>
>The performance improvement is related to this optimization,
>I used a ebpf kretprobe on virtio_transport_send_skb to check
>that each packet was sent directly to the virtqueue
>
>Co-developed-by: Marco Pinna <marco.pinn95@gmail.com>
>Signed-off-by: Marco Pinna <marco.pinn95@gmail.com>
>Signed-off-by: Luigi Leonardi <luigi.leonardi@outlook.com>
>---
> net/vmw_vsock/virtio_transport.c | 39 +++++++++++++++++++++++++++++++++++----
> 1 file changed, 35 insertions(+), 4 deletions(-)

All my comments have been resolved. I let iperf run bidirectionally for 
a long time and saw no problems, so:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>


>
>diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>index f641e906f351..f992f9a216f0 100644
>--- a/net/vmw_vsock/virtio_transport.c
>+++ b/net/vmw_vsock/virtio_transport.c
>@@ -208,6 +208,28 @@ virtio_transport_send_pkt_work(struct work_struct *work)
> 		queue_work(virtio_vsock_workqueue, &vsock->rx_work);
> }
>
>+/* Caller need to hold RCU for vsock.
>+ * Returns 0 if the packet is successfully put on the vq.
>+ */
>+static int virtio_transport_send_skb_fast_path(struct virtio_vsock *vsock, struct sk_buff *skb)
>+{
>+	struct virtqueue *vq = vsock->vqs[VSOCK_VQ_TX];
>+	int ret;
>+
>+	/* Inside RCU, can't sleep! */
>+	ret = mutex_trylock(&vsock->tx_lock);
>+	if (unlikely(ret == 0))
>+		return -EBUSY;
>+
>+	ret = virtio_transport_send_skb(skb, vq, vsock);
>+	if (ret == 0)
>+		virtqueue_kick(vq);
>+
>+	mutex_unlock(&vsock->tx_lock);
>+
>+	return ret;
>+}
>+
> static int
> virtio_transport_send_pkt(struct sk_buff *skb)
> {
>@@ -231,11 +253,20 @@ virtio_transport_send_pkt(struct sk_buff *skb)
> 		goto out_rcu;
> 	}
>
>-	if (virtio_vsock_skb_reply(skb))
>-		atomic_inc(&vsock->queued_replies);
>+	/* If send_pkt_queue is empty, we can safely bypass this queue
>+	 * because packet order is maintained and (try) to put the packet
>+	 * on the virtqueue using virtio_transport_send_skb_fast_path.
>+	 * If this fails we simply put the packet on the intermediate
>+	 * queue and schedule the worker.
>+	 */
>+	if (!skb_queue_empty_lockless(&vsock->send_pkt_queue) ||
>+	    virtio_transport_send_skb_fast_path(vsock, skb)) {
>+		if (virtio_vsock_skb_reply(skb))
>+			atomic_inc(&vsock->queued_replies);
>
>-	virtio_vsock_skb_queue_tail(&vsock->send_pkt_queue, skb);
>-	queue_work(virtio_vsock_workqueue, &vsock->send_pkt_work);
>+		virtio_vsock_skb_queue_tail(&vsock->send_pkt_queue, skb);
>+		queue_work(virtio_vsock_workqueue, &vsock->send_pkt_work);
>+	}
>
> out_rcu:
> 	rcu_read_unlock();
>
>-- 
>2.45.2
>
>

