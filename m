Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FCC0369D40
	for <virtualization@lists.linux.dev>; Tue, 23 Jun 2026 09:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782208544; cv=pass; b=HEPX0uCM4gWFHhCkVQsmGWXKYlAKORvWOosxdh89B6+A6YfdqTIkhfkLngDOOibtl6mr0MhxmtfOFu7IDdAZRAXMmnCbgEBJf45znoq92vPiZfKvvQ6N6yzWtwNGFMioPxjH3Wmc/4DXN+pO4n7+Euv7xDWm/1rZLU2uT5BzYt8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782208544; c=relaxed/simple;
	bh=LvYUThQne3TrY6uaQG9EmEyHuxSQP+aNbK640K+aMxU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S4PeWghiMsoxHJPJIa1xa/3Vf4MQgP/Py+c/oLU8qSLceYChF8hgZbhb7lXJALBlTM7X3vtRpiIpGPMdMfeMX/Jv9rENBkrRPeBxynOm1JXz+YbMpavBkvT3xe8K3sYbCfGGBFBJK/uec7+oVWhbETFgdt+w8hOQpsQuh+FTxmc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OfAS9PIa; arc=pass smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OfAS9PIa"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-51a019e9ea9so38504391cf.2
        for <virtualization@lists.linux.dev>; Tue, 23 Jun 2026 02:55:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782208542; cv=none;
        d=google.com; s=arc-20240605;
        b=Ix0nc8P1k2GH8w1HBuEzuR+eNuUq4u76uRLcCj6od+uOppZx69EI8j+Q5ORf/SfddZ
         /gQ++fXuUj+IvHkTixI/mCA8Uxe/ijwjQWudJ7CpxFigeZdgn/E7CONDXlm0Mc/9HN7w
         WqJLsUtD37VOeYP7neBj3ii5oRImsYMh4MFXzaORyCfu4YpJHBtuQInrN1z2Wj8BYdht
         jCO0nJ1zcsi8l7/3M+22wtieLp5dle72JfAVcb9nEGRoiVOizOzq8irH9aIDE9omFkAc
         2/Y1Sd9OXhnVrmFN6EJGrLbAfqcOVXfB1jrw9Xxhnres+O0esjg34FOSs/QmbN9yJj6d
         1Q5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WWdevSc0aWVCs6aCLgUGOAww7ZtaohjUE77vhEuxp50=;
        fh=RVw7ZcT2bboZ6MASQx5hDorIYhxMqgwt3k1EzkCxGho=;
        b=BoV65YNOBNQoEhe3Bll72Cr0qmY+R/ZvafRc51ditSEsJXNrA27/tM88dzOi/xlzqI
         3luuQDCq7pJUdnvglhsQ3lq3jRqp9AJh8+cBwr/nzx/HvdXX6SUKqRxOpJK2kb/PSagM
         lHxFrf9TQVCVDqGJ2SKNyrhi5vTfmV4+ycXA6lHmrTGR9F5dr/0Nbg9laWA4zr2w4mME
         y6Nk6mi0DqQwRruvQnZg66wj9jYXMhkAThl620SiN1IyxxJEjesZ+vaM+eHBgOb86r/e
         pBrDT8RCK9tsahv90spwDV4NlPbdWU8lQLJui2assPjiAOlgFFEiNJ7KnssM0/eFgThs
         k/og==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782208542; x=1782813342; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WWdevSc0aWVCs6aCLgUGOAww7ZtaohjUE77vhEuxp50=;
        b=OfAS9PIa+G87qmkYiWdS3T/xSZ56wdynhWxyM+v+W9CJtF4wAKeYn5/m80jxRDUY25
         Dm/3YUr6wpt1qnYr0TfBfFbDm69YfTVSfI+WP3gHVgu0oVSMTg/Mpi7TodbeeI9vOxvJ
         X0NBJFCV+aArIB/avcbtipWO7+iB4osFdDjZUHAzHk7x88U/tvsVSdDgX3O9Q/mPMfNb
         J14/SjOHGjYtURbpRgiAP11FfGB4fGNzOUr1lKT5QfzIb0sUtZ62gZdMUsWv+BCuDqzW
         zRDVvOUmZQ6TbgKnQqj3t5bF9tpKisxa8mQLKpQSCDhlPEuf5oliVJOnHJVMLZa0oIlM
         ZP8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782208542; x=1782813342;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WWdevSc0aWVCs6aCLgUGOAww7ZtaohjUE77vhEuxp50=;
        b=hTC4ZLi7wdTp31WSQlLWFfuzL5S3oNAxNVhHryd8fafneXrtMgKx7kM6Ihrpdm5a+W
         +PuHDfbR/n1kQGcdJCg/CWcr7sdfyKUC9GmnZD2H2snyNke31MkhK4Exhhm7wkJ2FiQz
         Tmo43eoJy3QMMVomWTVl8ddzCxL40NQSZUtuGgncAlsfGH7l2nyWNmc6WXp5fDAB0ceh
         dpyJi89w0UNlTffqiM8jc2Lu+exHXMCiIv385Kv1OImOegIW6ckWo2j2T7+E3Ym7Sl6l
         5h62GoV94g3um8WEoC/6GYV3114BXVpCGAI9ReiZ8b8WTcxnMTHy6Rnn+iF6i3+kPNf1
         QcbQ==
X-Forwarded-Encrypted: i=1; AFNElJ+bTG25i2Fij7sSGf/uZrHDwIWzHM3uMDtjTmW0n0mn0yz8h4vk9XUruBVinFfiWQ+94B8qu3Pq6p27gv2f2g==@lists.linux.dev
X-Gm-Message-State: AOJu0YzoPElUG47je/9i2S51IoflREvjM5+Bgyot5mLNhzaVH7VQGEzN
	i3LwU/eORo61bKvyXssJW1gtfKc/+lj+3M55PBjVoytZNq9oVGv0gp7oBu6Hy1U9xUTKj/e6lPK
	a/dIvKpOSJ+hlWLn9RRyv+jFezrz24dswgD82V9c7
X-Gm-Gg: AfdE7cnWCUhg83BuyFEd/+dM/bMviwT+sw9saJIALDDpUTAMgYJBnXH0PrNtrTuemLK
	NhUXKNe7bVJkSJ1ZUvRvGTx6EMJTnHwRHdDorbzng7ASoUvFFOH+W6J1y9ksHbk1sA383li4f/Q
	rsJfBA9kXg3FC/ng9cZu2XkJY8bUVSLZ3RhITZ31UK3XXlIK49t3kZBIH2O6CaKAFcvJYcr0qxE
	4lEfep75qUwMuNlhkOE40RejK4ugm3wGaBW5fP6az0ImRVL9lmggUkmMVj4joSrJHUtzIe7hmb5
	hD6JVj59Bo6L2ex1aGY40+HP1hEtHC5WrN+A4mTB/AHVn6KpYN4UhgoGLegxXOGU41vet40jujZ
	mbM2F2IwT
X-Received: by 2002:a05:622a:291:b0:517:5e32:f3ad with SMTP id
 d75a77b69052e-51a06937e84mr204781371cf.26.1782208541730; Tue, 23 Jun 2026
 02:55:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260623091901.118315-1-lange_tang@163.com>
In-Reply-To: <20260623091901.118315-1-lange_tang@163.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 23 Jun 2026 02:55:30 -0700
X-Gm-Features: AVVi8CdxKu-26NNasQTWpoEm4a53c3jWCLNr8S1zeEbZh07qmL6p3AGRUsDetT0
Message-ID: <CANn89iLrOTKQNqJA_oZKPjkHb1Xyqm6LS9tDn72X4az65isDGQ@mail.gmail.com>
Subject: Re: [PATCH v2] virtio_net: disable cb when NAPI is busy-polled
To: Longjun Tang <lange_tang@163.com>, netdev <netdev@vger.kernel.org>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, jasowang@redhat.com, 
	virtualization@lists.linux.dev, tanglongjun@kylinos.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 23, 2026 at 2:19=E2=80=AFAM Longjun Tang <lange_tang@163.com> w=
rote:
>
> From: Longjun Tang <tanglongjun@kylinos.cn>
>
> When busy-poll is active, napi_schedule_prep() returns false in
> virtqueue_napi_schedule(), so virtqueue_disable_cb() is skipped.
> The device may keep firing irqs until reaches virtqueue_napi_complete().
> Under load (received =3D=3D budget), it will lead to a large number
> of spurious interrupts.
>
> Fix it by disabling the callback at the virtnet_poll() entry. This keeps
> the callback off while we poll and re-enable by virtqueue_napi_complete()
> when going idle.
>
> Signed-off-by: Longjun Tang <tanglongjun@kylinos.cn>
>

I added netdev@ to get more attention from networking napi polling experts,

Please add a Fixes: tag as this will ease code review.

My rough guess is:

Fixes: ceef438d613f ("virtio_net: remove custom busy_poll")

Thanks.

> ---
> V1 -> V2: Remain agnostic to busy polling
> ---
>  drivers/net/virtio_net.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index f4adcfee7a80..0a11f2b32500 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3008,6 +3008,11 @@ static int virtnet_poll(struct napi_struct *napi, =
int budget)
>         unsigned int xdp_xmit =3D 0;
>         bool napi_complete;
>
> +       /* Keep callbacks suppressed for the duration of this poll,
> +        * busy-poll need.
> +        */
> +       virtqueue_disable_cb(rq->vq);
> +
>         virtnet_poll_cleantx(rq, budget);
>
>         received =3D virtnet_receive(rq, budget, &xdp_xmit);
> --
> 2.43.0
>
