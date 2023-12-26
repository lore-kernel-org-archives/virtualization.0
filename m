Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6135351C25
	for <virtualization@lists.linux.dev>; Tue, 26 Dec 2023 18:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="caLyKgfB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703614287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hT6GvBmX89c+TsvMimuxFBTAQCwbiQqPyRqut34DI6c=;
	b=caLyKgfBnKlDH5aheZyVZcbM7sL4yme/uTYiVPXtX4L8A7mEWGKvw1KvKys4Y5hoKqQfvJ
	YJWJEP9eLZqdvTA7HmsH5w16rJv5G8jpfsnYuPpjY9MplMIJdNhWGUnBZxRNj/o7AeKs4m
	yS49VVdc4olLwaKtkDkkHARVsDBAslw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-r6PVbrTOO-WC5AqRPDj-uA-1; Tue, 26 Dec 2023 13:11:24 -0500
X-MC-Unique: r6PVbrTOO-WC5AqRPDj-uA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-33680996d4fso3648047f8f.0
        for <virtualization@lists.linux.dev>; Tue, 26 Dec 2023 10:11:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703614283; x=1704219083;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hT6GvBmX89c+TsvMimuxFBTAQCwbiQqPyRqut34DI6c=;
        b=inZqTW3So8AO3uimD6PHSdOC2OA+n722IFQLCWpxrn32wQ5568ArRkFdktK8ui9r+2
         iqEHWfxJ3vg1Cr4DHyfUkayI9QKw7ci7VeJ+ixJPJJncP7TSjg0ivu1UQlw6BMmd9T6E
         xGIIydfi+1vHwBRiRya/XNsmPvKfniUdK93vEsKyLFbIkVx1kCow0v1mpviYgHNu6GGL
         Jm5b/ej8ItjMxSka5QROb3dsabL+jYz1Z3DsTOU+twM7Vd6nhM/LBHArpC9h7e+5wy5w
         KlxrcosWit74T+LDv0Y4q/h8Pdi7PSCYIJS3vkX3nwcCD3B7A0bre+4WTDZFpAPP79nX
         VORg==
X-Gm-Message-State: AOJu0Yzrn9Gq8hcDoLjiYG0wHuCF+BYiRd6WdDyEDDaT71YIyS9vZ5VS
	hZX0z9aJHgXX2TCbb9K4dSRp+9bYVp/5nsFVgtp8OPz9ss0g56i4s1wj5gU01KSt5T4TrMVUm7g
	Nt0SEYjz4NpK+lKOtmTbJLDSzifVs99NUWe4=
X-Received: by 2002:a05:6000:1091:b0:336:4ba9:e2b3 with SMTP id y17-20020a056000109100b003364ba9e2b3mr4036885wrw.58.1703614282984;
        Tue, 26 Dec 2023 10:11:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEGXob+rV7M1PH+RPj4+87x11/2hKBwDb4SfJTkxlS6lAfVaflaggsdNvr5HvrCeMfv5UKIxQ==
X-Received: by 2002:a05:6000:1091:b0:336:4ba9:e2b3 with SMTP id y17-20020a056000109100b003364ba9e2b3mr4036877wrw.58.1703614282620;
        Tue, 26 Dec 2023 10:11:22 -0800 (PST)
Received: from redhat.com ([2.55.177.189])
        by smtp.gmail.com with ESMTPSA id k15-20020adfe3cf000000b003367a51217csm13082390wrm.34.2023.12.26.10.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Dec 2023 10:11:21 -0800 (PST)
Date: Tue, 26 Dec 2023 13:11:18 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Zhu Yanjun <yanjun.zhu@linux.dev>, Zhu Yanjun <yanjun.zhu@intel.com>,
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, virtualization@lists.linux.dev,
	netdev@vger.kernel.org
Subject: Re: [PATCH 1/1] virtio_net: =?utf-8?Q?Fix_?=
 =?utf-8?B?IuKAmCVk4oCZIGRpcmVjdGl2ZSB3cml0aW4=?= =?utf-8?Q?g?= between 1 and
 11 bytes into a region of size 10" warnings
Message-ID: <20231226130707-mutt-send-email-mst@kernel.org>
References: <20231226114507.2447118-1-yanjun.zhu@intel.com>
 <b1034710-62df-4623-a0ad-d09a6bb12765@linux.dev>
 <20231226100113.4ea54838@hermes.local>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20231226100113.4ea54838@hermes.local>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Tue, Dec 26, 2023 at 10:01:13AM -0800, Stephen Hemminger wrote:
> On Tue, 26 Dec 2023 19:53:58 +0800
> Zhu Yanjun <yanjun.zhu@linux.dev> wrote:
> 
> > The warnings are as below:
> > 
> > "
> > 
> > drivers/net/virtio_net.c: In function ‘init_vqs’:
> > drivers/net/virtio_net.c:4551:48: warning: ‘%d’ directive writing 
> > between 1 and 11 bytes into a region of size 10 [-Wformat-overflow=]
> >   4551 |                 sprintf(vi->rq[i].name, "input.%d", i);
> >        |                                                ^~
> > In function ‘virtnet_find_vqs’,
> >      inlined from ‘init_vqs’ at drivers/net/virtio_net.c:4645:8:
> > drivers/net/virtio_net.c:4551:41: note: directive argument in the range 
> > [-2147483643, 65534]
> >   4551 |                 sprintf(vi->rq[i].name, "input.%d", i);
> >        |                                         ^~~~~~~~~~
> > drivers/net/virtio_net.c:4551:17: note: ‘sprintf’ output between 8 and 
> > 18 bytes into a destination of size 16
> >   4551 |                 sprintf(vi->rq[i].name, "input.%d", i);
> >        |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > drivers/net/virtio_net.c: In function ‘init_vqs’:
> > drivers/net/virtio_net.c:4552:49: warning: ‘%d’ directive writing 
> > between 1 and 11 bytes into a region of size 9 [-Wformat-overflow=]
> >   4552 |                 sprintf(vi->sq[i].name, "output.%d", i);
> >        |                                                 ^~
> > In function ‘virtnet_find_vqs’,
> >      inlined from ‘init_vqs’ at drivers/net/virtio_net.c:4645:8:
> > drivers/net/virtio_net.c:4552:41: note: directive argument in the range 
> > [-2147483643, 65534]
> >   4552 |                 sprintf(vi->sq[i].name, "output.%d", i);
> >        |                                         ^~~~~~~~~~~
> > drivers/net/virtio_net.c:4552:17: note: ‘sprintf’ output between 9 and 
> > 19 bytes into a destination of size 16
> >   4552 |                 sprintf(vi->sq[i].name, "output.%d", i);
> > 
> > "
> > 
> > Please review.
> > 
> > Best Regards,
> > 
> > Zhu Yanjun
> > 
> > 在 2023/12/26 19:45, Zhu Yanjun 写道:
> > > From: Zhu Yanjun <yanjun.zhu@linux.dev>
> > >
> > > Fix a warning when building virtio_net driver.
> > >
> > > Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> > > ---
> > >   drivers/net/virtio_net.c | 5 +++--
> > >   1 file changed, 3 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index 49625638ad43..cf57eddf768a 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -4508,10 +4508,11 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
> > >   {
> > >   	vq_callback_t **callbacks;
> > >   	struct virtqueue **vqs;
> > > -	int ret = -ENOMEM;
> > > -	int i, total_vqs;
> > >   	const char **names;
> > > +	int ret = -ENOMEM;
> > > +	int total_vqs;
> > >   	bool *ctx;
> > > +	u16 i;
> > >   
> > >   	/* We expect 1 RX virtqueue followed by 1 TX virtqueue, followed by
> > >   	 * possible N-1 RX/TX queue pairs used in multiqueue mode, followed by  
> > 
> 
> If you change the variable type to u16, then the format string should no
> longer use %d. Instead should be %u

I would just use unsigned FWIW. But it doesn't matter the range is
limited here. It's just that the compiler can't figure it out.

-- 
MST

