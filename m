Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E23B24EF65
	for <virtualization@lists.linux.dev>; Wed, 19 Mar 2025 01:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742348605; cv=none; b=hHZGd7tuwMyMQCq5CJ3ClxmrgZwo8059smfuY//0NY67uqYmOFtnwipnQEq0fgzaFRcy8NAG6F62Cu0MG2UYe4bQMI5udbqQIyCPn2VDnSxZsL8iah3eTubVz/WSk0PGNCY0BpuzkVPB6e5G0YXSXhXsT4wSIHf7TskF77O+3Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742348605; c=relaxed/simple;
	bh=vMQ1NxGAapHE6NnLtNfhVr4o56PmQKO6ToRg9ogrVb8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LShygvhlPe3+pxlP/0w7UfI4lo8VXn4k3P/313Q0YIQvLRQk+Q7BI7z6IZCAxqZdY886Rtbc+I8MR7/yJtFtvsRorRMgZik0vvFuJJr4sNbI7LmKvrBmzQ2QOoHQjg5li8ef2bQnuKyKkY1JuqjnivAN8gJXVIjA/AHfzr6jhl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JfdktLqD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JfdktLqD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742348603;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K5sLlh9CAsq5ZwTK4lMG7v2tALwodsO/DfUbIpuQvGo=;
	b=JfdktLqDrSRI/5asH9v5Al0duVuB1FV21MF07iyMZqA+hJG7qpvpr5OFEh+ZL3+PCiUsV+
	FNFpZ3L5zd+vQzPKXedR91+HcZgJHmnJwIXBnp9Sr1SqUi09mNNmPzeytQ17skYd5xY2CJ
	QPp5qAzkpg3XMotBzyKu4kGcwzvRVI4=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-206-rRodmSAjM8SA1P489sFF_w-1; Tue, 18 Mar 2025 21:43:22 -0400
X-MC-Unique: rRodmSAjM8SA1P489sFF_w-1
X-Mimecast-MFC-AGG-ID: rRodmSAjM8SA1P489sFF_w_1742348601
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2ff6aaa18e8so6308422a91.1
        for <virtualization@lists.linux.dev>; Tue, 18 Mar 2025 18:43:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742348601; x=1742953401;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K5sLlh9CAsq5ZwTK4lMG7v2tALwodsO/DfUbIpuQvGo=;
        b=WqwoyfPw/b2cN/y7z7NKQLey2mDHQqFlAcJDCj10yXAAHh8irEBzVJzfYNHTSGuhFj
         KPFOlubTAKZRK8CGPoyr+O8E3OU+7lN/Q4ByZdHc1ILKE61cN16h9SF2L8my3JppROB8
         4Et1PRb0nMjH/vdwOwZjiivRgYLnqhPX15JJxXEH/M1GpF37uF4hOyvfRQc3HYJCCKGG
         hEbEL22kkCHbbjLUr5EnbmCNRNBZsV1R/zPNFyuxrLUbJ7gWgMaxjthuoNQZKAoikaZD
         SC+lSf+YIxcxRDfHuZc0iRjhVibJadYUCWSyAW2KmkEKSCRkoa84l3H/U536RBsRy18Q
         s+sA==
X-Forwarded-Encrypted: i=1; AJvYcCWe3+wEa6/IHXAaTEz7JiWeUmA4DxsI7n+4C7HVvxMmAqSDy2qwb3SrZv5WAcho8XM3FBLcA/8BEdj8+DVP9Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YyqiPozihzWjhXVKXtsxPOvDRp4XiEDQQB0thBWG5S1cwoaJONd
	RuL8g8UYkqVN/ngmBpufbQs4FNezOFAwFgbKr4qzfoObNORsI7OIPg1+HWQmeyGMrKhHRzH6MSu
	M2tbRMhiSOQJAPaQLBqOkficbvy17D8WtaIGFPEPm+WzEk/marnuc9SjRS9/3fdhTvBMJW8nxN9
	SZMTDzPXRihNDeziurcPofqieurFJtWUqSJTso3qs=
X-Gm-Gg: ASbGnct6PvdrbHSMC6RMCOi6uFsHyVlQpMFcGV6iTP0J3bN1aocrXg2uF3s63+IBhke
	eDockZX2I1pbq5VzVeRTXGcggeXLIU/3nlrDcJ0yjPM9BrjC3Eod1m9dys0O/RirmbFJAfT+i
X-Received: by 2002:a17:90b:1648:b0:2ff:6788:cc67 with SMTP id 98e67ed59e1d1-301be206e87mr990207a91.34.1742348601133;
        Tue, 18 Mar 2025 18:43:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0++cP7CuHsJuA4ykUqEhaO0hgo1XA+wkh7+TJ3CNVMbX8Xf+ByWZl4BacAg74fMOEy0eBKEoJ6izk1WeYfSI=
X-Received: by 2002:a17:90b:1648:b0:2ff:6788:cc67 with SMTP id
 98e67ed59e1d1-301be206e87mr990190a91.34.1742348600818; Tue, 18 Mar 2025
 18:43:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250318-virtio-v1-0-344caf336ddd@daynix.com> <20250318-virtio-v1-4-344caf336ddd@daynix.com>
In-Reply-To: <20250318-virtio-v1-4-344caf336ddd@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 19 Mar 2025 09:43:07 +0800
X-Gm-Features: AQ5f1JpzmBMSEro2nh12X2DCr43bIWbmp32ijo_MawALr8QoNkwJtaJ_yge_7wo
Message-ID: <CACGkMEvt5A00kvw6=O5Q2qW2vbbzAnFBpUmcBVwSPJr0i9xmpQ@mail.gmail.com>
Subject: Re: [PATCH net-next 4/4] virtio_net: Allocate rss_hdr with devres
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Andrew Melnychenko <andrew@daynix.com>, Joe Damato <jdamato@fastly.com>, 
	Philo Lu <lulie@linux.alibaba.com>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, devel@daynix.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: cRftvhbEqGcJPs0XltmAlb1oBbMkdFK27fbVWuERUNE_1742348601
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025 at 5:57=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix=
.com> wrote:
>
> virtnet_probe() lacks the code to free rss_hdr in its error path.
> Allocate rss_hdr with devres so that it will be automatically freed.
>
> Fixes: 86a48a00efdf ("virtio_net: Support dynamic rss indirection table s=
ize")
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  drivers/net/virtio_net.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

