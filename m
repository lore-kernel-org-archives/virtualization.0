Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C42A38AC85
	for <virtualization@lists.linux-foundation.org>; Tue, 23 Jun 2026 17:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782235612; cv=none; b=UlKjPMfMjhJk4k6M65O6zAKSrALNcPEJvYndaUmjCXUGtI/Afs+fBKbJqwnXOsYlMY+Pnb4T/Of5vnf8BQxvCWP02QwWo4SudPLweTnl9mcNjOvle3WnaCfbxNCjSwubIYHlNK6s+1J1znHZJKfZtgGLBXyeG53n3XHs0Nh9Ybs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782235612; c=relaxed/simple;
	bh=rip9uRV7z1MrHq44c9P9AtUk8yQpQ+kZiXRL/p9vnmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=mHoYti4UMdvo9s1XePDXBMpuOctedUT/vONy5jofd6C2YoU98R34+lXdfy4mPg4pJ072F1QRHjem50CzR1ezhjv70UUGkdtghBE5K2/Rl5tT7izKz6OfkFDOy1BpBYtQsEyjW/qqMBDZI5e7oVXj5GocBAe6xAp3ays/Y0hReD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UMHkL/cB; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UMHkL/cB"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 752F640A10
	for <virtualization@lists.linux-foundation.org>; Tue, 23 Jun 2026 17:26:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.792
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id O82nPo5hbpPs for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Jun 2026 17:26:48 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 603AF40A0C
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 603AF40A0C
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UMHkL/cB
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 603AF40A0C
	for <virtualization@lists.linux-foundation.org>; Tue, 23 Jun 2026 17:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782235606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lVPkNP6BJkSGxsw8Xm+oSCJFyrrNmnKR4VG6pNKWuqE=;
	b=UMHkL/cBt9u4LU5O9Ozvgx4IZp1j7yLBffa2cpF18SDH9hmeWTZi6O5GC7Rq73z+C2a+MT
	yHQY2ZI3EtM6J/qvuFBc5xjxnZ7hDafE4MqeLBvHb/Bvp0p/wmMDhUFtuS1q4TquQRxc+c
	s7WbtS1iVZiM5zn0GHVfciHrMEirlq8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-454-0Br9UMBWNX25iQRFMzQ88w-1; Tue, 23 Jun 2026 13:26:44 -0400
X-MC-Unique: 0Br9UMBWNX25iQRFMzQ88w-1
X-Mimecast-MFC-AGG-ID: 0Br9UMBWNX25iQRFMzQ88w_1782235604
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-463aaa77ffeso68630f8f.3
        for <virtualization@lists.linux-foundation.org>; Tue, 23 Jun 2026 10:26:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782235603; x=1782840403;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lVPkNP6BJkSGxsw8Xm+oSCJFyrrNmnKR4VG6pNKWuqE=;
        b=Ev60num8hbx5+SOG8aJKwmLOMIgm/CrnHH8bGyK97N3SKn9xXsssrfwOpC0dc6ZxPy
         RA1ow9eranIz5UhvW7InC5Ti1xLCz1SzqXopgWhmEvCo7YVDIRxXviPiew1U498qdcLH
         0H1gArC+CQSkHBEaB0l5YjkKG5LGDNx6KbZAzJJsyzY7xloLv+tsdacQA3rnm/ApOdmN
         D6FtpTpJgikH8iWRl36sYbZaKd3e5HMEEyYUFv3d77tqDJYSEPeFDZRIomCirXCIHB+Y
         /zyCXurKviMvOxe/3BIAqmQ/ZpfnaTo+dC82sKi1kMEcdG+EQnEeF/iNhSCjrmhM7An2
         Qj/g==
X-Forwarded-Encrypted: i=1; AFNElJ8Swy3JZpZgEhMw5UP+9iXee+o6ljk3pWm/6NjbvjzyPKHI8dN6g/EfgAse05j8VOcjfaoL4vOtP07DADbBjw==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yx9VM0PNL79+M806/Dfgx1OFcAyjuMTcv1MR5rLE8aBR5ATdImJ
	2jFH54A4UN9Apwq+kB7n9Iqyz2xUtF5RySr2IfSJBHdHz7BNcuImNHI12P9QWIW3SHy4PR+3198
	dhina1rRQT+J1qC2wKxbP305fS8igHoAUHwxAJJdr8j4QopGiRkNBdsBdOfmtmwIxIf//FnpU1/
	qOYx4cnCc=
X-Gm-Gg: AfdE7cm2DzwaTl0Zv8PQMPsPhanXZu12BdQgrc4nFsUoGOKOTtwPgYnFHJ2dt4LF3Su
	+7hOOVBHh7Lc12oaJB9ThsA1GOHUEZyowZj1rgevZA5/M56h3xuRlc3ctPta0WmpPM9Z71Nf37q
	VgoSCC5VzcHLVgoENqDh6BGnlhx9CCdx4JRDznvGs77AHKMBGiSbSB/nJa2vlsJ4xGpdifp+fnc
	i7cn8f8R4DsWQz0eyNxn11o7nNnZiBVQGM6A2CE+cpKxQa9BjlAzl20O3AqLX+eNHrRN3uqc9C9
	RopHqrYYLIGhnbz1ImAWoLQQIJnImfdxlHEFm8NT3q5iCTMv8aw1oZUzQkkTE/G4dJJa0La0ckq
	d35Y+3QYmXoxNh+LqsvkLxko50qYkIM4n
X-Received: by 2002:a05:600c:d4:b0:488:ac01:72de with SMTP id 5b1f17b1804b1-49240e20de0mr257222915e9.5.1782235603254;
        Tue, 23 Jun 2026 10:26:43 -0700 (PDT)
X-Received: by 2002:a05:600c:d4:b0:488:ac01:72de with SMTP id 5b1f17b1804b1-49240e20de0mr257222385e9.5.1782235602685;
        Tue, 23 Jun 2026 10:26:42 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4923fd15535sm425803415e9.3.2026.06.23.10.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 10:26:41 -0700 (PDT)
Date: Tue, 23 Jun 2026 13:26:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Arseniy Krasnov <avkrasnov@rulkc.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Bobby Eshleman <bobbyeshleman@meta.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Simon Horman <horms@kernel.org>, kvm@vger.kernel.org,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, oxffffaa@gmail.com,
	rulkc@linuxtesting.org
Subject: Re: [PATCH net-next v3] vsock/virtio: rewrite MSG_ZEROCOPY flag
 handling
Message-ID: <20260623132014-mutt-send-email-mst@kernel.org>
References: <20260623153819.697635-1-avkrasnov@rulkc.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260623153819.697635-1-avkrasnov@rulkc.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: BLP3dI9M4kIDRgbT6H7QppV1pBpBajXUSL-ojgVYzyw_1782235604
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 23, 2026 at 06:38:19PM +0300, Arseniy Krasnov wrote:
> Logically it was based on TCP implementation, so to make further support
> easier, rewrite it in the TCP way (like in 'tcp_sendmsg_locked()'). This
> patch only rewrites flag handling (e.g. it doesn't change logic).
> 
> Signed-off-by: Arseniy Krasnov <avkrasnov@rulkc.org>


It seems to change logic though:

> ---
>  Changelog v1->v2:
>  * Rebase on last 'net-next'. Don't need 'skb_zcopy_set()' now - it was
>    already added.
>  Changelog v2->v3:
>  * Update commit message.
>  * Remove one empty line.
> 
>  net/vmw_vsock/virtio_transport_common.c | 47 ++++++++++++-------------
>  1 file changed, 22 insertions(+), 25 deletions(-)
> 
> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> index 09475007165b..41c2a0b82a8e 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -328,38 +328,35 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
>  	if (pkt_len == 0 && info->op == VIRTIO_VSOCK_OP_RW)
>  		return pkt_len;
>  
> -	if (info->msg) {
> -		/* If zerocopy is not enabled by 'setsockopt()', we behave as
> -		 * there is no MSG_ZEROCOPY flag set.
> +	if (info->msg && (info->msg->msg_flags & MSG_ZEROCOPY)) {
> +		/* If 'info->msg' is not NULL, this is only VIRTIO_VSOCK_OP_RW.
> +		 * 'MSG_ZEROCOPY' flag handling here is based on the same flag
> +		 * handling from 'tcp_sendmsg_locked()'.
>  		 */
> -		if (!sock_flag(sk_vsock(vsk), SOCK_ZEROCOPY))
> -			info->msg->msg_flags &= ~MSG_ZEROCOPY;

So previously without SOCK_ZEROCOPY, MSG_ZEROCOPY was always ignored...


> +		if (info->msg->msg_ubuf) {
> +			uarg = info->msg->msg_ubuf;
> +			can_zcopy = virtio_transport_can_zcopy(t_ops, info, pkt_len);

now it's not in this case?


Maybe the right call, but saying "does not change logic" seems wrong.


> +		} else if (sock_flag(sk_vsock(vsk), SOCK_ZEROCOPY)) {
> +			uarg = msg_zerocopy_realloc(sk_vsock(vsk), pkt_len,
> +						    NULL, false);
> +			if (!uarg) {
> +				virtio_transport_put_credit(vvs, pkt_len);
> +				return -ENOMEM;
> +			}
>  
> -		if (info->msg->msg_flags & MSG_ZEROCOPY)
>  			can_zcopy = virtio_transport_can_zcopy(t_ops, info, pkt_len);
> +			if (!can_zcopy)
> +				uarg_to_msgzc(uarg)->zerocopy = 0;
>  
> +			have_uref = true;
> +		}
> +
> +		/* 'can_zcopy' means that this transmission will be
> +		 * in zerocopy way (e.g. using 'frags' array).
> +		 */
>  		if (can_zcopy)
>  			max_skb_len = min_t(u32, VIRTIO_VSOCK_MAX_PKT_BUF_SIZE,
>  					    (MAX_SKB_FRAGS * PAGE_SIZE));
> -
> -		if (info->msg->msg_flags & MSG_ZEROCOPY &&
> -		    info->op == VIRTIO_VSOCK_OP_RW) {
> -			uarg = info->msg->msg_ubuf;
> -
> -			if (!uarg) {
> -				uarg = msg_zerocopy_realloc(sk_vsock(vsk),
> -							    pkt_len, NULL, false);
> -				if (!uarg) {
> -					virtio_transport_put_credit(vvs, pkt_len);
> -					return -ENOMEM;
> -				}
> -
> -				if (!can_zcopy)
> -					uarg_to_msgzc(uarg)->zerocopy = 0;
> -
> -				have_uref = true;
> -			}
> -		}
>  	}
>  
>  	rest_len = pkt_len;
> -- 
> 2.25.1

