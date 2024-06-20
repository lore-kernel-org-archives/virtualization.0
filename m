Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800E917CA10
	for <virtualization@lists.linux.dev>; Thu, 20 Jun 2024 08:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718871681; cv=none; b=mG2ckIPpq6uW9rxtCD11l98oXKyNIo0NNoDAMKeu56vuIDomDo8WgFDkFdlvI5Bax9gwzxkyS+/O/Swk/sXqoZLuFgrAX+oMHz3XNX/X82Igq0CNwov5p67RMOZ4kvclQ1HXr430b7Rtneweqfo7UOux8tl6XuCchvosny8qPv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718871681; c=relaxed/simple;
	bh=/n3uJxZGHDBrLN6/BzeZ/X4SdYonmAdhMRnGu+C5EYc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p80ZcMLt2SnlR6SHGkoX2vBtEzXqANJSEn9YQBH863VyYLERsQkB0JO4UfaGB4WdQls8Ue37vfy7eEEu1wVPUHtACgdyrydS0IaCupyT+hxLDmF7HL7oaNiyMWP/ok0/Nl/pPsd9HAXSEjJdWcSWXThvWfiCAwFfeTvXg8JZSaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cUmL6nV/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cUmL6nV/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718871678;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UOPoZ6lA6/IZ64IgHqSK6o73AoMp8QIpZ9FSfSUbtuk=;
	b=cUmL6nV/5CbZRo82jy5UhAddRP4yj0QbdE+/eRVRrf+eDhv6n/Dj2QVeKNwBL6I497JZTH
	uW/t5/hmsQZ608Xnk+nwMqhmmrNlCsmwXIzFIZmP/WRFvPdpmYB5ylURSpgyAgskT+mwEF
	+ppvzawk5r5VbcjOxVdnmI1brXkS+lI=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-307-xHHRw0g1MxShOKv8IayxSw-1; Thu, 20 Jun 2024 04:21:15 -0400
X-MC-Unique: xHHRw0g1MxShOKv8IayxSw-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2c7a8dc68aeso797536a91.0
        for <virtualization@lists.linux.dev>; Thu, 20 Jun 2024 01:21:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718871674; x=1719476474;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UOPoZ6lA6/IZ64IgHqSK6o73AoMp8QIpZ9FSfSUbtuk=;
        b=JNwwKsa7ENLeeYaobsfGdshlBTrWE2dCLDpHqrAS822wrgRZMtgTXm8tGlhFFWROfl
         zzNyM2dxKgqy6GT3vtv1+uwEw8b2uHka3Cuoza5YpWXu6peHWD+UVeNi4SR0lE/HW/4t
         KxwxneIcgFJsm8qFzEw009TY/Nf+oIgpONVqeB3cyiBZwSJuR1+GUmQf+uV/uPQoKLWl
         x0bPgvSduOnE5P5Q+/o4TaFQXyzhWRLqNQgF0jJMlfkiYKkMN3xSoIkbamnpdgxmfj5r
         /yjbYHHnWT8acIqAI7cQpmIckGvA2GV6o6nzngKf8ibYDvI2oNTUp77+s8eYRHscZzgv
         ZEMw==
X-Forwarded-Encrypted: i=1; AJvYcCWhURjVDW5RoJvA42DLnYkITOQg895xiJy2G92BKZr1Qds3Px3/1VS3H6ppI4MnbGYIVCIc5IXXzk8eFSGHqdJdMdCv+BaPE1oBiJlHSHI=
X-Gm-Message-State: AOJu0YxjtSrxWYn0RxMU89jWhFp1K0KyroHXe2ohDUvfRLMSWuAU4klD
	ev653YoFWosCEfJ+KZyBcvOjOmwIMRcGMWgqd4OZgtdRtVCYlxwFJqkMJ0b1FvYSZWyNTsxk6su
	8PFmDvkbdvtpc6p/6FBKTMeHFaAa6ou50gfhr7Webu+WEH/3BxeGWWbLodYgDJ2HBWzeVGWvFrn
	m2bRYBFBDH9PBZQ/f4x4pnhCq/Yj+zHtTI+Aq+nF4=
X-Received: by 2002:a17:90a:e00e:b0:2c2:c61f:e09 with SMTP id 98e67ed59e1d1-2c7b5c8ab04mr4856703a91.20.1718871673980;
        Thu, 20 Jun 2024 01:21:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEELXLOS9maMM8/VKYz9vtsvs8uB8tfK91+qINgt4JeMnX/Yop4+S/SdYYQlGJlokc9zzzowtkPFO6a1HfYlMg=
X-Received: by 2002:a17:90a:e00e:b0:2c2:c61f:e09 with SMTP id
 98e67ed59e1d1-2c7b5c8ab04mr4856685a91.20.1718871673621; Thu, 20 Jun 2024
 01:21:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240619161908.82348-1-hengqi@linux.alibaba.com>
 <20240619161908.82348-3-hengqi@linux.alibaba.com> <20240619171708-mutt-send-email-mst@kernel.org>
 <1718868555.2701075-5-hengqi@linux.alibaba.com>
In-Reply-To: <1718868555.2701075-5-hengqi@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 20 Jun 2024 16:21:02 +0800
Message-ID: <CACGkMEv8jnnO=S3LYW00ypwHfM3Tzt42iuASG_d4FAAk60zoLg@mail.gmail.com>
Subject: Re: [PATCH net-next v4 2/5] virtio_net: enable irq for the control vq
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2024 at 3:35=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.com> =
wrote:
>
> On Wed, 19 Jun 2024 17:19:12 -0400, "Michael S. Tsirkin" <mst@redhat.com>=
 wrote:
> > On Thu, Jun 20, 2024 at 12:19:05AM +0800, Heng Qi wrote:
> > > @@ -5312,7 +5315,7 @@ static int virtnet_find_vqs(struct virtnet_info=
 *vi)
> > >
> > >     /* Parameters for control virtqueue, if any */
> > >     if (vi->has_cvq) {
> > > -           callbacks[total_vqs - 1] =3D NULL;
> > > +           callbacks[total_vqs - 1] =3D virtnet_cvq_done;
> > >             names[total_vqs - 1] =3D "control";
> > >     }
> > >
> >
> > If the # of MSIX vectors is exactly for data path VQs,
> > this will cause irq sharing between VQs which will degrade
> > performance significantly.
> >

Why do we need to care about buggy management? I think libvirt has
been teached to use 2N+2 since the introduction of the multiqueue[1].

> > So no, you can not just do it unconditionally.
> >
> > The correct fix probably requires virtio core/API extensions.
>
> If the introduction of cvq irq causes interrupts to become shared, then
> ctrlq need to fall back to polling mode and keep the status quo.

Having to path sounds a burden.

>
> Thanks.
>


Thanks

[1] https://www.linux-kvm.org/page/Multiqueue

> >
> > --
> > MST
> >
>

