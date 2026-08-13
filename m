Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331FD450408
	for <virtualization@lists.linux.dev>; Thu, 13 Aug 2026 09:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786613986; cv=none; b=sHhuFgKQQZAEKhsbGG6iMZINKLTYcKNTn+dx1WtZZyOpHnp3r5ZC2tugEJu3GkqQUwIOZ9bDnEV1AdgAhsos7+BCbEsY4vpMdFqOj40Njd7iGeqYb4apMk7pGpGyJd9aO5BJSsOxyovzm7/9dp6ty1cO2BmC9dRR4cvf1K8t+2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786613986; c=relaxed/simple;
	bh=RIJDgA6soFRVC0k78nWGXCgPMPcUzn7IBwof5CGhtdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=On/r/sZ4dAsUV9fcqOjsYMHKvc5jj1mObc2cWVCnqPQ6zgIJHtQy7ddR/AfNpwRy85tMj4YxbYb9VnPg/sWxdY7Aj4Dj4k+DbnuSOhx4OFmLB2lVUBwgxgUt4puaayLTcRM0N0B1Kzohf/Reh3d8juA3ZyniLR41PSwwI8k/Vcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JDngVWrN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JDngVWrN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786613984;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9F6N+VCq58ZT8xzy15i+HHmMii8MMNX7ejz2MgM7nfQ=;
	b=JDngVWrNLFp8rBTx+uoPUIqOrXYGU5wKT2c6/5z3B6ESDg2fAbr67LzmSjgl9BRmTdFCJ7
	keNUMTypdMvZo69dMff1d3+k927n7CJ47jUmw1lQdPZztn7lFgsrXyL4MzNVFg3jjr8EKS
	AAL8P8IzXIt3fe8MSh6UlDRTaoa1thE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-gqBhC4NWNmy7oWyQ2b4lJw-1; Thu, 13 Aug 2026 05:39:37 -0400
X-MC-Unique: gqBhC4NWNmy7oWyQ2b4lJw-1
X-Mimecast-MFC-AGG-ID: gqBhC4NWNmy7oWyQ2b4lJw_1786613977
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-47fd4ee0ac0so391330f8f.2
        for <virtualization@lists.linux.dev>; Thu, 13 Aug 2026 02:39:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786613977; x=1787218777;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9F6N+VCq58ZT8xzy15i+HHmMii8MMNX7ejz2MgM7nfQ=;
        b=bw4Wq0V7F97/dnsvqXLpjGvNomumfiozIcd8fPO2kfcVPi3SphCANYLy8ZETQXn5Od
         O0zCGdODRkRzBqn6tvzfO/KMQMj8v/pUN6hz24JCQhsifc0riERrec2wBASPmFsjl5B5
         lZtcVaSTXN23Xdk5AarLrUxb1IRFS2/TpOWNMe/261voGNX2m8Vly3hwi6v3I4nLQw1T
         tJHOdw2rQZiU3fMfZsGsgo1xoqICkTVGfwbAzIZ3oXZ2dri+qRrbzDANui+6pS5v/D97
         3j3+NlRhq2YlyDhutUv57Vq5Kwe56Lb1lYf7BO4e2Y/1X01BCB+p+jRy0sXdUKjY1GzU
         k6eA==
X-Forwarded-Encrypted: i=1; AHgh+RobRSHl9LZJZp2ImPuD65nej72KYUIsS6A2KZZVMgPj+bmAnNhLP7CHsHsAXpLhY87z8eEqHP8qdR3hJ/KjUw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw7h3ztvYLA9IaYycp1ZDaoFg9ZnLOGL63JcRXgax1pZ6rHb6e9
	upijfonwVKji61fqxRvNSfs5OI15AAGfw8riebiIEocOJ11OrTU37atQzBEaMxt2xhz0BEISBqh
	D8F4XaROg8Vz5gCkNUCm0CEbD9kbQFYW84WpgN3Cj9P1tqwj9sKb9EFlc1cvOhBwdUkDPbDjfZQ
	V+
X-Gm-Gg: AR+sD122sp0zcfua/s1DkWJnBQ6qpNlB+ABiHFBEzz7B7ina39EfskNuGoKGqdQX0Yg
	ep/lllmyoeQs0hG1H+XAimXKu/mxw+FNbnOhUnvPbwrFfjrAUJakyXgV3kLPWK/fpw6rekdcZt3
	c+5dFsHevHqClkJ2kEpyqaCWJ/+EjBpMKYb0yXG4SaBwVUNVzMAbu3DnDNwNNVKp0XioTTtB5dQ
	5Jxd/V8nQOGmOvXSKpDiOQAVy7G9kRkAzM9aA8JsejZJmXORAOakjUAiww2NSqRlB8cOzHvpnOI
	lOvsLQSjYIjfyYOpDLw+NlBMmXFOWKww/Payt2STPrEzNTZ3tQqltWW87UskhWnB01g08zLK0Ze
	Tnb0n75BFg2XQS0+VpryeA6Mdbs7QZWOqj0DUXWZWaRFjOEc1Xp7l
X-Received: by 2002:a05:6000:220d:b0:475:3a97:8e2c with SMTP id ffacd0b85a97d-4815a01c666mr5772515f8f.16.1786613976689;
        Thu, 13 Aug 2026 02:39:36 -0700 (PDT)
X-Received: by 2002:a05:6000:220d:b0:475:3a97:8e2c with SMTP id ffacd0b85a97d-4815a01c666mr5772398f8f.16.1786613976129;
        Thu, 13 Aug 2026 02:39:36 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-154.retail.telecomitalia.it. [82.53.135.154])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815a5612d0sm4972789f8f.2.2026.08.13.02.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 02:39:35 -0700 (PDT)
Date: Thu, 13 Aug 2026 11:39:30 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jia Jia <physicalmtea@gmail.com>
Cc: stefanha@redhat.com, mst@redhat.com, jasowangio@gmail.com, 
	eperezma@redhat.com, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] vhost/vsock: discard IOTLB when ACCESS_PLATFORM
 is cleared
Message-ID: <an2KTuUm-mZ0nnDQ@sgarzare-redhat>
References: <20260810134018.143973-1-physicalmtea@gmail.com>
 <20260810134018.143973-2-physicalmtea@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260810134018.143973-2-physicalmtea@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: chNSX0XHsQ3eMHHhRQ4Hd_AOStq6SK-s7iulScULjHM_1786613977
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Mon, Aug 10, 2026 at 09:40:17PM +0800, Jia Jia wrote:
>vhost_vsock_set_features() leaves the device IOTLB attached when
>userspace clears VIRTIO_F_ACCESS_PLATFORM. Descriptors can therefore
>continue to use translations installed before the feature change,
>including HVAs made stale by a later memory table update.
>
>Detach the device IOTLB before acknowledging a feature mask without
>ACCESS_PLATFORM. Serialize each virtqueue handoff with its own mutex
>while clearing its IOTLB pointer, resetting its metadata cache, and
>updating its acknowledged features. Keep the old IOTLB alive until all
>virtqueues have dropped their references, then free it.
>
>Also drop queued IOTLB miss messages and wake readers now that the
>device no longer accepts IOTLB updates.
>
>Fixes: e13a6915a03f ("vhost/vsock: add IOTLB API support")
>Suggested-by: Michael S. Tsirkin <mst@redhat.com>
>Signed-off-by: Jia Jia <physicalmtea@gmail.com>
>---
> drivers/vhost/vsock.c | 39 ++++++++++++++++++++++++++++++++++-----
> 1 file changed, 34 insertions(+), 5 deletions(-)
>
>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>index 9aaab6bb8061..7372c22691de 100644
>--- a/drivers/vhost/vsock.c
>+++ b/drivers/vhost/vsock.c
>@@ -851,6 +851,30 @@ static int vhost_vsock_set_cid(struct vhost_vsock *vsock, u64 guest_cid)
> 	return 0;
> }
>
>+/* Caller must hold the device mutex. */
>+static void vhost_vsock_clear_iotlb(struct vhost_vsock *vsock, u64 features)
>+{
>+	struct vhost_iotlb *iotlb;
>+	struct vhost_virtqueue *vq;
>+	int i;
>+
>+	iotlb = vsock->dev.iotlb;
>+	vsock->dev.iotlb = NULL;
>+
>+	for (i = 0; i < ARRAY_SIZE(vsock->vqs); i++) {
>+		mutex_lock(&vsock->vqs[i].mutex);
>+		vq = &vsock->vqs[i];

You can assing vq before the mutex_lock() and use it there too (and in 
mutex_unlock()), as we do in all other places in this file.

>+		vq->iotlb = NULL;
>+		memset(vq->meta_iotlb, 0, sizeof(vq->meta_iotlb));
>+		vq->acked_features = features;
>+		mutex_unlock(&vsock->vqs[i].mutex);
>+	}
>+
>+	vhost_clear_msg(&vsock->dev);
>+	vhost_iotlb_free(iotlb);
>+	wake_up_interruptible_poll(&vsock->dev.wait, EPOLLIN | EPOLLRDNORM);
>+}

I don't see anything vsock specific here. Would it be better to move 
this to vhost.c and reuse some of the functions we have there?

I mean something like this (untested and may be incomplete):


void vhost_clear_device_iotlb(struct vhost_dev *d)
{
	struct vhost_iotlb *iotlb;
	int i;

	iotlb = d->iotlb;
	d->iotlb = NULL;

	for (i = 0; i < d->nvqs; ++i) {
		struct vhost_virtqueue *vq = d->vqs[i];

		mutex_lock(&vq->mutex);
		vq->iotlb = NULL;
		__vhost_vq_meta_reset(vq);
		mutex_unlock(&vq->mutex);
	}

	vhost_clear_msg(d);
	vhost_iotlb_free(iotlb);
	wake_up_interruptible_poll(&d->wait, EPOLLIN | EPOLLRDNORM);
}
EXPORT_SYMBOL_GPL(vhost_clear_device_iotlb);


>+
> static int vhost_vsock_set_features(struct vhost_vsock *vsock, u64 features)
> {
> 	struct vhost_virtqueue *vq;
>@@ -872,11 +896,16 @@ static int vhost_vsock_set_features(struct vhost_vsock *vsock, u64 features)
>
> 	vsock->seqpacket_allow = features & (1ULL << VIRTIO_VSOCK_F_SEQPACKET);
>
>-	for (i = 0; i < ARRAY_SIZE(vsock->vqs); i++) {
>-		vq = &vsock->vqs[i];
>-		mutex_lock(&vq->mutex);
>-		vq->acked_features = features;
>-		mutex_unlock(&vq->mutex);
>+	if (!(features & (1ULL << VIRTIO_F_ACCESS_PLATFORM)) &&
>+	    vsock->dev.iotlb) {
>+		vhost_vsock_clear_iotlb(vsock, features);
>+	} else {
>+		for (i = 0; i < ARRAY_SIZE(vsock->vqs); i++) {
>+			vq = &vsock->vqs[i];
>+			mutex_lock(&vq->mutex);
>+			vq->acked_features = features;
>+			mutex_unlock(&vq->mutex);
>+		}

TBH I don't like this mix.

Why assigning acked_features inside vhost_vsock_clear_iotlb()?

IMO it's confusing. I see that you're saving another loop around the 
VQs, but this code is not easy to understand IMO.

I think we have 2 options:
1. leave the loop for acked_features and don't set it in
    vhost_vsock_clear_iotlb() (less code touched by this patch).
    This is also what to do if we move the clear_iotlb() function
    in vhost.c.
2. change the code to have a single for loop with if block inside to
    reset IOTLB stuff if needed. In this case maybe better to avoid the
    function and move the entire code here.

I prefer 1 with clear_iotlb() in vhost.c, but I'm not fully against 2.

Thanks,
Stefano


> 	}
> 	mutex_unlock(&vsock->dev.mutex);
> 	return 0;
>-- 
>2.34.1
>

