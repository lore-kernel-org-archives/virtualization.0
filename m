Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36102FE58D
	for <virtualization@lists.linux.dev>; Thu, 13 Nov 2025 15:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763047496; cv=none; b=FpHwRNnfOMbYkjpSg/63Z5pcde5M0kUKd+YYXIPTz77tVBOTtgG2WoVpHcUkDzLhUxQk12K0WxmfTfucp0JdX6hCdpzybr1I7Rusyx6FhZjSx5e7NATjrvNFVvQYGYFwE4yUFlAJddD5gj0BFeblG0qkeBWZbBBjJU3lgH3/C20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763047496; c=relaxed/simple;
	bh=RWmdUrg02H6f+aep4jIDFyNZk5wA5k2aihRICtWoOEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Ba2Fn11fQv62cPbRyYU0RZSeseLDI6+ibNUlc8FDe36vH+xY8yf0K9h0mXyWjUEfyDhtIj+FxA462STM2YJJQEqkEvVajkDNNyqqaI9aJHQ0+wLOLcvFz4tkoQERR1GxDSnn+tlfImaehzStakeB+91Yl+saZeFbCk4J2sObbWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NN3H6Fph; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NN3H6Fph"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763047493;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+6KSIoS5LmlMULcY0rSH3odgewvUTbNtCV5m3STvge8=;
	b=NN3H6FphYabUoE/hWZhY6AHZT+tJF2udbt6qDtApDMvBb9f6q39su7mldV1L2rwIzYo5j6
	70XgPYLdZkzRE4XTi43bkm//BMpCaayN6RUXZim+0EAmdo7ZJNv94+G800UndMcdvEic/Q
	85QVp7gWvmdRPclVucja75ZR0Y/EghY=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-52-Vq2SQUtYP9OTeAeUMd_1wg-1; Thu, 13 Nov 2025 10:24:52 -0500
X-MC-Unique: Vq2SQUtYP9OTeAeUMd_1wg-1
X-Mimecast-MFC-AGG-ID: Vq2SQUtYP9OTeAeUMd_1wg_1763047491
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-6408222225eso1842910a12.3
        for <virtualization@lists.linux.dev>; Thu, 13 Nov 2025 07:24:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763047491; x=1763652291;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+6KSIoS5LmlMULcY0rSH3odgewvUTbNtCV5m3STvge8=;
        b=BrIJ3pzcA4MkTgPlPdxY9dbBblkkbKCsM+TKozAEF25sByAJF8CPENjCm9qJk3/M4e
         4Hqxp2KvHAgh2sv4Y7RW1OKSl7ceTF5hpqYxLcGQz085i/Rf03oCgFweSBPGlAHQnL8r
         /FIOYoj12Sd+nNa8ftgOGn80LOemtWhLqTw4tiM6Xs5cyEGPvLUiMCluqq2gTuA/b7fE
         Szs8vyvVu4AqRFSeEdgnpQ/vB2Nc/v5MxHu9hpPFDQclvgMyMlYUYW/TyTlcJy1GOHU1
         J8iTSSvbA6CoP6QfsQepnZf/x9w2AKzRrKXS4wB0vCCbhs4kl5CxxJxCkX69o74E7lrx
         HSHA==
X-Forwarded-Encrypted: i=1; AJvYcCVK16l/HIbG3EsBEzzcuu5Mo8O6p639n9H+3YJ+4fyhKmTo0aL1oRF2S/TpYsXym3+PnRYDe5HYMV8gn5BZ2A==@lists.linux.dev
X-Gm-Message-State: AOJu0YxgK3h68dFXkoQHZczQ3U5xDy+PTzRKMk+Fc3ZB5IaQ6eOyj5ph
	cSRJ7zADWuSElvJoM8JeQPu8rHgFghkLo/Ht0gM5qsu0AikQbNE0YgPfxoPKYziYfwYzEuHVnYE
	lA+fuoUZZceKF7lFH4q6Pz4C90iSV7gqUyV8yHcwwk8m4QCY9CEGBTwx91A1dG8/DSFTp
X-Gm-Gg: ASbGncu0UsmVx2r6x+aJaq39zYnwYPyBc1mRYoDqWGfWhUZaTUEs6lY64FEYZFLZNRv
	tkADS2Tb/BvzHupVhqoHootOQyQtlJNKaj4IaAg80f0z5Qj6CNIb5Y/hI53FwOSI84qsOh1VOzL
	OVCA55TlIQSJxv/DTZbPK68fWX//Z0+oR9HU0hFJ1BuFIHZTqpk/u7vWH1bOxz27ry3nxc+O7tp
	H/+x+XvGIL1aQLw1eyDp1c2jp+7J6x7FYQ6q1ae2eb/RqWY0bq6fZJ0M8rTL3gVrK2rK8MP7F6x
	T3m0ivZ5kW/JZKbfyvinykk4D8wCXMmw7Pi1tR7xv5OaV6jwgNn20OOszJQ+DoQbvEn53YEvT97
	P1gOEMo0hYO8UJeyU/wgF4tmxsbAxTFIOf+YzK2wjPCAswXhxENo=
X-Received: by 2002:a05:6402:3510:b0:63c:eb6:65e8 with SMTP id 4fb4d7f45d1cf-6431a56938amr6157374a12.30.1763047491186;
        Thu, 13 Nov 2025 07:24:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFlKgqnCe8xOA2ZWxmxvwtxL2cKocqyC9cwwbKOiPr8xF8kOeK/j8WX7lSpFb7Tuv717eLwhg==
X-Received: by 2002:a05:6402:3510:b0:63c:eb6:65e8 with SMTP id 4fb4d7f45d1cf-6431a56938amr6157323a12.30.1763047490676;
        Thu, 13 Nov 2025 07:24:50 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-153.retail.telecomitalia.it. [79.46.200.153])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6433a497fc5sm1661218a12.22.2025.11.13.07.24.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 07:24:50 -0800 (PST)
Date: Thu, 13 Nov 2025 16:24:44 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Bryan Tan <bryan-bt.tan@broadcom.com>, Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, Sargun Dhillon <sargun@sargun.me>, berrange@redhat.com, 
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v9 06/14] vsock/loopback: add netns support
Message-ID: <g5dcyor4aryvtcnqxm5aekldbettetlmog3c7sj7sjx3yp2pgy@hcpxyubied2n>
References: <20251111-vsock-vmtest-v9-0-852787a37bed@meta.com>
 <20251111-vsock-vmtest-v9-6-852787a37bed@meta.com>
 <g6bxp6hketbjrddzni2ln37gsezqvxbu2orheorzh7fs66roll@hhcrgsos3ui3>
 <aRTRhk/ok06YKTEu@devvm11784.nha0.facebook.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <aRTRhk/ok06YKTEu@devvm11784.nha0.facebook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0Zo6FUIMy9rlriKNmUG4pA2_ADkokcC8sdlYTeh3kzU_1763047491
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Wed, Nov 12, 2025 at 10:27:18AM -0800, Bobby Eshleman wrote:
>On Wed, Nov 12, 2025 at 03:19:47PM +0100, Stefano Garzarella wrote:
>> On Tue, Nov 11, 2025 at 10:54:48PM -0800, Bobby Eshleman wrote:
>> > From: Bobby Eshleman <bobbyeshleman@meta.com>
>> >
>> > Add NS support to vsock loopback. Sockets in a global mode netns
>> > communicate with each other, regardless of namespace. Sockets in a local
>> > mode netns may only communicate with other sockets within the same
>> > namespace.
>> >
>> > Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>> > ---
>> > Changes in v9:
>> > - remove per-netns vsock_loopback and workqueues, just re-using
>> >  the net and net_mode in skb->cb achieved the same result in a simpler
>> >  way. Also removed need for pernet_subsys.
>> > - properly track net references
>> >
>> > Changes in v7:
>> > - drop for_each_net() init/exit, drop net_rwsem, the pernet registration
>> >  handles this automatically and race-free
>> > - flush workqueue before destruction, purge pkt list
>> > - remember net_mode instead of current net mode
>> > - keep space after INIT_WORK()
>> > - change vsock_loopback in netns_vsock to ->priv void ptr
>> > - rename `orig_net_mode` to `net_mode`
>> > - remove useless comment
>> > - protect `register_pernet_subsys()` with `net_rwsem`
>> > - do cleanup before releasing `net_rwsem` when failure happens
>> > - call `unregister_pernet_subsys()` in `vsock_loopback_exit()`
>> > - call `vsock_loopback_deinit_vsock()` in `vsock_loopback_exit()`
>> >
>> > Changes in v6:
>> > - init pernet ops for vsock_loopback module
>> > - vsock_loopback: add space in struct to clarify lock protection
>> > - do proper cleanup/unregister on vsock_loopback_exit()
>> > - vsock_loopback: use virtio_vsock_skb_net()
>> >
>> > Changes in v5:
>> > - add callbacks code to avoid reverse dependency
>> > - add logic for handling vsock_loopback setup for already existing
>> >  namespaces
>> > ---
>> > net/vmw_vsock/vsock_loopback.c | 41 ++++++++++++++++++++++++++++++++++++++++-
>> > 1 file changed, 40 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/net/vmw_vsock/vsock_loopback.c b/net/vmw_vsock/vsock_loopback.c
>> > index d3ac056663ea..e62f6c516992 100644
>> > --- a/net/vmw_vsock/vsock_loopback.c
>> > +++ b/net/vmw_vsock/vsock_loopback.c
>> > @@ -32,6 +32,9 @@ static int vsock_loopback_send_pkt(struct sk_buff *skb, struct net *net,
>> > 	struct vsock_loopback *vsock = &the_vsock_loopback;
>> > 	int len = skb->len;
>> >
>> > +	virtio_vsock_skb_set_net(skb, net);
>> > +	virtio_vsock_skb_set_net_mode(skb, net_mode);
>> > +
>> > 	virtio_vsock_skb_queue_tail(&vsock->pkt_queue, skb);
>> > 	queue_work(vsock->workqueue, &vsock->pkt_work);
>> >
>> > @@ -116,8 +119,10 @@ static void vsock_loopback_work(struct work_struct *work)
>> > {
>> > 	struct vsock_loopback *vsock =
>> > 		container_of(work, struct vsock_loopback, pkt_work);
>> > +	enum vsock_net_mode net_mode;
>> > 	struct sk_buff_head pkts;
>> > 	struct sk_buff *skb;
>> > +	struct net *net;
>> >
>> > 	skb_queue_head_init(&pkts);
>> >
>> > @@ -131,7 +136,41 @@ static void vsock_loopback_work(struct work_struct *work)
>> > 		 */
>> > 		virtio_transport_consume_skb_sent(skb, false);
>> > 		virtio_transport_deliver_tap_pkt(skb);
>> > -		virtio_transport_recv_pkt(&loopback_transport, skb, NULL, 0);
>> > +
>> > +		/* In the case of virtio_transport_reset_no_sock(), the skb
>> > +		 * does not hold a reference on the socket, and so does not
>> > +		 * transitively hold a reference on the net.
>> > +		 *
>> > +		 * There is an ABA race condition in this sequence:
>> > +		 * 1. the sender sends a packet
>> > +		 * 2. worker calls virtio_transport_recv_pkt(), using the
>> > +		 *    sender's net
>> > +		 * 3. virtio_transport_recv_pkt() uses t->send_pkt() passing the
>> > +		 *    sender's net
>> > +		 * 4. virtio_transport_recv_pkt() free's the skb, dropping the
>> > +		 *    reference to the socket
>> > +		 * 5. the socket closes, frees its reference to the net
>> > +		 * 6. Finally, the worker for the second t->send_pkt() call
>> > +		 *    processes the skb, and uses the now stale net pointer for
>> > +		 *    socket lookups.
>> > +		 *
>> > +		 * To prevent this, we acquire a net reference in vsock_loopback_send_pkt()
>> > +		 * and hold it until virtio_transport_recv_pkt() completes.
>> > +		 *
>> > +		 * Additionally, we must grab a reference on the skb before
>> > +		 * calling virtio_transport_recv_pkt() to prevent it from
>> > +		 * freeing the skb before we have a chance to release the net.
>> > +		 */
>> > +		net_mode = virtio_vsock_skb_net_mode(skb);
>> > +		net = virtio_vsock_skb_net(skb);
>>
>> Wait, we are adding those just for loopback (in theory used only for
>> testing/debugging)? And only to support virtio_transport_reset_no_sock() use
>> case?
>
>Yes, exactly, only loopback + reset_no_sock(). The issue doesn't exist
>for vhost-vsock because vhost_vsock holds a net reference, and it
>doesn't exist for non-reset_no_sock calls because after looking up the
>socket we transfer skb ownership to it, which holds down the skb -> sk ->
>net reference chain.
>
>>
>> Honestly I don't like this, do we have any alternative?
>>
>> I'll also try to think something else.
>>
>> Stefano
>
>
>I've been thinking about this all morning... maybe
>we can do something like this:
>
>```
>
>virtio_transport_recv_pkt(...,  struct sock *reply_sk) {... }
>
>virtio_transport_reset_no_sock(..., reply_sk)
>{
>	if (reply_sk)
>		skb_set_owner_sk_safe(reply, reply_sk)

Interesting, but what about if we call skb_set_owner_sk_safe() in 
vsock_loopback.c just before calling virtio_transport_recv_pkt() for 
every skb?

Maybe we should refactor a bit virtio_transport_recv_pkt() e.g. moving 
`skb_set_owner_sk_safe()` to be sure it's called only when we are sure 
it's the right socket (e.g. after checking SOCK_DONE).

WDYT?

>
>	t->send_pkt(reply);
>}
>
>vsock_loopback_work(...)
>{
>	virtio_transport_recv_pkt(..., skb, skb->sk);
>}
>
>
>for other transports:
>
>	virtio_transport_recv_pkt(..., skb, NULL);
>
>```
>
>This way 'reply' keeps the sk and sk->net alive even after
>virtio_transport_recv_pkt() frees 'skb'. The net won't be released until
>after 'reply' is freed back on the other side, removing the race.
>
>It makes semantic sense too... for loopback, we already know which sk
>the reply is going back to. For other transports, we don't because
>they're across the virt boundary.
>
>WDYT?
>
>I hate to suggest this, but another option might be to just do nothing?
>In order for this race to have any real effect, a loopback socket must
>send a pkt to a non-existent socket, immediately close(), then the
>namespace deleted, a new namespace created with the same pointer
>address, and finally a new socket with the same port created in that
>namespace, all before the reply RST reaches recv_pkt()... at which point
>the newly created socket would wrongfully receive the RST.

Yeah, let's keep this as plan B for now :-)

Thanks,
Stefano

