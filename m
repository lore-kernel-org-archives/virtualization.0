Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B72D2F5
	for <virtualization@lists.linux.dev>; Thu,  1 Aug 2024 05:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722491931; cv=none; b=QViswKdAdqS5JA5qNgSyGFdReept37blyqoAziR0rgz6uB7qV15K6HNy97Nqc2cvNRNIs/Q9QqJ0Bv+AfErZT7wgQA1x8U0YeWIdkrCXZMEqBfsEkwWX2DBo+X3Yaa/Qsybglngh7MdxUEZtlt9sRFob4Ol8Xi0qfZqZcyBLDvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722491931; c=relaxed/simple;
	bh=BQeirBRuPNmOYvkj19aFRvVKY+QYqsgfJredh3tRZs0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=IrpojX7q9RlmNvDjYX92nPT+Vg9HBNQWd8HZadpjOKjBeg3D1xe3WFRnukDGa+cNd7tlqQesFtKhO0PBX9UtREq1h1sJra65x3uScdZIEDAQ+aJM78a7RMcoeCX2EvDM/+kgw6Abl+q+12L2iEi/h1Wbos2kNPK+SbnvjwhFTbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FNNLZDzl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FNNLZDzl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722491928;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TYby3S55PJtaqBnCLpODSNFCjBcgHmHQ8Om5VMgkKMM=;
	b=FNNLZDzlCl7xEy5BH1jlj7BJ+5IyclCVrOqGLMg0ut3W2PfS6bjafgTQsj3YbuwiaFVf4G
	fmzYkEIykgvKYm8rV69Ua5KD1E8/bSuwZQ1G0tw9UDAlWuEUqYYFJBvXK2iTOj29ndFTAT
	JfaWxVh3rTggDRZwEDOlliJ4jm1ePsQ=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-567-Ev8wvu4zO1S0RdhiheVcuA-1; Thu, 01 Aug 2024 01:58:46 -0400
X-MC-Unique: Ev8wvu4zO1S0RdhiheVcuA-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-52fceed3473so6282627e87.0
        for <virtualization@lists.linux.dev>; Wed, 31 Jul 2024 22:58:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722491925; x=1723096725;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TYby3S55PJtaqBnCLpODSNFCjBcgHmHQ8Om5VMgkKMM=;
        b=ZybxyH1i7K/N3yzRou8UHiQXrcCoRP7WlgsfbaA4YYlHiFn3UN9SX7Uy7jbi8NjJ03
         ynJL4zodOgh6ge0ORN6d0rmolHKn/Dk2z/ruJgwsC6IhPiV2rz/qTMRMdAKKHm6c1lGG
         IKpDkWJbLMczMUgc+/nCbMbe4182Y5wRKZodfRRm+K4SuXEblt4iCPKTy7mHqJpfpOFV
         Nvcg9ueDVhLI+tqvaIKllpLGN0c0OvrtobP+Bdn4f3g888AyZY+HTt3BaP2k3IyTtacz
         MxCFmJYgyBaqpUpkSMI7D3o/3ZNuv2vCzfJiiO+zVjLl606iZmSeo/zR1+RY/DLHsUpt
         L8AQ==
X-Forwarded-Encrypted: i=1; AJvYcCXS+Zg/P6EyAgRo6S4upA5/vK35GW8YywzYxAd9aYnYmaNMzfV+kAU1W+kC4r4T9cc4vfcY9o4k3ZSZr6Sg8S55dOwPfOezyN3MRktKE30=
X-Gm-Message-State: AOJu0YwzcFh4l67Z5r56itOO1ZaZHYz3TAA1tCsh36pJNUgnQ2XzDq2i
	OwdrxhOng9AUj1t94lLJPxMYnzek/4iFMpVAWfAUkW4Q2Hrhq8jIZk6Y4I3ClUxq7w07MIRs+Fb
	8b1IYPiSBQdNGSH+CeO8E4Gm2qumHuKLwlswgG49IDpVxLj24PgVxcrhbCIzQ0sLw
X-Received: by 2002:a05:6512:4008:b0:52c:83c7:936a with SMTP id 2adb3069b0e04-530b61fec2cmr1028193e87.42.1722491924839;
        Wed, 31 Jul 2024 22:58:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdBq5LsXMOtvElE6EOfY6fVtQyD07R6xmuzAO4uy70HRKTviw+Ngzs8GylVhzOCWgj7uUzpg==
X-Received: by 2002:a05:6512:4008:b0:52c:83c7:936a with SMTP id 2adb3069b0e04-530b61fec2cmr1028165e87.42.1722491923947;
        Wed, 31 Jul 2024 22:58:43 -0700 (PDT)
Received: from redhat.com ([2.55.44.248])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acad41479sm849692166b.123.2024.07.31.22.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 22:58:43 -0700 (PDT)
Date: Thu, 1 Aug 2024 01:58:36 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Venkat Venkatsubra <venkat.x.venkatsubra@oracle.com>,
	Gia-Khanh Nguyen <gia-khanh.nguyen@oracle.com>
Subject: Re: [PATCH V4 net-next 3/3] virtio-net: synchronize operstate with
 admin state on up/down
Message-ID: <20240801015344-mutt-send-email-mst@kernel.org>
References: <20240731025947.23157-1-jasowang@redhat.com>
 <20240731025947.23157-4-jasowang@redhat.com>
 <20240731172020-mutt-send-email-mst@kernel.org>
 <CACGkMEvXfZJbCs0Fyi3EdYja37+D-o+79csXJYsBo0s+j2e5iA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CACGkMEvXfZJbCs0Fyi3EdYja37+D-o+79csXJYsBo0s+j2e5iA@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 01, 2024 at 10:16:00AM +0800, Jason Wang wrote:
> > > @@ -2885,6 +2886,25 @@ static void virtnet_cancel_dim(struct virtnet_info *vi, struct dim *dim)
> > >       net_dim_work_cancel(dim);
> > >  }
> > >
> > > +static void virtnet_update_settings(struct virtnet_info *vi)
> > > +{
> > > +     u32 speed;
> > > +     u8 duplex;
> > > +
> > > +     if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_SPEED_DUPLEX))
> > > +             return;
> > > +
> > > +     virtio_cread_le(vi->vdev, struct virtio_net_config, speed, &speed);
> > > +
> > > +     if (ethtool_validate_speed(speed))
> > > +             vi->speed = speed;
> > > +
> > > +     virtio_cread_le(vi->vdev, struct virtio_net_config, duplex, &duplex);
> > > +
> > > +     if (ethtool_validate_duplex(duplex))
> > > +             vi->duplex = duplex;
> > > +}
> > > +
> >
> > I already commented on this approach.  This is now invoked on each open,
> > lots of extra VM exits. No bueno, people are working hard to keep setup
> > overhead under control. Handle this in the config change interrupt -
> > your new infrastructure is perfect for this.
> 
> No, in this version it doesn't. Config space read only happens if
> there's a pending config interrupt during ndo_open:
> 
> +       if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_STATUS)) {
> +               if (vi->status & VIRTIO_NET_S_LINK_UP)
> +                       netif_carrier_on(vi->dev);
> +               virtio_config_driver_enable(vi->vdev);
> +       } else {
> +               vi->status = VIRTIO_NET_S_LINK_UP;
> +               netif_carrier_on(dev);
> +               virtnet_update_settings(vi);
> +       }

Sorry for being unclear, I was referring to !VIRTIO_NET_F_STATUS.
I do not see why do we need to bother re-reading settings in this case at all,
status is not there, nothing much changes.


> >
> >
> > >  static int virtnet_open(struct net_device *dev)
> > >  {
> > >       struct virtnet_info *vi = netdev_priv(dev);
> > > @@ -2903,6 +2923,16 @@ static int virtnet_open(struct net_device *dev)
> > >                       goto err_enable_qp;
> > >       }
> > >
> > > +     if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_STATUS)) {
> > > +             if (vi->status & VIRTIO_NET_S_LINK_UP)
> > > +                     netif_carrier_on(vi->dev);
> > > +             virtio_config_driver_enable(vi->vdev);
> > > +     } else {
> > > +             vi->status = VIRTIO_NET_S_LINK_UP;
> > > +             netif_carrier_on(dev);
> > > +             virtnet_update_settings(vi);
> > > +     }
> > > +
> > >       return 0;
> > >
> > >  err_enable_qp:
> > > @@ -3381,12 +3411,18 @@ static int virtnet_close(struct net_device *dev)
> > >       disable_delayed_refill(vi);
> > >       /* Make sure refill_work doesn't re-enable napi! */
> > >       cancel_delayed_work_sync(&vi->refill);
> > > +     /* Make sure config notification doesn't schedule config work */
> >
> > it's clear what this does even without a comment.
> > what you should comment on, and do not, is *why*.
> 
> Well, it just follows the existing style, for example the above said
> 
> "/* Make sure refill_work doesn't re-enable napi! */"

only at the grammar level.
you don't see the difference?

        /* Make sure refill_work doesn't re-enable napi! */
        cancel_delayed_work_sync(&vi->refill);

it explains why we cancel: to avoid re-enabling napi.

why do you cancel config callback and work?
comment should say that.



> >
> > > +     virtio_config_driver_disable(vi->vdev);
> > > +     /* Make sure status updating is cancelled */
> >
> > same
> >
> > also what "status updating"? confuses more than this clarifies.
> 
> Does "Make sure the config changed work is cancelled" sounds better?

no, this just repeats what code does.
explain why you cancel it.



-- 
MST

