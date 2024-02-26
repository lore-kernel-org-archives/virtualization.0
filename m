Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457855A7BC
	for <virtualization@lists.linux.dev>; Mon, 26 Feb 2024 11:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708948652; cv=none; b=TUvn/+nUCxmsW73QBPuvcWoYisTZk9OQ8YMpafyRNA7K7zTkEzNpJljEG0gG0oe99A8vbTYhMYeOntxWV2qm5Am7C8C7TBHIykN9P2OH6CDVxIuRsMhDQ6XF4y2iZNJZtiA73+w6NeGHGRtNYgzD3nO1tzyxKiE8cdfq6rNP02E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708948652; c=relaxed/simple;
	bh=Foucft6WlPR2KyfAnFENVyW3MER3G1QZvKQCjZkxl/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=mcBjpfVAiLKAwPpubqFGEOFHdieIHrV+Lpdk8vJ4xPAcR8EZjw9NtOpe9JVLd/xPgUh6dm6qzb5//SU7wDFbLXRTyFKK5Xyw5JIVk6ebeGA2spLXLUMlh8riDgvEoG25mRKMntaRLKYSqQV16Ad+CDy2xcLtvSMiIoIkEgEszyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=blRy128n; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="blRy128n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708948649;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MwTMNcm/OZxGXy6MTFKOugn5j6dLDR0+J9PuYt4fDWs=;
	b=blRy128nYHLdCZxG4jJoUa2ap2DEJ6w2mvf0PskQEkf6Zw2TlcFEzqM7dP9X1U5OMU7GwK
	ZJnc6kKoSMz5YJTmRmZ3XVoSiMlQyyEWh4xCEYFR1ApoxaN3LzloGzCNfnMFRgT9XXkU4i
	v/WcEsT+KkkxIxB38XQb/bDmLt6d99o=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-mwladD-uPp6onfRMCBeV9g-1; Mon, 26 Feb 2024 06:57:28 -0500
X-MC-Unique: mwladD-uPp6onfRMCBeV9g-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-512aa50323cso3278902e87.0
        for <virtualization@lists.linux.dev>; Mon, 26 Feb 2024 03:57:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708948646; x=1709553446;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MwTMNcm/OZxGXy6MTFKOugn5j6dLDR0+J9PuYt4fDWs=;
        b=RIwVAM8+VrVTwdrPLiS/l4i2Fv/wChJwE69Tf78wihFwNG6LbRASApcpQEx4V+tLEK
         SzrZSni2zNzZB5qZXxFn+nDocAV/HGBFzs8lr3CXys4CSJSpVOZ0frHo3MLJmJa65aSK
         cfGKc91iBr5PA4e8x/7y4BYub1v97L6ObIZeoQ6/lcIk5ETLSPumMlCTa1kUfFpL9Gsf
         B+TEdKGl/e+2CjNdmW3wzhO0u8JObKhOt7f/ong3woQUvfgnhV2WooInSz/hXDSoba7W
         jrTxo8Pzi8WgglJ/1z7ZumNmsyTB1QeKt0CrIFHhzBNamN4gWI+xRxY7P1k88OezcOxp
         MoLQ==
X-Gm-Message-State: AOJu0Yy/39VANBfxjdQWfR08JCBamgCNQRaUf7aBrCzgUzDQBKa+t6zr
	Wt4rOGSytNwJCWesOXGSpUWD7x+1m9tqOVeYbpChTzmSd+gUuRXAz9F+zs+XzMTsA6XoGAwxZZN
	EZuFpw3jZ9QzIDhIFS3gD/aWBzXuNv8vjUuSNDdvrTyeTKXamExnn7f3wD3P4k0D9
X-Received: by 2002:a05:6512:2206:b0:512:fbb0:3c55 with SMTP id h6-20020a056512220600b00512fbb03c55mr2652528lfu.17.1708948646546;
        Mon, 26 Feb 2024 03:57:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGhlB+sQrxdk/wnezoDvCnQO/+FHCrT1btYEeq6+bycpFpncFqBUrdfh9u7XJ++FrnKpKlBAA==
X-Received: by 2002:a05:6512:2206:b0:512:fbb0:3c55 with SMTP id h6-20020a056512220600b00512fbb03c55mr2652497lfu.17.1708948646157;
        Mon, 26 Feb 2024 03:57:26 -0800 (PST)
Received: from redhat.com ([109.253.193.52])
        by smtp.gmail.com with ESMTPSA id z9-20020a05600c114900b004128fa77216sm11737552wmz.1.2024.02.26.03.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 03:57:25 -0800 (PST)
Date: Mon, 26 Feb 2024 06:57:17 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
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
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	linux-um@lists.infradead.org, netdev@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org,
	kvm@vger.kernel.org, bpf@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH vhost v2 19/19] virtio_net: sq support premapped mode
Message-ID: <20240226065709-mutt-send-email-mst@kernel.org>
References: <20240223082726.52915-1-xuanzhuo@linux.alibaba.com>
 <20240223082726.52915-20-xuanzhuo@linux.alibaba.com>
 <20240225032330-mutt-send-email-mst@kernel.org>
 <1708946440.799724-1-xuanzhuo@linux.alibaba.com>
 <20240226063120-mutt-send-email-mst@kernel.org>
 <1708947209.1148863-1-xuanzhuo@linux.alibaba.com>
 <20240226063532-mutt-send-email-mst@kernel.org>
 <1708947549.7906592-2-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <1708947549.7906592-2-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 26, 2024 at 07:39:09PM +0800, Xuan Zhuo wrote:
> On Mon, 26 Feb 2024 06:36:53 -0500, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > On Mon, Feb 26, 2024 at 07:33:29PM +0800, Xuan Zhuo wrote:
> > > > what is dma_map_direct? can't find it in the tree.
> > >
> > > YES.
> > >
> > >
> > > diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
> > > index 58db8fd70471..5a8f7a927aa1 100644
> > > --- a/kernel/dma/mapping.c
> > > +++ b/kernel/dma/mapping.c
> > > @@ -144,6 +144,18 @@ static inline bool dma_map_direct(struct device *dev,
> > >         return dma_go_direct(dev, *dev->dma_mask, ops);
> > >  }
> > >
> > > +bool dma_is_direct(struct device *dev)
> > > +{
> > > +       if (!dma_map_direct(dev, ops))
> > > +               return false;
> > > +
> > > +       if (is_swiotlb_force_bounce(dev))
> > > +               return false;
> > > +
> > > +       return true;
> > > +}
> > > +EXPORT_SYMBOL(dma_unmap_page_attrs);
> > > +
> > >
> > > Thanks.
> >
> >
> > where is it? linux-next?
> 
> 
> I see it in the vhost branch kernel/dma/mapping.c.
> 
> Maybe you miss it.
> 
> Thanks.
> 

which hash?

> >
> > --
> > MST
> >

