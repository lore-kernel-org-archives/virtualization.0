Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49B918FC86
	for <virtualization@lists.linux.dev>; Mon, 20 Oct 2025 23:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761001616; cv=none; b=erOV0JF9IP9fQ55pEuyPSnOQL0gloHAp17/wGQ4CPoBfDkunsiaGcCDvffo7S6CzWRnnCZ3b4iCca0iei8XdoCDTTvEt8KjEu76n6Z2xaj3+BVY5nD7rjIkVKQOcoRAkpXVEYvZrHNUgErHPpRM+GWobbnLP9xeUX5TpbS7DJRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761001616; c=relaxed/simple;
	bh=WOamq/8NTrRJ6lJQJ2kGQKI3k7GTITbOcQoS4hwx+3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=BZsfwWPbhzlGY1b7ysHSyp4sCSlFC7Km9m/VMe55p9F+AAPX6R3ADu0s01VaJGF7iu35fAs6X70j1KZnUfvr7H3q6lzNJC5sFtk/sCRwzzY4JHMuRs0BIWJQ+2uzhy3BGMKTxNdAPpsjV/1tkvBkQHd9K2HFlinReDNlI28xJxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ftp7fjzS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ftp7fjzS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761001612;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yadhvA4ZuoYMPNwq6F4mNtP+XLX9TmfXDYE8mlqAeoM=;
	b=ftp7fjzSm1mE5k2KxfYt7moomGkLHpxJIR95cGHSw6/nko4jhopDtoXzKOQ/W0BryQCivZ
	kRWcz0DjyDhOSWfclonOq94rZpTg4t+Ts4likTg0fSZtUoxuYp0h34i/8LL+aW441YuGrh
	aiztxQHFXANCyS3YZUEnodCmjiXUwRE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-281-fnhSgK7BMNOvOLBJgQy7zw-1; Mon, 20 Oct 2025 19:06:51 -0400
X-MC-Unique: fnhSgK7BMNOvOLBJgQy7zw-1
X-Mimecast-MFC-AGG-ID: fnhSgK7BMNOvOLBJgQy7zw_1761001610
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-47113dcc1e0so40437055e9.3
        for <virtualization@lists.linux.dev>; Mon, 20 Oct 2025 16:06:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761001610; x=1761606410;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yadhvA4ZuoYMPNwq6F4mNtP+XLX9TmfXDYE8mlqAeoM=;
        b=DmDxgmy+74cI0nOwQV4OIRr8+OxcRnzrHggPlhaXkXQyfW+RGqx5ezjQeqLY55WlSk
         31CdfBuSEZceXRtOcA12shCco7AtA9puiAMVRSPEWYqOpsmvG1MFE8mny8KScHq/xuUV
         4ltwy6+GHj/x4MhQRh0U/Cobpfd2TQ8IVAST2fTjXd9C7BMmP55kl3wS5itgrZ8I3+Gt
         WFftEnlxnXC3AGYDEdI6f6snzvkSx14noTcGp+AnaByyTKKwVlepB6YRWuoHdbl69BBa
         P+/e8fwtvzxRLRemAeNt4WzwgWFe2K9byeGAqoCbLQy2NohkSx7YvRAMM9EnZkF7+exF
         kmfw==
X-Forwarded-Encrypted: i=1; AJvYcCVPPG24/pjjsRB7UdG87kOznEUshI5AizisNDAq/wWnE2ASbmw0tT1v86m1gq9gaN4QHwNKYfcrZc0bYJbV9A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yydd6jLMaNDs4xJU9SxEN+9tPlBHpOtHWqpFqUCgmPBGHp4ssa0
	cjXcNswAIgTyoHnYhgqz5V3lQtThahOqV7s0MOT04mSH2q7wYdJJVJOfe2/xPIbn130aL/+n8nR
	eWC+DAi/GEoGS0igg9mVWpoqNueSLiVD+RUutVZAYPhzyZLhOVoUe02kFmPPJPAdkycf0
X-Gm-Gg: ASbGnctcZ0Fpm3ABehqbLkpyCsspeiEifPQwpQOcCZ835hBYFEcIHFRND3dfynevgZd
	RGMYeJvMS3QbbHNzCRYwc0yDQiPwLg8uy/Nanqc4v7sDOgLobDjd9+ZH0qHqNTcQzsVuPidXDAq
	Cx9hRxHmg/ub/8qCF33TVJ5P8uNAJmHLCEZMJI4Hh4+Wyg/8pTs9mTqZp+Tqj5owPHNZRuGZu85
	itFokDIX98gQVTWykZfcO/n4A5ec5+zt5ud9bvVxvs3C3mVkqe4VHT24BZIiPGDNSiFlkqi4IwL
	iOYUkSDq7lQkOkzf+YC5TR2WnzqIbXfBoPEp7qlauNtKsQicTGbygCR7zIOnPsM8bibO
X-Received: by 2002:a05:600c:8b03:b0:46e:41b0:f0cb with SMTP id 5b1f17b1804b1-4711790c57amr116010335e9.25.1761001610030;
        Mon, 20 Oct 2025 16:06:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGF22YnS0c4s1OTo1hseU2hGEMN8vRo6HAvsbGEUP5hVKEl3u1SlCcU+fRoWFkUMK+1iwOOIw==
X-Received: by 2002:a05:600c:8b03:b0:46e:41b0:f0cb with SMTP id 5b1f17b1804b1-4711790c57amr116010165e9.25.1761001609538;
        Mon, 20 Oct 2025 16:06:49 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:152d:b200:2a90:8f13:7c1e:f479])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4711442d3ddsm246071025e9.5.2025.10.20.16.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 16:06:48 -0700 (PDT)
Date: Mon, 20 Oct 2025 19:06:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V7 15/19] virtio_ring: factor out core logic of buffer
 detaching
Message-ID: <20251020190537-mutt-send-email-mst@kernel.org>
References: <20250925103708.44589-1-jasowang@redhat.com>
 <20250925103708.44589-16-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250925103708.44589-16-jasowang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: PaQykyKqCtlzGdcp3IfuRGb88Z5jm56GbYDXmXISbEM_1761001610
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Thu, Sep 25, 2025 at 06:37:04PM +0800, Jason Wang wrote:
> Factor out core logic of buffer detaching and leave the id population


"id population" here really means "free list management".


> to the caller so in order can just call the core logic.


in order -> in_order


> 
> Acked-by: Eugenio Pérez <eperezma@redhat.com>
> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/virtio/virtio_ring.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index fc04cdb99706..4b01c26f83b9 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -1661,8 +1661,8 @@ static bool virtqueue_kick_prepare_packed(struct vring_virtqueue *vq)
>  	return needs_kick;
>  }
>  
> -static void detach_buf_packed(struct vring_virtqueue *vq,
> -			      unsigned int id, void **ctx)
> +static void detach_buf_packed_in_order(struct vring_virtqueue *vq,
> +				       unsigned int id, void **ctx)
>  {
>  	struct vring_desc_state_packed *state = NULL;
>  	struct vring_packed_desc *desc;
> @@ -1673,8 +1673,6 @@ static void detach_buf_packed(struct vring_virtqueue *vq,
>  	/* Clear data ptr. */
>  	state->data = NULL;
>  
> -	vq->packed.desc_extra[state->last].next = vq->free_head;
> -	vq->free_head = id;
>  	vq->vq.num_free += state->num;
>  
>  	if (unlikely(vq->use_map_api)) {
> @@ -1711,6 +1709,17 @@ static void detach_buf_packed(struct vring_virtqueue *vq,
>  	}
>  }
>  
> +static void detach_buf_packed(struct vring_virtqueue *vq,
> +			      unsigned int id, void **ctx)
> +{
> +	struct vring_desc_state_packed *state = &vq->packed.desc_state[id];
> +
> +	vq->packed.desc_extra[state->last].next = vq->free_head;
> +	vq->free_head = id;
> +
> +	detach_buf_packed_in_order(vq, id, ctx);
> +}
> +
>  static inline bool is_used_desc_packed(const struct vring_virtqueue *vq,
>  				       u16 idx, bool used_wrap_counter)
>  {
> -- 
> 2.31.1

