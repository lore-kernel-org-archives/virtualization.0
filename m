Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EAFE330D22
	for <virtualization@lists.linux-foundation.org>; Thu, 13 Nov 2025 08:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763021594; cv=none; b=jpcIkeOcsmDrnM+dGN6c4UGuI6Wn9sYqslrXvy6EU5P9cKS6RQ2fn0AgISSuOTYm+FikfEP7TRZ2VXyEoaoi1NZ/g9ubmJbeukAMfD8DHhhqcejeRwU4AvoRXUWy0UGiYAU1pbuongNU1K2mbEb5oWH5zrL2YnI/ws+RbGIns2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763021594; c=relaxed/simple;
	bh=Ap2yBhzXTU6O9fGE+Hj6HPv06KYwiyh5Yi2mJXSIy64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=iVo+WZv1ee+IbXADeSAiWEl7T3PMIswoFtU3aQx72nhJ5752mvjQ93+nhcmzAirNV/IdiPXSzDKUNRs7u2nhVyaI5fwRKvhehRs2419ita+EArndgvyCGEwKFsvyayKHZ1SismvFq1KuqblcFoDQO+MV3XVW9Oze9swzpI69ip4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CXT2YJTY; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CXT2YJTY"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1D0E981E4D
	for <virtualization@lists.linux-foundation.org>; Thu, 13 Nov 2025 08:13:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.792
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YMYAuF4H6sH9 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Nov 2025 08:13:10 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org E77CE81E4C
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E77CE81E4C
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CXT2YJTY
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E77CE81E4C
	for <virtualization@lists.linux-foundation.org>; Thu, 13 Nov 2025 08:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763021588;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4DGVaSw4kPeGIDKxD03tfYFZ4BdD6dssNRKM1w0msCk=;
	b=CXT2YJTY1Nqk/lRMblEf1ThTmZhqk+8CDp6xVJiLsccz5izRRKz1GAssE17iBPgQwl0yy+
	oTtGgPrQ9MJyIFlK/we2QuBsSuldxlFYqYbGLWeGZtg9FwZK4iy3wMhRlVZvgJRpdgnE6j
	Ebd9Wwv+deY7u9OdakQxUYs985309G0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-pw7Y3tWdNI-PZ7K-7rUcDA-1; Thu, 13 Nov 2025 03:13:07 -0500
X-MC-Unique: pw7Y3tWdNI-PZ7K-7rUcDA-1
X-Mimecast-MFC-AGG-ID: pw7Y3tWdNI-PZ7K-7rUcDA_1763021586
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-477563e531cso4744755e9.1
        for <virtualization@lists.linux-foundation.org>; Thu, 13 Nov 2025 00:13:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763021586; x=1763626386;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4DGVaSw4kPeGIDKxD03tfYFZ4BdD6dssNRKM1w0msCk=;
        b=m8cWiOlZo6MYRuGYw4gCtDwx6wcDKurSF04XGzOjE+AaLC+BBOm8Jg1rhC/a3nVaE7
         pwwXq9w6T+Mo+DPbsjG/iPizk5Z4vFY8nFQzcRhorht4NZ3+rGIxQyOzIoacADUlhL++
         PqxhZx/sK008sRwMF3kNkqq/Lka8Jb+H0n6nUiDYUddV5IEZeMXdZC/kF48qbL3WMrdh
         Huef0wFucfqX99HgqefXZF8BWBV4BNG8R0tyx9qRTbPRbLjcusFRj2OWnWDHrRCZceGh
         ahH1Bt6wD7dbScsAOY5H9RqnpVFHOY22K3cqUxiQYO0hvtA/O7YTslGCvByfy0+6r/Ee
         NgnQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXrjA9tLVHx0oScrV2AU9/vu/Fy4vavL0ljRUOGTOWuimG+7saJZpQZU64iwZdVu9w46Ic/uyzkFHOZGD0kw==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YxSo7mqg5lWEodqO6P9SL6HvE9chblTzBbNXk14y+kcP4hF7GSJ
	tdHvtSt7BBZw3kavJIa6Wn+7BWbF+Bb7t3CB+md5KDt11JXxj/3BHcCYLdoFHuA+IHPo/Tti+sO
	l8QAaMpWpV64dNAFnbRFmcJ9mcjj+A1K1KltRJZAGK2hMj3K81+BwaubmRmSc+KDoHa+wY2rnEd
	fMxBzmKnk=
X-Gm-Gg: ASbGncuylWYkWEnzTtBeeFVVvBNNRoxd8EgYK2gr/MIl50MTEnCGTDDW3S+fS4hsNyO
	ZFK1VxmfnzMmHJTrmn+yYVIt8fodSYExFozEZX5R0X0XEg+nLyIO00oDItWrk0Ha048jfy9GrXF
	teuQbMzR4m7gmOrYChW8lhhVBRmp+OLQXoMxZ6lWC6g9SvjB0uJmi+Y5lAcAFJxm41Ugv0FrkUO
	6oSYsEvIzA76Yv27Z7CbiUz/I6RDjK6mbiSDdVCeklQ/iybnWf4TnMHjg7MlkIqMuYUPRdfEbv5
	I6hEwu8Hdh3KUJ9tYToAHuE2kHEmRAyDVDWaduBdqzmwkeYuXLALli6eNxix/lnszCrFc+CPmSJ
	hHpVD7pamoCj2BbBEOwA=
X-Received: by 2002:a05:600c:a44:b0:477:832c:86ae with SMTP id 5b1f17b1804b1-4778707ca20mr55192315e9.12.1763021585439;
        Thu, 13 Nov 2025 00:13:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGIQgN138Wh9SyzvdeVmx3/FSQLTRYGtc1iBG+F/973cdwN4YYhSCw6TLEU3JsjzbHZAdvt9g==
X-Received: by 2002:a05:600c:a44:b0:477:832c:86ae with SMTP id 5b1f17b1804b1-4778707ca20mr55191905e9.12.1763021584764;
        Thu, 13 Nov 2025 00:13:04 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4778c8a992bsm20321275e9.16.2025.11.13.00.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 00:13:04 -0800 (PST)
Date: Thu, 13 Nov 2025 03:13:01 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net] vhost: rewind next_avail_head while discarding
 descriptors
Message-ID: <20251113030230-mutt-send-email-mst@kernel.org>
References: <20251113015420.3496-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251113015420.3496-1-jasowang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: UL065di4JhJp24gDITrIN2Pzt_IfsMTbaqe5w4S1-7U_1763021586
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 13, 2025 at 09:54:20AM +0800, Jason Wang wrote:
> When discarding descriptors with IN_ORDER, we should rewind
> next_avail_head otherwise it would run out of sync with
> last_avail_idx. This would cause driver to report
> "id X is not a head".
> 
> Fixing this by returning the number of descriptors that is used for
> each buffer via vhost_get_vq_desc_n() so caller can use the value
> while discarding descriptors.
> 
> Fixes: 67a873df0c41 ("vhost: basic in order support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Wow that change really caused a lot of fallout.

Thanks for the patch! Yet something to improve:


> ---
>  drivers/vhost/net.c   | 53 ++++++++++++++++++++++++++-----------------
>  drivers/vhost/vhost.c | 43 ++++++++++++++++++++++++-----------
>  drivers/vhost/vhost.h |  9 +++++++-
>  3 files changed, 70 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index 35ded4330431..8f7f50acb6d6 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -592,14 +592,15 @@ static void vhost_net_busy_poll(struct vhost_net *net,
>  static int vhost_net_tx_get_vq_desc(struct vhost_net *net,
>  				    struct vhost_net_virtqueue *tnvq,
>  				    unsigned int *out_num, unsigned int *in_num,
> -				    struct msghdr *msghdr, bool *busyloop_intr)
> +				    struct msghdr *msghdr, bool *busyloop_intr,
> +				    unsigned int *ndesc)
>  {
>  	struct vhost_net_virtqueue *rnvq = &net->vqs[VHOST_NET_VQ_RX];
>  	struct vhost_virtqueue *rvq = &rnvq->vq;
>  	struct vhost_virtqueue *tvq = &tnvq->vq;
>  
> -	int r = vhost_get_vq_desc(tvq, tvq->iov, ARRAY_SIZE(tvq->iov),
> -				  out_num, in_num, NULL, NULL);
> +	int r = vhost_get_vq_desc_n(tvq, tvq->iov, ARRAY_SIZE(tvq->iov),
> +				    out_num, in_num, NULL, NULL, ndesc);
>  
>  	if (r == tvq->num && tvq->busyloop_timeout) {
>  		/* Flush batched packets first */
> @@ -610,8 +611,8 @@ static int vhost_net_tx_get_vq_desc(struct vhost_net *net,
>  
>  		vhost_net_busy_poll(net, rvq, tvq, busyloop_intr, false);
>  
> -		r = vhost_get_vq_desc(tvq, tvq->iov, ARRAY_SIZE(tvq->iov),
> -				      out_num, in_num, NULL, NULL);
> +		r = vhost_get_vq_desc_n(tvq, tvq->iov, ARRAY_SIZE(tvq->iov),
> +					out_num, in_num, NULL, NULL, ndesc);
>  	}
>  
>  	return r;
> @@ -642,12 +643,14 @@ static int get_tx_bufs(struct vhost_net *net,
>  		       struct vhost_net_virtqueue *nvq,
>  		       struct msghdr *msg,
>  		       unsigned int *out, unsigned int *in,
> -		       size_t *len, bool *busyloop_intr)
> +		       size_t *len, bool *busyloop_intr,
> +		       unsigned int *ndesc)
>  {
>  	struct vhost_virtqueue *vq = &nvq->vq;
>  	int ret;
>  
> -	ret = vhost_net_tx_get_vq_desc(net, nvq, out, in, msg, busyloop_intr);
> +	ret = vhost_net_tx_get_vq_desc(net, nvq, out, in, msg,
> +				       busyloop_intr, ndesc);
>  
>  	if (ret < 0 || ret == vq->num)
>  		return ret;
> @@ -766,6 +769,7 @@ static void handle_tx_copy(struct vhost_net *net, struct socket *sock)
>  	int sent_pkts = 0;
>  	bool sock_can_batch = (sock->sk->sk_sndbuf == INT_MAX);
>  	bool in_order = vhost_has_feature(vq, VIRTIO_F_IN_ORDER);
> +	unsigned int ndesc = 0;
>  
>  	do {
>  		bool busyloop_intr = false;
> @@ -774,7 +778,7 @@ static void handle_tx_copy(struct vhost_net *net, struct socket *sock)
>  			vhost_tx_batch(net, nvq, sock, &msg);
>  
>  		head = get_tx_bufs(net, nvq, &msg, &out, &in, &len,
> -				   &busyloop_intr);
> +				   &busyloop_intr, &ndesc);
>  		/* On error, stop handling until the next kick. */
>  		if (unlikely(head < 0))
>  			break;
> @@ -806,7 +810,7 @@ static void handle_tx_copy(struct vhost_net *net, struct socket *sock)
>  				goto done;
>  			} else if (unlikely(err != -ENOSPC)) {
>  				vhost_tx_batch(net, nvq, sock, &msg);
> -				vhost_discard_vq_desc(vq, 1);
> +				vhost_discard_vq_desc(vq, 1, ndesc);
>  				vhost_net_enable_vq(net, vq);
>  				break;
>  			}
> @@ -829,7 +833,7 @@ static void handle_tx_copy(struct vhost_net *net, struct socket *sock)
>  		err = sock->ops->sendmsg(sock, &msg, len);
>  		if (unlikely(err < 0)) {
>  			if (err == -EAGAIN || err == -ENOMEM || err == -ENOBUFS) {
> -				vhost_discard_vq_desc(vq, 1);
> +				vhost_discard_vq_desc(vq, 1, ndesc);
>  				vhost_net_enable_vq(net, vq);
>  				break;
>  			}
> @@ -868,6 +872,7 @@ static void handle_tx_zerocopy(struct vhost_net *net, struct socket *sock)
>  	int err;
>  	struct vhost_net_ubuf_ref *ubufs;
>  	struct ubuf_info_msgzc *ubuf;
> +	unsigned int ndesc = 0;
>  	bool zcopy_used;
>  	int sent_pkts = 0;
>  
> @@ -879,7 +884,7 @@ static void handle_tx_zerocopy(struct vhost_net *net, struct socket *sock)
>  
>  		busyloop_intr = false;
>  		head = get_tx_bufs(net, nvq, &msg, &out, &in, &len,
> -				   &busyloop_intr);
> +				   &busyloop_intr, &ndesc);
>  		/* On error, stop handling until the next kick. */
>  		if (unlikely(head < 0))
>  			break;
> @@ -941,7 +946,7 @@ static void handle_tx_zerocopy(struct vhost_net *net, struct socket *sock)
>  					vq->heads[ubuf->desc].len = VHOST_DMA_DONE_LEN;
>  			}
>  			if (retry) {
> -				vhost_discard_vq_desc(vq, 1);
> +				vhost_discard_vq_desc(vq, 1, ndesc);
>  				vhost_net_enable_vq(net, vq);
>  				break;
>  			}
> @@ -1045,11 +1050,12 @@ static int get_rx_bufs(struct vhost_net_virtqueue *nvq,
>  		       unsigned *iovcount,
>  		       struct vhost_log *log,
>  		       unsigned *log_num,
> -		       unsigned int quota)
> +		       unsigned int quota,
> +		       unsigned int *ndesc)
>  {
>  	struct vhost_virtqueue *vq = &nvq->vq;
>  	bool in_order = vhost_has_feature(vq, VIRTIO_F_IN_ORDER);
> -	unsigned int out, in;
> +	unsigned int out, in, desc_num, n = 0;
>  	int seg = 0;
>  	int headcount = 0;
>  	unsigned d;
> @@ -1064,9 +1070,9 @@ static int get_rx_bufs(struct vhost_net_virtqueue *nvq,
>  			r = -ENOBUFS;
>  			goto err;
>  		}
> -		r = vhost_get_vq_desc(vq, vq->iov + seg,
> -				      ARRAY_SIZE(vq->iov) - seg, &out,
> -				      &in, log, log_num);
> +		r = vhost_get_vq_desc_n(vq, vq->iov + seg,
> +					ARRAY_SIZE(vq->iov) - seg, &out,
> +					&in, log, log_num, &desc_num);
>  		if (unlikely(r < 0))
>  			goto err;
>  
> @@ -1093,6 +1099,7 @@ static int get_rx_bufs(struct vhost_net_virtqueue *nvq,
>  		++headcount;
>  		datalen -= len;
>  		seg += in;
> +		n += desc_num;
>  	}
>  
>  	*iovcount = seg;
> @@ -1113,9 +1120,11 @@ static int get_rx_bufs(struct vhost_net_virtqueue *nvq,
>  		nheads[0] = headcount;
>  	}
>  
> +	*ndesc = n;
> +
>  	return headcount;
>  err:
> -	vhost_discard_vq_desc(vq, headcount);
> +	vhost_discard_vq_desc(vq, headcount, n);

So here ndesc and n are the same, but below in vhost_discard_vq_desc
they are different. Fun.

>  	return r;
>  }
>  
> @@ -1151,6 +1160,7 @@ static void handle_rx(struct vhost_net *net)
>  	struct iov_iter fixup;
>  	__virtio16 num_buffers;
>  	int recv_pkts = 0;
> +	unsigned int ndesc;
>  
>  	mutex_lock_nested(&vq->mutex, VHOST_NET_VQ_RX);
>  	sock = vhost_vq_get_backend(vq);
> @@ -1182,7 +1192,8 @@ static void handle_rx(struct vhost_net *net)
>  		headcount = get_rx_bufs(nvq, vq->heads + count,
>  					vq->nheads + count,
>  					vhost_len, &in, vq_log, &log,
> -					likely(mergeable) ? UIO_MAXIOV : 1);
> +					likely(mergeable) ? UIO_MAXIOV : 1,
> +					&ndesc);
>  		/* On error, stop handling until the next kick. */
>  		if (unlikely(headcount < 0))
>  			goto out;
> @@ -1228,7 +1239,7 @@ static void handle_rx(struct vhost_net *net)
>  		if (unlikely(err != sock_len)) {
>  			pr_debug("Discarded rx packet: "
>  				 " len %d, expected %zd\n", err, sock_len);
> -			vhost_discard_vq_desc(vq, headcount);
> +			vhost_discard_vq_desc(vq, headcount, ndesc);
>  			continue;
>  		}
>  		/* Supply virtio_net_hdr if VHOST_NET_F_VIRTIO_NET_HDR */
> @@ -1252,7 +1263,7 @@ static void handle_rx(struct vhost_net *net)
>  		    copy_to_iter(&num_buffers, sizeof num_buffers,
>  				 &fixup) != sizeof num_buffers) {
>  			vq_err(vq, "Failed num_buffers write");
> -			vhost_discard_vq_desc(vq, headcount);
> +			vhost_discard_vq_desc(vq, headcount, ndesc);
>  			goto out;
>  		}
>  		nvq->done_idx += headcount;
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 8570fdf2e14a..b56568807588 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -2792,18 +2792,11 @@ static int get_indirect(struct vhost_virtqueue *vq,
>  	return 0;
>  }
>  
> -/* This looks in the virtqueue and for the first available buffer, and converts
> - * it to an iovec for convenient access.  Since descriptors consist of some
> - * number of output then some number of input descriptors, it's actually two
> - * iovecs, but we pack them into one and note how many of each there were.
> - *
> - * This function returns the descriptor number found, or vq->num (which is
> - * never a valid descriptor number) if none was found.  A negative code is
> - * returned on error. */

A new module API with no docs at all is not good.
Please add documentation to this one. vhost_get_vq_desc
is a subset and could refer to it.

> -int vhost_get_vq_desc(struct vhost_virtqueue *vq,
> -		      struct iovec iov[], unsigned int iov_size,
> -		      unsigned int *out_num, unsigned int *in_num,
> -		      struct vhost_log *log, unsigned int *log_num)
> +int vhost_get_vq_desc_n(struct vhost_virtqueue *vq,
> +			struct iovec iov[], unsigned int iov_size,
> +			unsigned int *out_num, unsigned int *in_num,
> +			struct vhost_log *log, unsigned int *log_num,
> +			unsigned int *ndesc)

>  {
>  	bool in_order = vhost_has_feature(vq, VIRTIO_F_IN_ORDER);
>  	struct vring_desc desc;
> @@ -2921,16 +2914,40 @@ int vhost_get_vq_desc(struct vhost_virtqueue *vq,
>  	vq->last_avail_idx++;
>  	vq->next_avail_head += c;
>  
> +	if (ndesc)
> +		*ndesc = c;
> +
>  	/* Assume notifications from guest are disabled at this point,
>  	 * if they aren't we would need to update avail_event index. */
>  	BUG_ON(!(vq->used_flags & VRING_USED_F_NO_NOTIFY));
>  	return head;
>  }
> +EXPORT_SYMBOL_GPL(vhost_get_vq_desc_n);
> +
> +/* This looks in the virtqueue and for the first available buffer, and converts
> + * it to an iovec for convenient access.  Since descriptors consist of some
> + * number of output then some number of input descriptors, it's actually two
> + * iovecs, but we pack them into one and note how many of each there were.
> + *
> + * This function returns the descriptor number found, or vq->num (which is
> + * never a valid descriptor number) if none was found.  A negative code is
> + * returned on error.
> + */
> +int vhost_get_vq_desc(struct vhost_virtqueue *vq,
> +		      struct iovec iov[], unsigned int iov_size,
> +		      unsigned int *out_num, unsigned int *in_num,
> +		      struct vhost_log *log, unsigned int *log_num)
> +{
> +	return vhost_get_vq_desc_n(vq, iov, iov_size, out_num, in_num,
> +				   log, log_num, NULL);
> +}
>  EXPORT_SYMBOL_GPL(vhost_get_vq_desc);
>  
>  /* Reverse the effect of vhost_get_vq_desc. Useful for error handling. */
> -void vhost_discard_vq_desc(struct vhost_virtqueue *vq, int n)
> +void vhost_discard_vq_desc(struct vhost_virtqueue *vq, int n,
> +			   unsigned int ndesc)

ndesc is number of descriptors? And n is what, in that case?


>  {
> +	vq->next_avail_head -= ndesc;
>  	vq->last_avail_idx -= n;
>  }
>  EXPORT_SYMBOL_GPL(vhost_discard_vq_desc);
> diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
> index 621a6d9a8791..69a39540df3d 100644
> --- a/drivers/vhost/vhost.h
> +++ b/drivers/vhost/vhost.h
> @@ -230,7 +230,14 @@ int vhost_get_vq_desc(struct vhost_virtqueue *,
>  		      struct iovec iov[], unsigned int iov_size,
>  		      unsigned int *out_num, unsigned int *in_num,
>  		      struct vhost_log *log, unsigned int *log_num);
> -void vhost_discard_vq_desc(struct vhost_virtqueue *, int n);
> +
> +int vhost_get_vq_desc_n(struct vhost_virtqueue *vq,
> +			struct iovec iov[], unsigned int iov_size,
> +			unsigned int *out_num, unsigned int *in_num,
> +			struct vhost_log *log, unsigned int *log_num,
> +			unsigned int *ndesc);
> +
> +void vhost_discard_vq_desc(struct vhost_virtqueue *, int n, unsigned int ndesc);
>  
>  bool vhost_vq_work_queue(struct vhost_virtqueue *vq, struct vhost_work *work);
>  bool vhost_vq_has_work(struct vhost_virtqueue *vq);
> -- 
> 2.31.1

