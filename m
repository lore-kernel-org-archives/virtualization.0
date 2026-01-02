Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04C42D97A5
	for <virtualization@lists.linux.dev>; Fri,  2 Jan 2026 13:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767358968; cv=none; b=aIFEhts8t2GKxorLyHoZHlpih+tJnwufqR33hS1p9/3+6wfB8LptjxBgvwLpndjtL9UveL3ndk6Kf43YuTxTto8G/clir08h0FeRuIjXaIl3TxXiBVTOW5ANvcty/vunUgMjzpUV4wQ7VRpQpquAt5ZdXxNc3BMlmJStZFBdGBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767358968; c=relaxed/simple;
	bh=MzslOykd8x14UYRASjqMHG8WwlyrJUbVhQ0wOUaMEeA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=oQkzibUclESEPfOsn5GRH+LsD+w0XWWkgwW71Al8WaWFc0acvcLA8yuuZyTQNqvyAdTGwBQgBX2SKqruG5zLxZasOMWk1SvKhc6fl4Krm/pH0ep97vBVbjXlwAFWwTAk7DSUqac8jyRvyJ5lLeCyxd1DsbYqzDfV5FwJJIdCmkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g9S+/CyK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g9S+/CyK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767358965;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WmDmlKfsEAT3FFZsP/TiPm94jNR+IqB/SohCa4X10es=;
	b=g9S+/CyK1C6JJBWcQlwwzsZIwfK62SPGUZh7f5sbj77vHDL5uN8LOA36f43ptn1rw4ex14
	APaY+8v7XatQxmHpqtwe2Xz3CaZ2QPcjwItZ8DHf0xmW96SeB5iIZjtpiPn0WblNPiNOcS
	EFVvXgjHs5oR1+jFRo5nrAWeWBw8Nfk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-456-GDR0gh8mNoSEEoUnnXabtg-1; Fri, 02 Jan 2026 08:02:43 -0500
X-MC-Unique: GDR0gh8mNoSEEoUnnXabtg-1
X-Mimecast-MFC-AGG-ID: GDR0gh8mNoSEEoUnnXabtg_1767358963
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-47a97b719ccso71928495e9.2
        for <virtualization@lists.linux.dev>; Fri, 02 Jan 2026 05:02:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767358962; x=1767963762;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WmDmlKfsEAT3FFZsP/TiPm94jNR+IqB/SohCa4X10es=;
        b=YzOUa6sAdH8pOy0h14vj3cw2ejEPpnwEmQ4H/untwPmnYVBco+gTRHv0fCczKK9w2T
         9BbRLtthAwZid6FJU6IRaMhOxyCtFOY3P7LQvSpBfuBm6o75z91II0mX9tka6D3EAeQc
         hJftRNh3k3SK2giLjcxoqMUlIbtqG0CKHAm3DDrjbrg1nBWOMP4JTcmTTZf3h6eie0sf
         x7nS55+rxNGKGy5cT3zV8UA3JxkXD5m8jrG4ndjXg2PUV5rhfkHEaKd9pNuui/uJJ4pK
         B9iNgx1z88fVt9n3KoA/lsJvyU1oLos0vIlIebsUuYjmD/F07B0z+i0WjD1gTFaoiZjh
         5Lgw==
X-Forwarded-Encrypted: i=1; AJvYcCUzOTXYfG0mtZyino2MwhJxaxeC7iYSqMkp2wQokLHCoNHZ+TQdM4mjolw4BO+Dv3TfFhcG7NH9kUGVqcAAoQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxzMD+ICgTgOz6ORWzld5rZhy/9yAFo9aGr1zd8jYcyCufQ0mYu
	YEX5oLP/XDR3wVRXbXpMUhNdD3kNdFeTKdH8559cf/EnFAbHJs8M8/2UqGbLvKc2t487VhtYh/e
	TRi54d1xEBqKGolNJUBwI2nGX7DbOiE3MdwFC3MDaRW6hzFE+vXgh9jybKvpoEG7c8nrI
X-Gm-Gg: AY/fxX55PDJkoyXEQDreZNhuTPIpIqIn2P3p7ChQT/mgYYtSwS3b1pyqxlHtjDYQL+I
	ONVVE60jAlpYrXUl7rAUVNcWM1wIW/eFZ9uEP89KhlKYRzx+Xrl11SZ73sijQy5JLwMCio4ni2T
	O8rh2KZ0MAU5MHCU5iKgbTzM0bu03RnPAonspjCRl2erU2ZrXm0rLC2T0vpZo3qckb0NZN5rGcK
	W2X3/RWpaXfTI7FRJHm56PqolRXfL2JbLWnY8QPoL7MKXE9E6QMdxOa57pXpWaWg/ZJPNxNz139
	mqCunuCvZquG0cB0eYFVf8mD41dPI6/BoJ8MzOMsZ17TD8Rtlgk9j5eJPcOp0jXxs4VWzWlOopf
	lajdhNcTYUP/uEKYl1J86f420Qs+NIkemKA==
X-Received: by 2002:a05:600c:3508:b0:477:1bb6:17de with SMTP id 5b1f17b1804b1-47d19590bbemr512375225e9.30.1767358962191;
        Fri, 02 Jan 2026 05:02:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFBPpH0ihQmD8Y4wAGqUXdjbUDmUwQhrGC4bvR7Khhg9b0D8Nv1fILL/X18iGX7aRdaW+Lc0w==
X-Received: by 2002:a05:600c:3508:b0:477:1bb6:17de with SMTP id 5b1f17b1804b1-47d19590bbemr512374585e9.30.1767358961687;
        Fri, 02 Jan 2026 05:02:41 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d193d4e91sm720685835e9.13.2026.01.02.05.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 05:02:40 -0800 (PST)
Date: Fri, 2 Jan 2026 08:02:36 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-kernel@vger.kernel.org, Cong Wang <xiyou.wangcong@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Olivia Mackall <olivia@selenic.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Jason Wang <jasowang@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Petr Tesarik <ptesarik@suse.com>,
	Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-doc@vger.kernel.org, linux-crypto@vger.kernel.org,
	virtualization@lists.linux.dev, linux-scsi@vger.kernel.org,
	iommu@lists.linux.dev, kvm@vger.kernel.org, netdev@vger.kernel.org,
	"Enrico Weigelt, metux IT consult" <info@metux.net>,
	Viresh Kumar <vireshk@kernel.org>,
	Linus Walleij <linusw@kernel.org>, linux-gpio@vger.kernel.org
Subject: Re: [PATCH RFC 15/13] gpio: virtio: reorder fields to reduce struct
 padding
Message-ID: <20260102080135-mutt-send-email-mst@kernel.org>
References: <cover.1767089672.git.mst@redhat.com>
 <55e9351282f530e2302e11497c6339c4a2e74471.1767112757.git.mst@redhat.com>
 <CAMRc=MfWX5CZ6GL0ph1g-KupBS3gaztk=VxTnfC1QwUvQmuZrg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CAMRc=MfWX5CZ6GL0ph1g-KupBS3gaztk=VxTnfC1QwUvQmuZrg@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0Y_vWtDakkyLqUk6qh2sv1UMikPzEoIaecpdR1sU07A_1767358963
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 02, 2026 at 12:47:04PM +0000, Bartosz Golaszewski wrote:
> On Tue, 30 Dec 2025 17:40:33 +0100, "Michael S. Tsirkin" <mst@redhat.com> said:
> > Reorder struct virtio_gpio_line fields to place the DMA buffers (req/res)
> > last. This eliminates the need for __dma_from_device_aligned_end padding
> > after the DMA buffer, since struct tail padding naturally protects it,
> > making the struct a bit smaller.
> >
> > Size reduction estimation when ARCH_DMA_MINALIGN=128:
> > - request is 8 bytes
> > - response is 2 bytes
> > - removing _end saves up to 128-6=122 bytes padding to align rxlen field
> >
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  drivers/gpio/gpio-virtio.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpio/gpio-virtio.c b/drivers/gpio/gpio-virtio.c
> > index 32b578b46df8..8b30a94e4625 100644
> > --- a/drivers/gpio/gpio-virtio.c
> > +++ b/drivers/gpio/gpio-virtio.c
> > @@ -26,12 +26,11 @@ struct virtio_gpio_line {
> >  	struct mutex lock; /* Protects line operation */
> >  	struct completion completion;
> >
> > +	unsigned int rxlen;
> > +
> >  	__dma_from_device_aligned_begin
> >  	struct virtio_gpio_request req;
> >  	struct virtio_gpio_response res;
> > -
> > -	__dma_from_device_aligned_end
> > -	unsigned int rxlen;
> >  };
> >
> >  struct vgpio_irq_line {
> > --
> > MST
> >
> >
> 
> Acked-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

Thanks! There's a new API as suggested by Petr so these patches got changed,
but the same idea. Do you want me to carry your ack or you prefer to
re-review?

-- 
MST

