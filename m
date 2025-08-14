Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D122264CF
	for <virtualization@lists.linux.dev>; Thu, 14 Aug 2025 10:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755168143; cv=none; b=qU4kmL8uPWT5Db7por5MS9L23PJ2o0jXMn9/VOVIcrDitos1v+qF02C0Isvd+A9Erhoa69Q7fImN+eago8pwsKw2Rj47/EtABfpkv7HMLKCooKNNXaUowTA3L+8DvIA3il9qk8fb9oY4nwu4UeapQnWaDhNjDsMmYBgZZE3fk3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755168143; c=relaxed/simple;
	bh=NZEGr2QeyUxRWwugsIcQDl4cNFKSjIiz0H7NjY0LWuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=OZe2XSi95AtsiCaZ1dIt8rUAaW7xCdeJdzc4KiiwyxA9S28pzJz1AcdQwZlL3cG2HFPomuh2A9+hG9LTT6qnNRSa+nYWwjcQm7a/0wNnRqcuNRfN7czHsGwIXxmqmqxdxwaXOk9rAVLJG0EMmsm2N9xIk4XBj6OPAqfgIk2Q6uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SnfDEpGL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SnfDEpGL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755168141;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KT5Tzn19cqg4hmQfGcslJH9hMAr6Q0PLi1IKh5xD2zI=;
	b=SnfDEpGLVBDJsjYue/B6E/omYAluQ43nu0PIrKQuL06NqVcbOVakN4WmhnMG3pBvA6g6kh
	ghE2P+2peRcXvD2e1JE5kGTgOy2GXnQbILuAkGXS5mrqV6azb26IYNrtrrzAf2w37uEZ9e
	im5/Wzwv4YRY194ckeNt2vWCmQM3L6Y=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-272-_ALoZjX-MIO4q47GaIGlPw-1; Thu, 14 Aug 2025 06:42:19 -0400
X-MC-Unique: _ALoZjX-MIO4q47GaIGlPw-1
X-Mimecast-MFC-AGG-ID: _ALoZjX-MIO4q47GaIGlPw_1755168139
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3b9d41b779aso464120f8f.0
        for <virtualization@lists.linux.dev>; Thu, 14 Aug 2025 03:42:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755168138; x=1755772938;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KT5Tzn19cqg4hmQfGcslJH9hMAr6Q0PLi1IKh5xD2zI=;
        b=JfOT/QSl4Nk7gGDyvauXeVct2t0si53qEMlZPrAWVoyYTvb8xdji66ejg8MBNu0VW3
         qcnlPM1XXFV7jZhXC1DKKNhs6H8Mr4Y87UK04pbZozOvsKYVRPmZVeatBWuSSXyt5lV+
         RFf1ZX3ggzCIgG4WKRmJY76wtczYrmwvgWZAx5dQHTijOKnQluBZZ0434WeSpapGttDl
         f9e8nfFwvNL5CQpSsqN+4l6rxbmnfnFT6R472L5zZYl5dToFEFyxhNvtFO+AM/tqlKno
         a51zynBgGAnbRjFacV/MaZY72v9QQAOVKk2Bp3m8dqrXeBUtz4nrUM3eGHSQsCMpXZVW
         zQ3g==
X-Forwarded-Encrypted: i=1; AJvYcCVLAD8RosB362EzYTNbb51LrfPEJnRLM9Yy8HGf2WwaJL2za/uSwZnaKbBkQXgco/pEtBkVET440q3UcXwIlA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwQBlKHynTA3LmeOFevwKpD8ZUggwtkTaddVU+FohVNj1uTZYLB
	dqAMmqSbCE6Cc4v+h2GstaETn4CC7i7BHxU5qunJPHcZvN6J0CosrB9aJnsgBus3zm3LUjlFaTE
	rch9LrgeSn33JQRXjx91PZ1yLGXFhbh2qXNhyTdCSi2YcqU2xVoc7Qe5LWn3YTm/4Ww00
X-Gm-Gg: ASbGnctZUKseCC9rW7cQT4pBYg8XsT80YYQKRmHH7oI3foaO0VaSKiDHiM1/Dp4sEvp
	mfHFTWHOUvltNMWwDWoQOT/Ji0drQ9ruELnZrLwP6OYNF9fp3KBWnZDZHjfdYd3akUui/43pqEF
	rVi29usbef2Y94sVe7ImjJnHE9kLuCI5FEnrXFxrBMN3Ce1J9XGfQFhief6dxSv22ru4h5zzIY4
	PSiVGzpzV/Az+ajbMZrvJ9IvYiw8VmVdx7tGxtSNu+4h0Fr4ZtQRgugySm+lnNHwMO1ZRi7Rzo3
	QFGDvNg2ILSPzWHbDMKyWCZDHSHa9W8vAkY=
X-Received: by 2002:a05:600c:a06:b0:456:1d61:b0f2 with SMTP id 5b1f17b1804b1-45a1b687253mr23970615e9.30.1755168138567;
        Thu, 14 Aug 2025 03:42:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9mCEyeVUFOpZlzFS33KyQN6euUVxnMFYMC8qwFmmhan4Sd4sDTaAq8nOK27r6IHm2BnFDpw==
X-Received: by 2002:a05:600c:a06:b0:456:1d61:b0f2 with SMTP id 5b1f17b1804b1-45a1b687253mr23970315e9.30.1755168138131;
        Thu, 14 Aug 2025 03:42:18 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73d6:5500:f926:f5f2:d44c:9bbf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1c6cf151sm16626985e9.8.2025.08.14.03.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 03:42:17 -0700 (PDT)
Date: Thu, 14 Aug 2025 06:42:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	hch@infradead.org
Subject: Re: [PATCH V5 4/9] virtio: introduce vring_mapping_token
Message-ID: <20250814063927-mutt-send-email-mst@kernel.org>
References: <20250813054831.25865-1-jasowang@redhat.com>
 <20250813054831.25865-5-jasowang@redhat.com>
 <20250813043151-mutt-send-email-mst@kernel.org>
 <CACGkMEuKmn4f9spFT1YxjVPxBFkdGVCTQEUpNG=xHd6hcL-a8w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CACGkMEuKmn4f9spFT1YxjVPxBFkdGVCTQEUpNG=xHd6hcL-a8w@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _q4Q5MVXqIQXHEJYUdLMH4jVWMNXo-KuX-RNlj6qZOg_1755168139
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 14, 2025 at 11:36:22AM +0800, Jason Wang wrote:
> > > diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> > > index addbc209275a..37029df94aaf 100644
> > > --- a/include/linux/virtio.h
> > > +++ b/include/linux/virtio.h
> > > @@ -40,6 +40,13 @@ struct virtqueue {
> > >       void *priv;
> > >  };
> > >
> > > +union vring_mapping_token {
> > > +     /* Device that performs DMA */
> > > +     struct device *dma_dev;
> > > +     /* Transport specific token used for doing map */
> > > +     void *opaque;
> >
> > Please just declare whatever structure you want it to be.
> 
> It's an opaque one and so
> 
> 1) the virtio core knows nothing about that because it could be
> transport or device specific
> 2) no assumption of the type and usage, it just receive it from the
> transport and pass it back when doing the mapping
> 
> It should work like page->private etc.
> 
> Does this make sense?
> 
> Thanks

I fully expect most devices simply to use DMA here and no weird
tricks. vduse is the weird one, but I don't see us making it
grow much beyond that.

So I think for now we can just make it vduse_iova_domain *. If we see
it's getting out of hand with too many types, we can think of solutions.

-- 
MST

