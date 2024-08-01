Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B63C5338D
	for <virtualization@lists.linux.dev>; Thu,  1 Aug 2024 02:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722479849; cv=none; b=pc1UZd+a0u8j48//KDDW4pSVjoDlqlEPKXWkjKmaR50SgoAl4BjKnDhJ0hnoUlZU8i0tWJMnWC5pbkkFL2EQp8YE8S0QvsjbYlsN8EdgOnVxajefwievVc9utmPI5AKUzWK4kFs6zPdvY3clBzJu3d8launi2z5Sp25GawzECk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722479849; c=relaxed/simple;
	bh=JkFM2Ny4vMDebnwTdLYUpcjCFwe1fHcrPqEFeR1vWXo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k+claV9n7O2B+h3SWQo0JH99/VZO7eNgOoEcCv2m5aXMdymn6euIeeUIjRgvVbBnf9SoRHqQVMCOe3OvLNP+PaSM5dJQpM4C0fkC+xWM9x2RolnlS/+175j3s9DH0Dx5JdMann4tVrSdcWDCILcy8MVB3zw+boiTENGn1EsXiIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GxMIHYkO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GxMIHYkO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722479846;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eCV/gbsqq1NHQ2GSJMetL6TR9fq83KPx+nGrIXful2A=;
	b=GxMIHYkOHZRFgfawI7lIUchLry000tx5wSYgnk3Qh+mRSNRL44BDWkZoIwZWMjZBsRV5Ai
	EM+mUm9jdxocqLVXYeUMZj7EB/J9QBuV+m+mGSFDUcmtYuNwHRzUd5wdQfibSzrhqLwvQa
	QhWqfSA15sMdZlp0AStaME43zTIvSRA=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-314-VFd--DVTPyu3Lzhbod51nA-1; Wed, 31 Jul 2024 22:37:24 -0400
X-MC-Unique: VFd--DVTPyu3Lzhbod51nA-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2cb7364bac9so1767189a91.0
        for <virtualization@lists.linux.dev>; Wed, 31 Jul 2024 19:37:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722479843; x=1723084643;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eCV/gbsqq1NHQ2GSJMetL6TR9fq83KPx+nGrIXful2A=;
        b=ASLGgnTrcOUqtHu2mi5gaNDf0wRVCOOfuccCSrfR8h85+qkBpbLz+MAkWrGjZu7zSJ
         DZRLSqV3KEpdQJLgx5lZY+RVPte93SxgvylYEG9PdVjCRDL8lWW6UoLT+21jTBZoogFZ
         diB9auSf/OO+E1QLVTQWKSJuiBlI+QouofVaC+RDnWlii2dzDsKx+gB4zBMziaziVJHt
         F57mh4WZj+uAg5L8UDXdK3zZyud4DkU1WsYJSOW4K4NI5qhCwuLqt+XaC+Yx0uDqf/1i
         GUxXtZw2w4gPRcJ+Tq1P1K03sB+EKarXgCLMqmXFeMeRNMskMb1ZaXOe9uvCO5xW0nzT
         Xz0w==
X-Forwarded-Encrypted: i=1; AJvYcCVzXjTVMb57qfDGWMga82fY4BBDDZoIPeOaTtklRVsxv1U7JxbBz5F9UBGvclZJjVO5o0MuADEd8t/CmplyAQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzhl77zJdWBDWJzTskjTKbxILVZK9HLMJq0Ekx2WNjelrj2qnpP
	qm4Zn54SurjWtk6XM6AqY+SvgGGWd+eauHECfPjEBjdpvOJuoRs0axoeswBfxrDr3DkoojLegmX
	PBKVS9rS9FX+IPuGOu15RuqDZZeSHyz1BThN7HJhCvEx0v+vcUier855zDzp/3Y+bJtSwxRCqVR
	7P2rQbbYC/EfZNIV9K9cYtp2yavpCWFZI7A5dCbGg=
X-Received: by 2002:a17:90a:bc8a:b0:2c9:5a71:1500 with SMTP id 98e67ed59e1d1-2cfe7da2a1dmr1942678a91.0.1722479843440;
        Wed, 31 Jul 2024 19:37:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IET7EuEOnpge9cNc1MaYwZg+IDCtIfBL1OyFJpDSCTW8Lj5hFzc/DsOT4Ymou2PsXW7dZFr4cOVKBFljKC9rTY=
X-Received: by 2002:a17:90a:bc8a:b0:2c9:5a71:1500 with SMTP id
 98e67ed59e1d1-2cfe7da2a1dmr1942651a91.0.1722479842947; Wed, 31 Jul 2024
 19:37:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240731000155.109583-1-21cnbao@gmail.com> <20240731000155.109583-2-21cnbao@gmail.com>
 <CACGkMEsZPBbQfh+kyjn0nFb76Ad8_o=CXxD2hJt5fxoPa3rhvA@mail.gmail.com>
 <CAGsJ_4wDOH1WoR0viTMO7vf_K6r1ET0VQ4-A4gwqirHvsqwE8A@mail.gmail.com>
 <CACGkMEuzYXp51h2tPk29HKhvSfgsC5WSYtGt==SVMDU-0YSPEg@mail.gmail.com>
 <CAGsJ_4z+-XdAEt+XrxGTnoB4PnimKXhg0JciiwPST-OQYit+-g@mail.gmail.com>
 <CACGkMEvnfFVWWd9++BkZu=7iL8+yo71Fr=R00sTJ+pZUbKbiXw@mail.gmail.com>
 <CAGsJ_4w9UrgBR9gs-J74036JBXaod2OE0WOtPiMYyw+ov7VcHQ@mail.gmail.com> <a7276007-7567-4f8b-a9c8-e491e571c80f@I-love.SAKURA.ne.jp>
In-Reply-To: <a7276007-7567-4f8b-a9c8-e491e571c80f@I-love.SAKURA.ne.jp>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 1 Aug 2024 10:37:11 +0800
Message-ID: <CACGkMEuqnkN2LUwUkRzmR4jQtDHBb02KJY0assOhc+s9wQ-qUQ@mail.gmail.com>
Subject: Re: [PATCH RFT v2 1/4] vpda: try to fix the potential crash due to
 misusing __GFP_NOFAIL
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org, linux-mm@kvack.org, 
	42.hyeyoo@gmail.com, cl@linux.com, hailong.liu@oppo.com, hch@infradead.org, 
	iamjoonsoo.kim@lge.com, lstoakes@gmail.com, mhocko@suse.com, 
	penberg@kernel.org, rientjes@google.com, roman.gushchin@linux.dev, 
	torvalds@linux-foundation.org, urezki@gmail.com, v-songbaohua@oppo.com, 
	vbabka@suse.cz, virtualization@lists.linux.dev, 
	"Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Maxime Coquelin <maxime.coquelin@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 6:21=E2=80=AFPM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> On 2024/07/31 14:05, Barry Song wrote:
> > Jason,
> > Thank you very much. Also, Tetsuo reminded me that kmalloc_array() migh=
t be
> > problematic if the count is too large:
> >  pages =3D kmalloc_array(count, sizeof(*pages), GFP_KERNEL | __GFP_NOFA=
IL);
>
> If "count" is guaranteed to be count <=3D 16, this might be tolerable.

It's not unfortunately, the maximum bounce buffer size is:

#define VDUSE_MAX_BOUNCE_SIZE (1024 * 1024 * 1024)

>
> Consider a situation where current thread was chosen as an global OOM vic=
tim.
> Trying to allocate "count" pages using
>
>         for (i =3D 0; i < count; i++)
>                 pages[i] =3D alloc_page(GFP_KERNEL | __GFP_NOFAIL);
>
> is not good.

Right, I wonder if we need to add a shrink to reclaim the pages that
belong to VDUSE bounce pages.

>
> >
> > You might want to consider using vmalloc_array() or kvmalloc_array() in=
stead
> > when you send a new version.
>
> There is a limitation at https://elixir.bootlin.com/linux/v6.11-rc1/sourc=
e/mm/page_alloc.c#L3033
> that you must satisfy count <=3D PAGE_SIZE * 2 / sizeof(*pages) if you us=
e __GFP_NOFAIL.
>
> But as already explained above, allocating 1024 pages (assuming PAGE_SIZE=
 is 4096 and
> pointer size is 8) when current thread was chosen as an OOM victim is not=
 recommended.
> You should implement proper error handling instead of using __GFP_NOFAIL =
if count can
> become large.

I think I need to consider a way to avoid __GFP_NOFAIL. A easy way is
not to free the kernel bounce pages, then we don't need to allocate
them again.

Thanks

>
>

