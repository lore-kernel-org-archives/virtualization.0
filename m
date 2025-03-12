Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32EA81EF09A
	for <virtualization@lists.linux.dev>; Wed, 12 Mar 2025 20:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741813046; cv=none; b=D7vJZWbJ5bjn/EGpSLPlYdzZIkfinyC0ok2eCr8PZxrK3CGo/I9G6Inj+TVuQW32tQbyvTX94cDlqexQeoKrraQfo3CGCuCThrTQgSELCy2ggmAV7dtpQ78oyPSii7nlLhH2d5W95XORxeigzkIEHOJDivbFmlljwy2suzNi6cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741813046; c=relaxed/simple;
	bh=hWLmRQlu6su8qwX6geP2oMXctHQ9DhFclCPqDI2P8ks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=NXfBkGqpfsEFdhpEpICwpeL+p+hZamqIk2iDnJMCWEkMTZ29CIU9PMIOreUjMSJYtFb+BH4WNQSMVCq6LEYZ5SpgcWS0rpC3fXVkvLivQckzv7E7XNg/OGKa1nh1aCWerqJ21ju7zfFmfhxSP9+hAuSfulHf05s+cI+pQuUlWgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A0vdGSez; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A0vdGSez"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741813042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=slUJe+JHhJOnq30PEtJv6XBCtRVaMaEHLPY3w2dXjCU=;
	b=A0vdGSezksR6SG4T9D+Kr+UxQwtZlIKsr0kXpq774s2dvMrsRYNBUaTXVihaw1BTm2aLs3
	BQ5M2pWGGOs/2b13QUgCrO/uFsp8125SbnXkOcLvLjkGxlTkN79o5aCZvMEKRhNUB+vCJN
	Ld+DLQT0XyBBNe0JBJ9+ld4FDn8Un5c=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-386-ZiPtq85DOcewjhDal3_WeQ-1; Wed, 12 Mar 2025 16:57:21 -0400
X-MC-Unique: ZiPtq85DOcewjhDal3_WeQ-1
X-Mimecast-MFC-AGG-ID: ZiPtq85DOcewjhDal3_WeQ_1741813040
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43d08915f61so966545e9.2
        for <virtualization@lists.linux.dev>; Wed, 12 Mar 2025 13:57:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741813040; x=1742417840;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=slUJe+JHhJOnq30PEtJv6XBCtRVaMaEHLPY3w2dXjCU=;
        b=upaNRKyST7RoDK0jPTNcl1l9FT4tIhiLHZs/m2x/Qcgf52rAnIowPYVN0f9iyHbx93
         5uSdREd7//RIlFpR8sMvx6pwV9jYSnxJz+6opqYPxXjzdmnl58HWTiGJbssg7tkmHxxl
         CHGi89Fclx3Shq8JvMLhywhaEbGn4kDqYky/Pf5tL4HgPb36GwS4X2ws5dY3MkRdXDsF
         9fc4/mH0L50GYVyP/ZDdZxyGUbkZjU6WrXvGDFbJOHkle5Gxbj8NCE6/sPQPqi3j60LU
         vFMksbg4EYX8kKHuLMccmnBZPLHfAWPOwgvffNq8CIc9NcEceaXl30EIoUqzBRI1XE17
         n4lw==
X-Forwarded-Encrypted: i=1; AJvYcCU9rBQcadpbm4Gnmc0BYaPHIoYt0m2hmZ+WW3TZEx9APs6xR55IA9Xot2wT7/Z+kJU44k5B/AyTT7iHHf/onA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx9/I0VUgFCh+QcL3JxSenvmKqAVjNwibneqklDnIPaPKmy7A3V
	nPZIrnRLBuVXmnDJKGIo7SbQxCx5Z7jenXU5rxorLCAieO2MKdwmkCUTVogDKFBHANW6ShLYsLr
	JdrM/xR1JEcqsvYxVAlMUHWBhNI+7sNA12TyUlRV7+rAbESPW1kxmyQwHT3d3omDU
X-Gm-Gg: ASbGncsqRxs8iTy3IxccTT/ObfaKZRvzoe022Kzzc938GkXG6hUZ70dPD6CEKgEcQi8
	hUgcC4IG6EbabnC8dm+xaVhD/h7heqp7RQaWSE5EPuIrVgHYO5AGhmJ8K3ReuzYyWavPs8Lwd9A
	CcJSijORl3vaqDiLTj6tSTVOkic68B8s2E0Fi8ezKszI5us/JxJWnJeJ5ssJ9YnLQ162PZTNYwL
	NuaidKNoqY8/I9NzZkJ0oGey6sIhLF7zcn3kN/fiy69iBWjaUnyhX0l7Gb2j7alrHMe5HIptLSv
	/QZmVaMfbA==
X-Received: by 2002:a05:6000:144d:b0:38f:503a:d93f with SMTP id ffacd0b85a97d-39132d9908fmr17334954f8f.40.1741813039716;
        Wed, 12 Mar 2025 13:57:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3/+BK82Z+aTDjO7POooWoHYU637cwTUeXYPG2W8VKTA2QZ3BgBHzUd7t9xStiQ+fOSVcEVA==
X-Received: by 2002:a05:6000:144d:b0:38f:503a:d93f with SMTP id ffacd0b85a97d-39132d9908fmr17334939f8f.40.1741813039371;
        Wed, 12 Mar 2025 13:57:19 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfdfcb8sm22470458f8f.33.2025.03.12.13.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 13:57:17 -0700 (PDT)
Date: Wed, 12 Mar 2025 16:57:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Nico Pache <npache@redhat.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev, xen-devel@lists.xenproject.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	cgroups@vger.kernel.org, kys@microsoft.com, haiyangz@microsoft.com,
	wei.liu@kernel.org, decui@microsoft.com,
	jerrin.shaji-george@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com, arnd@arndb.de,
	gregkh@linuxfoundation.org, david@redhat.com, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, jgross@suse.com,
	sstabellini@kernel.org, oleksandr_tyshchenko@epam.com,
	akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org,
	roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, nphamcs@gmail.com, yosry.ahmed@linux.dev,
	kanchana.p.sridhar@intel.com, alexander.atanasov@virtuozzo.com
Subject: Re: [RFC 4/5] vmx_balloon: update the NR_BALLOON_PAGES state
Message-ID: <20250312165302-mutt-send-email-mst@kernel.org>
References: <20250312000700.184573-1-npache@redhat.com>
 <20250312000700.184573-5-npache@redhat.com>
 <20250312025607-mutt-send-email-mst@kernel.org>
 <CAA1CXcDjEErb2L85gi+W=1sFn73VHLto09nG6f1vS+10o4PctA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CAA1CXcDjEErb2L85gi+W=1sFn73VHLto09nG6f1vS+10o4PctA@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: H8V-GK913n0kuDz4OCw6Ooka3GauhVKVK9P3ipDkJ5g_1741813040
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Mar 12, 2025 at 02:11:09PM -0600, Nico Pache wrote:
> On Wed, Mar 12, 2025 at 12:57 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Tue, Mar 11, 2025 at 06:06:59PM -0600, Nico Pache wrote:
> > > Update the NR_BALLOON_PAGES counter when pages are added to or
> > > removed from the VMware balloon.
> > >
> > > Signed-off-by: Nico Pache <npache@redhat.com>
> > > ---
> > >  drivers/misc/vmw_balloon.c | 5 ++++-
> > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/misc/vmw_balloon.c b/drivers/misc/vmw_balloon.c
> > > index c817d8c21641..2c70b08c6fb3 100644
> > > --- a/drivers/misc/vmw_balloon.c
> > > +++ b/drivers/misc/vmw_balloon.c
> > > @@ -673,6 +673,8 @@ static int vmballoon_alloc_page_list(struct vmballoon *b,
> > >
> > >                       vmballoon_stats_page_inc(b, VMW_BALLOON_PAGE_STAT_ALLOC,
> > >                                                ctl->page_size);
> > > +                     mod_node_page_state(page_pgdat(page), NR_BALLOON_PAGES,
> > > +                             vmballoon_page_in_frames(ctl->page_size));
> >
> >
> > same issue as virtio I think - this counts frames not pages.
> I agree with the viritio issue since PAGE_SIZE can be larger than
> VIRTIO_BALLOON_PFN_SHIFT, resulting in multiple virtio_balloon pages
> for each page. I fixed that one, thanks!
> 
> For the Vmware one, the code is littered with mentions of counting in
> 4k or 2M but as far as I can tell from looking at the code it actually
> operates in PAGE_SIZE or PMD size chunks and this count would be
> correct.
> Perhaps I am missing something though.


Can't say for sure. This needs an ack from the maintainer.

> >
> > >               }
> > >
> > >               if (page) {
> > > @@ -915,6 +917,8 @@ static void vmballoon_release_page_list(struct list_head *page_list,
> > >       list_for_each_entry_safe(page, tmp, page_list, lru) {
> > >               list_del(&page->lru);
> > >               __free_pages(page, vmballoon_page_order(page_size));
> > > +             mod_node_page_state(page_pgdat(page), NR_BALLOON_PAGES,
> > > +                     -vmballoon_page_in_frames(page_size));
> > >       }
> > >
> > >       if (n_pages)
> > > @@ -1129,7 +1133,6 @@ static void vmballoon_inflate(struct vmballoon *b)
> > >
> > >               /* Update the balloon size */
> > >               atomic64_add(ctl.n_pages * page_in_frames, &b->size);
> > > -
> >
> >
> > unrelated change
> Fixed, Thanks for reviewing!
> >
> > >               vmballoon_enqueue_page_list(b, &ctl.pages, &ctl.n_pages,
> > >                                           ctl.page_size);
> > >
> > > --
> > > 2.48.1
> >

