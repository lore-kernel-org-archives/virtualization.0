Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73AA737F8C0
	for <virtualization@lists.linux.dev>; Sun,  9 Aug 2026 22:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786315724; cv=none; b=HO1Ay0gb5uSYO8xGO/AAjmZjRMXECGGThAiaCwLmhR6GqFcu3zGwoaEJHxaqs8yjwoX/176fzvIRr+9WF5+DHy69tTdc0H53c1ks1HP2Cg7wzH5t7PGrt6c0HGzBbqdgwiWzN5uct7wfeZSUZjnBujm3WoQyd3byt711Ktj+aI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786315724; c=relaxed/simple;
	bh=KM8prxrVrtAsOR6nP5susi/p8S+6RyFtfZi+PBXuziI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=VSDMd+1isCju+rUwFGMgxdvFBrB9HjgfWmzBbq/AnAYSV6DXQF9sDabWxefqmeiGbpZcuqhfzYK56Qz3s1gkQikAQVPniBOcff5+I3Fh5b4EG42vo+cQqzlOOuQeZaPz+t/E7O2dxUdfoRkB5rdVooICS8uoTQDOkpRrWEZDm6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XJnXpNtz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XJnXpNtz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786315721;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vdUvLyEIlQ9ZJUxPR28fKR6RB33aERo4aOGowMmRbvM=;
	b=XJnXpNtzYkv0zi6fzZZe1UU9lmcJJ+c0/2sv4AURrLE9+YV036UA6uX6aKrAJuTDUnuiJA
	4TfEDn99DNeSwt7KwVIkeOAyMAOEzmjn7Uwn6oJZZVflGNy0JGRgyU2tUM2wIOzM7Dojf+
	WmCs0A0lVPIF1L4nhCk2s/8Hz5JmniI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-696-nCvKNkBQNLCr14QJgutGGg-1; Sun, 09 Aug 2026 18:48:40 -0400
X-MC-Unique: nCvKNkBQNLCr14QJgutGGg-1
X-Mimecast-MFC-AGG-ID: nCvKNkBQNLCr14QJgutGGg_1786315719
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-495474a5fbcso11952045e9.1
        for <virtualization@lists.linux.dev>; Sun, 09 Aug 2026 15:48:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786315719; x=1786920519;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vdUvLyEIlQ9ZJUxPR28fKR6RB33aERo4aOGowMmRbvM=;
        b=CS45VbDHGA82dkTnnY04rjCl1jJugn+4hmLH5z3I9op0CmfUPrRY4jNLNvZsFcGdYT
         Iv4OmK/I9KsmIlyAfjt1c3QZlQHfpUPefko+Olu3ZwwxBSa3aj2nGt9TOEzYGvooofmB
         bm/JLY/iEUq2bSMqTpVQkmQUldFzlyR6f/pSTbSdvT6209QYERqhreI9bhScLYH+KGTA
         a5Br9+jqYUtZ3sRkKE71uaMcy95f8zOXdd23JrRjdSw+JNWwzHDRTnS4Irz3bqxA9T7r
         /KekgiGfh/Zmo9GEw7ic5VSbZed9TloiDcSQ5I2/AJVRnFgduc/yUke7AL5mxLoP9v5k
         hRRA==
X-Forwarded-Encrypted: i=1; AHgh+Rr9GzCd+h70dNecTTVaX+qP9h/9SUnLkmHhMBQ6Qq0WTexyHpl8Z1wxVQp4WMeAw10aR0Eh4lhG2UJ8WSN+yw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwEBUJeaGkbu5wOi+qzlRXIYxH5D/h0n8NVsu92uc6iJqBOlFv+
	23/JTH7HeVj+jbTfyr/W1tlw99gAz63Dwf02cJO+83jHNM0Bqj5xGu1LZ0wjcp9na0Ueo3UVQj6
	uqEgWQXW7NsQgbo8qA9bZZQ9boTcNQV7TACn+fD8OxNn1dp0cfSzyCM9+FnJ4Lb/6YTcUUAVwX4
	VJ
X-Gm-Gg: AR+sD13BdFJJk/hbn1CHk4UqXNyDRkda0F5Zz0GNTNCP1eIbZmVae6dXV4uwaGxiOo7
	Y7kcqlI5B02MnScpP2ze+oUaaIIk+OEAem7zsRYtb3rg97JBUD+3v1nH9B3bVx20DY5D1iRbNS/
	JoiCBehQFmqNhonuF8abtWQAa9CqjkF8G9h9CiDIpB7ttXu1yvQo2D9R1dqzlUbgM2PnMn39OlM
	3+4yjPFQyJbdMkTuNeP6pjShRyNxgcb7ytiYF5j23VtcKQqJUx5Tyk+Zseh6cMgBli6MU7m37Q+
	KyHbuUjAV+b+ZHlbtBy2FEUqvhPMJrNI4kYcAXv26g6VO9h8Ue7bdRMakNlmfxQHxZryIWFvDOs
	vXVyvmhnu8eWhT8+tOlPlbw==
X-Received: by 2002:a05:600c:c8a:b0:493:eed4:7210 with SMTP id 5b1f17b1804b1-49961992a4amr220473745e9.11.1786315718615;
        Sun, 09 Aug 2026 15:48:38 -0700 (PDT)
X-Received: by 2002:a05:600c:c8a:b0:493:eed4:7210 with SMTP id 5b1f17b1804b1-49961992a4amr220473375e9.11.1786315718192;
        Sun, 09 Aug 2026 15:48:38 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-39-98.inter.net.il. [80.230.39.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-480021509a5sm25733149f8f.16.2026.08.09.15.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 15:48:37 -0700 (PDT)
Date: Sun, 9 Aug 2026 18:48:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alexander Graf <graf@amazon.com>
Cc: Jason Wang <jasowangio@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	nh-open-source@amazon.com, Stefan Hajnoczi <stefanha@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH 02/12] virtio_ring: validate premapped addresses
 through the device's map
Message-ID: <20260809184247-mutt-send-email-mst@kernel.org>
References: <20260809182010.32931-1-graf@amazon.com>
 <20260809182010.32931-3-graf@amazon.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260809182010.32931-3-graf@amazon.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: LC1fRJW6EiIMGyjnzbSQxNW6_2sIglupB_1teabXOQY_1786315719
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Aug 09, 2026 at 06:20:00PM +0000, Alexander Graf wrote:
> Callers that forget to handle a mapping failure may accidentally pass
> DMA_MAPPING_ERROR as target map address and we don't error out for it.
> The mapped path in vring_map_one_sg() checks the result, but the
> premapped path takes the address as given. That makes it more difficult
> to identify accidental API misuse.


Nah.

We don't spread null checks all over the place and this is the same.


> 
> Run the address through the existing vring_mapping_error(), which asks
> the device's virtio_map_ops mapping_error op or dma_mapping_error(),
> warn once and return -ENOMEM when it rejects the address. Document
> where the premapped helpers expect their addresses to come from, since
> an address from any other source is indistinguishable from a valid one.
> That way an API misuse shows up at the call that made it.

Commit log does not match what doc patches do.

> Assisted-by: Kiro:claude-opus-5 checkpatch sparse
> Signed-off-by: Alexander Graf <graf@amazon.com>
> ---
>  drivers/virtio/virtio_ring.c | 40 ++++++++++++++++++++++++++++++++++--
>  1 file changed, 38 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index b438dc2ce1b8..9caa4f96204f 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -499,6 +499,19 @@ static int vring_map_one_sg(const struct vring_virtqueue *vq, struct scatterlist
>  	if (premapped) {
>  		*addr = sg_dma_address(sg);
>  		*len = sg_dma_len(sg);
> +
> +		/*
> +		 * The caller mapped this itself, so the map it used is the
> +		 * only thing that can judge the result.  Ask it rather than
> +		 * skipping the check the mapped path performs: a caller that
> +		 * ignored a failed mapping would otherwise publish the
> +		 * reserved error value to the device.
> +		 */
> +		if (dev_WARN_ONCE(&vq->vq.vdev->dev,
> +				  vring_mapping_error(vq, *addr),
> +				  "premapped buffer holds no valid mapping\n"))
> +			return -ENOMEM;
> +
>  		return 0;
>  	}
>  
> @@ -2910,6 +2923,14 @@ EXPORT_SYMBOL_GPL(virtqueue_add_outbuf);
>   * @data: the token identifying the buffer.
>   * @gfp: how to do memory allocations (if necessary).
>   *
> + * Each entry of @sg must carry an address the caller obtained for this
> + * virtqueue: from the DMA API when virtqueue_dma_dev() returns a device, and
> + * from virtqueue_map_page_attrs() when it returns NULL, because the device
> + * then interprets every address published to it in its own terms.  Only an
> + * address the map itself rejects is caught here; an address from any other
> + * source is indistinguishable from a valid one and reaches the device
> + * unchanged.
> + *
>   * Caller must ensure we don't call this with other virtqueue operations
>   * at the same time (except where noted).
>   *
> @@ -3008,6 +3029,14 @@ EXPORT_SYMBOL_GPL(virtqueue_add_inbuf_ctx);
>   * @ctx: extra context for the token
>   * @gfp: how to do memory allocations (if necessary).
>   *
> + * Each entry of @sg must carry an address the caller obtained for this
> + * virtqueue: from the DMA API when virtqueue_dma_dev() returns a device, and
> + * from virtqueue_map_page_attrs() when it returns NULL, because the device
> + * then interprets every address published to it in its own terms.  Only an
> + * address the map itself rejects is caught here; an address from any other
> + * source is indistinguishable from a valid one and reaches the device
> + * unchanged.

I don't see what this comment gets us.
And let's not do this half hearted validation.


> + *
>   * Caller must ensure we don't call this with other virtqueue operations
>   * at the same time (except where noted).
>   *
> @@ -3025,10 +3054,17 @@ int virtqueue_add_inbuf_premapped(struct virtqueue *vq,
>  EXPORT_SYMBOL_GPL(virtqueue_add_inbuf_premapped);
>  
>  /**
> - * virtqueue_dma_dev - get the dma dev
> + * virtqueue_dma_dev - get the device to use for DMA API calls
>   * @_vq: the struct virtqueue we're talking about.
>   *
> - * Returns the dma dev. That can been used for dma api.
> + * A NULL return means this virtqueue publishes no DMA addresses: either it
> + * needs no mapping at all, or the device supplies its own virtio_map_ops and
> + * interprets every address published to it in its own terms.  A caller that
> + * maps buffers itself must therefore check for NULL before using the DMA API
> + * on this virtqueue's behalf, and use virtqueue_map_page_attrs() when it is,
> + * which maps through whichever of the two the device uses.


Too verbose and repetetive. E.g. of course people who call virtqueue_dma_dev
do it to "map bufers itself".

> + *
> + * Return: the device to use for DMA API calls, or NULL when there is none.
>   */
>  struct device *virtqueue_dma_dev(struct virtqueue *_vq)
>  {

