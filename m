Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5AA0224FD
	for <virtualization@lists.linux.dev>; Thu, 23 Jan 2025 02:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737600452; cv=none; b=W88dnphG56PfiJYI7NcGS5P2KfumgoHXjIXdHhNuUpXQMdw1eixLK7hzRkCBbCy7qvT6Le906wly+TdDAQxES6F3MVM8KsInq7ZiiSqO5eyKtuGQI4Oy+lqUvrtEo9zHO5j/AMFTRplI31CarVykX05bXTnVS4tJBNLIFq821sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737600452; c=relaxed/simple;
	bh=qpz5GHIV/q1Z6mS3ehwKqxMZzFsWsx5+0NpTvYpIx3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pAHsbvSMOHDdZv8MdGfmdK59STioRgcwTQiGFZEedT3bH6LoI2ipI/sS7q7GB9NOOcjmd7k0KQvz+OWnMl5rfzLb2FNlvlIK3uHppUiUB4+BoLeeMlXPCA4wEmtRtrh8JHCCTmjpy7D9BWAQcbNXYR9INiw28b/B1L9rzhIeUXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=fm08k6Yw; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="fm08k6Yw"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-21661be2c2dso5945745ad.1
        for <virtualization@lists.linux.dev>; Wed, 22 Jan 2025 18:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1737600450; x=1738205250; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A2UgsPHwIKBOqMrfozZVw3t3KHtftNFDPhqp8M0WAbQ=;
        b=fm08k6YwGYlSL92J8mPeY4Leg4RTDAeF4EZ5N9YV/+HBOkOkiRB4cHtvq5t7b4b++Q
         6APDqnVpTyMulHjLY1tLVpulv7g6RBc78ay9nNCoCs+UQ+CmDkA4XlQzCwe90Q/SJLEb
         OAMsYpIDm9XCDENnBdWzCDp5MSY+B+kQbjt1c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737600450; x=1738205250;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A2UgsPHwIKBOqMrfozZVw3t3KHtftNFDPhqp8M0WAbQ=;
        b=MikyXy+LShPjumkdEii2qk1ueXD3tf3g3bneu06xTPrv7APPTgOoCYdsgh8JxAflUL
         wQGfhIdIfRVgW/Vm8D28G0UDH2KxKGSF81Wh6eMXyDtHro+rzcl2Hy9UuKvkVtdxW0nz
         mGscJPG2W1nkxq5lVrImZxXuNrKb7pV0zjpEAjvOuCSRxw2enBIN0mlHaTVE/tU7fWQ0
         MfrHput46NG5z6AUvdY6xbvUx2W2UVDW4JV6kbjkgBM0tgf/d50c7wWjlgIsi3X4cg9J
         sCDOBbQgH5sWJK+1yEHwVjCkP8mRubM0QMC1pNRX2XuGwWF1ORuBXQffn5Nh/1thhZJc
         jyTw==
X-Forwarded-Encrypted: i=1; AJvYcCWXAWGUMyJ5n1Lzx5lw3gg1Yamnb9gAIFIglhNTGZNqpl/iUqH4qXQlTk4a7rhKJBWXg2knt0qsRDWQiFDvcw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxfivkEUZZBElPZYbQP3hUNAql3vlyhvzIcvxTigAGKtOHxANe5
	kad41jCw7m5vocO/3Dztl2xXuBv0QDFybifuvfWaCvSMhtpCGg2WLjmI8vy+6T7PIKZJ+b7LWj2
	H
X-Gm-Gg: ASbGncsr5hHKeKncigLW2y/4c1EhUKiXNcEUfqzDTfQDktJknYyY9M6YvEdDZzU4n6R
	hXwayIDMYS+bR3igPNBeLv6xGBJ0m53JVNYzF/+spQ4pSR2tbBlEdYTYc2PfMDyxPFYL2Df+HqG
	bXayL9IkSOSYej//yzauRD7CsOPt2sRkHKL4DBRHdJN2nAqjoZ0NK34XVODA8zeyJ51kcBS2jiZ
	5d/BGNejCFrgIb3rey/9SPdGivlxdtdvp8YeC5jW4d7UETW6cKFrwLEliaak2ebroFcMD468zZX
	Im4azCNPhPZ50uc6ytHu7WO/a0S0bEXVv+FWO7WL4mpO5DtJGp5TVbQvMw==
X-Google-Smtp-Source: AGHT+IFJpJzS0Tmwz6QJjW16olbKOsy6uoF4TTmtdWvfMVbO5XC6LPMoIN8L//vAPXE/Dy/lO1nFLA==
X-Received: by 2002:a17:902:e5ca:b0:215:b473:1dc9 with SMTP id d9443c01a7336-21c355fa313mr312106225ad.46.1737600450217;
        Wed, 22 Jan 2025 18:47:30 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-a9bce3a7eedsm11353188a12.40.2025.01.22.18.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 18:47:29 -0800 (PST)
Date: Wed, 22 Jan 2025 18:47:25 -0800
From: Joe Damato <jdamato@fastly.com>
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org, gerhard@engleder-embedded.com,
	leiyang@redhat.com, xuanzhuo@linux.alibaba.com,
	mkarsten@uwaterloo.ca, "Michael S. Tsirkin" <mst@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC net-next v3 2/4] virtio_net: Prepare for NAPI to queue
 mapping
Message-ID: <Z5Gtve0NoZwPNP4A@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jason Wang <jasowang@redhat.com>, netdev@vger.kernel.org,
	gerhard@engleder-embedded.com, leiyang@redhat.com,
	xuanzhuo@linux.alibaba.com, mkarsten@uwaterloo.ca,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>
References: <20250121191047.269844-1-jdamato@fastly.com>
 <20250121191047.269844-3-jdamato@fastly.com>
 <CACGkMEvT=J4XrkGtPeiE+8fwLsMP_B-xebnocJV8c5_qQtCOTA@mail.gmail.com>
 <Z5EtqRrc_FAHbODM@LQ3V64L9R2>
 <CACGkMEu6XHx-1ST9GNYs8UnAZpSJhvkSYqa+AE8FKiwKO1=zXQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEu6XHx-1ST9GNYs8UnAZpSJhvkSYqa+AE8FKiwKO1=zXQ@mail.gmail.com>

On Thu, Jan 23, 2025 at 10:40:43AM +0800, Jason Wang wrote:
> On Thu, Jan 23, 2025 at 1:41 AM Joe Damato <jdamato@fastly.com> wrote:
> >
> > On Wed, Jan 22, 2025 at 02:12:46PM +0800, Jason Wang wrote:
> > > On Wed, Jan 22, 2025 at 3:11 AM Joe Damato <jdamato@fastly.com> wrote:
> > > >
> > > > Slight refactor to prepare the code for NAPI to queue mapping. No
> > > > functional changes.
> > > >
> > > > Signed-off-by: Joe Damato <jdamato@fastly.com>
> > > > Reviewed-by: Gerhard Engleder <gerhard@engleder-embedded.com>
> > > > Tested-by: Lei Yang <leiyang@redhat.com>
> > > > ---
> > > >  v2:
> > > >    - Previously patch 1 in the v1.
> > > >    - Added Reviewed-by and Tested-by tags to commit message. No
> > > >      functional changes.
> > > >
> > > >  drivers/net/virtio_net.c | 10 ++++++++--
> > > >  1 file changed, 8 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > index 7646ddd9bef7..cff18c66b54a 100644
> > > > --- a/drivers/net/virtio_net.c
> > > > +++ b/drivers/net/virtio_net.c
> > > > @@ -2789,7 +2789,8 @@ static void skb_recv_done(struct virtqueue *rvq)
> > > >         virtqueue_napi_schedule(&rq->napi, rvq);
> > > >  }
> > > >
> > > > -static void virtnet_napi_enable(struct virtqueue *vq, struct napi_struct *napi)
> > > > +static void virtnet_napi_do_enable(struct virtqueue *vq,
> > > > +                                  struct napi_struct *napi)
> > > >  {
> > > >         napi_enable(napi);
> > >
> > > Nit: it might be better to not have this helper to avoid a misuse of
> > > this function directly.
> >
> > Sorry, I'm probably missing something here.
> >
> > Both virtnet_napi_enable and virtnet_napi_tx_enable need the logic
> > in virtnet_napi_do_enable.
> >
> > Are you suggesting that I remove virtnet_napi_do_enable and repeat
> > the block of code in there twice (in virtnet_napi_enable and
> > virtnet_napi_tx_enable)?
> 
> I think I miss something here, it looks like virtnet_napi_tx_enable()
> calls virtnet_napi_do_enable() directly.
> 
> I would like to know why we don't call netif_queue_set_napi() for TX NAPI here?

Please see both the cover letter and the commit message of the next
commit which addresses this question.

TX-only NAPIs do not have NAPI IDs so there is nothing to map.
