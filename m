Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF4821519A
	for <virtualization@lists.linux.dev>; Wed, 22 Jan 2025 17:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737567665; cv=none; b=t6kLHNI3mc9yrN5GOo5BqRgsY+myMBKcwKt2wdjraJMpeeXBJ1bZEC2VwIryVdkcILqiyXawo5js+Rk3E8didJHyIjdP58sJ/vL3qyp/1uWAbqN1Gr4b27IoDca9krSRkasR+sOUv3wmD+QHaFWgMS7tvCqpFxRJvuwnwzvJRs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737567665; c=relaxed/simple;
	bh=zXXrzWCLJA++Rf33uMBJnwYrM22DuyNXl1CNawXNbVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oJJe+Ig7mPemTylimb2Q6CidIjOjravZzPXtDLaRgdd5+851mEIqZiMXWIlEvEWgtjlM7OmRFtuZaB8yLvkVfCkNvF2qschwLtiX6OZVVHy6P9VvFhuwtJXDvx0m5tS7Ky+ulqfHkhAHsV6lKAK8UdJvm75ceM7cK19tlYYKdcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=g9Aahn2f; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="g9Aahn2f"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-21675fd60feso154023225ad.2
        for <virtualization@lists.linux.dev>; Wed, 22 Jan 2025 09:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1737567662; x=1738172462; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hzk4EqT1xduSyCel68HG0gUHXnZnF8tcdwDmYNduisU=;
        b=g9Aahn2fcFPDe1k/APb28tj//J11i1DHHvTqal96nifMfK9B7v60NpsQpgOsd52BKI
         UQXfI+laIj/hwzQRau3AjmzvICC6QFdCo+j/in0EZ6X3oAttur6GcF+yuqY3z0s80Nbr
         cGXXLTzJbwbdZCOHlimKc9WM0/GVYRHjgyZyY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737567662; x=1738172462;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hzk4EqT1xduSyCel68HG0gUHXnZnF8tcdwDmYNduisU=;
        b=iz5Mf6sBbXg4t4Rk0Y9MOBKH0DsJiZNHkokeujMeg2VFvXs//U2p5tEPujBStSw6gd
         vG1PDC0YVXj4OXDOfBPoKOXQodyhpWKZJR6lNVnz+6Obq6NJwWvpAyy2Vb9VtfxHVUCE
         6mI/Gyo5vc9deSE7l7BwTA1eVVr+pWlGdeMKjgBf9a1C611iqkoP7V3iVT4MxQMUcwKC
         ri3AaFX2H0FQXv1/EHv8ABfor5+e+6eEbzC8EQPrnEM4LtWvvoPiSoAlIOCfJflC/FPh
         BZ5N4oVPuwpwi/cOjbMwqBfYoO6G9BoxB1WDRANpaobtqa3J790iQ2SV0fqZq/1sf468
         2LFA==
X-Forwarded-Encrypted: i=1; AJvYcCXbXPoKndhIPjYOz0EtNc4O5MGs2c3lIBxw3xHnNK3vXPaIloQHWsfnBVmbNPWIdBTLMA2Fg1qYR8WeyKCIoQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzV2YFBLz02BD7cJ6bgVv44iV5wqRWI8n3p6cJFqINA3ovLPgi4
	hSEQ7xoK2bEL/UG5YchaeHDO+B/ks8Xe+EW7bQphh27/Uroge/lcl3tJo213jWU=
X-Gm-Gg: ASbGncvv50kGIlSMh+0np6aQy/YA85QgP78XUADR3wC+NqkPx+7eeawbWY2SIR7e8NT
	Fq1A5xJ7yKN0RRIWeCFarfUGvHLa4LUIIxP3xbjY/5+DcjHXTgDpQao0X76+uDB51e7MLhoMPav
	zfHLCqpvaDwUoPCvxTLyMQPKrKMNrQiwf7jTsflVMIV7JN4hm/CG85z3RY/9Ev+0QgIsrjrs86s
	94qQDbJiutqNAE3euJBVKWXZvJUjAPdMh7Q/hC656JMKSkp66ptzBgPcsLfslXJRX0ujdM9HGAy
	enSvQA8gWF+D3Q8jY6V80SI22YXAJoMEqCpC
X-Google-Smtp-Source: AGHT+IFIskecjwcV3BTTBpzH9S2j5V80AaBRDbVtEQoTgjHrPpiHHnoNJ2flDyZszDsdGQ6aVKgGOw==
X-Received: by 2002:a17:902:da88:b0:212:5786:7bb6 with SMTP id d9443c01a7336-21c353ef3abmr311395045ad.3.1737567660702;
        Wed, 22 Jan 2025 09:41:00 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2ce9ef97sm97733815ad.42.2025.01.22.09.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 09:41:00 -0800 (PST)
Date: Wed, 22 Jan 2025 09:40:57 -0800
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
Message-ID: <Z5EtqRrc_FAHbODM@LQ3V64L9R2>
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
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEvT=J4XrkGtPeiE+8fwLsMP_B-xebnocJV8c5_qQtCOTA@mail.gmail.com>

On Wed, Jan 22, 2025 at 02:12:46PM +0800, Jason Wang wrote:
> On Wed, Jan 22, 2025 at 3:11 AM Joe Damato <jdamato@fastly.com> wrote:
> >
> > Slight refactor to prepare the code for NAPI to queue mapping. No
> > functional changes.
> >
> > Signed-off-by: Joe Damato <jdamato@fastly.com>
> > Reviewed-by: Gerhard Engleder <gerhard@engleder-embedded.com>
> > Tested-by: Lei Yang <leiyang@redhat.com>
> > ---
> >  v2:
> >    - Previously patch 1 in the v1.
> >    - Added Reviewed-by and Tested-by tags to commit message. No
> >      functional changes.
> >
> >  drivers/net/virtio_net.c | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 7646ddd9bef7..cff18c66b54a 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -2789,7 +2789,8 @@ static void skb_recv_done(struct virtqueue *rvq)
> >         virtqueue_napi_schedule(&rq->napi, rvq);
> >  }
> >
> > -static void virtnet_napi_enable(struct virtqueue *vq, struct napi_struct *napi)
> > +static void virtnet_napi_do_enable(struct virtqueue *vq,
> > +                                  struct napi_struct *napi)
> >  {
> >         napi_enable(napi);
> 
> Nit: it might be better to not have this helper to avoid a misuse of
> this function directly.

Sorry, I'm probably missing something here.

Both virtnet_napi_enable and virtnet_napi_tx_enable need the logic
in virtnet_napi_do_enable.

Are you suggesting that I remove virtnet_napi_do_enable and repeat
the block of code in there twice (in virtnet_napi_enable and
virtnet_napi_tx_enable)?

Just seemed like a lot of code to repeat twice and a helper would be
cleaner?

Let me know; since net-next is closed there is a plenty of time to
get this to where you'd like it to be before new code is accepted.

> Other than this.
> 
> Acked-by: Jason Wang <jasowang@redhat.com>

Thanks.
