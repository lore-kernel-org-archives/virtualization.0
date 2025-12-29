Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBD921D3CD
	for <virtualization@lists.linux.dev>; Mon, 29 Dec 2025 15:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767023250; cv=none; b=syuEyqlCN0kCLa42vXfeAD87yRVu3hS8Aq6bLZ/CZcayHR4yMUeltNLDqDlJjtF2FhYG9zLKpegz5t0/pKvubNGqqIuu5sp5bdyj6JpEDwiqtQzQWYp8ruoE22zXpMUd2F+j8Y4lHE0Pr4nd9BEghN5sRLLX6kPIC4Af9Ayc7Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767023250; c=relaxed/simple;
	bh=mhCgMyPpA6PN3yVOHuOdBSAHQLvFlmqczKLfLDwflf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=CZeMdcB/U+H7WZ8ZRWqgFxfcOhgQ24ua2QV+9c+vvgzkqqVzSdhkxtv8IVsfM71bS3epI4a7y3+RuXRNmVM/PWKihFsGD++8hHEeQkVq4XEvi9HsKwY6B/MWTrAheXH8zJOyFwJgDcheeetsABFso6FXZ98Cqh3tw817GIWJZvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LUV9ZpGV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LUV9ZpGV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767023247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5cnHluyd0CLs9rtZivbBUXRafIxh4RF5VK55fRt2P2g=;
	b=LUV9ZpGVEPkmHORXnFSBR0rDgV3KeTzXBHmPgs9U4dN9K28Mn4jInrQOikPXTPuM5wKx1Q
	OkHQRVpKuwp5uixzEsHWbWG2kwj9GWJbvNy0VhET5/UQhxUHwQk+b8wA/jBHE2SaxTeXju
	ZvGVIzzA+jOkMkYUGPgT0kdnCqWp+bw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-189-Nl_gCm3lMF-a7rDXHgDSEg-1; Mon, 29 Dec 2025 10:47:25 -0500
X-MC-Unique: Nl_gCm3lMF-a7rDXHgDSEg-1
X-Mimecast-MFC-AGG-ID: Nl_gCm3lMF-a7rDXHgDSEg_1767023244
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-4325ddc5babso3445802f8f.0
        for <virtualization@lists.linux.dev>; Mon, 29 Dec 2025 07:47:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767023244; x=1767628044;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5cnHluyd0CLs9rtZivbBUXRafIxh4RF5VK55fRt2P2g=;
        b=PMcDy7wxclnuIgfEFSX0H6FLJXEm3X6eVWIYu+npqWCQS2VoUrrr11en2LfyFPjzPH
         HCBEiPkv4QAQA6AWNfpBcB5SdJFP6bJx4YvkVq058+Q+Ts0Klu7YZJQXCUfHxFZ6S8fj
         FTQ0dTsGq1mxI9xdet8AzugiBBZRZxvYD2YoeN7gsNBi55y6ACH8Z0sEneWnT4UceFLR
         3Dmfae6EcwiTx4mhD7QSE3eNdYtcmGuuXv8yQPL2bs6mn/3Rxdp/GWohV0LDo6zJuRry
         c4YIYyia1HB+r6GI9cysucgYyz5qPTB+1zzFF2yy3z2i8VJPIGAtDxWoKFaMnVFj3fxL
         t1Tw==
X-Forwarded-Encrypted: i=1; AJvYcCW9rfl1hsonxZYIQdGiUsxVo3Rd9qtCObX3ra+5zKecY6AtE64MbRwhRaZk52RKs41Yc4Jbz522adAPD+541A==@lists.linux.dev
X-Gm-Message-State: AOJu0YxQ4Zz+utmqi4Rm4w8y/mR75gf/xMpI/GS+HTkKTKPz/3E5o9V9
	hBsuDYb6b5vP2OY9ZpesZV42EaJmXg1bjZ8A43OnhqqR4HbSeo8pXJzBWxCfCNR1vHJS4Hsr6lM
	A8hE/uokNtLVKcChpnyaeYSlRlUXotN8+Uhcdui2eLIPPsJkBUbzA1DnhfboBb/WYJ/O5
X-Gm-Gg: AY/fxX5moNMkviktxxlEdt1KOI+AUj2IvYWuGcQR5BEDyePc/MWG0eySt4EN1cSr6g3
	WrS+wU37KqTmDEpbOQANZb9qwIE+fqg0/TXvHxWin+931OuJMJQ7PsxGbi6IVbNGrrvZEqaz8dH
	B2Ier+NmuM9F+iJTGMRqsqN5ztL6Z9XQYqSp9OZoMA9FKNJuYo/dwdVGpw86qfW4+1NfGTt8tKz
	LhU9i5qqgZCYmuMb4lehZLqZNc66HYBzKkJIIYufV9iMCqZq3EpPDPZGx9ZBq7DVS8KRFPKc/4L
	L8aXNfphrm8Oh2bw9WS6HuyVqsp1TmsCzAlKawL0BVM9O0C05EM6sMXPVuavIi+DRmy/0m0rRwc
	=
X-Received: by 2002:a05:6000:1861:b0:430:f182:788f with SMTP id ffacd0b85a97d-4324e4cc554mr39523656f8f.21.1767023244046;
        Mon, 29 Dec 2025 07:47:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF9KgR/b0s0HVFW/sbw2hCKfSRSBzsJZhjFf3671GVOJvGrUkexpDNZQnv9PMFYyD2Weeeb2g==
X-Received: by 2002:a05:6000:1861:b0:430:f182:788f with SMTP id ffacd0b85a97d-4324e4cc554mr39523625f8f.21.1767023243627;
        Mon, 29 Dec 2025 07:47:23 -0800 (PST)
Received: from fedora ([37.169.8.157])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea1aee5sm64128709f8f.4.2025.12.29.07.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Dec 2025 07:47:22 -0800 (PST)
Date: Mon, 29 Dec 2025 16:47:11 +0100
From: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
To: Francesco Valla <francesco@valla.it>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Harald Mommer <harald.mommer@oss.qualcomm.com>,
	Mikhail Golubev-Ciuchea <mikhail.golubev-ciuchea@oss.qualcomm.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-can@vger.kernel.org,
	virtualization@lists.linux.dev,
	Wolfgang Grandegger <wg@grandegger.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH v6] can: virtio: Add virtio CAN driver
Message-ID: <aVKifw2noSECGCGS@fedora>
References: <aQJRnX7OpFRY/1+H@fedora>
 <aQkgsuxa2UaL_qdt@bywater>
 <aTsE1VIk4V/A49HE@fedora>
 <aT7XAsTWr0_yyfx_@bywater>
 <aU71oJScQ8aC0npw@fedora>
 <aU8Krjsv0_aC3E7A@bywater>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <aU8Krjsv0_aC3E7A@bywater>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: HDFQ51_mNVVfU1diM9ZHICun7niN4eX8x_fvTdtBq4M_1767023244
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 26, 2025 at 11:22:38PM +0100, Francesco Valla wrote:
> On Fri, Dec 26, 2025 at 09:52:48PM +0100, Matias Ezequiel Vara Larsen wrote:
> > > > > > +static int virtio_can_read_tx_queue(struct virtqueue *vq)
> > > > > > +{
> > > > > > +	struct virtio_can_priv *can_priv = vq->vdev->priv;
> > > > > > +	struct net_device *dev = can_priv->dev;
> > > > > > +	struct virtio_can_tx *can_tx_msg;
> > > > > > +	struct net_device_stats *stats;
> > > > > > +	unsigned long flags;
> > > > > > +	unsigned int len;
> > > > > > +	u8 result;
> > > > > > +
> > > > > > +	stats = &dev->stats;
> > > > > > +
> > > > > > +	/* Protect list and virtio queue operations */
> > > > > > +	spin_lock_irqsave(&can_priv->tx_lock, flags);
> > > > > 
> > > > > The section below seems a pretty big one to protect behind a spin lock. 
> > > > > 
> > > > 
> > > > How can I split it? 
> > > > 
> > > 
> > > Question here is: what needs to be protected? As far as I can tell, the
> > > only entity needing some kind of locking here is the queue, while both
> > > ida_* and tx_inflight operations are already covered (the former by
> > > design [1], the second because it's implemented using an atomic.
> > > 
> > > If I'm not wrong (but I might be, so please double check) this can be
> > > limited to:
> > > 
> > > 	/* Protect queue operations */
> > > 	scoped_guard(spinlock_irqsave, &priv->tx_lock)
> > > 		err = virtqueue_add_sgs(vq, sgs, 1u, 1u, can_tx_msg, GFP_ATOMIC);
> > > 
> > > 
> > > Maybe the whole locking pattern is a leftover from a previous version, 
> > > where a list of TX messages was kept?
> > > 
> > 
> > I followed this approach for the three queues. I wonder why the rx queue
> > and the ctrl queue use a mutex instead of spinlock? I added a mutex for
> > the operations to the rx queue.
> 
> If I interpreted correctly (but maybe Harald can shine some light on this):
> 

Thanks for the explanation.

> - the virtio_can_send_ctrl_msg() uses a mutex because it could be
>   executed in parallel by different actors (read: userspace processes
>   invoking up and down operations); moreover, is the whole control
>   operation that needs to be protected and not only the access to the
>   virtqueue_ functions, so a mutex should make sense;


In the code, a comment says that this lock may not be required. The lock
is used in virtio_can_send_ctrl_msg(), which is called only from
virtio_can_start() and virtio_can_stop(). But, the sending of control
msgs is sync,i.e., the driver first sends and then waits for a response
thus blocking the access to the control queue. This semantics requires a
mutex. I do not know if access to control queue may be implemented
differently thus preventing to keep the mutex during the whole access. 


> - the rx queue shouldn't actually need any locking, since it is accessed
>   only by the poll function and the network framework should guarantee
>   that no multiple parallel poll operations are called on a napi;
> - the tx queue needs instead to be protected, since it could
>   concurrently be accessed by both the start_xmit callback and the poll
>   function; a spinlock there makes more sense, as accesses should be
>   very short.
> 
> > 
> > Matias
> > 
> > 
> 
> Thank you
> 
> Regards,
> Francesco
> 

