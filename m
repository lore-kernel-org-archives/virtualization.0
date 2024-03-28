Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B8C53E1F
	for <virtualization@lists.linux.dev>; Thu, 28 Mar 2024 08:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711613118; cv=none; b=IBEpOAuufvpcVtrzeJbjqufx4o0rL259WbEhVcj+Ta0cJGAtpQCnthH0y6GY1daJ445GCgCN2bMVMRy7Zyx0DLl2uVhj71l/HFNPfqJKehrJVX7i+V/v0dHJ73y2gwq/u0kzUwVQrTGQAJfy+Y+crZe6r2NB2eCuRP0Z8534n8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711613118; c=relaxed/simple;
	bh=Be0UUd5PJExJNdd3TaFGM+tMRsL4MrmrEUd8POcwdfo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NDJLGdz0ytaRauFsoEjx56hqUwK6dazqs1IGUOGvBrqjrmaayuFI/YzrSXHzHxtAslSCMxdcqrSgg/yA2j0+WQVYCufqYVcnv1b9urWLLUuvnr+0VWgF+fd484WSgClW0Cmx86LWjFtPTZ2EcAi0xeZ5mUdAveKO3RGigCQDz48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G57giJhw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G57giJhw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711613115;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Be0UUd5PJExJNdd3TaFGM+tMRsL4MrmrEUd8POcwdfo=;
	b=G57giJhwcAzFj99f+RVo+4O9Iu3LnU2kHV/12U+XIaAfhBuHTLAmBKcjP6fSTeSpgT7AJA
	6g/wLql2leBkHGigFcffejpD/ZqV7b3bsmXQSoLHKMKbiSr0p8WWCtMvz7LIhrjT+JgOZV
	Ii+5xiWLoPg/LoUyGpuARVlrn97cF3A=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-Yrn5cds9P46AzlF_qEE6mw-1; Thu, 28 Mar 2024 04:05:14 -0400
X-MC-Unique: Yrn5cds9P46AzlF_qEE6mw-1
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-6e7149bc12fso714869b3a.3
        for <virtualization@lists.linux.dev>; Thu, 28 Mar 2024 01:05:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711613113; x=1712217913;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Be0UUd5PJExJNdd3TaFGM+tMRsL4MrmrEUd8POcwdfo=;
        b=hFdXucv4YX7rCJR+zXOC+gpo17+6r3LjDD1DhyNULniePwPTpJ6TZaRSX3aoaIyri9
         JYG2V3HCWfkdCnNIBIhT5N6QkdeCN2yhKp7z3K8FBdH0IkUe4AQx52CtyWHBICvAHB+e
         w5+XCuYRzA+oLrAnZnExz5fcTy0cPdNjM2Lo9wsjOELCktkxamsLe81r1E1Wq+CVe+Ks
         fpKaZKc0QXxe1kP8M6xa+arsRmcf8bcXTAVY4U999Nk4+TcGlJIm3t1G0Pva6y6pGa1y
         lgnkKwsKgn546V+KEXD07TTihvI6NeBtILSHkZ7ZgTeyPsOzLbWjJnzEAQ6ZMMh6J270
         x2SQ==
X-Gm-Message-State: AOJu0YxQ5Ev9pS5bl8oRSBorUtWmA6O3agBflHSTYlDRuXqp4ADGcKuJ
	hMuhraNwNVwwbQjcYeL0daKJ+CVj+0ixl31/FquPEbRKV/mQm52BFCMjLml/kWpCKUrbY6aCKkE
	tFK9AWlScQMtbsrRSCj458x5kgJVy/8V+7HfPCa53z8G6dqobOpM2kS2tbROgPm2Itn5A5L9AQk
	fHhYv6oNCvnq1duOAj4fEOSbTY+44UdvGPFoKlO88=
X-Received: by 2002:a05:6a21:338f:b0:1a3:71d4:cf3 with SMTP id yy15-20020a056a21338f00b001a371d40cf3mr2662976pzb.59.1711613113300;
        Thu, 28 Mar 2024 01:05:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERrEZq1/g2j0eedaT4nU+tDdrIYn3NcnhmsxEIr3VlSxiStFU+h9PY3rVqqpDbZd11ygttWItTa2FI/UGvmcc=
X-Received: by 2002:a05:6a21:338f:b0:1a3:71d4:cf3 with SMTP id
 yy15-20020a056a21338f00b001a371d40cf3mr2662962pzb.59.1711613113069; Thu, 28
 Mar 2024 01:05:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240327111430.108787-1-xuanzhuo@linux.alibaba.com> <20240327111430.108787-10-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240327111430.108787-10-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 28 Mar 2024 16:05:02 +0800
Message-ID: <CACGkMEs=NZGkkA7ye0wY7YcPBPfbKkYq84KCRX1gS0e=bZDX-w@mail.gmail.com>
Subject: Re: [PATCH vhost v6 09/10] virtio_net: set premapped mode by find_vqs()
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2024 at 7:14=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> Now, the virtio core can set the premapped mode by find_vqs().
> If the premapped can be enabled, the dma array will not be
> allocated. So virtio-net use the api of find_vqs to enable the
> premapped.
>
> Judge the premapped mode by the vq->premapped instead of saving
> local variable.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---

I wonder what's the reason to keep a fallback when premapped is not enabled=
?

Thanks

