Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF9185626
	for <virtualization@lists.linux.dev>; Sat, 11 Oct 2025 05:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760160111; cv=none; b=RV6citFsk21ty5XbuuXUiFOPPOUK4QD7/8J2DDc7eLT//qABkn689H/1UJtJcjyeggx9RUMI2tkQNwRVqQgRlOixlPBx2+1fagxYbXtE4lOF5cMjXoTWr/v60lXSwJOQxUYSJgjFdD+1VyLNlnjVNfshSEFtEbjbjagRY++JTeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760160111; c=relaxed/simple;
	bh=TJeg9Z4aALDqJap1+G0oltNt+C3Bn87a4wIzshptlQQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R3C7LMm6rALd918Hncne4Yzm5x6NoJ+gk7A56pEUx0dO6rz0s/pUc3hglP6Px0hM5L0p9xxRS9hIzPk23dhrouz5MOr+ZTh6vEwFrOChF6gFheBtjRC8PudcmDoKgMuOeXoets/iyNduAfkWVS6E6BT0aeaAY6VuGw6kKb5rUDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zmz5La7i; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zmz5La7i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760160107;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3yUOPtsTsKEv6cjl5rLeXUFskesAE1DpbF/midGppfE=;
	b=Zmz5La7iZ6U1EJAgYZ8IDYNTZRh0NGJgfTXBnMbge+5JsGllU2kXFD8fXbHK3K9dAgF6bm
	gzqGNmVuRNxnvMymybyOYIpdKkBHWu5hJ20Jqk3VdvyKvbAOlIqnKCpuPqVZwQrIbqbAhp
	EnDx1RVgHCJoVwmxz9DA8VKfRjxXDvo=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-308-viTRNVWPPYO-CEWavoxQFQ-1; Sat, 11 Oct 2025 01:21:46 -0400
X-MC-Unique: viTRNVWPPYO-CEWavoxQFQ-1
X-Mimecast-MFC-AGG-ID: viTRNVWPPYO-CEWavoxQFQ_1760160106
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-76e2e60221fso9415180b3a.0
        for <virtualization@lists.linux.dev>; Fri, 10 Oct 2025 22:21:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760160105; x=1760764905;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3yUOPtsTsKEv6cjl5rLeXUFskesAE1DpbF/midGppfE=;
        b=poeYdLF1QZYumVNsyH50tQrxs0kPqjsUC3UFCp3csNJKuyyxywz3GGqg+MufxiPdci
         b4geRCC67bVtfC8/4vcMRZZZBbxUKo0QA7w4cQlXhkRebpAVI1wWUzDsnXMoycNrXyn/
         X2Os+DrFckAXUYq3hXkmAMEeqhhSEBUVVoef6uK1ZYzGJShcmlgFkB96eVHzQq/wHZwf
         v+WxM63ZE0FskR9H/xBa0EamVE67x7fRQI1DF0lFMGumh79goXtgpA+WeXFyfXahtKbO
         P/AHXOPAim7cF+vgYUl/CrXtcXPVszHuTVVrhzaW+H+pEqCP3RafaBgePAggDI5VnGoX
         sIuw==
X-Forwarded-Encrypted: i=1; AJvYcCWZqvwk2GzQ0tup70BY0YAr+g+7XeantECdj5Dsk6/R9+APQKnCFsblo61+baZUuRHsvqC4xG4dhjBfs22H1Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YwGK2BycRD4Eh0iFEdtv/EjEpGBzyaBRiRIR44VtR6iG21JojEH
	H1XrYZqNspXN9+vM9tf8HbUpYqa/ny/6gGRU/V3GIRXusyyYlyC5GUkekwHxBFvDC8uHJHl8mGt
	XJIjQTUYqB9RfZJePZS8WK1O7jRo05kBosXchY6oAPZ1mNEN9VLIQD7W8aEu4gRXoeqkVtV97zT
	DWLbAC2zHHn+LdnD5GsqZqkj5GnupcStId6npspUku9jc=
X-Gm-Gg: ASbGncvfrB6846OgKAN03FUS5JysOSpfsLyCYsXBIIVezXlooy1D0tOFTOx6glJWBxz
	BWBlpe7aGV2JVaFXnkAIbt2Syqmihq2kBMAZRkH0yDP5DMl5PSehf6h4vZfNmWqpYEBfgmXUWzT
	+XEBNvS/RRDRQ3hEJeIg==
X-Received: by 2002:a05:6a20:c87:b0:32d:b97a:fe41 with SMTP id adf61e73a8af0-32db97aff63mr12231304637.32.1760160105688;
        Fri, 10 Oct 2025 22:21:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESLbYaTQ/nRv54ze+Jvy0H6UYM9Iny3wDuAFsnzcLXByiZsI2i3VTIAPf0kNgN9LhzXrDvYt6DHG3MIt4RYtw=
X-Received: by 2002:a05:6a20:c87:b0:32d:b97a:fe41 with SMTP id
 adf61e73a8af0-32db97aff63mr12231290637.32.1760160105327; Fri, 10 Oct 2025
 22:21:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251010085827.116958-1-eperezma@redhat.com> <20251010085827.116958-3-eperezma@redhat.com>
In-Reply-To: <20251010085827.116958-3-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Sat, 11 Oct 2025 13:21:32 +0800
X-Gm-Features: AS18NWDgOW4hAvaDJkPQBqz-cewMh-HRIF3tVFTzvhwvYoFoiUZL-6c_AX1jgSc
Message-ID: <CACGkMEujn923PtF1gUWk6MC0=fA6+yXPTFoyZbqiqRCHJfr4Ag@mail.gmail.com>
Subject: Re: [PATCH v7 2/7] vduse: add v1 API definition
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Yongji Xie <xieyongji@bytedance.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Maxime Coquelin <mcoqueli@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Cindy Lu <lulu@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: HwJZzJZy5n7kiz_MXLrriTOomdMystef0g7BO9ltyJk_1760160106
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 10, 2025 at 4:58=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@redhat=
.com> wrote:
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

