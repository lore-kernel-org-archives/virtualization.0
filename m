Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8077134AB
	for <virtualization@lists.linux.dev>; Mon, 24 Feb 2025 07:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740383122; cv=none; b=YpMy7pkmZcbNOTr84f6LOJH7SSYF1g2wdB61BKPY1PZJfBbWZa97CPyLta1zg/WpNbFH9gIYe++ieNoY8e6FngP307nkcRjsmoY2uEFDRsp/Ez1TRPKdF5/xgB8xgb/wmiXwYD1avMuINw1skb3eLlKwqzVVbDD/Z9Rx/cMafLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740383122; c=relaxed/simple;
	bh=NH8pA/rRIuhJj2dTHWRNlJwy4WjedINerJ+EuN1qX8U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Znlfn0bu2b5GXDqM9aqX5sjrttgur47eSSJgJI70msVTY7aHDT7P5P54yLuoAbBfifjGuSK4Iyw9x17EReh0WeL+KzvK4dWgAoncculTVkIilAOAyK5rt4hCze4IObAsoguTz7pMx51SmDrtUCx4bwo6W+z44jwQxaKqnT4gmLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q5fuKkfC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q5fuKkfC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740383119;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TqqJsStYSzgw6zPnJ9OVQt4WMGE6BKA9vAfMMXb1jqY=;
	b=Q5fuKkfCvEWkY1pPl6bQPz+tlvA8PELP3mAPrZXCdenjlYXGDGB+88LQ4weQxxbuT1IG3j
	Lo8OOYcQkBIvlYs05PwGiTV4F3M0c+n2F4/HlSEspuTQeNaH/oM5fW6wUxSsadO2gfaeav
	ZUnVa5u39i94UZyV1sdcHbtDhKMZgHM=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-gWiwK3TANca3IeGYvn0W-Q-1; Mon, 24 Feb 2025 02:45:18 -0500
X-MC-Unique: gWiwK3TANca3IeGYvn0W-Q-1
X-Mimecast-MFC-AGG-ID: gWiwK3TANca3IeGYvn0W-Q_1740383117
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2fc1a70935fso8714604a91.1
        for <virtualization@lists.linux.dev>; Sun, 23 Feb 2025 23:45:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740383116; x=1740987916;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TqqJsStYSzgw6zPnJ9OVQt4WMGE6BKA9vAfMMXb1jqY=;
        b=KRDEzZBKhjvLfe6OjpiNjffkvxdEffdu/UOT7ubn+awfjqhBS6wSSpBYALg72cBb66
         124mApkBWBWCjpTrWvC7WsyLHF3GFeBztgVA+xkq0gwO5BGtYgcK4z9dp1GTBToH04eU
         SH2tENkRwlmO46/mhKtCe+mfk2RJlr0qDGkmTJ0ppIqfwKUBxl6KA0EtHZLiHmTFCf4U
         uzkgZXc2SP6nBucJfv7vSY4iTZsCDjPQ/RhDw7M+9BimH3VfQUPRoWPJVrSq4BHRb2aC
         ZFUnj2b3p2o54v1179cfH6pW445RFIykE7G7riq0Y/Zwtv+hUt+pAqZQ9zdHLRELEVQm
         dYog==
X-Forwarded-Encrypted: i=1; AJvYcCVzwk6A8jt7gmhe0mbni/dZEpEjJ9SgRnZjf+UMmozzAyo1eY/njw08Py4OWCKI07HQLPI7S8RarAL/Mzg7YQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz7S7j6KmZHHUVXLZQ44BvP2+FG0kU67NXLmG5FTm/SYrWFGvUS
	YxyC5k5PFKlaC8BoqusL+5K8el4GLYpr78pTYnolXZiBTW+gd+qJducTZdtxs6kZR64UM1bWjv+
	8uhlkVp8wCeKXSY0Um+Hn/3aB9dZqlzpmbH1+djQmM1dFfnrDDkUd118ot8F52rT7qs9ZvEWLG4
	RmEI6Pa3VLYQGrXhZJqxcoKdtYfeLklKVvHAxvhn27EZCIt8AnTXB7
X-Gm-Gg: ASbGncv57iRh9lCEMniQNgMjgSAevbMuRclMDWy2MwXijABoTE6DQlVIsifY1beNAE1
	GBlOeLFFnKG82GaFlWH7+7oHqVR2uMoNpmgqgcKTKsHdhiMqcPZDu1ULOkhAKqx1Au/Vut7c=
X-Received: by 2002:a17:90b:35ce:b0:2ee:c9b6:c26a with SMTP id 98e67ed59e1d1-2fce78afc47mr22453434a91.11.1740383116368;
        Sun, 23 Feb 2025 23:45:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGd03NCJKapA0K4R+wH4X2B5nqwHMlKA6kza08T2BGLCU3PC/BSlrcq1ri4MQU6KVoRSv045FU2aIywSuBF4Y0=
X-Received: by 2002:a17:90b:35ce:b0:2ee:c9b6:c26a with SMTP id
 98e67ed59e1d1-2fce78afc47mr22453410a91.11.1740383116074; Sun, 23 Feb 2025
 23:45:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250221170626.261687-1-eperezma@redhat.com> <20250221170626.261687-6-eperezma@redhat.com>
 <CACGkMEtdWhdPt6yOjBsMuqF5wv6kjHH2OV_HHN3gedXDUe2T5Q@mail.gmail.com> <CAJaqyWcxWvYrFoocHD6e4ccZxQp9J=rQ_Ou+s3zcwmXQt4xMYA@mail.gmail.com>
In-Reply-To: <CAJaqyWcxWvYrFoocHD6e4ccZxQp9J=rQ_Ou+s3zcwmXQt4xMYA@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 24 Feb 2025 08:44:39 +0100
X-Gm-Features: AWEUYZlg1nXAbWMa31gRfSEy_may4MYKmRmSOpCZy6ZQMcIzQZvycxAkt7cnt7M
Message-ID: <CAJaqyWfwPCOSrgJ=rBFm4oJph5wPG2xu4Gvr-WFntqoA0n4o=Q@mail.gmail.com>
Subject: Re: [RFC v2 5/5] virtiofs: Disable notifications more aggresively
To: Jason Wang <jasowang@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Hanna Reitz <hreitz@redhat.com>, linux-kernel@vger.kernel.org, 
	German Maglione <gmaglione@redhat.com>, virtualization@lists.linux.dev, 
	Stefano Garzarella <sgarzare@redhat.com>, yama@redhat.com, Vivek Goyal <vgoyal@redhat.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 1Y63PUGE4rkVuAo8BBETv5LVczqDkBFly4q9SxfNpWI_1740383117
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 7:44=E2=80=AFAM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Mon, Feb 24, 2025 at 3:01=E2=80=AFAM Jason Wang <jasowang@redhat.com> =
wrote:
> >
> > On Sat, Feb 22, 2025 at 1:07=E2=80=AFAM Eugenio P=C3=A9rez <eperezma@re=
dhat.com> wrote:
> > >
> > > Disable notifications right before scheduling, instead of waiting unt=
il
> > > the work is running.
> > >
> > > After applying this patch, fio read test goes from 1191MiB/s to
> > > 1263.14Mib/s
> >
> > Let's describe more about the testing. E.g FIO parameters, test setups.
> >
> > >
> > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > ---
> > >  fs/fuse/virtio_fs.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> > > index e19c78f2480e..3d6981c0f3c3 100644
> > > --- a/fs/fuse/virtio_fs.c
> > > +++ b/fs/fuse/virtio_fs.c
> > > @@ -915,6 +915,8 @@ static void virtio_fs_vq_done(struct virtqueue *v=
q)
> > >
> > >         dev_dbg(&vq->vdev->dev, "%s %s\n", __func__, fsvq->name);
> > >
> > > +       /* Shceduled, don't send more notifications */
> >
> > Typo, and I think we can just drop this commnet.
>
> Agree.
>
> >
> > > +       virtqueue_disable_cb(vq);
> >
> > Do we need to tweak the virtio_fs_requests_done_work() as well?
>
> I don't think so, as virtqueue_disable_cb can be called multiple times
> without consequences.
>
> To control it in virtio_fs_requests_done_work imply to create a new
> boolean somewhere and add a conditional there, redundant with the
> conditional in virtio_fs_requests_done_work.

I meant it would be redundant with the conditional in
virtqueue_disable_cb_split and _packed, as they store the avail flags
set so the operation is idempotent :).

Is it worth reordering this patch so it can be profiled and applied in
current code?

