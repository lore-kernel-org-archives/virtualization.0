Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6878B11182
	for <virtualization@lists.linux.dev>; Thu, 16 May 2024 05:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715835821; cv=none; b=kT/rY6fk+nd+bLfSY2DYQGKQax4v6awWOoyfXZoTrWcxy/TkW4sgraJ0nJaQ5vnvXtpC9u/87pkNYIDfKT9JWPBPIELM7cEKBi0t5nipbNjmJO1cj0oGP3IqgJhsmDSLBwEvFDKM/i6rFIZAUCi+eLSvreY3UZew8UuHj3PGSkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715835821; c=relaxed/simple;
	bh=DjF0gKWJ8+yHQMlYXKXU86iXdSe/PU926z1Ys3/Duiw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bi5a6oSDjc6zyl+hFveFVxSiTjqc5bEo5JlHlfe9GyA9LVspldXjITYrBbtPeAQ+F0RoY71DDKKQFOM0wWhdkFQJXKxDC5M9W3Dc6CEJn0U0PNJm52QnKfI1wSTQhOLB3AQmI3tQYiYXhtsTgAlg4lnFzLGWxzl+jgB1g96X4CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h1dD+Dao; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h1dD+Dao"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715835817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BIdlxCtNUsN14oiOu6iayNNOeSqk/xL+5C1diPVIWj8=;
	b=h1dD+Daog574QsulTvpjvB4BWR08WfD4rReYTO9SWY7VZatn2suzFwj81QBrNUXIxecMZW
	TooWaC2ftPtS4iVwKbufUb89bRcnmc5KBOUzTv/g7slk11OxuVVfVhuRtK9aSRVGN6fSt/
	sIpgJ5mO3dUa3waKWiWsKxiJKvTPfVg=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-572-5M4Gi8JLOLCYyF0DfaLHRg-1; Thu, 16 May 2024 01:03:35 -0400
X-MC-Unique: 5M4Gi8JLOLCYyF0DfaLHRg-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2b96f302d84so2748730a91.0
        for <virtualization@lists.linux.dev>; Wed, 15 May 2024 22:03:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715835814; x=1716440614;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BIdlxCtNUsN14oiOu6iayNNOeSqk/xL+5C1diPVIWj8=;
        b=eHE/32byfddOJw2nlR89XV9yc2rYO6fW6k+Czgqab9vKPjUCv6KJWlAGXCNJIdZ1az
         xx6u2k+0YoVKSrInor8LzUlt10gE3R2gAimWeejX4UiUhLCSKO3E87OI+q9X0HJ26qGC
         kqjCSV15l/0r4hWqoYHjb/6bO1NQFQNkQiAGEkxBoIU8Pvhurw9In363yAxp4Dd1gquq
         Mc/RBrmOxOd2trmiGa/C9HWAc6JWiy/U3qH0PahzbyRxNOUspfRJyA5V5B6cxvmFXtNr
         XV9wbfNMvMaoNXv9lZDyVJj+Sf9Aj0aoJ8BgiWTdnTzKHP4TI1i/mnWib00S6we6AZkX
         3apg==
X-Forwarded-Encrypted: i=1; AJvYcCUoPdOzyJDNTx7iNzHNn0HJMjgcxhAVOWfxd3C4NtT7y4kjp0sQ8lCFANemB7hk0RUaXCn6UrfwcOmeEH8R0yhEUbn0VWt4ZQ7qQhbrf9s=
X-Gm-Message-State: AOJu0YxcaZ+54ISu4jCFXnPhecqi5WfOO2iBNY81+mudkZbJm/7Orubz
	ISpZWTs66Q721PJEB+i9ZIQzohs35SqGqROc+nl5rrzm7siTvGrm4yroZUj6umllN7WomcbQSJM
	Y9vzLrN4M6Ayo3M4f16v2NIMolIK8WM8LyMQpwAiwFuOulIRktHgkTjde91pAIvC6XtEWWuUmec
	JCf7C4Tm+t8sSiCvLMtFOu0yV+GxOnt94MzJzvi6I=
X-Received: by 2002:a17:90a:dc82:b0:2b5:6e92:1096 with SMTP id 98e67ed59e1d1-2b6cc87abadmr17615798a91.28.1715835814627;
        Wed, 15 May 2024 22:03:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+ev8TSdRX+zKT0qCrNrwqTtjz+WkSu2mM3TK3gNNhGR767n/TIbLADRCAzfaJ2wL8x2tkPfFJfTl8kBewwqM=
X-Received: by 2002:a17:90a:dc82:b0:2b5:6e92:1096 with SMTP id
 98e67ed59e1d1-2b6cc87abadmr17615782a91.28.1715835814295; Wed, 15 May 2024
 22:03:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <bcc17a060d93b198d8a17a9b87b593f41337ee28.1715785488.git.mst@redhat.com>
In-Reply-To: <bcc17a060d93b198d8a17a9b87b593f41337ee28.1715785488.git.mst@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 16 May 2024 13:03:23 +0800
Message-ID: <CACGkMEtxYsRhxRc_DExPXeSLOstp0D66+yEoyXKVWrMdTx5ASw@mail.gmail.com>
Subject: Re: [PATCH] vhost/vsock: always initialize seqpacket_allow
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, 
	syzbot+6c21aeb59d0e82eb2782@syzkaller.appspotmail.com, 
	Jeongjun Park <aha310510@gmail.com>, Arseny Krasnov <arseny.krasnov@kaspersky.com>, 
	"David S . Miller" <davem@davemloft.net>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 15, 2024 at 11:05=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com=
> wrote:
>
> There are two issues around seqpacket_allow:
> 1. seqpacket_allow is not initialized when socket is
>    created. Thus if features are never set, it will be
>    read uninitialized.
> 2. if VIRTIO_VSOCK_F_SEQPACKET is set and then cleared,
>    then seqpacket_allow will not be cleared appropriately
>    (existing apps I know about don't usually do this but
>     it's legal and there's no way to be sure no one relies
>     on this).
>
> To fix:
>         - initialize seqpacket_allow after allocation
>         - set it unconditionally in set_features
>
> Reported-by: syzbot+6c21aeb59d0e82eb2782@syzkaller.appspotmail.com
> Reported-by: Jeongjun Park <aha310510@gmail.com>
> Fixes: ced7b713711f ("vhost/vsock: support SEQPACKET for transport").
> Cc: Arseny Krasnov <arseny.krasnov@kaspersky.com>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Acked-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
> Tested-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

