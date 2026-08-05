Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E4C33F383
	for <virtualization@lists.linux.dev>; Wed,  5 Aug 2026 05:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785907792; cv=none; b=lLAU0lMbpx3hCaI000xovX2Ixwxal8QfeK3kMrb8nUuNFyPKGyST5x0gXpDZQk6kgHocaEtimTIRaP65anUDIhR1cFFZhf4dnmU1DMsmFEMi0rTWhidmnpEUF176zwkCHAAQHGiIDt1drOTGrETPXHOuywoXDXtEu3ecI2K7YK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785907792; c=relaxed/simple;
	bh=tou1oMvJ+1xi7K5Ayg0UJnhYTWNqiNkGHykmQO0m2n4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=JEXCecC+XPKusIXj/0pxvBjt2yBSmMqUNmnIEPhfUXNZ3nA6oCfc9Aou7unGrZQNLpjIE0wfYfjk/7XT3h7RcevzjV978HebrVBsAxVMjTsg6UeCtHVx465OSSIOzcMP7Le2sIWxLoB9nlOwTgI65MqhOM7mCuxmvIuniTjVHF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XSMlWwcf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XSMlWwcf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785907790;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uoYUbeJfzYbnY0HKD2boTZCl0qawjKDIX6lvEivFnzg=;
	b=XSMlWwcfztG3uuan9Mal4HhFlO4yFI8li4OhRu4V5Kj49dISTG3R7qiDxbVSGrURSC0ipM
	urx/5FBBwiVoLpJfauHZU9/Povg9c1vI2CSlPCUCydCForY7d8RWNzzZWTUrTaN2QAWHHA
	1NIrN6fuxv9v8OjNBFgi5Qx683R/aeg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-gXFM-CjdMCGSldryd2PaTg-1; Wed, 05 Aug 2026 01:29:34 -0400
X-MC-Unique: gXFM-CjdMCGSldryd2PaTg-1
X-Mimecast-MFC-AGG-ID: gXFM-CjdMCGSldryd2PaTg_1785907773
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4955b84e25eso3135305e9.1
        for <virtualization@lists.linux.dev>; Tue, 04 Aug 2026 22:29:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785907773; x=1786512573;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uoYUbeJfzYbnY0HKD2boTZCl0qawjKDIX6lvEivFnzg=;
        b=EApjdp2+BlYN6fZKSqUQln7uA7YP22NG/VbJC4XLcQnAtehs98LwT5wHVyLy8xY0Zd
         7okO6fq1WYq3soLnEeuQldkHodSGRnBuKCXXNN8ll84Z+CGlqGfszFi37qtdQQesLtuW
         N3vrtoakL0JhtqaJXl6HFV3GeTiY1MNRMQGzBbRhPEukFxqOgKXtg07NdsrrRtaC/lk3
         fYbv3tPNcnr4TwnIyJAp0FsXylBrVk3vr4wi8cMwHwA0kXeGXyyYK+QukHYPz9UWRdGF
         mpbKqPtBRyLTqUU5CESp7gWNgZ1T4TRBNIkq/KssL+5XjAZMb6jMOBEX3fX3LtzdlcRX
         1TOQ==
X-Gm-Message-State: AOJu0YwfLppqwDd9g54hsxaT4HbtPRC/SiPOTsxO8HFdhHDwnlbbMJ6X
	6YVFrGrDDMaUKcrUwjOQZo2FdZdhULag02/tKVV7IYCmnJ827faHtlRLYvAck1FxrPPbXEfJKfZ
	cCx1ROPRMnH0B1P0YH6MW9+kUmfVSjeJrVuJN666IGmbZk0+swPWIPvRuAApyWMSkck+5
X-Gm-Gg: AR+sD12tbly/es6QWI64iirf3bgODkyK0W7xSWotU4orADPUT9lxSJaRRFpRbYIqE1r
	AwwEwCwo0FuE6CF/GPi659oIJcuGUERzqflnavHiAgvCYBdS/WYq+nXiAq2wx7XKUMPHPd96bjU
	VAbrnTYj4o8jM4ZNiv2t2OIxiigHc2pr/s7G+unZSpcJAWiKLrzo2B0LN60pl9z4AnlAIy266M+
	odpAE0yHqvUYOY4h6EIHd8J659KQSMSLEmxOtBvNTNGcSURDHzSVzqCwQ0x14o1k6FAh8p8yn0o
	2ZLST2P16uOPr7hJe6LNtk32lIgjgChzx5U9HKG2rIKv1+4upjbgwbTEhPjZmctCE/3eflA7daW
	h3IPh2ejV6AZ8VSjDG+sPZA==
X-Received: by 2002:a05:600c:1d1f:b0:496:c9cd:e7ab with SMTP id 5b1f17b1804b1-4994e71d2acmr37754675e9.5.1785907772746;
        Tue, 04 Aug 2026 22:29:32 -0700 (PDT)
X-Received: by 2002:a05:600c:1d1f:b0:496:c9cd:e7ab with SMTP id 5b1f17b1804b1-4994e71d2acmr37754275e9.5.1785907772318;
        Tue, 04 Aug 2026 22:29:32 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-28-14.inter.net.il. [80.230.28.14])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4994df7e025sm63769205e9.0.2026.08.04.22.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 22:29:31 -0700 (PDT)
Date: Wed, 5 Aug 2026 01:29:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xiong Weimin <xiongweimin@kylinos.cn>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	Gerd Hoffmann <kraxel@redhat.com>,
	Jason Wang <jasowangio@gmail.com>, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] virtio_input: reset device if input_register_device()
 fails
Message-ID: <20260805012846-mutt-send-email-mst@kernel.org>
References: <20260805032931.1606652-1-xiongweimin@kylinos.cn>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260805032931.1606652-1-xiongweimin@kylinos.cn>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: V7tmLd80sO4u1IB1VOjWamkONMOgz9vBuBWkBVsMKSg_1785907773
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 05, 2026 at 11:29:31AM +0800, Xiong Weimin wrote:
> Probe marks the device DRIVER_OK with virtio_device_ready() before
> calling input_register_device(). If registration fails, the error path
> cleared vi->ready and called del_vqs() while the device was still live,
> so the device could keep DMA to queues that were already torn down.
> 
> Match remove/freeze: call virtio_reset_device() on that path before
> tearing down the virtqueues.
> 
> Fixes: 271c865161c5 ("Add virtio-input driver.")
> Cc: stable@vger.kernel.org



for each of these patches: is this a real or a theoretical issue?
stable rules preclude the later kind.

> Signed-off-by: Xiong Weimin <xiongweimin@kylinos.cn>
> ---
>  drivers/virtio/virtio_input.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/virtio/virtio_input.c b/drivers/virtio/virtio_input.c
> index deec24e8e..1a87be4c8 100644
> --- a/drivers/virtio/virtio_input.c
> +++ b/drivers/virtio/virtio_input.c
> @@ -331,6 +331,7 @@ static int virtinput_probe(struct virtio_device *vdev)
>  	spin_lock_irqsave(&vi->lock, flags);
>  	vi->ready = false;
>  	spin_unlock_irqrestore(&vi->lock, flags);
> +	virtio_reset_device(vdev);
>  err_mt_init_slots:
>  	input_free_device(vi->idev);
>  err_input_alloc:
> -- 
> 2.43.0

