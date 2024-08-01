Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0F2157493
	for <virtualization@lists.linux.dev>; Thu,  1 Aug 2024 07:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722495645; cv=none; b=I+skJ87RTMdtMl1sNQ5JNAhMRnpEDKvdufck/rWhhRPsRdHn6CTV0rPrzhS3vmU8gIBtqYq/XplzOnGsAMfwmh4glG/EU9fWqBva//dIvmiLie/vdhzrtdDxNy9x8BrvuP+HPde7RnR7ItA1XmZeaYMRCR6mG8OfRBX1eZ3pqRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722495645; c=relaxed/simple;
	bh=6caj9hE7loqxOk5C9aNScvIKPsjhWLmXJsy3xQINueI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ALkhMU9HpZPZWiaSQL9xhJp5l8XZkFgwJsxwNG29pmip3ovowU8ybzLy9z/iOB9QaM1qORyV4bfdVR5bmhUaUS5/91tTHlxRPE1fWxNQukTwhhnw3WQlwrxRq8/WoQ9y5MIwjfGwJjkz31lqYLV5WV2XFYaE11M9mzulyu8xeDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bHC3//kc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bHC3//kc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722495642;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t97vND1gXCaWJSJ9FHizLICBacjd6UoqhOOoXzZ7+t4=;
	b=bHC3//kcWa09ThXOKXaKXr/YvZtQ/tfRd6s6rd6+uEKGhVhg1g9tdR/AzfcLxayKcsOYma
	NoBli8TxkOFZUzrcdGh9jqMnoCekuQyrWDZSJ2G5eJqxZNq83MUwe8Z+rQpf5czBsyyiGB
	QrBiydUPXrAYhd/Nb1fo723OhtPHZ7o=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-BmrjM5-2Pm-Io9YblC2lsw-1; Thu, 01 Aug 2024 03:00:40 -0400
X-MC-Unique: BmrjM5-2Pm-Io9YblC2lsw-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a7a83f54fdeso574968866b.0
        for <virtualization@lists.linux.dev>; Thu, 01 Aug 2024 00:00:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722495639; x=1723100439;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t97vND1gXCaWJSJ9FHizLICBacjd6UoqhOOoXzZ7+t4=;
        b=gVaPNNVHSb8BIQFtwTjNsLbp6GbjKrTL8nTTmlkf/JsbIIONxeDvbuhHHDmfknDaEb
         86nx7iVdNSKr53iUOaJISUljpGhz3/8Rgo7evEK4DkzkIYwC9oBmjvqxBGqZihN56UWX
         qa6seDnRyqP3WSqKxLaLC+wrgaD5E0yGevgrZHjhN3QAF2BWZMuVyv4jUsnEDt6sVc/M
         KiAhaZHY1LGcDFst9CIDkxkwBRJ9rpbANw8d0U5WUxsehkFZBvyO93KfgFyB+hZP/t4g
         jZnoXcxc3vZNvfaD6apJhHgV25Rh4ymvgXhXG+hreNQA//Yzjv32Um5CzmZIVLZzndDc
         1Tlw==
X-Forwarded-Encrypted: i=1; AJvYcCVpm/K+mxbxrIkkSu/+zhpz9mXY3PcMo6G/bDXM/yCflPHPH95qo8lDe6dTTAcIBLaHonpoGsGvJQo0Z9FQlynakAip5W3HQmK9Hky2bcE=
X-Gm-Message-State: AOJu0Yx94f47fvtJ1wzQpjXdOfx8RSKEYAEmKmRcXSI7J1Zf7e6EuG5/
	3hkjXj+WlUpwo7MX6loGTkvjtga0x3T/LS7uHp8o99A+2CvXBC7WB0/g9deMFXNU0zKFrT+305j
	isLTvUySBCp5rnAlhNlaQlLgLy0y+dTiabDnNyHitmUn5jesmiyc7TqcB4nN8zOUH
X-Received: by 2002:a17:907:7f04:b0:a6f:27e6:8892 with SMTP id a640c23a62f3a-a7daf675bd7mr105141066b.60.1722495639438;
        Thu, 01 Aug 2024 00:00:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHIGOhV7W2CvCzjil9k2swrnaiNLjMulcih3ywR2QuFboFQabgr8+Sp6ngW0L7YU6f1KXlkKQ==
X-Received: by 2002:a17:907:7f04:b0:a6f:27e6:8892 with SMTP id a640c23a62f3a-a7daf675bd7mr105136866b.60.1722495638552;
        Thu, 01 Aug 2024 00:00:38 -0700 (PDT)
Received: from redhat.com ([2.55.14.19])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acab260besm848865466b.4.2024.08.01.00.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 00:00:37 -0700 (PDT)
Date: Thu, 1 Aug 2024 03:00:32 -0400
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
Message-ID: <20240801025654-mutt-send-email-mst@kernel.org>
References: <20240731025947.23157-1-jasowang@redhat.com>
 <20240731025947.23157-4-jasowang@redhat.com>
 <20240731172020-mutt-send-email-mst@kernel.org>
 <CACGkMEvXfZJbCs0Fyi3EdYja37+D-o+79csXJYsBo0s+j2e5iA@mail.gmail.com>
 <20240801015344-mutt-send-email-mst@kernel.org>
 <CACGkMEstXNPWqhxBXiU3_VnXgQrwHgJKPONRTisbG9mRMkosuA@mail.gmail.com>
 <20240801024012-mutt-send-email-mst@kernel.org>
 <CACGkMEu1MO_UWObYY99SVMigjbRv0oaaKZKqXeVjdiFmUzUM2A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CACGkMEu1MO_UWObYY99SVMigjbRv0oaaKZKqXeVjdiFmUzUM2A@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Thu, Aug 01, 2024 at 02:55:10PM +0800, Jason Wang wrote:
> On Thu, Aug 1, 2024 at 2:42 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Thu, Aug 01, 2024 at 02:13:18PM +0800, Jason Wang wrote:
> > > On Thu, Aug 1, 2024 at 1:58 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Thu, Aug 01, 2024 at 10:16:00AM +0800, Jason Wang wrote:
> > > > > > > @@ -2885,6 +2886,25 @@ static void virtnet_cancel_dim(struct virtnet_info *vi, struct dim *dim)
> > > > > > >       net_dim_work_cancel(dim);
> > > > > > >  }
> > > > > > >
> > > > > > > +static void virtnet_update_settings(struct virtnet_info *vi)
> > > > > > > +{
> > > > > > > +     u32 speed;
> > > > > > > +     u8 duplex;
> > > > > > > +
> > > > > > > +     if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_SPEED_DUPLEX))
> > > > > > > +             return;
> > > > > > > +
> > > > > > > +     virtio_cread_le(vi->vdev, struct virtio_net_config, speed, &speed);
> > > > > > > +
> > > > > > > +     if (ethtool_validate_speed(speed))
> > > > > > > +             vi->speed = speed;
> > > > > > > +
> > > > > > > +     virtio_cread_le(vi->vdev, struct virtio_net_config, duplex, &duplex);
> > > > > > > +
> > > > > > > +     if (ethtool_validate_duplex(duplex))
> > > > > > > +             vi->duplex = duplex;
> > > > > > > +}
> > > > > > > +
> > > > > >
> > > > > > I already commented on this approach.  This is now invoked on each open,
> > > > > > lots of extra VM exits. No bueno, people are working hard to keep setup
> > > > > > overhead under control. Handle this in the config change interrupt -
> > > > > > your new infrastructure is perfect for this.
> > > > >
> > > > > No, in this version it doesn't. Config space read only happens if
> > > > > there's a pending config interrupt during ndo_open:
> > > > >
> > > > > +       if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_STATUS)) {
> > > > > +               if (vi->status & VIRTIO_NET_S_LINK_UP)
> > > > > +                       netif_carrier_on(vi->dev);
> > > > > +               virtio_config_driver_enable(vi->vdev);
> > > > > +       } else {
> > > > > +               vi->status = VIRTIO_NET_S_LINK_UP;
> > > > > +               netif_carrier_on(dev);
> > > > > +               virtnet_update_settings(vi);
> > > > > +       }
> > > >
> > > > Sorry for being unclear, I was referring to !VIRTIO_NET_F_STATUS.
> > > > I do not see why do we need to bother re-reading settings in this case at all,
> > > > status is not there, nothing much changes.
> > >
> > > Ok, let me remove it from the next version.
> > >
> > > >
> > > >
> > > > > >
> > > > > >
> > > > > > >  static int virtnet_open(struct net_device *dev)
> > > > > > >  {
> > > > > > >       struct virtnet_info *vi = netdev_priv(dev);
> > > > > > > @@ -2903,6 +2923,16 @@ static int virtnet_open(struct net_device *dev)
> > > > > > >                       goto err_enable_qp;
> > > > > > >       }
> > > > > > >
> > > > > > > +     if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_STATUS)) {
> > > > > > > +             if (vi->status & VIRTIO_NET_S_LINK_UP)
> > > > > > > +                     netif_carrier_on(vi->dev);
> > > > > > > +             virtio_config_driver_enable(vi->vdev);
> > > > > > > +     } else {
> > > > > > > +             vi->status = VIRTIO_NET_S_LINK_UP;
> > > > > > > +             netif_carrier_on(dev);
> > > > > > > +             virtnet_update_settings(vi);
> > > > > > > +     }
> > > > > > > +
> > > > > > >       return 0;
> > > > > > >
> > > > > > >  err_enable_qp:
> > > > > > > @@ -3381,12 +3411,18 @@ static int virtnet_close(struct net_device *dev)
> > > > > > >       disable_delayed_refill(vi);
> > > > > > >       /* Make sure refill_work doesn't re-enable napi! */
> > > > > > >       cancel_delayed_work_sync(&vi->refill);
> > > > > > > +     /* Make sure config notification doesn't schedule config work */
> > > > > >
> > > > > > it's clear what this does even without a comment.
> > > > > > what you should comment on, and do not, is *why*.
> > > > >
> > > > > Well, it just follows the existing style, for example the above said
> > > > >
> > > > > "/* Make sure refill_work doesn't re-enable napi! */"
> > > >
> > > > only at the grammar level.
> > > > you don't see the difference?
> > > >
> > > >         /* Make sure refill_work doesn't re-enable napi! */
> > > >         cancel_delayed_work_sync(&vi->refill);
> > > >
> > > > it explains why we cancel: to avoid re-enabling napi.
> > > >
> > > > why do you cancel config callback and work?
> > > > comment should say that.
> > >
> > > Something like "Prevent the config change callback from changing
> > > carrier after close"?
> >
> >
> > sounds good.
> >
> > > >
> > > >
> > > >
> > > > > >
> > > > > > > +     virtio_config_driver_disable(vi->vdev);
> > > > > > > +     /* Make sure status updating is cancelled */
> > > > > >
> > > > > > same
> > > > > >
> > > > > > also what "status updating"? confuses more than this clarifies.
> > > > >
> > > > > Does "Make sure the config changed work is cancelled" sounds better?
> > > >
> > > > no, this just repeats what code does.
> > > > explain why you cancel it.
> > >
> > > Does something like "Make sure carrier changes have been done by the
> > > config change callback" works?
> > >
> > > Thanks
> >
> > I don't understand what this means.
> 
> Maybe "Ensure the configuration change callback successfully modifies
> the carrier status"?
> 
> Thanks

I don't know what this means either.
Do you mean:

/* Stop getting status/speed updates: we don't care until next open */


> >
> > > >
> > > >
> > > >
> > > > --
> > > > MST
> > > >
> >

