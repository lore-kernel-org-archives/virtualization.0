Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FAD15BB
	for <virtualization@lists.linux.dev>; Fri, 22 Mar 2024 05:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711084652; cv=none; b=iPKX/z9k1faQc7PNbOUUuBeHy5Kp5uUI7CNQzBiWy6le+JOL0YLD72/f02bcAP9dxXmK8FsFSt4KFKj4bukmAKxRgyB1/sFAe+fjiF1yaVZarWpvGASBWIJ32s1WaPtkQrj2bVS1F1VEeNe2kcGYQIXNJ93CTtMZy9W+fihAypw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711084652; c=relaxed/simple;
	bh=EWE/U2YdOLWytXJDbIZukYYxmLvwVy2p5yLqcqrgdd8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WSG7/qt0Byt1y4pB4PhyG7eDSFJV53HayhGNuorTErUv0GrvKLxMjIhbED+fT5wMohH31+hiLZOPA0DBPT/hefuf8aDW0xF0n2K6/CEkONV921WSujR9ZpQ6Xv0+s3rWezyMKfZTW0+j9xNxMdB7XdAp1lE1fpAb+wzXpfCoaQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YtnXc9Gk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YtnXc9Gk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711084649;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OiB8g8AYZuTj7XKOAnl43a6gnRGZomUOLPEEyadQvtw=;
	b=YtnXc9GkCjbyo4L/VC6dlWk8zAyo3yRJJLTXuFeIMcxY7FxFUsPSYYV6Z4j5f1CuzHFlnP
	3OOse6f0jmPExEwe0hGa0PHSVtfIYkzm0EhGuOMpMDUpqziR5DXq3IwYR8SuEr8wXh1fJ7
	mUOjQJv6WG8axVIU46l76uWllq2CM3Q=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-482-RmXAbRMFN9CC2cOGLzZWoA-1; Fri, 22 Mar 2024 01:17:28 -0400
X-MC-Unique: RmXAbRMFN9CC2cOGLzZWoA-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-29df71a709eso1316295a91.1
        for <virtualization@lists.linux.dev>; Thu, 21 Mar 2024 22:17:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711084645; x=1711689445;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OiB8g8AYZuTj7XKOAnl43a6gnRGZomUOLPEEyadQvtw=;
        b=NDpZXUw3+KR/Nz0fMDCZNwTjbpcKBaJiGvFRPvKy+dycR1ukDXKOJfGCVuFkLWM1L9
         DY0U/PKjZvNdfyZNfHvN1iUaDV2+2wDsSYTct0fuxZ0T7nD3j262X2BirL7UmqaOKvZB
         SPVVM5ID8h1+iPtiHF03/v2hrOFVBBOua5Bg64BByzfJGt47Ar40HpbzWgL6hCNjItHX
         ryNAVluE0ZeBmENsFG3Zyp5cIQHwGvBeR4K9WGyaADAR1LP/nntlGHCaE17IBEgtQoPR
         EDvgNXN4uuDREwChZB234zjn3u+RjAlSHz6MS4tOyRDx3fMHwQfQr1YSFqZMJS56bI7z
         QBxg==
X-Forwarded-Encrypted: i=1; AJvYcCV7USb1NylZlTYF4ZN4Mo6CbRAO3RROcgXy62LGoi/6UlBVuOvwUi/YhRsQATiYCuan83ERKG/oORXboCIdoUrMXkWwOZD8ncYsov5oZtc=
X-Gm-Message-State: AOJu0YwFpgTV+NSl5dgKcedHZ7AtTWEixB4EsP2MQTW0r2eK6jfAIMyG
	5CjSVSu61f0UGbKn3i44xxnQU31FROhk5U1NKBGwUUY1hVIDvT0lRLjPDBF/DdyBqnne5BKEeNG
	+ftI6D0TAoKu9ydnAXzxRcROg0eS3mWVUB2RcNA6t6vXD7ZtJuX+mNzFpiRNbmKTNrvWTXKosyn
	r/AwkgR/KvyfzUYvBWSg08sO2VwG5IwU3u1vfAAms=
X-Received: by 2002:a17:90b:4cc2:b0:29f:e100:5e8d with SMTP id nd2-20020a17090b4cc200b0029fe1005e8dmr1233624pjb.30.1711084645655;
        Thu, 21 Mar 2024 22:17:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwL6cxEzgUlFXUmhD96O4FYrKpPpJNtEYJx+SiogAQgf6veEJ5BZwFAMdLl9ha2tgOY4F2KX9Mf22HeDjoKcM=
X-Received: by 2002:a17:90b:4cc2:b0:29f:e100:5e8d with SMTP id
 nd2-20020a17090b4cc200b0029fe1005e8dmr1233612pjb.30.1711084645417; Thu, 21
 Mar 2024 22:17:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <1711021557-58116-1-git-send-email-hengqi@linux.alibaba.com> <1711021557-58116-2-git-send-email-hengqi@linux.alibaba.com>
In-Reply-To: <1711021557-58116-2-git-send-email-hengqi@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 22 Mar 2024 13:17:14 +0800
Message-ID: <CACGkMEtyujkJ6Gvxr1xV94a_tMzTo48opA+42oBvN-eQ=92StA@mail.gmail.com>
Subject: Re: [PATCH 1/2] virtio-net: fix possible dim status unrecoverable
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 21, 2024 at 7:46=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.com> =
wrote:
>
> When the dim worker is scheduled, if it fails to acquire the lock,
> dim may not be able to return to the working state later.
>
> For example, the following single queue scenario:
>   1. The dim worker of rxq0 is scheduled, and the dim status is
>      changed to DIM_APPLY_NEW_PROFILE;
>   2. The ethtool command is holding rtnl lock;
>   3. Since the rtnl lock is already held, virtnet_rx_dim_work fails
>      to acquire the lock and exits;
>
> Then, even if net_dim is invoked again, it cannot work because the
> state is not restored to DIM_START_MEASURE.
>
> Fixes: 6208799553a8 ("virtio-net: support rx netdim")
> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> ---
>  drivers/net/virtio_net.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index c22d111..0ebe322 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3563,8 +3563,10 @@ static void virtnet_rx_dim_work(struct work_struct=
 *work)
>         struct dim_cq_moder update_moder;
>         int i, qnum, err;
>
> -       if (!rtnl_trylock())
> +       if (!rtnl_trylock()) {
> +               schedule_work(&dim->work);
>                 return;
> +       }

Patch looks fine but I wonder if a delayed schedule is better.

Thanks

>
>         /* Each rxq's work is queued by "net_dim()->schedule_work()"
>          * in response to NAPI traffic changes. Note that dim->profile_ix
> --
> 1.8.3.1
>

