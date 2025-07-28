Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5456043147
	for <virtualization@lists.linux.dev>; Mon, 28 Jul 2025 13:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753710137; cv=none; b=GNNn5yHedMyO0IpgTFB+a9dc8cHDTLuAMQB4aDcQ41QHrxdosuaVZPzFJP/yzZWF+DhoLuwUF8Gx0qeQg16oV4+ybMb2FpmZoV1bE1+19LbYd8f/DPl5/V7DSQI4/zbVyuSndolywzVvlckfv0Cu9gsvqw/kmGSuObQrSRs4JSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753710137; c=relaxed/simple;
	bh=Qi73DRoSdKFUDtg+GqUWUXH46IoLyNyfTl9cXuf39KI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nUIF5uA78RWNXJYZCwl88RFHcsQKMpx1Khavs0OGyRvZ61pIDSNQE/32a35mZ/6YbXWlsMi2mKQHcQPQHf64Sv4XjEX/BEstKziQE8GCE5zDTjCc00EmGHMS+bl6rZOXAdIgiH8Bk4kOGlKIPWYjjSFW3bWZ3Mtz3mgrRpcmae0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e3apBcto; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e3apBcto"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753710133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N+z91P0F4/0V3P8rhqCpVUP3XXznNf+Eecy4UXi6zcY=;
	b=e3apBctoDmGLP9JFRSs8Ym5TdWp2J5pNXMbwkUEu79fCCEbt+9w+DjMtP9jGayuMAf52MA
	H+N/HzESGQ+ahT5M9Rt4RfXcvgSrzmwKSnc8mSNInWHY3QZN3vzjHwC3X5RxndOGdzBztx
	TGC53l4yYSVQDT/jVxSnUr1gQsEq8jQ=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-h1riCpasMAyf-8gmMsoFPg-1; Mon, 28 Jul 2025 09:42:12 -0400
X-MC-Unique: h1riCpasMAyf-8gmMsoFPg-1
X-Mimecast-MFC-AGG-ID: h1riCpasMAyf-8gmMsoFPg_1753710131
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-234f1acc707so40705585ad.3
        for <virtualization@lists.linux.dev>; Mon, 28 Jul 2025 06:42:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753710131; x=1754314931;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N+z91P0F4/0V3P8rhqCpVUP3XXznNf+Eecy4UXi6zcY=;
        b=IsnnMGGEZ7ZxyPfmTSis6eo8BzRENclUHGxvAT4rtUZ4vlW8GMEdjF6LOEtkWzc8NG
         27mehbaO2c2cqMYkNnSD2FV7elJsxzNkgntRkH8rk3WElpV+Oy0lkPWt47l/5fxb5zhO
         NbyR904POB2UESPHpQLNJtr2I10huMZ6ZxYtQsytSa50/F+YjRHaYjpJ+juM5zu3e9r5
         UTsZtf9/jACEfNF4HvyZJlGjXTvt9rzolhaaKjl9I7hTCmmoNB6+qx0IO+B0SSQNXHxH
         KmKzLG8yPG1k2x4LZt5+wazUcdv/ff4eqjvxELnWzFt4U37RMknBBpmDUimqTnx5nCQ3
         XMUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAo2bck9cGOuYmsu1Vpxjp+ZmIekzZ0iCZn9Qho/dyCyGj0lZdkyq5+ed+vdkVsQvrW0vghk9ficNHBwnYxQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyFNML+L/h2ste467RivIZr/tAD1GiZ+5BJCTwiDmLo8Aa+kSa3
	VkrQFB870VE+9RVPDbHFvJ6QvMZJhvkyxgK4BwNuBkOCQzzH01ex8zL2zkS0xkkTK8Z7Kg3fyf1
	V7tHTEAy24Cil7c/Q3MT0BvrfxjZ0o6hLRGRiGLY9RiPza/kcSqJuWrYtUqbOODImtvnvzHiRPp
	Y+98dEC9wmf08Jyx1Zd/SOzfJbFhPM5u6lzuuH1i21rAQ=
X-Gm-Gg: ASbGnctFU8FkItDJ9x/K2D7OkZ87fTcac2iGBdQBG5eGWb/v8ZHnWJA318bxRD42V45
	rPwXW77LVaqpjrhFNDPuKLYmM7ryho/AhcvukAIolG7Ijs9SyJDg9HK0yrcrg7Tfookvu7eOLPD
	WjG3Qw4mP+Gj5DlWceJNGb
X-Received: by 2002:a17:903:1c2:b0:234:ef42:5d69 with SMTP id d9443c01a7336-23fb30995c3mr182209925ad.13.1753710130866;
        Mon, 28 Jul 2025 06:42:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHtpGSH0sdEHyiDtTCdyalB+5CXKfabmBBzxTMxNDt4pqkBUOeol9l7wFkRGUrlKlV1TFiSAWJviDOHFEHtNE=
X-Received: by 2002:a17:903:1c2:b0:234:ef42:5d69 with SMTP id
 d9443c01a7336-23fb30995c3mr182209645ad.13.1753710130476; Mon, 28 Jul 2025
 06:42:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250724064017.26058-1-jasowang@redhat.com>
In-Reply-To: <20250724064017.26058-1-jasowang@redhat.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 28 Jul 2025 15:41:34 +0200
X-Gm-Features: Ac12FXzUYMLeBVSoheOigrILsCXTJHp77xuCF_ZnD4KDihWoroctcgBEpSz1Kg0
Message-ID: <CAJaqyWddTABhmjGjvY5F91g1x5pN4MxCtPnsWt-3H=SqEKO4RQ@mail.gmail.com>
Subject: Re: [PATCH V4 00/19] virtio_ring in order support
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 5MBD4TuLPwOuT2695e74Aen7jgklBhpgvddspcx7syw_1753710131
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 24, 2025 at 8:40=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> Hello all:
>
> This sereis tries to implement the VIRTIO_F_IN_ORDER to
> virtio_ring. This is done by introducing virtqueue ops so we can
> implement separate helpers for different virtqueue layout/features
> then the in-order were implemented on top.
>
> Tests shows 2%-19% imporvment with packed virtqueue PPS with KVM guest
> vhost-net/testpmd on the host.
>
> Changes since V3:
>
> - Re-benchmark with the recent vhost-net in order support
> - Rename the batched used id and length
> - Other minor tweaks
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
>  drivers/virtio/virtio_ring.c | 902 +++++++++++++++++++++++++++--------
>  1 file changed, 690 insertions(+), 212 deletions(-)
>

I'm happy with this series and it solves the abuse of the DMA API as
far as I know. As a suggestion, maybe we can get rid of the
vring_use_map_api function and move it to the vdev? It's actually part
of the TODO of the function, and this seems ideal.

This can be done on top of course, so

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Thanks!

