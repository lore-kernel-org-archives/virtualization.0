Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39C88C1F
	for <virtualization@lists.linux.dev>; Fri, 31 Jul 2026 09:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785490694; cv=none; b=Ontl+MiGVTYDipe6p/O77+rYWtWVsC/jAhhbPsEh6rbuhMunOjzEr9hjDaLZQWzBP/uyTKXv5flvD3YReieYkHD+Dk14L7U7n1+u/BGFDkyvp2mTu6gsgyJmv5AO+bqDrMSOH6RSU6+xFerLCxvhAM66d0n8eZe0W3Wje+pH8tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785490694; c=relaxed/simple;
	bh=2JVB5NHlGcJkRbxyYTYM1W0SpjpRQTNPaqgefsqMK44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=NPQvEJVawEpA9Aizq0+IUR0y3qKqpk92DXIQQ895gSMQjOngNz3Fe/b1pNz8yOjyDpEJoILzAHP0biDlotF2aInnApoURTP+TNDK6NvDFYlFMZbvdxMwF51D1FiPkRjUTTacv+kFxF7659nzVNc16skSdDuoJ2cqeakKdSjUq9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LoOKlSMf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LoOKlSMf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785490691;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XynOkVOU0Sg6QSEg62BZ8juSeRUPNKjmdjv0kL5gaaM=;
	b=LoOKlSMfxhVPbdfhN0l2DOnpFF7eolzpR1/XfJmqOrcmmPpaZIUTRTUKj2Ck4RS9q2+xLs
	c0PClRvMujK0Wp2s7OLNRm74ak/LomLtWLrMmOEG0i7lQx4tL66EPsGnruKJYnI8F6P44T
	D27lwPmRjJny8fEFaxxD95KHcvEg4sQ=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-210-YnQ4U-cyPA-yvqLPe1KGjw-1; Fri, 31 Jul 2026 05:38:10 -0400
X-MC-Unique: YnQ4U-cyPA-yvqLPe1KGjw-1
X-Mimecast-MFC-AGG-ID: YnQ4U-cyPA-yvqLPe1KGjw_1785490689
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c1630a90890so52290266b.1
        for <virtualization@lists.linux.dev>; Fri, 31 Jul 2026 02:38:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785490689; x=1786095489;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XynOkVOU0Sg6QSEg62BZ8juSeRUPNKjmdjv0kL5gaaM=;
        b=bjcV3+9em31+wagf7CEkyrm7oDeWc8pBFkFbqvTD+CxanwIvj+yggT/2VuZSKI1qxp
         jsJ5jXcYjnwsqtprFCs0CrlVKQNIWzxvalKpFgaC+Oxtn4YV9/BbtlBCXHbObxL580CZ
         l7NsAxB7fT/0u/y8LQsIPuIMGOPOWaa5bkGBf/4WwY3A7Qe7hysoqjUmpKtEscSPWpSx
         7B6i0tFaQ78QIY8QFMAd+yGQmFhE4xBa0oL93MT8nHw3xSj61Lh4sb28EK4UgJhjny++
         CziaQ3Sqx8tMJHhSxw06Kmmb3IbaLhB8WeMIS0LCE1VSt1NFeJDE9mzdMtN7rFdaIs1N
         lUKQ==
X-Forwarded-Encrypted: i=1; AHgh+RrcttjUXnEvZ3rilHUzcxDhWFpzzNThCbHwrTXbWEcdUUKyOmmSkpUFzUEtIY83Xj9Xq6pt1KTVfHiNn37CQw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzsbitscNVKwRxZS/TdGegRRJCZNhCSCwuqbeZd1ks5ieHKqIHi
	0HCHgm3bZ8RycP4rf0QQ05sFFLhJttq6K7H1sXV7rUR+al3/Z/ZrtHJzVcbAMTj1xrXGx8GSgfM
	nrYr2xteT9jecfxbISRxtrQFALtXcJA1RWA0uyjyV7Kllw+IZoXiCKNZQunyBsP9/3CfR
X-Gm-Gg: AR+sD1180WO3I0H8Vre40xzVFTlHB5JCpcsqHDuLu/Ww/3/0rYluJkE/wHomXVlGzwj
	5kdmthNedHGZvP70iDl/V14km3GfkhkG6R0DoXWAIGvmjOhA9RKEDBHwH/uv9r4GKJAsTvPbmo4
	Gpl3e994dcPVc6McgsEuLBZVY7OPMEOz/COenYNew8C6HSGxMQ2DdtOecnKTIBkVrAb9HmpZuQA
	JFyP9+hVuxAUO2yEiI6HPO1KNoC/tKd2HRe/aDzHrt78hX9EqDk4pzuNuWdCyMLe+a/QAIfKYm4
	LJOiKFgJETK9Ozd6y0lFikWoNWpAihWgo3rvARzqa6mlit0i/DzzBkBS4YPGgfuXcPa5as50t1z
	F6xtbD3rjkoeUppxraKyAZoo=
X-Received: by 2002:a17:907:b046:20b0:c16:16b9:9907 with SMTP id a640c23a62f3a-c1fd1e9acdfmr50313166b.15.1785490688970;
        Fri, 31 Jul 2026 02:38:08 -0700 (PDT)
X-Received: by 2002:a17:907:b046:20b0:c16:16b9:9907 with SMTP id a640c23a62f3a-c1fd1e9acdfmr50311166b.15.1785490688444;
        Fri, 31 Jul 2026 02:38:08 -0700 (PDT)
Received: from redhat.com (ppp-94-66-118-61.home.otenet.gr. [94.66.118.61])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1fd3c5b8c7sm92699366b.9.2026.07.31.02.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 02:38:07 -0700 (PDT)
Date: Fri, 31 Jul 2026 05:38:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jia Jia <physicalmtea@gmail.com>
Cc: stefanha@redhat.com, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vhost/vsock: prevent stale IOTLB after ACCESS_PLATFORM
 changes
Message-ID: <20260731053736-mutt-send-email-mst@kernel.org>
References: <20260730104857-mutt-send-email-mst@kernel.org>
 <20260731044145.1734317-1-physicalmtea@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260731044145.1734317-1-physicalmtea@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: hEDQiT4y5fGi95dCs5q9I_MNNfCRlBkpNwGhJdpKC0E_1785490689
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 31, 2026 at 12:41:45PM +0800, Jia Jia wrote:
> On Thu, Jul 30, 2026 at 10:51:15AM -0400, Michael S. Tsirkin wrote:
> > I don't know if this will break anything. Why not just blow
> > out the iotlb? kernel will rebuild it if it needs it afterwards
> > for some reason.
> >
> > This part you are fixing is harmless. Let's make it a separate patch
> > and document the motivation.
> 
> Thanks.
> 
> Yes, I considered discarding the IOTLB before choosing -EBUSY. My
> hesitation was not about whether it could eventually be rebuilt, but
> that doing so would no longer be only a control-plane validation
> change. It would modify translation state directly used by running
> virtqueues.
> 
> The minimum synchronization I had in mind was roughly:
> 
>   vhost_vsock_set_features(features):
>       mutex_lock(dev.mutex)
> 
>       if (!(features & ACCESS_PLATFORM) && dev.iotlb):
>           lock all vq.mutex in index order
> 
>           old = dev.iotlb
>           dev.iotlb = NULL
> 
>           for each vq:
>               vq.iotlb = NULL
>               reset vq.meta_iotlb
>               vq.acked_features = features
> 
>           unlock all vq.mutex
>           vhost_iotlb_free(old)
> 
>       ...
> 
>       mutex_unlock(dev.mutex)
> 
> The switch has to be serialized against all active VQs. My hesitation
> was that this turns VHOST_SET_FEATURES into a datapath synchronization
> point: the ioctl may wait for in-flight kick handlers, and rebuilding
> an empty IOTLB may stall queues on misses until the translations are
> restored. If stopping or flushing the device is also required, the
> disruption is larger than a normal feature update.
> 
> I was not sure whether VHOST_SET_FEATURES is expected to impose that
> cost on a running device, or whether userspace should quiesce it first.
> That is why I chose -EBUSY for v1. If synchronization with active VQs is
> the intended behavior here, I can rework the patch accordingly.
> 
> I will also split the existing-IOTLB preservation change into a
> separate patch and document its motivation.

thanks

