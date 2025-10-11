Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDEA85626
	for <virtualization@lists.linux.dev>; Sat, 11 Oct 2025 05:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760160138; cv=none; b=DlNC2HL0yF0OaDSt7AIQ0vd79GHwtkkpEIiwns1YLvDyCvhULN28W4sB9TZgLaEU7POszjoq8f31QLqI8EVkljvY++SaOo3F0jy3yHCT7fAIJu3xt6TJqO1EEECbllz5xrr6s2H81kjou25q/7bcJCDXHRnQ1/KFltp0KZ9FroE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760160138; c=relaxed/simple;
	bh=/3LzOtv8dJtC1ktenpnEogrud/DtztmjtxJadmmjkyc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nWqY8z0pArSoqHB/1lN4VRQ6G9byVdrQKjSxmixvcUXuOdBqPcti7n5Zsa54ffDbJdfp3mLPt4unxSOO1Jdp/xEvIItJ+M3yA/4/a0TpKll42gkRn3lysCTW6bivx8Cbks4Qua+CFGucpHLisn5WrwEa45jPNDkF2HIJRW9WDW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eJwEhIhA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eJwEhIhA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760160135;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oKJe1f/npSv+cn4k13IGSW6Z3J78wAl5KpQfDooVFR8=;
	b=eJwEhIhA93nO9+wOcJq7IhckH+xuy2FTklEAVjdaWF8NPxrCNvXc+wifcWowmisqPSzLQV
	ufF1dHtoSYT/8a23hteYMkuMUwAeHrcVveuE7JZdX7dNRvKPx2cm8eTgEso4VMY3M2UFws
	R/9snFLGxluWvQdMl4bPo9bZAaQHCnM=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-365-ABIrq8iXNgOd8GgVvYV5_w-1; Sat, 11 Oct 2025 01:22:14 -0400
X-MC-Unique: ABIrq8iXNgOd8GgVvYV5_w-1
X-Mimecast-MFC-AGG-ID: ABIrq8iXNgOd8GgVvYV5_w_1760160133
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-339d5dbf58aso14579602a91.3
        for <virtualization@lists.linux.dev>; Fri, 10 Oct 2025 22:22:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760160133; x=1760764933;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oKJe1f/npSv+cn4k13IGSW6Z3J78wAl5KpQfDooVFR8=;
        b=juLTSw9loHZKyG2XiuNmCEBXOwpZRGCg9Z3+4sFqt2PtGMzXoxs1C2VWwRJl8JEwIW
         PZLaVAfE44AxtCHG0ryvp/SE9l4Lk28bHH1Pf5HiQZb5ABm/VSdyz3VhBPZdAae6xAsZ
         oeQ3la2XqIxqWW93Vnr1o19YclnQaX42pvBXAbViae3GfT3ZKTNjPV5UZTcF3+uYAkpy
         pjLW1G8SkMFI4R3aX2mLLKQtljaEJW3B1iz72H21S1FxTbM4N4sgE+jeDmYE77cD/8He
         3T+jkIIxqPxxpBosPk6YlqYy0scuIoJlEu1Bp9eEraYc2LQxRMCoW6AOWfCj+k7JkC4o
         DOPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTJJBqlV/9rDEEgDKZWneJ47K2zSI6ypWXTJDjKennuRVgpmaLrcznOUODWuyuyKiM1AX+uKPrgoHp1N3h1A==@lists.linux.dev
X-Gm-Message-State: AOJu0YzA9HjnWOPwTkgY0C3t9OrselxksBAVOkvnWjkataofddoO09jV
	CxzbrplBPODl9k4SNZCOsOkGjCSGEmUaFrmgZzGEY4ae3lMuOYrQqVrwJyOOpv3MSFbgFykvYWl
	MSKXlU+I58cbCv9oePoS9iAT/ICK2tBvG9g9MyxarwZy1pj/Mjj0vedCPSfKIz3bg5dIqfqDSY6
	HakYH62xOYcO+TEwVKHz6m+3wUIgfgh/Su3HSl0g/r/PM=
X-Gm-Gg: ASbGnct1M+JL0hBuPfvwFeli1QfFpjQxnyvkoyVxoDCDk2JiOWWHBtmAaF+rp1mIGsx
	fEJ97HNJ7oUU0/wH6rrW6gKpyB61+7CJSWoKBWBk692cUg9Li8jy8F7F0L9lCtUqBtvjF71oNpY
	XIoks3c3J2uUxYUp6lzw==
X-Received: by 2002:a17:90b:17c2:b0:339:a2c1:7014 with SMTP id 98e67ed59e1d1-33b513ced34mr20732321a91.29.1760160133244;
        Fri, 10 Oct 2025 22:22:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/JD09ViFdPNqcboD87jMMMQVF/bSya9yD9MAkoy488ZtLUSNmpZ4bsRcbDyKKAOxchl7DKt9FKGg+9jJMlNg=
X-Received: by 2002:a17:90b:17c2:b0:339:a2c1:7014 with SMTP id
 98e67ed59e1d1-33b513ced34mr20732292a91.29.1760160132813; Fri, 10 Oct 2025
 22:22:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251010085827.116958-1-eperezma@redhat.com> <20251010085827.116958-4-eperezma@redhat.com>
In-Reply-To: <20251010085827.116958-4-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Sat, 11 Oct 2025 13:22:00 +0800
X-Gm-Features: AS18NWCstKUrE7ls-cyuYLB0dmOpFt6xWYANcsj8p4ighsnVT_EbI8zLz4sUvHw
Message-ID: <CACGkMEtKm0WhbGSLaHreAga7r_=fX2mrG3s+-hORYW5it-NpYg@mail.gmail.com>
Subject: Re: [PATCH v7 3/7] vduse: add vq group support
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Yongji Xie <xieyongji@bytedance.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Maxime Coquelin <mcoqueli@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Cindy Lu <lulu@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: tl9czUgYp-3KQALuSq5fRZlDPp853lzFG_ODbE7AcWk_1760160133
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 10, 2025 at 4:58=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@redhat=
.com> wrote:
>
> This allows separate the different virtqueues in groups that shares the
> same address space.  Asking the VDUSE device for the groups of the vq at
> the beginning as they're needed for the DMA API.
>
> Allocating 3 vq groups as net is the device that need the most groups:
> * Dataplane (guest passthrough)
> * CVQ
> * Shadowed vrings.
>
> Future versions of the series can include dynamic allocation of the
> groups array so VDUSE can declare more groups.
>
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

