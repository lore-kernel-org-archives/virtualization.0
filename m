Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F541864
	for <virtualization@lists.linux.dev>; Sun,  4 Feb 2024 01:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707009635; cv=none; b=C9iNxOaTLiRE6QNxcSaMD6T+Mxn8NyL4oFNEoMNGOoAwND6C5s2Xe6EocyQPdfEeyYGA6PDXRGmtO4VuJysqC/r2IJwEGsA6hlEsktZaowGAYYVyNrMTiOIQXv/YKX9kd5NYp2sKQaaKqYah52Wl7imhRMOE578DANuFlxL23VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707009635; c=relaxed/simple;
	bh=GrLn6m3UyHUH3/hc/boqpLQuQEwf0Xhn2F1etqYsfrw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kYjVurgpg58V9OJHFMfV3+Uo5eFHakfKLbNmaFfpS27Twjg5huUlrBmG3l4Wwk7uXoDPsANFglkuqLwaI/XoCJgB3X4JBpcIRyZmEFClg6uORJ6P7t1iy9cs2JH1fDbMORm4BJSt5lUJ2aQwFZfZ+9PAIUV5sHRja7hj+aIwhe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VbOP3nku; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VbOP3nku"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707009632;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GrLn6m3UyHUH3/hc/boqpLQuQEwf0Xhn2F1etqYsfrw=;
	b=VbOP3nku89BtM+p7ZgKTjZZPjaGlzc/cFB7pf1Eu3F4d5fX3EaqgfAomtTC1TwW6PZCd2k
	IzKACsTQBBCT7xPE9slcOSAhHslNQVevLWgzXwphrVkuJTVhUEFuwSmFDfusiD24IZ3M74
	MATL29NSDZCzFxhUnUPYzmIRHdN7/x0=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-416-p2NmYqMbPhmHfvGQcx4ZzA-1; Sat, 03 Feb 2024 20:20:31 -0500
X-MC-Unique: p2NmYqMbPhmHfvGQcx4ZzA-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-6e0382c0447so396871b3a.3
        for <virtualization@lists.linux.dev>; Sat, 03 Feb 2024 17:20:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707009630; x=1707614430;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GrLn6m3UyHUH3/hc/boqpLQuQEwf0Xhn2F1etqYsfrw=;
        b=fp7OSN41RNAnTJKWBt00vpDvU6AIM++nOpnYZnL0NuZHp2l/RcMSeWSNym+wBar6rg
         PGrps3P8DtTdbWc8zC6ZVY4Ylg0lrFb7Ve39pNL/aQoMD9kg0SI0aJ4srwgmGpgMHOme
         hghjTjYSfdchUMwrnqapKhLCCTnUhgdleOPOaGldQgh8R8q7J6iDEJf8XEDxaUYQAxMe
         R69iw9+BUufBBmZ6a7PHrrt21Bsd63IdxNWCveZ/jkcIeFY2OLSJq7UKLGzKsXm2nyjb
         v8lSIpZQKycCkTOSCCzpSMND1e48DtMYyxceJyIUYInyb+EidqQCoWxMiOvbS6m/aJxA
         yK7Q==
X-Gm-Message-State: AOJu0Yzd6ZmEMESSLxUQBxr/CVw0jsJW+ZwAMXj5B634H4rHFrmcpDds
	PG5FNm4XeRz67XQKcyF+zrovF0FkAzXj3sHiOn7HQr9MJqEfLSSWfWWWQT5OLHEAIzwbeqaRV7i
	z3rTaNUI0t+RNO4FebYFVT1nhTOzz9CKzjRatZv/zMvk5fjZrsNNTGj1/fF/RXz6dnGf6yannzk
	ryjleHlWGKmVexbn8sfstgu+r7OhGFtL6qu6/TyXA=
X-Received: by 2002:a05:6a00:2d9e:b0:6e0:39eb:4458 with SMTP id fb30-20020a056a002d9e00b006e039eb4458mr740457pfb.13.1707009629938;
        Sat, 03 Feb 2024 17:20:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEpEqw0qeg+3LkvyM090gl2kRntiMNEEAMPcCtEOcygOBp3Ndl+KISIbO/hY3TpjCUGrq5QZrOz0t80A5hhj10=
X-Received: by 2002:a05:6a00:2d9e:b0:6e0:39eb:4458 with SMTP id
 fb30-20020a056a002d9e00b006e039eb4458mr740448pfb.13.1707009629660; Sat, 03
 Feb 2024 17:20:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240130142521.18593-1-danielj@nvidia.com> <20240130095645-mutt-send-email-mst@kernel.org>
 <CH0PR12MB85809CB7678CADCC892B2259C97D2@CH0PR12MB8580.namprd12.prod.outlook.com>
 <20240130104107-mutt-send-email-mst@kernel.org> <CH0PR12MB8580CCF10308B9935810C21DC97D2@CH0PR12MB8580.namprd12.prod.outlook.com>
 <20240130105246-mutt-send-email-mst@kernel.org> <CH0PR12MB858067B9DB6BCEE10519F957C97D2@CH0PR12MB8580.namprd12.prod.outlook.com>
 <CAL+tcoCsT6UJ=2zxL-=0n7sQ2vPC5ybnQk9bGhF6PexZN=-29Q@mail.gmail.com>
 <20240201202106.25d6dc93@kernel.org> <CAL+tcoCs6x7=rBj50g2cMjwLjLOKs9xy1ZZBwSQs8bLfzm=B7Q@mail.gmail.com>
 <20240202080126.72598eef@kernel.org>
In-Reply-To: <20240202080126.72598eef@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Sun, 4 Feb 2024 09:20:18 +0800
Message-ID: <CACGkMEu0x9zr09DChJtnTP4R-Tot=5gAYb3Tx2V1EMbEk3oEGw@mail.gmail.com>
Subject: Re: [PATCH net-next] virtio_net: Add TX stop and wake counters
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jason Xing <kerneljasonxing@gmail.com>, Daniel Jurgens <danielj@nvidia.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>, 
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, 
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>, 
	"abeni@redhat.com" <abeni@redhat.com>, Parav Pandit <parav@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 3, 2024 at 12:01=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Fri, 2 Feb 2024 14:52:59 +0800 Jason Xing wrote:
> > > Can you say more? I'm curious what's your use case.
> >
> > I'm not working at Nvidia, so my point of view may differ from theirs.
> > From what I can tell is that those two counters help me narrow down
> > the range if I have to diagnose/debug some issues.
>
> right, i'm asking to collect useful debugging tricks, nothing against
> the patch itself :)
>
> > 1) I sometimes notice that if some irq is held too long (say, one
> > simple case: output of printk printed to the console), those two
> > counters can reflect the issue.
> > 2) Similarly in virtio net, recently I traced such counters the
> > current kernel does not have and it turned out that one of the output
> > queues in the backend behaves badly.
> > ...
> >
> > Stop/wake queue counters may not show directly the root cause of the
> > issue, but help us 'guess' to some extent.
>
> I'm surprised you say you can detect stall-related issues with this.
> I guess virtio doesn't have BQL support, which makes it special.

Yes, virtio-net has a legacy orphan mode, this is something that needs
to be dropped in the future. This would make BQL much more easier to
be implemented.

> Normal HW drivers with BQL almost never stop the queue by themselves.
> I mean - if they do, and BQL is active, then the system is probably
> misconfigured (queue is too short). This is what we use at Meta to
> detect stalls in drivers with BQL:
>
> https://lore.kernel.org/all/20240131102150.728960-3-leitao@debian.org/
>
> Daniel, I think this may be a good enough excuse to add per-queue stats
> to the netdev genl family, if you're up for that. LMK if you want more
> info, otherwise I guess ethtool -S is fine for now.
>

Thanks

