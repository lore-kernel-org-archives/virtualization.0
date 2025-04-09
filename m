Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC8525D911
	for <virtualization@lists.linux.dev>; Wed,  9 Apr 2025 10:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744196187; cv=none; b=WCwvpswv9N2QGgtdvlFSZSv7kvcFFDGEKDLuY/3fA542HcycJMniDqMdFVOzOzn4fi/O2+gZjG3vw2GTuKYXWI/bu3jJHaXqWci14ddWi7Y1qjLjgJf7GvyvlAlhNKr/Edy4hDPDC8MeThWMrAC+wlu8Yv+Ss77RuuyBQk4QjJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744196187; c=relaxed/simple;
	bh=LTCwaImwKuvWXY2scLkUXgWwOFI49yWpZ+qPbyisx2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=EzGkM0AL9TcQmGffCRlRUo6NyOtHNRzIOM4rBFPohB2eapcrSdbNnYSayzirTQPUoPNGjbYGIUFE6E2JcHmgl6FsDSTf4OYBosa5Ea3CT1zFcdJsVQd2TVT++bRuO6Zhm9leJlDcEuprgwhWLIUs8uUkilXKwLpDMs7GDGorl3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GZpzofv3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GZpzofv3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744196184;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Giukvq1XMekOaAYyLauP2qjMQgVPWM9Bad3lqnf3cCw=;
	b=GZpzofv3VnlMlF3TsU2dcxEsH6EXSUW7C2SaH7X0djruiyD2/Y3D39WLchoMk/OXpwnETM
	MLiE0oH5eSzrnY5zCpOJIvb3Gu1yiu7eX9UUX4HVrGB0JoqjfMcX5V9IdW4V+Sldo6YNYU
	x3voRVE0/a+19sHqdgTlongZ2FiTShY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-580--D-U5DLoOnGvOctQzp--kg-1; Wed, 09 Apr 2025 06:56:23 -0400
X-MC-Unique: -D-U5DLoOnGvOctQzp--kg-1
X-Mimecast-MFC-AGG-ID: -D-U5DLoOnGvOctQzp--kg_1744196182
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43cf172ff63so38172555e9.3
        for <virtualization@lists.linux.dev>; Wed, 09 Apr 2025 03:56:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744196182; x=1744800982;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Giukvq1XMekOaAYyLauP2qjMQgVPWM9Bad3lqnf3cCw=;
        b=R0RByhsVdDXIepY7QIy62zPNVJ+jW1f9ut7I2+FSxEKR60B7n1YI2blEG/CXLCfpbn
         RhU9UlNEq40w1a7yKzhQ2pleydEUUF3x5U+8C4Bw2Z5eaX5kKEJGgT5O7aH6gB7zlEa+
         mYaeFKSMeIanZppeOV+z3KcGtXWa2Hcx3wDGvuYWELitS+o8z6qkll0IhYGIkYXpXNxy
         ypAYyiGCYl9Pjg9BHnzToGuPa2IEG01LNDTx8is5nflc43MOuRQDETikDEoTgIA/omCr
         1CHrA8+JBhgUGHowF3CDSXbza58mFY+5Se8RdlXRCXZTVF/db1M19B2fvC0e4Q7bGx8d
         3z4A==
X-Forwarded-Encrypted: i=1; AJvYcCVI0D8fZUXx6QdyPh76cRmNkVXYL8/f7EdXzD7h5PtDXpE52ROumYNkpLIqubGAmhxMZcgXkhBJeF0Iibzy9g==@lists.linux.dev
X-Gm-Message-State: AOJu0YyWenoBc9jaRn9g7g7ClWZkgGrItSig5ZuXpbWa2yEuVnajI76h
	NASkMCyUMWmmGtwcMlk1I3YjXsgYYG2sy3388ZoFL/hCKGVdcpTvQNcQyPIeSawMJMrPaC59ec+
	oW/G0qZagHumNhkaOUf+ioPooxfaXogM/5WL/4nH9R9wYYzii6wo7ufzHFMfmBiIU
X-Gm-Gg: ASbGncusBm89QQNcP/gXOxAjS64AW4QVDEDIhLlqSuDNbmnY6IRV61H973E0RrYpEBH
	4DWtYNV3ZdqBZe5S7gzNRJVFosqnvgEoXSwpo2Q45nE4XOyhnUzvFIqhHeCEmDZK4lYHq5bjSG3
	bh5t35N6UYQVx7qbwV7D+O/0p/iXGyJExDFHrtw2reQ9ZUcw2rORJEyKDIRL8LI8wU9gb/U+hWi
	C6aLVfNx07EPXppSrLx7fVXMR38QB5tz6R2XRPo9ScPa9+q3Nu2bmUGrLOtcbgkS4aZep4DChT6
	DbBkuQ==
X-Received: by 2002:a05:600c:3b0d:b0:43b:b756:f0a9 with SMTP id 5b1f17b1804b1-43f1eca7da6mr24601085e9.11.1744196182100;
        Wed, 09 Apr 2025 03:56:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNLH4SJp0xl9ym+oA6t+X06BpgXTrGstDaDUYdeGqpHCubYFfAQEql88GLYD8pGId9XSYpMw==
X-Received: by 2002:a05:600c:3b0d:b0:43b:b756:f0a9 with SMTP id 5b1f17b1804b1-43f1eca7da6mr24600885e9.11.1744196181679;
        Wed, 09 Apr 2025 03:56:21 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f20625eeesm16142845e9.11.2025.04.09.03.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 03:56:20 -0700 (PDT)
Date: Wed, 9 Apr 2025 06:56:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: Daniel Verkamp <dverkamp@chromium.org>,
	Halil Pasic <pasic@linux.ibm.com>, linux-kernel@vger.kernel.org,
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
Message-ID: <20250409065216-mutt-send-email-mst@kernel.org>
References: <20250407044743-mutt-send-email-mst@kernel.org>
 <b331a780-a9db-4d76-af7c-e9e8e7d1cc10@redhat.com>
 <20250407045456-mutt-send-email-mst@kernel.org>
 <a86240bc-8417-48a6-bf13-01dd7ace5ae9@redhat.com>
 <33def1b0-d9d5-46f1-9b61-b0269753ecce@redhat.com>
 <88d8f2d2-7b8a-458f-8fc4-c31964996817@redhat.com>
 <CABVzXAmMEsw70Tftg4ZNi0G4d8j9pGTyrNqOFMjzHwEpy0JqyA@mail.gmail.com>
 <3bbad51d-d7d8-46f7-a28c-11cc3af6ef76@redhat.com>
 <20250407170239-mutt-send-email-mst@kernel.org>
 <440de313-e470-4afa-9f8a-59598fe8dc21@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <440de313-e470-4afa-9f8a-59598fe8dc21@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: uUfn6INOHoQ4hnGFj9aZm9vyIOCgv6aoxwDqWLFPVws_1744196182
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 09, 2025 at 12:46:41PM +0200, David Hildenbrand wrote:
> On 07.04.25 23:20, Michael S. Tsirkin wrote:
> > On Mon, Apr 07, 2025 at 08:47:05PM +0200, David Hildenbrand wrote:
> > > > In my opinion, it makes the most sense to keep the spec as it is and
> > > > change QEMU and the kernel to match, but obviously that's not trivial
> > > > to do in a way that doesn't break existing devices and drivers.
> > > 
> > > If only it would be limited to QEMU and Linux ... :)
> > > 
> > > Out of curiosity, assuming we'd make the spec match the current QEMU/Linux
> > > implementation at least for the 3 involved features only, would there be a
> > > way to adjust crossvm without any disruption?
> > > 
> > > I still have the feeling that it will be rather hard to get that all
> > > implementations match the spec ... For new features+queues it will be easy
> > > to force the usage of fixed virtqueue numbers, but for free-page-hinting and
> > > reporting, it's a mess :(
> > 
> > 
> > Still thinking about a way to fix drivers... We can discuss this
> > theoretically, maybe?
> 
> Yes, absolutely. I took the time to do some more digging; regarding drivers
> only Linux seems to be problematic.
> 
> virtio-win, FreeBSD, NetBSD and OpenBSD and don't seem to support
> problematic features (free page hinting, free page reporting) in their
> virtio-balloon implementations.
> 
> So from the known drivers, only Linux is applicable.
> 
> reporting_vq is either at idx 4/3/2
> free_page_vq is either at idx 3/2
> statsq is at idx2 (only relevant if the feature is offered)
> 
> So if we could test for the existence of a virtqueue at an idx easily, we
> could test from highest-to-smallest idx.
> 
> But I recall that testing for the existance of a virtqueue on s390x resulted
> in the problem/deadlock in the first place ...
> 
> -- 
> Cheers,
> 
> David / dhildenb

So let's talk about a new feature bit?

Since vqs are probed after feature negotiation, it looks like
we could have a feature bit trigger sane behaviour, right?

I kind of dislike it that we have a feature bit for bugs though.
What would be a minimal new feature to add so it does not
feel wrong?

Maybe it's in the field of psychology though ...


-- 
MST

