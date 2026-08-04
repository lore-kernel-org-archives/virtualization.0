Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8745B3EE1FE
	for <virtualization@lists.linux.dev>; Tue,  4 Aug 2026 03:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785813540; cv=none; b=k6aYxs8wS+A2YyV/R0gNvQc5IDcRaJTUfs8frTm6Xp7rzyhJNhT6vd1ww8tpaRsL8k5ZlxZNw/PBfaf3chzrkpEko0T3KeSeHIE+8ZhyJCCuZXgUvNDm8pa1XPxnkCBuMlJNwHL5ar52zOpSLSmPKhTmtb2T4zlLubTmqfh5z/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785813540; c=relaxed/simple;
	bh=vjexPMXz+uHstAFBD5kC8PIMoFh7FLyMaZtlnqi/L7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=lfTdE9KvspOVU28AcwqCmT8zovulmC/Rk/DXVeYnpRdA6X9rR6tKCIy09k80zwtyfp0tJmgJ1x+7z9PUm5iVu7hrKTj0GEKL4bnFmt7q0jhu1ENDfj0JyeXw9ftWo/DMMHlfr0mjuEywzfArEKGJRNoLskSXwtrIuGQdkBiwrRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WOsmrTl0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WOsmrTl0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785813537;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hn89OAtGF04fL1DOEPjseXWeO4u1I3kemB7CwT2Ey+4=;
	b=WOsmrTl0WPEYOFPXeNljOcoJoRUC4RfI3uHlEBrEHkt1DiNdxBxtfXtbbsJED3LveS2Kz/
	9vozBWMnJxCWerxFuy0Cq8xSmLck86C3emQbHWCvrg+c3UOCUn0LJo3wNkJO8Qdxac3xVf
	kjDA205eNy6LAzx3wOe8JOsTsPKcgog=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-100-66LamftTO0WLJzF2f2Wkow-1; Mon, 03 Aug 2026 23:18:56 -0400
X-MC-Unique: 66LamftTO0WLJzF2f2Wkow-1
X-Mimecast-MFC-AGG-ID: 66LamftTO0WLJzF2f2Wkow_1785813535
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-698557ec1e9so3226188a12.1
        for <virtualization@lists.linux.dev>; Mon, 03 Aug 2026 20:18:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785813535; x=1786418335;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hn89OAtGF04fL1DOEPjseXWeO4u1I3kemB7CwT2Ey+4=;
        b=RHgtJv8hanBnL36c1dbAZ5pZELVaVwv5Kp2g525snv5ESBjQKyrmFk7cHz2GmsO8fv
         r/XCERLpdAM5QaZ++seM8E1Bb+2wA7EqneFGKNQaZne4k4pnoLpL12TWUlkfPtvoaI12
         UYX6CvV65aUEsoG8QmBwKmPaFs8ZIlAbOBNvXm3fqGuE1dWLmVwDEy2qRI9ryMzASrdv
         9N+X643QGz4FItlpajDZcnPEDtpRrUtFY1M83fJ7bwka3dg2bDSY3jdB408Qpl05PGKf
         fO4PtmBR4i6rpwsBn7Nsqc9pauVHHljIURrMVjME/6BkP50LOlyLB7fICQ/3q+Qpoiy6
         dcxg==
X-Forwarded-Encrypted: i=1; AHgh+RrazG2PU9CRLXMaODiy8wrPHTMkee9cL9QRJ1EkYDaHjRkXa6yLEbWe0dV2kFAUg4iGeZQ5SwEUZ9wcM5T6gQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw9JKRnk9FXT9HN1xgKa9W+6fhrurP82d53ykLPr4iBnDzmJo8c
	fAQmNLATOgJMsLXIKUFatw0kXntihc+UbRtZXNKt90nt+bxpGcYu15rjXwYuKQSIE4yt26p4nwR
	DTtbs6C8KuVfEsH9bKt3w9F3GjiVxVNDa3ANo6E0wXGCyYeLFh2NRZ7aIxRko/UzUOMNe
X-Gm-Gg: AR+sD12pSjA8S8iXPdHw8XdOlvLNxAba2cD2qua8pdBRKlAtgJdWgwIEepSbsIgzihR
	uzK+VuG+8n7CIMRPviHL87cf8LqumNVBa3K8P49vP1qVCTxxISx7xEz/OymclhDLJBc1Yr20j00
	kBjD+e6iU0CkKSf460v+1VdMSsm7i0J7LrY0nUJ8nYkKHLKjACFmYCMSm9cf0oN/CyrPNqETbha
	C+fuGql6Ttgt1ugyon70N6vffJvZe1n9VBZ3tHUk5zlAfWwAdgYMmg/SwLW6z7sxDj6uNKUW8E1
	9FclMAYr6eYuiiTuEvGdschVNfz2Ekp1PLG7Jivs4yBecHbx3QOHb8M48eCIlYZEc5lg
X-Received: by 2002:a05:6402:42c8:b0:6a1:2400:baea with SMTP id 4fb4d7f45d1cf-6a12400bf12mr1998133a12.10.1785813534920;
        Mon, 03 Aug 2026 20:18:54 -0700 (PDT)
X-Received: by 2002:a05:6402:42c8:b0:6a1:2400:baea with SMTP id 4fb4d7f45d1cf-6a12400bf12mr1998100a12.10.1785813534402;
        Mon, 03 Aug 2026 20:18:54 -0700 (PDT)
Received: from redhat.com ([186.247.166.67])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a09c5a09acsm5960120a12.4.2026.08.03.20.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 20:18:53 -0700 (PDT)
Date: Mon, 3 Aug 2026 23:18:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jia Jia <physicalmtea@gmail.com>
Cc: stefanha@redhat.com, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] vhost/vsock: discard IOTLB when ACCESS_PLATFORM
 is cleared
Message-ID: <20260803231405-mutt-send-email-mst@kernel.org>
References: <20260730104857-mutt-send-email-mst@kernel.org>
 <20260731103414.1746316-1-physicalmtea@gmail.com>
 <20260731103414.1746316-2-physicalmtea@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260731103414.1746316-2-physicalmtea@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: KQo6PiNF9tn6azo8VeRffpYaZHwlih3AA9HrPwQQ1WE_1785813535
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 31, 2026 at 06:34:13PM +0800, Jia Jia wrote:
> vhost_vsock_set_features() leaves the device IOTLB attached when
> userspace clears VIRTIO_F_ACCESS_PLATFORM. Descriptors can therefore
> continue to use translations installed before the feature change,
> including HVAs made stale by a later memory table update.
> 
> Detach the IOTLB before acknowledging a feature mask without
> ACCESS_PLATFORM. Hold all virtqueue mutexes in index order while clearing
> the device and virtqueue IOTLB pointers, resetting metadata caches, and
> updating the acknowledged features. This prevents a kick handler from
> observing a mixed translation state.
> 
> Free the old IOTLB after releasing the virtqueue mutexes. Also drop
> the old IOTLB miss messages and wake readers now that the device no
> longer accepts IOTLB updates.
> 
> Fixes: e13a6915a03f ("vhost/vsock: add IOTLB API support")
> Signed-off-by: Jia Jia <physicalmtea@gmail.com>
> ---
>  drivers/vhost/vsock.c | 43 ++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 38 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> index 9aaab6bb8061..562b9e139a76 100644
> --- a/drivers/vhost/vsock.c
> +++ b/drivers/vhost/vsock.c
> @@ -851,6 +851,34 @@ static int vhost_vsock_set_cid(struct vhost_vsock *vsock, u64 guest_cid)
>  	return 0;
>  }
>  
> +/* Caller must hold the device mutex. */
> +static void vhost_vsock_clear_iotlb(struct vhost_vsock *vsock, u64 features)
> +{
> +	struct vhost_iotlb *iotlb;
> +	struct vhost_virtqueue *vq;
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(vsock->vqs); i++)
> +		mutex_lock_nested(&vsock->vqs[i].mutex, i);
> +
> +	iotlb = vsock->dev.iotlb;
> +	vsock->dev.iotlb = NULL;
> +
> +	for (i = 0; i < ARRAY_SIZE(vsock->vqs); i++) {
> +		vq = &vsock->vqs[i];
> +		vq->iotlb = NULL;
> +		memset(vq->meta_iotlb, 0, sizeof(vq->meta_iotlb));
> +		vq->acked_features = features;
> +	}
> +
> +	for (i = ARRAY_SIZE(vsock->vqs); i-- > 0;)
> +		mutex_unlock(&vsock->vqs[i].mutex);

Why lock down all vqs like this?  Would this work just as well instead?

	iotlb = vsock->dev.iotlb;
	vsock->dev.iotlb = NULL;

	for (i = 0; i < ARRAY_SIZE(vsock->vqs); i++) {
		mutex_lock(&vsock->vqs[i].mutex);
		vq = &vsock->vqs[i];
		vq->iotlb = NULL;
		memset(vq->meta_iotlb, 0, sizeof(vq->meta_iotlb));
		vq->acked_features = features;
		mutex_unlock(&vsock->vqs[i].mutex);
	}

and if no why not?


> +	vhost_clear_msg(&vsock->dev);
> +	vhost_iotlb_free(iotlb);
> +	wake_up_interruptible_poll(&vsock->dev.wait, EPOLLIN | EPOLLRDNORM);
> +}
> +
>  static int vhost_vsock_set_features(struct vhost_vsock *vsock, u64 features)
>  {
>  	struct vhost_virtqueue *vq;
> @@ -872,11 +900,16 @@ static int vhost_vsock_set_features(struct vhost_vsock *vsock, u64 features)
>  
>  	vsock->seqpacket_allow = features & (1ULL << VIRTIO_VSOCK_F_SEQPACKET);
>  
> -	for (i = 0; i < ARRAY_SIZE(vsock->vqs); i++) {
> -		vq = &vsock->vqs[i];
> -		mutex_lock(&vq->mutex);
> -		vq->acked_features = features;
> -		mutex_unlock(&vq->mutex);
> +	if (!(features & (1ULL << VIRTIO_F_ACCESS_PLATFORM)) &&
> +	    vsock->dev.iotlb) {
> +		vhost_vsock_clear_iotlb(vsock, features);
> +	} else {
> +		for (i = 0; i < ARRAY_SIZE(vsock->vqs); i++) {
> +			vq = &vsock->vqs[i];
> +			mutex_lock(&vq->mutex);
> +			vq->acked_features = features;
> +			mutex_unlock(&vq->mutex);
> +		}
>  	}
>  	mutex_unlock(&vsock->dev.mutex);
>  	return 0;
> -- 
> 2.34.1

