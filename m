Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D4725E83E
	for <virtualization@lists.linux.dev>; Mon, 24 Mar 2025 14:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742827154; cv=none; b=osFxQpJGl0TzDP3gJUdhOog/pBHx7lzSWkjbVj5x7z1BietEjonJtSaRtBXx0YZ3h7FYqIgDdGNXIT+uHgI1aqa35qAc7rbnqVjwn2ObZMJ7sW8Cl2YNXKZFIOGipnceEcVSAHRuMpMbFLqnfA8iWkzk4v9HbwxA0bFzxeOg8Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742827154; c=relaxed/simple;
	bh=nTliLNqMZBbrK6UBfCB5qUOnQ701+cm9BjDjoUn7wrA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O/frgx+YwddQ5rjYfy0o40cthhr+fEVALe9WMxVqjQp9iEbMhfvm8Gp4dmTW535PCJ69fUbYaezJU/JdB+72CYY56yGmUtC+RCvuRKczdXpC+M7mRmSax2tXUxzwAMG2wDjLuyrpAQAZgUIpLIKJR09gmJTL1/f4LI7Eo0sdzI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LaGgcwNg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LaGgcwNg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742827151;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xq0MDmj/bWYFPGaNLprQBYbBGHp/cGo+8wXXgvTKy6U=;
	b=LaGgcwNgzDnPFuCxmGvN85esBcy4QKnDCvyIYLTR/aOFj1wTKfwL10mCfBFYWJQ9y5lIZ8
	oKdIBctUPm2ER2BFUvSQyyFFY7eQ6N5dYxxEJ8VFXSFnBAcbK3946o5uHlKjZlagqoAPJP
	BE1I2jOxi+WnDmWuDvJEDDyITStRMwE=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-117-KODCzD03MuqjCoZE5TxdOQ-1; Mon, 24 Mar 2025 10:39:09 -0400
X-MC-Unique: KODCzD03MuqjCoZE5TxdOQ-1
X-Mimecast-MFC-AGG-ID: KODCzD03MuqjCoZE5TxdOQ_1742827148
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5e6136633b1so3569639a12.0
        for <virtualization@lists.linux.dev>; Mon, 24 Mar 2025 07:39:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742827148; x=1743431948;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xq0MDmj/bWYFPGaNLprQBYbBGHp/cGo+8wXXgvTKy6U=;
        b=OZ5Z8103+IpQVYoPb/AqV/mozUi/wvXqpjK7rdivifhqXHaLZtt0L8qAMVBogsUvUl
         CzuymIVDmXIabmdI0D4KHkQea8Qx5xsiLmJKZA6XAaCu9TqfUlFluTtghdqBtWn1Lyah
         a/QoG0+L7haVLCndiudLu8s7jbE+YB5QpixnwdRU3MI4ps1T+Kxb76wpZsN/Os72Alxs
         jF2qfnirYh5mAkLp5op83hSB11QhYZ/HjUtS/ozqb2MXYKQ/gWXs9TujHg9YTFzdSymA
         Geix1Rs7Y8BczrjvP650LIK/trRKvfd45ZCtrb2RQ4lfESG/ChhjQxqCQVurRZnpTpoP
         Q1Pw==
X-Forwarded-Encrypted: i=1; AJvYcCVGVpQaKLnHo5ChnTr0NhBIII89LZUBlEYhiVTyMuQaqZ5tgLkUMveAP05Htet+71ZQYeHaT9nOxja8ze0paA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxFxrxCuGCuuNITrKkBx3Qs94GBJP4bi46KPWQIHp5jU/McPxxx
	o2snANba87dVIBmKrPdk7rT6h/PEv/nM9chs/6HkdvbiWPVNsq2cv/4of1TL5r0uvTS/y4omTbx
	vkiJA9BqXEoAC5ayLIcuYHQRCehAxiVoEBPmIY5VAeoav6cWyEmcclZjsFHJs7TVy+YMvHLQiRE
	OeBms/DAyNHx29RU8OwFr/+9NyVFZA5wZuR6grOD0=
X-Gm-Gg: ASbGnctLra4pKMH2JBd1TFN4x0oAkIxa1wGhNXFZFN4Z6xokNo76CQCQ4OTiCUAU6OH
	F0HZ9CEihtwRcrXiJETxv6nMgXKFeG3DgBNPbM+jWk/AyzFd+CkHGg9kOIJ0VCnxn+bVR5tbGmA
	==
X-Received: by 2002:a05:6402:909:b0:5e6:e68c:b6e5 with SMTP id 4fb4d7f45d1cf-5ebcd51c105mr10515824a12.32.1742827147947;
        Mon, 24 Mar 2025 07:39:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9DKx6B3C9S8Xr5iUK6i6jAmqu93CsYREN/zAlEYF/Sj4+lRsLtO/S8UYF8aFRkQ36lLETXWAjFegsoIHGZa8=
X-Received: by 2002:a05:6402:909:b0:5e6:e68c:b6e5 with SMTP id
 4fb4d7f45d1cf-5ebcd51c105mr10515798a12.32.1742827147499; Mon, 24 Mar 2025
 07:39:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250321-virtio-v2-0-33afb8f4640b@daynix.com> <20250321142648-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250321142648-mutt-send-email-mst@kernel.org>
From: Lei Yang <leiyang@redhat.com>
Date: Mon, 24 Mar 2025 22:38:30 +0800
X-Gm-Features: AQ5f1JrTYgZzgkgv85az98_SpxBT46ja6zriWYT-n8Fbp7M8MZtf2vAwTdHHOlk
Message-ID: <CAPpAL=w1BRdeEKnPa2Gxgq7F_xcyieOSms1tFXETUpzE3An4sg@mail.gmail.com>
Subject: Re: [PATCH net-next v2 0/4] virtio_net: Fixes and improvements
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Andrew Melnychenko <andrew@daynix.com>, Joe Damato <jdamato@fastly.com>, 
	Philo Lu <lulie@linux.alibaba.com>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, devel@daynix.com, 
	"Michael S. Tsirkin" <mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: i22rxrBgaOutpBc2CjZaNHPPvIJeN86BAcCAJlKiypY_1742827148
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

QE tested this series of patches v2 with virtio-net regression tests,
everything works fine.

Tested-by: Lei Yang <leiyang@redhat.com>

On Sat, Mar 22, 2025 at 2:27=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Fri, Mar 21, 2025 at 03:48:31PM +0900, Akihiko Odaki wrote:
> > Jason Wang recently proposed an improvement to struct
> > virtio_net_rss_config:
> > https://lore.kernel.org/r/CACGkMEud0Ki8p=3Dz299Q7b4qEDONpYDzbVqhHxCNVk_=
vo-KdP9A@mail.gmail.com
> >
> > This patch series implements it and also fixes a few minor bugs I found
> > when writing patches.
> >
> > Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
>
> > ---
> > Changes in v2:
> > - Replaced kmalloc() with kzalloc() to initialize the reserved fields.
> > - Link to v1: https://lore.kernel.org/r/20250318-virtio-v1-0-344caf336d=
dd@daynix.com
> >
> > ---
> > Akihiko Odaki (4):
> >       virtio_net: Split struct virtio_net_rss_config
> >       virtio_net: Fix endian with virtio_net_ctrl_rss
> >       virtio_net: Use new RSS config structs
> >       virtio_net: Allocate rss_hdr with devres
> >
> >  drivers/net/virtio_net.c        | 119 +++++++++++++++-----------------=
--------
> >  include/uapi/linux/virtio_net.h |  13 +++++
> >  2 files changed, 56 insertions(+), 76 deletions(-)
> > ---
> > base-commit: d082ecbc71e9e0bf49883ee4afd435a77a5101b6
> > change-id: 20250318-virtio-6559d69187db
> >
> > Best regards,
> > --
> > Akihiko Odaki <akihiko.odaki@daynix.com>
>

