Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2874B143C6C
	for <virtualization@lists.linux-foundation.org>; Wed, 14 Aug 2024 07:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723620448; cv=none; b=SGTA7vYsR86Q7iSiCGTPn3hR5OiZGgWimAlteuucCqEil1nmf15Gel2i4kCmCeQXq1Rmq3PzyGdh6y2BdQrg9jwvBXpA04/6EjkkUDYqDEpj+h3O+gyqPJ7MmVZtnHae0pNW6uNmRlxffy9eZ93y8uUCVzT/lTzmKLlt6sivnoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723620448; c=relaxed/simple;
	bh=1UP383j6hjG1P69n1FRHYze421i09BJSQebpheB6rVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=WrQ1EExOI2GUSp/h1r49IcfeKyAaVCx96EILshuSgt8h1wdi6PEZMeVJC/BLA1mfdlBJjiY0U/wp5Czoi1/6yaHzZCqucfbxPAiMAtNjJ1a3TXAb7djqGHHtUkPycl7YQRQvEoVbyDMo8JQy7SnNAj72TBugkWdP3bw6OzrMInM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ih4OhHVA; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ih4OhHVA"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B23C040391
	for <virtualization@lists.linux-foundation.org>; Wed, 14 Aug 2024 07:27:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XhT7og5Q806x for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Aug 2024 07:27:25 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 945C84038A
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 945C84038A
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ih4OhHVA
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 945C84038A
	for <virtualization@lists.linux-foundation.org>; Wed, 14 Aug 2024 07:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723620443;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lWW6/JtLLOdbS2RriwQ1Xt/j+3UDgvX+fkiP4SLbmfs=;
	b=Ih4OhHVAICbUeWWP6Tgwb5apy9vBT1ETH2CNM8owRiUdiSPhhG+bXggByXmOJfQlC34hNY
	9ml8wSSi9U4GRzOqzzgsRLW6sLC6kSMMBu28ZAwUmC+LbpeUxTU4d33J+tnZMy/ErTTtDD
	b5yqGCyidS9uLAvHrAi7dxcPVgUY4Kg=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-83-RTzbTfJcP2CbbmqmwqR7GQ-1; Wed, 14 Aug 2024 03:27:21 -0400
X-MC-Unique: RTzbTfJcP2CbbmqmwqR7GQ-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a7dc32f39c6so481897466b.2
        for <virtualization@lists.linux-foundation.org>; Wed, 14 Aug 2024 00:27:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723620440; x=1724225240;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lWW6/JtLLOdbS2RriwQ1Xt/j+3UDgvX+fkiP4SLbmfs=;
        b=KFR+PBcw8TU7unXEyRn/3bTqoF+cHJr5YVOWTW31ru8YJaHQxtZPliZy38RShWPvQC
         G5yORy6M8lZjDeIwjBnC0z1TvF1lYEGpx/q7kUXbOhUL9truinCOnYzpwD3mN1XPB7ev
         Djgv0XUggkZJrsS1Eb/rxIjR0sJPFtFx0AMNYgGpHEv3/y5WEOLA30l4Yg6EAS2iis9I
         safq4PtAU0dU52qpodBJMGU6ZphjSMoxjktGuW7zRuCrHjqEDcv5cMyo63PNHRW4HKoK
         0Uess/ylOerWnMIpR5qXYeo07nS7XzsU55i6gNUg8JbE1Hd5jmqKv3A/Y6wDoOVU1ogQ
         5oNw==
X-Forwarded-Encrypted: i=1; AJvYcCXmsdzr64s9uOzP3ePsMx43XsbQg8N7BPBqhYU/i8+oFqVEwy5AIbbeEx4GCsx+95OnHPuFEw90XbTkmRcrhJUlEmykoAgFoalm5uGM1NCgPNtMPbRQnqyzSw==
X-Gm-Message-State: AOJu0YzqWNnZGtD+Qv+a0i1YWVlZvNVClM29JDyA1783S98r9ykZ63JX
	SUjZKyq+deAtPNN+itsbCGN0RHMZPDvikJ0TxJvqTt3h0t043ej9nPnKkPEDJPUH86o2apBWTKJ
	rTC9wBIWy1juAkVKIhmVJCSyyIcNMAK5rkdD5uVXtjyY0X4W9b5wX8pSyoVsdpXZB9h0euJYSPe
	vkp/8=
X-Received: by 2002:a17:907:e6cb:b0:a7a:83f8:cfd5 with SMTP id a640c23a62f3a-a8366c31b00mr116566266b.18.1723620440174;
        Wed, 14 Aug 2024 00:27:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWLP3dpgqeL2l8ABzufX/5DIla/d7Ejaojfhfx0OWK/1bdtH+0ljIF9zLiuDaMf7faqOl25Q==
X-Received: by 2002:a17:907:e6cb:b0:a7a:83f8:cfd5 with SMTP id a640c23a62f3a-a8366c31b00mr116563466b.18.1723620439327;
        Wed, 14 Aug 2024 00:27:19 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:346:dcde:9c09:aa95:551d:d374])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80f411d225sm137283666b.107.2024.08.14.00.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 00:27:18 -0700 (PDT)
Date: Wed, 14 Aug 2024 03:27:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: dtatulea@nvidia.com, lingshan.zhu@intel.com, kvm@vger.kernel.org,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] vhost_vdpa: assign irq bypass producer token
 correctly
Message-ID: <20240814032700-mutt-send-email-mst@kernel.org>
References: <20240808082044.11356-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240808082044.11356-1-jasowang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 08, 2024 at 04:20:44PM +0800, Jason Wang wrote:
> We used to call irq_bypass_unregister_producer() in
> vhost_vdpa_setup_vq_irq() which is problematic as we don't know if the
> token pointer is still valid or not.
> 
> Actually, we use the eventfd_ctx as the token so the life cycle of the
> token should be bound to the VHOST_SET_VRING_CALL instead of
> vhost_vdpa_setup_vq_irq() which could be called by set_status().
> 
> Fixing this by setting up  irq bypass producer's token when handling
> VHOST_SET_VRING_CALL and un-registering the producer before calling
> vhost_vring_ioctl() to prevent a possible use after free as eventfd
> could have been released in vhost_vring_ioctl().
> 
> Fixes: 2cf1ba9a4d15 ("vhost_vdpa: implement IRQ offloading in vhost_vdpa")
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Want to post a non-RFC version?

> ---
> Note for Dragos: Please check whether this fixes your issue. I
> slightly test it with vp_vdpa in L2.
> ---
>  drivers/vhost/vdpa.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index e31ec9ebc4ce..388226a48bcc 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -209,11 +209,9 @@ static void vhost_vdpa_setup_vq_irq(struct vhost_vdpa *v, u16 qid)
>  	if (irq < 0)
>  		return;
>  
> -	irq_bypass_unregister_producer(&vq->call_ctx.producer);
>  	if (!vq->call_ctx.ctx)
>  		return;
>  
> -	vq->call_ctx.producer.token = vq->call_ctx.ctx;
>  	vq->call_ctx.producer.irq = irq;
>  	ret = irq_bypass_register_producer(&vq->call_ctx.producer);
>  	if (unlikely(ret))
> @@ -709,6 +707,12 @@ static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
>  			vq->last_avail_idx = vq_state.split.avail_index;
>  		}
>  		break;
> +	case VHOST_SET_VRING_CALL:
> +		if (vq->call_ctx.ctx) {
> +			vhost_vdpa_unsetup_vq_irq(v, idx);
> +			vq->call_ctx.producer.token = NULL;
> +		}
> +		break;
>  	}
>  
>  	r = vhost_vring_ioctl(&v->vdev, cmd, argp);
> @@ -747,13 +751,14 @@ static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
>  			cb.callback = vhost_vdpa_virtqueue_cb;
>  			cb.private = vq;
>  			cb.trigger = vq->call_ctx.ctx;
> +			vq->call_ctx.producer.token = vq->call_ctx.ctx;
> +			vhost_vdpa_setup_vq_irq(v, idx);
>  		} else {
>  			cb.callback = NULL;
>  			cb.private = NULL;
>  			cb.trigger = NULL;
>  		}
>  		ops->set_vq_cb(vdpa, idx, &cb);
> -		vhost_vdpa_setup_vq_irq(v, idx);
>  		break;
>  
>  	case VHOST_SET_VRING_NUM:
> @@ -1419,6 +1424,7 @@ static int vhost_vdpa_open(struct inode *inode, struct file *filep)
>  	for (i = 0; i < nvqs; i++) {
>  		vqs[i] = &v->vqs[i];
>  		vqs[i]->handle_kick = handle_vq_kick;
> +		vqs[i]->call_ctx.ctx = NULL;
>  	}
>  	vhost_dev_init(dev, vqs, nvqs, 0, 0, 0, false,
>  		       vhost_vdpa_process_iotlb_msg);
> -- 
> 2.31.1

