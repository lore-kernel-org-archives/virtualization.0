Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660CEF9FB
	for <virtualization@lists.linux-foundation.org>; Wed, 20 Dec 2023 04:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MQHVrLdi"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E8E9340AA4
	for <virtualization@lists.linux-foundation.org>; Wed, 20 Dec 2023 04:06:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E8E9340AA4
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MQHVrLdi
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tksZ-saDdZbL
	for <virtualization@lists.linux-foundation.org>;
	Wed, 20 Dec 2023 04:06:04 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9144740A5B
	for <virtualization@lists.linux-foundation.org>; Wed, 20 Dec 2023 04:06:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9144740A5B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703045163;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=od6b06R9di1R/4iYBvwR9HNhISJUCGr44+UWNtXtRoc=;
	b=MQHVrLdiTnYXrw0TsTvqsw7g/+M4/YK//6u5ghkO6uJMkdtWueDTmWOVcYC0+84OnsPtBr
	CRJlyc3k2ErmsGfxbmvLCd7QsgMEhdsvofSjae84SHOrSeW3rffOP2KvbOaJHVkAiaklLC
	s+SaepToKj1tfMOCkQaWM2rvIRnM5Mo=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-yYsaec44N1eIu3Gg0-TpdA-1; Tue, 19 Dec 2023 23:06:01 -0500
X-MC-Unique: yYsaec44N1eIu3Gg0-TpdA-1
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3b9d731fd1bso6594249b6e.1
        for <virtualization@lists.linux-foundation.org>; Tue, 19 Dec 2023 20:06:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703045161; x=1703649961;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=od6b06R9di1R/4iYBvwR9HNhISJUCGr44+UWNtXtRoc=;
        b=Pc3o1RCWLj9TpHvCfz9Z1gWh4oi9rGW8z5KqtjjQj6hbWZkLzI+ZgGejWN9NP870dH
         I/mgTLoqUADzTrrXlCWlhMGTJPQ5//wVOmFYj2s8GNg3JK/Wc6i3i9ukQy4T80rOjZGY
         NfLQIpTvHb8CD+a9ViV9KOwdpSmiOKDe3GtFFbxREPUqt1bMrNEHcPubYsJC7G6uLSkY
         R0+G+cL8XSoqvzFi9wg72eHMEwsBNZk+U7KwXB5wjoQAEHsYkLatHtupTicER9ect5qx
         URtPadnTYayz0dTjNIQyRS91KJnDoxFXL/SkJo/L24SLtoa25MuMwJhHvsG8T6bGzZGd
         yc2g==
X-Gm-Message-State: AOJu0Yy4TLs2TVNjRL/rncw4rzTODzeA8xyQP68ChRELwL2k7Ts+q1U5
	dzZ9mlqRaQqByO4Cd6wXXAY3snYeApihO/RqUK8d5Dxm1Yy2cCgkN/+rrQdcn9wFdfce6TBL7qI
	wfbv7YlDYjsd5NOJXpPlU7tZvmpyZx13LWsU21tdZRqE9OxOM0027jmfA/w==
X-Received: by 2002:a05:6808:2022:b0:3bb:5f46:fc92 with SMTP id q34-20020a056808202200b003bb5f46fc92mr2662220oiw.32.1703045161219;
        Tue, 19 Dec 2023 20:06:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF7bNzJNP++sajjpkBSvZbj8fBXUFR3JlD7KqetxxL+4FHj3ZcsomiOKSot/CNkMhv11b5giD9zm5wB0LFKSTg=
X-Received: by 2002:a05:6808:2022:b0:3bb:5f46:fc92 with SMTP id
 q34-20020a056808202200b003bb5f46fc92mr2662209oiw.32.1703045161039; Tue, 19
 Dec 2023 20:06:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231219180858.120898-1-dtatulea@nvidia.com> <20231219180858.120898-3-dtatulea@nvidia.com>
 <CACGkMEv7xQkZYJAgAUK6C3oUrZ9vuUJdTKRzihXcNPb-iWdpJw@mail.gmail.com>
In-Reply-To: <CACGkMEv7xQkZYJAgAUK6C3oUrZ9vuUJdTKRzihXcNPb-iWdpJw@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 20 Dec 2023 12:05:50 +0800
Message-ID: <CACGkMEsaaDGi63__YrvsTC1HqgTaEWHvGokK1bJS5+m1XYM-6w@mail.gmail.com>
Subject: Re: [PATCH vhost v4 02/15] vdpa: Add VHOST_BACKEND_F_CHANGEABLE_VQ_ADDR_IN_SUSPEND
 flag
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Eugenio Perez Martin <eperezma@redhat.com>, 
	Si-Wei Liu <si-wei.liu@oracle.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, virtualization@lists.linux-foundation.org, 
	Gal Pressman <gal@nvidia.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Parav Pandit <parav@nvidia.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2023 at 11:46=E2=80=AFAM Jason Wang <jasowang@redhat.com> w=
rote:
>
> On Wed, Dec 20, 2023 at 2:09=E2=80=AFAM Dragos Tatulea <dtatulea@nvidia.c=
om> wrote:
> >
> > The virtio spec doesn't allow changing virtqueue addresses after
> > DRIVER_OK. Some devices do support this operation when the device is
> > suspended. The VHOST_BACKEND_F_CHANGEABLE_VQ_ADDR_IN_SUSPEND flag
> > advertises this support as a backend features.
>
> There's an ongoing effort in virtio spec to introduce the suspend state.
>
> So I wonder if it's better to just allow such behaviour?

Actually I mean, allow drivers to modify the parameters during suspend
without a new feature.

Thanks

>
> Thanks
>
>

