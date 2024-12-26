Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCBC1D357B
	for <virtualization@lists.linux.dev>; Thu, 26 Dec 2024 11:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735214080; cv=none; b=YCQmrvZ583v5AePoVl8dyHZtq4oISSYOkKNeBqKdP/R9vZ9WeO4hv4bVjaj61T2YOu0jbRBXLoQnWHrlj7gjLIza8ZjFv7JMyVocrudib1elGNAuw20+hot4LiRXScZ/wvjdCnyHroDulfWVDklhlqJ+QUYO2/dE7uudrFFkZl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735214080; c=relaxed/simple;
	bh=iWkIeH7XpKncFP2q6VfoR5Zy250ww4ZI5R5aDEzlRHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=YJL7jkItL1Yg6BUcw9dnKH1GxFoVYyEVtNzReptNC0ptbl+A6QhZGh7Jc/UEYwaHqvNIVqKvxtX0yI4X8ffkpKhDReeMotAk3AWqa7dwUxs8D2P4dyBaafD6tujg8CJg8dFl6Kbj6FvzT4Q8nUNKILL/YyyryJaaD/LYJpTvhb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UOYY+ud7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UOYY+ud7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1735214076;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xLjAVdZBTOv5YjH5Y2Kd0YMJTvW51ihi5xrqHhONKz8=;
	b=UOYY+ud7XJHB6jBvPnaDdD/gA9kBt7omi9yk+nToFD0PcCNDVuKDrAiEy6fgErGh3g02bc
	RtEFsRwEuUccaphx6xikKnfGfmIg4y+5ZctpQMvL6uwFaGQVHNzAUmFmbja3In98GCj53d
	38JzIhMgEljibTrgjwSKiX6VOcUmf/o=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-oqBsEf5LNciaXG_fgNaJiw-1; Thu, 26 Dec 2024 06:54:35 -0500
X-MC-Unique: oqBsEf5LNciaXG_fgNaJiw-1
X-Mimecast-MFC-AGG-ID: oqBsEf5LNciaXG_fgNaJiw
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-aa680c6aa0eso472591366b.0
        for <virtualization@lists.linux.dev>; Thu, 26 Dec 2024 03:54:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735214074; x=1735818874;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xLjAVdZBTOv5YjH5Y2Kd0YMJTvW51ihi5xrqHhONKz8=;
        b=pTvYFTRPR+ZKv/wXlu3nLQvRo+4I6JFgSZ/HR1bMJxgQnh5DscOfQT8UYjJ3WVRK8C
         zYvmZN27QNmiMdzI7EaZn/zZGI1g84Zftd9y9bT7Nm1aDzZA/JRDe5v/U3ApJHcOq/Cc
         iKhaOtpjYkDoOvAESvxAiKvrSzbT/nK7BaUf7oyc2msGmJlZ2WXnbj1DNMTkIVZt1N84
         b6x94EXb5yo7ByeGS6xypnCnMYdxahtT74OG4MHHPhQJgrNQK5tWuvyJqhtgYcX7T1QY
         hXc2Fgxit4T3+6ZRUfu0RNQtVCvALUwqDfbppqj4xx9jy7shfhyN9PSSleD2AX6LJVCy
         HdPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjuqcpW9XhuX/lLwUy9emY7AznEyPynho/vpsEA7TleT2jlMKGpkKO681Fojbmr2i/Yz3g0keof2OsKSZtqw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyPMJkXca3MB1FemG9z2YhRN0RNB2NM8q0kfWKG9PGbkNDK4fSz
	fMKo+mEv2Wdt4qmLAB1LxRBUYqS0zK0FxK9/wKwr1jE/epbLJhCDGBiZ1eU1xxIyHiwLU3ZIZkR
	JaV3oRGJmGeitujuo+G+h2JFyremFxDLGGDZ7RiVoz6nt+tCc7rbxovPGxTwuD3U4tyL2zZiL
X-Gm-Gg: ASbGnctSjJSZKzb4cUBQk/M5sLfQYx5arxo3aW0hSIrSxZSwt0YlWKueOM107Iqz9FW
	A2hBvOO91+X2z4tDuGoCC/tERInDJGNYhyr5EHdvwrrM37YO3NbA1GTB+qQ64HFkOPJ4+0Uxh8/
	YWCXn36WFFDXkgBWxgRS66KXO9g55eRIqsiAm/3YLMIn1wWMdwto6oAmKaOepKrOw1eOeuqTlj4
	pFj+nAXhMbTrIOzzoeAn0B+mFDYdY/nTvlHTPPXPIhFbH8=
X-Received: by 2002:a17:907:60cc:b0:aab:736c:558 with SMTP id a640c23a62f3a-aac3368bd9amr2037709166b.55.1735214074264;
        Thu, 26 Dec 2024 03:54:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGYnbh6gwrQFWWldDcanUaWJe0Ikrbn57WhRMyPauSRLl4E+qhWj414eKBdK7jKHQ4sxz/A6Q==
X-Received: by 2002:a17:907:60cc:b0:aab:736c:558 with SMTP id a640c23a62f3a-aac3368bd9amr2037707666b.55.1735214073922;
        Thu, 26 Dec 2024 03:54:33 -0800 (PST)
Received: from redhat.com ([31.187.78.158])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0f0159f1sm938821566b.154.2024.12.26.03.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Dec 2024 03:54:33 -0800 (PST)
Date: Thu, 26 Dec 2024 06:54:27 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	kvm@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vhost/net: Set num_buffers for virtio 1.0
Message-ID: <20241226064215-mutt-send-email-mst@kernel.org>
References: <20240915-v1-v1-1-f10d2cb5e759@daynix.com>
 <20241106035029-mutt-send-email-mst@kernel.org>
 <CACGkMEt0spn59oLyoCwcJDdLeYUEibePF7gppxdVX1YvmAr72Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CACGkMEt0spn59oLyoCwcJDdLeYUEibePF7gppxdVX1YvmAr72Q@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 1m9HIzhj0fdAhnG_mk24Cwz4tkK4d7tiJQ2XPSuaVjY_1735214075
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, Nov 11, 2024 at 09:27:45AM +0800, Jason Wang wrote:
> On Wed, Nov 6, 2024 at 4:54 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Sun, Sep 15, 2024 at 10:35:53AM +0900, Akihiko Odaki wrote:
> > > The specification says the device MUST set num_buffers to 1 if
> > > VIRTIO_NET_F_MRG_RXBUF has not been negotiated.
> > >
> > > Fixes: 41e3e42108bc ("vhost/net: enable virtio 1.0")
> > > Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> >
> > True, this is out of spec. But, qemu is also out of spec :(
> >
> > Given how many years this was out there, I wonder whether
> > we should just fix the spec, instead of changing now.
> >
> > Jason, what's your take?
> 
> Fixing the spec (if you mean release the requirement) seems to be less risky.
> 
> Thanks

I looked at the latest spec patch.
Issue is, if we relax the requirement in the spec,
it just might break some drivers.

Something I did not realize at the time.

Also, vhost just leaves it uninitialized so there really is no chance
some driver using vhost looks at it and assumes 0.

There is another thing out of spec with vhost at the moment:
it is actually leaving this field in the buffer
uninitialized. Which is out of spec, length supplied by device
must be initialized by device.


We generally just ask everyone to follow spec.  So now I'm inclined to fix
it, and make a corresponding qemu change.


Now, about how to fix it - besides a risk to non-VM workloads, I dislike
doing an extra copy to user into buffer. So maybe we should add an ioctl
to teach tun to set num bufs to 1.
This way userspace has control.

Hmm?


> >
> >
> > > ---
> > >  drivers/vhost/net.c | 5 ++++-
> > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> > > index f16279351db5..d4d97fa9cc8f 100644
> > > --- a/drivers/vhost/net.c
> > > +++ b/drivers/vhost/net.c
> > > @@ -1107,6 +1107,7 @@ static void handle_rx(struct vhost_net *net)
> > >       size_t vhost_hlen, sock_hlen;
> > >       size_t vhost_len, sock_len;
> > >       bool busyloop_intr = false;
> > > +     bool set_num_buffers;
> > >       struct socket *sock;
> > >       struct iov_iter fixup;
> > >       __virtio16 num_buffers;
> > > @@ -1129,6 +1130,8 @@ static void handle_rx(struct vhost_net *net)
> > >       vq_log = unlikely(vhost_has_feature(vq, VHOST_F_LOG_ALL)) ?
> > >               vq->log : NULL;
> > >       mergeable = vhost_has_feature(vq, VIRTIO_NET_F_MRG_RXBUF);
> > > +     set_num_buffers = mergeable ||
> > > +                       vhost_has_feature(vq, VIRTIO_F_VERSION_1);
> > >
> > >       do {
> > >               sock_len = vhost_net_rx_peek_head_len(net, sock->sk,
> > > @@ -1205,7 +1208,7 @@ static void handle_rx(struct vhost_net *net)
> > >               /* TODO: Should check and handle checksum. */
> > >
> > >               num_buffers = cpu_to_vhost16(vq, headcount);
> > > -             if (likely(mergeable) &&
> > > +             if (likely(set_num_buffers) &&
> > >                   copy_to_iter(&num_buffers, sizeof num_buffers,
> > >                                &fixup) != sizeof num_buffers) {
> > >                       vq_err(vq, "Failed num_buffers write");
> > >
> > > ---
> > > base-commit: 46a0057a5853cbdb58211c19e89ba7777dc6fd50
> > > change-id: 20240908-v1-90fc83ff8b09
> > >
> > > Best regards,
> > > --
> > > Akihiko Odaki <akihiko.odaki@daynix.com>
> >

