Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C642F3C26
	for <virtualization@lists.linux.dev>; Wed, 22 Oct 2025 07:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761116476; cv=none; b=L1AZmRtKDpYqxYpQK65e2DVnlHdXDEmXJ1L0mOwiKegy+k9ZTyCoWWgcsC50pe2W1RbyW6WRgVCB8fX9wCwRtdexXMfsYC2/lTxmbqrVI0LGoTnXuW06p0HWWihPqmZSMS56CcEgcGD88vEntYrJIP6DaYRI/NwKLfHlT63fxQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761116476; c=relaxed/simple;
	bh=HxC//6c/pxtCaIYc6byaWXcJI1kJg6+v7VVvcpx2G0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=BwScwW2S8rj/oGbeUeewEgxULc1BSvCk8jKPvCqZ1NSuZ/iwC9MI7zskz1OOUG9nTmxDOAzjA+7kIcCM1QBw1MsAAZgAT8gS4jr2bROji6osIpfGY9bqbqa4mmhV0p635Y4qYNxNymXv3itBF5yxuq+vgUM2WWhvW8CYiuVdvOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W8qas0hE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W8qas0hE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761116472;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p/wzttfZZIcdwp5kIjVhv23r7cyBB6dYXyfUT8ERUaw=;
	b=W8qas0hEH5GL360KYTIMceo4wRxqr5SPDi0l21S/2Q0/W0WI3alD002ffYiXXryeoDJusn
	NFk6ipt58G32+KsqwrguBtqcmj87jGbXqLZW3evCF4sg9zu1o+wNX1f22Z84BqUn7wclPX
	LQM4BdwCosUAyLEzFBTrGKUkDjcSCoE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-83-Plppfh8HN4ObSbODK0SWHg-1; Wed, 22 Oct 2025 03:01:10 -0400
X-MC-Unique: Plppfh8HN4ObSbODK0SWHg-1
X-Mimecast-MFC-AGG-ID: Plppfh8HN4ObSbODK0SWHg_1761116469
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-42558f501adso2625034f8f.1
        for <virtualization@lists.linux.dev>; Wed, 22 Oct 2025 00:01:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761116469; x=1761721269;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p/wzttfZZIcdwp5kIjVhv23r7cyBB6dYXyfUT8ERUaw=;
        b=h4f51cyYwJEiIIWMQuhlFwlTczQoEtPZjRUtAk+Bhm63699IWdG7z9x8Rb6tNauNYf
         C0EnQHKWCvOa8JLJaKaEavp2Bonptne2PuJt5Gcb2RsYZJCA/a/YuUrg+pmsNN9xj39Z
         VYayrgpKFt2QfgeoLrg8GzG4Q91fYDe4TNa7vZnOOCxi/K99HIs/qvxTcvhQqgdoCdEa
         yoEXwIr92KGeweu+GniGk1EoIhIQfecODAJ6AGVlcZGWdxD4n2wiXdvdgIQCbiKaypyJ
         naDvG7ReUu+oBq7+0+J5AL06/8nD+u1Plq+lvuEn2JfoPZpLrvAH2n/pJMOtiNOO5j+r
         ssyw==
X-Forwarded-Encrypted: i=1; AJvYcCWodAeCuOexAF0ugjj20vPFneCooucvM2C57ELRx9qkbU5MBJdeWcKSK/8sVa0BLMw54j0DOkoZTfAudkWuyw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzocMznzm1RkTfeYs20VWaoBEqY5LNUTJryGFLlaiWOMjqNyqrx
	1hki5OvX2VTe9PrVemdxraKr87LvL5YqHPs3FqRH7DNbwgyA+qI00rJ3ESGqPIuIOcROv00b8Qq
	vNfT7ai5T41mN+0JPyMa0ObYDI5B5aEtmSZV3BPPevri7dp25QJEF0tvg9ZMzInb1mVrn
X-Gm-Gg: ASbGncvX2yE3BWs89uxRRUH+pLIif3JOApGtUkXYOE8QyB4pmNkSiD/4oF7ofUr2JAO
	r3ha6XH4FrECAuELaPNYjv2ZTTbeNCoyUdYoCYDrfuM0rbJfmNaLlLHGKAUjMSrwvsIVLW8HueC
	0reM+gLdf5AcU1/kR9J2sNGui+JI6jqcjNvwxqEFfNJXRjy0evxUzvy4CASHVOyrV4lOu/AgZ4D
	TiRSFuaCEHUstLXTjUn2qYWxAbuSWbzMejTHtaZdH2P3lPCZhUS3M54cWCpyzoHRlivUcrfVt+2
	lWQgrzzbRQFXUA57sif/SWlm3Rzg3CbqjIJTBsmIapWfQg3ePoY5JIA2ThqKHKsxippc
X-Received: by 2002:a05:6000:420a:b0:3e5:5822:ec9d with SMTP id ffacd0b85a97d-42704d99f29mr12826969f8f.41.1761116469391;
        Wed, 22 Oct 2025 00:01:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtVUgbjjOkBKOAaeXoFsLqPC4uhTnJ7B4qxCiofbC48XDxdUtASszyIQinjVP9ESvl7Ojt0A==
X-Received: by 2002:a05:6000:420a:b0:3e5:5822:ec9d with SMTP id ffacd0b85a97d-42704d99f29mr12826933f8f.41.1761116468823;
        Wed, 22 Oct 2025 00:01:08 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:152d:b200:2a90:8f13:7c1e:f479])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427ea5b3c56sm23924067f8f.18.2025.10.22.00.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 00:01:08 -0700 (PDT)
Date: Wed, 22 Oct 2025 03:01:05 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Cong Zhang <cong.zhang@oss.qualcomm.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	linux-arm-msm@vger.kernel.org, virtualization@lists.linux.dev,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	pavan.kondeti@oss.qualcomm.com
Subject: Re: [PATCH] virtio_blk: NULL out vqs to avoid double free on failed
 resume
Message-ID: <20251022030050-mutt-send-email-mst@kernel.org>
References: <20251021-virtio_double_free-v1-1-4dd0cfd258f1@oss.qualcomm.com>
 <20251021085030-mutt-send-email-mst@kernel.org>
 <CACGkMEsU3+OWv=6mvQgP2iGL3Pe09=8PkTVA=2d9DPQ_SbTNSA@mail.gmail.com>
 <20251022014453-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251022014453-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 43fU3TUoJsULXWEp998r2CG0gNKnDOHfgXylN9e3AXg_1761116469
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Oct 22, 2025 at 01:45:38AM -0400, Michael S. Tsirkin wrote:
> On Wed, Oct 22, 2025 at 12:19:19PM +0800, Jason Wang wrote:
> > On Tue, Oct 21, 2025 at 8:58 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > On Tue, Oct 21, 2025 at 07:07:56PM +0800, Cong Zhang wrote:
> > > > The vblk->vqs releases during freeze. If resume fails before vblk->vqs
> > > > is allocated, later freeze/remove may attempt to free vqs again.
> > > > Set vblk->vqs to NULL after freeing to avoid double free.
> > > >
> > > > Signed-off-by: Cong Zhang <cong.zhang@oss.qualcomm.com>
> > > > ---
> > > > The patch fixes a double free issue that occurs in virtio_blk during
> > > > freeze/resume.
> > > > The issue is caused by:
> > > > 1. During the first freeze, vblk->vqs is freed but pointer is not set to
> > > >    NULL.
> > > > 2. Virtio block device fails before vblk->vqs is allocated during resume.
> > > > 3. During the next freeze, vblk->vqs gets freed again, causing the
> > > >    double free crash.
> > >
> > > this part I don't get. if restore fails, how can freeze be called
> > > again?
> > 
> > For example, could it be triggered by the user?
> > 
> > Thanks
> 
> I don't know - were you able to trigger it? how?

Sorry I mean the submitter of course.

> 
> > >
> > > > ---
> > > >  drivers/block/virtio_blk.c | 13 ++++++++++++-
> > > >  1 file changed, 12 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> > > > index f061420dfb10c40b21765b173fab7046aa447506..746795066d7f56a01c9a9c0344d24f9fa06841eb 100644
> > > > --- a/drivers/block/virtio_blk.c
> > > > +++ b/drivers/block/virtio_blk.c
> > > > @@ -1026,8 +1026,13 @@ static int init_vq(struct virtio_blk *vblk)
> > > >  out:
> > > >       kfree(vqs);
> > > >       kfree(vqs_info);
> > > > -     if (err)
> > > > +     if (err) {
> > > >               kfree(vblk->vqs);
> > > > +             /*
> > > > +              * Set to NULL to prevent freeing vqs again during freezing.
> > > > +              */
> > > > +             vblk->vqs = NULL;
> > > > +     }
> > > >       return err;
> > > >  }
> > > >
> > >
> > > > @@ -1598,6 +1603,12 @@ static int virtblk_freeze_priv(struct virtio_device *vdev)
> > > >
> > > >       vdev->config->del_vqs(vdev);
> > > >       kfree(vblk->vqs);
> > > > +     /*
> > > > +      * Set to NULL to prevent freeing vqs again after a failed vqs
> > > > +      * allocation during resume. Note that kfree() already handles NULL
> > > > +      * pointers safely.
> > > > +      */
> > > > +     vblk->vqs = NULL;
> > > >
> > > >       return 0;
> > > >  }
> > > >
> > > > ---
> > > > base-commit: 8e2755d7779a95dd61d8997ebce33ff8b1efd3fb
> > > > change-id: 20250926-virtio_double_free-7ab880d82a17
> > > >
> > > > Best regards,
> > > > --
> > > > Cong Zhang <cong.zhang@oss.qualcomm.com>
> > >

