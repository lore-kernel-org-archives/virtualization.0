Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A3523098D
	for <virtualization@lists.linux.dev>; Mon,  7 Apr 2025 09:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744018681; cv=none; b=TuK965W3Ndu2kKJeLX9tml6+qMmJE61KfNywWBuf4Rdm0hW+lOOsV9qZQuS1vlrCuSdsperuvh2BqHLZH1v8Wnu8f/Nzfbn9wdhSKGfrYF7nQY40hv/9LQ+HXShT2BBWxnsJwB3PZhoic3739FojxFGhZB1Zvlm5kpBRQtP2IWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744018681; c=relaxed/simple;
	bh=UYVpnQToVhKkeD2a7choe2evBwk4oKQuBCk3T1e9dSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=UDmaIerGJfjtWjSyNtld8gY8RtLE/l5dLNkU8935KlQxmL6jZzLMj7SjF7ADqkSzGCQPDbi0N9lJh5kQol8AaT95RuYuazFX1P4Nhmb+0ADGvsCiuAhpxP6nQIUuaR3tuuoBvNPYcm0Jg7vhKqlX1cggTjXPOSlHylNY4eNEYy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i6mKwM6B; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i6mKwM6B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744018678;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dTru+5exuSFoOa7/E+HIvTf2c8suoUygvHtY3wcFXLI=;
	b=i6mKwM6B9xMTtKxQ51wJ6gUzpGWgU81DNIcXWG5gVErbcxeND8RhWF8mQ+Dm2gSXoumL9E
	xagm5HWG0aNMYp8cFIk1XTc0I8PgkMBJfrXO6OZqyhUxX02CLn7J83mLXjGOBa5XU4AfLV
	nbPdYnJqndz1p6Dg4L2z5GDga3M231o=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-131-gE_C1H47OuSxgDz6X1GAuw-1; Mon, 07 Apr 2025 05:37:55 -0400
X-MC-Unique: gE_C1H47OuSxgDz6X1GAuw-1
X-Mimecast-MFC-AGG-ID: gE_C1H47OuSxgDz6X1GAuw_1744018675
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43ceb011ea5so27617285e9.2
        for <virtualization@lists.linux.dev>; Mon, 07 Apr 2025 02:37:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744018674; x=1744623474;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dTru+5exuSFoOa7/E+HIvTf2c8suoUygvHtY3wcFXLI=;
        b=UqZ4hjGOjxBAne5sUH6AVM0A/1UAS5kluh538UAyQwthrtYK+XReD6VAKYqc9fcFbG
         YdpWe75/CwXdyZBomfH0jx/bqccM4o478+Z3dPYkxaoOR48wGXoonvqdrc4pO6u9ugYy
         Qremjw02IubBfQd+qdSrA1sydvqf3sbap7uuoS3AterB6VmdmHFQdYuD0RpWSZiyk5qH
         tWOF9pVmolwmQ6iX4N2KLHDvYafNIbTqQN1AWBCkeiKf+fGlARnfX4+sbI9EO/5imLE8
         tFwpyaHtXRfJKSw+a2dky/LGL6iNygSCRGn8IKnksK/0y7OLEo5z7hMmBwtTJrsW9ryE
         CIhA==
X-Forwarded-Encrypted: i=1; AJvYcCUPNvAlazKe9x17OLLDlkpFonLKe91YUnssadGc5Prpp7UQ01+Ype69E073F+R071rBXmh33y3rcujPpHg37g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz0Yh3pkoJh+fdOPfYNc5ekWL9aH24k1ErtnuQ7ixrpyMkAN947
	9qVlD/Mb4BpPGuy6js2/E68uICenUA6YMw9AIwbgwtkc/dI7n6tTbH125wz+5ohDM5CdljYT4z+
	AaPVZMuojIisOhPsflvsU2Zi6YmT0t1tl+sE09FQTYkfxoQYbfknJHpxTJxo7nJJP
X-Gm-Gg: ASbGncuibU7NNrdIhqQhjmpdVevS9IlyszPTFCCYKPzm/ij3Yq0xYqegvQN6+yeZfB0
	fncOaNLfy8TAu6bZKE2WRrl3cp9MqDWSjA2JqCEnB96Y7TG5Mkmq1h46K0FW2UIMv1PZMsuqI08
	rGQIKG840UbXa9fvrGt4Vvgz76zoLt0UZSUBKWSiMkftaKxWkUjQO++aqjV0N0V5VIWONCV0Oqm
	TewkSynFXbcNgujfZGA4s9oYo+ZQFrg+Xz64H7c0Fl78ESws7HMbJp4DEvJwJWqPf3TKjHk77Jk
	/4rRFd5U3A==
X-Received: by 2002:a05:600c:470d:b0:43d:47e:3205 with SMTP id 5b1f17b1804b1-43ecf85f23bmr79396995e9.11.1744018674553;
        Mon, 07 Apr 2025 02:37:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRDexwe+g43YwqQL8SzrJOq1OlI7SDdhXyepzHhoBm7gIYyJsaf0/QWV3+ztzeILwqBFtKrA==
X-Received: by 2002:a05:600c:470d:b0:43d:47e:3205 with SMTP id 5b1f17b1804b1-43ecf85f23bmr79396625e9.11.1744018674172;
        Mon, 07 Apr 2025 02:37:54 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec17b33c2sm132022505e9.40.2025.04.07.02.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 02:37:53 -0700 (PDT)
Date: Mon, 7 Apr 2025 05:37:50 -0400
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
Message-ID: <20250407053037-mutt-send-email-mst@kernel.org>
References: <6f548b8b-8c6e-4221-a5d5-8e7a9013f9c3@redhat.com>
 <20250404173910.6581706a.pasic@linux.ibm.com>
 <20250407034901-mutt-send-email-mst@kernel.org>
 <2b187710-329d-4d36-b2e7-158709ea60d6@redhat.com>
 <20250407042058-mutt-send-email-mst@kernel.org>
 <0c221abf-de20-4ce3-917d-0375c1ec9140@redhat.com>
 <20250407044743-mutt-send-email-mst@kernel.org>
 <b331a780-a9db-4d76-af7c-e9e8e7d1cc10@redhat.com>
 <20250407045456-mutt-send-email-mst@kernel.org>
 <a86240bc-8417-48a6-bf13-01dd7ace5ae9@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <a86240bc-8417-48a6-bf13-01dd7ace5ae9@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: w3zua5eHl-VPrVd5eny-AIFtDZC6piBQVWiw8pH_0Vw_1744018675
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 07, 2025 at 11:11:34AM +0200, David Hildenbrand wrote:
> On 07.04.25 10:58, Michael S. Tsirkin wrote:
> > On Mon, Apr 07, 2025 at 10:54:00AM +0200, David Hildenbrand wrote:
> > > On 07.04.25 10:49, Michael S. Tsirkin wrote:
> > > > On Mon, Apr 07, 2025 at 10:44:21AM +0200, David Hildenbrand wrote:
> > > > > > 
> > > > > > 
> > > > > > 
> > > > > > > Whoever adds new feat_X *must be aware* about all previous features,
> > > > > > > otherwise we'd be reusing feature bits and everything falls to pieces.
> > > > > > 
> > > > > > 
> > > > > > The knowledge is supposed be limited to which feature bit to use.
> > > > > 
> > > > > I think we also have to know which virtqueue bits can be used, right?
> > > > > 
> > > > 
> > > > what are virtqueue bits? vq number?
> > > 
> > > Yes, sorry.
> > 
> > I got confused myself, it's vq index actually now, we made the spec
> > consistent with that terminology. used to be number/index
> > interchangeably.
> > 
> > > Assume cross-vm as an example. It would make use of virtqueue indexes 5+6
> > > with their VIRTIO_BALLOON_F_WS_REPORTING.
> > 
> > 
> > crossvm guys really should have reserved the feature bit even if they
> > did not bother specifying it. Let's reserve it now at least?
> 
> Along with the virtqueue indices, right?

Well ... as long as the implementation is careful to check that feature
is negotiated, reusing vq index at least causes no trouble for others.


> Note that there was
> 
> https://lists.gnu.org/archive/html/qemu-devel/2023-05/msg02503.html
> 
> and
> 
> https://groups.oasis-open.org/communities/community-home/digestviewer/viewthread?GroupId=3973&MessageKey=afb07613-f56c-4d40-8981-2fad1c723998&CommunityKey=2f26be99-3aa1-48f6-93a5-018dce262226&hlmlt=VT
> 
> But it only was RFC, and as the QEMU implementation didn't materialize,
> nobody seemed to care ...

Thanks! I will try poke the author again.


> > 
> > 
> > > So whatever feature another device implements couldn't use this feature bit
> > > or these virtqueue indexes.
> > > 
> > > (as long the other device never intends to implement
> > > VIRTIO_BALLOON_F_WS_REPORTING, the virtqueue indexes could be reused. But
> > > the spec will also be a mess, because virtqueue indexes could also have
> > > duplicate meanings ... ugh)
> > 
> > what do they do with vq indices btw?
> 
> See above links, they use the two for "s_vq and notification_vq".
> 
> -- 
> Cheers,
> 
> David / dhildenb

