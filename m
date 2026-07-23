Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5AB38AC65
	for <virtualization@lists.linux.dev>; Thu, 23 Jul 2026 16:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784825449; cv=none; b=p9BoxJj6eCuXwd28k5Cr+KIfY+nlkHhyxqOASOJv9Pp4z5hh+X3GHMmnWW++ajCaYSXYi3MZh+vqBrAdIKYGNdq3t1IX/Z0P9318grrdtQfKSOCUPw8AmYAo1bXCLTwCHQAEqTNu+CzD0bubi9lpX8nUF224K1yumkPcBffMMS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784825449; c=relaxed/simple;
	bh=HVzEoDIUOtKuu1wfn87SZ/HEqRdQyUU7D8rY8b4wr/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=W8WHvErq1xk5Qfqc8BlKyf+RbQcFkLuvAVbKWyT0EXmO0J0hN1dFU/ZK/JsHemQxx4rNeDaNZJ2aJPC37borbuGIYlM9lzMFHdQaL30SAiQRYD9B/cQ+7TCLP9OblCYO3eFVxq+7P9FxzWqVaOHFmr08h8Lh3qpRr2EUHIAjnFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TjSfeZ6p; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TjSfeZ6p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784825446;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=skv50H0aRdZe1+yzOYqLWkWcMMVGnxgMC07zr3GCyxM=;
	b=TjSfeZ6pu5R8DPjQuuTY4xDpXprvKssADW8j7hARr9DqlmkCzOHyBZ55ey0Axw2CicRtGP
	XW9+Z8D6ofDT6Wv+2wuUjdHo1gad7BUUtqI85ngb6eGT+nghtrP7JwPjaoLTZ0L4EhFz11
	OPf31VtPVILbv9cAt40a615RnshLfh0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-LavK5xXOMIql2EOlmFAUFQ-1; Thu, 23 Jul 2026 12:50:45 -0400
X-MC-Unique: LavK5xXOMIql2EOlmFAUFQ-1
X-Mimecast-MFC-AGG-ID: LavK5xXOMIql2EOlmFAUFQ_1784825444
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4955b84e25eso6241985e9.1
        for <virtualization@lists.linux.dev>; Thu, 23 Jul 2026 09:50:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784825444; x=1785430244;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=skv50H0aRdZe1+yzOYqLWkWcMMVGnxgMC07zr3GCyxM=;
        b=UwVsuyxTAfF3jcKmvqbaRzhDI/S1u72b2Bp1HGRG2vrq1+j0ZZWqS/CgEPbCtQrmxY
         nlnLlAXQuX8gkl5fgGhJO2TACij3l+raX+nE5RbYIpAj7pEX5RkA7JZaPoxyJgTZjatQ
         4p5L89Gz9qa7rp3/1k83uGRTC2YsZorhmLdfhWIqbmsBrnX0VrobLPbeB/wlfyQR39kN
         C18YZrdYI6naeu9p/XOs/AH1leea/vWgnV5DJ1J0HW5llL7/zbMvZtzuLs4tEl07aZ5z
         iDxPovHTnVv75WtogFr6SQambM+KkGZMTr4rv7ii4fZs5+mm1x30s2RQslARECQBiGNy
         bs9Q==
X-Forwarded-Encrypted: i=1; AHgh+RrxPTneOxjZP+t7xwiiODWUJSpzLh8HyMPjm5AhrtYc6++kGfD5On/0M6hIPHH94PpzS+ph5JpC9dhI9JNyTg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxXSU4ienR+mNyDhwQGJGZHbaKtVlOOyix0W6AEVFKdUB3UsaP+
	43v9vh9pqSwV2yCAfWv3Fh0EWMduGFdLBTwH6/LgQXPl20jQHFGx/+wPuFeabdswyany7XePukK
	UxcFeTcip0ScTbmnicK1pPVBKeugB2PAbkc/4WNPxVV0bgmjQ3ltDb8n+DKUTV1PSqnBY
X-Gm-Gg: AR+sD11wXhbGM1jfh7t3BvznVpsGtIdxn4ypqVug6UCkD036bEKc7YGLw7SsIVdyZai
	0LJHtyuZfOA0tEGTJhUvf4GdIImzPQstyh57oWm5EdM89Sj4zpqOhuPqB/YJilJWt+WwjOAAD73
	C244OUyvjcvUNxmIzibqMaZGYyTLRQa1QT5OhR5fLMgfGBx/RUhQ/XGPFqKM/bGSg/iaKfUDsff
	qS1A4GZHj7B3Vr2TJacu0EtLRCy7pT19vo/MAvgGIuCAcd57NR1Niyvvmw1NgTZzWKO/2Ni8xwM
	uLa4ot2Ivpy26SihzPt1tA2VgB8DwsQONlSWK2vY26bzfOAT0hA9Y6joXCGcksHK//hw2TFJl8r
	u3aBQg3UKNT9Y0mzXVvRihQ==
X-Received: by 2002:a05:600c:350a:b0:495:441a:39d2 with SMTP id 5b1f17b1804b1-49573cd8932mr43271935e9.21.1784825443873;
        Thu, 23 Jul 2026 09:50:43 -0700 (PDT)
X-Received: by 2002:a05:600c:350a:b0:495:441a:39d2 with SMTP id 5b1f17b1804b1-49573cd8932mr43270805e9.21.1784825442214;
        Thu, 23 Jul 2026 09:50:42 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-37-66.inter.net.il. [80.230.37.66])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4957af5d910sm6009915e9.3.2026.07.23.09.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 09:50:41 -0700 (PDT)
Date: Thu, 23 Jul 2026 12:50:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	sgarzare@redhat.com, stefanha@redhat.com, dongli.zhang@oracle.com,
	maciej.szmigiero@oracle.com, bchaney@akamai.com,
	mark.kanda@oracle.com, ptikhomirov@virtuozzo.com, den@openvz.org
Subject: Re: [PATCH v5 4/5] vhost: synchronize with RCU readers when freeing
 workers
Message-ID: <20260723124908-mutt-send-email-mst@kernel.org>
References: <20260720102241.371610-1-andrey.drobyshev@virtuozzo.com>
 <20260720102241.371610-5-andrey.drobyshev@virtuozzo.com>
 <20260723111557-mutt-send-email-mst@kernel.org>
 <0c7172c4-0dc4-4d7e-9310-4f045e27efb9@virtuozzo.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <0c7172c4-0dc4-4d7e-9310-4f045e27efb9@virtuozzo.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: K4D-QX_mCBryjDRTWVwoIUlxss5a9qo-tavhD9m-scc_1784825444
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 23, 2026 at 07:46:58PM +0300, Andrey Drobyshev wrote:
> On 7/23/26 6:18 PM, Michael S. Tsirkin wrote:
> > On Mon, Jul 20, 2026 at 01:22:40PM +0300, Andrey Drobyshev wrote:
> >> vhost_vq_work_queue() only holds the RCU read lock while it dereferences
> >> vq->worker and queues work on it.  vhost_workers_free() however clears
> >> the vq->worker pointers and immediately frees the workers, without
> >> waiting for a grace period.  A caller that fetched the worker right
> >> before the pointer was cleared can therefore still be queueing work on
> >> it while it is freed.  And even when the queueing itself wins the race,
> >> the work is never run, so its VHOST_WORK_QUEUED bit stays set and all
> >> future attempts to queue it are silently skipped.
> >>
> >> None of the current callers can actually hit this: net and scsi stop
> >> their virtqueues before the workers are freed, and vsock unhashes the
> >> device and does synchronize_rcu() of its own in vhost_vsock_dev_release()
> >> before the workers go away.  But the upcoming VHOST_RESET_OWNER support
> >> in vhost-vsock keeps the device hashed while its workers are freed, so
> >> the lockless send/cancel paths become able to race with the teardown.
> >>
> >> Fix this by clearing the vq->worker pointers, waiting for a grace
> >> period, and then flushing the workers so any work the last readers
> >> queued runs before the workers are freed.
> > 
> > 
> > 
> > 
> >> Fixes: 228a27cf78af ("vhost: Allow worker switching while work is queueing")
> >> Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
> >> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> >> ---
> >>  drivers/vhost/vhost.c | 11 +++++++++++
> >>  1 file changed, 11 insertions(+)
> >>
> >> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> >> index 4c525b3e16ea..d6e235c25254 100644
> >> --- a/drivers/vhost/vhost.c
> >> +++ b/drivers/vhost/vhost.c
> >> @@ -729,6 +729,17 @@ static void vhost_workers_free(struct vhost_dev *dev)
> >>  
> >>  	for (i = 0; i < dev->nvqs; i++)
> >>  		rcu_assign_pointer(dev->vqs[i]->worker, NULL);
> >> +
> >> +	/*
> >> +	 * vhost_vq_work_queue() reads vq->worker under rcu_read_lock(), so a
> >> +	 * reader that fetched a worker before we cleared the pointers above
> >> +	 * may still be queueing work on it.  Wait for those readers to
> >> +	 * finish, then flush so any work they queued runs (clearing
> >> +	 * VHOST_WORK_QUEUED) before the workers are freed.
> >> +	 */
> >> +	synchronize_rcu();
> > 
> > 
> > 
> > Any way not to add this for all devices that don't need it?
> > Or preferably, even for vsock in absense of the new ioctl?
> >
> 
> This code was initially local to vsock, and was moved here in v3->v4
> after we discussed with Stefano that the issue looks more generic and
> should probably be fixed in vhost.c (see
> https://lore.kernel.org/virtualization/akO6tps94iFxCAWv@sgarzare-redhat).
> 
> As a compromise, we can keep this code here, but only call it
> conditionally.  Namely, create a bool flag on 'struct vhost_dev' which
> is always false, only set it to true on RESET_OWNER, and only call this
> code once it's set.  Clumsy, but this way no other code path would have
> to wait the full grace period.
> 
> What are your thoughts on that?
> 
> Thanks,
> Andrey

Or just thread a bool parameter to it?

> > 
> >> +	vhost_dev_flush(dev);
> >> +
> >>  	/*
> >>  	 * Free the default worker we created and cleanup workers userspace
> >>  	 * created but couldn't clean up (it forgot or crashed).
> >> -- 
> >> 2.47.1
> > 

