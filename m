Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9DD24BBEE
	for <virtualization@lists.linux-foundation.org>; Tue, 15 Jul 2025 15:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752593545; cv=none; b=q8sgMOEyNCY7VYf5klBAC8Gu4C3GhGkQLBMGtcbZTEH167SKy2kSoZU8bCANXRKGG/D4RhOPfG0J2vHTCtP2BuJJUUBtfmV2sCz5IMRxc8XtDbJolbqR9zOL0FvceBv7URg0Z0bGbO6YxdCn8xNx4hT7stIA6Gmdw4HyHTrhrow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752593545; c=relaxed/simple;
	bh=5rdRvK0/wv3rgyzsgXz0n1m+AdOdwgEE5BaXSVwhhTU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M5cJcjBh8k8eKHL7VAwknmiZGzn0C9etz+Dmed19jgwTpY4tPqVP3HgTTbAJHu5opXcOTaO32UhuEeTjnKMYc4gC+KL3BqmGbHC8i5Es8WvGoXmZ/MXLZkTEYM3sKhw1hdVtvOamn1h2spPXpNwFR6CNIXKr9v1aTrrAI8ZqcpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WkPjtxJS; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WkPjtxJS"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4EFBB610C0
	for <virtualization@lists.linux-foundation.org>; Tue, 15 Jul 2025 15:32:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.792
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7wKkxMCADq2Q for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Jul 2025 15:32:18 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=leiyang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 9E8816066A
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9E8816066A
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WkPjtxJS
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9E8816066A
	for <virtualization@lists.linux-foundation.org>; Tue, 15 Jul 2025 15:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752593536;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wnh22gI/k+OIEWCf+4ySowORAdVnUSIEoD4hbUCmi1M=;
	b=WkPjtxJSVWQMk2C5as1nCxaCE1ldStlV+zztTaJRs7GiSv4gaCccbRPDfShBs/+COQ/E3i
	clxEm0/cYWCMzkJ5NxM31s5LY/Rxk9cmiMnjOdONXfsEOSFQjM18pjsO9GZkB7wQuKqHGF
	qXGj8KZvoy/qV55Tc7Z+vDaXz39JwTE=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-pc7ICZ8KOk-C-Dk56Ae5Zg-1; Tue, 15 Jul 2025 11:32:14 -0400
X-MC-Unique: pc7ICZ8KOk-C-Dk56Ae5Zg-1
X-Mimecast-MFC-AGG-ID: pc7ICZ8KOk-C-Dk56Ae5Zg_1752593533
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-ae0aec611beso404392866b.3
        for <virtualization@lists.linux-foundation.org>; Tue, 15 Jul 2025 08:32:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752593533; x=1753198333;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wnh22gI/k+OIEWCf+4ySowORAdVnUSIEoD4hbUCmi1M=;
        b=KnH1uiJMMsyRzCGqWieReQ8/nFcwIP2LQVJMONs4lje6YSuoPh6g8JpSSP58GbuOah
         UDongdTXV+wCCsQVsVqcsj8ZOQcxGuI0kGbz0piuflfMNu50GFSSVKiqSStC+iEk65Ry
         j08msVBws+ar9Nkk6NSwFBs1x/cVYbLKsSb+lRfOvmJziKODlaOoqdENxf2VqNPKqQVj
         DN4L4aN9wTlxSR7HHoaekg9+YhIItkIV4dwwzYEZyL43LUSKEhO40MQbpFKcPFHrT0Pe
         zcNqJYuHvMlqUGFYiyxU84ey/LjZnnEZVskkbLwXKzThCl8EJsXloiDk4AoGvWJ5k86P
         Agzw==
X-Forwarded-Encrypted: i=1; AJvYcCWWQ7jcoaauF8iCnlMBzc/3qvq0C34LLADLq5Yxw/Swvn7W3echebXVk4Uomkk3bBvo6jdTshLtj1uAVyeMxA==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YwzV3O7II3PM/IceBOJA6gGdHnGuOZM+sTUt9IsKYza/935rbBk
	ucy0ew5ZOyKuNu7vWxZ+hAszDf9A0Cj9TZ2uRgLy7b5m4mKTeJD4cOessCwuBi1hguMoRerpSFh
	wDHjStWV0KZbklZY324IFAxAYbBRQzaEMjkifeWUBXLgqCUtLzfyAqVW9QJeFl5vMayqqK79mB6
	IswcxcPqFFKLLL0bgeshoy3yXDRGL2mWbOFXjcF5o1lHG1YLC17tWqYgxCiA==
X-Gm-Gg: ASbGncuk0tnqs3IM/L4zq8L6qn3DY0EwKoBDpYoCLHZi6dShIAg/AiHCL4Y+ZHl0htE
	VpN0E35K5979sb18uo1t6crDkZhA8+/+5NWRR0xR5nnqoiDG7PZsAoNJf3knDgbuhR3OB7PowX5
	PWj/B/wh2B6rEOz+yA9PCK6Q==
X-Received: by 2002:a17:907:cf93:b0:ae3:cf41:b93b with SMTP id a640c23a62f3a-ae6fc0a7f90mr1582699266b.41.1752593533371;
        Tue, 15 Jul 2025 08:32:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOIuENMcFdE7XVF/eBak/JoBXEh87UvUrI/EctpEOdONudRuCPXduAkkRmy07jHtjgT20K0pXxQIEZJ9U0ySo=
X-Received: by 2002:a17:907:cf93:b0:ae3:cf41:b93b with SMTP id
 a640c23a62f3a-ae6fc0a7f90mr1582696366b.41.1752593532954; Tue, 15 Jul 2025
 08:32:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250710023208.846-1-liming.wu@jaguarmicro.com>
In-Reply-To: <20250710023208.846-1-liming.wu@jaguarmicro.com>
From: Lei Yang <leiyang@redhat.com>
Date: Tue, 15 Jul 2025 23:31:35 +0800
X-Gm-Features: Ac12FXx0K4HuoaUKypyFETVzBZg3F6wzzVt1s3aBwTTAZbrGnPQbtaOUcuDFRP8
Message-ID: <CAPpAL=wvL2LfRV5BFgLVG69hUoO5fYVx6WEK-PimjoQpy1S7ZA@mail.gmail.com>
Subject: Re: [PATCH v2] virtio_net: simplify tx queue wake condition check
To: liming.wu@jaguarmicro.com
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Jakub Kicinski <kuba@kernel.org>, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, angus.chen@jaguarmicro.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 28_WzazNBxQrBf1qlybnlBkgnIAZlnFXJN4nLhbYr_E_1752593533
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Tested this series of patches v2 with virtio-net regression tests,
everything works fine.

Tested-by: Lei Yang <leiyang@redhat.com>

On Thu, Jul 10, 2025 at 10:32=E2=80=AFAM <liming.wu@jaguarmicro.com> wrote:
>
> From: Liming Wu <liming.wu@jaguarmicro.com>
>
> Consolidate the two nested if conditions for checking tx queue wake
> conditions into a single combined condition. This improves code
> readability without changing functionality. And move netif_tx_wake_queue
> into if condition to reduce unnecessary checks for queue stops.
>
> Signed-off-by: Liming Wu <liming.wu@jaguarmicro.com>
> Tested-by: Lei Yang <leiyang@redhat.com>
> Acked-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/net/virtio_net.c | 22 ++++++++++------------
>  1 file changed, 10 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 5d674eb9a0f2..07a378220643 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3021,12 +3021,11 @@ static void virtnet_poll_cleantx(struct receive_q=
ueue *rq, int budget)
>                         free_old_xmit(sq, txq, !!budget);
>                 } while (unlikely(!virtqueue_enable_cb_delayed(sq->vq)));
>
> -               if (sq->vq->num_free >=3D MAX_SKB_FRAGS + 2) {
> -                       if (netif_tx_queue_stopped(txq)) {
> -                               u64_stats_update_begin(&sq->stats.syncp);
> -                               u64_stats_inc(&sq->stats.wake);
> -                               u64_stats_update_end(&sq->stats.syncp);
> -                       }
> +               if (sq->vq->num_free >=3D MAX_SKB_FRAGS + 2 &&
> +                   netif_tx_queue_stopped(txq)) {
> +                       u64_stats_update_begin(&sq->stats.syncp);
> +                       u64_stats_inc(&sq->stats.wake);
> +                       u64_stats_update_end(&sq->stats.syncp);
>                         netif_tx_wake_queue(txq);
>                 }
>
> @@ -3218,12 +3217,11 @@ static int virtnet_poll_tx(struct napi_struct *na=
pi, int budget)
>         else
>                 free_old_xmit(sq, txq, !!budget);
>
> -       if (sq->vq->num_free >=3D MAX_SKB_FRAGS + 2) {
> -               if (netif_tx_queue_stopped(txq)) {
> -                       u64_stats_update_begin(&sq->stats.syncp);
> -                       u64_stats_inc(&sq->stats.wake);
> -                       u64_stats_update_end(&sq->stats.syncp);
> -               }
> +       if (sq->vq->num_free >=3D MAX_SKB_FRAGS + 2 &&
> +           netif_tx_queue_stopped(txq)) {
> +               u64_stats_update_begin(&sq->stats.syncp);
> +               u64_stats_inc(&sq->stats.wake);
> +               u64_stats_update_end(&sq->stats.syncp);
>                 netif_tx_wake_queue(txq);
>         }
>
> --
> 2.34.1
>

