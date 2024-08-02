Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183661C2AD
	for <virtualization@lists.linux.dev>; Fri,  2 Aug 2024 02:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722567322; cv=none; b=QciolQhxbwpz+M5MnFq93KQ69vKoiYhZ6o5c+o631sWzwcB6c8V7y5NjRU3MyvyeQ/X+WXOtjHE6Pb+vyxwNCjM1TceLZ4NeH1FinYfe+X0MooV+948aYKnIkXeFDxS41dLn85CazBaLEooSBJI1xNTftb2Dg8F4Sg+8n0lizRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722567322; c=relaxed/simple;
	bh=K4xoLpkZ6BwH3cmnGonrRZ9W1NOI6AkuT9StzCmYZVM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rB6CxL9XlMVrJ7tWMfnYfGHHG3gip/AHTy9d1AxJgjELN1kB01Oa71t8YdwliQNMFYa/DwjtFOrZgOFrJgk8YLjR8gI26Mb20XvkqMFITrIxkGKAO2k4Q4KolRSMl1Wz5VDYc7X2mHvUXacWLc2ijlzRZY6BR5oDuwpF7AL0WoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gZNVvxGS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gZNVvxGS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722567318;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qBdueG4+2+xR+07KsJ4mUB3qhmEq0wrfejgSN+9Z9CQ=;
	b=gZNVvxGSHw6H/VGVQgk5/DTkBjNxV5buMN/c/zAlNnRpT83GhkrNIhUvWnl1XT17wIocb3
	OygMh/722Qkdgp3e5Pn/yYqFumTwYEFNZJh3tDxdI177XnuVbNz7KIT5oI7ndr7q+uWDdh
	Nz98PMKMfHgbAhXu+652CP6s0u5DhLE=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-578-tmJU5TbfPWeedDn3l85plQ-1; Thu, 01 Aug 2024 22:55:16 -0400
X-MC-Unique: tmJU5TbfPWeedDn3l85plQ-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2cb4bcd9671so10055088a91.1
        for <virtualization@lists.linux.dev>; Thu, 01 Aug 2024 19:55:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722567315; x=1723172115;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qBdueG4+2+xR+07KsJ4mUB3qhmEq0wrfejgSN+9Z9CQ=;
        b=HWlTR40ZvvWoCCWp8g9mL30OghzAofJtv7iMyBqK4fDpdeg5IAiQ4i8GWeYNJz78sD
         tJUXljri/wbvn5CZGzmFtLkh3XxQ6CCnhy9Qh8pQ3vevUTiARFy8czLK159kxuLCGZrO
         aIylUmANqIpTBsVVLn4SzsjrzpRj++CefWHibh+b9Zi4aORgR29kckSVpGCtfgecAVdk
         d35c/eLiMca/Lo3pA340VcgszV8dELv+Z97fwLqSj2c9FpSeoykTW/ktfITSYkKbGkIX
         EHY6xoGYNRGqFvXu9F76K8njBeWCwY2nIxK5s220vXKRTsB+C3WcNFuAjWUmXVFCTCWt
         pHWg==
X-Forwarded-Encrypted: i=1; AJvYcCXEqyFtwstEYZewEPb9wgZArmBM+vuBoxjIGawbEoK+biafp6IAf5kWEYEHz17O09sAvsgN7Zx04FEIJaBCl+YeQkuM0mmxW2yzAyhd0fw=
X-Gm-Message-State: AOJu0YxeoHJju8llojwaUcOrEWljWGxA8JBZ5SdyOkM+b6ffQCWQMouP
	eOYLZAxn8Fzppq07QwwqrAYi/x2phqRfd+mTffWRTlvpgqpI8gqUGmizyYiieBsIeGU+jKFUqVz
	SWvQ5vuaN1855rlgXEbnPtos1//vGcqrg0tzZvtHEiWsFIuZ5yijWspa1VpLoAM0UVipZuDqnEJ
	yvmSwUpzVqII/kS+hmAyvZi1vp2JEAB6OKfAg+UCE=
X-Received: by 2002:a17:90b:33ca:b0:2ca:d1dc:47e2 with SMTP id 98e67ed59e1d1-2cff9559d93mr2787839a91.33.1722567315121;
        Thu, 01 Aug 2024 19:55:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRq+tQFKs9EteORmxL/nkd8DIBEa3fxroeU6VOvZY8mZ7YjkWhizQtBG+HeQFWezhpE3EcMFHeQEUCYHijGbw=
X-Received: by 2002:a17:90b:33ca:b0:2ca:d1dc:47e2 with SMTP id
 98e67ed59e1d1-2cff9559d93mr2787814a91.33.1722567314583; Thu, 01 Aug 2024
 19:55:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240801132338.107025-1-hengqi@linux.alibaba.com> <20240801132338.107025-2-hengqi@linux.alibaba.com>
In-Reply-To: <20240801132338.107025-2-hengqi@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 2 Aug 2024 10:55:03 +0800
Message-ID: <CACGkMEtiLsg6NKNB3TmwchxB-MbBYBnnsEJh1Cq3gHh1K7djbQ@mail.gmail.com>
Subject: Re: [PATCH net v4 1/2] virtio-net: check feature before configuring
 the vq coalescing command
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev, 
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	"David S. Miller" <davem@davemloft.net>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 1, 2024 at 9:23=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.com> w=
rote:
>
> Virtio spec says:
>
>         The driver MUST have negotiated the VIRTIO_NET_F_VQ_NOTF_COAL
>         feature when issuing commands VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET
>         and VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET.
>
> So we add the feature negotiation check to
> virtnet_send_{r,t}x_ctrl_coal_vq_cmd as a basis for the next bugfix patch=
.
>
> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

