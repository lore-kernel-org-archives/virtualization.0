Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFEA4F4730
	for <virtualization@lists.linux.dev>; Wed, 16 Sep 2026 12:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789562689; cv=none; b=T/XcSQqQI/pBF+Kf/WmQ14JhZ7dcQdQw4wc5xwDZcGI/8farOuj4FYCHTVWdLOYwr5BdjMknIWvgfjIGY3w1bLVjTC3B6LRv7hOnPVNn8D+qqeDBkAwYD5uWEZLrZlX1CZRaM23CBcfpKDsfdcBLfubRkDTyWZ54riu5QqJDpR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789562689; c=relaxed/simple;
	bh=R6gErF33Osgu7Z3SwcLr9EAh1+JuJ9MhvIEQ63MOWQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=H/c9yDVUcyFwIt+HvEbWYlPmO0rak0YlbwJzYZ3FPzCT8DQhjSIRMB2zgpcB15Czz9OsImNJvUeyveJUv2+U/PXtqj1gXnC/e47YItv1UeDh46bW9+16mIE7p20UTZV9+FeAY4GjcBqZ+3YPj+x17TUScnymTLZpJ3mnYAtcpmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RcIlpOwa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RcIlpOwa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789562684;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xtQRXCuPYRxWKGeHGm4yA8jBCwKuCZ6dScY6lTLEkSY=;
	b=RcIlpOwaTlobIzWa/YE8ruiQm7M4CeDTDZIptGzeAA67KfWKI9/XOpsAZv9HMGaXmdVsW5
	/MwEegDWyPy2pRv8HLEkEPkdNuzyUO2Ykln77Pt104i2IqeqZJwdpib/9CABgViSyPQcrM
	IXei7w5InMc2c0GC+Jwz8V1nzBfYKG8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-384-ci38qrIzPqi6PcAETH_1IQ-1; Wed, 16 Sep 2026 08:44:41 -0400
X-MC-Unique: ci38qrIzPqi6PcAETH_1IQ-1
X-Mimecast-MFC-AGG-ID: ci38qrIzPqi6PcAETH_1IQ_1789562680
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-47f6e8b5996so5138465f8f.2
        for <virtualization@lists.linux.dev>; Wed, 16 Sep 2026 05:44:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789562680; x=1790167480;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xtQRXCuPYRxWKGeHGm4yA8jBCwKuCZ6dScY6lTLEkSY=;
        b=gBlqkxBV+SyZFYh3cFb7nnxf5ANlWWNKRI8Ljjbc9U1KzxnkYH2xjesICY1mCH8y8q
         VETIOoUDs91WYMHUle2aPl9tY3C0KQnPb1mXwDb8wTXYRpgoSSsjuS+lu1sUMtRLh7mO
         qPD2x2E4kLA5oDeDFwUJeUYqQ5ngrG2n4iXvdWbMqrr8yrd5c3YVefciPJdnNki8GNZE
         Wxxd09ikU4MOvDGMYpEFaoE7oNR6m17Tu+YM4Lp160+KlrEMrrZOBJ6G08pWACoErsff
         /Oe0NcmEhdzQYcCF1/mOy7ZfxuCqxynxzLD+rwO5gECIOhpjCRPBl/rFtJhxbOvuw9eU
         roUw==
X-Forwarded-Encrypted: i=1; AKwUvByERwwq8CAd8WySrKjjUemcHbxWGHpZKTNqMZuUuJxlFw6MG6iBvVXb7QkdSkIKtV1RNaOTb+Hj7JdOloI7/w==@lists.linux.dev
X-Gm-Message-State: AFuF++myY2XoDxUR+TSivOI/eDb/dEDZGiHFfTsgebucWrE7k2m/VyAk
	9u0MN4keAAVlWgR8UHbVReWd2fwPUk1F5ni4qBXpGjN5Td5wuNK2HU/Ku0oguL3urC0RhJTLLWn
	eq7sl1OljAuprk737uRjyPcyz13szBo6yW+ZsAAyl/3GvwjRWwCCWearMJI/qsxmYlW+7
X-Gm-Gg: AYBFou1V6GTPP4mSjHO0I5iwpdoY0otnV1IANR0mNrch0ab0SqFj+kK3WDlrYqJrKB3
	zeI0QI4EyYSuKG9IoQqLhImuEZbXYjAX49c5CFPxwVCMnpLgHl/wJ9M5iVScMjxdTHrhgNbGPvN
	B210vGnHIyXoUOD4o0JhM9BwIaU40cvSCmTS6DzzaXgdAlA21hx6t1QauAlGXHsJEoVDpCN+JZK
	m9S1qlAnqpLkZnroH0Abb6PYyKyhtBo89BYmpddFKkrkl+mQ+lEGxvXGfstAcVIyQ8ie/P9bA+X
	R5VPFNuwncdCw2FVkL2OV2VtiBcYuhJqmtC9Je72z4QC09xE6775e3FjHu1+bEcZSs7uGrPrgGa
	RiwfNu7YWFXVeoJ5eI9toiwsfGEDcxRmjEdJ+XOUHMbYk0w==
X-Received: by 2002:a05:6000:2210:b0:486:e949:532c with SMTP id ffacd0b85a97d-4870d16d687mr2826020f8f.43.1789562680128;
        Wed, 16 Sep 2026 05:44:40 -0700 (PDT)
X-Received: by 2002:a05:6000:2210:b0:486:e949:532c with SMTP id ffacd0b85a97d-4870d16d687mr2825969f8f.43.1789562679479;
        Wed, 16 Sep 2026 05:44:39 -0700 (PDT)
Received: from sgarzare-redhat (host-79-53-30-11.retail.telecomitalia.it. [79.53.30.11])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4870bf3494dsm6691205f8f.28.2026.09.16.05.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 05:44:38 -0700 (PDT)
Date: Wed, 16 Sep 2026 14:44:28 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowangio@gmail.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, sargun@sargun.me, jlinbox@meta.com, 
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next 3/6] vsock/virtio: support guest device network
 namespace
Message-ID: <aqqNZX0gk0I6AbVG@sgarzare-redhat>
References: <20260902-vsock-guest-ns-v1-0-9995383e9a8b@meta.com>
 <20260902-vsock-guest-ns-v1-3-9995383e9a8b@meta.com>
 <aqlkWGyoUYrgQUzz@sgarzare-redhat>
 <aqmLFzcF3MmwRITz@devvm29614.prn0.facebook.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <aqmLFzcF3MmwRITz@devvm29614.prn0.facebook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: HE76IjVWFA-CSO4YxHMXBwOa0nzEjBJbTwwwe0ca_DM_1789562680
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, Sep 15, 2026 at 11:14:47AM -0700, Bobby Eshleman wrote:
>On Tue, Sep 15, 2026 at 05:47:02PM +0200, Stefano Garzarella wrote:
>> On Wed, Sep 02, 2026 at 04:00:49PM -0700, Bobby Eshleman wrote:
>> > From: Bobby Eshleman <bobbyeshleman@meta.com>
>> >
>> > virtio-vsock did not have namespace support (the device was always
>> > accessible to any global namespace).
>> >
>> > Make the virtio-vsock device assignable to a namespace and initialize it
>> > to init_net. Because virtio-vsock and init_net are both hardcoded to
>> > global mode, nothing changes until the assign ioctl is issued.
>> >
>> > When the device's local-mode namespace is being destroyed, received
>> > packets are reset until new valid a namespace has been assigned and/or
>> > automatically returned to, and the next RX batch begins (in
>> > virtio_transport_rx_work). They are reset rather than dropped because
>> > vsock does not retransmit, so a silent drop would leave the host waiting
>> > for a timeout, and a connection request arriving in that window has no
>> > socket whose teardown would tell it otherwise. This requires making
>> > virtio_transport_reset_no_sock() available outside of the common code.
>> >
>> > When a device is assigned to a namespace, every already established
>> > vsock socket that is no longer able to reach the device is forcibly
>> > reset. For that reason, adding new sockets to the connected table must
>> > be performed atomically with regards to namespace assignment. This
>> > ensures that when the socket is added to the connected table that it
>> > actually passes the new reachability conditions set by ns assignment. If
>> > it wins the race to the table and does NOT pass the reachability tests,
>> > then the reset sweep will correctly catch it. This is the purpose
>> > of the new helper 'vsock_maybe_set_connected()'.
>> >
>> > Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>> > ---
>> > include/linux/virtio_vsock.h            |  2 ++
>> > net/vmw_vsock/virtio_transport.c        | 28 ++++++++++++++++++++++------
>> > net/vmw_vsock/virtio_transport_common.c | 28 +++++++++++++++++++++-------
>> > 3 files changed, 45 insertions(+), 13 deletions(-)
>> >
>> > diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
>> > index f91704731057..9c68ce1d7fb4 100644
>> > --- a/include/linux/virtio_vsock.h
>> > +++ b/include/linux/virtio_vsock.h
>> > @@ -286,6 +286,8 @@ void virtio_transport_inc_tx_pkt(struct virtio_vsock_sock *vvs, struct sk_buff *
>> > u32 virtio_transport_get_credit(struct virtio_vsock_sock *vvs, u32 wanted);
>> > void virtio_transport_put_credit(struct virtio_vsock_sock *vvs, u32 credit);
>> > void virtio_transport_deliver_tap_pkt(struct sk_buff *skb);
>> > +int virtio_transport_reset_no_sock(const struct virtio_transport *t,
>> > +				   struct sk_buff *skb, struct net *net);
>> > int virtio_transport_purge_skbs(void *vsk, struct sk_buff_head *list);
>> > int virtio_transport_read_skb(struct vsock_sock *vsk, skb_read_actor_t read_actor);
>> > int virtio_transport_notify_set_rcvlowat(struct vsock_sock *vsk, int val);
>> > diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>> > index 4f9aa9c4c3aa..a453a4f828dc 100644
>> > --- a/net/vmw_vsock/virtio_transport.c
>> > +++ b/net/vmw_vsock/virtio_transport.c
>> > @@ -540,9 +540,14 @@ static bool virtio_transport_msgzerocopy_allow(void)
>> > 	return true;
>> > }
>> >
>> > +static bool virtio_transport_netns_assign_allow(void)
>> > +{
>> > +	return true;
>> > +}
>> > +
>> > bool virtio_transport_stream_allow(struct vsock_sock *vsk, u32 cid, u32 port)
>> > {
>> > -	return vsock_net_mode_global(vsk);
>> > +	return vsock_g2h_net_reachable(sock_net(sk_vsock(vsk)));
>> > }
>> >
>> > static bool virtio_transport_seqpacket_allow(struct vsock_sock *vsk,
>> > @@ -587,6 +592,7 @@ static struct virtio_transport virtio_transport = {
>> > 		.seqpacket_has_data       = virtio_transport_seqpacket_has_data,
>> >
>> > 		.msgzerocopy_allow        = virtio_transport_msgzerocopy_allow,
>> > +		.netns_assign_allow       = virtio_transport_netns_assign_allow,
>> >
>> > 		.notify_poll_in           = virtio_transport_notify_poll_in,
>> > 		.notify_poll_out          = virtio_transport_notify_poll_out,
>> > @@ -616,7 +622,7 @@ virtio_transport_seqpacket_allow(struct vsock_sock *vsk, u32 remote_cid)
>> > 	struct virtio_vsock *vsock;
>> > 	bool seqpacket_allow;
>> >
>> > -	if (!vsock_net_mode_global(vsk))
>> > +	if (!vsock_g2h_net_reachable(sock_net(sk_vsock(vsk))))
>> > 		return false;
>> >
>> > 	seqpacket_allow = false;
>> > @@ -634,6 +640,9 @@ static void virtio_transport_rx_work(struct work_struct *work)
>> > 	struct virtio_vsock *vsock =
>> > 		container_of(work, struct virtio_vsock, rx_work);
>> > 	struct virtqueue *vq;
>> > +	struct net *net;
>> > +
>> > +	net = vsock_g2h_net_get();
>> >
>> > 	mutex_lock(&vsock->rx_lock);
>> >
>> > @@ -682,10 +691,14 @@ static void virtio_transport_rx_work(struct work_struct *work)
>> >
>> > 			virtio_transport_deliver_tap_pkt(skb);
>> >
>> > -			/* Force virtio-transport into global mode since it
>> > -			 * does not yet support local-mode namespacing.
>> > -			 */
>> > -			virtio_transport_recv_pkt(&virtio_transport, skb, NULL);
>> > +			if (unlikely(!net)) {
>> > +				virtio_transport_reset_no_sock(
>> > +					&virtio_transport, skb, &init_net);
>>
>> Why init_net?
>
>This parameter is actually unused by virtio_transport_reset_no_sock(),
>its call to virtio_transport_send_pkt(), and even the eventual call to
>virtio_transport_deliver_tap_pkt()... so maybe NULL w/ a comment would
>be better?

mmm, should we remove that parameter if unused?

Anyway, not in this series/patch.

Here, anything is fine, just put a comment with the reason.

Thanks,
Stefano

