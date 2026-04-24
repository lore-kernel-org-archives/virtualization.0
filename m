Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6FC179A3
	for <virtualization@lists.linux.dev>; Fri, 24 Apr 2026 13:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777037851; cv=none; b=fWkkkcGUHmnJRJ/oY8fYuFiwDEyUaAoEiWJv4YCJEFDtXF++dFerFbSYqU4vlRSgJwTDrAUEJ5kjf+8Y79pEmjl6hx/+TaducZXXugOqEA/1DssyqZSDPgwceZfgJWmcEGXMU0oamLJBYu3zJun3dcf2YbxBD5DavTMrgD/2BRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777037851; c=relaxed/simple;
	bh=dUQQ8pFtZezmOFkHjVksdGw4qZjH1LIeyqVm6Lhy7lw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tj0hcfxbg5zZqPk64MO43XiyEuilSDX1V88a+WFyU9x2MH1sWS10vlusB544nvdMrrumPCDN4f3Hj/M3/h7foP457i61Jhdxz0HRHK1P29LzqoBbkdMU5HRmCXu17baM8NoY5KRGvPB+fcMYAn6OZlw6PPRNAC66Y3DlLbJtU/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QLs3Qty1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QLs3Qty1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777037849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DtX66lT/W6prL5uqZLqwtLz4hKp3UqjA1u9XnUtN2Os=;
	b=QLs3Qty1NhsXUVoGhZxJ/CWDGHC72QamyYMR/0V4eM6p8gLIhOZbfIDmtndD051QlaBQSD
	5nfK/j8j41w+Kbi2/nUEQYcRDVt6dpgXKIo0ytPF9gDM63pjrivDjkCjd3+rbRPV+Ptequ
	jVoWR5BEz0dGSuEcs4l84vQjXcmZCWc=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-332-OutpVRkpMoWV5iJYd49z7g-1; Fri, 24 Apr 2026 09:37:27 -0400
X-MC-Unique: OutpVRkpMoWV5iJYd49z7g-1
X-Mimecast-MFC-AGG-ID: OutpVRkpMoWV5iJYd49z7g_1777037846
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-7af89eabe49so165529437b3.0
        for <virtualization@lists.linux.dev>; Fri, 24 Apr 2026 06:37:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777037846; x=1777642646;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DtX66lT/W6prL5uqZLqwtLz4hKp3UqjA1u9XnUtN2Os=;
        b=G+cShZyENrdcsb67F8dON49OdVLLqXUq/A18x3+CKLNPGRFOmjm0/drfxgn7s350as
         cRhkEaPMoSUc9+VWh0HYt6vSop2iTLgMxMXn94AkfYbUCpedhVxQ2PJLowzQC6R51XJN
         ipQAFHoTbzQCUVvoin92dVmiZbXB1V6OxQCouvnLiDl2F+3/LhYHpMROcILkKqsUCy5X
         iwXRf6QGvmYJ5r2ydzP7dVZbxG5IqEbJWOLYxlaQIIse5UA8QsBHWYDedWl++L7SkLng
         iXi39q0l9NAsB907IJpavlsm/khFNDPkRj4yjfJcSXzEwZS6bUR/ujinU5yat+XOnJtz
         4O0g==
X-Forwarded-Encrypted: i=1; AFNElJ8T6Dd45yOh/OpzObkxO4H4RA5zZNIHpWIxgiQQjyxdaa8yN9Y3T8JVgY50AnEwLexQSOCQRI5vqnSqVbq9+A==@lists.linux.dev
X-Gm-Message-State: AOJu0YzbKcBtR9AB4+qw/U5NC0YBBwj7yNvR2ULhHOX1Bt6PX0iJI20k
	6CHmU1q56TWPTLI2vn6vpM0TBftWNYeOGogLEpjeVX9cgGhXoEN79WAFhTGix6EFxEOUuNxqRhJ
	vyHTqL5+oa89ehvnIh5nZHvAS3hORUu8z/WAPC8MSsAS4SHkwuFNYHqlNwzuICJ2WdNaLQqwCvI
	zqtXPIuRivbF2AjO/JgXxWzpuvJ68luwK3WuvvdQwVhPI=
X-Gm-Gg: AeBDiesCkYMA9KzxEnITxcLH+YpKTHX5MjKQK9iNE7SoCdBNOAYfeASTLxI/XXIEuC3
	CK0pmni5uta8pNsv2bghc8WSrvIuyw4p18yo9iufCa4is/U0z74OTWaHq097O+hSfTqxmD4Cte5
	eRk84JFcKSz2o/An72d637hyU+Hn3yMny0h4yLZe403wjjiqASBYqNWBBLriTWeWAU5TIbKtC8n
	jBro4WixYrPN578
X-Received: by 2002:a05:690c:6b12:b0:7ba:f0ed:c5a6 with SMTP id 00721157ae682-7baf0edf1f6mr208138967b3.15.1777037846496;
        Fri, 24 Apr 2026 06:37:26 -0700 (PDT)
X-Received: by 2002:a05:690c:6b12:b0:7ba:f0ed:c5a6 with SMTP id
 00721157ae682-7baf0edf1f6mr208138587b3.15.1777037846048; Fri, 24 Apr 2026
 06:37:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260310-virtio-media-id-v1-1-be211bcf682b@redhat.com>
 <CADSE00+VyDf6hMAB79wP2koSQ3FznO_OJuGCZ6zN8zuCrwtZMg@mail.gmail.com> <20260424090616-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260424090616-mutt-send-email-mst@kernel.org>
From: Albert Esteve <aesteve@redhat.com>
Date: Fri, 24 Apr 2026 15:37:14 +0200
X-Gm-Features: AQROBzAcYYySN2fayIUUaSV-I7pnifB2PVF_IgwJqIST63eaPPZiClrCmiTkhnc
Message-ID: <CADSE00JEjrecyM==PyjX9LT5X62awYQOn3as-KFGYQrSD0+K_w@mail.gmail.com>
Subject: Re: [PATCH] virtio: Add ID for virtio media
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	gnurou@gmail.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: n8AFuOBrRxIOvy-NY5v7bge_8Sn1P8q4gZZC_CTI2Sg_1777037846
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 24, 2026 at 3:07=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Thu, Apr 09, 2026 at 06:53:41PM +0200, Albert Esteve wrote:
> > Hi,
> >
> >
> > On Tue, Mar 10, 2026 at 9:41=E2=80=AFAM Albert Esteve <aesteve@redhat.c=
om> wrote:
> > >
> > > Add VIRTIO_ID_MEDIA definition for virtio-media.
> > >
> > > Signed-off-by: Albert Esteve <aesteve@redhat.com>
> >
> > Are there any thoughts on this patch, or any actions I need to take?
> >
> > Thanks,
> > Albert
>
> Create a github issue and request a vote as documented in README.md

The inclusion of this ID was already voted and approved. The device
already appears in the VirtIO v1.4 specification, with the same ID (as
linked below). This patch is only meant to translate the decision to
the kernel header.

>
> > > ---
> > > While the Linux driver for virtio media is currently under active
> > > development and review [1], the VirtIO v1.4 specification has
> > > already been published and oficially defines the media device type [2=
].
> > >
> > > Adding the device ID now allows other components and tools to referen=
ce it
> > > before the driver lands, and ensures the kernel headers stay aligned
> > > with the specification.
> > >
> > > [1] https://lore.kernel.org/linux-media/20250412-virtio-media-v3-1-97=
dc94c18398@gmail.com/
> > > [2] https://docs.oasis-open.org/virtio/virtio/v1.4/virtio-v1.4.html#x=
1-82200022
> > > ---
> > >  include/uapi/linux/virtio_ids.h | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/include/uapi/linux/virtio_ids.h b/include/uapi/linux/vir=
tio_ids.h
> > > index 6c12db16faa3a..f9056af0c6223 100644
> > > --- a/include/uapi/linux/virtio_ids.h
> > > +++ b/include/uapi/linux/virtio_ids.h
> > > @@ -69,6 +69,7 @@
> > >  #define VIRTIO_ID_BT                   40 /* virtio bluetooth */
> > >  #define VIRTIO_ID_GPIO                 41 /* virtio gpio */
> > >  #define VIRTIO_ID_SPI                  45 /* virtio spi */
> > > +#define VIRTIO_ID_MEDIA                        48 /* virtio media */
> > >
> > >  /*
> > >   * Virtio Transitional IDs
> > >
> > > ---
> > > base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
> > > change-id: 20260310-virtio-media-id-b31179fcdc44
> > >
> > > Best regards,
> > > --
> > > Albert Esteve <aesteve@redhat.com>
> > >
>

