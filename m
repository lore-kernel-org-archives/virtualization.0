Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966852900AA
	for <virtualization@lists.linux-foundation.org>; Fri,  4 Jul 2025 10:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751623447; cv=none; b=a0JG8SNFP/jI/bYV6p0I2Ud6IEWr14R7rIJINUMtFq2GqhtKB/wFFa801DJ1vVg/4BfuQyOZ/lN0YN7xgv7tIGEHku3Ug+Wr7JDnb9XBoLFfERNqHOTkeVbp3ZGvo7ZHAx6j35t+yxnnNLBR1q/sQhqa67kmVX4oMdhUUgfVoEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751623447; c=relaxed/simple;
	bh=B7aUvk/jHjdAbP1Txi087l61k45RNX1ZWe+SIygilVA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q/41xOsmWBQupqHHnHib5ANiZFSc5bVy2Ve34NFCoHNdzLy6kG864DI72xPoqqo6k94HB42hjJNUP1uUip58Bfqhz+tkrG465yPXF+A5zYMB8J1T8aZqlkcG9sqHJKHaKRD1k8lj/ldg9YHg/Klf2eA5iQkPls8Q9p28ru3T2Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UJnu80K5; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UJnu80K5"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2C66460B86
	for <virtualization@lists.linux-foundation.org>; Fri,  4 Jul 2025 10:04:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FKsogQEWmaiQ for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Jul 2025 10:04:04 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=leiyang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 5DD586075D
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5DD586075D
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UJnu80K5
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5DD586075D
	for <virtualization@lists.linux-foundation.org>; Fri,  4 Jul 2025 10:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751623442;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rWi88a+JkVfvhFesKDsYwPcS3Up3wpcEEvDnhl9YEKo=;
	b=UJnu80K5FfXIcTUpsh0CkcpNPZnGSZ0u2illoO2/caqzWH3NvBO7eprHjWYS7TWoKpQhvj
	m15ViQNmfDSEUk/rHj48kJqOBaAFylOHi73lVP9X/z7JGCA91zlsgkJ4JJ8lt0gItZI3l6
	s5Vc0r6TExzAwTFfSFn3PL6t598J8ns=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-248-jJZUgmJ-PGm9umtZWfDU2w-1; Fri, 04 Jul 2025 06:04:01 -0400
X-MC-Unique: jJZUgmJ-PGm9umtZWfDU2w-1
X-Mimecast-MFC-AGG-ID: jJZUgmJ-PGm9umtZWfDU2w_1751623440
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-ae371f9e3f5so185958566b.1
        for <virtualization@lists.linux-foundation.org>; Fri, 04 Jul 2025 03:04:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751623439; x=1752228239;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rWi88a+JkVfvhFesKDsYwPcS3Up3wpcEEvDnhl9YEKo=;
        b=wqqo1QIvbDbxItCdUPqOnLnHUQbz/IdzZDe2WiyjB5QSCUSzk1W8EAkJy6aCnCcYGb
         8VAoW2LS02ul5qqVFjDQQnO9Eps5B0A/g6C2TLLf5NYumj3iYw/SVcUAIzCqtpIW/fT5
         WTGrIvtY9HnXicPWHAxgG2+CT1mM5RW0AR0xV6j4r9V/eRd+kc7lXKJc1lkSTLRndVN2
         xaAs8fayzTg3YRt0XT5s5fSojkyc9XQ6tvgX63aUomjzExOszASCwlri+SGUWSHhUYPH
         y66iMEUPtYGJqOWByVxRI6pKbRLnX9Fif1g7i9iq6e0gRlFqwEl6YpaPJwU/rimUsBr4
         AuHw==
X-Forwarded-Encrypted: i=1; AJvYcCWp9JI1q6VDFiaP7jaxAQb/wIUU/rrRSMOoK/CKPPDuJQ+OXeAZJWOmXG3u4Ynu+Z9/p/788wcGv74wwe+VKw==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yz75UwTKYF8pVoI1E0y+MJbssmXuTMo4NrNDNjtBBKzBAONOlUi
	IUjgKKDY4Ej6kIZufrOIXHsKWd+5JqtvDdWOv4YjJ9ZMueYGfUd+ZlsX2ig+EJGKdg+w5TtkpX1
	39jnwbq0aYCghHOE94drtRBEzgzj90xKMxqR8r8jcY2O9C7icuiSbruni+t7CUV0xZJeGX8PDdu
	nplEkn/kp1hAE+BRsD+so/LIbw5DZ2OlRVHr/uycXq+dyuxaYvtY6674boZuz1HLGoWA==
X-Gm-Gg: ASbGncsWHoA0mz2rWBeUmm5DOA/+aBhPY8+D7I0N6m/mtHOXHCf3h0iJwfWshD7OTpl
	7idos8XF41P7MZ5eBZMh7W5a6FveER9HItkodF2v2cg2Mr7yqmvnuuqakeDTiXvtZYWGr5Lipzv
	VH6Gd/
X-Received: by 2002:a17:907:1b28:b0:ae3:6038:ad6f with SMTP id a640c23a62f3a-ae3f801ffffmr257590366b.3.1751623439430;
        Fri, 04 Jul 2025 03:03:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHS9N1eCIk/WZ0O55TJaTXfCqhycvxAdX3gpiv7v0S1xEAaaTDokoaZNHnw35/eNshgWtKvOMMHV8DKBFb9MEc=
X-Received: by 2002:a17:907:1b28:b0:ae3:6038:ad6f with SMTP id
 a640c23a62f3a-ae3f801ffffmr257584266b.3.1751623438615; Fri, 04 Jul 2025
 03:03:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250702014139.721-1-liming.wu@jaguarmicro.com>
In-Reply-To: <20250702014139.721-1-liming.wu@jaguarmicro.com>
From: Lei Yang <leiyang@redhat.com>
Date: Fri, 4 Jul 2025 18:03:21 +0800
X-Gm-Features: Ac12FXx2LPRflMaDOhrK2WN9s4Zkqha02pwAGwf7MkpIy2PH8obbz9l4skjV1c8
Message-ID: <CAPpAL=wY_JU7r8oWgcF_keq+rbpGdkhS5KF0K67g=rbX7_nwng@mail.gmail.com>
Subject: Re: [PATCH] virtio_net: simplify tx queue wake condition check
To: liming.wu@jaguarmicro.com
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, angus.chen@jaguarmicro.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 481OxLQjma_LKU6o7ogksqWo1FuxAB_G0ETOwpxqea0_1751623440
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I tested this patch with virito-net regression tests, everything works fine=
.

Tested-by: Lei Yang <leiyang@redhat.com>

On Wed, Jul 2, 2025 at 9:42=E2=80=AFAM <liming.wu@jaguarmicro.com> wrote:
>
> From: Liming Wu <liming.wu@jaguarmicro.com>
>
> Consolidate the two nested if conditions for checking tx queue wake
> conditions into a single combined condition. This improves code
> readability without changing functionality. And move netif_tx_wake_queue
> into if condition to reduce unnecessary checks for queue stops.
>
> Signed-off-by: Liming Wu <liming.wu@jaguarmicro.com>
> ---
>  drivers/net/virtio_net.c | 22 ++++++++++------------
>  1 file changed, 10 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index e53ba600605a..6f3d69feb427 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2998,12 +2998,11 @@ static void virtnet_poll_cleantx(struct receive_q=
ueue *rq, int budget)
>                         free_old_xmit(sq, txq, !!budget);
>                 } while (unlikely(!virtqueue_enable_cb_delayed(sq->vq)));
>
> -               if (sq->vq->num_free >=3D 2 + MAX_SKB_FRAGS) {
> -                       if (netif_tx_queue_stopped(txq)) {
> -                               u64_stats_update_begin(&sq->stats.syncp);
> -                               u64_stats_inc(&sq->stats.wake);
> -                               u64_stats_update_end(&sq->stats.syncp);
> -                       }
> +               if (sq->vq->num_free >=3D 2 + MAX_SKB_FRAGS &&
> +                   netif_tx_queue_stopped(txq)) {
> +                       u64_stats_update_begin(&sq->stats.syncp);
> +                       u64_stats_inc(&sq->stats.wake);
> +                       u64_stats_update_end(&sq->stats.syncp);
>                         netif_tx_wake_queue(txq);
>                 }
>
> @@ -3195,12 +3194,11 @@ static int virtnet_poll_tx(struct napi_struct *na=
pi, int budget)
>         else
>                 free_old_xmit(sq, txq, !!budget);
>
> -       if (sq->vq->num_free >=3D 2 + MAX_SKB_FRAGS) {
> -               if (netif_tx_queue_stopped(txq)) {
> -                       u64_stats_update_begin(&sq->stats.syncp);
> -                       u64_stats_inc(&sq->stats.wake);
> -                       u64_stats_update_end(&sq->stats.syncp);
> -               }
> +       if (sq->vq->num_free >=3D 2 + MAX_SKB_FRAGS &&
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
>

