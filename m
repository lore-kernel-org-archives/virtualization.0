Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFF0370AE2
	for <virtualization@lists.linux.dev>; Thu, 20 Aug 2026 09:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787217200; cv=none; b=fQBEswEy/4yBUebPcber62GGZx9JzB3tSwAX7mOsdDnF3IEM22PLHfDT/cH8ZBplxd4lQSModYvFFIy6gftKmrhtZUHcGkrTKc6z/PoQWoPNbwvAlaS82Vj0cpj9lOYot1+408VxPLNN7Qa/Unfl6q3ASAWzce7me0r39VW093c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787217200; c=relaxed/simple;
	bh=hPrJc7tLhkydvuvGvf8xRiI2Fvb0aBBPRteZTc4WY1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=d3zqvyIoZV0eDaf9u+SbHt+HC9OP1KtPJjop+2VELnL7HzkElBUJ+zLerMUvXibWRz7owcNEooJMYvCpUdx3sl5F0cVD/K8S3qgJXkrr/FY1xRO2jlCog4oFRCA4E9MA/h4Z9HVnRNRBeDYy8i+EKjfJ3ZU5K6pWqLmkScXATsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yo7R8tZL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yo7R8tZL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787217198;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DPZmMm/W2rtjcsEXGt7ZjhaQKZ8JdwFQHJlaLZYMDpQ=;
	b=Yo7R8tZLklxCEmVaiQxpMFLsLUse6tV3uQ7JCqhdMefPHb9XOkZ/XYQe98p9uuDRPgfYL5
	5rmoA9gQcfnWX1jQSnCwVByLT5+GGH72QWv3RK5/REmvycsdQmTgXgfXCGFQsw0ghjcwJ4
	pmuhxRwjGZpdvPRvMTzGSc6zhfCo6VI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-yRyJV7stP_iiBlGThLVyuQ-1; Thu, 20 Aug 2026 05:13:16 -0400
X-MC-Unique: yRyJV7stP_iiBlGThLVyuQ-1
X-Mimecast-MFC-AGG-ID: yRyJV7stP_iiBlGThLVyuQ_1787217195
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-496b6f97676so19439455e9.2
        for <virtualization@lists.linux.dev>; Thu, 20 Aug 2026 02:13:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787217195; x=1787821995;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DPZmMm/W2rtjcsEXGt7ZjhaQKZ8JdwFQHJlaLZYMDpQ=;
        b=hLuF5xltXF+RZmfuFeurCZCD0e4cL0vzhv/ILb5LH//epCrd8msSwHysAIyvCAZnq4
         Ob42gguDWEmRxYpnjInJuHtx93J+62CGivWJIoDnNE/22VeVSGWpVLSYmJLcKkWuHm3G
         XWxiO991ZVeC51DUJ8ERO/yALaDvcbEY+HOu1Vl+5CvUIFVBefhFANBD9CnL0ir+pD4K
         6wELr1iW1kfv2zTZ12vgpxpYvIh1F6xJQpa+h/bVab0PBQrJ6e/AONLv8F+HGgvIOcpM
         G7iYV70PYdlH+b0kr4/RHiE612itikSj2yHLjD5fcVUUt1UiLkc3YQ1y66LF8A5hXd3x
         SbTg==
X-Forwarded-Encrypted: i=1; AHgh+RpcH7Dcr8GT6DERE07nzvZ1kdRlM2zKXPvj6nnK/XzzVDaqOfasXNgRWHQM0eKSeGY8hettWL/b3NJSsh4PKA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxTOBOnL442c+MvM7QrZO89bOPbhWeEJ5+MZ4Tr1gHKQirsXso8
	7e0O3yVKtoLR4nEljnR66KSOgCZa5f5tV77XWPpzfHsREgSnYF88JXRWn2D6OwqSrdgtYPamCbQ
	8D+riXFmIh8skJuXcc0+IqJ+eDJvJUbDhB4Mq9MiC8DOB4xkCzUifKyZDE+O1SCJrJ7uc
X-Gm-Gg: AR+sD10zztArlHqetZDKrqJgb4SmaCUZ6kji8qzRmXvSjjzAQVNUiWn2kZeo68wldqC
	0Q4o5REp2xjG/KTvnWB48SAEh+GPxHxzxwLEj0RDCnQwcAhMGVluZyEkj71kXEFfSpz/qfmDrx6
	hbOrYUKdngk57/aW1r0JKfAMZZKg3wsSb+kT4EJIROWKtcDYfYUICUNo2VQz2tUQJ8jHOwNGxCn
	xMJu9lrtv6sTnBWNxfdzy2ihgO0MYOzHBNOTRAR9UgaLie0mfOX5GAwDhU1inTRRpkwQ0QGmF9O
	N7fFwSC87eQNYtyoJ7CDz1TEM94P0mV/vsinPe1sFw1VfXdW7JduvIdVLt7o4imtPr4u4DaR2zH
	6cr3o4Lz4tiPD3MTHEkbosbfI+AEETBQeld+2EgdqX96oR1j694AR
X-Received: by 2002:a05:600c:3ba2:b0:495:4d88:e630 with SMTP id 5b1f17b1804b1-499aa1a93fbmr209390645e9.10.1787217195321;
        Thu, 20 Aug 2026 02:13:15 -0700 (PDT)
X-Received: by 2002:a05:600c:3ba2:b0:495:4d88:e630 with SMTP id 5b1f17b1804b1-499aa1a93fbmr209389755e9.10.1787217194814;
        Thu, 20 Aug 2026 02:13:14 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-154.retail.telecomitalia.it. [82.53.135.154])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499aa0fd7a9sm164548055e9.2.2026.08.20.02.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 02:13:14 -0700 (PDT)
Date: Thu, 20 Aug 2026 11:13:09 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jia Jia <physicalmtea@gmail.com>
Cc: stefanha@redhat.com, mst@redhat.com, jasowangio@gmail.com, 
	eperezma@redhat.com, weiyj.lk@gmail.com, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/3] vhost/vsock: discard IOTLB when ACCESS_PLATFORM
 is cleared
Message-ID: <aobEwtvZ2WELwX15@sgarzare-redhat>
References: <20260820080332.313933-1-physicalmtea@gmail.com>
 <20260820080332.313933-3-physicalmtea@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260820080332.313933-3-physicalmtea@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: QPFB-TIp4nurZfi0C09ghNdoDGzt7cwW3_q4ySImPj0_1787217195
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Thu, Aug 20, 2026 at 04:03:31PM +0800, Jia Jia wrote:
>Clear the device IOTLB when userspace clears VIRTIO_F_ACCESS_PLATFORM.
>Otherwise descriptor translation can continue to use mappings installed
>before the feature change.
>
>The common helper invalidates cached vring access and applies the
>transition even while a backend is attached. The backend remains attached,
>but userspace must configure the vring addresses for the new address mode
>after a successful live transition.
>
>Fixes: e13a6915a03f ("vhost/vsock: add IOTLB API support")
>Suggested-by: Michael S. Tsirkin <mst@redhat.com>
>Signed-off-by: Jia Jia <physicalmtea@gmail.com>
>---
> drivers/vhost/vsock.c | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>index 9aaab6bb8061..e1e9d002d6ae 100644
>--- a/drivers/vhost/vsock.c
>+++ b/drivers/vhost/vsock.c
>@@ -865,9 +865,11 @@ static int vhost_vsock_set_features(struct vhost_vsock *vsock, u64 features)
> 		goto err;
> 	}
>
>-	if ((features & (1ULL << VIRTIO_F_ACCESS_PLATFORM))) {
>+	if (features & (1ULL << VIRTIO_F_ACCESS_PLATFORM)) {

Unrelated change...

I think I've already pointed something like this in previous versions: 
for a patch that fixes a specific issue, these unrelated changes should 
be avoided. Please keep this in mind.

Stefano

> 		if (vhost_init_device_iotlb(&vsock->dev))
> 			goto err;
>+	} else {
>+		vhost_clear_device_iotlb(&vsock->dev);
> 	}
>
> 	vsock->seqpacket_allow = features & (1ULL << VIRTIO_VSOCK_F_SEQPACKET);
>-- 
>2.34.1
>

