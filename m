Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813D1227599
	for <virtualization@lists.linux.dev>; Mon,  7 Apr 2025 08:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744014880; cv=none; b=XSvLQjSXCzDvnMkIp0qNDZ/LIC2n1WVUao6Fu+qITIg1nex7FTiQn9A+2Zm5kq50QNukv9SSxkXVD10UncVn7KlZBduVcALV2ZX+rGcJdUMU8UVWLKIdy2kIm9YNhry9lkz3TLIoOYAixdQzSaJfWv+WwaoDfmoo0et6+W/PFSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744014880; c=relaxed/simple;
	bh=sLck2J+6PcjmSINGrDUpZvijf9T2VzrBWCePSK/Qvj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=L7gJ+d4UXMe65usFpCcLF9FUlPRUAGIw9iMQvtNXact+l+lbLVeLXrnAjuS3k3vSavoxmko5bJ7qyS+UR8uivBZu4w94nttg26uYIvX+A/UGRW0P0ieLd6eGSc8bB5pJm9cydlJDUVarlObo5sMPhqVXUCzf2F2Hldk3XLxrAyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iOqp/5Dq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iOqp/5Dq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744014877;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RyTmsi9BhA0X2tfDIhwHRBuV/xgf5KDyDiyovwov3BE=;
	b=iOqp/5DqQ81Z9G+t16UlUS1eEZGOeK/2UWg4vAyjXNQncfsSXtZM/DEnOgWUuBTk90MIGI
	oNwSfslntM40dldKJytqVCrZywGVtnZgtYKQNmjR1qVlBTfusFOw6TU/ExIRaVrdFzAh4c
	yODhXl8DpJm1lzSLW0/YA4fW152uB9M=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-277-vn6PCSE1PP2a88wogfX00g-1; Mon, 07 Apr 2025 04:34:35 -0400
X-MC-Unique: vn6PCSE1PP2a88wogfX00g-1
X-Mimecast-MFC-AGG-ID: vn6PCSE1PP2a88wogfX00g_1744014874
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43d0a037f97so23878275e9.2
        for <virtualization@lists.linux.dev>; Mon, 07 Apr 2025 01:34:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744014874; x=1744619674;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RyTmsi9BhA0X2tfDIhwHRBuV/xgf5KDyDiyovwov3BE=;
        b=HO7eDZm8j6Oin4ZFuD+cv5Mzkuhl/lqUUyAZWEdAeo+c6/L3RbH+9sFo8F0GEowyTu
         Ru48U1J+YmomNcA6KLlIIvsIMU1sHIJwtQwR+XQ1TeGxF7tYGPyYf7dPQjPQzl4SC/TG
         DdI0ON/jmZS/dwjT+b4ix9UZ0fxHET2k/1wTZmFH/OGAcCXQdIjQrtkN1Sf+Yn1dprSU
         hS3/xZeAa2aLg9mQsYPNQxX/CzVnYLpCvi8FJj2xKR6sWpCG4RzKsyC/ZU7JtDET42zY
         mCMIt8MYy3KNChjAONoNYBDAF7S6x5h28vcr9SMYHI6A59IZwxtZCY91xRzvpaCE5EwN
         KxIw==
X-Forwarded-Encrypted: i=1; AJvYcCVo6JAWN82tosmbvgCMLA3DVbWgXXO404odtp4DgJoa+mbJz2IvIC+Wm5ypA+OQOqayvvQexLsHMCEa99oNmg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxd9ExE2leOZfFWoVrHe/eJ7KXZ0BvvCMCIAnZ0zvhh0bQ5fxvW
	SdQKiorOpKdH1uAuscQWK7KD2xtaxp8UeZMqK4LDOybI/9c1JjviBhaS2BVhCoonhB9wQeJuIvc
	zavYyqr9TlIFo3cC7b8fsl+QdiwoCHKtwisTLSYBWgf5FNG7YTDNCvHpAUMP6AlVa
X-Gm-Gg: ASbGncu4LmaUDP7NrF8l6dR7npSzB8yN7ghPOA4c6ObzwN0I7xVYe7zvtEKw+2Pguuk
	93jzynJTZInCjnktNmdsj0rzXF96SdvkUFAsWf3o6etbfTLVIG9UvRLZUZgA6ARW0tKxj8AzOjH
	j/DAzgsozfAxj5XdiEK9Rk03vN11FkY0c8O9Lx9iCpEA1xrG/wxA2d95yaWcYnqPanQHvrKKrBo
	G11bDwN18LNYZ4qjMjiF7ZlQMAt50/Ywlv5vDByAOb5GoJ9h9pVT18h1W0A16wKX3WEMAcSLjs0
	IMtGXtFBNQ==
X-Received: by 2002:a05:600c:1e13:b0:43d:abd:ad0e with SMTP id 5b1f17b1804b1-43ecf8e72d6mr114694665e9.18.1744014874156;
        Mon, 07 Apr 2025 01:34:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+83STYsHXI3xn6x5xnem+/h77ehJWni3dU6P1EgXI8aWI6y/h2doOJ2sCUgok7+DS4MLeKg==
X-Received: by 2002:a05:600c:1e13:b0:43d:abd:ad0e with SMTP id 5b1f17b1804b1-43ecf8e72d6mr114694305e9.18.1744014873776;
        Mon, 07 Apr 2025 01:34:33 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec1630f21sm126976935e9.8.2025.04.07.01.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 01:34:33 -0700 (PDT)
Date: Mon, 7 Apr 2025 04:34:29 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org, virtualization@lists.linux.dev,
	kvm@vger.kernel.org, Chandra Merla <cmerla@redhat.com>,
	Stable@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>,
	Thomas Huth <thuth@redhat.com>, Eric Farman <farman@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Wei Wang <wei.w.wang@intel.com>
Subject: Re: [PATCH v1] s390/virtio_ccw: don't allocate/assign airqs for
 non-existing queues
Message-ID: <20250407042058-mutt-send-email-mst@kernel.org>
References: <20250404063619.0fa60a41.pasic@linux.ibm.com>
 <4a33daa3-7415-411e-a491-07635e3cfdc4@redhat.com>
 <d54fbf56-b462-4eea-a86e-3a0defb6298b@redhat.com>
 <20250404153620.04d2df05.pasic@linux.ibm.com>
 <d6f5f854-1294-4afa-b02a-657713435435@redhat.com>
 <20250404160025.3ab56f60.pasic@linux.ibm.com>
 <6f548b8b-8c6e-4221-a5d5-8e7a9013f9c3@redhat.com>
 <20250404173910.6581706a.pasic@linux.ibm.com>
 <20250407034901-mutt-send-email-mst@kernel.org>
 <2b187710-329d-4d36-b2e7-158709ea60d6@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <2b187710-329d-4d36-b2e7-158709ea60d6@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: vftcREk_zg4Y9n5p5FtvtP2lgLalZcfQPR2V2mfae-k_1744014874
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 07, 2025 at 10:17:10AM +0200, David Hildenbrand wrote:
> On 07.04.25 09:52, Michael S. Tsirkin wrote:
> > On Fri, Apr 04, 2025 at 05:39:10PM +0200, Halil Pasic wrote:
> > > > 
> > > > Not perfect, but AFAIKS, not horrible.
> > > 
> > > It is like it is. QEMU does queue exist if the corresponding feature
> > > is offered by the device, and that is what we have to live with.
> > 
> > I don't think we can live with this properly though.
> > It means a guest that does not know about some features
> > does not know where to find things.
> 
> Please describe a real scenario, I'm missing the point.


OK so.

Device has VIRTIO_BALLOON_F_FREE_PAGE_HINT and VIRTIO_BALLOON_F_REPORTING
Driver only knows about VIRTIO_BALLOON_F_REPORTING so
it does not know what does VIRTIO_BALLOON_F_FREE_PAGE_HINT do.
How does it know which vq to use for reporting?
It will try to use the free page hint one.



> Whoever adds new feat_X *must be aware* about all previous features,
> otherwise we'd be reusing feature bits and everything falls to pieces.


The knowledge is supposed be limited to which feature bit to use.



> > 
> > So now, I am inclined to add linux code to work with current qemu and
> > with spec compliant one, and add qemu code to work with current linux
> > and spec compliant one.
> > 
> > Document the bug in the spec, maybe, in a non conformance section.
> 
> I'm afraid this results in a lot of churn without really making things
> better.

> IMHO, documenting things how they actually behave, and maybe moving towards
> fixed queue indexes for new features is the low hanging fruit.

I worry about how to we ensure that?
If old code is messed up people will just keep propagating that.
I would like to fix old code so that new code is correct.

> 
> As raised, it's not just qemu+linux, it's *at least* also cloud-hypervisor.
> 
> -- 
> Cheers,
> 
> David / dhildenb

There's a slippery slope here in that people will come to us
with buggy devices and ask to change the spec.




-- 
MST

