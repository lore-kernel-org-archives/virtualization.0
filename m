Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173EA296BA5
	for <virtualization@lists.linux.dev>; Wed, 19 Nov 2025 07:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763537934; cv=none; b=qdh1hX5K5YVda2cdn4surp0K6Tl9/3REgNKzwV5JluApfS7d/QycWMxyc0aC201RWwlCqfhu0o5pLTnMvCwbuyIfqmqFA/beQCwNSfzK2qVp0qhBnkiKSEa8V/IcPiPzBirzH4igpI17Gz1zTUoJiSlaH2G6KEckop/1jQAx+F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763537934; c=relaxed/simple;
	bh=zmNqkoSltZ5GgXLj7EvC+Y7auPwKrmrMj6qaKvvDaGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=eN0tIbsD1vCMe1YL+SMn+5GLlht9ZzLB1bymL8887UaAIx3Onz0aIJ3M9ZNLhYiiecEuoc5BMcOiAKQoPg9KxcBBW8hjEdOZgIlTJF6CdauGDmJeib88YBwXyJcsi4rWfk2jWye9dTFz34fQpco9SmF2Bo4aNMyCcjNMaW6LHUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GxhMlCTb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GxhMlCTb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763537931;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Eden/oMzm33N9T6c3JgYfx1SV0QunnDnTTMkdMfqk7c=;
	b=GxhMlCTbtrIUBhfQdNKOcSBa5hn20SJFCsI0ym8F4Sz4CV/pMCHW65uBqIuK4iMucsJOqT
	HpAxj2i3FJS2PIDWlL8/mxIQdfHXH8I2lldRcSpzYAE6d6bYZCu0/QdRkl2u8bIimBndMh
	gr5DppfoJkdFbsRm9YHSTeSWBlCPsos=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-RO_TlxqAM7mhPh5xcAhhnQ-1; Wed, 19 Nov 2025 02:38:49 -0500
X-MC-Unique: RO_TlxqAM7mhPh5xcAhhnQ-1
X-Mimecast-MFC-AGG-ID: RO_TlxqAM7mhPh5xcAhhnQ_1763537929
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-477964c22e0so4262205e9.0
        for <virtualization@lists.linux.dev>; Tue, 18 Nov 2025 23:38:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763537928; x=1764142728;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Eden/oMzm33N9T6c3JgYfx1SV0QunnDnTTMkdMfqk7c=;
        b=fQmM5R2h0uNguMwNwuU1DmXrVqJKZZMVysnE+U3hYYh8Y+GBZEKVkMFYmz+lipTqY3
         QXKSM7IlrVu6zOmuCyUZeVzH0t1lWtPVGwzvrVQUTWYLnAsHW63QInDG52gN/HvzIMW1
         d8GO7PX/sEYpsLwP0ZcoU4Rl3itg5zdkh/qcf41TsjXKoWMRNM62se5vtXGDWUuxp0Gp
         nOFdHcnH4KhPnUyZZzCoPPQdJZlOjgNmza10AWn8vEF7iyMOzAkXi0+0BxU4uGn2mPiy
         Ho/OOl6ibJHjeJxQlMkze7fbePro82q5qRzJXsHRAxObHbBx8J0pycnjPO7D20MAWGwk
         vkDw==
X-Forwarded-Encrypted: i=1; AJvYcCUGH4KWaCwmMskVC8jdFKoGZTZhGgWuvTOfZs7wbF8AgMz7Fds6W6c2UJ3voXsRYNsAoQBOQSRNV4OUa6ukqg==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywi+5DjNZN8bAgWJPuhohC4aKVupwjKoLMoeH9VTc7/SUTBf8E2
	rF7AWp3/NdSwrSFoGzH5BKj8OUyuDcI70lSXh3WxRCySEiFhsrnIjUxm35P/K70ApB5L73Kw2M/
	BnkQjeIueOGp+RnBIMlhy/BcZArbRC2qpKpca4IdJQT0owRsnWlSgUZR03iwYdgrA+7rq
X-Gm-Gg: ASbGncveCv0Qb1i61drhn+RfcbrL/VdLGHzWRJKqUHOnlENEOT7+7IHmPBgEWwPVlNc
	EHi4ADJocJjXWfsVVEvNlIu+6akkAVwvHf+u2uN5Io0NhUAK6k9fo8wgnJ/oJ4xaGUcH1FQKoP6
	hqg5SmEOUYfULAE8XN10N/wYyb2TVeE9MqIPt/k1jWPiw6b+g8xja5HwDtO74lIUedYWEZS1TS5
	hGJ4/1sUieUaP5m+W37e6TYnpSwYT9GZ5zI+b7N6MeZjItJAycMe9e/oR/Q5uq3MalXcKYgh9Ig
	PihPela/hwcJ01gX/DXMVpmTVlnDHgpNmMF4KEgUZbwp12C1YcBDzNYVrJcFipf38pujgBnJzXV
	I6NdzCtRoowapXbNM9wE6JIzJjB6JKw==
X-Received: by 2002:a05:600c:3b29:b0:477:a289:d854 with SMTP id 5b1f17b1804b1-477b18bfcf8mr13614895e9.5.1763537928444;
        Tue, 18 Nov 2025 23:38:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHBaprik/Sp1uYavYsVh1sL/U72VYWrQLNUZqdCZ0jFk34W6YL7U0vj3IwUMUFpjme+YxSRHg==
X-Received: by 2002:a05:600c:3b29:b0:477:a289:d854 with SMTP id 5b1f17b1804b1-477b18bfcf8mr13614705e9.5.1763537928057;
        Tue, 18 Nov 2025 23:38:48 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477a9ddef38sm34907765e9.3.2025.11.18.23.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 23:38:47 -0800 (PST)
Date: Wed, 19 Nov 2025 02:38:44 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
	virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, jgg@ziepe.ca, kevin.tian@intel.com,
	kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v11 01/12] virtio_pci: Remove supported_cap size
 build assert
Message-ID: <20251119023725-mutt-send-email-mst@kernel.org>
References: <20251118143903.958844-1-danielj@nvidia.com>
 <20251118143903.958844-2-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251118143903.958844-2-danielj@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: BRYQ0cKw2F8uFNpglUetdeoXweI2OHqshuvQuqL9IOg_1763537929
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 18, 2025 at 08:38:51AM -0600, Daniel Jurgens wrote:
> The cap ID list can be more than 64 bits. Remove the build assert. Also
> remove caching of the supported caps, it wasn't used.
> 
> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
> Reviewed-by: Parav Pandit <parav@nvidia.com>
> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> 
> ---
> v4: New patch for V4
> v5:
>    - support_caps -> supported_caps (Alok Tiwari)
>    - removed unused variable (test robot)
> ---
>  drivers/virtio/virtio_pci_common.h | 1 -
>  drivers/virtio/virtio_pci_modern.c | 8 +-------
>  2 files changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
> index 8cd01de27baf..fc26e035e7a6 100644
> --- a/drivers/virtio/virtio_pci_common.h
> +++ b/drivers/virtio/virtio_pci_common.h
> @@ -48,7 +48,6 @@ struct virtio_pci_admin_vq {
>  	/* Protects virtqueue access. */
>  	spinlock_t lock;
>  	u64 supported_cmds;
> -	u64 supported_caps;
>  	u8 max_dev_parts_objects;
>  	struct ida dev_parts_ida;
>  	/* Name of the admin queue: avq.$vq_index. */
> diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
> index dd0e65f71d41..ff11de5b3d69 100644
> --- a/drivers/virtio/virtio_pci_modern.c
> +++ b/drivers/virtio/virtio_pci_modern.c
> @@ -304,7 +304,6 @@ virtio_pci_admin_cmd_dev_parts_objects_enable(struct virtio_device *virtio_dev)
>  
>  static void virtio_pci_admin_cmd_cap_init(struct virtio_device *virtio_dev)
>  {
> -	struct virtio_pci_device *vp_dev = to_vp_device(virtio_dev);
>  	struct virtio_admin_cmd_query_cap_id_result *data;
>  	struct virtio_admin_cmd cmd = {};
>  	struct scatterlist result_sg;
> @@ -323,12 +322,7 @@ static void virtio_pci_admin_cmd_cap_init(struct virtio_device *virtio_dev)
>  	if (ret)
>  		goto end;
>  
> -	/* Max number of caps fits into a single u64 */
> -	BUILD_BUG_ON(sizeof(data->supported_caps) > sizeof(u64));
> -
> -	vp_dev->admin_vq.supported_caps = le64_to_cpu(data->supported_caps[0]);
> -
> -	if (!(vp_dev->admin_vq.supported_caps & (1 << VIRTIO_DEV_PARTS_CAP)))
> +	if (!(le64_to_cpu(data->supported_caps[0]) & (1 << VIRTIO_DEV_PARTS_CAP)))
>  		goto end;

It's ok but a better way is

data->supported_caps[0] & cpu_to_le64(1 << VIRTIO_DEV_PARTS_CAP)

giving the compiler a chance to do the byte swap at compile time
on BE.



>  	virtio_pci_admin_cmd_dev_parts_objects_enable(virtio_dev);
> -- 
> 2.50.1

