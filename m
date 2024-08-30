Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BA124B28
	for <virtualization@lists.linux.dev>; Fri, 30 Aug 2024 02:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724984863; cv=none; b=GOJK2tdCqJK/D+jZozie5zOrd2/W2ueh9nN8iHt14FLT6JF3jsKKrRypbLgRqanPmBgfVk8+Bq62NMZQmmpEdN3onuajW2t4fB6lEywMi+SSBUWMIZ6qFlDt83QCk1R7vooJbI2dfoVRG8XlAHBUbdq+fpxHyKc7evahrf7zH9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724984863; c=relaxed/simple;
	bh=7aOFzquSXsxWdg9sGe6soNpradm3zUkzZgIEXOgg6N4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rz4by7sPXFm2y0XIM00Xu371o8y9+5eX1Ng67zFR1pFmxkrc5VCG+W5zoTKce/+X3e4SG2q03w6EL0ilVK+J3PulG7IpvUxC8PNYIF+kPJMf63Q1m7Fzu/BQnBEcFH7/t+f7Z6/RQfjitSnKBR5gC2aPzVh2wcgRKL8UnDP0c0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GAr7klop; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GAr7klop"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724984860;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fqa6fnY1m7BN2MuwAFexWwsKLrqxXcsUqarIMqCmGqY=;
	b=GAr7klopEJFtFsTKgez1COygRolSKZPEh/vxKzgO02yLRW/IqsHvI8VtitrSxifL0YatTk
	/8j7gkBhK+U289oiww07tTQur8vqbGUx5VI+7gepCYs4Kax+GjNa7/ThFXE7D8U6ABJExZ
	UpztAnKExFvInHXU0FzLAVJb6HeLZPQ=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-375-YaMNfMzgOlidGRBydMw9Pg-1; Thu, 29 Aug 2024 22:27:38 -0400
X-MC-Unique: YaMNfMzgOlidGRBydMw9Pg-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2d86e9da90cso191925a91.2
        for <virtualization@lists.linux.dev>; Thu, 29 Aug 2024 19:27:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724984857; x=1725589657;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fqa6fnY1m7BN2MuwAFexWwsKLrqxXcsUqarIMqCmGqY=;
        b=F3UJwQxq3f35+NvJpurboU8zruLwju2Z/DAmiUxUNCBrZe7tx6KpwTTwjPOV+D09gq
         U5nVTwDpawwFXJsyJgTGn+Lv4FMOFlAPpFwU64Hqjj8G1xFQusQeTxKf2pFR/+CmrWFB
         ib12Ul7gxJsloSrVpjR1ORL8ewo9UoXgDYis0pBwBl25lgJaHtCQ2uP/YbLU7+hPopDO
         dUf+JsXdVFJqi+tzGSOH9XtOByyPTCybV0217JtXiQAEplS1ywVSumOd06MzB0NrCn6K
         1djCcrz2ru34EXVpf+dZMAgKcLYUA4iSn8XaccCE9OZAAjPd7UVCgEYbU+fWAjURH9z/
         aZPg==
X-Forwarded-Encrypted: i=1; AJvYcCU7GX4JxriFfeOghF6SocJzROXoN3xehsHeDsfnkXxTLDIrmr6nZgurnEfO2i/1bfF8M7SI51/xzXXmUMR5lA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy9SqGGUG68wxmvbIeBUR0hPkJgQA+U1/wi3XufTVg6p5NnLh2j
	RPAyJBjR8Jir1LOiHOcTsJXZrfavPLmtaAZFpr5gMljw0lC9M/xaSAeByf3QcegQWlmAzDp8Vol
	p07DO128Nmj2ea9ThUMMPpN1H+O6hCUHuMqDc/JYOzrBhFzgW6Ztx5OxRAOGWw0GciuAWIotIuD
	b0krWOQZyM6W/zoBmgWX3c677YMe0clBzh2k+jMNQ=
X-Received: by 2002:a17:90b:1c8d:b0:2d1:bf4b:4a6d with SMTP id 98e67ed59e1d1-2d856171083mr5715598a91.1.1724984857615;
        Thu, 29 Aug 2024 19:27:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHuPvs4K6ErQNk0JQcambzJJSK9Hb/yPLY7k6nxtFvEimYY7nj16dOoSPmKxLqdHCvR6Gg7k0fB8H2rbMXASD0=
X-Received: by 2002:a17:90b:1c8d:b0:2d1:bf4b:4a6d with SMTP id
 98e67ed59e1d1-2d856171083mr5715575a91.1.1724984857029; Thu, 29 Aug 2024
 19:27:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240829143757.85844-1-sgarzare@redhat.com> <CAJSP0QW3WN2Z-x5Y8TnyA_Rq-ok9VgG1YSUzYPDCrav7Phx6Hw@mail.gmail.com>
In-Reply-To: <CAJSP0QW3WN2Z-x5Y8TnyA_Rq-ok9VgG1YSUzYPDCrav7Phx6Hw@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 30 Aug 2024 10:27:24 +0800
Message-ID: <CACGkMEvS-kVERRhYHQh5=o_6O=-1qyrzraNq+3KsJLyVZ6LPZw@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: add virtio-vsock driver in the VIRTIO CORE section
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 11:15=E2=80=AFPM Stefan Hajnoczi <stefanha@gmail.co=
m> wrote:
>
> On Thu, 29 Aug 2024 at 11:01, Stefano Garzarella <sgarzare@redhat.com> wr=
ote:
> >
> > The virtio-vsock driver is already under VM SOCKETS (AF_VSOCK),
> > managed pricipally with the net tree, and VIRTIO AND VHOST
> > VSOCK DRIVER. However, changes that only affect the virtio part
> > usually go with Michael's tree, so let's also put the driver in
> > the VIRTIO CORE section to have its maintainers in CC for changes
> > to the virtio-vsock driver.
> >
> > Cc: "Michael S. Tsirkin" <mst@redhat.com>
> > Cc: Jason Wang <jasowang@redhat.com>
> > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > ---
> >  MAINTAINERS | 1 +
> >  1 file changed, 1 insertion(+)
>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

