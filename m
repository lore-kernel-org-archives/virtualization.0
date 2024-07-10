Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F50C7D412
	for <virtualization@lists.linux.dev>; Wed, 10 Jul 2024 11:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720611374; cv=none; b=iekcWUUUJLoVaSLvkRoyyK8bYO1wQtFmk+OgFijRUE5eoRQCViGO1meSmyR93JUH0hrze0InhzoqbzsAG5koit5rTPXWL2u4EBQK0IRDDyRtbXOhZuybrSpNH39x7s2CIcSw1+S5CY7swyueOTSzjskoHLd4OmlkUJM2srZs1qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720611374; c=relaxed/simple;
	bh=X8uDFXcnEE5RI3vslZAxqO3xUCnLxKmC6eeolodP1ls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=al7XkOCAYpGtoacLnmZV7kpACHTb13TDvSjXWr438uQ5/41yU0tTaP2BkVjpxfVULZeGbieI2TAhxU0shLW1b8+IHLs321xAs3qUvYAzS1BPrRo6ZLGleJ7/jT/BsWQ4t/PoApBloJPN5SJS4bqFp/kCpTttcb0hscyQD9WOMkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QjgXxmrh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QjgXxmrh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720611371;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2suduc0eZg9XX+FDprjOHVDzW/H7s1JCz2GVtSoayG0=;
	b=QjgXxmrhvzqvDRED5uNWxROYATnazhObthV6JhJ+JZ8099Pig5/+3AsyisMyEJcyojPUnU
	PJaBlEelo2G+vN1fWFa5WCKce6q/DgYDpEkpzLIipZT0TTBxj/hhUnZkPn9nlUfNeECrT/
	BT5NCuID62RmxuAGgrtmlQymtnsqESc=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-42-O1jWvF36OryOhs_VnkZqiw-1; Wed, 10 Jul 2024 07:36:10 -0400
X-MC-Unique: O1jWvF36OryOhs_VnkZqiw-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a77bfa15f92so468514166b.0
        for <virtualization@lists.linux.dev>; Wed, 10 Jul 2024 04:36:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720611369; x=1721216169;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2suduc0eZg9XX+FDprjOHVDzW/H7s1JCz2GVtSoayG0=;
        b=aiWbzv3lVB1E/CIdqth5UdV/QCjSMGDY68laClHKZBumWaDxP+yLAJo6Rm03X8SWlS
         jxscO9sQaCwpFVwLt3rrYW/UFdzQCP+QzEUxkZDf8iRxv074E8Jxgg9sjLbRzREVJUI8
         M/1pGoMlb7ZBFrR+B84vmQVJ7k7BZL9QrT8iow1zG8UIbfi6RlXJC08wWOGeqv1jd3/j
         supFx8fsyc0ipGZu9kT/daUz7JoG5AIJMIna+AdZcE+/AH84jTBTTh5m2f4moFXt0tkr
         W6gFqI82uIdsSZEmds4m7M1iINU5YR+WMHJ0bvsmEdZYM0e51TyDBoT0OnfrIEpfziKd
         6rjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrfFXfgOE+xKafMdbPUgHVo5BlnvWMfv5Gu0P7ibV/TVhGK1s5dVIaq5/VgGW61beA3eZlgI2cidpwX0T5jKrM5n3z1K3Ekn85vt+xa1s=
X-Gm-Message-State: AOJu0YzWZN7hsaxiMMTU4+EEVjt+0E7JNcjEubaUGzPMjNKBV9w1T/yE
	ThH8FW7/HFJbrVKUOx2ofYe55y+8ay3oA99Et2Kk0M5O8bD2aYFCH9PeSfmbq+00X77csincfiK
	FBhnMZcoqs4IRr8byS3fnXPg6tQXvJf4653BcnBtmJlEzrFZOmA7+DoUTBgwRZ21+
X-Received: by 2002:a17:906:118f:b0:a6c:7181:4ffe with SMTP id a640c23a62f3a-a780b89cae7mr337171566b.66.1720611369134;
        Wed, 10 Jul 2024 04:36:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1927fCvntios62qJMLPjpSJ34oAaJFk3+qIAErLv8E/TF32/P37V3lT+hs0r8hE+DUqaNEA==
X-Received: by 2002:a17:906:118f:b0:a6c:7181:4ffe with SMTP id a640c23a62f3a-a780b89cae7mr337169166b.66.1720611368490;
        Wed, 10 Jul 2024 04:36:08 -0700 (PDT)
Received: from redhat.com ([2a02:14f:174:f6ae:a6e3:8cbc:2cbd:b8ff])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a854592sm152506866b.146.2024.07.10.04.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 04:36:07 -0700 (PDT)
Date: Wed, 10 Jul 2024 07:36:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Alexander Duyck <alexander.h.duyck@linux.intel.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev
Subject: Re: [PATCH 1/2] virtio_balloon: add work around for out of spec QEMU
Message-ID: <20240710065317-mutt-send-email-mst@kernel.org>
References: <cover.1720173841.git.mst@redhat.com>
 <14b1a2a1acfcaf6d519db8c67f6f207d7cdd7c3b.1720173841.git.mst@redhat.com>
 <CACGkMEtszy1YNB1KAtXVdYFkythWDfrYR+w6CSBAQWV1NCc3hA@mail.gmail.com>
 <20240710021441-mutt-send-email-mst@kernel.org>
 <CACGkMEv7-si5b9Eq7mEDZHGC2r_6CFudOHj9ge7u3s7a1epNcA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CACGkMEv7-si5b9Eq7mEDZHGC2r_6CFudOHj9ge7u3s7a1epNcA@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Jul 10, 2024 at 03:37:49PM +0800, Jason Wang wrote:
> On Wed, Jul 10, 2024 at 2:16 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Wed, Jul 10, 2024 at 11:23:20AM +0800, Jason Wang wrote:
> > > On Fri, Jul 5, 2024 at 6:09 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > QEMU implemented the configuration
> > > >         VIRTIO_BALLOON_F_REPORTING && ! VIRTIO_BALLOON_F_FREE_PAGE_HINT
> > > > incorrectly: it then uses vq3 for reporting, spec says it is always 4.
> > > >
> > > > This is masked by a corresponding bug in driver:
> > > > add a work around as I'm going to try and fix the driver bug.
> > > >
> > > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > > ---
> > > >  drivers/virtio/virtio_balloon.c | 19 +++++++++++++++++--
> > > >  1 file changed, 17 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> > > > index 9a61febbd2f7..7dc3fcd56238 100644
> > > > --- a/drivers/virtio/virtio_balloon.c
> > > > +++ b/drivers/virtio/virtio_balloon.c
> > > > @@ -597,8 +597,23 @@ static int init_vqs(struct virtio_balloon *vb)
> > > >
> > > >         err = virtio_find_vqs(vb->vdev, VIRTIO_BALLOON_VQ_MAX, vqs,
> > > >                               callbacks, names, NULL);
> > > > -       if (err)
> > > > -               return err;
> > > > +       if (err) {
> > > > +               /*
> > > > +                * Try to work around QEMU bug which since 2020 confused vq numbers
> > > > +                * when VIRTIO_BALLOON_F_REPORTING but not
> > > > +                * VIRTIO_BALLOON_F_FREE_PAGE_HINT are offered.
> > > > +                */
> > > > +               if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_REPORTING) &&
> > > > +                   !virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT)) {
> > > > +                       names[VIRTIO_BALLOON_VQ_FREE_PAGE] = "reporting_vq";
> > > > +                       callbacks[VIRTIO_BALLOON_VQ_FREE_PAGE] = balloon_ack;
> > > > +                       err = virtio_find_vqs(vb->vdev,
> > > > +                                             VIRTIO_BALLOON_VQ_REPORTING, vqs, callbacks, names, NULL);
> > > > +               }
> > > > +
> > > > +               if (err)
> > > > +                       return err;
> > > > +       }
> > > >
> > > >         vb->inflate_vq = vqs[VIRTIO_BALLOON_VQ_INFLATE];
> > > >         vb->deflate_vq = vqs[VIRTIO_BALLOON_VQ_DEFLATE];
> > > > --
> > > > MST
> > > >
> > >
> > > Acked-by: Jason Wang <jasowang@redhat.com>
> > >
> > > Do we need a spec to say this is something that needs to be considered
> > > by the driver?
> > >
> > > Thanks
> >
> > I'd say it's a temporary situation that we won't need to bother
> > about in several years.
> 
> I mean, should a newly-written virtio-balloon driver care about this?
> If not, it means it can't work for several Qemu versions.
> 
> Thanks

True - I could not find a way to make it work in a way that
would be compatible with old qemu.


> >
> > --
> > MST
> >

