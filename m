Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819DE32692A
	for <virtualization@lists.linux.dev>; Mon, 17 Nov 2025 09:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763371640; cv=none; b=fR+h7PfCK2jbgoqOLbMraxtP+nUFJ7aQ2xWxGfcCo7Ge4/xtGSQvdwvjFcscyibxJGjmwfiO6ok3GgBHNn5JktkOYwq18QVN8eqjyqnKR+hMKUk1a0g1LhVuQC4p8bNdpcQtyjXKvYjVyMI6IjXsWHWVtF9llj3n15Mt5sjVgA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763371640; c=relaxed/simple;
	bh=p/mOhX5wU5TPg1ebgo1inWvk1dt88qml9Q0+hRWvaJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=UCY3wGh3bbgcWr3gKH1op7bMaK/EM/IQKHF2/Anu9g0FRF7xqVfCQy3bRmeIimg2OsMV1Myy97z/+WVn+56j0XFeYYffEOYYVhHpiwY2HQnnFQSCFKk2geLp1nDLtYIzfMjhqXiT/rJBvm5mXIhATb+kSGtuuq0ooS0Ds4t/9Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dTL8eZMC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dTL8eZMC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763371637;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dQqnpRSsfBU0PL63czO3vH9zmSpTVYGkOah3QsIuznM=;
	b=dTL8eZMCZDHlXzsu63Jqk0kYR+Ek9TqEG3PDnqScMEMdV4amlC/LlkEtYgP1wM/1RpS9Sq
	Pwaq2rNjw3mQnAcyPQd1o853ekIJkENJ+R96DTlBjGwriDHc///lPi7+cl98yuY6js3Rr9
	GorX7mkJ14tqQMN4ThLqdwLagi+791E=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-G10_CK_iNMm1SWJWEEgO6g-1; Mon, 17 Nov 2025 04:27:16 -0500
X-MC-Unique: G10_CK_iNMm1SWJWEEgO6g-1
X-Mimecast-MFC-AGG-ID: G10_CK_iNMm1SWJWEEgO6g_1763371635
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-42b352355a1so2416300f8f.1
        for <virtualization@lists.linux.dev>; Mon, 17 Nov 2025 01:27:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763371635; x=1763976435;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dQqnpRSsfBU0PL63czO3vH9zmSpTVYGkOah3QsIuznM=;
        b=m3BTVZdjXjgRk4fmISwAJ4vj2HDrYXvXsfAYf2Lipk5tBKUVkvbuf4Dn66wX3KP7Wy
         IK1vyZMkVlSbPna//9HLHO15b67SgU1bu/2jBBmVZ8mMnWs5/r6FfNu6YQsqPpcJExc8
         w3jt6PSZjfNyPAU5wnoDZWOAcCpXQ5kVCBSPKMN8naEcJ3zVUPhaXJ2tZ8yhZiHU+Bh2
         UIQU0oD9RjOhUTWpwyfWUmSnsFFWm+W/ovzCdtjXM7mjZb+yaJ4sjdMbfmqFJYYKtbRZ
         yah3tvGjyro52yfpsLB39mfsaXrwmJjfSN3cXIfmkSL2hj0YRldyMzMN8rcmhK7Ymrxz
         u4+A==
X-Forwarded-Encrypted: i=1; AJvYcCUdO0CJ5ezjb6k6hHpvA2uwz9kg1ViBK2zG1hKNNP1CkrRkVayAzlitu3vkIobttda8+0ysm/g/BgVQDgw9LA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx3PVVWghlAmwgOxpKg9KWquNICXf8dWDPLpUxi948P4GuorHJ8
	ro51f0G0f64Q2k7W0k61Keah3B6WFYtlvUIVwr4Yykfn3kdrz+StoV+iMEHf4lIlqKyeXRl5QUX
	uJjpDNAYTqaB824ayVBEFTjmf5XF1SlrwxIvlCFUJWsMaHzTG/OoNkMwCmPNwGv/FjCZy
X-Gm-Gg: ASbGncufYN5eDNtSNv4OFUwr48wHLFTtxVe4dqqjsZAHONGCRLBcltWxOXbLi93BP9a
	tbZkuG5mCOjJyQsliU5O7g9mr7/59L1+F2ZJTukMX6OGVPW9okwHUZCo9v+hjMxMpasxe4IJPVU
	6QDvKU2nquV9f8Ykyo6tdyIFLVYt3JfcMbLXHSUEO6BV6DxM2OkHcbNVxuN9WAFGIriGD9S1zpQ
	758FOMfPV9OrqzD9ITjKFmsWLXKyIs/LBkbkp3hf/xHtdGb7e+Z+ght8rj8UkriIAqpKQrinfR3
	/532Y1IymRCce6eaTIiv6gWLdL8rumRMXidOotpd2h8x6OcNxz1pMKSWHxg4Zbv9jVCSPy8sMgB
	McGEqKWFZ8s9sZfgn+CwX4VMccIsNQy9u8d4864mDCE5mR3Njj74=
X-Received: by 2002:a05:6000:2c13:b0:429:eb80:11f5 with SMTP id ffacd0b85a97d-42b52844470mr15024952f8f.26.1763371634619;
        Mon, 17 Nov 2025 01:27:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEOfAeOwT64wQfDszMuYE9w8CzeegX6YU8PZBJXsP9KBtQpKpQ5VM0qnMs29giIOIDG2ykJgw==
X-Received: by 2002:a05:6000:2c13:b0:429:eb80:11f5 with SMTP id ffacd0b85a97d-42b52844470mr15024903f8f.26.1763371634074;
        Mon, 17 Nov 2025 01:27:14 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-153.retail.telecomitalia.it. [79.46.200.153])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53e91f2dsm25732564f8f.19.2025.11.17.01.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 01:27:11 -0800 (PST)
Date: Mon, 17 Nov 2025 10:27:00 +0100
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
Message-ID: <i43cna2w32sysezh6v7b7qkl543g2danbv3kctfwnpcxlfo2oq@b6of2fd27pu6>
References: <20251111-vsock-vmtest-v9-0-852787a37bed@meta.com>
 <20251111-vsock-vmtest-v9-6-852787a37bed@meta.com>
 <g6bxp6hketbjrddzni2ln37gsezqvxbu2orheorzh7fs66roll@hhcrgsos3ui3>
 <aRTRhk/ok06YKTEu@devvm11784.nha0.facebook.com>
 <g5dcyor4aryvtcnqxm5aekldbettetlmog3c7sj7sjx3yp2pgy@hcpxyubied2n>
 <aRYivEKsa44u5Mh+@devvm11784.nha0.facebook.com>
 <kwgjzpxxqpkgwafydp65vlj6jlf7h7kcnhwgtwrrhzp2qtgkkq@z3xfl26ejspl>
 <aRepp4Weuhaxgn6W@devvm11784.nha0.facebook.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <aRepp4Weuhaxgn6W@devvm11784.nha0.facebook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: eUm_eAO5GSQ_9V5j5v5MfLX1FfdxzJohjlNyY-TVOQQ_1763371635
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Fri, Nov 14, 2025 at 02:13:59PM -0800, Bobby Eshleman wrote:
>On Fri, Nov 14, 2025 at 10:33:42AM +0100, Stefano Garzarella wrote:
>> On Thu, Nov 13, 2025 at 10:26:04AM -0800, Bobby Eshleman wrote:
>> > On Thu, Nov 13, 2025 at 04:24:44PM +0100, Stefano Garzarella wrote:
>> > > On Wed, Nov 12, 2025 at 10:27:18AM -0800, Bobby Eshleman wrote:
>> > > > On Wed, Nov 12, 2025 at 03:19:47PM +0100, Stefano Garzarella wrote:
>> > > > > On Tue, Nov 11, 2025 at 10:54:48PM -0800, Bobby Eshleman wrote:
>> > > > > > From: Bobby Eshleman <bobbyeshleman@meta.com>
>> > > > > >
>> > > > > > Add NS support to vsock loopback. Sockets in a global mode netns
>> > > > > > communicate with each other, regardless of namespace. Sockets in a local
>> > > > > > mode netns may only communicate with other sockets within the same
>> > > > > > namespace.
>> > > > > >
>> > > > > > Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>> >
>> > [...]
>> >
>> > > > > > @@ -131,7 +136,41 @@ static void vsock_loopback_work(struct work_struct *work)
>> > > > > > 		 */
>> > > > > > 		virtio_transport_consume_skb_sent(skb, false);
>> > > > > > 		virtio_transport_deliver_tap_pkt(skb);
>> > > > > > -		virtio_transport_recv_pkt(&loopback_transport, skb, NULL, 0);
>> > > > > > +
>> > > > > > +		/* In the case of virtio_transport_reset_no_sock(), the skb
>> > > > > > +		 * does not hold a reference on the socket, and so does not
>> > > > > > +		 * transitively hold a reference on the net.
>> > > > > > +		 *
>> > > > > > +		 * There is an ABA race condition in this sequence:
>> > > > > > +		 * 1. the sender sends a packet
>> > > > > > +		 * 2. worker calls virtio_transport_recv_pkt(), using the
>> > > > > > +		 *    sender's net
>> > > > > > +		 * 3. virtio_transport_recv_pkt() uses t->send_pkt() passing the
>> > > > > > +		 *    sender's net
>> > > > > > +		 * 4. virtio_transport_recv_pkt() free's the skb, dropping the
>> > > > > > +		 *    reference to the socket
>> > > > > > +		 * 5. the socket closes, frees its reference to the net
>> > > > > > +		 * 6. Finally, the worker for the second t->send_pkt() call
>> > > > > > +		 *    processes the skb, and uses the now stale net pointer for
>> > > > > > +		 *    socket lookups.
>> > > > > > +		 *
>> > > > > > +		 * To prevent this, we acquire a net reference in vsock_loopback_send_pkt()
>> > > > > > +		 * and hold it until virtio_transport_recv_pkt() completes.
>> > > > > > +		 *
>> > > > > > +		 * Additionally, we must grab a reference on the skb before
>> > > > > > +		 * calling virtio_transport_recv_pkt() to prevent it from
>> > > > > > +		 * freeing the skb before we have a chance to release the net.
>> > > > > > +		 */
>> > > > > > +		net_mode = virtio_vsock_skb_net_mode(skb);
>> > > > > > +		net = virtio_vsock_skb_net(skb);
>> > > > >
>> > > > > Wait, we are adding those just for loopback (in theory used only for
>> > > > > testing/debugging)? And only to support virtio_transport_reset_no_sock() use
>> > > > > case?
>> > > >
>> > > > Yes, exactly, only loopback + reset_no_sock(). The issue doesn't exist
>> > > > for vhost-vsock because vhost_vsock holds a net reference, and it
>> > > > doesn't exist for non-reset_no_sock calls because after looking up the
>> > > > socket we transfer skb ownership to it, which holds down the skb -> sk ->
>> > > > net reference chain.
>> > > >
>> > > > >
>> > > > > Honestly I don't like this, do we have any alternative?
>> > > > >
>> > > > > I'll also try to think something else.
>> > > > >
>> > > > > Stefano
>> > > >
>> > > >
>> > > > I've been thinking about this all morning... maybe
>> > > > we can do something like this:
>> > > >
>> > > > ```
>> > > >
>> > > > virtio_transport_recv_pkt(...,  struct sock *reply_sk) {... }
>> > > >
>> > > > virtio_transport_reset_no_sock(..., reply_sk)
>> > > > {
>> > > > 	if (reply_sk)
>> > > > 		skb_set_owner_sk_safe(reply, reply_sk)
>> > >
>> > > Interesting, but what about if we call skb_set_owner_sk_safe() in
>> > > vsock_loopback.c just before calling virtio_transport_recv_pkt() for every
>> > > skb?
>> >
>> > I think the issue with this is that at the time vsock_loopback calls
>> > virtio_transport_recv_pkt() the reply skb hasn't yet been allocated by
>> > virtio_transport_reset_no_sock() and we can't wait for it to return
>> > because the original skb may be freed by then.
>>
>> Right!
>>
>> >
>> > We might be able to keep it all in vsock_loopback if we removed the need
>> > to use the original skb or sk by just using the net. But to do that we
>> > would need to add a netns_tracker per net somewhere. I guess that would
>> > end up in a list or hashmap in struct vsock_loopback.
>> >
>> > Another option that does simplify a little, but unfortunately still doesn't keep
>> > everything in loopback:
>> >
>> > @@ -1205,7 +1205,7 @@ static int virtio_transport_reset_no_sock(const struct virtio_transport *t,
>> > 	if (!reply)
>> > 		return -ENOMEM;
>> >
>> > -	return t->send_pkt(reply, net, net_mode);
>> > +	return t->send_pkt(reply, net, net_mode, skb->sk);
>> > }
>> >
>> > @@ -27,11 +27,16 @@ static u32 vsock_loopback_get_local_cid(void)
>> > }
>> >
>> > static int vsock_loopback_send_pkt(struct sk_buff *skb, struct net *net,
>> > -				   enum vsock_net_mode net_mode)
>> > +				   enum vsock_net_mode net_mode,
>> > +				   struct sock *rst_owner)
>> > {
>> > 	struct vsock_loopback *vsock = &the_vsock_loopback;
>> > 	int len = skb->len;
>> >
>> > +	if (!skb->sk && rst_owner)
>> > +		WARN_ONCE(!skb_set_owner_sk_safe(skb, rst_owner),
>> > +			  "loopback socket has sk_refcnt == 0\n");
>> > +
>>
>> This doesn't seem too bad IMO, but at this point, why we can't do that
>> in virtio_transport_reset_no_sock() for any kind of transport?
>>
>> I mean, in any case the RST packet should be handled by the same net of the
>> "sender", no?
>>
>> At this point, can we just put the `vsk` of the sender in the `info` and
>> virtio_transport_alloc_skb() will already do that.
>>
>> WDYT?
>> Am I missing something?
>
>This is the right answer... I'm pretty sure this works out-of-the-box
>for all transports.

I hope too, but I was worried there was something hidden, even though it 
should make sense. Anyway, I would make this change in a separate patch, 
explaining our reasoning clearly (that reset packets should be 
associated with the sending socket, etc.), so that if we find something 
wrong in the future, we can revert it if necessary.

>
>I'll implement it and report back with a new rev if all good or come
>back to this thread to discuss if any issues arise.
>
>Have a good weekend!

I did :-) hope it was good for you too!

Ciao,
Stefano

