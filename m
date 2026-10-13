Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD0D519901
	for <virtualization@lists.linux.dev>; Tue, 13 Oct 2026 14:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791902519; cv=pass; b=KgR0e5X231IiKXvsijeApsvDAJurIHeO+o/rMjktwWVMJn1IFMZoOBRLKIi33ehdkDmxTe6FbYIKKRUnv1SoSMDnYSTHBz8FC844WkW2hU5vI2mYWF7Grl2soT3EigH1y4LmRav6k+rlGdhXlYgoCz4fmFs/KIDtPyxnzGca430=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791902519; c=relaxed/simple;
	bh=qUs7w5ACRHy3GOBHYVZOyK+3nLYWhsG5Y+p+Px/cmc4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RcF58O3FfdrHIJsKT0LOHiIMix1UhAvIpirvH3s6RBPw6WSRxvRIzy1b9T6Z47kPEef0h6D6yDsB/ZOkwv/PicRxXN6LE9IHeiPqQNtrTNN45L/5BE4Divj+J70XlwzLyBRhUxFheK/VxIF6UQOcHq11uORaH+1+mYBF6fFY4BU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rdW8Ib+O; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rdW8Ib+O"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-675676afc3cso3047410d50.3
        for <virtualization@lists.linux.dev>; Tue, 13 Oct 2026 07:41:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791902517; cv=none;
        d=google.com; s=arc-20260327;
        b=iogI0aMe1QcFLkFhoYVPp74O3jti21QOe0X7Jufitpn+yxVp5WKueFGae7WIgipSdY
         EL03ErXFtvw8Rup5tOBYDNzg1FZOo7uOP0mYvbCBCC7BSXqwC9nW1vlViS/FkFnvS8LZ
         4tSFU482VsnHH0Eip9qB8NFNIr20xAr47zGbGQc1Lj1++bJ+vq24EYXcr5LlNgjERtrP
         md2jFk/lLxgK+22VZ+2BBoQ484MJrWfO3hHTwGXWEBXGEUzlvH2YPashBkbi2dOrpJhp
         Yf1zWzftIdC8dRMRlrKGd6EEXfvqJ5lUI2+eeWhhqCYNVW2yEGqYbpg+VkENco1XVQga
         5CDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=msz/OHbY6gDBK50SJeL3egmDDr6qQneSQ9CQTdw74V4=;
        fh=3DN85bOskq6QhUisFU4CqKE4tCnKkzRZeu9N3OITa9A=;
        b=UVTTq8ER+oNx68KVLzcy70+hKEAQeKOpZk5i/46MdgAzu87EoEAGnG6OP0zqq2M2Tx
         rHR6B4GLepf3iPI8bMjJ7Fx1sUDAtt/oRJt3+cLODEmJd64e9TMWrt52k0yAseNinYxJ
         RRAyKsQLYUcqN2wq4Q2O6EQf7qZ7Mlr6fOilobOOpPuoSYZY9W6CG8BP3AMd0zglIzTq
         BCwW7VaEf8mjc1ySbu/RAFLe34V4FX4mxiO5nd3Dr2888XmRjhvpCGxu50N4fBCd67cS
         ac319ObJ1vVhuEjNsyxDvIDgDfK9PBbwDl/HWZ9apFhAJTuMgHM+7TxAzJMsjJFzIWLA
         Awtw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791902517; x=1792507317; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=msz/OHbY6gDBK50SJeL3egmDDr6qQneSQ9CQTdw74V4=;
        b=rdW8Ib+O7fpBl852lgbyjMT6uBFZts4O1gKKJBbIkbSFdHTOFS3ZHg1Ml9PqjGGq6m
         rh4CO6kiMAmubwTOqjRaDNrt9r7GJQy+1rsyUUBKnS9k87LI7xsmdLWkYNzAKIa2lTa3
         ku41oVZxjaCzAW49l6x9sN1Fw4f17xOrdG3ftdGZni/qerpmKStT475t1Kxabt1XRMZ8
         YqZ7kBaoWsclM/rGo2s6wcyXH7Hdsn/EWfir3ylnmYYU7DZjFDDi65v5ZwbyTQ409H/F
         1ks84/R4/0pnNHGz+3UB4ut3Br6XonlQZfkre8susOVmP4c/XDLszIZ2zgZis2F8hlo7
         hy8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791902517; x=1792507317;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=msz/OHbY6gDBK50SJeL3egmDDr6qQneSQ9CQTdw74V4=;
        b=AnWXP4W5becG1jbTdYYDV0xgwo/vVSmvTLbr8ugEajWK7RvK441pyONld/XmGf+8HN
         7KebXIVOpTvF0yBPDfgSQkDDeRUUqFcQaKo5X3Ol9OEDl+2xiMiPwMhd0XUAP53bGcPV
         IjIB/Bn0SUuvVbGqLydvhZT/eyol6xHam1Y+gxEkI+vx817DtB0YYt7vgQZbadHma0j0
         +2rfKfUeHeQ7ivv94TBzBCSjZHsezT9DohsqJXaEEtGz27jR0KfEofsKpAZoRfKW8L2G
         a8RcY1PiD9zwmzROVNzg5h9cFbvow1HruXJRYyn0fu/ZMU8bYeSZIx+DCoaD75IHYP53
         uPiA==
X-Forwarded-Encrypted: i=1; AKwUvBwkDtmtSXlrQownyCrJ0RyIYW1yS/zriYLy3AAmtyUcdn4PMjON2B3tRE7G10TrXnmNZ3pipm7qJbjOOqpMQg==@lists.linux.dev
X-Gm-Message-State: AFq9FYJGhGaiG2x5S+IisJMsrLd7RTOpvV2ONUlwJgZl3RUeNet/QjSn
	Wfn+YClL7v6zipOMVoGHhi2JMPI6M2aHuSaByt4lO8aOzGN6x/p7rP3Dr82+gDk7SPQVwWAVDjG
	V2UKR4hPtQlEePdYYbLYuIRVX7qCDrDo=
X-Gm-Gg: AYBFou3PqQcCChybY0weHGp4KM2kfPmavXexUYdsIKYKjZzNel95dlU/vmTAFYB3SX7
	zOwP2wXb+JqkaOVasSakhbiMrcUH+XV634ukleuEbCv38QanSGKkSUjQ8hwznlFgVek0ArYG9dz
	+SS4CIZrSRifN5tjfC2xFMsEwiGXuQE7QH+r+nd9Z+WjQZj0Fw3leUmbVLj5g8aI5nxydX6uzJE
	nLkrwtASmBUsZJM0Rk8WdW4SjVH4m7CqC6HblK22jOMTJlIj5xExWoZW7XdVjsdg+7bzVjhQuyC
	+q+FuZt9hwZAzvCOLIZ7PPvo9G3NDby/Amr8sQ167JDV2XoZsB/whnoLPJwl7Q33cjBlKVdUUat
	s7ywWbdAEj01W5hXcIExqhCrrwDpCeviqRFMkF8YZcnQSqLvynGSdHSl37IWXotRabo+Bf7i/QQ
	==
X-Received: by 2002:a05:690e:4419:b0:676:9115:60e9 with SMTP id
 956f58d0204a3-6793628f4demr2875284d50.90.1791902517059; Tue, 13 Oct 2026
 07:41:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1791887415.git.mst@redhat.com>
In-Reply-To: <cover.1791887415.git.mst@redhat.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Tue, 13 Oct 2026 08:41:19 -0600
X-Gm-Features: AclHuK9vgLAAAJnijj2jNDp9uWMhQi6KN7iUpclgw57vpslbmAypj_7mfirQUWM
Message-ID: <CAF=yD-JhTbmYmHUkkruPcyvSWv0QhVeGWC=K=ZvvpMdkzA-jig@mail.gmail.com>
Subject: Re: [PATCH net-next 0/4] more virtio-net csum hardening
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Jason Wang <jasowangio@gmail.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, Max Krasnyansky <maxk@qualcomm.com>, 
	Paulos Yibelo <habte.yibelo@gmail.com>, Chris Arges <carges@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2026 at 4:58=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> Allowing untrusted hardware to specify csum start/offset for
> CHECKSUM_PARTIAL was not a good idea, because, if it edits the packet
> outside the actual checksum, and depending on the setup, the networking
> stack could be looking at the packet both before and after the edit, and
> seeing different results.
>
> Previously, commit 6785011f8b16 ("ipv4: validate checksum_start before
> completing checksum") validated all known instances where this
> causes the most grief, but the real fix is to make sure
> that either only actual checksum fields are ever edited,
> or the checksum is completed before the net stack looks at it,
> so it is always consistent.

+1 on the general approach of performing the checksum offload at
input, unless the input can easily be validated to be one of a few
common protocols. That greatly reduces the risk vs my previous attempt
at trying to drop.

Since we do not know the full extent of grief, I think this too should
go to net and stable. That would mean initially a single patch that
touches as few files as possible. The helper function in
include/linux/ip.h and conversion of existing open coded parsers to
use that can follow up later in net-next.


> This basically does this: checksum at ingress, except in a narrow list
> of specified known good cases.
>
> Fixes: f43798c27684 ("tun: Allow GSO using virtio_net_hdr")
>
> Michael S. Tsirkin (4):
>   net: add ip4_parse()
>   net: use ip4_parse() in receive validation
>   net: resolve uncommon partial checksums at ingress
>   net: account for ingress-resolved virtio net hdr state
