Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD526328B7F
	for <virtualization@lists.linux.dev>; Tue, 14 Jul 2026 18:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784053297; cv=none; b=Hl87tNwuh4M/ppq7ZwJhGHp2XeNaxylzyhtocaiNF4XTLCik9CdzcsNcV6b5GflbX8ubp5laoO8pX0KSap4EQSbJQGeId/+CTmzE9Ml4hNCfOVvhlrpMkUwSPZv/Cc34qnM8ASVKWprLhki352vTRbaRF0oH8R5h881QXL2hZLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784053297; c=relaxed/simple;
	bh=A38XAf/qyrY/pxvb8R0wLZ2ECalCATFuHuqBr7PPTyE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=mKZlqsz2ou6ACddoEPoTmmyVSIL6VKxAnGoWFD5iWvJzc/BsTp76mYUo45Uynx1KMLXFCYYKEYTm38u1rdnZeC50ajd4fpPG3Z+7Iv07Zih+iXHbSUZ/4HReVdUj1ZTGIfkDlK2DswHmoO56gIKRoA9mTQi/MbrZ/PFmJno2O5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c8E5V17b; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c8E5V17b"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2cede6375caso171145ad.0
        for <virtualization@lists.linux.dev>; Tue, 14 Jul 2026 11:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784053295; x=1784658095; darn=lists.linux.dev;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8gQRzGlj1G5cVe9CASOoXX9GLstMyJGv9XUVp1m4BJc=;
        b=c8E5V17bJcYiUNolQ3GXKo9TtWo1dfa/+4msTE+6vw4fW+9ohku0txhPgEhn7cR+dn
         yQKd7fb8xVfxUNJ8eGrT5D8S3bGGrd8qzS/eTC4zo2aZWloeAvIvHXnaovjaUHPs1k7X
         G6a1WcXupkQ4wTiSYAW9K3SZ7BPASMCzEzB3cFQIQbJAM/vjJpdLPjlqNzNXkwKczfey
         yWzmA55nPxU92lxJcKeToO+zqU7FMtwhyB6OnLpIGfeeRzQmnuQTtNOw/6PqhLKrWFS+
         ASOIcjvL6bgLS4Rh/Et2dV0lTBQUIK5HANDcgPhgzxoLEKxu0WL5M4Bt6S7zsKGVaoBv
         ovyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784053295; x=1784658095;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8gQRzGlj1G5cVe9CASOoXX9GLstMyJGv9XUVp1m4BJc=;
        b=HUXKCqbi+gEJWNF0pUtE9wiAvmtRE1ocrcl1JPzgkmnpmqlBdfcLibG6x9dL6ARYAd
         MwBLjyUVzKScoRCSgdbOOLI943LKNDY60R2LT81Sy3S3c2zmmLn6GyMFVMIlt0ADfFhv
         JK1H8ar8xp3NxcKJzCqBjCs7xd0UhcGIdpxeF7/B2orKoyT313BxhSZAzMdjlJdTkvly
         9ZcBcW9vQgNa4OVYXgeHEtMf1ta/lHD70SNLEXJQGBLpxakO99eViIG8HHhBN3nSxOt0
         5cKnRZnBjuk7kC+HI8TFJEwc3K+fm5Kp6jfEhbWX+kakB0k1xUnHD5fn4rSUmT1OkB9e
         5ZXQ==
X-Forwarded-Encrypted: i=1; AHgh+Rrx6iMNIIAPXW/mki+e+vfNBgRvY5CvgdksIC2VavYQGEoQeDtaRcW8wsVhuk556YCkb6ZLmi6lLs9ruOw2nA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzlV7XCN5MnP/+/Xn6p14DVoLf/HZo8hLnwzOrpouMWzN1HRGnc
	LwCAv6R9Y6TfGCN29kP6uik2qaps8milLfNvkTum5jPAqIbVLzxyUKjSaJGr9qlfnXBGyU+kXd7
	6iESEChnT
X-Gm-Gg: AfdE7cmUHRJm+YDC7Y5XvVlFQGEH3VehbxfCG/Eyh1YINC1ZT8EUDkLzDxwU1g0CvNe
	60+d/43s55f/6QHqt4u/3t57ySu1mnQXyCht86YVW0/D3qMcXMhyh3bmTw3ccWTbKwfPM3dVBvG
	vzisIVbTz6q0A5A4Mevj3VNG2vVfO9rTBTXSxu0tCtiGTDgIbcriyhSR1+Nu3dhRnr6716cwnnk
	Sq1tj1riqP6sDfLvrYFEj/+cUr3/QKr4YfSrv38bd3T/eGRKBHFwF/BsIKBklWbTDcegYUeEYsK
	cZzwZHxNt1pKBzXTwEEJmA3NZClhv+hrj2Kq/I0iAK1K72zsuVqWxH/0y91HvUPwWZbwocR6Uku
	Btv0hdWJbIl8dqpR3AD12uPbgjgMOz2dW50rXyFznK7ETDLgQCRNUcMUk5EPjaz72HYwSL7IL0Z
	vN+ga3cYnsMxld+ukZEuEWFmZg+hN4o5rI6W2qB4KG4Uh5aHd4vxJeFZR8xq+FLQT5wrEMpfXOx
	rQ0blMpOeuWExKvkcYNUrZTrevOGDqevhELPQ7le2Q=
X-Received: by 2002:a17:902:f70b:b0:2cc:6df5:62a1 with SMTP id d9443c01a7336-2cee1ca3115mr7223455ad.20.1784053294748;
        Tue, 14 Jul 2026 11:21:34 -0700 (PDT)
Received: from [2a00:79e0:2eb4:9:c2bd:d216:2ddc:2568] ([2a00:79e0:2eb4:9:c2bd:d216:2ddc:2568])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e172cc7f1sm1933730a91.5.2026.07.14.11.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 11:21:33 -0700 (PDT)
Date: Tue, 14 Jul 2026 11:21:33 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
cc: "David Hildenbrand (Arm)" <david@kernel.org>, Link Lin <linkl@google.com>, 
    Andrew Morton <akpm@linux-foundation.org>, 
    Vlastimil Babka <vbabka@kernel.org>, virtualization@lists.linux.dev, 
    linux-mm@kvack.org, linux-kernel@vger.kernel.org, prasin@google.com, 
    duenwen@google.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com, 
    Ammar Faizi <ammarfaizi2@openresty.com>, jiaqiyan@google.com, 
    ahwilkins@google.com, Greg Thelen <gthelen@google.com>, 
    Alexander Duyck <alexander.duyck@gmail.com>, stable@vger.kernel.org
Subject: Re: [RFC] virtio_balloon: fix Use-After-Free in page reporting during
 PM freeze
In-Reply-To: <20260714092146-mutt-send-email-mst@kernel.org>
Message-ID: <5e18d7ec-a9d7-2cc3-7741-695ec3580ffa@google.com>
References: <20260709224330.946683-1-linkl@google.com> <8d316b6c-41fb-4ae3-8923-3b649b92b33d@kernel.org> <20260714092146-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 14 Jul 2026, Michael S. Tsirkin wrote:

> > > diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> > > index a1b2c3d4e5f6..45a90fb3abf8 100640
> > > --- a/drivers/virtio/virtio_balloon.c
> > > +++ b/drivers/virtio/virtio_balloon.c
> > > @@ -1055,6 +1055,9 @@ static int virtballoon_freeze(struct virtio_device *vdev)
> > >  	 * The workqueue is already frozen by the PM core before this
> > >  	 * function is called.
> > >  	 */
> > > +	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_REPORTING))
> > > +		page_reporting_unregister(&vb->pr_dev_info);
> > > +
> > >  	remove_common(vb);
> > >  	return 0;
> > >  }
> > >  
> > >  static int virtballoon_restore(struct virtio_device *vdev)
> > >  {
> > >  	struct virtio_balloon *vb = vdev->priv;
> > >  	int ret;
> > >  
> > >  	ret = init_vqs(vdev->priv);
> > >  	if (ret)
> > >  		return ret;
> > >  
> > >  	virtio_device_ready(vdev);
> > >  
> > > +	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_REPORTING)) {
> > > +		ret = page_reporting_register(&vb->pr_dev_info);
> > > +		if (ret)
> > > +			goto out_remove_vqs;
> > > +	}
> > 
> > Hm, that failure handling is rather nasty.
> > 
> > 
> > In virtballoon_freeze() we document:
> > 
> > "The workqueue is already frozen by the PM core before this function is called"
> > 
> > Your report states:
> > 
> > "Workqueue: events page_reporting_process"
> > 
> > 
> > I assume that workqueue is not frozen yet because ... it's not freezable :)
> > 
> > So could we queue to system_freezable_wq instead, or define our own freezable
> > workqueue there? Then a driver doesn't have to worry about that.
> > 
> > -- 
> > Cheers,
> > 
> > David
> 
> +1.  Just system_freezable_wq will do the trick.
> 

This makes sense.

I'm curious why this bug hasn't popped up earlier, presumably any VM that 
has gone through suspend while reporting free pages through FPR is 
vulnerable to it and could have panicked as a result.  Which would suggest 
maybe >99% of FPR is done by guests that never suspend?  While under 
pressure this issue seems reproducible.
