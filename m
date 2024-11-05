Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A2E186284
	for <virtualization@lists.linux.dev>; Tue,  5 Nov 2024 09:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730798569; cv=none; b=bd1ayVY+WdPPkAJLewiCPXlr5mVLiVhnNch8EJZ4n/OoGw1J8BfVDjtOiAAC1t1mN7bzFQiPqeIfi0Xe+wH6YRl3cU71TTyQ4rXxUNk9r/lQFElD3K5FS+uNCgjQjkGfWnOir0QzEo2kzrS+FpDhtXFQL3sqTm55tjwQWacwiXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730798569; c=relaxed/simple;
	bh=EF+cUOkjIhI0I2fV5fEeBbZvkl9AhwMOu/7bTG8aM+c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DYs8QLIl2pFUcbwP5uwBjMxgFHwiUhjn8CCcnZAhrQKWcp5kChjQ5py6ql1Qpei3KLb0fUq1bZUCBHkn3nGPrzVoQEiMbs80OKWMMiMKQ+rL6tBzWl6q8m6LZCuN9L7xI6N647g5ThVo2tdRmcfjqgb09FqTWmMNxzWwlx1PcrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eEXIBrKR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eEXIBrKR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730798567;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EF+cUOkjIhI0I2fV5fEeBbZvkl9AhwMOu/7bTG8aM+c=;
	b=eEXIBrKRrSTkMnrZsG/0MCrg2iVPwtkNduOic2htnCm/6BCpv28uyqVwNs+Feo32RZZV72
	24ulsSOKeHggMGLw39IVaUVDRDWlTO75EDloe9MAVWdtzfLkvXYdWuhzSDOUPuGZbg6Czr
	N9CsX1eNKrIQcMA+A9oBmyFxsjxddqc=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-VoCshlxePfa2vTEYkcKUNg-1; Tue, 05 Nov 2024 04:22:46 -0500
X-MC-Unique: VoCshlxePfa2vTEYkcKUNg-1
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-71e8641f2a7so5566481b3a.2
        for <virtualization@lists.linux.dev>; Tue, 05 Nov 2024 01:22:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730798564; x=1731403364;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EF+cUOkjIhI0I2fV5fEeBbZvkl9AhwMOu/7bTG8aM+c=;
        b=CdqfhW9Naf9iJG+6WqtHgf30amD5sr3WF9gRiCHTuEGMUmyk4FPG+WRUL1zCHc0KFK
         P9pcVasavXdqJF1WOBQXvF5+ujA78UVILHXvbFg7ChmBQqaZ14Kzi3yabY+aIxgvxET1
         3iuAP4i60+L4eK7/p4aweBnZU55Vue7ZXGPVnOIoRI4xf6iPCjFC3qHIU3iMR59VLEBs
         jFwNRkZtbR4p3lFG61FDY5d8tqYsmzimlGMQ2MeGC33Nbv0l2E9iFGtd6UuLlYj/981U
         jgWeDD37/OOJ+u383JvYvZGKjroUPh6YTOdo71F3zzg0FHNc9M7m8EEunKLXAms0lBX3
         WCxA==
X-Forwarded-Encrypted: i=1; AJvYcCWklishPhFwECwSMN7kUs+B6PO7RH6ImINg1mAPgMdftpkq76HIlEla+f8DJMYIcUDHYPKRyy0n1rIPmgisuQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwFGYabsinwcTUo2W+mVb9E3BZ82C1+pg5M8T6G9nkhXvA8cEQj
	gEVaWyVr5HxNISDJCIAqgiZfpkGRmsXSCeyNfQfepv9Y5/2Fdc6MRZrq8lxXU5r3ViT5UiHe7Ge
	91MejNbDkMzvokfGfuCcZX0o7vIyka+bUuG0+rxg3N7H7zIzlmfY6VtTr82YErB3v+slH9Q9euk
	Yy3SCRhFffuA0LfMqNdoE+zOz0pnbOw8Mw9y2Bs4M=
X-Received: by 2002:a05:6a21:3a83:b0:1d9:282f:3d16 with SMTP id adf61e73a8af0-1dba55ab06dmr22782422637.32.1730798564194;
        Tue, 05 Nov 2024 01:22:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEUF89/hihdswxOtAb4byZStyWXa9YeJw2bT+DRtfOsSJAEuOSAjJDBwQX2nvxNHlBrXE1XdSe3ApulAMDdAps=
X-Received: by 2002:a05:6a21:3a83:b0:1d9:282f:3d16 with SMTP id
 adf61e73a8af0-1dba55ab06dmr22782407637.32.1730798563750; Tue, 05 Nov 2024
 01:22:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241029084615.91049-1-xuanzhuo@linux.alibaba.com> <20241029084615.91049-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20241029084615.91049-2-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 5 Nov 2024 17:22:31 +0800
Message-ID: <CACGkMEuo7ADSJg-gv_qtiGt=M3VqVjR76Q4baqkDmNLsb7OcAA@mail.gmail.com>
Subject: Re: [PATCH net-next v1 1/4] virtio-net: fix overflow inside virtnet_rq_alloc
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	virtualization@lists.linux.dev, Si-Wei Liu <si-wei.liu@oracle.com>, 
	Darren Kenny <darren.kenny@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 29, 2024 at 4:47=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> When the frag just got a page, then may lead to regression on VM.
> Specially if the sysctl net.core.high_order_alloc_disable value is 1,
> then the frag always get a page when do refill.
>
> Which could see reliable crashes or scp failure (scp a file 100M in size
> to VM).
>
> The issue is that the virtnet_rq_dma takes up 16 bytes at the beginning
> of a new frag. When the frag size is larger than PAGE_SIZE,
> everything is fine. However, if the frag is only one page and the
> total size of the buffer and virtnet_rq_dma is larger than one page, an
> overflow may occur.
>
> The commit f9dac92ba908 ("virtio_ring: enable premapped mode whatever
> use_dma_api") introduced this problem. And we reverted some commits to
> fix this in last linux version. Now we try to enable it and fix this
> bug directly.
>
> Here, when the frag size is not enough, we reduce the buffer len to fix
> this problem.
>
> Reported-by: "Si-Wei Liu" <si-wei.liu@oracle.com>
> Tested-by: Darren Kenny <darren.kenny@oracle.com>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

