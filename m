Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9635212D7C
	for <virtualization@lists.linux.dev>; Tue, 17 Jun 2025 12:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750163435; cv=none; b=FzxU02+pEcC/eQU+pGjf3eLvDB3NLEpETfqyGXM7GKNNLBCyyYGqEO7xx0Es3ZtjCxHFXkmRFNN9LYS006cFGoaQNiGrvNABKTfaKY2bRHuXf2D9x2Q4rajoLJmPhUGYieP6de2d46Bf5thzQCRE34ZBcAFiFTIZLHdykaxENcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750163435; c=relaxed/simple;
	bh=TB/w16P9pB9DnXe6stqbMfh5xgU3Sips4Ssv9O+y+GY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F4RU9GFbvRu48DcgVgzVJlIZFidiAP1tOljT+wSHlHmeA9H1CMqosadyKsRZuivjsZlVJq+Ftgz3uPFsUpvA4xi3c3R0Wlt4jFmMSBCtUbIaxW5YI3gUVtiLnSZK2aeXvWWYdC+8qkDgvhlV42ZJcEW9PwfjbX6dinxoTiEL3j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fcGV2Eqk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fcGV2Eqk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750163432;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C4KpzV7mfKG7YJcI56fObFy+07qjMjy6zIN0X7a6W3Y=;
	b=fcGV2EqkpwmV0BYWpkWiPoZAyeDypJkFY84lfgbm8I3pTN+a5gdEybWtbpeo+1lqTWBt5+
	/324+flPE68+pQ1o2l/05aSI7mBudpUMftk/Nufq7cA2tsmrKZLfraxngJ5o+8fxKhPKIw
	J50q0vMsbJEvERlkImHWE72Tn5gP2cQ=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-546-mbltWTioMPuevuw4TbUoMA-1; Tue, 17 Jun 2025 08:30:31 -0400
X-MC-Unique: mbltWTioMPuevuw4TbUoMA-1
X-Mimecast-MFC-AGG-ID: mbltWTioMPuevuw4TbUoMA_1750163430
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b2f4c436301so4133876a12.0
        for <virtualization@lists.linux.dev>; Tue, 17 Jun 2025 05:30:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750163430; x=1750768230;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C4KpzV7mfKG7YJcI56fObFy+07qjMjy6zIN0X7a6W3Y=;
        b=tdBgha4hhqTGStgC57X22p4+PJ4UatJs7UP+aLwu5TBWDLxnoVPyychLdhF8pGcbWL
         GBGrFgqWILIfcvAwRXXgj5ozsiA1NGpPebRrAKr6apT7qle8oPwfyLD0OxOVuRT//ZDN
         iBESmszrK+xyoWOyFf+Fj/zpZFdWImhzKXijbuaM2qrj4lTtuY0W2zKD49Y5SuTPQpWj
         20+VZ8dJ/41mGa/uYmFMuzGcT4F6C5TFmswc5FNXb14GkjzAf1/h6xWQQpdGx4uAIcDJ
         yXFfD7KRR/bTo67KrzOr/omwVMz+3tgaR6/6ftuT0xV3Dak1J9IQKdbQEISmJRlhX1QS
         D29g==
X-Forwarded-Encrypted: i=1; AJvYcCUxkV5/P9IUjtbx3tsCD5etHaDszMgRBe1hQPGowDdA+V7sS25RT6Aseo2SqYD8lkJfjR5IKx9OqccFHYciCQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzqmhzCM0++KB04i6ELnaOQMezjzQeNUUtEwVA2U3K8yJ/pj0rY
	QalyuWJvA9RvxYOwQFbMxXnzQYfQKcq3ThghH2cGFLRnnM/bSCrYiesoK0N9IOyBu3JmPJqzoj2
	xoFPyJ7zgiBGqh6aZmvSLUxlkiNstoKPwoSb3c4LtwDB9oUNi78i8s8qNAVbmpLffN6YEfcEezF
	ONzKELabXtFNEDX4uKUebphEdIOGCUzqPlkCR8ojUohSk=
X-Gm-Gg: ASbGncsS81f/4K57PsCb2XyPB+3GCcdFgC3vRtJqMR+eN0Ij5DEfHBcMclwilTLOaLP
	y99MicDVdb/lG7cmlKtFYLJq4ih8ocJwLQ1lXor7yRmraKOqF8gn5l+vEthiLHSZUl8b6oJfiUS
	YmDA==
X-Received: by 2002:a17:90b:57c5:b0:314:2cd2:595d with SMTP id 98e67ed59e1d1-3142cd260camr1982708a91.8.1750163430336;
        Tue, 17 Jun 2025 05:30:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQNEBXEy5uriJtOkqUSJvEhCCTvxWbcelcAhaQW4UNtVmCQ1n9HvM1d8Jev83IHABwhp+As21PazyBz3dX5LY=
X-Received: by 2002:a17:90b:57c5:b0:314:2cd2:595d with SMTP id
 98e67ed59e1d1-3142cd260camr1982671a91.8.1750163429917; Tue, 17 Jun 2025
 05:30:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250616082518.10411-1-jasowang@redhat.com>
In-Reply-To: <20250616082518.10411-1-jasowang@redhat.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 17 Jun 2025 14:29:53 +0200
X-Gm-Features: AX0GCFusAvHVE3AZoZTULayMywUaufTKyuftKIh_kB3-gFeGtOgP4a0XWHoJg-U
Message-ID: <CAJaqyWehyX6TvfCk_8L_dKxkkpR-P2CwHbobGOs5tX8rhxQyjw@mail.gmail.com>
Subject: Re: [PATCH V3 00/19] virtio_ring in order support
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: TqqRF0lcNqWUvWvtI3lYWw_s3vYerIrRh0qfkhVMDVc_1750163430
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 16, 2025 at 10:25=E2=80=AFAM Jason Wang <jasowang@redhat.com> w=
rote:
>
> Hello all:
>
> This sereis tries to implement the VIRTIO_F_IN_ORDER to
> virtio_ring. This is done by introducing virtqueue ops so we can
> implement separate helpers for different virtqueue layout/features
> then the in-order were implemented on top.
>
> Tests shows 3%-5% imporvment with packed virtqueue PPS with KVM guest
> testpmd on the host.
>
> Changes since V2:
>
> - Fix build warning when DEBUG is enabled
>
> Changes since V1:
>
> - use const global array of function pointers to avoid indirect
>   branches to eliminate retpoline when mitigation is enabled
> - fix used length calculation when processing used ids in a batch
> - fix sparse warnings
>
> Please review.
>
> Thanks
>
> Jason Wang (19):
>   virtio_ring: rename virtqueue_reinit_xxx to virtqueue_reset_xxx()
>   virtio_ring: switch to use vring_virtqueue in virtqueue_poll variants
>   virtio_ring: unify logic of virtqueue_poll() and more_used()
>   virtio_ring: switch to use vring_virtqueue for virtqueue resize
>     variants
>   virtio_ring: switch to use vring_virtqueue for virtqueue_kick_prepare
>     variants
>   virtio_ring: switch to use vring_virtqueue for virtqueue_add variants
>   virtio: switch to use vring_virtqueue for virtqueue_add variants
>   virtio_ring: switch to use vring_virtqueue for enable_cb_prepare
>     variants
>   virtio_ring: use vring_virtqueue for enable_cb_delayed variants
>   virtio_ring: switch to use vring_virtqueue for disable_cb variants
>   virtio_ring: switch to use vring_virtqueue for detach_unused_buf
>     variants
>   virtio_ring: use u16 for last_used_idx in virtqueue_poll_split()
>   virtio_ring: introduce virtqueue ops
>   virtio_ring: determine descriptor flags at one time
>   virtio_ring: factor out core logic of buffer detaching
>   virtio_ring: factor out core logic for updating last_used_idx
>   virtio_ring: factor out split indirect detaching logic
>   virtio_ring: factor out split detaching logic
>   virtio_ring: add in order support
>
>  drivers/virtio/virtio_ring.c | 896 ++++++++++++++++++++++++++---------
>  1 file changed, 684 insertions(+), 212 deletions(-)
>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Thanks!

