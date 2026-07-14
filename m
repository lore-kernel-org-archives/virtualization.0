Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A40633345A
	for <virtualization@lists.linux.dev>; Tue, 14 Jul 2026 18:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784055184; cv=none; b=Z8ar1GruEcuIXrnMqzQtw/dePDtsyX6vGudhqlmG0NQ6qKqbq34pzxEUfVKNyjpgTJc/zMyPSgf6d1sfxMTwLJNToTHEX8fg5usZETRCWJBE28Cz6sAgE1bx0z7ze8M4ESvnYdXn4pio3f+99tvhWoV8d9E6bcD4r5O3srVyp1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784055184; c=relaxed/simple;
	bh=1xwTUh0XQqqeQexWpf4nYNoBpFIntTgU7ikkAM9WIvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=L8UGTlzNyy0TWfC/9SCoySUy2QARuxvwBf7pptV3aXWmmWffWumXMiVt5KvG+sBcDc9CHwKKtL/SfFibzrI3oaTbk966QKlOldb/4oF3oaCAjbMPRTR53nAgUmV44wWipJGrE0ukZXGmH4zL5Vwhz9Mye8yXDDf5rxVfGam3Q3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jr8vmDj+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jr8vmDj+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784055164;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nIfwW/o8U7z/0oL+ZaQUBUaHVA8qfCLS7p9kgkBe1fQ=;
	b=Jr8vmDj+shCe3i11Pbg0V9yvgDERCYb2gOmKHz0hHFjix4LG2SvbkuZr6QBjvVbU6mkCS4
	EaZsG+AEmWsQAQjjAlUZx9radzDuDwfx0trPKpK3h9puycUiOoP9dEt8bNMXWPcyQLYTpo
	kw/KsYuP6KLjF5BVf2foCuzGF7sc/Ks=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-83-chZsQHwAMcqiG5MY2UvJPw-1; Tue, 14 Jul 2026 14:52:43 -0400
X-MC-Unique: chZsQHwAMcqiG5MY2UvJPw-1
X-Mimecast-MFC-AGG-ID: chZsQHwAMcqiG5MY2UvJPw_1784055162
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-4744b72f90bso2445061f8f.0
        for <virtualization@lists.linux.dev>; Tue, 14 Jul 2026 11:52:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784055162; x=1784659962;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nIfwW/o8U7z/0oL+ZaQUBUaHVA8qfCLS7p9kgkBe1fQ=;
        b=XSp/4YjaQuDDN9nDlwkh0ZLxUrznpOP2Xg8wDk27ndAJiLQoJIe7G8qqyor4oYlzmd
         d/6ZrfpPbqvXOqAhZim3CzU+Y9kC8KPX8UV/dCZV2y9KjiCjCzWuh25cxjQtgLAD1Bef
         LvICafMEpPV3+OKHLJvtGg8vUWA37VJNSigVUPSZeQb7HCQOnRUZM3sF11yVIIqidu9Q
         rKlCltaj8N5DyfC45z4fz7DcYZGEPqIa8NUjUsUMr5UoNjEOMtcbV+wTRmMHKTrpHFXO
         6P9681kBvMr+J7Xb3R5zlO/uILcfrJ6gGC9YrVWLtc/MG2rnn3OHX2+dKCiEM7t/fvwo
         rlJw==
X-Forwarded-Encrypted: i=1; AHgh+RpGK/Enzax7yPWcjArofPqgI/F1GLVkkLZ+rwl8TMlT/rxIFtl1sE84QaxJqWVZxhL/tEoydEZRpiRz/Kr2Gg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw0TJnpFcmz2b1d4czcmP4Dw5SnbPW3zBxB+Sj+3mdcPKfXn4fr
	/hFwSGK93PVKcpC9sA0EC02DQ+fyJcvhNx26tixy8oQtRDa3OYGa7yHCP0ueXHotRxgb7qdp4b3
	n20s+CvfLNEOTFPGVlvxRYyhO48ZNV7ua5FEU5k4mS/mb7mThkbG+CN4kyVGNyV+XWaM2
X-Gm-Gg: AfdE7clYEdx4xr35PN3Sgu5vwSFR1Mqlnx0JXUxU+MTIV7XCN7AXiOE/qv7a5ZftVGa
	IgJxJ8KPRgWj/DZcWqmyrK+r4ZAxmCnDzw/PraHO9WG06cXmUJpLbF3o4E7hEdhcsgcBUfHWd+T
	kTC+JigeC9O0cwbXqn+DvwdTauazC2FuKPdM+saFrktU236cpoxu/MdYzG20Jam0Z0YRTiXRPkJ
	9tK0C1Eg3UHluk6GvfOdqsa6q9B9mgzvT9KyH8+crKRHm9gSPBAhZ9RNIrS/wMvPK9lcsBGILPn
	EleQYA9PGDqtada2ByOUJuIz04Sm7UzacLHPZPsRLhogqj4dZM/no9108K8q2lgIqWzZz8DU35s
	6TIVuxrR6Iu9ct1qX2MFLSI51CfS8ltTx9vk=
X-Received: by 2002:a5d:5f49:0:b0:462:6aa1:4393 with SMTP id ffacd0b85a97d-47f4886edc6mr4094736f8f.4.1784055161958;
        Tue, 14 Jul 2026 11:52:41 -0700 (PDT)
X-Received: by 2002:a5d:5f49:0:b0:462:6aa1:4393 with SMTP id ffacd0b85a97d-47f4886edc6mr4094699f8f.4.1784055161476;
        Tue, 14 Jul 2026 11:52:41 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-24-117.inter.net.il. [80.230.24.117])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f464a9879sm11237677f8f.22.2026.07.14.11.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 11:52:40 -0700 (PDT)
Date: Tue, 14 Jul 2026 14:52:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Rientjes <rientjes@google.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	Link Lin <linkl@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@kernel.org>, virtualization@lists.linux.dev,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, prasin@google.com,
	duenwen@google.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	Ammar Faizi <ammarfaizi2@openresty.com>, jiaqiyan@google.com,
	ahwilkins@google.com, Greg Thelen <gthelen@google.com>,
	Alexander Duyck <alexander.duyck@gmail.com>, stable@vger.kernel.org
Subject: Re: [RFC] virtio_balloon: fix Use-After-Free in page reporting
 during PM freeze
Message-ID: <20260714145155-mutt-send-email-mst@kernel.org>
References: <20260709224330.946683-1-linkl@google.com>
 <8d316b6c-41fb-4ae3-8923-3b649b92b33d@kernel.org>
 <20260714092146-mutt-send-email-mst@kernel.org>
 <5e18d7ec-a9d7-2cc3-7741-695ec3580ffa@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <5e18d7ec-a9d7-2cc3-7741-695ec3580ffa@google.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: G4uwXb615sgaUfFyk2RHtK3RfUnXOS96KUicdv2I_ks_1784055162
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 14, 2026 at 11:21:33AM -0700, David Rientjes wrote:
> On Tue, 14 Jul 2026, Michael S. Tsirkin wrote:
> 
> > > > diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> > > > index a1b2c3d4e5f6..45a90fb3abf8 100640
> > > > --- a/drivers/virtio/virtio_balloon.c
> > > > +++ b/drivers/virtio/virtio_balloon.c
> > > > @@ -1055,6 +1055,9 @@ static int virtballoon_freeze(struct virtio_device *vdev)
> > > >  	 * The workqueue is already frozen by the PM core before this
> > > >  	 * function is called.
> > > >  	 */
> > > > +	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_REPORTING))
> > > > +		page_reporting_unregister(&vb->pr_dev_info);
> > > > +
> > > >  	remove_common(vb);
> > > >  	return 0;
> > > >  }
> > > >  
> > > >  static int virtballoon_restore(struct virtio_device *vdev)
> > > >  {
> > > >  	struct virtio_balloon *vb = vdev->priv;
> > > >  	int ret;
> > > >  
> > > >  	ret = init_vqs(vdev->priv);
> > > >  	if (ret)
> > > >  		return ret;
> > > >  
> > > >  	virtio_device_ready(vdev);
> > > >  
> > > > +	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_REPORTING)) {
> > > > +		ret = page_reporting_register(&vb->pr_dev_info);
> > > > +		if (ret)
> > > > +			goto out_remove_vqs;
> > > > +	}
> > > 
> > > Hm, that failure handling is rather nasty.
> > > 
> > > 
> > > In virtballoon_freeze() we document:
> > > 
> > > "The workqueue is already frozen by the PM core before this function is called"
> > > 
> > > Your report states:
> > > 
> > > "Workqueue: events page_reporting_process"
> > > 
> > > 
> > > I assume that workqueue is not frozen yet because ... it's not freezable :)
> > > 
> > > So could we queue to system_freezable_wq instead, or define our own freezable
> > > workqueue there? Then a driver doesn't have to worry about that.
> > > 
> > > -- 
> > > Cheers,
> > > 
> > > David
> > 
> > +1.  Just system_freezable_wq will do the trick.
> > 
> 
> This makes sense.
> 
> I'm curious why this bug hasn't popped up earlier, presumably any VM that 
> has gone through suspend while reporting free pages through FPR is 
> vulnerable to it and could have panicked as a result.  Which would suggest 
> maybe >99% of FPR is done by guests that never suspend?

Quite possible.

>  While under 
> pressure this issue seems reproducible.

