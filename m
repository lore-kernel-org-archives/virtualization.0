Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABAAB19B5A3
	for <virtualization@lists.linux.dev>; Mon, 24 Feb 2025 06:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740379498; cv=none; b=fPr4LcWbHOcqk+t2AnW6cbId9SBHJzjiknC67F/FNibCdFIEQXSIirpDnlT6MEMbohCBG7N/7K7jzr7u3N247BQ2wMV3J+/g6xW2iSvHUKhgTyg6Clw6uJtOXkhi1m5y7mjxceZasaciecLnODVa27c07KX6a0rX0f8w+td33mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740379498; c=relaxed/simple;
	bh=/Jfq7whmlioOSwgDgSDv2qm9bwJJVCS1zNEaZ6n/TAs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pRCxJ9qjRVMZEu/Hsb2O/bTae796viVqQrx+o+pIlg6vLL44fyv6N5g5W/XH1Og7Hf8Ob0c6wlO3Je1wfbnXaCJgsqOBTSafdTYzGZKQfdJBnonAU9pj3DyN48YJM4qNPKMjegGhlgyo9JUUTyxiz6Ydc7QK0oVqjP3GCwKkpCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Px/ai2Zl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Px/ai2Zl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740379495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jlnzt+4Vsslz5x4/AuLq7Fn3rGBWOoO6iNMkYrHdaZU=;
	b=Px/ai2ZlLBcrnxdEnU3O8m7xigc2WAI298WEwsJUsQisfsVraPMpiMxud/oCuR9yrVJS1M
	e1OG5d751pQUlmIkDEPWOIHP75Ro3uxZzTiLgnUXz1fAtWnRhqeCUUHWFCv4zdooBQmrOG
	fvBeP0tVbaqujMF0OfZ3ZALoUrD3RKQ=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-6jDfhDClPxaLsGV449fqhg-1; Mon, 24 Feb 2025 01:44:54 -0500
X-MC-Unique: 6jDfhDClPxaLsGV449fqhg-1
X-Mimecast-MFC-AGG-ID: 6jDfhDClPxaLsGV449fqhg_1740379493
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2fc0bc05b36so13517412a91.3
        for <virtualization@lists.linux.dev>; Sun, 23 Feb 2025 22:44:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740379493; x=1740984293;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jlnzt+4Vsslz5x4/AuLq7Fn3rGBWOoO6iNMkYrHdaZU=;
        b=uVwi18NZio07iMyscjdFkpD/8Zt/sGmbTRaPmiU8G2j6kxfXQj23AUpkJcsk7JgutS
         71u3CiIuEI3RZge9Gp8GMZ5GIrOPpq13/WO/CLxeDTsktfQkbHG0bbux24j3xcYig/2c
         J7t2D0HQe9wivO3Aj0VGmzDkni16y/YPS8LdTz5xFhm2ih4GqU1+VPcxYNxt1VpqgRus
         shXVqCTYbQvIhKvWVXwacwOtfKCIjNqK4tR/rmU2A4Qb+QYUkeu8Rv/mgMNGizb75yew
         pYqI000q59IcOhgX/1ZzW1QviONfUuhINeYNXjWcnBel3SDa5CKwN4FdfsVvjuEdZiXr
         k5WA==
X-Forwarded-Encrypted: i=1; AJvYcCU9vWU2JIWuI1XXfN9S9CMp9bePEyYBIN0UzgQJGYi9FgarnczenL/RPV2gRpgtyDJ9Q48NDH5AmdaAtbRf+Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxh8M/DtOZ6unR0ExwwQwxU7Z/65bKNPwXIcNXT3Z00j09od1Bi
	8UO8j+j6zvwu9TWG7etW3FKwc6lsXdeGMjcWh5DBV5tlwAIs38q+ZWNb4YCwRYevIybij6GkvJN
	GTngwm3EkDMm6fmrIcQDfYvtriIt63o8g7KoDPT/fLHW/NPWqFOfuPDEa8SDBSiQ26eD9Y57Y58
	/qlme8NwTSvso4g1zjP4s/Rots/hJUGHolwisbt2A=
X-Gm-Gg: ASbGncvY1IRGmp6t8O+Rx+myuoUn09wkkiVjXuBogVIfpH1LZtUQlxzwkku9wlmETRk
	ug0uZh1CAdMQxHlf2fPZ+OhHR7NcnYKIt4F9QGg98lVLkMH94P8pfn2eyGBZ5DUNXuB5ynII=
X-Received: by 2002:a17:90a:e18c:b0:2ea:bf1c:1e3a with SMTP id 98e67ed59e1d1-2fce86ae2cbmr22577970a91.12.1740379493312;
        Sun, 23 Feb 2025 22:44:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH+QXXdDVbqf8t3f/26ebYVnK6ojKfcvcrvRH2q7kwGg4SFCRCzuT+aRlB7GnSP50i0yF2Yhl0NOkW+BNnKYTQ=
X-Received: by 2002:a17:90a:e18c:b0:2ea:bf1c:1e3a with SMTP id
 98e67ed59e1d1-2fce86ae2cbmr22577956a91.12.1740379493050; Sun, 23 Feb 2025
 22:44:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250221170626.261687-1-eperezma@redhat.com> <20250221170626.261687-6-eperezma@redhat.com>
 <CACGkMEtdWhdPt6yOjBsMuqF5wv6kjHH2OV_HHN3gedXDUe2T5Q@mail.gmail.com>
In-Reply-To: <CACGkMEtdWhdPt6yOjBsMuqF5wv6kjHH2OV_HHN3gedXDUe2T5Q@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 24 Feb 2025 07:44:16 +0100
X-Gm-Features: AWEUYZmaaoOh5-_CSThxXsUePh68Wwvct_SIIcGFaKJE8V1sULxHulV6xbikoMM
Message-ID: <CAJaqyWcxWvYrFoocHD6e4ccZxQp9J=rQ_Ou+s3zcwmXQt4xMYA@mail.gmail.com>
Subject: Re: [RFC v2 5/5] virtiofs: Disable notifications more aggresively
To: Jason Wang <jasowang@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Hanna Reitz <hreitz@redhat.com>, linux-kernel@vger.kernel.org, 
	German Maglione <gmaglione@redhat.com>, virtualization@lists.linux.dev, 
	Stefano Garzarella <sgarzare@redhat.com>, yama@redhat.com, Vivek Goyal <vgoyal@redhat.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: XNk58Bx7fr9tu7sqJ6fyXN_QfS4Eq5EfkrL4Dj0VoDY_1740379493
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 3:01=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Sat, Feb 22, 2025 at 1:07=E2=80=AFAM Eugenio P=C3=A9rez <eperezma@redh=
at.com> wrote:
> >
> > Disable notifications right before scheduling, instead of waiting until
> > the work is running.
> >
> > After applying this patch, fio read test goes from 1191MiB/s to
> > 1263.14Mib/s
>
> Let's describe more about the testing. E.g FIO parameters, test setups.
>
> >
> > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > ---
> >  fs/fuse/virtio_fs.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> > index e19c78f2480e..3d6981c0f3c3 100644
> > --- a/fs/fuse/virtio_fs.c
> > +++ b/fs/fuse/virtio_fs.c
> > @@ -915,6 +915,8 @@ static void virtio_fs_vq_done(struct virtqueue *vq)
> >
> >         dev_dbg(&vq->vdev->dev, "%s %s\n", __func__, fsvq->name);
> >
> > +       /* Shceduled, don't send more notifications */
>
> Typo, and I think we can just drop this commnet.

Agree.

>
> > +       virtqueue_disable_cb(vq);
>
> Do we need to tweak the virtio_fs_requests_done_work() as well?

I don't think so, as virtqueue_disable_cb can be called multiple times
without consequences.

To control it in virtio_fs_requests_done_work imply to create a new
boolean somewhere and add a conditional there, redundant with the
conditional in virtio_fs_requests_done_work.

