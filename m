Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41904279DB6
	for <virtualization@lists.linux.dev>; Thu, 23 Jul 2026 15:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784819901; cv=none; b=GIbLR3hWSmAmQUz3Qff47e8MzK8P5TGvZ2CBBz1u8lnitbT1dbwvAy56J+Qe2md4Uc8+b+QIyEoSoq0ZOh9HEo/23FJ0Zo7K6oITMDOQpDPeXX7qk7hDjqPMPvU+5VpTelJo9QjX/3/rZsHtPzGShKVdvPFdg9DsXhO24Ig0CQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784819901; c=relaxed/simple;
	bh=rSe9HD907K8IRLWvdPwE7ouRnZKLSw9p6mExkMka2to=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=bIwUiaIuHkIm05Y0Y5tm4tksLRPNEhySfO6rMKWIK4DG3sr8+BJzjC9jiDTXZ7WXM9RwypwD17JvYXv5b5m9rne3ibkAm0NDtreYyjY+l98jD5hejjyeME9icruJ11eJhr87vBycMlPch3Uh6Yz+I76yjaRyewwGv6hz5NGn6XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LzENcHB1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LzENcHB1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784819892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9OUorP8L7Hv+mWbQVnXQe/Nap+PNXLSDh1VLwTpZtYE=;
	b=LzENcHB1cpLjBEdZ9cuFWNVyohdTFmqAa5uS1Qe12rANZDve9zhxVseFElVf7pXst9gXQl
	RDr2tHAWamFHBsAgkwbkUq6vtPq+yuMrpPPXY77n4VvCCFAdCwm3Rh7b0pUYOQIASf0a7H
	Vl8cTZaFt8CghHIzzF8VvfxLetY4OfA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-49--YmHHB6oMGSPIkoYYCyOeA-1; Thu, 23 Jul 2026 11:18:11 -0400
X-MC-Unique: -YmHHB6oMGSPIkoYYCyOeA-1
X-Mimecast-MFC-AGG-ID: -YmHHB6oMGSPIkoYYCyOeA_1784819890
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-4629f312a67so630564f8f.2
        for <virtualization@lists.linux.dev>; Thu, 23 Jul 2026 08:18:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784819890; x=1785424690;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9OUorP8L7Hv+mWbQVnXQe/Nap+PNXLSDh1VLwTpZtYE=;
        b=Ol94LVQnbtc8KKmEBCfLxgCuulMF0uejDN6ZPzZK2Z2Hw/iCt075enMlp2XJvqEoKV
         XUuF/8RkaZY1yvK3kCw0sntEP4DbW4EU7K1btDJBV2YVYqTY2MWF0EQ/ijAPaVFLf3Ko
         fJDy7h9QsEvYsTT31NVPQuBPsTwpFDIM4Z0Eys9RFpgwJadK2XW8BHWkp5khJtonM93r
         kIEsB6Y/+gporUmtfFn3q4gZO/7krqZLIUMGCR9SBrSLDjBMZVxV08fzkQbMyRfndufk
         bF9G/kkqdJp1BgTvSwVjys89jUqgNZbCkKlH87L9xGDZ6QB2HmLYjpEIrd3DAXIDm5SV
         3Y1A==
X-Forwarded-Encrypted: i=1; AHgh+RpHt5Jlrw6yIE4XMtaJ3GrVsyn9e5F1yPx4B+iTouaV17Qm8S2N/7TsfhpqkpDUAK6RZjSXXRg6UF4mEbm00w==@lists.linux.dev
X-Gm-Message-State: AOJu0YxE7EQ7taJuM0hfGvW8DXMGQj8EBvlMnuLyY8hqV+zr+bFPz9S0
	5FN8iTODxTKWVw7S0OPxRaBsDeIsi8eLpG8HrGKWlGQKt5/YCXbhlPvkVR6f1t+jbiYlhwd21HV
	S4zHNII8FwYoez7xAqI/ZlvmIfEWZUcrkpsPRVKITe8gjoViEWbiT+pUd91E0RuinIXjI
X-Gm-Gg: AR+sD13tgeVgH/LkVHUTcYGu+3qldtBGC+CpioCO5ILiAfoZbgMqRp2BVDRuVofwceW
	b+CVmaohB3f80LQhVV2h1mcQe6MQTqlFsa/Te2DA6mNUX3lvdMo8NUoPTLzJWSouVK5CoAvZhCW
	o0CpV3wlJuKWipqYQ0EQXcKErso4yQElc6LThK2CceXGf3zeOk9aGXvunBhJd0yXDioBc/Hi9gv
	C+scQMIUvxvrn9ljEJ1NZNz7a7zCPH+Br49krAb3CpxrGcJ5MPUKJPU9XV57jZumoNI1S/Po2e1
	nN/W+8sG1ibS/S2Bu/Ihq8jF5dD5jMfDm8mL5znSJsmKR5vt7l0rCfYrQeY8vhxO8uUkRryZtZd
	7ln1xlt6aNxlc7iAcni2rrQ==
X-Received: by 2002:a05:6000:4386:b0:474:13ac:a91b with SMTP id ffacd0b85a97d-47f8d7564edmr4641369f8f.32.1784819889732;
        Thu, 23 Jul 2026 08:18:09 -0700 (PDT)
X-Received: by 2002:a05:6000:4386:b0:474:13ac:a91b with SMTP id ffacd0b85a97d-47f8d7564edmr4641303f8f.32.1784819889120;
        Thu, 23 Jul 2026 08:18:09 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-37-66.inter.net.il. [80.230.37.66])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85bc62basm16346454f8f.13.2026.07.23.08.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 08:18:08 -0700 (PDT)
Date: Thu, 23 Jul 2026 11:18:05 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	sgarzare@redhat.com, stefanha@redhat.com, dongli.zhang@oracle.com,
	maciej.szmigiero@oracle.com, bchaney@akamai.com,
	mark.kanda@oracle.com, ptikhomirov@virtuozzo.com, den@openvz.org
Subject: Re: [PATCH v5 4/5] vhost: synchronize with RCU readers when freeing
 workers
Message-ID: <20260723111557-mutt-send-email-mst@kernel.org>
References: <20260720102241.371610-1-andrey.drobyshev@virtuozzo.com>
 <20260720102241.371610-5-andrey.drobyshev@virtuozzo.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260720102241.371610-5-andrey.drobyshev@virtuozzo.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: gmJVyFJMqSzPChyKvZvACnWIA4iREzxsnkuSE9MttKk_1784819890
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 20, 2026 at 01:22:40PM +0300, Andrey Drobyshev wrote:
> vhost_vq_work_queue() only holds the RCU read lock while it dereferences
> vq->worker and queues work on it.  vhost_workers_free() however clears
> the vq->worker pointers and immediately frees the workers, without
> waiting for a grace period.  A caller that fetched the worker right
> before the pointer was cleared can therefore still be queueing work on
> it while it is freed.  And even when the queueing itself wins the race,
> the work is never run, so its VHOST_WORK_QUEUED bit stays set and all
> future attempts to queue it are silently skipped.
> 
> None of the current callers can actually hit this: net and scsi stop
> their virtqueues before the workers are freed, and vsock unhashes the
> device and does synchronize_rcu() of its own in vhost_vsock_dev_release()
> before the workers go away.  But the upcoming VHOST_RESET_OWNER support
> in vhost-vsock keeps the device hashed while its workers are freed, so
> the lockless send/cancel paths become able to race with the teardown.
> 
> Fix this by clearing the vq->worker pointers, waiting for a grace
> period, and then flushing the workers so any work the last readers
> queued runs before the workers are freed.




> Fixes: 228a27cf78af ("vhost: Allow worker switching while work is queueing")
> Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> ---
>  drivers/vhost/vhost.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 4c525b3e16ea..d6e235c25254 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -729,6 +729,17 @@ static void vhost_workers_free(struct vhost_dev *dev)
>  
>  	for (i = 0; i < dev->nvqs; i++)
>  		rcu_assign_pointer(dev->vqs[i]->worker, NULL);
> +
> +	/*
> +	 * vhost_vq_work_queue() reads vq->worker under rcu_read_lock(), so a
> +	 * reader that fetched a worker before we cleared the pointers above
> +	 * may still be queueing work on it.  Wait for those readers to
> +	 * finish, then flush so any work they queued runs (clearing
> +	 * VHOST_WORK_QUEUED) before the workers are freed.
> +	 */
> +	synchronize_rcu();



Any way not to add this for all devices that don't need it?
Or preferably, even for vsock in absense of the new ioctl?


> +	vhost_dev_flush(dev);
> +
>  	/*
>  	 * Free the default worker we created and cleanup workers userspace
>  	 * created but couldn't clean up (it forgot or crashed).
> -- 
> 2.47.1

