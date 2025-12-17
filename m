Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4975730CDAF
	for <virtualization@lists.linux.dev>; Wed, 17 Dec 2025 20:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766005107; cv=none; b=KKB5fVjaZA5tfw6jWqxCe2Zati1daAP25VfEpEvFtf9I5WusplyI/KmwbtjbCQ8nmuSzpN0h21YHjv1sUx7g8eXSINg+4snAxO0Yi6OJL/u76DDhAOMx9GwURV4h7npMTAb6Op9wQND3Csq0qTzfsNkFF9e43NJveYFMJVVF4/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766005107; c=relaxed/simple;
	bh=hZNjoNQVlYTqUf2JurJDMNVvZvU8KiFitH8a3f2oqF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K67dggcSwd5fxcUVVM7m53yds7MmP3ifT4r0jxYsR8306AEramZ/VwlGGqOuCJEfLjkrUPrmSmWalG5pB4khVCS3MIBkjjvEtnVqCQlvlr6hUxLiQHHP9UwWOW+ZOCjI83lUsylIuvsyscHDTzkIVvn8LhzZ41nEDhqOEpkH2U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=l1yE7Pie; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l1yE7Pie"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-34be2be4b7cso4088396a91.3
        for <virtualization@lists.linux.dev>; Wed, 17 Dec 2025 12:58:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1766005103; x=1766609903; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y8l6Ur6Yr4Kr5eraloIZXw+ktF7rID9FaI2hPFW+l6Y=;
        b=l1yE7PieCCTt1nQmG0XqBKpVcAjUA83qTBYDWVAaAR+4aJZ8ONad+8rbkYSQullLI1
         CtRdrVZdLFx6mkZa96+3QGZW5vasO03ATqTG2fnCxXN2QUYu9zud/x3/AdDrkpP0WjP5
         04HnJiT5WrCHVaUtS7l5lHV/bH50N8qpohKQL7wvMoL0fqVmfDRiu+Xy0CyRsLRepbjH
         TOiASQX/RFpKw4oUpUwQ7h7NXEOqTryAIAkeLCRIJXHS1s8/ImT9jlnsH/NlOT7ErWlN
         MStgqSrMCPDJaVOaNZAX20naqX2ADHJLTVTo9wrfoPEOojYrjuTi3EIe4HPRZT1Pj3/M
         4xbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766005103; x=1766609903;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y8l6Ur6Yr4Kr5eraloIZXw+ktF7rID9FaI2hPFW+l6Y=;
        b=i4qff3oFPf0uR2VUIAkYiJ3PBKnJ7EHu0q6FPv5NnVJ2UwEPQogSyADBmyxkx+s5sD
         NPZCacqAFaoMJ9CzBTv+yIAxU+r89hprfiLpQEpzuiGb39+KwV4Rnb5EF10I3Bc+0Ki6
         tnLtF6IMlyuB6Dm5SexPhrhvQjzdLadZW7JMoK+4IDaIwDjnb6iC2E1fgo0bBKQvqUSi
         m4Usht3eFewBWbwno0lZ7ZE5GdLDx7ZBSVq8Uw/voY0iVRwn6iYs113W5MMJY2cR+aOG
         +LdPJ0GpEYNxrhclOhd//T7YM5caTYWcLHMOTZoqAynBEHV2e/gXyvE8EE1JPy/Z6Vp4
         22uQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEF9loffvNHafOHNwLNpL4fxWQz0LkC12WFivCiCtv8Jq07w6suIgVkY1OGIh3Q1hAPPe5SOqrR4TQd07gYw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxx6vQdCeXrT3Arir3mF+NY0S1VMwYOIhqO67Z8odtiLY8HSws8
	ezfPN/uCVvSsclGpLYbl+o/V0HQ/xRWLQRc2OCN4ny2ojdC2Y3T2QuPjiyRs/xEIWqk=
X-Gm-Gg: AY/fxX4xtwlTXy0rlfLcCi4/oXyYrJTNIeeLIHahu0mH3Z46hDrHGngRE+8g5YfKE/N
	79i67YxjxMJipVTuGBGNqltGr6IiMZmoj9ZyWKMZ9y9zJRQC5GHb9bKw8ZB9ZUR5n8zQ/nALMsz
	Y2XSf7Asmgs6YyEhJ5AGcXvqZwYpD0kqIAKxp7ZTWOA9jFZ3wnV912OBmDsCnXXIMU5qXvC5PUm
	3QvGkAejNjrefi4Puk8u4am8QbrfmTktlsySGR1q0/+WRf7PA+pwSNQ3wfkHz+VyEfsq16/57vp
	hKIUcm6+dGdL2sQq4UF+wGO5r93nXt4/pQSSIH0eNxIDxWFoeUyS1M/PNi6KfBEapgHLVnW86Y6
	215ybyc5ALM5CFcfOyL0QgkP1h3w/i4ExOCDVTfP0wIAbM887Jq2+wSRdsKc0BR7p7Yz/yDXowu
	G7cUeLmBq93IcrL4Tp6FMOgXM=
X-Google-Smtp-Source: AGHT+IEv6aRfuWteg9CkMupYi3aESqJksIkIawgSnCLh8bd8HFbrpV909yajnxOdzZbpUhAy/NMThA==
X-Received: by 2002:a17:90b:5348:b0:32e:3829:a71c with SMTP id 98e67ed59e1d1-34abd809190mr17284905a91.16.1766005103068;
        Wed, 17 Dec 2025 12:58:23 -0800 (PST)
Received: from p14s ([2604:3d09:148c:c800:cfb9:c35:9f28:8222])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e7710a5f8sm11766a91.6.2025.12.17.12.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 12:58:22 -0800 (PST)
Date: Wed, 17 Dec 2025 13:58:19 -0700
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Tanmay Shah <tanmay.shah@amd.com>
Cc: andersson@kernel.org, mst@redhat.com, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org,
	virtualization@lists.linux.dev, xiaoxiang@xiaomi.com,
	Xiang Xiao <xiaoxiang781216@gmail.com>
Subject: Re: [RFC PATCH 1/2] rpmsg: virtio_rpmsg_bus: allow the different
 vring size for send/recv
Message-ID: <aUMZayrdEIB6P90p@p14s>
References: <20251114184640.3020427-1-tanmay.shah@amd.com>
 <20251114184640.3020427-2-tanmay.shah@amd.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251114184640.3020427-2-tanmay.shah@amd.com>

Hi Tanmay,

On Fri, Nov 14, 2025 at 10:46:39AM -0800, Tanmay Shah wrote:
> From: Xiang Xiao <xiaoxiang781216@gmail.com>
>

This feature has been abandoned a long time ago - you own it now.
 
> it's useful if the communication throughput is different from each side
> 

Please provide a better changelog.

> Signed-off-by: Xiang Xiao <xiaoxiang@xiaomi.com>
> Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
> ---
>  drivers/rpmsg/virtio_rpmsg_bus.c | 47 ++++++++++++++++----------------
>  1 file changed, 24 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
> index 484890b4a6a7..cc26dfcc3e29 100644
> --- a/drivers/rpmsg/virtio_rpmsg_bus.c
> +++ b/drivers/rpmsg/virtio_rpmsg_bus.c
> @@ -37,8 +37,9 @@
>   * @svq:	tx virtqueue
>   * @rbufs:	kernel address of rx buffers
>   * @sbufs:	kernel address of tx buffers
> - * @num_bufs:	total number of buffers for rx and tx
> - * @buf_size:   size of one rx or tx buffer
> + * @num_rbufs:	total number of buffers for rx
> + * @num_sbufs:	total number of buffers for tx
> + * @buf_size:	size of one rx or tx buffer
>   * @last_sbuf:	index of last tx buffer used
>   * @bufs_dma:	dma base addr of the buffers
>   * @tx_lock:	protects svq, sbufs and sleepers, to allow concurrent senders.
> @@ -57,7 +58,8 @@ struct virtproc_info {
>  	struct virtio_device *vdev;
>  	struct virtqueue *rvq, *svq;
>  	void *rbufs, *sbufs;
> -	unsigned int num_bufs;
> +	unsigned int num_rbufs;
> +	unsigned int num_sbufs;
>  	unsigned int buf_size;
>  	int last_sbuf;
>  	dma_addr_t bufs_dma;
> @@ -112,7 +114,7 @@ struct virtio_rpmsg_channel {
>  /*
>   * We're allocating buffers of 512 bytes each for communications. The
>   * number of buffers will be computed from the number of buffers supported
> - * by the vring, upto a maximum of 512 buffers (256 in each direction).
> + * by the vring, up to a maximum of 256 in each direction.
>   *
>   * Each buffer will have 16 bytes for the msg header and 496 bytes for
>   * the payload.
> @@ -127,7 +129,7 @@ struct virtio_rpmsg_channel {
>   * can change this without changing anything in the firmware of the remote
>   * processor.
>   */
> -#define MAX_RPMSG_NUM_BUFS	(512)
> +#define MAX_RPMSG_NUM_BUFS	(256)
>  #define MAX_RPMSG_BUF_SIZE	(512)
>  
>  /*
> @@ -439,11 +441,8 @@ static void *get_a_tx_buf(struct virtproc_info *vrp)
>  	/* support multiple concurrent senders */
>  	mutex_lock(&vrp->tx_lock);
>  
> -	/*
> -	 * either pick the next unused tx buffer
> -	 * (half of our buffers are used for sending messages)
> -	 */
> -	if (vrp->last_sbuf < vrp->num_bufs / 2)
> +	/* either pick the next unused tx buffer */
> +	if (vrp->last_sbuf < vrp->num_sbufs)
>  		ret = vrp->sbufs + vrp->buf_size * vrp->last_sbuf++;
>  	/* or recycle a used one */
>  	else
> @@ -878,19 +877,20 @@ static int rpmsg_probe(struct virtio_device *vdev)
>  	vrp->rvq = vqs[0];
>  	vrp->svq = vqs[1];
>  
> -	/* we expect symmetric tx/rx vrings */
> -	WARN_ON(virtqueue_get_vring_size(vrp->rvq) !=
> -		virtqueue_get_vring_size(vrp->svq));
> -
>  	/* we need less buffers if vrings are small */
> -	if (virtqueue_get_vring_size(vrp->rvq) < MAX_RPMSG_NUM_BUFS / 2)
> -		vrp->num_bufs = virtqueue_get_vring_size(vrp->rvq) * 2;
> +	if (virtqueue_get_vring_size(vrp->rvq) < MAX_RPMSG_NUM_BUFS)
> +		vrp->num_rbufs = virtqueue_get_vring_size(vrp->rvq);
> +	else
> +		vrp->num_rbufs = MAX_RPMSG_NUM_BUFS;
> +
> +	if (virtqueue_get_vring_size(vrp->svq) < MAX_RPMSG_NUM_BUFS)
> +		vrp->num_sbufs = virtqueue_get_vring_size(vrp->svq);
>  	else
> -		vrp->num_bufs = MAX_RPMSG_NUM_BUFS;
> +		vrp->num_sbufs = MAX_RPMSG_NUM_BUFS;
>  
>  	vrp->buf_size = MAX_RPMSG_BUF_SIZE;
>  
> -	total_buf_space = vrp->num_bufs * vrp->buf_size;
> +	total_buf_space = (vrp->num_rbufs + vrp->num_sbufs) * vrp->buf_size;
>  
>  	/* allocate coherent memory for the buffers */
>  	bufs_va = dma_alloc_coherent(vdev->dev.parent,
> @@ -904,14 +904,14 @@ static int rpmsg_probe(struct virtio_device *vdev)
>  	dev_dbg(&vdev->dev, "buffers: va %p, dma %pad\n",
>  		bufs_va, &vrp->bufs_dma);
>  
> -	/* half of the buffers is dedicated for RX */
> +	/* first part of the buffers is dedicated for RX */
>  	vrp->rbufs = bufs_va;
>  
> -	/* and half is dedicated for TX */
> -	vrp->sbufs = bufs_va + total_buf_space / 2;
> +	/* and second part is dedicated for TX */
> +	vrp->sbufs = bufs_va + vrp->num_rbufs * vrp->buf_size;
>  
>  	/* set up the receive buffers */
> -	for (i = 0; i < vrp->num_bufs / 2; i++) {
> +	for (i = 0; i < vrp->num_rbufs; i++) {
>  		struct scatterlist sg;
>  		void *cpu_addr = vrp->rbufs + i * vrp->buf_size;
>  
> @@ -1001,7 +1001,8 @@ static int rpmsg_remove_device(struct device *dev, void *data)
>  static void rpmsg_remove(struct virtio_device *vdev)
>  {
>  	struct virtproc_info *vrp = vdev->priv;
> -	size_t total_buf_space = vrp->num_bufs * vrp->buf_size;
> +	unsigned int num_bufs = vrp->num_rbufs + vrp->num_sbufs;
> +	size_t total_buf_space = num_bufs * vrp->buf_size;
>  	int ret;
>  
>  	virtio_reset_device(vdev);
> -- 
> 2.34.1
> 
