Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A594202C50
	for <virtualization@lists.linux.dev>; Fri, 27 Jun 2025 10:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751020624; cv=none; b=sCv91tKr7bFKxGKeAFudjyeKr+ocZFHPBEUCjl6uNPJCCFCwj7yzG0iHjUzz2fVBxrWOwl51xy+kDtURVj6sQspV7rfqQwCh8KMcbBl/r4yHaYoTKQxPxdJS9+MGDc6af0Ti5szOmDijMKAnGk4pY1tluJ7jHMZOXDTpBR1FZO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751020624; c=relaxed/simple;
	bh=PftrHSJSMYZ7m6RfvegnAyP7tt3C2p8CyLScg97a/jI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=jFAtKtB/Wtf4RXOqIGS7QxeMlR+4lagpDXRr2BK1+TZL9PxNXdyMkpGgD40Z05X/vMe2s5KLPFUPVobeqBLh5+OSYADn0VQ3X7iaFU4A2quvgsSpn+O8OHGlk7eXya7UEy/8lDdCRnTxSbi046TvOMbfmEJEbS1K/hQ9o7Dhl8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G8kyI+Gm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G8kyI+Gm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751020621;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xM08rJUXb05AQG4eXstXXPFP8RjwRrIPi+WmNXcJ64I=;
	b=G8kyI+GmNQn9bQGPAAM4zkejLir4dd89djKd9yZJmx0nopOjJEYDFsm3hN8cfQghD/85YX
	fh33jsEhn5ktKUXuWjbaZMvqwgrHloSYUBOAyht0H0+Gph7cZLKx4bIbZk9pHHisB/EBe4
	LXHertnkCQ3Ifb0+J4HwsqpBnnhsdpE=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637--VEMJEZRN3KaQGa4XJ_cGQ-1; Fri, 27 Jun 2025 06:37:00 -0400
X-MC-Unique: -VEMJEZRN3KaQGa4XJ_cGQ-1
X-Mimecast-MFC-AGG-ID: -VEMJEZRN3KaQGa4XJ_cGQ_1751020619
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b31bc3128fcso2569524a12.0
        for <virtualization@lists.linux.dev>; Fri, 27 Jun 2025 03:36:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751020619; x=1751625419;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xM08rJUXb05AQG4eXstXXPFP8RjwRrIPi+WmNXcJ64I=;
        b=t0wrsgsJ1d6RwVm6YlgaMrKMHC6MXB7ZpF9Qcz8k4exrBAZRkLgJcarYhzm8R0TihO
         i2VUHVAbrJby02hSEULH512FEmcoblrKOeWlR/Ewm5WKvQrJ/EU0jbum+emRz/VeZuDb
         M3JFoGEStgN81x79WC/bFcKT3VCB5P4I4zclCXggDDOjvN4TF2c4fUW/EIHjkbpMHhd1
         xYUOJg6ScOyliVrvXsQonBl3Fhzj96NwNY3ARbbgXzUnOqDi5N+fadH0j1wBGfQ6i0nH
         ug8UKUiANACrw5L4TsggydkB2PdSAfQfZCoTuqnoBvG7krikG+PFN54crKG3Pd8EonPE
         12ow==
X-Forwarded-Encrypted: i=1; AJvYcCXVmz4U/Qx3yxWBUXkfAZ00zrk22p+NmY6KLmUt1DnF5kq1viQR/RxKgzk9BgJoOGVaVjPNFaxQIP4ZxDNwFg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwluSpwJkz+p1AhTNiJqKXIPYYAMj8S30NgOCM2pG66ExbO+izb
	SwbzFzwHK0KZuRR4YFMMVwCbXWMzuQbIstnJpFxZsrO0fIER75r6m0YpQKB1Vuc71Vbx/we49cL
	fyslTj7ZWtropd/ZZHp+A9UPKDsLpPi+TzG5ILLi5AFXXcbMQXMbDkMpiiv6bhXWY1hnp
X-Gm-Gg: ASbGnct6cfDXjnaeHn57ac9tn89YsL2uPWgsK4YhCAvAT6FVZnXebplALxTqwob8rmo
	iTniG4Dm9cnpvOxW1uexBMzqEspCVK6x5p5FICUYD+Wixic5uSdwMt0P8KFaoL61GKx/n6bvQha
	A57gEis0bOo0Phywl82cDjd32yHfmqZ+mRkEQnfjtipFa2dnshwI3FP32adE9/HUZRnGiqAzbsa
	+NhMo4rNeibrUbH7KEB17mRJh3lJQUeTrst9YvQx14V8uAULuJr0A5DC82STRMIPpTHe4VtXDA4
	F+jZJ5J4nE99DJEMBOaGtpD9W8I=
X-Received: by 2002:a17:90b:54d0:b0:311:f99e:7f4b with SMTP id 98e67ed59e1d1-318c926568dmr3705108a91.28.1751020619063;
        Fri, 27 Jun 2025 03:36:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2NSMNCRnsJPJF7ZAu3FfPcP3Jvs8X5CeYQn6CTkxq0SuisV7Qqhbya1ObUs6rSXJylkxq5w==
X-Received: by 2002:a17:90b:54d0:b0:311:f99e:7f4b with SMTP id 98e67ed59e1d1-318c926568dmr3705073a91.28.1751020618513;
        Fri, 27 Jun 2025 03:36:58 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.150.33])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-318c14e1f8fsm2013391a91.24.2025.06.27.03.36.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 03:36:58 -0700 (PDT)
Date: Fri, 27 Jun 2025 12:36:46 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, Keir Fraser <keirf@google.com>, 
	Steven Moreland <smoreland@google.com>, Frederick Mayle <fmayle@google.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	netdev@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH 1/5] vhost/vsock: Avoid allocating arbitrarily-sized SKBs
Message-ID: <7byn5byoqlpcebhahnkpln3o2w2es2ae3jpzocffkni3mfhcd5@b5hfo66jn64o>
References: <20250625131543.5155-1-will@kernel.org>
 <20250625131543.5155-2-will@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250625131543.5155-2-will@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: URbUhs82LBiyj3fb2dQaOscxxbI0T-9gAELXcTDBLys_1751020619
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Wed, Jun 25, 2025 at 02:15:39PM +0100, Will Deacon wrote:
>vhost_vsock_alloc_skb() returns NULL for packets advertising a length
>larger than VIRTIO_VSOCK_MAX_PKT_BUF_SIZE in the packet header. However,
>this is only checked once the SKB has been allocated and, if the length
>in the packet header is zero, the SKB may not be freed immediately.
>
>Hoist the size check before the SKB allocation so that an iovec larger
>than VIRTIO_VSOCK_MAX_PKT_BUF_SIZE + the header size is rejected
>outright. The subsequent check on the length field in the header can
>then simply check that the allocated SKB is indeed large enough to hold
>the packet.

LGTM, but should we consider this as stable material adding a Fixes tag?

Thanks,
Stefano

>
>Signed-off-by: Will Deacon <will@kernel.org>
>---
> drivers/vhost/vsock.c | 6 ++++--
> 1 file changed, 4 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>index 802153e23073..66a0f060770e 100644
>--- a/drivers/vhost/vsock.c
>+++ b/drivers/vhost/vsock.c
>@@ -344,6 +344,9 @@ vhost_vsock_alloc_skb(struct vhost_virtqueue *vq,
>
> 	len = iov_length(vq->iov, out);
>
>+	if (len > VIRTIO_VSOCK_MAX_PKT_BUF_SIZE + VIRTIO_VSOCK_SKB_HEADROOM)
>+		return NULL;
>+
> 	/* len contains both payload and hdr */
> 	skb = virtio_vsock_alloc_skb(len, GFP_KERNEL);
> 	if (!skb)
>@@ -367,8 +370,7 @@ vhost_vsock_alloc_skb(struct vhost_virtqueue *vq,
> 		return skb;
>
> 	/* The pkt is too big or the length in the header is invalid */
>-	if (payload_len > VIRTIO_VSOCK_MAX_PKT_BUF_SIZE ||
>-	    payload_len + sizeof(*hdr) > len) {
>+	if (payload_len + sizeof(*hdr) > len) {
> 		kfree_skb(skb);
> 		return NULL;
> 	}
>-- 
>2.50.0.714.g196bf9f422-goog
>
>

