Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794983614;
	b=wRJ9pANSMXV9PGZBc7wWQS9M44RdByuD22Q2Ko04bU92389H39x0/InicJFdY75+HAR0
	 z3BLJujMBs+02UJC9ig0nVudp63VlS1/G9nbRh3JazPB6jLzCV1WAoqt8ez/Bgv2YySdP
	 DUEkI9RBh40t/PQifHHzU0GZaz+MTCqPiAOXaWBaBVDE0k0YAwmTWXLqv3p0ozl2fTBcM
	 R7RTH8r9UNnxn9ACNcDU0Rb2MmcS/ADncIb/ZS7XgZLwlKoXrPpqMJU2mvCZjCrv9Sgw5
	 qBIFcIVMJmX1l5PCpTmcteqn0YfvfECW99BjSGB0WnsO3fySDSN1pxBRDwrRT/sfpRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794983614;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=jm9UtSkj5qTjc2aQp3GV2uLJyBITV/apzUIo7FVG7gI=;
	b=g4GdcYqIxy04QFMsMPOSqkPb5WRItL8Ati3wcZOtMm08L7Ro7JqP+os16XNX6chT6Swo
	 CGYSG8vfOLEA4CSq3o8AhDS/g2MJmVFVaZgsTmEVwI1YNhJE/uyONQLxAEhzYxSs7KqB4
	 QcOb0EGfbpq/YmyVm9ZiHbK7F8udBtVs/XGxGxQg7B7ZWbNQpkP0QT8/azXsWeUijmADt
	 0PIp5P7uO7XgOsHKyzqEe/m65TE4ShIn3cQ3327Qym9AZ+KjGaEWgGGd/NqdAM9se68pQ
	 nvgiTugFkKqQkJiMAM2YGL/PqDoaKEkOMnmFhCZLRDGJfi4zCt8Z42iwSXqpGFP7cGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ivQghRHa;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88BC606A325
	for <virtualization@lists.linux.dev>; Wed, 18 Nov 2026 06:33:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B88BC606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ivQghRHa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794983613;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jm9UtSkj5qTjc2aQp3GV2uLJyBITV/apzUIo7FVG7gI=;
	b=ivQghRHa7aHXycTCAk13nbpBx5z3W1dNgH+vQvlGMON2X+QF8CBPBJYbgBV97RbUwDRtir
	exKvSiGE3g88NUClB4MN3HXn5hqkE0eHVgrayFvP8p0bUp39vPsN01tn3Pl+j+4cRTPjmT
	esvnfSTamqwBk1Sndn3g4AOGQaE90ak=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-344-WpDKGjhjOFeqfPG4o-PZvQ-1; Wed, 18 Nov 2026 01:33:31 -0500
X-MC-Unique: WpDKGjhjOFeqfPG4o-PZvQ-1
X-Mimecast-MFC-AGG-ID: WpDKGjhjOFeqfPG4o-PZvQ_1794983610
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-49090fde23aso358165f8f.2
        for <virtualization@lists.linux.dev>; Tue, 17 Nov 2026 22:33:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794983610; x=1795588410;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jm9UtSkj5qTjc2aQp3GV2uLJyBITV/apzUIo7FVG7gI=;
        b=ag3O/cjHuMTn19clWW7KcLoYXIeNMNlxbrbBQeKoqz+vE0aF63KAot0OGitSAE0v2+
         cV9xla0xmZAB7uk2kVGuU90GcwByraxnJxA1seP4Ua76VeQFOgA4w09GLPRFp1yXRjZv
         MQWiD284QwzifPjZz8Bu6A44pFp4c3v2CCWp8SNdlvM+1Uhaw0HEkyUKWeHQlJwOGG5t
         zjeqRgQB26V6O4VKSQ4BPcEVjwqpXZEWOGtekpqcoy/bG5rOwOI515B6f3IeGQuHkadQ
         3byiEFAbQGaF1LI9ncuq9Wg+IQgP7IxXZM7uDyKncl3sNczSOXHBUqJdbeaAf8loaN1+
         OQ2w==
X-Forwarded-Encrypted: i=1; AL+hErGi7el/b2fKGvJM6oo9dDp49nD11dr0Sq3tYIUbxKFqh89hFJCSDl0Moxab7W0FF+oH5S4+IzOaEgXWQ/06sQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z/Hk2HVY6PAj04m+d3ACqGwnrXPwKp7FaFL4mw07/P4dP+6RbwZ
	swKP8UiRWKkq4B2uV07jOlkGA+WS8V/b6xrXk36nEWEC3qCwcfA/MzW2TqG3K1W3J2NxVOXYIB4
	YEkc4A8U80N/V3uG0sosJvRna3qIf5zTY0ixgS4rPzrCTIMpvhmL+StCYHJT6nNKQJosv
X-Gm-Gg: AZFdTZdFhLKL9C/Wp8atfFdHy4pHY36bbS10eL6D54/prj62OdgO0STrmBVtHllbnKX
	O1YtWxRt+glQQRDHpdYPGUqZj1Q4D1h6M2yjsEnO9TrzH5VBTHkxbCMXR4oIAQetWVNYsoSc1bt
	LMLC1rEPCWcyft6KNVlJmXAdncVQdk3Pg27SrbzMc0Mvj6xk2obKdzcEYSj/BKKdMawher0WHxx
	LVemjeQ0LO8lX0sFmXnl4bUOU1jFlftg7iW/7tJNp7BzMmXEIXTJ60WnGXw8Hh2D5rgHn2bM8cn
	VoPM9h1KVDbaviKidS4UGxXL3hSRPt+ojtAvdy4x+OXzc+4gWqS1S3tqjHxEAZygO7NdLryM7j1
	qjiZkZEe45bqpnUsfA4YGgfE/4OqWva5SxiCWPgo/JCI=
X-Received: by 2002:a5d:5d0d:0:b0:4a7:9630:7b5a with SMTP id ffacd0b85a97d-4a7963080e7mr331953f8f.47.1794983610318;
        Tue, 17 Nov 2026 22:33:30 -0800 (PST)
X-Received: by 2002:a5d:5d0d:0:b0:4a7:9630:7b5a with SMTP id ffacd0b85a97d-4a7963080e7mr331922f8f.47.1794983609777;
        Tue, 17 Nov 2026 22:33:29 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1520:4400:d78d:7b2d:2f5d:e08f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a65560b5f1sm2935743f8f.21.2026.11.17.22.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 22:33:28 -0800 (PST)
Date: Wed, 18 Nov 2026 01:33:26 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Nguyen Dinh Phi <phind.uet@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Bobby Eshleman <bobbyeshleman@meta.com>,
	Jason Wang <jasowangio@gmail.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Asias He <asias@redhat.com>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] vhost/vsock: annotate lockless accesses to guest_cid
Message-ID: <20261118012321-mutt-send-email-mst@kernel.org>
References: <20261117164916.2332953-1-phind.uet@gmail.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261117164916.2332953-1-phind.uet@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: IDIZCoKRJigTOI_KdcsZ0sRyhqH_OvSOaRXzFDg1FyU_1794983610
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 18, 2026 at 12:48:43AM +0800, Nguyen Dinh Phi wrote:
> vhost_vsock.guest_cid is written by vhost_vsock_set_cid() under
> vhost_vsock_mutex, but It is also read without that mutex in
> vhost_vsock_handle_tx_kick(), and vhost_vsock_get().
> 
> KCSAN will report data-race if we issue VHOST_VSOCK_SET_GUEST_CID
> ioctl while the device has TX traffic. For example:
> 
>  write to 0xffff88810f1596ac of 4 bytes by task 7914 on cpu 1:
>    vhost_vsock_dev_ioctl+0x25f/0x720
>    __x64_sys_ioctl+0xc2/0x110
>    x64_sys_call+0x299/0x20a0
>    do_syscall_64+0xc9/0x510
>    entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
>   read to 0xffff88810f1596ac of 4 bytes by task 7910 on cpu 3:
>    vhost_vsock_handle_tx_kick+0x41b/0x740
>    vhost_run_work_list+0x97/0xc0
>    vhost_task_fn+0x98/0x1f0
>    ret_from_fork+0x2e2/0x3c0
>    ret_from_fork_asm+0x1a/0x30
> 
>   value changed: 0x0000004d -> 0x00000032
> 
> Both readers load the CID once and works correctly with either the
> old or the new value.
> 
> Mark the store with WRITE_ONCE() and the two lockless loads with
> READ_ONCE(), so KCSAN knows the race is intentional.

You make it sounds like it is just KCSAN false positive.
Is it?
if yes, this should be data_race. If no, document why.



> 
> Fixes: 433fc58e6bf2 ("VSOCK: Introduce vhost_vsock.ko")
> Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>
> ---
>  drivers/vhost/vsock.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> index 88a310390eb0..f26c59013075 100644
> --- a/drivers/vhost/vsock.c
> +++ b/drivers/vhost/vsock.c
> @@ -78,7 +78,7 @@ static struct vhost_vsock *vhost_vsock_get(u32 guest_cid, struct net *net)
>  
>  	hash_for_each_possible_rcu(vhost_vsock_hash, vsock, hash, guest_cid,
>  				   lockdep_is_held(&vhost_vsock_mutex)) {
> -		u32 other_cid = vsock->guest_cid;
> +		u32 other_cid = READ_ONCE(vsock->guest_cid);
>  
>  		/* Skip instances that have no CID yet */
>  		if (other_cid == 0)
> @@ -572,7 +572,7 @@ static void vhost_vsock_handle_tx_kick(struct vhost_work *work)
>  		hdr = virtio_vsock_hdr(skb);
>  
>  		/* Only accept correctly addressed packets */
> -		if (le64_to_cpu(hdr->src_cid) == vsock->guest_cid &&
> +		if (le64_to_cpu(hdr->src_cid) == READ_ONCE(vsock->guest_cid) &&
>  		    le64_to_cpu(hdr->dst_cid) ==
>  		    vhost_transport_get_local_cid())
>  			virtio_transport_recv_pkt(&vhost_transport, skb,

Will prevent compiler from hoisting the reads out of the loops.
Does it matter?


> @@ -859,7 +859,7 @@ static int vhost_vsock_set_cid(struct vhost_vsock *vsock, u64 guest_cid)
>  	if (vsock->guest_cid)
>  		hash_del_rcu(&vsock->hash);
>  
> -	vsock->guest_cid = guest_cid;
> +	WRITE_ONCE(vsock->guest_cid, guest_cid);
>  	hash_add_rcu(vhost_vsock_hash, &vsock->hash, vsock->guest_cid);
>  	mutex_unlock(&vhost_vsock_mutex);
>  
> -- 
> 2.53.0

