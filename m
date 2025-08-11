Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078C05680
	for <virtualization@lists.linux.dev>; Mon, 11 Aug 2025 03:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754881898; cv=none; b=mZLTQruFe45JCznzSTnpONyZpabyyy6ENJKmF61RhW7l1Q1Y2Ion0GvDf8hA8+rqbeXu+xyhm0AczaFn2PNHpAK8FPmtfIua3WYug28zVS3Y4ngHraauIJIo+x8u7rGy+fkJdphkddoVpXWNvIXaJRKNlDBKbqBMoFy2MjmVksQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754881898; c=relaxed/simple;
	bh=maBI7Z0cjVr3fr8aTy9OrixNNANW0wIyfdiqxV1IUMY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=coPkqEkRTCk0VdcT3Yi4WZOMRq2uwB/r99qododUL4av02DL3fAaCpkcSRauso7RpaEvwKhgiksxTyfuTf+jl0u5wEKXTH//O2doR5WfS52NkkVzP/5Lv21c50uz/c5Gd8rhwPrKcTWfm2tw3hGTv5Z/PEfUvbpHyYsYjakFfYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ya2But8F; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ya2But8F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754881896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/pEQbTxYjhGDFsHuiWNheJaVv2nv1u7UUbIdxZWb26g=;
	b=Ya2But8FQkX3gUFAUQzW5GG3z/9s6jjvDSOtUIawWYWU9HhemQIHjO1h/UXdqXEn+sWdUv
	89VzQ+FfHtUiblghR9eDWTgA4SzAgfk3XNeB6TkbnEJS6bDRuhB5En/a7z++wOMLPBqxqv
	zdzvFQnnXHvp4AUTbzF0n+iJTgtcMeY=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-292-nFiJbw0QPXKRwndXiiSFcw-1; Sun, 10 Aug 2025 23:11:34 -0400
X-MC-Unique: nFiJbw0QPXKRwndXiiSFcw-1
X-Mimecast-MFC-AGG-ID: nFiJbw0QPXKRwndXiiSFcw_1754881894
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-76c0039e0f6so4108840b3a.2
        for <virtualization@lists.linux.dev>; Sun, 10 Aug 2025 20:11:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754881893; x=1755486693;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/pEQbTxYjhGDFsHuiWNheJaVv2nv1u7UUbIdxZWb26g=;
        b=c0mPEIeknX0FuPbFoGmYtby3TVGJlVgBjJelo0DDi8qGKN6jBwyKfpNFIP5xcgtVGp
         EGwlPLDcd4pKsA0iBXRs92uUXrBDmgKnbYP6P0p77zjS7QLb/iBYSV/wdm+QbUxVvR3Z
         B6FEH096bPhamYI4R5YA7YWQIya0eHElUoZUUo764g9r+FwhnOxHCd7pRtUzFTBOoX8F
         ZaXHJCuMlb8E6BX0tghjM8a+rM2fBkEHFIULWuEH/X0zuufu2IiZLC+nyt0S1qqOoisr
         dATwCjp1o1IrC0t6e1tK5BJH2yHb7eAtxcsAT8F44y6S/K/KnVRxOGZgcd/YOT+/SSvg
         T+qg==
X-Forwarded-Encrypted: i=1; AJvYcCXvBd5BmhyBb0viH23qTq0LArTNHyPVvzMnLZDqW+iVANMiKCTgg6zh9sQSGmziCMqtPLDBnnHWN1NbyhhAjw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy/XReIVhOwp8H7CqC4T1u7yAVUsllPeHxY82QfuKyaetrKNIoy
	YPgvKYGHhXtTLDRE+PP1vzrBsF9RhZYBu8jJ36f40PsnWUGd8Qu7CTR0UIrNi0hUp0FTPoe0dOW
	kgQiquFL2BQXU4N6PB0kyzgk3EzeJceJMYl3BKh+SnfVuGSaO/nGltop/hOSfFLTz+9WuO8AHIA
	168wyBKEexg2i72HxZ0jDevl7cs3smGv7zydeCiXw/hI4=
X-Gm-Gg: ASbGncsbIkPB0eklFw6etZv86CzJ0wZHTeO6TjQjqt1OAO2T6DN5gB1GUg9Q/r7GFvH
	UGhx06G1kOZ23F4iqJQZIXZ7cBWRqQ57hhkBNyvh9aFkoG9jyC6CkhfCpK3vSw8fIdDwbuLdOJk
	5eeMY1175aPT+dQjXOqJY=
X-Received: by 2002:a17:902:e88c:b0:234:ba37:87ae with SMTP id d9443c01a7336-242c1fdb1a4mr166559245ad.4.1754881893622;
        Sun, 10 Aug 2025 20:11:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtsx3KVyEM5/UWa7sqePKmGH3R/EGRQ55o/tUcNQZ17kWqSxEip+vydOQXtPV+WGUnScm9VUwpJK8slj4FmTA=
X-Received: by 2002:a17:902:e88c:b0:234:ba37:87ae with SMTP id
 d9443c01a7336-242c1fdb1a4mr166559055ad.4.1754881893271; Sun, 10 Aug 2025
 20:11:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250807115752.1663383-1-eperezma@redhat.com> <20250807115752.1663383-5-eperezma@redhat.com>
In-Reply-To: <20250807115752.1663383-5-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 11 Aug 2025 11:11:22 +0800
X-Gm-Features: Ac12FXwId_v-tQZlxWMiTuxB91Fl1Rss-uSa9iR_qSTFJ8fcB0sIt4v1QCSUZe0
Message-ID: <CACGkMEurTUOb6t9g+nVdzwU8LrZ=eAAxzHYVCTH1XkQkRtAUXQ@mail.gmail.com>
Subject: Re: [RFC v2 4/7] vduse: return internal vq group struct as map token
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Cindy Lu <lulu@redhat.com>, 
	Yongji Xie <xieyongji@bytedance.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	virtualization@lists.linux.dev, Laurent Vivier <lvivier@redhat.com>, 
	linux-kernel@vger.kernel.org, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Maxime Coquelin <mcoqueli@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: UiiqiV4PLaWgmrgq5DgOglP48oMOU7sfary4UPkQEiU_1754881894
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 7, 2025 at 7:58=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@redhat.=
com> wrote:
>
> Return the internal struct that represents the vq group as virtqueue map
> token, instead of the device.

Note that Michael prefers to use the iova domain. This indeed seems to
be better.

> This allows the DMA functions to access

s/DMA/map/

> the information per group.
>
> At this moment all the virtqueues share the same vq group, that only
> can point to ASID 0.  This change prepares the infrastructure for actual
> per-group address space handling
>
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Thanks

