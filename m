Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328362417E6
	for <virtualization@lists.linux.dev>; Thu,  3 Apr 2025 08:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743668683; cv=none; b=Z3zB4QnCgxPWfD8szidwhuziEEG3NejjvHU3eh4fS3zQ+mwsub3ps6v2lZIfHF0DPQtpl9G/HBJ7WIft8FXFWH0XpZeHF0yIaQbOTJ53SKEUpvs4nT2CzrtZRYaOaKhAlbR5yVPZ6L2Z3WLZ3OEMkJ4XDmYRhWIJ1cdbOmOD7zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743668683; c=relaxed/simple;
	bh=bqXLdyehYUYa7iugMoNsDrU5wqyxF2kAUPh12MXOU8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=UYlZtYQ8f3kTURGQTPDPQ5R6lThaTj5qmemNggduFdBaswPfQ11glwfxgGGdw9+MXmxiCsm/b/1ViSMamjBsD/y7y+pq5JGvMQJznmaj+KfxeQAwYrlLvCFBfcriqXx+sAn1AUMRV+b8fuYKh52MmMibHNzdve8N5U2YcpEiKP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h0Io82Sr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h0Io82Sr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743668680;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4QfRiYe5GXVmwZ4tJaWZHVzY2m09t34SISzB5r0Dv9k=;
	b=h0Io82Srk7VjmcF7R8ge8GrA3XvdrZcwX+EYkQFsWLHuG5EZPo+7VF3oJLG2Cax9w5D9FI
	5D5xmj8Be0MfSdM8ey8GcfakVkUI9GMtNL+/SHO3PPtvdKJxZ7pLfnJ4Jx650IVbzErdyW
	F90iuksBBYItoAvWfJQKHvw788Kjiao=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-NVXaDBBuPfSRJZJGtk3fcA-1; Thu, 03 Apr 2025 04:24:39 -0400
X-MC-Unique: NVXaDBBuPfSRJZJGtk3fcA-1
X-Mimecast-MFC-AGG-ID: NVXaDBBuPfSRJZJGtk3fcA_1743668677
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43d0a037f97so3464375e9.2
        for <virtualization@lists.linux.dev>; Thu, 03 Apr 2025 01:24:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743668677; x=1744273477;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4QfRiYe5GXVmwZ4tJaWZHVzY2m09t34SISzB5r0Dv9k=;
        b=P8z2762p2gFZffICx0zhaSN/TFiglvKahLhnC+PpH9lpMXW95qGjw+R8g16YntTN4v
         JT9eWqwacAnc91l280dwUdj6X1t4HtcnSQsRvGTnEC+tzKk+jbsr9r1yIyqV32BBM0yL
         wnMB8PuX7PLMOJC6Ln206jpRG4z+YK1hhBQJcd3ueve8b9hbN6f+ymUfb0j5oLhciB0e
         9RfolV5M0q6nOv5YwDdNdmbRnaW/s3W+uFoOHAv9cwP+9PLLdDPzD3/5X4qiyXcfWB4f
         FFsrtoBXH0s8CcM1Zuy5DEm2iPR1G+TrlvVry9Ne3r3Q7PmU9FkkVFzSUjCcGdtMQB3t
         Fppg==
X-Forwarded-Encrypted: i=1; AJvYcCWschqlBsrhmR9bD/AzuWtTA+tHu+IMEFJptyFkOBNEFHLYzMXtqOKpPCNtcTWwACBxfbDTvuzZ3mD/6QlRgg==@lists.linux.dev
X-Gm-Message-State: AOJu0YylEQXtyzPDHHrDc8/EaT/RevjbMYIblfZEyEenIkgwUvNHHLMI
	OSKdBgSgT53XgKvHIBX+6ACSawokDnVxIi6qEg9Gx886CbDtcj+DK+4iTb6IbbgUGg1d8wLfr4l
	xchsq1rqIs/6K5ctjgMK0yI9VHUaJpXfQfiKhNIiaAQT/qmuToXSMeNzxKfYl/UZKjYlx9CRquh
	0=
X-Gm-Gg: ASbGncsyGJnHvpcYlbjjNx/q51LGg0Tbn010jAsnjYYYwVRTzih9dLuf4SKoFY3HR+F
	Q2Uzd8ArfMXIiyB20yGJh6jO5z071slK2DVtlQJAjYxE9dpA/LSzscHZtnbzePYlHUWEPCaQX+7
	8dd9ccBFc4OkC5jduRqPgsHQyCowtPlervAefqmVs+nUp8WvAPigaSD3WAqRYKY53mXObRiWhs3
	s2MXy7cWplq0r0keY6rRbeWzMwoQt/bJ1BVLXKn7GirATEe6rDNF14n7MOjeDdZm/FXCbAenca+
	Z7MtMlhDiikopElWDQnCj5LplXcZruRco68SZUhO4J6ZEpA/HSgQ/vfgyyE=
X-Received: by 2002:a05:6000:4383:b0:39c:1404:312f with SMTP id ffacd0b85a97d-39c2f8c6371mr1428512f8f.1.1743668676614;
        Thu, 03 Apr 2025 01:24:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFEAZGAoNM13vK521/2jz+2sSbIX6WGto477kdtw5LD+g4dYvVQaOt1ETkS34SAS4HIRNgFdw==
X-Received: by 2002:a05:6000:4383:b0:39c:1404:312f with SMTP id ffacd0b85a97d-39c2f8c6371mr1428477f8f.1.1743668676004;
        Thu, 03 Apr 2025 01:24:36 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-59.retail.telecomitalia.it. [87.11.6.59])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec163107csm14698525e9.3.2025.04.03.01.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 01:24:35 -0700 (PDT)
Date: Thu, 3 Apr 2025 10:24:30 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, 
	Alexander Graf <graf@amazon.com>, "Michael S . Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux.dev, kvm@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
	Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	"David S . Miller" <davem@davemloft.net>, nh-open-source@amazon.com
Subject: Re: [PATCH v2] vsock/virtio: Remove queued_replies pushback logic
Message-ID: <5l2xvaamvvoayrz3vlof4rarp5hkeig5sljhsqzypo6xx4fcip@3bhjnwe5g7ha>
References: <20250401201349.23867-1-graf@amazon.com>
 <20250402161424.GA305204@fedora>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250402161424.GA305204@fedora>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: bTZO0QV2rK7k8Q0cUfxmtqTjY9oJBt8WZQy0WwEfHzw_1743668677
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Wed, Apr 02, 2025 at 12:14:24PM -0400, Stefan Hajnoczi wrote:
>On Tue, Apr 01, 2025 at 08:13:49PM +0000, Alexander Graf wrote:
>> Ever since the introduction of the virtio vsock driver, it included
>> pushback logic that blocks it from taking any new RX packets until the
>> TX queue backlog becomes shallower than the virtqueue size.
>>
>> This logic works fine when you connect a user space application on the
>> hypervisor with a virtio-vsock target, because the guest will stop
>> receiving data until the host pulled all outstanding data from the VM.
>>
>> With Nitro Enclaves however, we connect 2 VMs directly via vsock:
>>
>>   Parent      Enclave
>>
>>     RX -------- TX
>>     TX -------- RX
>>
>> This means we now have 2 virtio-vsock backends that both have the pushback
>> logic. If the parent's TX queue runs full at the same time as the
>> Enclave's, both virtio-vsock drivers fall into the pushback path and
>> no longer accept RX traffic. However, that RX traffic is TX traffic on
>> the other side which blocks that driver from making any forward
>> progress. We're now in a deadlock.
>>
>> To resolve this, let's remove that pushback logic altogether and rely on
>> higher levels (like credits) to ensure we do not consume unbounded
>> memory.
>
>The reason for queued_replies is that rx packet processing may emit tx
>packets. Therefore tx virtqueue space is required in order to process
>the rx virtqueue.
>
>queued_replies puts a bound on the amount of tx packets that can be
>queued in memory so the other side cannot consume unlimited memory. Once
>that bound has been reached, rx processing stops until the other side
>frees up tx virtqueue space.
>
>It's been a while since I looked at this problem, so I don't have a
>solution ready. In fact, last time I thought about it I wondered if the
>design of virtio-vsock fundamentally suffers from deadlocks.
>
>I don't think removing queued_replies is possible without a replacement
>for the bounded memory and virtqueue exhaustion issue though. Credits
>are not a solution - they are about socket buffer space, not about
>virtqueue space, which includes control packets that are not accounted
>by socket buffer space.

This is a very good point that I missed, I need to add a comment in the 
code to explain it, because it wasn't clear to me! Thank you very much 
Stefan!

So, IIUC, with this patch, a host or a sibling VM (e.g.  enclave, 
parent), can flood the VM with requests like VIRTIO_VSOCK_OP_REQUEST 
(even for example with a random port that is not open) that require a 
response. If the peer that is sending the requests, using the RX 
virtqueue, does not consume the TX virtqueue, it easily causes a 
consumption of all the memory on the other peer, which initially starts 
filling up the TX virtqueue, but when it becomes full starts using the 
internal queue indiscriminately.

I agree, if we want to get rid of queued_replies, we should find some 
other way to avoid this. So far I can't think of anything other than to 
stop the consumption of the virtqueue and wait for the other peer to 
consume the other one.

Any other ideas?

Thanks,
Stefano


>
>>
>> RX and TX queues share the same work queue. To prevent starvation of TX
>> by an RX flood and vice versa now that the pushback logic is gone, let's
>> deliberately reschedule RX and TX work after a fixed threshold (256) of
>> packets to process.
>>
>> Fixes: 0ea9e1d3a9e3 ("VSOCK: Introduce virtio_transport.ko")
>> Signed-off-by: Alexander Graf <graf@amazon.com>
>> ---
>>  net/vmw_vsock/virtio_transport.c | 70 +++++++++-----------------------
>>  1 file changed, 19 insertions(+), 51 deletions(-)
>>
>> diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>> index f0e48e6911fc..54030c729767 100644
>> --- a/net/vmw_vsock/virtio_transport.c
>> +++ b/net/vmw_vsock/virtio_transport.c
>> @@ -26,6 +26,12 @@ static struct virtio_vsock __rcu *the_virtio_vsock;
>>  static DEFINE_MUTEX(the_virtio_vsock_mutex); /* protects the_virtio_vsock */
>>  static struct virtio_transport virtio_transport; /* forward declaration */
>>
>> +/*
>> + * Max number of RX packets transferred before requeueing so we do
>> + * not starve TX traffic because they share the same work queue.
>> + */
>> +#define VSOCK_MAX_PKTS_PER_WORK 256
>> +
>>  struct virtio_vsock {
>>  	struct virtio_device *vdev;
>>  	struct virtqueue *vqs[VSOCK_VQ_MAX];
>> @@ -44,8 +50,6 @@ struct virtio_vsock {
>>  	struct work_struct send_pkt_work;
>>  	struct sk_buff_head send_pkt_queue;
>>
>> -	atomic_t queued_replies;
>> -
>>  	/* The following fields are protected by rx_lock.  vqs[VSOCK_VQ_RX]
>>  	 * must be accessed with rx_lock held.
>>  	 */
>> @@ -158,7 +162,7 @@ virtio_transport_send_pkt_work(struct work_struct *work)
>>  		container_of(work, struct virtio_vsock, send_pkt_work);
>>  	struct virtqueue *vq;
>>  	bool added = false;
>> -	bool restart_rx = false;
>> +	int pkts = 0;
>>
>>  	mutex_lock(&vsock->tx_lock);
>>
>> @@ -172,6 +176,12 @@ virtio_transport_send_pkt_work(struct work_struct *work)
>>  		bool reply;
>>  		int ret;
>>
>> +		if (++pkts > VSOCK_MAX_PKTS_PER_WORK) {
>> +			/* Allow other works on the same queue to run */
>> +			queue_work(virtio_vsock_workqueue, work);
>> +			break;
>> +		}
>> +
>>  		skb = virtio_vsock_skb_dequeue(&vsock->send_pkt_queue);
>>  		if (!skb)
>>  			break;
>> @@ -184,17 +194,6 @@ virtio_transport_send_pkt_work(struct work_struct *work)
>>  			break;
>>  		}
>>
>> -		if (reply) {
>> -			struct virtqueue *rx_vq = vsock->vqs[VSOCK_VQ_RX];
>> -			int val;
>> -
>> -			val = atomic_dec_return(&vsock->queued_replies);
>> -
>> -			/* Do we now have resources to resume rx processing? */
>> -			if (val + 1 == virtqueue_get_vring_size(rx_vq))
>> -				restart_rx = true;
>> -		}
>> -
>>  		added = true;
>>  	}
>>
>> @@ -203,9 +202,6 @@ virtio_transport_send_pkt_work(struct work_struct *work)
>>
>>  out:
>>  	mutex_unlock(&vsock->tx_lock);
>> -
>> -	if (restart_rx)
>> -		queue_work(virtio_vsock_workqueue, &vsock->rx_work);
>>  }
>>
>>  /* Caller need to hold RCU for vsock.
>> @@ -261,9 +257,6 @@ virtio_transport_send_pkt(struct sk_buff *skb)
>>  	 */
>>  	if (!skb_queue_empty_lockless(&vsock->send_pkt_queue) ||
>>  	    virtio_transport_send_skb_fast_path(vsock, skb)) {
>> -		if (virtio_vsock_skb_reply(skb))
>> -			atomic_inc(&vsock->queued_replies);
>> -
>>  		virtio_vsock_skb_queue_tail(&vsock->send_pkt_queue, skb);
>>  		queue_work(virtio_vsock_workqueue, &vsock->send_pkt_work);
>>  	}
>> @@ -277,7 +270,7 @@ static int
>>  virtio_transport_cancel_pkt(struct vsock_sock *vsk)
>>  {
>>  	struct virtio_vsock *vsock;
>> -	int cnt = 0, ret;
>> +	int ret;
>>
>>  	rcu_read_lock();
>>  	vsock = rcu_dereference(the_virtio_vsock);
>> @@ -286,17 +279,7 @@ virtio_transport_cancel_pkt(struct vsock_sock *vsk)
>>  		goto out_rcu;
>>  	}
>>
>> -	cnt = virtio_transport_purge_skbs(vsk, &vsock->send_pkt_queue);
>> -
>> -	if (cnt) {
>> -		struct virtqueue *rx_vq = vsock->vqs[VSOCK_VQ_RX];
>> -		int new_cnt;
>> -
>> -		new_cnt = atomic_sub_return(cnt, &vsock->queued_replies);
>> -		if (new_cnt + cnt >= virtqueue_get_vring_size(rx_vq) &&
>> -		    new_cnt < virtqueue_get_vring_size(rx_vq))
>> -			queue_work(virtio_vsock_workqueue, &vsock->rx_work);
>> -	}
>> +	virtio_transport_purge_skbs(vsk, &vsock->send_pkt_queue);
>>
>>  	ret = 0;
>>
>> @@ -367,18 +350,6 @@ static void virtio_transport_tx_work(struct work_struct *work)
>>  		queue_work(virtio_vsock_workqueue, &vsock->send_pkt_work);
>>  }
>>
>> -/* Is there space left for replies to rx packets? */
>> -static bool virtio_transport_more_replies(struct virtio_vsock *vsock)
>> -{
>> -	struct virtqueue *vq = vsock->vqs[VSOCK_VQ_RX];
>> -	int val;
>> -
>> -	smp_rmb(); /* paired with atomic_inc() and atomic_dec_return() */
>> -	val = atomic_read(&vsock->queued_replies);
>> -
>> -	return val < virtqueue_get_vring_size(vq);
>> -}
>> -
>>  /* event_lock must be held */
>>  static int virtio_vsock_event_fill_one(struct virtio_vsock *vsock,
>>  				       struct virtio_vsock_event *event)
>> @@ -613,6 +584,7 @@ static void virtio_transport_rx_work(struct work_struct *work)
>>  	struct virtio_vsock *vsock =
>>  		container_of(work, struct virtio_vsock, rx_work);
>>  	struct virtqueue *vq;
>> +	int pkts = 0;
>>
>>  	vq = vsock->vqs[VSOCK_VQ_RX];
>>
>> @@ -627,11 +599,9 @@ static void virtio_transport_rx_work(struct work_struct *work)
>>  			struct sk_buff *skb;
>>  			unsigned int len;
>>
>> -			if (!virtio_transport_more_replies(vsock)) {
>> -				/* Stop rx until the device processes already
>> -				 * pending replies.  Leave rx virtqueue
>> -				 * callbacks disabled.
>> -				 */
>> +			if (++pkts > VSOCK_MAX_PKTS_PER_WORK) {
>> +				/* Allow other works on the same queue to run */
>> +				queue_work(virtio_vsock_workqueue, work);
>>  				goto out;
>>  			}
>>
>> @@ -675,8 +645,6 @@ static int virtio_vsock_vqs_init(struct virtio_vsock *vsock)
>>  	vsock->rx_buf_max_nr = 0;
>>  	mutex_unlock(&vsock->rx_lock);
>>
>> -	atomic_set(&vsock->queued_replies, 0);
>> -
>>  	ret = virtio_find_vqs(vdev, VSOCK_VQ_MAX, vsock->vqs, vqs_info, NULL);
>>  	if (ret < 0)
>>  		return ret;
>> --
>> 2.47.1
>>


