Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE36F185E65
	for <virtualization@lists.linux.dev>; Mon, 15 Jul 2024 09:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721034194; cv=none; b=ujAvQA7PRpTTNpPbpx02ix2JkxVvLxKzkG2srbsddhfwu8EhrMREbXXjRE43+LDU7o4sgve66CzjOQ2c8mENro6yhMBcivwU7rQ0QxHnOMboNRJI0OfA7DL8dpODnVL2VFh4Bjt7z/25rYDLobrAOD0wgmeQ5t8fseZejLzVS2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721034194; c=relaxed/simple;
	bh=0VtblsLVTz1R0kxdVQvHUeHvU4ndJ7LDeoUp1XuPxJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ZGEEx1qnMwdNRLw8K8GVgx/u+6Cmcg/5trhuTZ2TVbUM0pSi70XAze9girPJplIH0d1jV0W43Ujos7t9Q6U2tKsYEUw9qWt3pUWWxEbfzqt1pQbEwHpQivRDXRFpfIa9lBpD5A6EsIxnNW8t6D2FrJUSqXhVizByt6u5fuRB1Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EUen+IGn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EUen+IGn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721034191;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vO2Bb+eqfl0fxtX+QD6D/kijz/3TM4znnKK7Xsx8B7w=;
	b=EUen+IGn0HndfuJjvx04h+sLd4/33/pJoOLb4MsbF8iJ2PT+mDzywAdNnqJJKsrjmvB86t
	YDYSifesqp2jcO7dMKeXj1T+39rIaOthIRsi5ayj7OhnycBrAbe/QLlu+Y86wx/4UsnXHW
	XXhf1j9i2Bs6fCel32j25kl4yR8RZ5U=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-173-nRSX9PWIN9OI0hRDPMOm6g-1; Mon, 15 Jul 2024 05:03:09 -0400
X-MC-Unique: nRSX9PWIN9OI0hRDPMOm6g-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a797c5b4f47so273849366b.2
        for <virtualization@lists.linux.dev>; Mon, 15 Jul 2024 02:03:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721034188; x=1721638988;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vO2Bb+eqfl0fxtX+QD6D/kijz/3TM4znnKK7Xsx8B7w=;
        b=gfU8GLVZFeCQoLkaRv2s0tuMdd3SjAL6DhlCS974D+mQmKrqW47R1wmHj7zzKaa6jr
         GAHH50OdvQWaHj4w+hQnRxMnhE0yVLKejsO/EXTG9fqolFqRWiXhXjmSSCS6yF/7w9mt
         2CFW2Mv/V3ldm+1dACEaY0ua7powfmQ9OqXMGGZ2WukYPuiy/BvlX5rwID6VSgQKtI6y
         6/846/0749ycNUPFepPxqYYyYp8mOEmMY3EmmoqOU7wzihSkm/QaDXep/QbbaVQnlfXj
         lIrhaNPKDuZwfx8cL1mRj5iEZBbl98VJpv/ebYGth3s32jGGH/G2AynQwRR7KLXbCxg/
         Cnmg==
X-Forwarded-Encrypted: i=1; AJvYcCUjDnZ9RWyQLrty9Wz+iuHRkcZGfHpPiBUDFdn3dXqcvOuOkK9eq5eSE18c9vd7K0rwtcwbicigLS/5zeOLB1mgnRvtNJQMr8T5cv1IBHA=
X-Gm-Message-State: AOJu0YzaeQE8OzAaXBSkMru6SGGMCTUxFWx0jfroo6eKxTzox2FmWQpr
	6EpWD+1cNiQPgW1BIB60A4vKlu/o7Ej2mfGmhoCsN5n8udgqab13zeFgoh6PEbRFCm13kyBDCyh
	7kCn4n4RyFzR6pbnFgxNmQkuADtjVKRrkHGwFM6RXhW4bBZwBg+rqynzkBWvVFnsJ
X-Received: by 2002:a17:906:d89:b0:a77:dcda:1fe1 with SMTP id a640c23a62f3a-a780b6b1ba2mr970344766b.25.1721034188367;
        Mon, 15 Jul 2024 02:03:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqZXlTl2DKuZCkgNKy50CImqdBaYrA/Bxg93I7LKOTfT1JLuU9I7zAbOlVg4MP1m7ZB48bSw==
X-Received: by 2002:a17:906:d89:b0:a77:dcda:1fe1 with SMTP id a640c23a62f3a-a780b6b1ba2mr970341466b.25.1721034186749;
        Mon, 15 Jul 2024 02:03:06 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:240:5146:27c:20a3:47d4:904])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680dabefa6sm5714732f8f.44.2024.07.15.02.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 02:03:06 -0700 (PDT)
Date: Mon, 15 Jul 2024 05:03:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Parav Pandit <parav@nvidia.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"eperezma@redhat.com" <eperezma@redhat.com>,
	Feng Liu <feliu@nvidia.com>,
	"hengqi@linux.alibaba.com" <hengqi@linux.alibaba.com>
Subject: Re: [PATCH virtio v2 10/13] virtio_pci_modern: create admin queue of
 queried size
Message-ID: <20240715045732-mutt-send-email-mst@kernel.org>
References: <20240710063601.2000149-1-jiri@resnulli.us>
 <20240710063601.2000149-11-jiri@resnulli.us>
 <20240714035231-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481152D9CF63DD6AA6611E8DCA02@PH0PR12MB5481.namprd12.prod.outlook.com>
 <ZpTWa5_9RWQCLCAY@nanopsycho.orion>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <ZpTWa5_9RWQCLCAY@nanopsycho.orion>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 15, 2024 at 09:57:31AM +0200, Jiri Pirko wrote:
> Sun, Jul 14, 2024 at 04:28:29PM CEST, parav@nvidia.com wrote:
> >
> >
> >> From: Michael S. Tsirkin <mst@redhat.com>
> >> Sent: Sunday, July 14, 2024 1:25 PM
> >> 
> >> On Wed, Jul 10, 2024 at 08:35:58AM +0200, Jiri Pirko wrote:
> >> > From: Jiri Pirko <jiri@nvidia.com>
> >> >
> >> > Don't limit the admin queue size to VIRTIO_AVQ_SGS_MAX and rather rely
> >> > on the queried queue size.
> >> >
> >> > Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> >> 
> >> I have some doubts about this one. Can't we limit the size to something
> >> sensible? E.g. max number of CPUs? Number of VFs? I don't see why we
> >> should just follow what device did blindly, the device has no idea about use
> >> so would tend to over-provision.
> >>
> >+1.
> >I agree with Michael, we can possibly do min(max_cpus, device_supplied_limit).
> >When more use cases of it arise, this can be improved in future to use larger limit.
> 
> Why max_cpus? How number of cpus is related here?
> 
> regarding max VFs is also value coming from the device,
> why is that better?

I mean the actual # of VFs enabled - that is provided by
software, right?

> For other queues, we also use number provided by the device. Why here
> the behaviour whould be different? Device should know what scale to
> prepare for, why to be smart here?

How can a plug-in device know how it will be used?
For many queues, more is generally better.
But yes, it is quite possible we could do better than
just follow hardware, we just don't have a better idea yet.


> 
> 
> > 
> >> > ---
> >> >  drivers/virtio/virtio_pci_modern.c | 3 +--
> >> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >> >
> >> > diff --git a/drivers/virtio/virtio_pci_modern.c
> >> > b/drivers/virtio/virtio_pci_modern.c
> >> > index 5ceb4b2c18df..a649c9dc436d 100644
> >> > --- a/drivers/virtio/virtio_pci_modern.c
> >> > +++ b/drivers/virtio/virtio_pci_modern.c
> >> > @@ -550,8 +550,7 @@ static struct virtqueue *setup_vq(struct
> >> virtio_pci_device *vp_dev,
> >> >  	if (index >= vp_modern_get_num_queues(mdev) && !is_avq)
> >> >  		return ERR_PTR(-EINVAL);
> >> >
> >> > -	num = is_avq ?
> >> > -		VIRTIO_AVQ_SGS_MAX : vp_modern_get_queue_size(mdev,
> >> index);
> >> > +	num = vp_modern_get_queue_size(mdev, index);
> >> >  	/* Check if queue is either not available or already active. */
> >> >  	if (!num || vp_modern_get_queue_enable(mdev, index))
> >> >  		return ERR_PTR(-ENOENT);
> >> > --
> >> > 2.45.2
> >

