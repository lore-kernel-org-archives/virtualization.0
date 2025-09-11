Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26A4314B75
	for <virtualization@lists.linux.dev>; Thu, 11 Sep 2025 13:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757598410; cv=none; b=mhyvcPSDo5eugomlssSO8kUPeKNv3CLBlu7kbR+ZGd9uNbYrh0aOJS5J0DyaR/K8W1vl3NtOs7fYstwZYqTkvFbpDVDjXoZuxRgpU0EhiG2wIa6wrnuiZ76jTcTapbrel22oK/fBopt8+xCUlMeAporInXUwGepYhvG6du22rlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757598410; c=relaxed/simple;
	bh=ZmND1jxWRj6B+QZKJOcM9mi5fG1sk8ssJasB6XluhTs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o9eiRL2SXmB0XDk4irjJ3wUMKZJcuLZ78ISbHnPE91WJZWfnTr73Tnp+5yr2Jr9s5OrRJ4f7ZtthB+Wm3yJKT10OWKKLvBIruH6Riz/mM8XSQYoH6pd7VZgihEKKBsoQPBB7gBM3+JNqzJKlO0H0LEiNYHmwIdbdSNJSmszWAkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XkcKBu/K; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XkcKBu/K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757598407;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nJomC7l8VyN+Oq6vLPb3hr3RXtewb7zgJ9BjC+tUcz8=;
	b=XkcKBu/KoceOo+7pvIdgl11CFJcgYTvadseoXT1o8jdb8Bj6Ps4yZKuwJM2af27BpeeTt2
	ZDIqcPdszVs4hmYfZcl21d/g31vU5UybMxXFgW7K+ZswFeBjPExBnMyXPR3uyUYAsuDUUA
	CAyiZul6UyW4FYxyKhI7BcbcJKW1wVk=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-540-C4LY2cInM7CUWy3eOw1SHA-1; Thu, 11 Sep 2025 09:46:46 -0400
X-MC-Unique: C4LY2cInM7CUWy3eOw1SHA-1
X-Mimecast-MFC-AGG-ID: C4LY2cInM7CUWy3eOw1SHA_1757598406
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-62297f39033so751003a12.0
        for <virtualization@lists.linux.dev>; Thu, 11 Sep 2025 06:46:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757598405; x=1758203205;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nJomC7l8VyN+Oq6vLPb3hr3RXtewb7zgJ9BjC+tUcz8=;
        b=bIP7vDH07MEuYGmEn0FfwtsMmelEZTbJGbpC/tjQUgn6H3hRtjf6pPzYHrHTmq+fZ2
         dBgLbWwn4MLkuFyDGZgeXlw5oLjn9DAZ0fHVo/cXqFxggpoMGRnNv6GucaI7Hs8FOWfY
         LObyCfWTYv3BSk+7Rz+QQ4XI2b/k1x5o6erlwmAXPYsBX/O5FM9KmXshclePc7Ew93Gm
         kHDy9Dtl5GUe2lmlt1y3iPelhjWRLk2sSUuiGKpm+Ga+3zk35kiv2Y3XJhs+8XPrkdCO
         y5ct2ewnUbaSDLgbBD/q+KfJrQeHkVgOpDal2mpj4aPJli0bPcSPKMYP9uDfMVCrf7Se
         IIBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjGwWY1l6dbi53UCx5c3X3aislSDV/aHKmMLQHrixHG+Y2LbdLUW5aM/43LS1VLJB67x/vqvqZL/8I/mKO/Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzkhmqf0ehB18wTiRVPsuzLo9QnWUn3rNUDYZk+OELjTPj7uvuK
	Gud8AjrfVSKXx5F1zHnZun3X+JAEFFTJbBmCiN6KM2b+es8bjZd80KZShGoFCVQTHPT7ozE6JIq
	5XhVE/SK3BWtDc/4PX+bSPUZeXXOCrINyfG9s5spVguteK0IfyZg0ju/0ImYoXBRIbD2Qetd+rg
	8/a1DwWj7GA4Kv2oSJIaW8bjAYwA/aS/zA+UuhzX12D9o=
X-Gm-Gg: ASbGncvZaKzdT4tktuu4i9qsb339EVAouoIH7K7rQNFVH3NO3LuHDVu+xzALZVQehCE
	H6y+jWKKsmSm3js9I7Tg7zA83cRHEvYvHINJ3QgPZnNVvT38Vttul0Tbqqe/7ooGPoSPqcDkmq1
	KX9vBEPpaq/5iVJ6VEScGJhg==
X-Received: by 2002:a05:6402:26c9:b0:62d:cb6:687e with SMTP id 4fb4d7f45d1cf-62d0cb66ba8mr6743597a12.24.1757598405264;
        Thu, 11 Sep 2025 06:46:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYG2o1FnjP9fsGPNzEo0BUw+nYr83QFU96UG32+VUh0e4aiIiyaWkEAie1/ZcB53x8WRZUc+uqk8px+C1mwx4=
X-Received: by 2002:a05:6402:26c9:b0:62d:cb6:687e with SMTP id
 4fb4d7f45d1cf-62d0cb66ba8mr6743564a12.24.1757598404790; Thu, 11 Sep 2025
 06:46:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250909-gxrings-v1-0-634282f06a54@debian.org>
In-Reply-To: <20250909-gxrings-v1-0-634282f06a54@debian.org>
From: Lei Yang <leiyang@redhat.com>
Date: Thu, 11 Sep 2025 21:46:06 +0800
X-Gm-Features: AS18NWD3xSVbl1wxOC8rlYtjyCxzlP11W8_KCY05l5fYLzSO6dDLpasmfV_vh8w
Message-ID: <CAPpAL=w8=V1O_d99+3rxXRmF1k9nQCAJeS-gSm=DCYYFABZg3Q@mail.gmail.com>
Subject: Re: [PATCH net-next 0/7] net: ethtool: add dedicated GRXRINGS driver callbacks
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, kuba@kernel.org, 
	Simon Horman <horms@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
	kernel-team@meta.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _cpfdveBefHKJECjlVvv0INWjyDAPzBeNYv-OunL4gM_1757598406
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Tested this patch with virtio-net regression tests, everything works fine.

Tested-by: Lei Yang <leiyang@redhat.com>


On Wed, Sep 10, 2025 at 4:24=E2=80=AFAM Breno Leitao <leitao@debian.org> wr=
ote:
>
> This patchset introduces a new dedicated ethtool_ops callback,
> .get_rx_ring_count, which enables drivers to provide the number of RX
> rings directly, improving efficiency and clarity in RX ring queries and
> RSS configuration.
>
> Number of drivers no implement .get_rxnfc just to report the ring count,
> so, having a proper callback makes sense and simplify .get_rxnfc.
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
> ---
> Changes from RFC:
> - Renaming and changing the return type of .get_rxrings() callback (Jakub=
)
> - Add the docstring format for the new callback (Simon)
> - Remove the unecessary WARN_ONCE() (Jakub)
> - Link to RFC: https://lore.kernel.org/r/20250905-gxrings-v1-0-984fc471f2=
8f@debian.org
>
> ---
> Breno Leitao (7):
>       net: ethtool: pass the num of RX rings directly to ethtool_copy_val=
idate_indir
>       net: ethtool: add support for ETHTOOL_GRXRINGS ioctl
>       net: ethtool: remove the duplicated handling from ethtool_get_rxrin=
gs
>       net: ethtool: add get_rx_ring_count callback to optimize RX ring qu=
eries
>       net: ethtool: update set_rxfh to use get_num_rxrings helper
>       net: ethtool: update set_rxfh_indir to use get_num_rxrings helper
>       net: virtio_net: add get_rxrings ethtool callback for RX ring queri=
es
>
>  drivers/net/virtio_net.c | 15 ++--------
>  include/linux/ethtool.h  |  2 ++
>  net/ethtool/ioctl.c      | 72 ++++++++++++++++++++++++++++++++++++++----=
------
>  3 files changed, 62 insertions(+), 27 deletions(-)
> ---
> base-commit: 9f0730b063b436938ebb6371aecb12ec6ed896e9
> change-id: 20250905-gxrings-a2ec22ee2aec
>
> Best regards,
> --
> Breno Leitao <leitao@debian.org>
>
>

