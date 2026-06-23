Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B0B370AE6
	for <virtualization@lists.linux.dev>; Tue, 23 Jun 2026 10:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782209727; cv=none; b=TPZavaZEkml7ZlhbuABV7cX9gdjbstWOE1efVw+yZ29p34Meqda3yganztmL7/+a5XTqAVSfLnCo5JB6bUFFy4CK/Ad9iO2avf6DYUQZLuIOOAZInMcoA70q740qJ5KJngONViIhAATSc77HjfrGQJg/uHnN0rc1iHE60CrgBHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782209727; c=relaxed/simple;
	bh=+W9b9/mk63xgykDNsp6FtMdtjEKzT7LDGD3p8gmWo2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=gRSAbrp3L3qGXvA9xxZi8WlrzwOET45NgnPEmO6UW0v/gO1G2iZuceIo7Eu9FYRYoVLzbCQk1B4G7hAIuhFWrK5sjQmjD/PEZ1ATkqh9NnNCv3+VBejPnKBAmdOMUHEo3/TVE6pmG3a+WGWI3dP2ouUZK81WI3mr05izTHArPeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JE97sESV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JE97sESV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782209725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cb/JwTi0oOwO3g9cvb2qcr2Dryjn8qmfB57Ud7IR7yk=;
	b=JE97sESVmUPmlrLaaDmbiwp5L/9yza3f7P1PzDpNiY9Wptxo7tB+LEdhRf3xyVUVlpmADA
	CIK+/8IiVzusyaECU8s5/yv1vgmDT23qxWWCH2641l/EuUds0I2QF/Zj0EiNvElchws5k0
	moA7s7urSAnultNwR16o1KthA95Q4rk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-SfU8cgzzNFiuyOkH0sbhrQ-1; Tue, 23 Jun 2026 06:15:24 -0400
X-MC-Unique: SfU8cgzzNFiuyOkH0sbhrQ-1
X-Mimecast-MFC-AGG-ID: SfU8cgzzNFiuyOkH0sbhrQ_1782209723
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-45f3d008865so705187f8f.0
        for <virtualization@lists.linux.dev>; Tue, 23 Jun 2026 03:15:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782209723; x=1782814523;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cb/JwTi0oOwO3g9cvb2qcr2Dryjn8qmfB57Ud7IR7yk=;
        b=TZpqbDBOAWByJoOF+7df9YWM4z2cemLW3iAVbtnIQzXZk7UNkG1c75w7a9dgEl/MqU
         2/NULfOBwFb79pjYTRgaLHQw9sJaDEPwDqKpbONWuWEh/XfzgLFnnQDt3jpTCDjL4QtL
         KEmDvdUriu9znIbAznAQ9Qj9TrsK6jCzn1Ys5m2fW6Mcda9BIGFE1xMDRhjGi+Iu8vEI
         azLy6vyfsTDaHJ2acw/1EgH9d0RfedY3vTEFRaglYjHlDy2j0sNxF7HeznlsazLiWxuQ
         Cj0qGg4bv6lXHMrJ+Y2xm0Z6R/PBkD2PsCt4iPPegkv/r7mSa5mCIdq5geKSrkvs/+CO
         WENw==
X-Forwarded-Encrypted: i=1; AHgh+Rroponh3oyBhs4VP1dYrIPkEdCVLkxFq/eLAVVgpKOMB2MO9OEKgbRXmZ2MJsxXQIyUEO81siRtePmyG1vCsA==@lists.linux.dev
X-Gm-Message-State: AOJu0YystkHcSrjyZ7JLM0vFJ/kkhWXlXbvPm9kb9z7Fksh7rW9myXwB
	IX2tuP+OuYDk1AF5tn0jXjnpAlYkbs9KEzd304iaS/8JmPRjOwLTzjXEcJjJaHSpOe0tROdy8Uo
	2BKZ+QHIF0+iwu+TWh8N8NCXwj4sNt3tWGuM1A3wG9PMXGWP5FZi9WF6xlsy6WNfBxLSi
X-Gm-Gg: AfdE7ckCnEhXu/Rxo92nlMceuB5AlVdHjD2XqHu9Hmij30FS1fIGrlcZQWNw8FjaSL2
	4FPme4obKtWz9ZhuJ5WyMf/T7BoyR2ZpwLrtJmuv/FwGHIf0NVqPReqV0GufE6rcEzX65ETjBM8
	kEy/+NZCre6MJKU20s55MKS79tkIauRUr65gKv3D3bF+sY9dhOh7Z7ObDmwLuI8HAbofMYlLjI+
	Lwl1FSRGs3R+JmWb9nQqK3vTYtq3NTEzrURJwE3ZYT8+OcyYylgtMnvARyTZLpPm62v8ipxaAXH
	+Mvc7UGgyd007zXEJJOS6p3ZYpyhUyDwT1PGRTNT2wRTS1Ea12DT1UqfsIGCQBKC751t9Ed/6pO
	rh/FI3ERYRdzkeFww8EBqy17IEen2+scx
X-Received: by 2002:a05:6000:46cf:b0:461:a15f:7aa5 with SMTP id ffacd0b85a97d-46a806bd4e0mr3008007f8f.21.1782209723166;
        Tue, 23 Jun 2026 03:15:23 -0700 (PDT)
X-Received: by 2002:a05:6000:46cf:b0:461:a15f:7aa5 with SMTP id ffacd0b85a97d-46a806bd4e0mr3007964f8f.21.1782209722591;
        Tue, 23 Jun 2026 03:15:22 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-466643f4e93sm37008028f8f.7.2026.06.23.03.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 03:15:22 -0700 (PDT)
Date: Tue, 23 Jun 2026 06:15:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eric Dumazet <edumazet@google.com>
Cc: Longjun Tang <lange_tang@163.com>, netdev <netdev@vger.kernel.org>,
	xuanzhuo@linux.alibaba.com, jasowang@redhat.com,
	virtualization@lists.linux.dev, tanglongjun@kylinos.cn
Subject: Re: [PATCH v2] virtio_net: disable cb when NAPI is busy-polled
Message-ID: <20260623061128-mutt-send-email-mst@kernel.org>
References: <20260623091901.118315-1-lange_tang@163.com>
 <CANn89iLrOTKQNqJA_oZKPjkHb1Xyqm6LS9tDn72X4az65isDGQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CANn89iLrOTKQNqJA_oZKPjkHb1Xyqm6LS9tDn72X4az65isDGQ@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: UIWVCqO-H1Gd7AGaetw2XDNjyY8uIvy2Al6GX1fpyRs_1782209723
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Tue, Jun 23, 2026 at 02:55:30AM -0700, Eric Dumazet wrote:
> On Tue, Jun 23, 2026 at 2:19 AM Longjun Tang <lange_tang@163.com> wrote:
> >
> > From: Longjun Tang <tanglongjun@kylinos.cn>
> >
> > When busy-poll is active, napi_schedule_prep() returns false in
> > virtqueue_napi_schedule(), so virtqueue_disable_cb() is skipped.
> > The device may keep firing irqs until reaches virtqueue_napi_complete().
> > Under load (received == budget), it will lead to a large number
> > of spurious interrupts.
> >
> > Fix it by disabling the callback at the virtnet_poll() entry. This keeps
> > the callback off while we poll and re-enable by virtqueue_napi_complete()
> > when going idle.
> >
> > Signed-off-by: Longjun Tang <tanglongjun@kylinos.cn>
> >
> 
> I added netdev@ to get more attention from networking napi polling experts,
> 
> Please add a Fixes: tag as this will ease code review.
> 
> My rough guess is:
> 
> Fixes: ceef438d613f ("virtio_net: remove custom busy_poll")
> 
> Thanks.

Exactly. The old custom virtnet_busy_poll did napi_schedule_prep + virtqueue_disable_cb itself.

I'd even say CC stable interrupt storms are devastating to performance.


> > ---
> > V1 -> V2: Remain agnostic to busy polling
> > ---
> >  drivers/net/virtio_net.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index f4adcfee7a80..0a11f2b32500 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -3008,6 +3008,11 @@ static int virtnet_poll(struct napi_struct *napi, int budget)
> >         unsigned int xdp_xmit = 0;
> >         bool napi_complete;
> >
> > +       /* Keep callbacks suppressed for the duration of this poll,
> > +        * busy-poll need.
> > +        */
> > +       virtqueue_disable_cb(rq->vq);
> > +
> >         virtnet_poll_cleantx(rq, budget);
> >
> >         received = virtnet_receive(rq, budget, &xdp_xmit);
> > --
> > 2.43.0
> >

