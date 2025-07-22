Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878DD27EC99
	for <virtualization@lists.linux.dev>; Tue, 22 Jul 2025 17:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753205211; cv=none; b=aaHrk9vO9gnlRoPYWUj3CnJYEYOtZr6sCKUWBWZFgMFqqHI7Ca2Bc0faU6uLqEa6ojlsjWxYHcn5snwqGwIq9FeQDzzeODQxXtIo/0+w93jH4sLiAA4axJ/GgTz40I+DF6536JQJzUA3BUBn2eXCFxtjl6uu/25FCY0dMKAFSfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753205211; c=relaxed/simple;
	bh=c5xfm6OYNiVwbzNBet3aZZZZdKaKwvkqUSGPp2GJVv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ojPdg+6KEsXZupBDP6rvjMsy0BJ2vZ6tieda5x6NgZHSWY5+zIT4Id1rFAhwCs6Oz18aEUysLqkAkqQjqhaXvx8iwmyUZW3/ILLVuQf2USvloOEwBZemeKi/tSDmKZ3OHUQr5Ft6st5y/gLm7Sy9gnA4L9vqk80gZaqMIpKCe9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XT2VtKav; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XT2VtKav"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753205208;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=335W5XPGAY+ZXGhtj/TuWMIOn7SjBZFQRs8M/rKwXEA=;
	b=XT2VtKavu0HYC9W06FYkqGPb/Gd9WlnaYGhKPrBNLdt9wHT9lbgK9o8CArDS+Dyz+3JyGv
	iHTTSEF8w4ooRQxkgafJMm9Y3lATu2UBfF7A4QwJtA2HJL3ZCMNIlo+VJYF4NcXDyC7C2t
	SMATbmY2ZzyMlf81qkGwesT94g8h+gQ=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-208-kmD5Xy-HPrGx4WxG5I4I2A-1; Tue, 22 Jul 2025 13:26:45 -0400
X-MC-Unique: kmD5Xy-HPrGx4WxG5I4I2A-1
X-Mimecast-MFC-AGG-ID: kmD5Xy-HPrGx4WxG5I4I2A_1753205204
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-606b62ce2d4so5691072a12.3
        for <virtualization@lists.linux.dev>; Tue, 22 Jul 2025 10:26:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753205203; x=1753810003;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=335W5XPGAY+ZXGhtj/TuWMIOn7SjBZFQRs8M/rKwXEA=;
        b=KNI/7mRGnHmDTbrmpbz5my/9E8UZpjH+XE6acMI9CnZPWMwR4/yv8F/LUsszauHCZz
         7l4Hc3ao/04Y7X5lgkTa8QjWt+TNQl6c27niSA/nQnBIcdlg5CI0W+G7yeTgAAh3H7Mo
         rbxxHpckVI749NdMDsWu73PkGPvwrX2cac0RvK4Y46bhsKVxfOXxRKUuviugW/kAYJfV
         n+6w/h0kusWHiiKNgfyWcKJAKcsQClRBkhPHyooliYR8qPRdg5GxTYcbkVfsmkrUAISN
         wZZY8ndHqSOGJeUBwc32+xFENo0rXJIb8naniBZ49yqetc8etSULhliBoHfJAXmP+c87
         s8Ew==
X-Forwarded-Encrypted: i=1; AJvYcCU5LlKgNVf+qq3v5KJ9j9PWOdyWwo+iLb7sgYubK4jEESVKl+uPvQ6UqqNL/KtRtY/y2jWhvVBPBqHqbhZa3g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy44B4nj8mR0aYWbyzJ8GDA4lAC+CMWF3MMtDZ8iRu5FsEiCxQ2
	Jq8KWBfMIrgj6UsnJefz3GenktT/aYxgt9c/Znirec+WzgzeyAJcykrmXGxrMbBWK+pKTKZfnvJ
	s1bfzOwHvEKEvGNllW9XhjcMoFrZRRH1v39fItKOjyHTw8U9y0N0lLeKkqtFNK1WzO8VJ
X-Gm-Gg: ASbGncujwyrRixrRWVf0pX1eltQ2guyoshzpscIq5PwNtl56urSFgZPUA19CROwpEnd
	dicuM+X8YwE/NumYjEBpJ2lZorOAEZjP+gGRJuOQ8a1kjWSNzrQ7fKMKO8K1JDaZy1dnPDnaOdI
	UoA0UXQgAAMpYzWBdQCiKPMa0wtFUesbJ0U5sBOdN5KYfM7qXHHrl3qQTrdECijMdik4MkLpoke
	94CgMfecTyIqZBGyj2Cbl9Y3AGBEPje1wrHLmK6mmh6K9mxHGfEfDEiAVU8Toh5a7j7qvd47uqd
	xfnI6mvKMZQOh+eOuJ/BfAnLZ2U4HA==
X-Received: by 2002:a05:6402:2693:b0:614:9567:4c98 with SMTP id 4fb4d7f45d1cf-61495674e36mr485124a12.5.1753205203502;
        Tue, 22 Jul 2025 10:26:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6ystqhDq9xjk78cU+H/eYTHS9qSMHNACY1JGEIqeoIofNDZac9pWTRqDGeQLtVAjbkFhhBA==
X-Received: by 2002:a05:6402:2693:b0:614:9567:4c98 with SMTP id 4fb4d7f45d1cf-61495674e36mr485106a12.5.1753205203008;
        Tue, 22 Jul 2025 10:26:43 -0700 (PDT)
Received: from redhat.com ([31.187.78.147])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61353336972sm1029021a12.48.2025.07.22.10.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 10:26:42 -0700 (PDT)
Date: Tue, 22 Jul 2025 13:26:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, hch@infradead.org,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V4 7/9] vdpa: rename dma_dev to map_token
Message-ID: <20250722131746-mutt-send-email-mst@kernel.org>
References: <20250718091616.6140-1-jasowang@redhat.com>
 <20250718091616.6140-8-jasowang@redhat.com>
 <20250718053156-mutt-send-email-mst@kernel.org>
 <CACGkMEue4Wh3ocM2Pmn5E_nMzjHkJqd-MhYbPDY9pXdwMtqgXQ@mail.gmail.com>
 <CACGkMEtxWrrq-9bW0w4eVyRbXra94oM-fEfPJOeWAOcNZVrjjw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CACGkMEtxWrrq-9bW0w4eVyRbXra94oM-fEfPJOeWAOcNZVrjjw@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 1e_GJXP8HsLzB8fO39YGzvLBEaA8Py8HBL2tP-pOL2c_1753205204
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, Jul 21, 2025 at 04:05:17PM +0800, Jason Wang wrote:
> On Fri, Jul 18, 2025 at 6:09 PM Jason Wang <jasowang@redhat.com> wrote:
> >
> > On Fri, Jul 18, 2025 at 5:37 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > On Fri, Jul 18, 2025 at 05:16:14PM +0800, Jason Wang wrote:
> > > > Virtio core switches from DMA device to mapping token, let's do that
> > > > as well for vDPA.
> > >
> > > Pls switch to imperative mood.
> > >
> > > And add explanation about what is going on and why please.
> >
> > I think this has been explained in patch [PATCH V4 6/9] virtio:
> > introduce map ops in virtio core?
> >
> > """
> > For the device or transport that doesn't do DMA,
> > they can implement their own mapping logic without the need to trick
> > DMA core. In this case the map_token is opaque to the virtio core that
> > will be passed back to the transport or device specific map
> > operations. For other devices, DMA API will still be used, so map
> > token will still be the dma device to minimize the changeset and
> > performance impact.
> > """
> >
> > >
> > > At least, document what are the actual types stored here.
> >
> > It is opaque to the virtio core and will be used as a token to be
> > passed back when the virtio core wants to map/unmap a buffer. So it
> > doesn't have a type.
> >
> > > I checked and it looks like vduse actually returns struct device * here, too?
> >
> > It's just a token, vduse can return anything that can be used to
> > identify an iova domain. For example, it can return a pointer to
> > iova_domain which will also work. If you prefer to use iova domain, I
> > can change to use that in the next version.
> >
> > > So why do we need this, why lose all type safety?
> >
> > If you worry about the case that assumes map_token as dma device in
> > virtio core. I can keep both map_token and dma_device and make the
> > mutually exclusive, then:
> >
> > - when transport reports dma device, use DMA API
> > - when transport reports map token, use map ops
> >
> > Does this work for you?
> 
> This seems to result in a lot of unnecessary code. I wonder if the
> following would work:
> 
> Just document the requirement in vring_create_virtqueue_map, say
> something like when a virtio device doesn't have a map operation,
> map_token must be a pointer to struct device.
> 
> Please give me some advice so I can work on a new version..
> 
> Thanks
> 
> >
> > Thanks


How about something like this?

typedef union {
	struct device *dma_dev;
	struct vduse_iova_domain *iova_domain;
	void *ptr;
} virtio_dma_dev_t;



Now, just pass this around.
You can also add an enum with the pointer:

typedef struct {
	union {
		struct device *dma_dev;
		struct vduse_iova_domain *iova_domain;
		void *ptr;
	};
	enum {
		VIRTIO_DMA,
		VIRTIO_IOVA
	} type;
} virtio_dma_dev_t;

(possibly only on debug builds, if you find it's costly?)

This allows encapsulation and asserts that the type is right.


-- 
MST

