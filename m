Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62352F12B1
	for <virtualization@lists.linux.dev>; Wed, 22 Oct 2025 05:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761111963; cv=none; b=Y2+7ckLOviBalXKKQm23MJETo4xXmv4z5X6FutbhzdyjpCAqTJTLzJMiEmyXY0d71GJ7iza7ieLDnVBMrypg3tSy3qf3efTsTNFq9fv3+MAnmk22o7paIiX/dcqXRqZqndjmNvtIhBtsdpVBIwENW0SjsyMOJPKOECgzj95k4Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761111963; c=relaxed/simple;
	bh=OOEDwYf/WoldymVHE1bARmPBao5IcHvki7sxdMEqYj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=f49S0HBaB+N2SrPcl5LDJF0gYl6y07SouveILBm1rYvM1dd0QKf7YzTyIQI4UFJEwFzInCEnr41tBynybF2G81Tis/g+0sA1lo5hNlTFo/LiN5Nu8rD30UtUp1YMj7RhPgHMQ+DQsPjIrmdoavodn6+4rE4vdR6McyqclzQ9FGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OHmrtw+x; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OHmrtw+x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761111959;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+gdOCtyqfpPDKTOSjwLO+fIICNulbuVoEvWA7TNWh1Q=;
	b=OHmrtw+x3WbkQ2MF1zz8n9dJhRqKtBNKhxQWG7L35fLALCIJ/cpZRD8NOvX8k5ACrSPMJJ
	KikFPPFZslbVN4sudxYiJqhCYD6zYU8IgQ2wOakQcNoN0TL1tBa9Z8wipeejpLmvQc3oX1
	yS+WJ5m2IBp4z/uOnoRaVov/2jaNEy4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-39aAY__qP1uNkAIolUIZ4Q-1; Wed, 22 Oct 2025 01:45:40 -0400
X-MC-Unique: 39aAY__qP1uNkAIolUIZ4Q-1
X-Mimecast-MFC-AGG-ID: 39aAY__qP1uNkAIolUIZ4Q_1761111939
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-47111dc7c5dso2806645e9.0
        for <virtualization@lists.linux.dev>; Tue, 21 Oct 2025 22:45:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761111939; x=1761716739;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+gdOCtyqfpPDKTOSjwLO+fIICNulbuVoEvWA7TNWh1Q=;
        b=L+nJVgm1H1yYmhD0Zty6cQXk88/P7tjDYsJldvH54MSEMNINbDeqkelAvBZY8QCQU4
         t/Yqkeu3pAlxiq8VFDku2itfUKThPfcClwRAl6WBYg0azmmL2n5KCfOMlhhXrxYBZvKS
         gPwFSaX71K4W08Sv31yVx5KzCdcNHOK8IeOrRn3PcxO+5E+UlPpjapiDCygOwEDMjJXX
         7Dt6kO2uTBdpRg198GMFuz7CexWKJOQqX/prdrVNDmcnqsK2G+WUCTSqus9cF7F/dGLl
         1+icF5rMSlXmpMNbwURQkXM9HZyUO5LH+G9+s6Lx2Bw1W5msqQyH+fNtgX6A53Hy07HP
         Yq2A==
X-Forwarded-Encrypted: i=1; AJvYcCWQ0GosP3NqQV9/SL0kTn8Hvc8EzzGufRTyvtE4PKAq2lNMti/3gyJ3SP/2q0w1pTbAKhM1zcddGXLysB4vTA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyZ3xERAkaSwu+oD/SZixl6Vg0XM9UK8MA5EPdM1kGYFkgMHNgP
	lJZzb/tGXOkvnf5KR/KKZDom+4lxCX9wv6zJYN82TAmXZgBIC4TFxtjZ8DQjvOTZyEHNbd0jymd
	v9OjX0bQL2BBIlGmG9wJ4BXYkCiXg3rF8w4GPBru/RiX5IhnQ+M3uqwFTqFw8xBbpxffUBbiIrY
	GW
X-Gm-Gg: ASbGncusJvkpFN8srPJMMXVt1AALHDAFBh2EPHcyIXFdfL+kHsuqdNfc2yIN/rPtpx9
	Pxc4OGPQ1oUgWYQUp+RFnC0D+Iwhs1JgJ/Wa1rSlvxQQjEehS+GBdgzgRPjn7DjvJLXWLZ3LGBp
	u2QAwxf9DtTCi6qJKfshKWnoO0OeM8O9RestrkMLSpap7dHD8m5R03n8TDDWLMmKLpVlhMOmJ4Y
	Ni/OjbwH3Ph/YxlS6x7IChX7JKEa8+vXp1mEwReYEqVie09htfbdBbnIVbWlbQJSzvOSFq8exdc
	NjQOv94rfxFBtFHJAt8DMRlGPhDR82YptWPEu+fZzJr8jvFLSoI2Fot0oDs2hIsz32CQ
X-Received: by 2002:a05:600c:6992:b0:471:5c0:94fc with SMTP id 5b1f17b1804b1-475c3fa355cmr13586765e9.6.1761111939128;
        Tue, 21 Oct 2025 22:45:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IElHGkXoX3hCkc0GRrDbDcYpbH4YLBEG6cIW8mw2RcnC42OK12DSE/fMXDY2iXzD02ahYxuXQ==
X-Received: by 2002:a05:600c:6992:b0:471:5c0:94fc with SMTP id 5b1f17b1804b1-475c3fa355cmr13586695e9.6.1761111938746;
        Tue, 21 Oct 2025 22:45:38 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:152d:b200:2a90:8f13:7c1e:f479])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47494ab11bbsm30712795e9.1.2025.10.21.22.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 22:45:38 -0700 (PDT)
Date: Wed, 22 Oct 2025 01:45:35 -0400
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
Message-ID: <20251022014453-mutt-send-email-mst@kernel.org>
References: <20251021-virtio_double_free-v1-1-4dd0cfd258f1@oss.qualcomm.com>
 <20251021085030-mutt-send-email-mst@kernel.org>
 <CACGkMEsU3+OWv=6mvQgP2iGL3Pe09=8PkTVA=2d9DPQ_SbTNSA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CACGkMEsU3+OWv=6mvQgP2iGL3Pe09=8PkTVA=2d9DPQ_SbTNSA@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: VP9Q8pDK1vJGMpKGhxeaY5Ft9E3F8P6WGSUoYyUYiWU_1761111939
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Oct 22, 2025 at 12:19:19PM +0800, Jason Wang wrote:
> On Tue, Oct 21, 2025 at 8:58 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Tue, Oct 21, 2025 at 07:07:56PM +0800, Cong Zhang wrote:
> > > The vblk->vqs releases during freeze. If resume fails before vblk->vqs
> > > is allocated, later freeze/remove may attempt to free vqs again.
> > > Set vblk->vqs to NULL after freeing to avoid double free.
> > >
> > > Signed-off-by: Cong Zhang <cong.zhang@oss.qualcomm.com>
> > > ---
> > > The patch fixes a double free issue that occurs in virtio_blk during
> > > freeze/resume.
> > > The issue is caused by:
> > > 1. During the first freeze, vblk->vqs is freed but pointer is not set to
> > >    NULL.
> > > 2. Virtio block device fails before vblk->vqs is allocated during resume.
> > > 3. During the next freeze, vblk->vqs gets freed again, causing the
> > >    double free crash.
> >
> > this part I don't get. if restore fails, how can freeze be called
> > again?
> 
> For example, could it be triggered by the user?
> 
> Thanks

I don't know - were you able to trigger it? how?


> >
> > > ---
> > >  drivers/block/virtio_blk.c | 13 ++++++++++++-
> > >  1 file changed, 12 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> > > index f061420dfb10c40b21765b173fab7046aa447506..746795066d7f56a01c9a9c0344d24f9fa06841eb 100644
> > > --- a/drivers/block/virtio_blk.c
> > > +++ b/drivers/block/virtio_blk.c
> > > @@ -1026,8 +1026,13 @@ static int init_vq(struct virtio_blk *vblk)
> > >  out:
> > >       kfree(vqs);
> > >       kfree(vqs_info);
> > > -     if (err)
> > > +     if (err) {
> > >               kfree(vblk->vqs);
> > > +             /*
> > > +              * Set to NULL to prevent freeing vqs again during freezing.
> > > +              */
> > > +             vblk->vqs = NULL;
> > > +     }
> > >       return err;
> > >  }
> > >
> >
> > > @@ -1598,6 +1603,12 @@ static int virtblk_freeze_priv(struct virtio_device *vdev)
> > >
> > >       vdev->config->del_vqs(vdev);
> > >       kfree(vblk->vqs);
> > > +     /*
> > > +      * Set to NULL to prevent freeing vqs again after a failed vqs
> > > +      * allocation during resume. Note that kfree() already handles NULL
> > > +      * pointers safely.
> > > +      */
> > > +     vblk->vqs = NULL;
> > >
> > >       return 0;
> > >  }
> > >
> > > ---
> > > base-commit: 8e2755d7779a95dd61d8997ebce33ff8b1efd3fb
> > > change-id: 20250926-virtio_double_free-7ab880d82a17
> > >
> > > Best regards,
> > > --
> > > Cong Zhang <cong.zhang@oss.qualcomm.com>
> >

