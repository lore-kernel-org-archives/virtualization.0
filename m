Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C223806C6
	for <virtualization@lists.linux.dev>; Sat, 14 Mar 2026 20:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773519107; cv=pass; b=emT4AqKEZn9ANobZU/+3n7/4/MZjOIspeNYyWBqqhHJuc7V/EnfrFzE/R4CT3LgYpzlYL0eCMxpbDgLdwagU1O7EHh7K86aHsLto1ngj/oEDSU2TDIEJnyVURlXXOHA8YYhYDKUfeIMtp1mdbKxLqTedw/0BFesDwVgdRGg6fJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773519107; c=relaxed/simple;
	bh=WkoXS075KSuaK6414fUI51pkZ2edKA0Qw+i5/cmums8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=emhpN2nTpox3RNEnC3wadk4hi+NG4kSQS96StRSicpL5/50dzxdiOFpebToIYBCtKp5HoyujgzlX8ZkLTYsTiu2Ey3UQBYi8zQSusWTqhZO4oVBsrgNWL37AqIORkWmwFSoNOzjFrQBCamc45BQ1XbLjFrh2AuTk4UPW1hqZpjg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Fr+RGEGh; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fr+RGEGh"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-50919fc3a14so38887591cf.2
        for <virtualization@lists.linux.dev>; Sat, 14 Mar 2026 13:11:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773519105; cv=none;
        d=google.com; s=arc-20240605;
        b=SFiVPnStkZD5+g8Hb8G0iHwWZkY/blJvJ45vNhcuoGZhcZCgl2pkB5oBNDyWDmerVX
         0+nI/+tqGRBJBrnxwP3Nm3bylDMQbalxUrL77huEfx4oUdO7cVr83Ky312waQATUiKiS
         yNx+IcNSCYgcUV6awaKMwWTR0+Pq0NES1F0MW2roFou4Y19a1JqROQTRAQYmI/UJ6qqe
         JeTZm7V3cQ7VXbHKlwkoAFPGSOBlR0j4RZUmbbZuDHGfMQYWOKlPRJC5PdXI854At6U5
         kqEhu2AguH2cR5jXYKmh162wt0DDuFSm+KD24SmMTDUJQVD//yEixQ7grvEl9fE3efBL
         Hcpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wNJU/EqgLDF0Q3nkWlyJwfLqn0QHXXY9993On9npY90=;
        fh=8cS6Fqdvp6l4udu3zMEwFP51yDCoOywW2rEdC13O+74=;
        b=SmOY7/DVT2aspUJ09IYHapBsvEwHW6KVT/tLbk4AqEYMLdTavHkbTPuh2YOSTyM8yR
         srycnuNBnITdrKPiHO6iWnSYYzM8GFVXl/SkcHJB2PIBYmMJEtHSwkeR0nyNak8+Wk/X
         j5VoxSWxpT/zh7uD7kBeGLs7zRyncHmqeuA7U7Uq3RlqI0FTIziHtGi+kB9xdLh8cqZS
         xuwGUYJpIfwr7Pv6cS3cPZsm2jON4s252sov+H+CdfQJfJ0ofHqpL19/PiI78vCQd0is
         9YZ+iIYXgxfMb1GypYy8POEmaGWJmcasoQmMCoHssWpbywlbXkXQi+OU6WHvLVH82U9p
         gwBw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773519105; x=1774123905; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wNJU/EqgLDF0Q3nkWlyJwfLqn0QHXXY9993On9npY90=;
        b=Fr+RGEGhRrQmOrnSnm/32F7u32NIjdjf7ATlExFzmnpsMjejVOh7c1uIxLi530rL1I
         evJbyAI0gZuAXpTGjthEVNwfOHhFVUG8smztl8QORWm8jl9ofIjyzJ8YmVnFTZiWgfdw
         GG+AyNTXfhb2jJmPOrWsuJWLsWslOo0RrUnQWlvFQNEXA5pudEPI18ArrB53LBmD9iBI
         ioB+qYR855CP4jaCUUeZjTBkaYyzFS6T0DIiBLOPa+cs9p/iWYnw/9qeo6IKoejGupHi
         chTNtpLy8h4+uofSXkMl57aJ2lw9NeUOQnOciCf+x4AY3kNZ9CsudSW3S5L/f0mbHU+e
         H0tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773519105; x=1774123905;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wNJU/EqgLDF0Q3nkWlyJwfLqn0QHXXY9993On9npY90=;
        b=ZclscYlRluWFrtAuPn98x6GzfB56SEfowBBC4Gn3JMB5wtRMaOWwYCY906lGVG62UN
         E4ockCtufomMl6IofsjHUbrdMBSbDLEW/0eSmQ0zKzwc2Xuf0I+B74Go5jZBABifIQZb
         UWpXidC0yfSzaXojrdCIivBn1iefPtfT2P1Ek+GrncYZ4XO8xrUxc7Np2RpXEbNWsdB+
         Z3nvI9dBqSo+13VKDssfcZrF1RIoreJa83mnVsJ9RbRhXeCsW4bUmle51ZLNz0VnvAQE
         0aq2C4lsF1mbh+HpQTMznmckjh24WreDRyRMoWHWrOEE9QAATlW+XCvUw32pt6+wkZ/k
         hqCg==
X-Forwarded-Encrypted: i=1; AJvYcCWJdGnSq6L4gj0RfO75A4GxIVIcmTcGnRA9vOLBsVyDd+a4XYilI4cUyt8380w3qqbB5JpYqu1L+sCAVlhQTg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzibyWU1Ab4OcA5uyhh1IjNAVyah6ig/YY3LpNFDtFgJbbKdnzF
	fMQTHVDeeNuJMIFJqeoe+Sc4h2/uU7Nn8WXoU45onPuq7JbKE8hcCOeK6Q+B7eqLA2BruZBgToE
	GKSZNeRITV1ryJCyolPnD9zvD4xPnqSVkCGEjHc2n
X-Gm-Gg: ATEYQzxUSgr1Blwj+OtQe4OOAfy3pvxzVno73MrkJDnpJeZBqnlHlfEJJAqqWyyiuZ6
	q5Qp2xziGXN/KKm8p4Bjxk8UVj38re/3LyuFM2EZYGM0xHYvMhlpSSk2an8WgSqpHZHYdj0xUqY
	6jJ8M5+X9G/YIDN/oeLAjMnlQwFpIZM158pEpYkid9t8a+9WztYdnMHWkSB5aRMN9T1/i7n+6fy
	s7YBhpq2FsrmxCkEI1Xf5f7CbWfxbQddEC1Z+SmO/7lVqKFJHHM36m8wlAifUGB8r0ljFzgzDPL
	VpIjUCu4
X-Received: by 2002:a05:622a:1913:b0:509:1cf9:ea0e with SMTP id
 d75a77b69052e-50957e6d9ebmr106751231cf.41.1773519104360; Sat, 14 Mar 2026
 13:11:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260312025406.15641-1-xietangxin@yeah.net> <20260314124017.59206dac@kernel.org>
In-Reply-To: <20260314124017.59206dac@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 14 Mar 2026 21:11:33 +0100
X-Gm-Features: AaiRm51U9n8JmYbi4nsFyK5po3qG7vw7KdHuv209pKgETRH95O2uglDU7CC6gfk
Message-ID: <CANn89iJHp+nCcAo7tzMTfH5yW2qDsEXP_u=RzdV=DC9ZvDH9Fg@mail.gmail.com>
Subject: Re: [PATCH net v2] virtio_net: Fix UAF on dst_ops when
 IFF_XMIT_DST_RELEASE is cleared and napi_tx is false
To: Jakub Kicinski <kuba@kernel.org>
Cc: xietangxin <xietangxin@yeah.net>, "Michael S . Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, "David S . Miller" <davem@davemloft.net>, 
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 14, 2026 at 8:40=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Thu, 12 Mar 2026 10:54:06 +0800 xietangxin wrote:
> > Fixes: f2fc6a54585a ("[NETNS][IPV6] route6 - move ip6_dst_ops inside th=
e network namespace")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: xietangxin <xietangxin@yeah.net>
>
> The Fixes tag should be:
>
> Fixes: 0287587884b1 ("net: better IFF_XMIT_DST_RELEASE support")

I disagree

What was the situation before this patch ?

I think virtio_net has been able to hold skbs way before
IFF_XMIT_DST_RELEASE has been invented.

Some archeology :

commit 93f154b594fe47e4a7e5358b309add449a046cd3
Author: Eric Dumazet <dada1@cosmosbay.com>
Date:   Mon May 18 22:19:19 2009 -0700

    net: release dst entry in dev_hard_start_xmit()

But really at that time struct dst_ops was not per netns

The bug came when each netns got a copy of "stuct dst_ops"

Not sure if 'fixing' virtio_net is enough. We really need to check all
other drivers that might hold skb with dst for more than an RCU grace
period.

Or... not count dst anymore. What is the point anyway ?
