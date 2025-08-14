Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287B611CA0
	for <virtualization@lists.linux.dev>; Thu, 14 Aug 2025 03:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755142676; cv=none; b=bX28pz2s99F5znCOke575gOg+/xUhc/FOdRejrhbR9V1duCfThoomGNlnVhog42oXG9Ym6gwKORLgHsBh5kR4VAtVAyDstRNoubbKg0JHdlO8huVLE6PEMgOQfGT02E4HiJ+nfffBLK9FrNdCtAmFSwS0jwEc0XAlsJh1DsAToI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755142676; c=relaxed/simple;
	bh=ODVYxGfhnZVWRUX1W6Z3ukNvLzD/yM+NyITXKvEjiHs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hv6GyPJi4Vkdl+QkPdGrqe+Xbj0dKxvRXzNtqY200Zi2AUHhIaDukfmycKgnnQ8Ri8Xe+6H81+P/pnON/5ov1kDn/uLHcu4ZsLaqsPyZK60G6PX5qORul/VxLNqUEZd7H9JTn8Y02wL8LVbRmmveorB65gcu9r0y98mf3ms6i6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SHCFK7EW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SHCFK7EW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755142674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=71MVi3o5yr4/rX1l/x2yD3713Ae1dnEt8rt0hT91LS8=;
	b=SHCFK7EWhZAZPRwYBKuOi4CuQPoDwSpfXoppUEYTfY0jn6HBRG/Hkh8XAlBzDTfKX/opz6
	P8wg+xjwtO3QvbxWZcvgyEuoC0u3vfonR0/4igmZfP5d4pDvE/lmwC4P4HSHNFjn6Z9w+a
	5KDPurc1sQfZNcO79+tMum90aaoe83A=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-153-A-yEkXZCOTGkKEkh4AJ_eg-1; Wed, 13 Aug 2025 23:37:52 -0400
X-MC-Unique: A-yEkXZCOTGkKEkh4AJ_eg-1
X-Mimecast-MFC-AGG-ID: A-yEkXZCOTGkKEkh4AJ_eg_1755142671
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-244581ce388so9496445ad.2
        for <virtualization@lists.linux.dev>; Wed, 13 Aug 2025 20:37:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755142671; x=1755747471;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=71MVi3o5yr4/rX1l/x2yD3713Ae1dnEt8rt0hT91LS8=;
        b=USHzWUjpe1rIx9CxxgvMmIsSnp5DHeM101uhZ2nnkWuIfw5y6y8loX/L468Ed/JX90
         Y9H+R0TSTvBma/kGRMpVGZTqiY7eAwB9QpW1R0DeMPWyCs4Q6hZaPf51VZDg6smY/ZFl
         gqxlJayDE043GlZAlw+ZGO0i5edZJGWRQ6QeaJ/9c3xt6W80Ved+q775MftkqdvDS6ZM
         yP04pxgXemIfg90UVov/unTeF7YaL74XUoGDUB4pDYOqbHfA/iM3IAGwI8j1oiqYnjL9
         7EO2Yp60tRB2akFouLQSUjYN1SSRwWPoXsMM9+HqpdvayxqrLwq3Dhit8Tlis2Gsgny7
         ry6A==
X-Forwarded-Encrypted: i=1; AJvYcCVlaGJ0ZuuJK11c40QBZ2AhO4oUw+5jupP/bi9ybdRyE9eq4wVKKtnVwockB0DvIqmLrAYRcFugSe7og/Bjnw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwY4wrNmDO9hIv5Br2TzEKUYWkHtA2lj/RJ+tQM5t5GmPaMbQ2S
	W6+55taYPmvlsZAwPQOzZ5C6dkxGWg1XnGY/l45B6kgCMSumrc3/60gFOhK06pOosvjTn8Omy8r
	mOx8u0JCk9cU2+BWsnPVujXY6m1C1Csp7bFNpfcjHaY4DT72reSK2VsfoIy5DIP7fP/Gnug6yDe
	HMPp3Usi+IqKpP6yKFU306UOpPXRG3NHl4fyQFyMpkf0I=
X-Gm-Gg: ASbGncuTagXntKXgtqJVXHWjtoOzXfjguXZA51EV1+7zFWQt84dl8QBLqEn37+PtOx5
	1KsLZPTY/qn5VQDZdGk8Sx7WLzSMVWFyyVfcTsJTAPwv+9rSSd5w1kEeD5FpLo+3ldAS1QeUi11
	Fb5pS+qSNwpF2iDqlFyLeskA==
X-Received: by 2002:a17:903:8cc:b0:240:79d5:8dc7 with SMTP id d9443c01a7336-244586e3c74mr23245535ad.46.1755142671527;
        Wed, 13 Aug 2025 20:37:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF203TRMVs/lgMYiSTXHuoYvkxDFILsRC72rZzKYmx/CNcAojWT22mJ6M9ytOYP/ptP7GBNCn7xeYRBHdNjeeQ=
X-Received: by 2002:a17:903:8cc:b0:240:79d5:8dc7 with SMTP id
 d9443c01a7336-244586e3c74mr23245145ad.46.1755142671092; Wed, 13 Aug 2025
 20:37:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250813054831.25865-1-jasowang@redhat.com> <20250813054831.25865-5-jasowang@redhat.com>
 <20250813045703-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250813045703-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 14 Aug 2025 11:37:39 +0800
X-Gm-Features: Ac12FXya8p3BEZXXuB73dkzyerfUrbOxfG5IhoNRbKncLSzHg_MDGkUzTwIXeTM
Message-ID: <CACGkMEuyTBC-g27cSaENVFE5sZdEEb6+ydgYWyzanN0CcgPyzA@mail.gmail.com>
Subject: Re: [PATCH V5 4/9] virtio: introduce vring_mapping_token
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	hch@infradead.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 55F1KoC3Fk8D--JOTlvCsw_ZQearUU9wJijlfORwDSs_1755142671
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 4:58=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Wed, Aug 13, 2025 at 01:48:26PM +0800, Jason Wang wrote:
> > Following patch will introduce the mapping operations for virtio
> > device. In order to achieve this, besides the dma device, virtio core
> > needs to support a transport or device specific mapping token as well.
> > So this patch introduces a union container of a dma device and opaque
> > mapping token. The idea is the allow the transport layer to pass
> > device specific mapping token which will be used as a parameter for
> > the virtio mapping operations. For the transport or device that is
> > using DMA, dma device is still being used.
> >
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> >  drivers/virtio/virtio_ring.c | 110 ++++++++++++++++++-----------------
> >  drivers/virtio/virtio_vdpa.c |   6 +-
> >  include/linux/virtio.h       |   7 +++
> >  include/linux/virtio_ring.h  |   7 ++-
> >  4 files changed, 72 insertions(+), 58 deletions(-)
> >
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.=
c
> > index 482a268af851..fb1d407d5f1b 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -210,8 +210,7 @@ struct vring_virtqueue {
> >       /* DMA, allocation, and size information */
> >       bool we_own_ring;
> >
> > -     /* Device used for doing DMA */
> > -     struct device *dma_dev;
> > +     union vring_mapping_token mapping_token;
>
> For name I don't much like "token". and it's not just
> mapping right? maybe it is just union virtio_dma ?
>

It's not limited to dma, maybe virtio_map? (I'm fine with either).

Thanks

