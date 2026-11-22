Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795384227;
	b=n6aQDoQ3wqucMnuXZBZaR9sj/0jwGMm1XS4Dsb6oucCGM95yJyzpqZ16waSHGM7iO0HX
	 r1kWY5cpN8kAO4irUzG7zBXGMd3h/ttbzXD1rz4R8i5PsjfND+eZNAb31s3LzrEuiV8Oi
	 DlkMgHiKI2CVLAPwG1RrCWIwANND28Q6gypOpELK/GxRtRvKe9w1y1B0TcLl5eOaWQjG8
	 LLgkE61nkyZoNUP7WqlQCcdl8VpkBX85IIEdQ7P4paI0xLAcWS7BaMNaBHPin5M6WBMe/
	 oQWGFWmFq/xhM8YN6od/txIJU2vb9OXDuyagSQEKU4FQIWVaN5GYJk3gGLu4DqjAtNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795384227;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=eGbs1Yuhkxx9FWUw+IvdWa5GoVs3JCcIuL+KJq7lsYc=;
	b=uobF8mWgX3sSterBMVhv/WMz/PSNDJn5KyCoV86/DOpG08VVBXnLCLSf5Xg2F/Zy0/+d
	 p5pU0sRloHwA2FbaVb9f/R8UnN9dVmR2biceEHafNNmQJCHQ2kmyr98Ovsvx5QG46Bx+q
	 UuusPrNXjgjTvPFCJFFe6fWSVPkoH3CXLdfwul+55j9R1w/QBCp+za1167vguz2izAWpF
	 KAMOnsKL/EadloKyWUZCRiKNdTnoCSClw0HuwQTmOUDbHlyLt1UM2OozVic+BI+nK6961
	 D0WpKl9oV9d6gMn8grzmkSJ6XW+eRwe1WVw2OuukpAd2VNsCB1OmSmgQh9XlOpcxsTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LEp+Edhc;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D2E606A320
	for <virtualization@lists.linux.dev>; Sun, 22 Nov 2026 21:50:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33D2E606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LEp+Edhc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795384226;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eGbs1Yuhkxx9FWUw+IvdWa5GoVs3JCcIuL+KJq7lsYc=;
	b=LEp+EdhcKfCEFq1LhYowrfAOQZ3ce10xA3xaf/32DniZyu0/FWSpNkyNVD6xFdA4bwe1sC
	stzkdsXxU6PQcwY9oKf9gvvJDmJDeGmkV4ljxqOF9iJMvq8AEw9jDhw8VOZQRb0b5L6hpw
	WNGeoZc70Xc2UbTD6XQJdXBccnLKGgI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-544-xpzKR7BXPYWm4-f0gxz0Lg-1; Sun, 22 Nov 2026 21:50:23 +0000
X-MC-Unique: xpzKR7BXPYWm4-f0gxz0Lg-1
X-Mimecast-MFC-AGG-ID: xpzKR7BXPYWm4-f0gxz0Lg_1795384223
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48e4d1e29f3so2298901f8f.3
        for <virtualization@lists.linux.dev>; Sun, 22 Nov 2026 13:50:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795384222; x=1795989022;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eGbs1Yuhkxx9FWUw+IvdWa5GoVs3JCcIuL+KJq7lsYc=;
        b=VmNIJJ2rr0hCIPhF4CyZPYbM1iw50V9hF2nNuDfdhygFCBOzT5Qlz35u6zyyObQ55S
         5PGIKgz2GdJUgNLxoOOMMiRIwnkeKLnAFRThzvGzxD4H6exfDOq2KRimEd92Bpu3ZpA4
         XCTiX77R1a/oAyJmiK9MlguHYqSxdAYKLN19jneyPe2xmfcunDzNyg03xJhdxnIHXxi7
         bBfWuMrrW5UCHWH9g4I7mGyLtXnBrctJc2HzXx/6bUvewzRIgPWUxxdRWyso9WEIMFYn
         e2hz7egC9uw6mMIw1loigzWqiHK0aalhs3uF17p+Rd4NghaS30VlW+yojHfSsPYtAieS
         tJLA==
X-Forwarded-Encrypted: i=1; AL+hErFH40JRiAHY/jlABXaKZzwcJELgga8c/Kd6ysRnWwEhUMnwSX8Htjmr0uKGZ3KdUPmJ8UB4q1taTRpRzTsvqg==@lists.linux.dev
X-Gm-Message-State: APuU4Z+CaIoQnJ0vQLrLg04TCS4PdsiNHVzznQLubakdOunLtBmmDb4Z
	FXtQkd2OH8vLU6lWmoutbX7XbWwTjMlfYFlSsrflLEWwUz0I0IsbYrR0+jlakspgXKzJldC+e5M
	Thf/ay8QlTHGV4h+8IUYSZEsoGe0nG4L2LmJrSaQYe13qSKLfToOGqzugtw1Rowke+XV3
X-Gm-Gg: AZFdTZdYMs9plSH/dJc8PtqPl5FphJC0bVCpynTyp8nIZeeWHzUxXmvL3r/AGEiGuN8
	UNz3h2oJPqwaxK+YtoCWYa0h5ODSWuK0UCZYYe3YaTwDkfv+VVmnTZftqVvc3phiPJiSNsOpXeS
	HLuO7BuI+UjtBMLFMfZcNzesQa2wOk7oihgj94HVzyzM0gwAb7266kZ2ph2t1rzK5feFnu9YIKv
	wlQ7emCgCWr/HJZBn6J2bm+XNwWxSPMCeqlxNpQtHFZLwCfL71EMopvwNPU5WO+OrXklYJuhqrE
	lMDwjVoc4SENhbdPkgfbrzIodooNhzcML3u2obfsTIt7TCrggFvpDJi863A49qpOa3NakX26ppk
	t0+s2uVPzDxhrVn6q9UYbOd8J/eBBdhl+LsLkohJg
X-Received: by 2002:a5d:6f07:0:b0:4af:7577:65c0 with SMTP id ffacd0b85a97d-4af75776767mr9196225f8f.5.1795384222443;
        Sun, 22 Nov 2026 13:50:22 -0800 (PST)
X-Received: by 2002:a5d:6f07:0:b0:4af:7577:65c0 with SMTP id ffacd0b85a97d-4af75776767mr9196193f8f.5.1795384221897;
        Sun, 22 Nov 2026 13:50:21 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1524:9e00:c39b:a740:e7:3fcf])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6bc8ce06sm17973036f8f.47.2026.11.22.13.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 13:50:20 -0800 (PST)
Date: Sun, 22 Nov 2026 16:50:17 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jianlin Shi <shijianlin11@foxmail.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev,
	jasowang@redhat.com, eperezma@redhat.com,
	xuanzhuo@linux.alibaba.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
	pabeni@redhat.com, talgi@nvidia.com, hengqi@linux.alibaba.com,
	horms@kernel.org
Subject: Re: [PATCH v2 2/2] virtio-net: unwind VQs when irq moderation init
 fails
Message-ID: <20261122165011-mutt-send-email-mst@kernel.org>
References: <cover.1790751008.git.shijianlin11@foxmail.com>
 <20261102155145.23144-1-shijianlin11@foxmail.com>
 <20261102155145.23144-3-shijianlin11@foxmail.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261102155145.23144-3-shijianlin11@foxmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: cBIJugjowyGpQJWCm9goVcovJIlUvU_Tf27A8KvfnYA_1795384223
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 02, 2026 at 11:51:45PM +0800, Jianlin Shi wrote:
> virtnet_probe() calls init_vqs() before virtnet_init_irq_moder().
> When the irq moderation init fails, the error path does "goto
> free", which only reaches free_netdev(): virtio_reset_device() and
> virtnet_del_vqs() are skipped, leaking the virtqueues and their
> DMA mappings.
> 
> Use the existing free_irq_moder label instead, as
> virtnet_create_page_pools() already does on failure.  This is safe
> only after net_dim_init_irq_moder() clears dev->irq_moder on its
> own failure (previous patch); otherwise virtnet_free_irq_moder()
> would net_dim_free_irq_moder() a dangling pointer, dereferencing
> freed memory and freeing it a second time.
> 
> Fixes: dcb67f6a9ead6 ("virtio-net: support dim profile fine-tuning")
> Signed-off-by: Jianlin Shi <shijianlin11@foxmail.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  drivers/net/virtio_net.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index dd2c41ef6fbe..d3ad1f1334bb 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -7027,7 +7027,7 @@ static int virtnet_probe(struct virtio_device *vdev)
>  
>  		err = virtnet_init_irq_moder(vi);
>  		if (err)
> -			goto free;
> +			goto free_irq_moder;
>  	}
>  
>  	/* Create page pools for receive queues.
> -- 
> 2.43.0

