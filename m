Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D2F27E076
	for <virtualization@lists.linux.dev>; Wed, 17 Sep 2025 06:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758091262; cv=none; b=oghWZ0OgI2lI0c8oRWFh7OyT2MX68QOAjeQxfMYEpowjwKn6PnURJf1h1Lgv3ze3exvBm9QX0O4vsMGtzRj4zCdeoT0EHQE5qzoQVOvoldKRLnw0VeWjDLp6e+Q+VnrrbmUB6vj5h/p8wpPfqfMT84acZCPyUAqa6EZDQIGzS1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758091262; c=relaxed/simple;
	bh=GTsD+zDHi5iUxyCHZCjNne7OiB64xj+ttr+pkOj+OwQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DRxDBja5eT5v0tveob8RxlXnaNw+JNEYp12fVWLI/xVkGTxBVlCLKYB9KsVciGR1o9C0jv73EJjDm8MRiHongq6NAdwUxKbrIkwTYEIE/CGQnX0Vsf4X+5K61sCLCJyWK5jNlm0o4LXPOyoqtvKayklHtnT50W+AKfhGSDD6gas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TsYit2XW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TsYit2XW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758091259;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LTbbBlln6DCFneAUqcEqgaH8223TNkqnZLXB2rPiJQQ=;
	b=TsYit2XWG+q/zCqkZemU2sfVZ597u7sAIosRsIKKbNbkV0VaKZxV57eWOYcO033fEARUJX
	d3vy8Mo8nWt/W35H1qFMiO4LhqWiN2j7os3CfhQoktdmHrEDY2XYaON/uoF0oNTDltVGrV
	sowSyKuDyaLjeEHj3KqPHzfD8uRXibs=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-TXVzYGlgNmO-vs8PvCjxeg-1; Wed, 17 Sep 2025 02:40:58 -0400
X-MC-Unique: TXVzYGlgNmO-vs8PvCjxeg-1
X-Mimecast-MFC-AGG-ID: TXVzYGlgNmO-vs8PvCjxeg_1758091257
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-62ed2de7ee8so5578953a12.2
        for <virtualization@lists.linux.dev>; Tue, 16 Sep 2025 23:40:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758091257; x=1758696057;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LTbbBlln6DCFneAUqcEqgaH8223TNkqnZLXB2rPiJQQ=;
        b=qlKeop6SPAHFAKCE3ZN7JHKgb1awazVziXYHbrtbTfddP6cmd4Ic3M29LmlfzMd9X5
         aroSsNlnG+fOBy4Cw+SYlEUSMuMfWQDkd1nUrhvJr69aADklmNDyhRPaYJylDSf0rCS4
         YwRBHHRGIVd/uIT4RPJ1JkYk1gu/ub154D3ctkdp4TFQ82bT7cFwjeS6owc6mv8Sj/Oc
         ygAfORXoKFbIw2IlN6iP4pAMpHq0ItBwACNEmSckwZflmqOYR/6Lqbiw9kmKeqripMfI
         yKRXERmpSwmb9o/YAYDMYss3/yub7nZJ48dFze3YK+XK7KeAT7spTeLF3+kLQeug1PCy
         zReA==
X-Forwarded-Encrypted: i=1; AJvYcCWJSsB/xibxdSKc1UCK2euMzo2GCu2+RIg29y+2JJP1u4kbaK4n1u09Je1rIxMBesO5Bpn5vGwAJGfNf37JBA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxexP4YFHiA5/LDwjrrjNP8nxVyDXLArFPbaxjIkSAvoha46nbf
	KYFQ1DP6SXDYTpJ9c+GTgfODWOxfkrAbL/6GT+ehAgTpbM9yes41NPSeS8ZIsT5BRajmdyUmrCt
	P1crnbVbS7tPaDVyt4DGWKYxdR219Lz+3jz560fVF2AEljeiWouO9mecq2Utu1fKuERI6m9mdkg
	TliKAfvJMwwHAZy5FoxparQZkwBFl7YTNtsD7BXv6o4js=
X-Gm-Gg: ASbGncs4pqtP+Iz5AoInZnMVHJlPpAddsKhoNuS0tJnbapuANUSWVsnBGxWBgW90elT
	M9m5ueuR4HOzbWHB5ur5CcRRR5VoUtjT77WpdIsDp8X1tNqNyldk7OYq3JF+09KY9PKxfNA3FJg
	11O2UBYhszkeP9FjU4OHaQOg==
X-Received: by 2002:a05:6402:40c8:b0:627:c739:ee36 with SMTP id 4fb4d7f45d1cf-62f83c34ad3mr933036a12.14.1758091256861;
        Tue, 16 Sep 2025 23:40:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHuCx8Wm2NjgvVx8aU5k6RVtZU9jl0CgUhRhEkRJ87iAGzVB+vCxFRz69dVnXZ4ziFgE912UQsq1iIuOuRI/cM=
X-Received: by 2002:a05:6402:40c8:b0:627:c739:ee36 with SMTP id
 4fb4d7f45d1cf-62f83c34ad3mr933005a12.14.1758091256362; Tue, 16 Sep 2025
 23:40:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250915-gxrings-v3-0-bfd717dbcaad@debian.org>
In-Reply-To: <20250915-gxrings-v3-0-bfd717dbcaad@debian.org>
From: Lei Yang <leiyang@redhat.com>
Date: Wed, 17 Sep 2025 14:40:19 +0800
X-Gm-Features: AS18NWAdyteJLjS2OkZ5AwPMlO36O2pUFdRp0nHMdxW5VJOQ-UMOLbGst0il8i0
Message-ID: <CAPpAL=wz5t4cMuVeksmpsv5aRyhJez=W4Uc2jOUqr7bNHHYJRw@mail.gmail.com>
Subject: Re: [PATCH net-next v3 0/8] net: ethtool: add dedicated GRXRINGS
 driver callbacks
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, kuba@kernel.org, 
	Simon Horman <horms@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
	kernel-team@meta.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: m-X_avRzDUVkgpDQgcLmX51YtZpm5nAh4IqSq70ZuMc_1758091257
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Tested this series of patches v3 with virtio-net regression tests,
everything works fine.

Tested-by: Lei Yang <leiyang@redhat.com>

On Mon, Sep 15, 2025 at 6:47=E2=80=AFPM Breno Leitao <leitao@debian.org> wr=
ote:
>
> This patchset introduces a new dedicated ethtool_ops callback,
> .get_rx_ring_count, which enables drivers to provide the number of RX
> rings directly, improving efficiency and clarity in RX ring queries and
> RSS configuration.
>
> Number of drivers implements .get_rxnfc callback just to report the ring
> count, so, having a proper callback makes sense and simplify .get_rxnfc
> (in some cases remove it completely).
>
> This has been suggested by Jakub, and follow the same idea as RXFH
> driver callbacks [1].
>
> This also port virtio_net to this new callback. Once there is consensus
> on this approach, I can start moving the drivers to this new callback.
>
> Link: https://lore.kernel.org/all/20250611145949.2674086-1-kuba@kernel.or=
g/ [1]
>
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> Tested-by: Lei Yang <leiyang@redhat.com>
> ---
> Changes in v3:
> - Make ethtool_get_rx_ring_count() non static and use it in rss_set_prep_=
indir()
> - Check return function of ethtool_get_rx_ring_count() in
>   ethtool_get_rx_ring_count() (Jakub)
> - Link to v2: https://lore.kernel.org/r/20250912-gxrings-v2-0-3c7a60bbeeb=
f@debian.org
>
> Changes in v2:
> - rename get_num_rxrings() to ethtool_get_rx_ring_count() (Jakub)
> - initialize struct ethtool_rxnfc() (Jakub)
> - Link to v1: https://lore.kernel.org/r/20250909-gxrings-v1-0-634282f06a5=
4@debian.org
> ---
> Changes v1 from RFC:
> - Renaming and changing the return type of .get_rxrings() callback (Jakub=
)
> - Add the docstring format for the new callback (Simon)
> - Remove the unecessary WARN_ONCE() (Jakub)
> - Link to RFC: https://lore.kernel.org/r/20250905-gxrings-v1-0-984fc471f2=
8f@debian.org
>
> ---
> Breno Leitao (8):
>       net: ethtool: pass the num of RX rings directly to ethtool_copy_val=
idate_indir
>       net: ethtool: add support for ETHTOOL_GRXRINGS ioctl
>       net: ethtool: remove the duplicated handling from ethtool_get_rxrin=
gs
>       net: ethtool: add get_rx_ring_count callback to optimize RX ring qu=
eries
>       net: ethtool: update set_rxfh to use ethtool_get_rx_ring_count help=
er
>       net: ethtool: update set_rxfh_indir to use ethtool_get_rx_ring_coun=
t helper
>       net: ethtool: use the new helper in rss_set_prep_indir()
>       net: virtio_net: add get_rxrings ethtool callback for RX ring queri=
es
>
>  drivers/net/virtio_net.c | 15 ++-------
>  include/linux/ethtool.h  |  2 ++
>  net/ethtool/common.h     |  2 ++
>  net/ethtool/ioctl.c      | 88 ++++++++++++++++++++++++++++++++++++++----=
------
>  net/ethtool/rss.c        | 15 ++++-----
>  5 files changed, 84 insertions(+), 38 deletions(-)
> ---
> base-commit: 5b5ba63a54cc7cb050fa734dbf495ffd63f9cbf7
> change-id: 20250905-gxrings-a2ec22ee2aec
>
> Best regards,
> --
> Breno Leitao <leitao@debian.org>
>

