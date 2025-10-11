Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532741DF985
	for <virtualization@lists.linux.dev>; Sat, 11 Oct 2025 05:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760160198; cv=none; b=Vuu7Yh5duKDFKXXMHDrUldaMVmODT2e1dxB+xWm7p97np0fb+P6TMNnxhz1EVk7YwrApzdp69kwGWh3JGGfhhjSpdAKrgkTRyKRKbib54vuWfnvtaXCXn85ceXD9FDkdJLI/2Y3j1HGv8sSYoJgrFREXizaIsiPUcgkDZ9OUirY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760160198; c=relaxed/simple;
	bh=ML9ZQr5qtEGcPY8cDifgT0HpjpbxGqYI3jcd5xULUAA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XqnQe8Qu/5VCYlK00AqoMKhmaJDwrkgYO8Lr1V2r6QvsABX3IF2qQr6DDB7d1KzI7lEZUQI89yTv8vtk8qlOCHJWua8/dFaYJW2Fs+3Hjxt6/pTfhZNUz4aJNzRqiExpjzgXIIzDQ//+hvo+1SELz3iFuFEuuEFw6NxhSQjB50M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D4KoTLsx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D4KoTLsx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760160196;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FWQu2WGPhVIahnhNe0m6Df6o5Q5Z3ctJ9ZyziPIltjs=;
	b=D4KoTLsx6PyE1CzGu6K45Be+CKLDSA8jXu5/hW2VzmxU7e1Hw9ZpuiSlJ3n3CXPFB2Qq5N
	X/Rortx/hixhEeu1HLn2jA7HLobqgHVjAA5bIY+plEeXsptYAxOSjEJLsc5Ve/zYZ8EkyU
	r2ZIXM7KDkuWpHYXJyg5Evh/sExHp58=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-DIDV4A3vMpGY1O9mr4-T6A-1; Sat, 11 Oct 2025 01:23:14 -0400
X-MC-Unique: DIDV4A3vMpGY1O9mr4-T6A-1
X-Mimecast-MFC-AGG-ID: DIDV4A3vMpGY1O9mr4-T6A_1760160194
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b5529da7771so5461332a12.0
        for <virtualization@lists.linux.dev>; Fri, 10 Oct 2025 22:23:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760160193; x=1760764993;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FWQu2WGPhVIahnhNe0m6Df6o5Q5Z3ctJ9ZyziPIltjs=;
        b=OifbVNU4ms6wgwW5O6l9NFOpJLeXnTKS5fU6TmBcHZne1ycwlCwFlR2edmH4DmYO9b
         +AQK7x121Gb1S7qRFyOpkztnoOv5KgS4w+KQ1cTClNAX83e8KkKSEPgwcYv0uStB4c0W
         TaqpQLoLJP8sKqq79GAqnOoTm9zmDwkZAI+33FezDV+uy8VJKnZIMwVQhg5Er1E9c3hv
         jqFyZD2yObuIVSGiKVe5Cmk4dVOi+n5fbjHjLeYNz6xAPrnUcvpRmA9CauVS4LlDcZF3
         VotoPlN585pwGAhgku3yEACmHBz/io3y/HlqRi+5O2gaKZECNr1flmCr4YcA8trUoPIK
         X7rQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrs8XoRTiEWKE5SJ5D+CtQ/pxea8nJf14uKj1tw6LQa+Behy7wKXiFW3zbBupl5h4judS03LD27N95bMp0QA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzWLhjV0iRrwKEnCxn5H+65ziKFgzKjFTfc4Wb0mF3NDdyjz16T
	8bmeqM6gX6Hs4yvPl6YGFoDvIIexKAzYZdPCUgyKORNQL9Eml2zB7jzSf6cByk5CxgSZ7CcEJ28
	3wF1qYNETdEOUAmVI1UWbFhx+qEuA2xoHNRTjGUhRiqRNeWi4UdA0h9S9lHltAXFMM5hck9K7aQ
	aw9mVdjz2KRtsgaTisVkOMwc3EGCPXcBxQnOCLkjcuPnIy8S/bk72I9Q==
X-Gm-Gg: ASbGncuRf33OxvZ8DPR0CuFmA6Bqi53mUcq9nGL0/jhkB3/2dxdTD236gUMvsyFh3p6
	WYbBhOVU7h3GrJrRuB4twRkfSdSLi/8EgxeO93gDyM2xWTzFcbSGl7+LZDpay7vd8YBrV5Rsara
	dnMqbHKzAyP0AN7E0jkw==
X-Received: by 2002:a17:90b:1e06:b0:32e:936f:ad7 with SMTP id 98e67ed59e1d1-33b513a1e9fmr21398909a91.27.1760160193685;
        Fri, 10 Oct 2025 22:23:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFP5N0j+lF1l6DP1UUMeDKPPGWGysv0k6+OdDZIQppdrlog+Rls2Qb28QkmANh5HgziapaNwTapps756d2070Q=
X-Received: by 2002:a17:90b:1e06:b0:32e:936f:ad7 with SMTP id
 98e67ed59e1d1-33b513a1e9fmr21398889a91.27.1760160193302; Fri, 10 Oct 2025
 22:23:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251010085827.116958-1-eperezma@redhat.com> <20251010085827.116958-6-eperezma@redhat.com>
In-Reply-To: <20251010085827.116958-6-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Sat, 11 Oct 2025 13:23:00 +0800
X-Gm-Features: AS18NWDV6gt530hRMSNr0SDAAntHl3ul-57z_6fY_ncu_SQpA-XmeSLZwozh8LE
Message-ID: <CACGkMEvSm_YQGgrGjaLU0DM7XW+YLeGi1AdvRn8PzKwRLW5Cpg@mail.gmail.com>
Subject: Re: [PATCH v7 5/7] vduse: refactor vdpa_dev_add for goto err handling
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Yongji Xie <xieyongji@bytedance.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Maxime Coquelin <mcoqueli@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Cindy Lu <lulu@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: s7hDBD16-jqICPAOSOilcni2to9Y3O_V1ZbBJVTincQ_1760160194
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 10, 2025 at 4:58=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@redhat=
.com> wrote:
>
> Next patches introduce more error paths in this function.  Refactor it
> so they can be accomodated through gotos.
>
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> ---
> v6: New in v6.

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

