Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7B5130E58
	for <virtualization@lists.linux.dev>; Tue, 24 Jun 2025 00:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750725685; cv=none; b=bo4RJnfixTb3N2YgDHtaHQ6+AaleYITWhYcdE9mvnWg+KexNvC+vZ1pK/y6XQnCJ4LuCD2lBYvyDu2+ynV0cVmuStQmf94+hl/M6+FkBonKt41UPSPr8SvWyyojJ35CIviC/rDbZBe36+Ym9plZIVhr+E8PIw+HQefBXQtJ5ZJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750725685; c=relaxed/simple;
	bh=GvGEMD4Kki46f9H9uX0qMuel22O0AXwTFQlVMCNPfGo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ghVvHls1NPpQ6jIxeb1473Ku1qv6+wuXp6QusKPJ3T/kLnZmP1H0v6Kw0HVNuvzj27jVA8D0woi+utn1kNS+biP1n+Cb1Xn+brR4LJ6N91STwirOvQqtWHaqTiFJSC0n5u7AwfKRTN5JJsFrXBqp1z2Z5gA0sJXZU2A7DrOojmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b9a0SJj7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b9a0SJj7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750725681;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xbnuXzX6Ua5JYwe0HLbF3e8hcisCc2OGbdItWwpjUDE=;
	b=b9a0SJj7PVtvbOUg/PCn3ZutknpJiyNfwBHXJ+DewYkXdF28SZjgAG9q95hkKrrsrjSJhH
	jUMu8IRNF30P+p7BJ9l2FOM5CpVeZ9/B+KArWhz52YCJap3vl0bCiyB/YC3Cwsa5HDZh7T
	/dDKqsN+TCjjaNUxojLMpJ4nXBCqs2o=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-62-xsi6kRmsM9-pSAc-jwsE2g-1; Mon, 23 Jun 2025 20:41:20 -0400
X-MC-Unique: xsi6kRmsM9-pSAc-jwsE2g-1
X-Mimecast-MFC-AGG-ID: xsi6kRmsM9-pSAc-jwsE2g_1750725680
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-311e7337f26so3995995a91.3
        for <virtualization@lists.linux.dev>; Mon, 23 Jun 2025 17:41:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750725679; x=1751330479;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xbnuXzX6Ua5JYwe0HLbF3e8hcisCc2OGbdItWwpjUDE=;
        b=OOm8Ssa1baKmb/8ueBZPx/94USHcTe/i/r/0jSwrXsZ/3byH7GSDbBDjQi989lEKaY
         BzjGwRE2P6ECkaozqEkzjoOpf1p7+HlXFQcPcjl3pSV74fqHKmCeOXxo0gA+qgh1n7p2
         ajX2r3kjSK0taS6CTT7sfS2M21/nTKO+Z4v/SmbbjkS/YE5m6lGH1YNRU2VH4RtqMMmU
         jlK0vkj1dLictM9SBIRSXot6voYUN6n/Q03kyvzeTn+oGT0XvyF24/gPrAc+Tn7r/s6o
         lYK8sf3XR9rxhUVvMMHUbmy51crlUtTbI1OQ78qO1sVsSsnDxfAYbpvOqR1T1riw/aBb
         IxWw==
X-Forwarded-Encrypted: i=1; AJvYcCV9jcBe6ilgJWxX0uRXTApvUOy/VNUrzlBUfZ360CeB7FGH0YgBctXmlBDrQ5l5SOj4PxIUBF6mcpJJ7tZVPA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwHi1U9oI/fDiA+ZoA6cRAsroajmVgFUA19osg/7FyTuFTsrwib
	E9eApBM1TgJMlvOv95KMZhQmE5IE12eCPFA6m3ZgQAaxjeWaNFhLdEaNHk0b5Z75UCnzmqTjW4J
	SfS9n1wsZXC4idGzm9Ma9MRyBaCSw/NcN/pDu2sSq69SSql3OHNzDYtFb1gU4LdYbvycvCDUISx
	6g5koLhzzswoQpIP4iqibWyfTEE6tKD3UvPc1mRWfTtCM=
X-Gm-Gg: ASbGncuGXndD1diT1advdLAGveqXVNyNAgKTn0FRNEnEQKLv2YI8zTqWRqljVxM9kQC
	eX6iNL3OKW4TklMUobCHc9QloHBO+w2pfxdsvHYAnZp5VKI8tx+QAYQXucbeuI6qDYqMcs6b+h2
	Vww0lR
X-Received: by 2002:a17:90b:1b11:b0:313:f775:d381 with SMTP id 98e67ed59e1d1-3159d8c6018mr24356837a91.18.1750725679505;
        Mon, 23 Jun 2025 17:41:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6dEmVr9JtJH1QXjsGmq2JCy5G9t+XM+PlD3FqtiyHroh5fjeISWvwEljOQeseXbYcTgWgJVagbODZoUulpeM=
X-Received: by 2002:a17:90b:1b11:b0:313:f775:d381 with SMTP id
 98e67ed59e1d1-3159d8c6018mr24356808a91.18.1750725679038; Mon, 23 Jun 2025
 17:41:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <241C7118259DA110+20250623065210.270237-1-wangyuli@uniontech.com>
In-Reply-To: <241C7118259DA110+20250623065210.270237-1-wangyuli@uniontech.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 24 Jun 2025 08:41:06 +0800
X-Gm-Features: AX0GCFvlNF7ePY8RpTN4tJmMih3I4v5pSV8-lai00J0trBY4VR8RP0Arg9mHNag
Message-ID: <CACGkMEvwV3em-7kca9JnTmWCgtWJUrVdOXU9om8Mjcfa9pic=w@mail.gmail.com>
Subject: Re: [PATCH] virtio: virtio_dma_buf: fix missing parameter documentation
To: WangYuli <wangyuli@uniontech.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	zhanjun@uniontech.com, niecheng1@uniontech.com, guanwentao@uniontech.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: r87qDxITg8mbHexpnqoksgewraQf3hyVK2Vgtlr8Qcs_1750725680
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 23, 2025 at 2:55=E2=80=AFPM WangYuli <wangyuli@uniontech.com> w=
rote:
>
> Add missing parameter documentation for virtio_dma_buf_attach()
> function to fix kernel-doc warnings:
>
> Warning: drivers/virtio/virtio_dma_buf.c:41 function parameter 'dma_buf' =
not described in 'virtio_dma_buf_attach'
> Warning: drivers/virtio/virtio_dma_buf.c:41 function parameter 'attach' n=
ot described in 'virtio_dma_buf_attach'
>
> The function documentation was missing descriptions for both the
> 'dma_buf' and 'attach' parameters. Add proper parameter documentation
> following kernel-doc format.
>
> Signed-off-by: WangYuli <wangyuli@uniontech.com>
> ---
>  drivers/virtio/virtio_dma_buf.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/virtio/virtio_dma_buf.c b/drivers/virtio/virtio_dma_=
buf.c
> index 3fe1d03b0645..95c10632f84a 100644
> --- a/drivers/virtio/virtio_dma_buf.c
> +++ b/drivers/virtio/virtio_dma_buf.c
> @@ -36,6 +36,8 @@ EXPORT_SYMBOL(virtio_dma_buf_export);
>
>  /**
>   * virtio_dma_buf_attach - mandatory attach callback for virtio dma-bufs
> + * @dma_buf: [in] buffer to attach
> + * @attach: [in] attachment structure
>   */
>  int virtio_dma_buf_attach(struct dma_buf *dma_buf,
>                           struct dma_buf_attachment *attach)
> --
> 2.50.0
>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

