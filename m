Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689C44AECB
	for <virtualization@lists.linux.dev>; Wed, 26 Jun 2024 01:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719367132; cv=none; b=t0yHS+TYGTD62fnmQDlGd5DGiM7rgUre7LXWqY/DGT7Q2cJ4y5iSXW4dtsO5WKWLtxsmVDhrbidq4sIKoklaEsY2U7s4SOLc9/CyDeXHUYA8xINMxU7DMOYlKu1ZIVmEqOOqgyj5t3VI+cF0wGjR4mpMdCXyxcbliia28+3Y4ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719367132; c=relaxed/simple;
	bh=GnG1sbGbs1jtmTvlrH54yNuEYDYvf8DpjOgAllIIWYk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YGJhN9iXWOBPkFVAW8xlKccWnYZA9lKGRHcidU2+7L/R5I9VdwlKasmKVBX2rcbPlQvHRjkx1I/3+Z4fBp/R6XmLl0LTldrpWaUFi1k96ifql+61OojSfyjUl5hqYIjuYs68grv9ZCGqpvK5eeHgFpIgYk9TnkmGjQEpv56EquM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YWD4xoor; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YWD4xoor"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719367130;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GnG1sbGbs1jtmTvlrH54yNuEYDYvf8DpjOgAllIIWYk=;
	b=YWD4xoorAwzQs3zU2jATGNTNmeD89KWOmU6kGQ8tXinlgtpjYgzMVqn4Nsj1RNxhfT4+Oc
	JA+4hvCBWWoYx4rSslftuotwidCVjM1jpWBuglOJoVnhJFaznNY4M8DjhDJv9UQ5et65IT
	rLvwnrr/71FanPPa3UiidIURjk3XNpo=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-455-A1cJeGE_O0qpQ1PnpOaKKQ-1; Tue, 25 Jun 2024 21:58:47 -0400
X-MC-Unique: A1cJeGE_O0qpQ1PnpOaKKQ-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2c7ef1fcf68so6989998a91.1
        for <virtualization@lists.linux.dev>; Tue, 25 Jun 2024 18:58:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719367126; x=1719971926;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GnG1sbGbs1jtmTvlrH54yNuEYDYvf8DpjOgAllIIWYk=;
        b=OAa19D/Z+nbzWf5HJmLxucwGhW1+/VzOTou92RhHR8S6UAdQ88aWhOSDSfDvOc3DAR
         rrMlYLy5cgbW/fEVWo2K08YXPeCFtZ1jtqi2XRlGyLBC09aXv78efGRpwLza8S/JTR5f
         GY7lFYSqPup/iXvIZYWKKNTwQRr9MMn+afLrCUOwV7k06VaYexyFVTDw/TMLq5y/MmmL
         cRbeOxU0xJRBen6WO/8UCPYXk0BbHZby5Rj4Bds94kUZulrZKtSYhdLCRSjMDhyGpLUe
         f6xZ742dJLsMwuKQdK2UG/WYGMOBqQMnECvWzDFMtyTvM3UHYoJ9UHj47a7nhhYnctsv
         L6eQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBxfrv2EqtF976rsoNaMjiP3Qi1sSf5ZVjcuIgnRYHztINVYCebQ3sYrOBPMVxe8AaTOslWvIHNirCRdUPt4etePWF+pJKdG+bDAUxmy8=
X-Gm-Message-State: AOJu0Yyx2dGgTcuHV1BhKlvDtxQf8jI3IkxlXwdIsN+gFKEfhXS1XkNU
	SYyDZzs388PVg9fNvEFZgMw8Q7H0+SAYN42BOV0CBZCGTSjC44vXNmn4/W9TBDKzKzqNrCXaBP4
	Jy+moVjIID6dZgw7A1Bx2fj1jlz4WFOPCve2YvaYf545xBzXzYxfC62D3/a23NHIYDljx0bzFfT
	N8DI8iFFoTC89Z5meVnj7ZGGUC+ToO3FcPb9FMFrO9GJPvGkxf0Q==
X-Received: by 2002:a17:90a:d98e:b0:2c4:b8e1:89b0 with SMTP id 98e67ed59e1d1-2c850573e58mr8416512a91.30.1719367126327;
        Tue, 25 Jun 2024 18:58:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5cItPu7kw+lpFHgT9mFcrgcyIi3eaohdOBIsIuRQUoMjB36Oowm0mQq7gn7+W9fkMRWr+6IMsheb7X2K6btw=
X-Received: by 2002:a17:90a:d98e:b0:2c4:b8e1:89b0 with SMTP id
 98e67ed59e1d1-2c850573e58mr8416498a91.30.1719367125794; Tue, 25 Jun 2024
 18:58:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240624024523.34272-1-jasowang@redhat.com> <20240624024523.34272-4-jasowang@redhat.com>
 <20240624060057-mutt-send-email-mst@kernel.org> <CACGkMEsysbded3xvU=qq6L_SmR0jmfvXdbthpZ0ERJoQhveZ3w@mail.gmail.com>
 <20240625031455-mutt-send-email-mst@kernel.org> <CACGkMEt4qnbiotLgBx+jHBSsd-k0UAVSxjHovfXk6iGd6uSCPg@mail.gmail.com>
 <20240625035638-mutt-send-email-mst@kernel.org> <CACGkMEtY1waRRWOKvmq36Wxio3tUGbTooTe-QqCMBFVDjOW-8w@mail.gmail.com>
 <20240625043206-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240625043206-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 26 Jun 2024 09:58:32 +0800
Message-ID: <CACGkMEvO+hAd-JeM-LEAavZqogEhSBPQRhSQK6hPMaVyEHH7jQ@mail.gmail.com>
Subject: Re: [PATCH V2 3/3] virtio-net: synchronize operstate with admin state
 on up/down
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, venkat.x.venkatsubra@oracle.com, 
	gia-khanh.nguyen@oracle.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2024 at 4:32=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Tue, Jun 25, 2024 at 04:11:05PM +0800, Jason Wang wrote:
> > On Tue, Jun 25, 2024 at 3:57=E2=80=AFPM Michael S. Tsirkin <mst@redhat.=
com> wrote:
> > >
> > > On Tue, Jun 25, 2024 at 03:46:44PM +0800, Jason Wang wrote:
> > > > Workqueue is used to serialize those so we won't lose any change.
> > >
> > > So we don't need to re-read then?
> > >
> >
> > We might have to re-read but I don't get why it is a problem for us.
> >
> > Thanks
>
> I don't think each ethtool command should force a full config read,
> is what I mean. Only do it if really needed.

We don't, as we will check config_pending there.

Thanks

>
> --
> MST
>

