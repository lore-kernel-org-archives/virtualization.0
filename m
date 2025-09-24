Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111674317D
	for <virtualization@lists.linux.dev>; Wed, 24 Sep 2025 00:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758675444; cv=none; b=IGA5cL8mA1UqKOYyXC8j8HirLV0aAQ10Ze5KRZAQVdSOfGaG0JrCsdKq5Uwq5qk30Aq6JPD6bRyT9KxlkV/Gcpph0HJivVjubXRhP8CiDaLVd2VxOy3Wtv1ap9gCUivs6CosEOAAwEeCMzA/kqaSTKF1c2q4spoabq7yOeZigtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758675444; c=relaxed/simple;
	bh=2meMIq0xvNpsd0C3TfnyRygJ3hyz9WrQ2mbRdwrlQNA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YBQnzSfYce3coE3hiYU0SjbUYfUgrwYFvjH1kbO5VLVfIifF6s6mg3FIcZ76/2dBUAbPFueM2cLmKZIsA5J/F1TO2+wKIHKEtw/SUGi1b7TTw3s5kzGg/9vflHG5qr0wovwDFlj390i2gGSPyQN34Bpbm9gNcGFrCvd1MxtDQH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SNiQEHZf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SNiQEHZf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758675441;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mna5fc8+pkr3kffYlRCUCjSYLNXJLdLSL+XsAUmGPn8=;
	b=SNiQEHZfnHPlc12UJcUcbY/EHBYMzUwyyGSz3SthdXe0Jo33h1haiBZ7Okd7VBuFTdvRCb
	DpvRdxNlJ42CC1ofJT44RJLwD+skglwQkqGRJABHUUiK5aIQk0FSbKPl8ik0Hqf94lWyYV
	xv0G9r1+9gSYIzkBPTv3pNO1DVbRR+c=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-428-9GrGTTu4NAurOtIaWkmCsg-1; Tue, 23 Sep 2025 20:57:19 -0400
X-MC-Unique: 9GrGTTu4NAurOtIaWkmCsg-1
X-Mimecast-MFC-AGG-ID: 9GrGTTu4NAurOtIaWkmCsg_1758675438
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-32ec69d22b2so6089218a91.1
        for <virtualization@lists.linux.dev>; Tue, 23 Sep 2025 17:57:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758675438; x=1759280238;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mna5fc8+pkr3kffYlRCUCjSYLNXJLdLSL+XsAUmGPn8=;
        b=wMsuPIsRk41loc1Tz2puPAMocID1Hhkd2OMVCQg+gddE3e5QCrVbdDNAeh4mSXd6DK
         M4NR9Nkry8GR+1HWRnxGSQXU9yIrjWbzd/VsiYZqBf1psNWGRTsgy4dn7UA/ehXFO1DU
         bm73CGhF9W2VKgx43Y1i4Uo5wW6cnHrCTsIA72pZPV8JUBNofGIn7OmYQt64UzS6lW8v
         +djYSR9FTt3Drauu4BcBagDlDaxMObeMuvqSSdjkvgpHkBQTGwhqvZ4EUBXTTCRVaPJp
         lbBTNclYkkhfJ8sGxV7SzBE9US2/WcySNnKggr/VozUST7TBFHdv18fDj17pxV+ygkle
         PmsA==
X-Forwarded-Encrypted: i=1; AJvYcCVp7ZDe3+E3Umv2RHmQMauQYry6YpMjumgSfSKNDrBtY+5n/yTIPnogpeH70UErTcYaooDtkXGhXn4wN85ETQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzOM5uFpJDbO2lPvJzIzVY0DJzeQxZqziN0enA+XnPV/1fhezC0
	g9A9JanVOLlZ/leUe2lY9pVDMWjE9von/2EexI1od8cmqyPmsf3lwzkOxOdSzWvngXi72e+LfXG
	vERjg7+SpFMPO/QylGRXqAVkLEfkPn/3DIoA1aNfAE5yEuLxuyZXv3+mr/trSeVgfFwdkg5h9mb
	LyUZnJH0mTg0TnZmQ33TVcY2R9l3nJJSyfkkaS6XCiSy0=
X-Gm-Gg: ASbGnct9ZlzYZAPHnHZuGWTPPGPRz3UcN/218ewBh+2XwRjcm14QEPUgXIwbs0j9/HG
	ZQbz4dEQmnY4YfDYLb1p7nUq8Jr4X6FkmRByOhyo2oqtRuLffbRHqrfU0qe387ItqwX35W8sc5t
	1QGUy3w6PNTeOsjPf6Xw==
X-Received: by 2002:a17:90a:c484:b0:330:84dc:d129 with SMTP id 98e67ed59e1d1-332a97051e0mr3951540a91.36.1758675438307;
        Tue, 23 Sep 2025 17:57:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFTV0R++YsWMVOlEFmppKwBiFSD4CRSUaeq9TRbxN7oL1yQIoluQr0UeLa4xvqZUE85brDoaQoOyIu6r8dY1Mo=
X-Received: by 2002:a17:90a:c484:b0:330:84dc:d129 with SMTP id
 98e67ed59e1d1-332a97051e0mr3951527a91.36.1758675437774; Tue, 23 Sep 2025
 17:57:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250915073429.54027-1-sheng.zhao@bytedance.com>
 <CACGkMEuvT3=a+6LyaFZFmCZzGS5tntPSbSJg=h6FAHdk89pC8g@mail.gmail.com> <2739dcc3-7c38-492c-854a-731298396a0c@bytedance.com>
In-Reply-To: <2739dcc3-7c38-492c-854a-731298396a0c@bytedance.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 24 Sep 2025 08:57:05 +0800
X-Gm-Features: AS18NWA2T2FJ5WODRMOqku7-Gx51ufQZ-1bBtbD01K3KvreFoFw78gqxKSyLVs4
Message-ID: <CACGkMEv3pUBF3Uv2s3MM0Qn--fP3mwN92SqE9NX4gNuMALBTUg@mail.gmail.com>
Subject: Re: Re: [PATCH] vduse: Use fixed 4KB bounce pages for arm64 64KB page size
To: Sheng Zhao <sheng.zhao@bytedance.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	xieyongji@bytedance.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: sIhbGMYOGzC8f1-XgaBCbPT2UfRCAZP9z1W81l6KjFE_1758675438
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2025 at 8:37=E2=80=AFPM Sheng Zhao <sheng.zhao@bytedance.co=
m> wrote:
>
>
>
> On 2025/9/17 16:16, Jason Wang wrote:
> > On Mon, Sep 15, 2025 at 3:34=E2=80=AFPM <sheng.zhao@bytedance.com> wrot=
e:
> >>
> >> From: Sheng Zhao <sheng.zhao@bytedance.com>
> >>
> >> The allocation granularity of bounce pages is PAGE_SIZE. This may caus=
e
> >> even small IO requests to occupy an entire bounce page exclusively. Th=
e
> >> kind of memory waste will be more significant on arm64 with 64KB pages=
.
> >
> > Let's tweak the title as there are archs that are using non 4KB pages
> > other than arm.
> >
>
> Got it. I will modify this in v2.
>
> >>
> >> So, optimize it by using fixed 4KB bounce pages.
> >>
> >> Signed-off-by: Sheng Zhao <sheng.zhao@bytedance.com>
> >> ---
> >>   drivers/vdpa/vdpa_user/iova_domain.c | 120 +++++++++++++++++--------=
--
> >>   drivers/vdpa/vdpa_user/iova_domain.h |   5 ++
> >>   2 files changed, 83 insertions(+), 42 deletions(-)
> >>
> >> diff --git a/drivers/vdpa/vdpa_user/iova_domain.c b/drivers/vdpa/vdpa_=
user/iova_domain.c
> >> index 58116f89d8da..768313c80b62 100644
> >> --- a/drivers/vdpa/vdpa_user/iova_domain.c
> >> +++ b/drivers/vdpa/vdpa_user/iova_domain.c
> >> @@ -103,19 +103,26 @@ void vduse_domain_clear_map(struct vduse_iova_do=
main *domain,
> >>   static int vduse_domain_map_bounce_page(struct vduse_iova_domain *do=
main,
> >>                                           u64 iova, u64 size, u64 padd=
r)
> >>   {
> >> -       struct vduse_bounce_map *map;
> >> +       struct vduse_bounce_map *map, *head_map;
> >> +       struct page *tmp_page;
> >>          u64 last =3D iova + size - 1;
> >>
> >>          while (iova <=3D last) {
> >> -               map =3D &domain->bounce_maps[iova >> PAGE_SHIFT];
> >> +               map =3D &domain->bounce_maps[iova >> BOUNCE_PAGE_SHIFT=
];
> >
> > BOUNCE_PAGE_SIZE is kind of confusing as it's not the size of any page
> > at all when PAGE_SIZE is not 4K.
> >
>
> How about BOUNCE_MAP_SIZE?

Fine with me.

>
> >>                  if (!map->bounce_page) {
> >> -                       map->bounce_page =3D alloc_page(GFP_ATOMIC);
> >> -                       if (!map->bounce_page)
> >> -                               return -ENOMEM;
> >> +                       head_map =3D &domain->bounce_maps[(iova & PAGE=
_MASK) >> BOUNCE_PAGE_SHIFT];
> >> +                       if (!head_map->bounce_page) {
> >> +                               tmp_page =3D alloc_page(GFP_ATOMIC);
> >> +                               if (!tmp_page)
> >> +                                       return -ENOMEM;
> >> +                               if (cmpxchg(&head_map->bounce_page, NU=
LL, tmp_page))
> >> +                                       __free_page(tmp_page);
> >
> > I don't understand why we need cmpxchg() logic.
> >
> > Btw, it looks like you want to make multiple bounce_map to point to
> > the same 64KB page? I wonder what's the advantages of doing this. Can
> > we simply keep the 64KB page in bounce_map?
> >
> > Thanks
> >
>
> That's correct. We use fixed 4KB-sized bounce pages, and there will be a
> many-to-one relationship between these 4KB bounce pages and the 64KB
> memory pages.
>
> Bounce pages are allocated on demand. As a result, it may occur that
> multiple bounce pages corresponding to the same 64KB memory page attempt
> to allocate memory simultaneously, so we use cmpxchg to handle this
> concurrency.
>
> In the current implementation, the bounce_map structure requires no
> modification. However, if we keep the 64KB page into a single bounce_map
> while still wanting to implement a similar logic, we may need an
> additional array to store multiple orig_phys values in order to
> accommodate the many-to-one relationship.

Or simply having a bitmap is sufficient per bounce_map?

Thanks

>
> Thanks
>

