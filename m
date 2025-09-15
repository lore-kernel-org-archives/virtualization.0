Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9761239591
	for <virtualization@lists.linux.dev>; Mon, 15 Sep 2025 16:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757952198; cv=none; b=MWt+W9kOC+8o4engYe6fMEe86RgepIzkN/aWcreS0wkPgWok6fOjO7/DDhnQgHssZIecDXahYZKJh0bgMrFaSyKSYICy8Ccd2yN47c5EJHZ1rc6Ss+RsWAdTA2+RgCOvOUBeEgFzXUBXsCEVEpPuvFhdVWpxOMxsVUkggt66hy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757952198; c=relaxed/simple;
	bh=UgpAiUSkfqsIiMi/5vuPzG4RqiLKzyDrVtzPJiZs6b0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Bmc1rFUbZekA9Bcmpcs0Qg1e/bBf6bMYS6LFjbnEsipQ5SbzE7Is0Chj0iYzhjtLxBtEYeYXNRtglkxspyyf2vi5XKrllPYbnxLZAYR/VTlH1C3g1G6kb50WRIQRdd0OKu/0vRMaFro75mVjLnJQA6KqZOR/SCtuAlJR7crG664=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dPKAIfnB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dPKAIfnB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757952195;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mxYYDZD7WvA8pBIh8RZ+XYWpfwg8m7Jck2wpptSqpfw=;
	b=dPKAIfnBBkSOZaiOxdGP1PiuyU56PTuZZY8Swx0Ha7AJPZgB7Lj+R09u6+IA/gZE/QebLe
	UnSi05Z8/e1sES4/87i3o9m3xEkGtTn29MOoE714t9URm3KTYNvlTu8RwGkC+TtuxvulOB
	p77eMs8vuQ0p2QzAmZF7AyM/6jTBtF0=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-179-Eoqb4NAxNj6WLOtAFh35XA-1; Mon, 15 Sep 2025 12:03:13 -0400
X-MC-Unique: Eoqb4NAxNj6WLOtAFh35XA-1
X-Mimecast-MFC-AGG-ID: Eoqb4NAxNj6WLOtAFh35XA_1757952192
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-6215a926e31so3517546a12.3
        for <virtualization@lists.linux.dev>; Mon, 15 Sep 2025 09:03:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757952192; x=1758556992;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mxYYDZD7WvA8pBIh8RZ+XYWpfwg8m7Jck2wpptSqpfw=;
        b=XTudHLWteWm2MZpfJNBirl1RcFiiQj4Pk+mm0J6XUUq/Tnj5k+IC9oskMZdCOJKsib
         f0GFqYQ5GfaJZ9X2cvQG9vSQJw/oe1yS3FXzRDdTb3W+utNy8ecNUNe2f9VBxPA5hB67
         TBbvst0mCtdDZG8RGjnBthcRvOo5JjaxGy51WUcQlqimjWz861OW4Xi4a09lDlsUpMUL
         DdRscH0lwH1YbyE8E5t3l8QA68dP62y8g9XtkmWPPxfym6sKoy2rETk5i4ukdj7eGAaa
         dLUewuayNl1BQ+oZMHy/hK0j4Zcei2j0IqyueYbdmOM+rDavufkWZd9v13oY5MPlPpl1
         wPKg==
X-Forwarded-Encrypted: i=1; AJvYcCXt6AJaR9xq66OEKyGyHlhKOof49Dr0cPqzIJ/fDCHOV9cP+d7ABrCUqzpkgmruNibyX1Ivz5fhKjPoqCJZtA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxsQpR47Jlp+9ZxqDW+gfJo7RUFGOiNSLo330BZ/jEBAHAbXA9A
	ATbf1nr7g88uzaSdeGD7g73/6gs1Ye2yNWshFvxTPxq9znGf9uLT0sOgUaloi+YFGStO9qxmG3u
	H9ejgHS067zWvvazzJPuaOcIxJtjyiyEE7CPPfet0rZJ5GvCAbhDlYsdhhh83mq8ouj2Q
X-Gm-Gg: ASbGncujiVJY91BX8pD+/h8bvBF0doa3VUyL8OL3q4gllAaNuRdKxKK7eOyBBNDUg/T
	AsgDNCoCCQw8JLy1udbuFQ9FmK5wEEgQrK3wapfE32qV4/rT6KXOjd0gY8JxtJBkyIws8dxUjCi
	IYzBnWNrECvCILW7LxYr64ZM2DZqwld+1k7R3RzKiOiHpgFWUiuqo46NcYN5bMDrknH0sLGB5tS
	iuwbJ6aiMAUenMpWHlzaE+GFfHSodewtGV7kcjtBGhNK98EV3tjpSe87MkT0RxInjk72dxBzYoC
	PNsQH7h65sBVLr/6tDCniBqVbHVl
X-Received: by 2002:a05:6402:5c9:b0:62f:5cd8:9b2e with SMTP id 4fb4d7f45d1cf-62f5cd8a072mr216478a12.29.1757952191712;
        Mon, 15 Sep 2025 09:03:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFjGn2Z0BOy+sfljpNHO+I5IXHBbdbcb8SYTOdauYndHQ59yMvvIQnAzpSL9eW6X/im0GKszQ==
X-Received: by 2002:a05:6402:5c9:b0:62f:5cd8:9b2e with SMTP id 4fb4d7f45d1cf-62f5cd8a072mr216441a12.29.1757952191084;
        Mon, 15 Sep 2025 09:03:11 -0700 (PDT)
Received: from redhat.com ([31.187.78.47])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62f454f4288sm1899363a12.5.2025.09.15.09.03.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 09:03:10 -0700 (PDT)
Date: Mon, 15 Sep 2025 12:03:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: eperezma@redhat.com, jonah.palmer@oracle.com, kuba@kernel.org,
	jon@nutanix.com, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net 2/2] vhost-net: correctly flush batched packet before
 enabling notification
Message-ID: <20250915120210-mutt-send-email-mst@kernel.org>
References: <20250912082658.2262-1-jasowang@redhat.com>
 <20250912082658.2262-2-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250912082658.2262-2-jasowang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: CmMCpR_n27bY8tr5ZuLwtVvfqSDY1MbiffW3JUG3oWA_1757952192
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 12, 2025 at 04:26:58PM +0800, Jason Wang wrote:
> Commit 8c2e6b26ffe2 ("vhost/net: Defer TX queue re-enable until after
> sendmsg") tries to defer the notification enabling by moving the logic
> out of the loop after the vhost_tx_batch() when nothing new is
> spotted. This will bring side effects as the new logic would be reused
> for several other error conditions.
> 
> One example is the IOTLB: when there's an IOTLB miss, get_tx_bufs()
> might return -EAGAIN and exit the loop and see there's still available
> buffers, so it will queue the tx work again until userspace feed the
> IOTLB entry correctly. This will slowdown the tx processing and may
> trigger the TX watchdog in the guest.
> 
> Fixing this by stick the notificaiton enabling logic inside the loop
> when nothing new is spotted and flush the batched before.
> 
> Reported-by: Jon Kohler <jon@nutanix.com>
> Cc: stable@vger.kernel.org
> Fixes: 8c2e6b26ffe2 ("vhost/net: Defer TX queue re-enable until after sendmsg")
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/vhost/net.c | 33 +++++++++++++--------------------
>  1 file changed, 13 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index 16e39f3ab956..3611b7537932 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -765,11 +765,11 @@ static void handle_tx_copy(struct vhost_net *net, struct socket *sock)
>  	int err;
>  	int sent_pkts = 0;
>  	bool sock_can_batch = (sock->sk->sk_sndbuf == INT_MAX);
> -	bool busyloop_intr;
>  	bool in_order = vhost_has_feature(vq, VIRTIO_F_IN_ORDER);
>  
>  	do {
> -		busyloop_intr = false;
> +		bool busyloop_intr = false;
> +
>  		if (nvq->done_idx == VHOST_NET_BATCH)
>  			vhost_tx_batch(net, nvq, sock, &msg);
>  
> @@ -780,10 +780,18 @@ static void handle_tx_copy(struct vhost_net *net, struct socket *sock)
>  			break;
>  		/* Nothing new?  Wait for eventfd to tell us they refilled. */
>  		if (head == vq->num) {
> -			/* Kicks are disabled at this point, break loop and
> -			 * process any remaining batched packets. Queue will
> -			 * be re-enabled afterwards.
> +			/* Flush batched packets before enabling
> +			 * virqtueue notification to reduce
> +			 * unnecssary virtqueue kicks.
>  			 */
> +			vhost_tx_batch(net, nvq, sock, &msg);

So why don't we do this in the "else" branch"? If we are busy polling
then we are not enabling kicks, so is there a reason to flush?


> +			if (unlikely(busyloop_intr)) {
> +				vhost_poll_queue(&vq->poll);
> +			} else if (unlikely(vhost_enable_notify(&net->dev,
> +								vq))) {
> +				vhost_disable_notify(&net->dev, vq);
> +				continue;
> +			}
>  			break;
>  		}
>  
> @@ -839,22 +847,7 @@ static void handle_tx_copy(struct vhost_net *net, struct socket *sock)
>  		++nvq->done_idx;
>  	} while (likely(!vhost_exceeds_weight(vq, ++sent_pkts, total_len)));
>  
> -	/* Kicks are still disabled, dispatch any remaining batched msgs. */
>  	vhost_tx_batch(net, nvq, sock, &msg);
> -
> -	if (unlikely(busyloop_intr))
> -		/* If interrupted while doing busy polling, requeue the
> -		 * handler to be fair handle_rx as well as other tasks
> -		 * waiting on cpu.
> -		 */
> -		vhost_poll_queue(&vq->poll);
> -	else
> -		/* All of our work has been completed; however, before
> -		 * leaving the TX handler, do one last check for work,
> -		 * and requeue handler if necessary. If there is no work,
> -		 * queue will be reenabled.
> -		 */
> -		vhost_net_busy_poll_try_queue(net, vq);
>  }
>  
>  static void handle_tx_zerocopy(struct vhost_net *net, struct socket *sock)
> -- 
> 2.34.1

