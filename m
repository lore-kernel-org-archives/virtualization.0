Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE47628
	for <virtualization@lists.linux.dev>; Thu, 20 Jun 2024 09:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718874879; cv=none; b=EGdRByUChgrpdMuZaZDqLPS1+sWlBcmIN7E2PJF79eP8iYpWgQ7+aP8XVJZt6qI9eG1DfkyZ2y0pgpJ2dbDGNtWzX7IhTF3xkFyWyQuZHs5g/McIEi7C5/YYh5g+3eAAGZMVrpnPXF6oMwQA1cCm+5df20isw9IS4jV+zHIBSbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718874879; c=relaxed/simple;
	bh=AblgfDKsQmxG/rhwuU9LnaVafDArI7B9+bO2yRkgtrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=uuLgAqMMitbtVG34ZVRYY010zW1q5xv+fAZCqgPoaULYrXNuqslRYj9okFrJ3AGyddSfnjanqZm33T9cOE9Xpu7KXtAx9doyi35jviomLobIq6lU96oZugm2LQZuVNFqdQWoiKXpVC7EPM5eBtgSpfZcMFsGXLsXUdSOCRqTSJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PdFtzHhF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PdFtzHhF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718874876;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7n/q6GHKkD/zFmXGYbmYPlaDuYuUj7aK/70/tkj3IdI=;
	b=PdFtzHhF02CNBCZCiNHjKgAsLwGlc1oXsiqPtdAqXh9/8eyWsd5MgkHU8n2KaIe1HWt69+
	5c6Im1aEvZ61kbP/nkjAobSk2ZbEtFs2ZQ194ceRM4fvDOcLojwBV5Lu5od2qzU8fT9xoU
	lf/RZiknU+YvRv9CsUKtNxI+WtyhH4s=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-25-Sz5P7kygNZCJ8eiRaixL_w-1; Thu, 20 Jun 2024 05:14:32 -0400
X-MC-Unique: Sz5P7kygNZCJ8eiRaixL_w-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a6f2af30793so26932766b.2
        for <virtualization@lists.linux.dev>; Thu, 20 Jun 2024 02:14:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718874871; x=1719479671;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7n/q6GHKkD/zFmXGYbmYPlaDuYuUj7aK/70/tkj3IdI=;
        b=Wv0M+49PE5YsIf8o3Xvi7NP4lZVDUYpy/GFLuPJabsAJDPFAMqvpnX4A9G+0dFZQLE
         NfqyCZkaaxr1Nsj7TGI56n1ioEBEKyw5zKcB5bk/hwV7kzGeQ/o1xa8nhrMjY6HZrVm+
         tGvdbO3h1aBBuOyxbMQKwSXM5RxlPZAEWsEGcDfjNMYihFpUgfpj8H9DDspEmL+jrSCP
         9vmlW32KGpwBjXpOlLec460jxlEGYJABpdpm91UlB7GyYeSfC72FPPTt/4mqchtstPJe
         YVcz6APEifdP5rRUdxDpONHQxQ+WTdOlvLBFGyEoVLwEcEfHfLoVhLD9jga12ud4bgWe
         Vp4g==
X-Gm-Message-State: AOJu0YxJ4zijmcUfusumJdO4UU8NI2DsGDIJHgqi2JTsytO+yMdpwgsZ
	WYSJTA1UzByrB+ufRO13+dC3lTTKJwNbeT+cYDa/F55KVUgSGRj6SAp9I//ZWsJyfwKY2/BxInu
	mgeCV8CGCh86pGAkmyRO7g8Z4BWOnOSIwG30eL+jfPm3+WDNbVdky2FSdGe5QypU9
X-Received: by 2002:a17:907:a581:b0:a6f:af4f:ff82 with SMTP id a640c23a62f3a-a6faf500049mr334400366b.25.1718874871294;
        Thu, 20 Jun 2024 02:14:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxdf7P1AFITZr2DVkTfIKfl2IcVnjVg8p04jUd8bO23ArK3RuJSM+iwOfOkWQb1H37WeNIsA==
X-Received: by 2002:a17:907:a581:b0:a6f:af4f:ff82 with SMTP id a640c23a62f3a-a6faf500049mr334396566b.25.1718874870708;
        Thu, 20 Jun 2024 02:14:30 -0700 (PDT)
Received: from redhat.com ([2.52.146.100])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56da3fe5sm759661166b.18.2024.06.20.02.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 02:14:30 -0700 (PDT)
Date: Thu, 20 Jun 2024 05:14:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Vadim Pasternak <vadimp@nvidia.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Cornelia Huck <cohuck@redhat.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Eric Farman <farman@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	David Hildenbrand <david@redhat.com>,
	Jason Wang <jasowang@redhat.com>, linux-um@lists.infradead.org,
	platform-driver-x86@vger.kernel.org,
	linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org,
	kvm@vger.kernel.org
Subject: Re: [PATCH vhost v9 3/6] virtio: find_vqs: pass struct instead of
 multi parameters
Message-ID: <20240620050545-mutt-send-email-mst@kernel.org>
References: <20240424091533.86949-1-xuanzhuo@linux.alibaba.com>
 <20240424091533.86949-4-xuanzhuo@linux.alibaba.com>
 <20240620034823-mutt-send-email-mst@kernel.org>
 <1718874049.457552-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <1718874049.457552-1-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 20, 2024 at 05:00:49PM +0800, Xuan Zhuo wrote:
> > > @@ -226,21 +248,37 @@ struct virtqueue *virtio_find_single_vq(struct virtio_device *vdev,
> > >
> > >  static inline
> > >  int virtio_find_vqs(struct virtio_device *vdev, unsigned nvqs,
> > > -			struct virtqueue *vqs[], vq_callback_t *callbacks[],
> > > -			const char * const names[],
> > > -			struct irq_affinity *desc)
> > > +		    struct virtqueue *vqs[], vq_callback_t *callbacks[],
> > > +		    const char * const names[],
> > > +		    struct irq_affinity *desc)
> > >  {
> > > -	return vdev->config->find_vqs(vdev, nvqs, vqs, callbacks, names, NULL, desc);
> > > +	struct virtio_vq_config cfg = {};
> > > +
> > > +	cfg.nvqs = nvqs;
> > > +	cfg.vqs = vqs;
> > > +	cfg.callbacks = callbacks;
> > > +	cfg.names = (const char **)names;
> >
> >
> > Casting const away? Not safe.
> 
> 
> 
> Because the vp_modern_create_avq() use the "const char *names[]",
> and the virtio_uml.c changes the name in the subsequent commit, so
> change the "names" inside the virtio_vq_config from "const char *const
> *names" to "const char **names".

I'm not sure I understand which commit you mean,
and this kind of change needs to be documented, but it does not matter.
Don't cast away const.

-- 
MST

