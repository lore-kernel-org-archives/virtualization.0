Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD04245024
	for <virtualization@lists.linux.dev>; Thu, 13 Feb 2025 14:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739458045; cv=none; b=jBOAB2EZYkx6821I5JewSMQdgt1aTWziW3Y1SWOWEh6QK8Uz8DVS9oZR2sIS8aNuIJ3Fmw3OV8F+W8+kSJkzK90mY+cDt89PZTVh4M+9KkSI3i1MfhYMt0uvYDAD2mb9PBa3d4ln3Ph3WTHOSS07C0FbtgnovRCc5xw+hxf5DEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739458045; c=relaxed/simple;
	bh=tPhyVVJDg+eB9kkF+HosG3iztKpJSHNf3iCVuHVuR0Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ecFibFLmWntMkh6Gh4oKOGCDHJHyKw7ox3x1vWBN7GNGj8Tlk9PO8vgDbgV48OfFOhL6UhAATxxGSFMj8x5WKHl4MbgL3DJ3bNGvEb6N4YQkGqBU/IYGj95DtVlQqI3ugmNGbtLeMz3B03BqDqzvrDlnkWAfZZj17bSRZih0yJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ENTsJjDT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ENTsJjDT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739458042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZAKfOutKaK2ALg6/h1nMfRqlupNtDP/2Xy+rsmNojjc=;
	b=ENTsJjDTM5+8wVNgEKEWPJlEFc7ttqtQtMT36YUqwRCQNDHrRUiosRx9A57Dt+f57HNKVT
	g/M1QUm06byNA8WuovkNcHJuYUaiXul2MAi9JGWxfq4yyoptVL9a8ks0SbDfWLNbIfGdQG
	LjirFsHh3JI0FuMTVAuWVnOQvIe7Q2E=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-288-1rmVIdkXNfy1olfs1USsEQ-1; Thu, 13 Feb 2025 09:47:19 -0500
X-MC-Unique: 1rmVIdkXNfy1olfs1USsEQ-1
X-Mimecast-MFC-AGG-ID: 1rmVIdkXNfy1olfs1USsEQ_1739458039
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-6f2793679ebso14365197b3.0
        for <virtualization@lists.linux.dev>; Thu, 13 Feb 2025 06:47:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739458039; x=1740062839;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZAKfOutKaK2ALg6/h1nMfRqlupNtDP/2Xy+rsmNojjc=;
        b=lWYzBhAPvOYxSUDfMxVvgD2Mm6Jk4+sEXSImwDSijE8uve60UZYQOj9f+h5WKqk1dn
         0BpEUOvlJt4GEkHVwZmoAesc/H7praDxSoUq5hHhRgoP4tWDGoKFS3IrbkEOqFYwbihY
         jBuDNyD458DEo2C07mAeq4WWpkSgrODvaLvlkgZrlXvH7ji1HGSQEoKFZDhkRFLIAF1G
         fdHQ9MmgPjBrchbAXzIENwXxNWmrGCyI3ikGDGUaVy0P2MZOMdLiSJuVmHCfuZbtGbab
         +KQ3Nt6iQEKEqz5FayEHhCv/SrfXStmZRi7pZ7HZXv0yOP6DyU3HMwLPg7L7Y50lvL0I
         FOtw==
X-Forwarded-Encrypted: i=1; AJvYcCUUh+FSYabxpOyB3bP6nbqczLdEuLQ0jodTqC4ZA3E/rTTwFHOjzQxJ0TzMs7M4+3zWXlWKsu+fdY89cSNmIw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy1Xd9ub7PA8CnAN2ul8jRCuxbcfgXc9h7NGb35GdSYUfQPZW1W
	G4ZyOr/E9Axnz9WPeYbgpHptB2HnaWmfo5K+q1csx1ILfK0F0edElOS2dBA/hsdWRafZ2zIXD3+
	kAydn2baT7+IXHT17KguhyLMFC5UFqo7qmRIqZGM/BKPnlitj6FS1e1Ek2zHKXWtAyvCqpZy1/C
	+FJ4oJ0rP7CbmPall0tZP8fE36Uc+0+tBnsDpWSMs=
X-Gm-Gg: ASbGncsOgEvm4yf3mAqc3cQV/Ri1MbvQLllNx2qhNpgajCd/IztHF8SNoF6tZUfTYzT
	cBpLmbLUBxDhcpe39YNb6sc+IuYxrwzoXbMdwNvWO08YRYZQMBCxbR4CCyVzx
X-Received: by 2002:a05:690c:690e:b0:6f7:406e:48d with SMTP id 00721157ae682-6fb1f29bcfdmr76979537b3.35.1739458038735;
        Thu, 13 Feb 2025 06:47:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHEeHYNZFDgV2vgtp07+EXLG6diJ0WLxws7MaPqF2P91HH13rbU2aou20GjoSl6bzof2WHxUqurRf5pGgUAIn4=
X-Received: by 2002:a05:690c:690e:b0:6f7:406e:48d with SMTP id
 00721157ae682-6fb1f29bcfdmr76979187b3.35.1739458038365; Thu, 13 Feb 2025
 06:47:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <gr5rqfwb4qgc23dadpfwe74jvsq37udpeqwhpokhnvvin6biv2@6v5npbxf6kbn>
 <CGME20250213012722epcas5p23e1c903b7ef0711441514c5efb635ee8@epcas5p2.samsung.com>
 <20250213012805.2379064-1-junnan01.wu@samsung.com> <4n2lobgp2wb7v5vywbkuxwyd5cxldd2g4lxb6ox3qomphra2gd@zhrnboczbrbw>
In-Reply-To: <4n2lobgp2wb7v5vywbkuxwyd5cxldd2g4lxb6ox3qomphra2gd@zhrnboczbrbw>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Thu, 13 Feb 2025 15:47:07 +0100
X-Gm-Features: AWEUYZk5_r-tBhZvoaLYlDqhO9_sUVYkjzi-JYbjI9o8ZFZY67uC4S7eLbX9jnQ
Message-ID: <CAGxU2F7PKH34N7Jd5d=STCAybJi-DDTB-XGiXSAS9BBvGVN4GA@mail.gmail.com>
Subject: Re: [Patch net 1/2] vsock/virtio: initialize rx_buf_nr and
 rx_buf_max_nr when resuming
To: Junnan Wu <junnan01.wu@samsung.com>
Cc: davem@davemloft.net, edumazet@google.com, eperezma@redhat.com, 
	horms@kernel.org, jasowang@redhat.com, kuba@kernel.org, kvm@vger.kernel.org, 
	lei19.wang@samsung.com, linux-kernel@vger.kernel.org, mst@redhat.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, q1.huang@samsung.com, 
	stefanha@redhat.com, virtualization@lists.linux.dev, 
	xuanzhuo@linux.alibaba.com, ying01.gao@samsung.com, ying123.xu@samsung.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6swp8ftF7OiGKk2Prr8HBbEntogrWpyx7iSmK9NV2Rs_1739458039
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 13 Feb 2025 at 10:25, Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> On Thu, Feb 13, 2025 at 09:28:05AM +0800, Junnan Wu wrote:
> >>You need to update the title now that you're moving also queued_replies.
> >>
> >
> >Well, I will update the title in V3 version.
> >
> >>On Tue, Feb 11, 2025 at 03:19:21PM +0800, Junnan Wu wrote:
> >>>When executing suspend to ram twice in a row,
> >>>the `rx_buf_nr` and `rx_buf_max_nr` increase to three times vq->num_free.
> >>>Then after virtqueue_get_buf and `rx_buf_nr` decreased
> >>>in function virtio_transport_rx_work,
> >>>the condition to fill rx buffer
> >>>(rx_buf_nr < rx_buf_max_nr / 2) will never be met.
> >>>
> >>>It is because that `rx_buf_nr` and `rx_buf_max_nr`
> >>>are initialized only in virtio_vsock_probe(),
> >>>but they should be reset whenever virtqueues are recreated,
> >>>like after a suspend/resume.
> >>>
> >>>Move the `rx_buf_nr` and `rx_buf_max_nr` initialization in
> >>>virtio_vsock_vqs_init(), so we are sure that they are properly
> >>>initialized, every time we initialize the virtqueues, either when we
> >>>load the driver or after a suspend/resume.
> >>>At the same time, also move `queued_replies`.
> >>
> >>Why?
> >>
> >>As I mentioned the commit description should explain why the changes are
> >>being made for both reviewers and future references to this patch.
> >>
> >
> >After your kindly remind, I have double checked all locations where `queued_replies`
> >used, and we think for order to prevent erroneous atomic load operations
> >on the `queued_replies` in the virtio_transport_send_pkt_work() function
> >which may disrupt the scheduling of vsock->rx_work
> >when transmitting reply-required socket packets,
> >this atomic variable must undergo synchronized initialization
> >alongside the preceding two variables after a suspend/resume.
>
> Yes, that was my concern!
>
> >
> >If we reach agreement on it, I will add this description in V3 version.
>
> Yes, please, I just wanted to point out that we need to add an
> explanation in the commit description.
>
> And in the title, in this case though listing all the variables would
> get too long, so you can do something like that:
>
>      vsock/virtio: fix variables initialization during resuming

I forgot to mention that IMHO it's better to split this series.
This first patch (this one) seems ready, without controversy, and it's
a real fix, so for me v3 should be a version ready to be merged.

While the other patch is more controversial and especially not a fix
but more of a new feature, so I don't think it makes sense to continue
to have these two patches in a single series.

Thanks,
Stefano

