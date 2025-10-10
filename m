Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5F9215077
	for <virtualization@lists.linux.dev>; Fri, 10 Oct 2025 12:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760099693; cv=none; b=Wf7/im+qWiJAqTqIQM6rQnA2cY4z2xoqxkbBZtqTztLJkuYSHrMb7OxLEGStywxvDWYXH7aToqvio9PBrFnpZ3+IPaCrE38BN6Hjb5OBanrtVCqRgqgm5QUFD09juFGmaUWylXGnRxm9/jVgFrdlfcgIkxJHFZxAt7CGcjz+m0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760099693; c=relaxed/simple;
	bh=PwmlyWveudHsfIuS3VUTnA/X9VYHtp8ZDcXtF9h5RNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=qhu7wdFbTMhx465FxngrIPOlGkwDFT1qSW0/URm87nCZC8ziy/H9olwg6MlaQk9k25/7PHGirSSizFU9/NQp2CelkAF7ll/B41GmMBCbwgIMiYA80irxvCYMcK/+bZcJuI1+E60rLF8AZBEraHFCqO1APdTH/Eap0fdsgdkrPdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lb9Sxp1P; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lb9Sxp1P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760099691;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9z70Jd6Jv9AFlxbEVxRvcKoGb7CrJGFNdocAe+tNYw0=;
	b=Lb9Sxp1PWaRBcNPAUgWf8fxSiJVtZC/zGOOexePE9qqhl/OAD0LQ9WATRy9TFJNuFCJg1c
	bsDw70ZiY367Gx1afJ3APlmsqAzucSQuSKbFEKwxWkRwq5EjVZDTgTogT2IO9O9k4Hka3D
	LMm/m/bsmIwN9puvcJdyTyqT+0ZLYdU=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-7yiTC2nLNF-a5LrkbNANhQ-1; Fri, 10 Oct 2025 08:34:48 -0400
X-MC-Unique: 7yiTC2nLNF-a5LrkbNANhQ-1
X-Mimecast-MFC-AGG-ID: 7yiTC2nLNF-a5LrkbNANhQ_1760099687
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b3cd833e7b5so188653666b.3
        for <virtualization@lists.linux.dev>; Fri, 10 Oct 2025 05:34:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760099687; x=1760704487;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9z70Jd6Jv9AFlxbEVxRvcKoGb7CrJGFNdocAe+tNYw0=;
        b=N0a5+c1hz5aKSWeWBuWXpzRQKgTIAmi5+w0yeIe24inUtMlzoHVVIQ7mUh+phgyWfa
         FSzhyE33SYwBpjosRMKmfcAEJpkbe3Wom94lsVe2z3lKxjfA7h4NxchOOAnc3QK3G3Ck
         BpEmwgR2vcsbMEN8W7+tFm+pCt4zybYZd/PAV+nUzkbhdWXTbKw+FyTwuFCUTtoV6071
         u/59sjSE+m+AW+bVx2t7rbKEGF2snsbMUg5eNdwCWUKKWq7/vJ2KEV8dkDgpv2TmObh9
         vZCM3MJmWn3+Q2IapUlCHhMeJFLTbnoVZtWFAC2oFsJoOd0KBDALlqcPaVGp30vUgY3l
         50JA==
X-Forwarded-Encrypted: i=1; AJvYcCVcrESFdJmBu1Bn+zFIhtow2HseqJj0CrcXILqazziB5Fy33eTgVshkLJpwKpButABssJkx4Nz49TG46Ut6NQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxmTnVMKDlT2SXUMvVIUOVKxvyQ7lx8Ha506Mtv5oVrM9ZvNv4C
	uFhpNHbkedWBNJyVenP6aJVR9eXwG/jCa7E5NZ1wRLXhT9AbmRESn272mzYiQPsUiOS/HmYUxFD
	llnQIUVPw/mX31NJi8TQaANHLTYNpm7OxR4riRqaXZ8xt3zZXHvj9yA2K6DbXYcppvzorMJSLzT
	9ShPM=
X-Gm-Gg: ASbGncstyVoT+kgyV0Y9apFzUnnaNRhwN3+5szIqtH9lOcmKYlF2wKygBvqI5sZA1VZ
	683dVmnLq7ZsGftLgJsxY0Jqk10UvLDkptV3TKbXII3H+iDIbmy382WbmGUu8bTnAEw/Arouhj8
	kwDYIHPmOhyCfZSBYocK1DNoYu2EObk3qZKdDrzgtg13vwlM9K1F9zwJ9bBsN3iOU8TAU3MGCy/
	21vvsWhn0oXVCcV8PCImOGJPsk4vsFxjTXPP8dhr3+LNwbHH36CR2JOHx6Gr6B4e+eZdr7Tz67Y
	YrgRni7TUPZlpiokuY9wyP+YEde/
X-Received: by 2002:a17:907:d86:b0:b3f:d9e9:baab with SMTP id a640c23a62f3a-b50aa8a9056mr1437765666b.27.1760099686706;
        Fri, 10 Oct 2025 05:34:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOOuXoMTv1v6zU6HQiuOj2sYZLdwOiI3H/cJN2ehsK1BrwiYpMK7mvk6NtIT530qtHzdp0AQ==
X-Received: by 2002:a17:907:d86:b0:b3f:d9e9:baab with SMTP id a640c23a62f3a-b50aa8a9056mr1437761466b.27.1760099686225;
        Fri, 10 Oct 2025 05:34:46 -0700 (PDT)
Received: from redhat.com ([31.187.78.23])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d8c12a62sm227557066b.58.2025.10.10.05.34.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 05:34:45 -0700 (PDT)
Date: Fri, 10 Oct 2025 08:34:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Cc: Yongji Xie <xieyongji@bytedance.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	jasowang@redhat.com, Maxime Coquelin <mcoqueli@redhat.com>,
	Laurent Vivier <lvivier@redhat.com>, Cindy Lu <lulu@redhat.com>
Subject: Re: [PATCH v7 1/7] vduse: make domain_lock an rwlock
Message-ID: <20251010081923-mutt-send-email-mst@kernel.org>
References: <20251010085827.116958-1-eperezma@redhat.com>
 <20251010085827.116958-2-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251010085827.116958-2-eperezma@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 47v7ezZTjqX78HamLAPZlEYPQYuraopBVe6TPFML9V8_1760099687
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Oct 10, 2025 at 10:58:21AM +0200, Eugenio Pérez wrote:
> It will be used in a few more scenarios read-only so make it more
> scalable.

Well a mutex is sleepable and rwlock is a spinlock.

So this does much more than "make it more scalable".

"A few more scenarios" and "scalable" is also vague.
RW has its own issues such as fairness.

So tell us please,  which operations do you want to speed up and why?
What kind of speedup was observed?

All this belongs in the commit log.

> Suggested-by: Xie Yongji <xieyongji@bytedance.com>
> Acked-by: Jason Wang <jasowang@redhat.com>
> Reviewed-by: Xie Yongji <xieyongji@bytedance.com>
> Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
> ---
> v6: Not including linux/rwlock.h directly.
> 
> v2: New in v2.
> ---


...


> @@ -2045,11 +2046,11 @@ static int vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
>  	if (ret)
>  		return ret;
>  
> -	mutex_lock(&dev->domain_lock);
> +	write_lock(&dev->domain_lock);
>  	if (!dev->domain)
>  		dev->domain = vduse_domain_create(VDUSE_IOVA_SIZE - 1,
>  						  dev->bounce_size);
> -	mutex_unlock(&dev->domain_lock);
> +	write_unlock(&dev->domain_lock);
>  	if (!dev->domain) {
>  		put_device(&dev->vdev->vdpa.dev);
>  		return -ENOMEM;


Let's look at this example:

So now you are invoking this under an rw lock:




struct vduse_iova_domain *
vduse_domain_create(unsigned long iova_limit, size_t bounce_size)
{                                
        struct vduse_iova_domain *domain;
        struct file *file;
        struct vduse_bounce_map *map;
        unsigned long pfn, bounce_pfns;
        int ret;
        
        bounce_pfns = PAGE_ALIGN(bounce_size) >> BOUNCE_MAP_SHIFT;
        if (iova_limit <= bounce_size)
                return NULL;
        
        domain = kzalloc(sizeof(*domain), GFP_KERNEL);
        if (!domain)
                return NULL;


...



Which unless I am mistaken will produce a lockdep splat and deadlock.


So it looks like the previous version did not compile
and this one looks DOA.  What's up?

At this stage please include information about configs you
tested, and how.

And any locking changes should also be tested with lockdep enabled
please.


-- 
MST

