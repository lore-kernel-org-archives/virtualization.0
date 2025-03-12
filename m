Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548011EC011
	for <virtualization@lists.linux.dev>; Wed, 12 Mar 2025 20:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741810303; cv=none; b=TkfKsucbQ/+qafqWPnaj+F1+PcLxK3Zk1voZgMWfafYk02AtXSY6gZAlEmLT8djHgM7NnvhZ0iyj6YCMn8BYslfNYihsY1dK+L2GFGn8I3fdyS9bqPtiTdft0wjfWzj/gsXdBNcuwFBkz6R8FZ7YCtl+aaoqrRmqfMKpyzNqMzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741810303; c=relaxed/simple;
	bh=nUvK5QSlWouoKts1hziqxpMybmXDATURg6I3GYwAYvs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZLfF3/8lBFg+zo+O5Gh1uUfqF/LDXtt1QvtQh2uZWlF8UFGpMFWvB8GkD1GnvhXcaVWZKJqd7u0jA03pb72j4xk5rvYh6Ec+qoA3UOPIzFNxZxSD5hMi6qQ/Xg6xcVC2/HrmzQXpB5z2aHsfXwTlS0N4KnyLUYq2ncefggypC9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F82Mlyo0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F82Mlyo0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741810301;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CUM3a6gnZC/3zAtpJFYD7FtGrYIIZpsLuUMo7CMvX0I=;
	b=F82Mlyo0zYJC1uYql6vhiQM61BRSDxkvHIdiEzXv/oS70uVzBG8LpiT4hR2a4tdB4FNih/
	HIWI2uP5s2SDn3m3RMrHvfaCkpSlUdSwFMZMGnGG5W0rHdTErTNswSTcUj9kbe4IKb+l40
	oZ/tLrhFAPVuFJh8wa3AZI3/JgAUUrg=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-yu4jbE6oODWo_nCVWYjfkg-1; Wed, 12 Mar 2025 16:11:37 -0400
X-MC-Unique: yu4jbE6oODWo_nCVWYjfkg-1
X-Mimecast-MFC-AGG-ID: yu4jbE6oODWo_nCVWYjfkg_1741810296
Received: by mail-yb1-f197.google.com with SMTP id 3f1490d57ef6-e60aebf48e8so340841276.0
        for <virtualization@lists.linux.dev>; Wed, 12 Mar 2025 13:11:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741810296; x=1742415096;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CUM3a6gnZC/3zAtpJFYD7FtGrYIIZpsLuUMo7CMvX0I=;
        b=Y+AQGsMPaxhvJETfJ0J1z0rJj8K5ebZLA9qC+QHLiPWTWU8a8c+VpaJXkolHYNQilV
         cxRDFthZVD5ruJRyjYt4jPy73SLQNDIougbVGWkGrnHL1t4AdeXT6RZ9nNGWC4TqHHlH
         VUUdYRKkGaxez4YxiWe4JXazMaTabI6dkkoEKqIvLXjoN3aTnVDIlHxgc5lJCpTfmMAa
         GZ8l1EAf3j6wz14nh9FRYVOOb4EunKXpaBeXjLpAKiMJljjicE18oeXdp2ytMMrjmFb+
         TOKXge7OV/URaPCxQD/Fi4cwqeqraO15k5SRHBJ1G+KKbeRrrEbdAgV6Pvq5RC8HcyPB
         VCCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpr0rZEuZsajq/Y6Nj0oC6efHKuUSQ0aSn+aREJzD/7lJwf24A26YjDY1YxKz8pH8oROtMpPAH/6yZGg7jHg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw63oO6+wd1EpemkbKXlPdB64h9map35aP6tPcWGDT5mQlDAE6I
	v8AlSWaJapGtKD9pmxTAz/6WNb4ZFkMWDEF9iB6ls+YARI3BDEtNsnoVx8gXaCksNg15QpUZMWw
	xyv976dRr7qWmpluaHQdE28sPLdTwk6kg2yp+OmsAbv4euG0x1EZH503pwj/IhqN5vP7qpNCy+r
	+ANcwsdfRk1uQhThPHW3IX2Jul5ObOB2JKRqkDQPQ=
X-Gm-Gg: ASbGncsV7wIe1DZYXLTvy8bRr6g93uXAVOaP2FnDok1NzxVQrkn3DCy3iDQ2tA7NT2H
	VinQGoujhi34McfbWOQjfxuOUA8scsm8u/livrsL6aa4U1LSbVJHw4oxGnOEBIhYIeLqz5K5MRn
	a3bPmyIBiQkBw=
X-Received: by 2002:a05:6902:4908:b0:e63:71cf:7a25 with SMTP id 3f1490d57ef6-e6371cf7f99mr23022180276.19.1741810296437;
        Wed, 12 Mar 2025 13:11:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFILEwS4y4Eu7CtZytQ1AMLlSYSOVDPPOZAL/URaaVOd4HXzYxT1BzN9xV4mLg1LOlVPDho5H2JPLVwRxAT/sw=
X-Received: by 2002:a05:6902:4908:b0:e63:71cf:7a25 with SMTP id
 3f1490d57ef6-e6371cf7f99mr23022141276.19.1741810296082; Wed, 12 Mar 2025
 13:11:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250312000700.184573-1-npache@redhat.com> <20250312000700.184573-5-npache@redhat.com>
 <20250312025607-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250312025607-mutt-send-email-mst@kernel.org>
From: Nico Pache <npache@redhat.com>
Date: Wed, 12 Mar 2025 14:11:09 -0600
X-Gm-Features: AQ5f1JpCzw-OMEiWJ5oWmnRpNTzG9s0Jia2dTAgWmtQzoaspW3JJPq9uXITvZCU
Message-ID: <CAA1CXcDjEErb2L85gi+W=1sFn73VHLto09nG6f1vS+10o4PctA@mail.gmail.com>
Subject: Re: [RFC 4/5] vmx_balloon: update the NR_BALLOON_PAGES state
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux.dev, xen-devel@lists.xenproject.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org, 
	decui@microsoft.com, jerrin.shaji-george@broadcom.com, 
	bcm-kernel-feedback-list@broadcom.com, arnd@arndb.de, 
	gregkh@linuxfoundation.org, david@redhat.com, jasowang@redhat.com, 
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, jgross@suse.com, 
	sstabellini@kernel.org, oleksandr_tyshchenko@epam.com, 
	akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org, 
	roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev, 
	nphamcs@gmail.com, yosry.ahmed@linux.dev, kanchana.p.sridhar@intel.com, 
	alexander.atanasov@virtuozzo.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 5951TgubJ9YxL3cPL3ZshljGF2BeHkkJQRKY0n5-7BE_1741810296
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 12, 2025 at 12:57=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com=
> wrote:
>
> On Tue, Mar 11, 2025 at 06:06:59PM -0600, Nico Pache wrote:
> > Update the NR_BALLOON_PAGES counter when pages are added to or
> > removed from the VMware balloon.
> >
> > Signed-off-by: Nico Pache <npache@redhat.com>
> > ---
> >  drivers/misc/vmw_balloon.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/misc/vmw_balloon.c b/drivers/misc/vmw_balloon.c
> > index c817d8c21641..2c70b08c6fb3 100644
> > --- a/drivers/misc/vmw_balloon.c
> > +++ b/drivers/misc/vmw_balloon.c
> > @@ -673,6 +673,8 @@ static int vmballoon_alloc_page_list(struct vmballo=
on *b,
> >
> >                       vmballoon_stats_page_inc(b, VMW_BALLOON_PAGE_STAT=
_ALLOC,
> >                                                ctl->page_size);
> > +                     mod_node_page_state(page_pgdat(page), NR_BALLOON_=
PAGES,
> > +                             vmballoon_page_in_frames(ctl->page_size))=
;
>
>
> same issue as virtio I think - this counts frames not pages.
I agree with the viritio issue since PAGE_SIZE can be larger than
VIRTIO_BALLOON_PFN_SHIFT, resulting in multiple virtio_balloon pages
for each page. I fixed that one, thanks!

For the Vmware one, the code is littered with mentions of counting in
4k or 2M but as far as I can tell from looking at the code it actually
operates in PAGE_SIZE or PMD size chunks and this count would be
correct.
Perhaps I am missing something though.

>
> >               }
> >
> >               if (page) {
> > @@ -915,6 +917,8 @@ static void vmballoon_release_page_list(struct list=
_head *page_list,
> >       list_for_each_entry_safe(page, tmp, page_list, lru) {
> >               list_del(&page->lru);
> >               __free_pages(page, vmballoon_page_order(page_size));
> > +             mod_node_page_state(page_pgdat(page), NR_BALLOON_PAGES,
> > +                     -vmballoon_page_in_frames(page_size));
> >       }
> >
> >       if (n_pages)
> > @@ -1129,7 +1133,6 @@ static void vmballoon_inflate(struct vmballoon *b=
)
> >
> >               /* Update the balloon size */
> >               atomic64_add(ctl.n_pages * page_in_frames, &b->size);
> > -
>
>
> unrelated change
Fixed, Thanks for reviewing!
>
> >               vmballoon_enqueue_page_list(b, &ctl.pages, &ctl.n_pages,
> >                                           ctl.page_size);
> >
> > --
> > 2.48.1
>

