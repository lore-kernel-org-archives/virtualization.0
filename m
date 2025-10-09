Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C96824BD
	for <virtualization@lists.linux.dev>; Thu,  9 Oct 2025 06:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759989793; cv=none; b=uY3ep3ktlyxEghiD7f7uU6+TvMOX4zH/v8tSsx4z4XHDcZIbYASX1E7uSzhyr/n6KAtm4gz4EjHm4cVdW/Ke4RO7BnedkviHn0zJbI9WUZKrHSmuUAFHhLCitQgfQvfEAM6v6URfgB1KKEkipnicqSyKgX4ErMFjWo//cr47ICM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759989793; c=relaxed/simple;
	bh=m3LMdSR0pUCk633KJY2rAFBl+kdS7af4YNqnHwPhzSc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F+oEyQDnvIvUjumRFJ0NzpxadcVQtBrHZ6KUvGqRPiug8t5FqpwynsDE7FtsDbgoXV9+NJ7IPxhXSZ1wTXaco4tBa83zzSRQCUJZp38bB8D/X1xjGVYib+OAPkb9XTgIxldVJx3QguOWKyBYjwa4pBlaALH+7RMMaj7VJkUxPL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HMwkIxzR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HMwkIxzR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759989790;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P+TYUU+xeDw8HGGSvf4GTNBs7jshrvw+KJVNBUadUDQ=;
	b=HMwkIxzReisIQj8NlSfFIuhRg1VVkXozf44J1ezCFaHzWuhX86jCVd1do71n9a0YAL9hx4
	9csZ+aXs3MIXoL+SSXMgWaZ7niGzybbfDjFTddXMuexsgbrcI42CNoAl4FnqHgtkL4F1BU
	/gghvCxFwyORCRwJXR9B4M+SXh7ygmw=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-vJrV_AQyNfuujoAJj5vBtQ-1; Thu, 09 Oct 2025 02:03:09 -0400
X-MC-Unique: vJrV_AQyNfuujoAJj5vBtQ-1
X-Mimecast-MFC-AGG-ID: vJrV_AQyNfuujoAJj5vBtQ_1759989789
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-5b0ad39e10cso401534137.0
        for <virtualization@lists.linux.dev>; Wed, 08 Oct 2025 23:03:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759989789; x=1760594589;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P+TYUU+xeDw8HGGSvf4GTNBs7jshrvw+KJVNBUadUDQ=;
        b=K+IeiSRLNKxI00sUwnY88bdg61tssJapvXr39lOY4tqncnVpMLO9OxEGohsKpoxJ+V
         TMHgWAf/ksPI4mV5efkA0bN2BoXT40d7d9hBvVfffWf4BiBWx9KbBKyJMrrPC7J3bYdf
         /A0kOc3dVgBL1o1J15iwJ5rKaReinKTfsQHoQ4hmwlEVN8vi0ZD7BQy9tn1dT4AEnmJ/
         7c5PKL6RoEf0uimwjEdcZv3l/DU4EJX0o5Dn1bwrc36AooGA+0McIkU81TbIf53h1+EU
         fHZ+SvRy4MmNt6IffXPw9mhFzEXxtlabWYrzQFvv/P0sESKYdtUm2V+KB+oP44MemePK
         mvUg==
X-Forwarded-Encrypted: i=1; AJvYcCUHwmQCGbLox//ClN6oTqtJpI2edq0gXh+JkuaxmCHPJMaZn+Oj0NjQEFuDedSI/Ryhv3l4dbel+BnoT/FGqA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx+/NagSweXz0/lTKowflknh5lvrlgN0/dz5z2hg1ISlpQozciE
	CQtYBW9c9hDciNqIzr5RFNMDzWgcEqVWDKx60zzXLzp/uCLbjbJt5Cq9zKObQyi0nQrPBGvj3gx
	bJb+mbbPiQZEIhtcFbr1/M3ybLFAPl2dWjEXfmWw7oSdn4GBUJ8aSfHqgj/Ajxbif7td4RZ+adX
	lK+9tSkDyVXHCXzogRvp3VeOr3LPhxcX2QhZRacOXei9c=
X-Gm-Gg: ASbGncs2QvQGJOHjQchcMoASyJHBFA2CnnjnIul4C1oDXcRh1/hgMlfYZWhJVp5R5uq
	2lIRN9P3ywuLBN3UBPwP6LoK72fysE+vV2JPEIwW5mTSEkXcJnY5+k/fi27M9rB1npNJl/VUQN1
	4m0ZyeEwmGJAvKfzpjtNZHlHY=
X-Received: by 2002:a05:6102:50a3:b0:59d:458d:b629 with SMTP id ada2fe7eead31-5d5e23b6f9fmr2592706137.30.1759989788809;
        Wed, 08 Oct 2025 23:03:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIVynxqXHdtPe98YX2uMJXg5j6g1+mpitA+niP2MyNvau1YAC2uKE39BRPR9p+oXUwcQuZODNisuncD9hvjIY=
X-Received: by 2002:a05:6102:50a3:b0:59d:458d:b629 with SMTP id
 ada2fe7eead31-5d5e23b6f9fmr2592701137.30.1759989788435; Wed, 08 Oct 2025
 23:03:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250929165213.2896034-1-eperezma@redhat.com> <20250929165213.2896034-3-eperezma@redhat.com>
In-Reply-To: <20250929165213.2896034-3-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 9 Oct 2025 14:02:55 +0800
X-Gm-Features: AS18NWCRvWiPkTewAunTvSLshw0QM9Wb0_PtyIIsY-hGVYpA9RFg6jNGdChZg58
Message-ID: <CACGkMEvnS_zYoCbh-MMjApFXQGuMdUrJ=EjOJwXkwUUdqfToNA@mail.gmail.com>
Subject: Re: [PATCH v6 2/7] vduse: add v1 API definition
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Laurent Vivier <lvivier@redhat.com>, 
	Yongji Xie <xieyongji@bytedance.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	Cindy Lu <lulu@redhat.com>, Maxime Coquelin <mcoqueli@redhat.com>, virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: G79UedooQ4lRA1YWP-i8jONL-pd_SEbHchx4f-nRCdY_1759989789
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2025 at 12:52=E2=80=AFAM Eugenio P=C3=A9rez <eperezma@redha=
t.com> wrote:
>
> This allows the kernel to detect whether the userspace VDUSE device
> supports the VQ group and ASID features.  VDUSE devices that don't set
> the V1 API will not receive the new messages, and vdpa device will be
> created with only one vq group and asid.
>
> The next patches implement the new feature incrementally, only enabling
> the VDUSE device to set the V1 API version by the end of the series.
>
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

