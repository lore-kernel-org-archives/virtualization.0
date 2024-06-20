Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D53172780
	for <virtualization@lists.linux.dev>; Thu, 20 Jun 2024 08:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718870911; cv=none; b=dK8PI7hvJTS1VRQxmlRGaW5uLlpYeIj71g/waAAJVEe/G34Iio4fP3ZvRDPUoMeWNjMoC3WXYLi92VXYyd/ITnW/Pyn3VQS/LODttXVmhVYCpjAIt/X2LTQIXQ7RCAK516jLxfZUS1pTrb5FkEIEcI+8yt3jSH1ADpZ7DG2D3xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718870911; c=relaxed/simple;
	bh=iZmgo2+TOhUg1x9YUztlK/dbvEtJpfYQSCVEMXHMeyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=JyTTz1dcrFqTYjevEvQuREN8IPhT7egayX0DWTV0l3Z7KOgmdrmXzPafZjEckr8kUxQCrk0i6E8loDUdAmJlR3CUJxURWWiteYD7uX9XYMqTYeLoykIvnJVjgmbJZ4Fs9923jjc2ZQK0bXY/MWrBKYSE0KoyHooVKZeoQmUu7fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bF2P88s4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bF2P88s4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718870907;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fYkcvH1qikOhnYAi1RzJNYy38ecUZaxzjAiohS4BdJU=;
	b=bF2P88s4SX3EaUwaeIwnArorSHARc3SzTla3IYss7j/qpYCU6LkXZBlS0zfg3IEcFxyo/2
	gtEsz+XWgkR2Ype+hZrBExturpTSxIKm6JHPGWpRP6V3YGCG058JwbtFWkkJELZyChz0Of
	4ckXhx6+JQ30wt2EWW6f1jtH9j785Sc=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-137-vbMx9AoJPsuyXfp1GdDpsg-1; Thu, 20 Jun 2024 04:08:25 -0400
X-MC-Unique: vbMx9AoJPsuyXfp1GdDpsg-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-57851ae6090so292516a12.3
        for <virtualization@lists.linux.dev>; Thu, 20 Jun 2024 01:08:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718870904; x=1719475704;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fYkcvH1qikOhnYAi1RzJNYy38ecUZaxzjAiohS4BdJU=;
        b=DO7rrj4INSNBM3ihdXNjGA2G9uFEjheA/KzGbGXIcC2T7ojzQgVT/roN2lLPsJfWCk
         MZ0lwd9js8f/beo3pNT5NbJkv/gwyT54peYfkYnlHBYr/X3gsobnNEmjZOQ7UvPZT+BZ
         NbBb/MpxpnzKHvbs70UEcNFp9+FOijwipiXOKpQhiPcQZz7MTpmZvJNt7JIMr7Ktei1T
         w3gs/3gv1XjMEmPkhw2oLj6isu49/E+SliSRSpeMb/mnISePpw9cAy7k2m6n4bqDqaLq
         NBCFtQ264WltZLijZAQ5U88pyUS//jP2INcYqsFG98/OpEIJeCZcVBlgVrq40b+MlvGe
         DbIA==
X-Gm-Message-State: AOJu0YzOlOBHzCCOKU3ped0xt+YGVg4L4k15O65a7IY6GJWuMJRI7cG0
	m4j9AE++YNvCjE0XBRY7YUj612ewvwWiKv6mFY3LvrmTIhOw9QGJxJhEr8ZtqFaSQMoV/hbiUl5
	lulE7U2GMwB7DKgTGgTKFm6oILMbN31E2bOIvvud2jb1ljyQl3cHjcm3YpeM32yMb
X-Received: by 2002:a50:ab18:0:b0:57d:12c3:eca6 with SMTP id 4fb4d7f45d1cf-57d12c3ed79mr2054061a12.18.1718870903881;
        Thu, 20 Jun 2024 01:08:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IElyy2gCyt3ovTk4v5Gf3L+EBBsQDxCvTGnZmU0yxgu5HjKvNiZ0eDBqsa0yCdr2XWpOKzZ1g==
X-Received: by 2002:a50:ab18:0:b0:57d:12c3:eca6 with SMTP id 4fb4d7f45d1cf-57d12c3ed79mr2054031a12.18.1718870902978;
        Thu, 20 Jun 2024 01:08:22 -0700 (PDT)
Received: from redhat.com ([2.52.146.100])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57cd24df611sm5962871a12.16.2024.06.20.01.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 01:08:22 -0700 (PDT)
Date: Thu, 20 Jun 2024 04:08:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Vadim Pasternak <vadimp@nvidia.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Cornelia Huck <cohuck@redhat.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Eric Farman <farman@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	David Hildenbrand <david@redhat.com>,
	Jason Wang <jasowang@redhat.com>, linux-um@lists.infradead.org,
	platform-driver-x86@vger.kernel.org,
	linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org,
	kvm@vger.kernel.org
Subject: Re: [PATCH vhost v9 1/6] virtio_balloon: remove the dependence where
 names[] is null
Message-ID: <20240620040415-mutt-send-email-mst@kernel.org>
References: <20240424091533.86949-1-xuanzhuo@linux.alibaba.com>
 <20240424091533.86949-2-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240424091533.86949-2-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 24, 2024 at 05:15:28PM +0800, Xuan Zhuo wrote:
> Currently, the init_vqs function within the virtio_balloon driver relies
> on the condition that certain names array entries are null in order to
> skip the initialization of some virtual queues (vqs). This behavior is
> unique to this part of the codebase. In an upcoming commit, we plan to
> eliminate this dependency by removing the function entirely. Therefore,
> with this change, we are ensuring that the virtio_balloon no longer
> depends on the aforementioned function.
> 
> As specification 1.0-1.2, vq indexes should not be contiguous if some
> vq does not exist. But currently the virtqueue index is contiguous for
> all existing devices. The Linux kernel does not implement functionality
> to allow vq indexes to be discontinuous. So the current behavior of the
> virtio-balloon device is different for the spec. But this commit has no
> functional changes.
> 
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> Acked-by: Jason Wang <jasowang@redhat.com>

I can't make heads of tails of this.

David you acked so maybe you can help rewrite the commit log here?

I don't understand what this says.
What in the balloon driver is out of spec?
NULL in names *exactly* allows skipping init for some vqs.
How is that "does not implement"?

And so on.


> ---
>  drivers/virtio/virtio_balloon.c | 48 ++++++++++++++-------------------
>  1 file changed, 20 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index c0a63638f95e..ccda6d08493f 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -548,49 +548,41 @@ static int init_vqs(struct virtio_balloon *vb)
>  	struct virtqueue *vqs[VIRTIO_BALLOON_VQ_MAX];
>  	vq_callback_t *callbacks[VIRTIO_BALLOON_VQ_MAX];
>  	const char *names[VIRTIO_BALLOON_VQ_MAX];
> -	int err;
> +	int err, idx = 0;
>  
> -	/*
> -	 * Inflateq and deflateq are used unconditionally. The names[]
> -	 * will be NULL if the related feature is not enabled, which will
> -	 * cause no allocation for the corresponding virtqueue in find_vqs.
> -	 */
> -	callbacks[VIRTIO_BALLOON_VQ_INFLATE] = balloon_ack;
> -	names[VIRTIO_BALLOON_VQ_INFLATE] = "inflate";
> -	callbacks[VIRTIO_BALLOON_VQ_DEFLATE] = balloon_ack;
> -	names[VIRTIO_BALLOON_VQ_DEFLATE] = "deflate";
> -	callbacks[VIRTIO_BALLOON_VQ_STATS] = NULL;
> -	names[VIRTIO_BALLOON_VQ_STATS] = NULL;
> -	callbacks[VIRTIO_BALLOON_VQ_FREE_PAGE] = NULL;
> -	names[VIRTIO_BALLOON_VQ_FREE_PAGE] = NULL;
> -	names[VIRTIO_BALLOON_VQ_REPORTING] = NULL;
> +	callbacks[idx] = balloon_ack;
> +	names[idx++] = "inflate";
> +	callbacks[idx] = balloon_ack;
> +	names[idx++] = "deflate";
>  
>  	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_STATS_VQ)) {
> -		names[VIRTIO_BALLOON_VQ_STATS] = "stats";
> -		callbacks[VIRTIO_BALLOON_VQ_STATS] = stats_request;
> +		names[idx] = "stats";
> +		callbacks[idx++] = stats_request;
>  	}
>  
>  	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT)) {
> -		names[VIRTIO_BALLOON_VQ_FREE_PAGE] = "free_page_vq";
> -		callbacks[VIRTIO_BALLOON_VQ_FREE_PAGE] = NULL;
> +		names[idx] = "free_page_vq";
> +		callbacks[idx++] = NULL;
>  	}
>  
>  	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_REPORTING)) {
> -		names[VIRTIO_BALLOON_VQ_REPORTING] = "reporting_vq";
> -		callbacks[VIRTIO_BALLOON_VQ_REPORTING] = balloon_ack;
> +		names[idx] = "reporting_vq";
> +		callbacks[idx++] = balloon_ack;
>  	}
>  
> -	err = virtio_find_vqs(vb->vdev, VIRTIO_BALLOON_VQ_MAX, vqs,
> -			      callbacks, names, NULL);
> +	err = virtio_find_vqs(vb->vdev, idx, vqs, callbacks, names, NULL);
>  	if (err)
>  		return err;
>  
> -	vb->inflate_vq = vqs[VIRTIO_BALLOON_VQ_INFLATE];
> -	vb->deflate_vq = vqs[VIRTIO_BALLOON_VQ_DEFLATE];
> +	idx = 0;
> +
> +	vb->inflate_vq = vqs[idx++];
> +	vb->deflate_vq = vqs[idx++];
> +
>  	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_STATS_VQ)) {
>  		struct scatterlist sg;
>  		unsigned int num_stats;
> -		vb->stats_vq = vqs[VIRTIO_BALLOON_VQ_STATS];
> +		vb->stats_vq = vqs[idx++];
>  
>  		/*
>  		 * Prime this virtqueue with one buffer so the hypervisor can
> @@ -610,10 +602,10 @@ static int init_vqs(struct virtio_balloon *vb)
>  	}
>  
>  	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT))
> -		vb->free_page_vq = vqs[VIRTIO_BALLOON_VQ_FREE_PAGE];
> +		vb->free_page_vq = vqs[idx++];
>  
>  	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_REPORTING))
> -		vb->reporting_vq = vqs[VIRTIO_BALLOON_VQ_REPORTING];
> +		vb->reporting_vq = vqs[idx++];
>  
>  	return 0;
>  }
> -- 
> 2.32.0.3.g01195cf9f

