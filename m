Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795101192;
	b=bsKExagk6yjvEv/5T8G/H4g0OXNLayzFnNp805We9UqTFNrkPX09g9XOCWF20iV3qm6c
	 bU198Jn3k3eFrr1IiAa60hujLwAVwHx201zwKWZG11b5pJ3sZJx3OU2PkA1pXFGBaXH62
	 c3X2jmE0Za2eBmUkXlklZUX8XncPtUgJ/g/LdP2kucE1BGKjD9dEupxTmRIzL5Ljsi/Y/
	 Pln5Um+O4uHxR8UaM4BHaFmPtty2bhEPSAQxXSQea3u0CjG7ceXNvFmnfBctClnsWLnOs
	 hgn/2g9DSirnuQMtjJ+hzdhOE3AJHt5mXdOi2QMLlME8McjEzny7EAhFIqpdg0tNxGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795101192;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=aUaUnGVOD0AnB0qQi2tHlDtmvMhT+a6tdGKKo0EDxDI=;
	b=CrNLYjZi+9aw3mOVevNW/ntId45iXSprW22/zr6REXx/jbgrVQncaiokX/AL2DCZzLl1
	 cpmdDRB+/4yNaP4f0z3EqVNr5SacNfa0ztKT+nd9CUpstlD1nytN9KZvlsCm1rV7TInt4
	 iv4f4DEGKGr9M6kprNg5KMuAyT5UMOTRB2IlhDK6YwPkcNOMUFH7QkUuFRdkZjW1T8f59
	 funBowM2+JMSF6Mdo/mq50RZ8NN7lw80d0Wt8fmc+qNiTWz/SgMqV+si7uYwuFu+pZrYH
	 k6k6NDi6FVtjal6THS7NCvawJq0say5mrpWqFjr+524Fb4ZUYrr1KHiKpqrQqHgC08g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cBBWWVap;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1FE606A331
	for <virtualization@lists.linux.dev>; Thu, 19 Nov 2026 15:13:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B1FE606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cBBWWVap
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795101190;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aUaUnGVOD0AnB0qQi2tHlDtmvMhT+a6tdGKKo0EDxDI=;
	b=cBBWWVapW56sdmwQY5UMddI0JZ00u44zAESJw/cYaa/YKag+oEGwM+Y94SS/4m80b36Kgu
	jVzZlwz4hIox9aSwqY0g3Dz72dcTMHA/XmrVtIsinizMVXyKEOJldOUFWaorW+m2SJcBu1
	L8cH9GoeyXINmgQjiv3wDumYUXgu0FI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-rZFutJbnO1WnQ8qSqqBLgQ-1; Thu, 19 Nov 2026 10:13:07 -0500
X-MC-Unique: rZFutJbnO1WnQ8qSqqBLgQ-1
X-Mimecast-MFC-AGG-ID: rZFutJbnO1WnQ8qSqqBLgQ_1795101186
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a35db2d6b3so17129545e9.3
        for <virtualization@lists.linux.dev>; Thu, 19 Nov 2026 07:13:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795101186; x=1795705986;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aUaUnGVOD0AnB0qQi2tHlDtmvMhT+a6tdGKKo0EDxDI=;
        b=XPSWNobB9pgo8j09poRUX3kjE8zDNxsWqc4Zn9k1IFn7e+UwKMEk6QsJJtQC1obC4b
         nZsq5eBC33bmDru3lpV9GZjG8z8DLboZkaQhTheyeNoNqk/K8V6nwWzotVAGSIf8t279
         NlwrOjylZ48ZVEfvXZGoXV7dvwAPQTY9E/BbevDrPochup5/WRQc5O/5npCO+POMPcB8
         nPyq5QGjIlRc2Ta2mLzrz7gNXbWI1rcn2f9hg5D4RF04wS7Nh8CqpYGUlFSSIvcWMhmQ
         fSC4ADH388gKTyceSxxV4JLKGscP+3dOGZBjB190hg44LQ0hF4Lta0yIR6DceAIJVv+Y
         DjHQ==
X-Forwarded-Encrypted: i=1; AL+hErHu73pS6S34/c586Kd3IwdAVSw2tCvF0fwCijHZA1Z+U6k9A1wB1Z402yNagYCTPToD6LXVTGDBlGtQK5i5+w==@lists.linux.dev
X-Gm-Message-State: APuU4Z/26WuQnFMZ60iRWL4a64oB1IXHn4mdX5w31vECf06JrsMDUnrW
	4uaKkWSW+UbHtfxzgs6ytK9+0HmqF4T7EKOVZfLSGG3BLcwGJSrmMmDHajaXMCw0Sl96KUE2WNz
	VDB5kv3yDC0BA/ZiPMeclX+KpCMNK6/bmxWrkcuxN8Y+J4AGsz5qWiDbVQmg6KGEcx3hJ
X-Gm-Gg: AYBFou0rxnlN8CJwdqsXEP5KU4zM1IlaGIWRnUjXqh82nv54C2ujAtvBPXgrNW4vRy6
	u++urjTiDDWfFDF2TMp3X2u8YODKAOE2pYoz4xXGIOa93Lx5nE+jz76RtkJcSFhdgVw18YqjUb/
	cP4wfsa5nWHwS8aAPH5srmOywaIOP7r2bsPJurV59lf39DMQguSZiKxL+JkT+slRu4i0QPf6vjB
	G1KVGu3Vrj06xEJ5ZuBbkPkMbjiFXu2dgPgUh65FZ37hdAKJeOdtyZGx+ijT5QE0cHgwI3M+/89
	peeUpsA/UjGS/muBWlvgJyG/q9PvPKV3lVLsCNvLsOK3WF6be5lTbjT067d23safWVlGd8I8tTx
	1J6TNiQs32+2RhrmOmR9pYJwR0NI2eGXkGixRLDFl3g==
X-Received: by 2002:a05:600c:3107:b0:4ba:eb:eb9b with SMTP id 5b1f17b1804b1-4bb7da1272cmr124142105e9.8.1795101185797;
        Thu, 19 Nov 2026 07:13:05 -0800 (PST)
X-Received: by 2002:a05:600c:3107:b0:4ba:eb:eb9b with SMTP id 5b1f17b1804b1-4bb7da1272cmr124141275e9.8.1795101185168;
        Thu, 19 Nov 2026 07:13:05 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1522:6500:ac93:c62:f076:48c6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884a3a3dsm3221365e9.10.2026.11.19.07.13.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 07:13:04 -0800 (PST)
Date: Thu, 19 Nov 2026 10:12:58 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Tao Cui <cui.tao@linux.dev>
Cc: akpm@linux-foundation.org, dgilbert@interlog.com, mkp@kernel.org,
	loberman@redhat.com, jmeneghi@redhat.com, kraxel@redhat.com,
	vivek.kasireddy@intel.com, jasowangio@gmail.com,
	eperezma@redhat.com, stefanha@redhat.com, sgarzare@redhat.com,
	rostedt@goodmis.org, vdonnefort@google.com, mhiramat@kernel.org,
	jgg@ziepe.ca, kevin.tian@intel.com, axboe@kernel.dk,
	linux-mm@kvack.org, James.Bottomley@hansenpartnership.com,
	sumit.semwal@linaro.org, christian.koenig@amd.com,
	phasta@kernel.org, joro@8bytes.org, will@kernel.org,
	linux-scsi@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
	kvm@vger.kernel.org, virtualization@lists.linux.dev,
	linux-trace-kernel@vger.kernel.org, iommu@lists.linux.dev,
	io-uring@vger.kernel.org, linux-kernel@vger.kernel.org,
	bobbyeshleman@meta.com, mathieu.desnoyers@efficios.com,
	robin.murphy@arm.com, mason@kernel.org, aesteve@redhat.com,
	tjmercier@google.com, harry@kernel.org, vbabka@suse.cz,
	cuitao@kylinos.cn
Subject: Re: [PATCH 3/7] vhost: account the per-device kernel allocations to
 memcg
Message-ID: <20261119101239-mutt-send-email-mst@kernel.org>
References: <20261106131829.3228926-1-cui.tao@linux.dev>
 <20261106131829.3228926-4-cui.tao@linux.dev>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261106131829.3228926-4-cui.tao@linux.dev>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: CZkUO_HFSbWWqzhLUCGcL7skU3Wm_8UYYzcAhnMK_jk_1795101186
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 06, 2026 at 09:18:25PM +0800, Tao Cui wrote:
> From: Tao Cui <cuitao@kylinos.cn>
> 
> Everything except the worker struct is allocated with plain GFP_KERNEL:
> the per-vq iovec and log arrays at VHOST_SET_OWNER, the memory table at
> VHOST_SET_MEM_TABLE whose size follows the user supplied region count,
> the pending message nodes, and the vhost_net/vhost_vsock device structs
> with their fallback to vmalloc.  The worker has been accounted since the
> vhost_task conversion.
> 
> A container that can open /dev/vhost-net or /dev/vhost-vsock, which
> device plugins hand out with passthrough, holds roughly 150KB of
> resident kernel memory per device after SET_OWNER.  Charge the rest the
> same way the worker already is.
> 
> Signed-off-by: Tao Cui <cuitao@kylinos.cn>


Acked-by: Michael S. Tsirkin <mst@redhat.com>

should each patch be merged individually?


> ---
>  drivers/vhost/net.c   | 14 ++++++++------
>  drivers/vhost/vhost.c | 16 ++++++++++------
>  drivers/vhost/vsock.c |  5 +++--
>  3 files changed, 21 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index 4570a4ffbab2..bab6597c696d 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -249,7 +249,7 @@ vhost_net_ubuf_alloc(struct vhost_virtqueue *vq, bool zcopy)
>  	/* No zero copy backend? Nothing to count. */
>  	if (!zcopy)
>  		return NULL;
> -	ubufs = kmalloc_obj(*ubufs);
> +	ubufs = kmalloc_obj(*ubufs, GFP_KERNEL_ACCOUNT);
>  	if (!ubufs)
>  		return ERR_PTR(-ENOMEM);
>  	atomic_set(&ubufs->refcount, 1);
> @@ -302,7 +302,8 @@ static int vhost_net_set_ubuf_info(struct vhost_net *n)
>  		if (!zcopy)
>  			continue;
>  		n->vqs[i].ubuf_info =
> -			kmalloc_objs(*n->vqs[i].ubuf_info, UIO_MAXIOV);
> +			kmalloc_objs(*n->vqs[i].ubuf_info, UIO_MAXIOV,
> +				     GFP_KERNEL_ACCOUNT);
>  		if  (!n->vqs[i].ubuf_info)
>  			goto err;
>  	}
> @@ -1344,17 +1345,18 @@ static int vhost_net_open(struct inode *inode, struct file *f)
>  	struct xdp_buff *xdp;
>  	int i;
>  
> -	n = kvmalloc_obj(*n, GFP_KERNEL | __GFP_RETRY_MAYFAIL);
> +	n = kvmalloc_obj(*n, GFP_KERNEL | __GFP_RETRY_MAYFAIL |
> +			 __GFP_ACCOUNT);
>  	if (!n)
>  		return -ENOMEM;
> -	vqs = kmalloc_objs(*vqs, VHOST_NET_VQ_MAX);
> +	vqs = kmalloc_objs(*vqs, VHOST_NET_VQ_MAX, GFP_KERNEL_ACCOUNT);
>  	if (!vqs) {
>  		kvfree(n);
>  		return -ENOMEM;
>  	}
>  
>  	queue = kmalloc_array(VHOST_NET_BATCH, sizeof(void *),
> -			      GFP_KERNEL);
> +			      GFP_KERNEL_ACCOUNT);
>  	if (!queue) {
>  		kfree(vqs);
>  		kvfree(n);
> @@ -1362,7 +1364,7 @@ static int vhost_net_open(struct inode *inode, struct file *f)
>  	}
>  	n->vqs[VHOST_NET_VQ_RX].rxq.queue = queue;
>  
> -	xdp = kmalloc_objs(*xdp, VHOST_NET_BATCH);
> +	xdp = kmalloc_objs(*xdp, VHOST_NET_BATCH, GFP_KERNEL_ACCOUNT);
>  	if (!xdp) {
>  		kfree(vqs);
>  		kvfree(n);
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index ea127af58ada..d1274106ad5d 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -526,11 +526,14 @@ static long vhost_dev_alloc_iovecs(struct vhost_dev *dev)
>  
>  	for (i = 0; i < dev->nvqs; ++i) {
>  		vq = dev->vqs[i];
> -		vq->indirect = kmalloc_objs(*vq->indirect, UIO_MAXIOV);
> -		vq->log = kmalloc_objs(*vq->log, dev->iov_limit);
> -		vq->heads = kmalloc_objs(*vq->heads, dev->iov_limit);
> +		vq->indirect = kmalloc_objs(*vq->indirect, UIO_MAXIOV,
> +					    GFP_KERNEL_ACCOUNT);
> +		vq->log = kmalloc_objs(*vq->log, dev->iov_limit,
> +				       GFP_KERNEL_ACCOUNT);
> +		vq->heads = kmalloc_objs(*vq->heads, dev->iov_limit,
> +					 GFP_KERNEL_ACCOUNT);
>  		vq->nheads = kmalloc_array(dev->iov_limit, sizeof(*vq->nheads),
> -					   GFP_KERNEL);
> +					   GFP_KERNEL_ACCOUNT);
>  		if (!vq->indirect || !vq->log || !vq->heads || !vq->nheads)
>  			goto err_nomem;
>  	}
> @@ -2053,7 +2056,8 @@ static long vhost_set_memory(struct vhost_dev *d, struct vhost_memory __user *m)
>  		return -E2BIG;
>  	if (max_iotlb_entries <= 0)
>  		return -EINVAL;
> -	newmem = kvzalloc_flex(*newmem, regions, mem.nregions);
> +	newmem = kvzalloc_flex(*newmem, regions, mem.nregions,
> +			       GFP_KERNEL_ACCOUNT);
>  	if (!newmem)
>  		return -ENOMEM;
>  
> @@ -3405,7 +3409,7 @@ EXPORT_SYMBOL_GPL(vhost_disable_notify);
>  struct vhost_msg_node *vhost_new_msg(struct vhost_virtqueue *vq, int type)
>  {
>  	/* Make sure all padding within the structure is initialized. */
> -	struct vhost_msg_node *node = kzalloc_obj(*node);
> +	struct vhost_msg_node *node = kzalloc_obj(*node, GFP_KERNEL_ACCOUNT);
>  	if (!node)
>  		return NULL;
>  
> diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> index 0cb87971d749..600daeb05e7b 100644
> --- a/drivers/vhost/vsock.c
> +++ b/drivers/vhost/vsock.c
> @@ -721,11 +721,12 @@ static int vhost_vsock_dev_open(struct inode *inode, struct file *file)
>  	/* This struct is large and allocation could fail, fall back to vmalloc
>  	 * if there is no other way.
>  	 */
> -	vsock = kvmalloc_obj(*vsock, GFP_KERNEL | __GFP_RETRY_MAYFAIL);
> +	vsock = kvmalloc_obj(*vsock, GFP_KERNEL | __GFP_RETRY_MAYFAIL |
> +			     __GFP_ACCOUNT);
>  	if (!vsock)
>  		return -ENOMEM;
>  
> -	vqs = kmalloc_objs(*vqs, ARRAY_SIZE(vsock->vqs));
> +	vqs = kmalloc_objs(*vqs, ARRAY_SIZE(vsock->vqs), GFP_KERNEL_ACCOUNT);
>  	if (!vqs) {
>  		ret = -ENOMEM;
>  		goto out;
> -- 
> 2.43.0

