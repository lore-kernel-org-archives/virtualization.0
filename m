Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E16A261B67
	for <virtualization@lists.linux.dev>; Mon, 29 Sep 2025 07:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759132533; cv=none; b=bhHRSSJ1svyeBLTqJSUBjsDjhHYW1LeCcLOm9BDOiBs1S4LvwvKF1oEFg01sRTv8apoyWY4w4EzsWkC2EOuOt69xS0BeRuCHvhXaOVyFO4ZaLRh6eSZuxGS0sCJD7bABkYt3smBMN2dKSuS3RASeHE/WAjos8aKqM2zZ9oGIDOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759132533; c=relaxed/simple;
	bh=lqTu2Wn6YlBhGAcSVpHOpoNC68jYPa6E4hsETWv4xyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=WJ4qSNczBKoXKSzK6UeDLUzwbgsM265XgRks0SgI0c+PiZ81Z0E+r1QxUiUu3V5sj6DaiN0/z74Njt7/+iTh0xLUZYtDn4PFDQwBFKkWCGm3cdOL8XryKUff5H3j+eaMIt+7d6rkMZcKWvKtu2oQ2bC+K6wR237Lq5zaitBlmAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FqGJ0Cz5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FqGJ0Cz5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759132531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7Omunrqw51MkpkcIN+kqJsam42py8x8dM1K62pxn/zA=;
	b=FqGJ0Cz59v8ouEkRiqzINgGccTiTGbN5Rfrkt5tHZJ8+62NIv/fmYro6eTnP9K1hwoQTH7
	8nMqML3F1CN9zoxt6BEkNlGPOMo5S9IArrG92oG7bjMYC2iBcZ68r+2ccmFrR9MYU9Hhpu
	ryoTGGy/UNP6uLniYEShAzS4olfHTG4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-102-2j9Ryg4bMTWaR_G2NUGHiQ-1; Mon, 29 Sep 2025 03:55:29 -0400
X-MC-Unique: 2j9Ryg4bMTWaR_G2NUGHiQ-1
X-Mimecast-MFC-AGG-ID: 2j9Ryg4bMTWaR_G2NUGHiQ_1759132529
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3ecdd80ea44so2985477f8f.1
        for <virtualization@lists.linux.dev>; Mon, 29 Sep 2025 00:55:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759132528; x=1759737328;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Omunrqw51MkpkcIN+kqJsam42py8x8dM1K62pxn/zA=;
        b=JNthaM6LvJmX4/aeVpgb/q0WBzLrmyDY9Y8JCZfID++PFFvUxUyH7A6e6FtU/abk4w
         LHxIU3pWILsd35t2ZENHbneqXRUColq10ufLUOFS9YQD8L/i0D+FoWwA6JtOLo30SoO+
         wjRjgzXpb38eik88JXoOumzRPn+EH/ginUwCC2ZMCDG3t8TuuLyQX26z+dLurqbJNLnI
         cc8tR7+ET/9Pd/N/IGwkHDnK0WdaOJ9tC1lFBO89/qXWijSaEsgNgOaGNK5bjm1XV0ZX
         1O0DvQDQ/Te81hy6MIJWO1o/bi6L7jrwG6eSRxkY6mUGwwh237V8H8sTeM2CxO42IS9g
         vD3A==
X-Forwarded-Encrypted: i=1; AJvYcCX+nCfgFRBcNj3jGy6BFoJbytFca7RG4GdA87A5hwqdXmStdp+RR6K9Gxv4JGV1ZCf3MIResixWVXJx+bHIvQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwTKL9myP83i2bBPpBmrbw4MeZz8d0Bmki5Uurix6bI29Xlh0sP
	Cg9AHdQxcsxWWy4E8yE8I328oGYblRNno18TtScW6SxRs6a3fyHvBcHrhHPpgn0qMZMnart8dub
	YMmZt57G9d3sUg1SkFAZVJKh9rSBWCWkYx1NqaYLQ4+zL1XyK4TeP/AgD2BFtkCMokp9Q
X-Gm-Gg: ASbGncv7U8+/gGrOTTz7elFYuYC3qYS/xBvFQC8DvMOH09QWwIqiTLOipugMMia2HYQ
	s8PpHWhIQmZjSSkw9QTjMyKHJVIP07y8D+pjVq+Mw+eO5T554vCZ4br5LPA1vSEDsA7CeMJY7He
	rO3dsDTBS7F3GQP2GleIiQQCb3wNlL6mQub5cinDFa/ySawJzYabUxB8yRsBo/Otd6c0S4oXB5d
	a0BkWsEqvvujK7EDdXrExqBfeaEGYqgb/Ao8DXftSJ5tCdjEIBD++7KOZUzo1mk2srNk7jmqwFv
	wxUQpxu2Ez+Mr5mQrTF8/o9RU80TkDjJfA==
X-Received: by 2002:a05:6000:310e:b0:3f5:3578:e538 with SMTP id ffacd0b85a97d-4180686140emr6760217f8f.21.1759132528479;
        Mon, 29 Sep 2025 00:55:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZHcNFzklivkL5bSzSWgmb6E+omLFHKnQN2HGuL3HJ7RyfD1N604PNWqxQXEmEA9uXKAeybw==
X-Received: by 2002:a05:6000:310e:b0:3f5:3578:e538 with SMTP id ffacd0b85a97d-4180686140emr6760185f8f.21.1759132527990;
        Mon, 29 Sep 2025 00:55:27 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1518:6900:b69a:73e1:9698:9cd3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fc82f2ff6sm17002153f8f.56.2025.09.29.00.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 00:55:27 -0700 (PDT)
Date: Mon, 29 Sep 2025 03:55:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: Yongji Xie <xieyongji@bytedance.com>, linux-kernel@vger.kernel.org,
	Maxime Coquelin <mcoqueli@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Cindy Lu <lulu@redhat.com>,
	virtualization@lists.linux.dev, Laurent Vivier <lvivier@redhat.com>,
	jasowang@redhat.com
Subject: Re: [PATCH v5 3/6] vduse: add vq group support
Message-ID: <20250929035510-mutt-send-email-mst@kernel.org>
References: <20250926101432.2251301-1-eperezma@redhat.com>
 <20250926101432.2251301-4-eperezma@redhat.com>
 <20250926112622-mutt-send-email-mst@kernel.org>
 <CAJaqyWdeA5xcozCsaYD3_bQ6riN1pdDGHLpMGjU7ejZmNZ4qig@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CAJaqyWdeA5xcozCsaYD3_bQ6riN1pdDGHLpMGjU7ejZmNZ4qig@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: rL-FCZp-wGuSDogWIH17Qyy6u2OMUmuOnS_NHDq6Grc_1759132529
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, Sep 29, 2025 at 07:55:59AM +0200, Eugenio Perez Martin wrote:
> On Fri, Sep 26, 2025 at 5:27 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Fri, Sep 26, 2025 at 12:14:29PM +0200, Eugenio Pérez wrote:
> > > @@ -1859,6 +1894,7 @@ static int vduse_create_dev(struct vduse_dev_config *config,
> > >       dev->device_features = config->features;
> > >       dev->device_id = config->device_id;
> > >       dev->vendor_id = config->vendor_id;
> > > +     dev->ngroups = (dev->api_version < 1) ? 1 : config->ngroups;
> >
> > Is this < 1 same as VDUSE_API_VERSION_1? If so, maybe use that?
> >
> 
> The macro for v0 is called VDUSE_API_VERSION, so I think it is less
> intuitive to put:
> dev->api_version == VDUSE_API_VERSION
> 
> But I'm ok with the change if you want.

Confused. You mean "more intuitive"?

