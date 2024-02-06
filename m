Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385D06E2A8
	for <virtualization@lists.linux.dev>; Tue,  6 Feb 2024 02:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707187711; cv=none; b=W1SAhLhXn+/eFsaelRSVDMLwpZlAs/eJpykQoZnHWxtBvcq8eA97W+6ln94bl2J79F6Dg45nhUSD+EFURTz1O7+KfP4K3cmavIvNU6NIBGBN9xk89HrNmx7unmTAo8Gxa5pIvKHt+0E/n2yvUgwDsVaWtUrGiT6zFXNdCOl0D9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707187711; c=relaxed/simple;
	bh=ztwf0puyw2TDsCRrz3TlAqmaa620OVTaNmCiF7tFow0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DY7h2qyT7xvkDMKetKBNaKvY8QM5jy9jE9GoXNQMEcx/CBMKqdAX2i8an45D07WLDEIk2M1zupmkBttF1PLUEaBK/bC1aiUQVJeOhpsuUOpHHciFhXIxbj/WK0fVh6g2AkKqgADdnNYAI1hTnYNkOW1eENfVGAm4xQGx1JyvDYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jKRQqc8b; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jKRQqc8b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707187706;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ztwf0puyw2TDsCRrz3TlAqmaa620OVTaNmCiF7tFow0=;
	b=jKRQqc8bmoUu7nzrCOkyp4ODkPKX+unhpj2d52ZsUj++5ZtjPDJeaGp2WkJWZQTI27ZA7/
	uc4GncWReK+KXi/F8v/Fnmj/6D7kArst5RYPi1VoxTQ3yrUaqUkUcAR9kCO8MJSSLGMx7w
	ocnDHiMCmt+1Q39LZKmkkAp8ziRMQx4=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-z2BOOsTGNI2xC924uSLpnw-1; Mon, 05 Feb 2024 21:48:25 -0500
X-MC-Unique: z2BOOsTGNI2xC924uSLpnw-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-6e0519304b2so917866b3a.3
        for <virtualization@lists.linux.dev>; Mon, 05 Feb 2024 18:48:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707187704; x=1707792504;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ztwf0puyw2TDsCRrz3TlAqmaa620OVTaNmCiF7tFow0=;
        b=Ty40lJVts3+gUF+TGJTG18sCWSx3oElKd1QhOQRbDVQn4weLduFaYf/BLjxoBxghcm
         aDtI5SnKvLdQ0BpHJNwVsRHf7Ed4tvahgviif835Co4LyCvr34BZGn1c/kLMBhYN7OKL
         vaWxTtCnIn0ZgmTQsqw+JKtQ2pZXGaJhiV0mTaP/llcfFbrgLCGAapZRXeRXGzyow/xS
         8xYnEbsg3I1pgkpUrvhhynI+SUeCDjg74Ys+CWdJT0aVV6oqGa6WkrELjBbF2eC3xYZd
         QzpKvFk1Sn7T86gLDQHGNWslej8tg8f8CQprspqElQTigYHbKrMk/3GWbzV03HDsBi38
         MHHA==
X-Gm-Message-State: AOJu0Yw5TOHUyn6o9E305BzwM0gXbDJN8dvsXvChs85kUZ59o6p3cYnS
	qzUE7mCq3GFKzzjCW+3U0wTaRfTo0IvIeoq+b9BedcRo3nW91wTNFJvseXaOxSb7KbsB80KzZ9v
	wpvpOXyzXfC9wN3OZx+b6lyVnUJ12m+MBFl+OiWBJ2bh8vJJ5aK1FPhOSoReg8jXn3O0DnJdJ+G
	TWXfbS9kKmQn20P7djGVVCUV047YkVGxGGDJKOmd4=
X-Received: by 2002:a05:6a00:2d99:b0:6e0:4674:78c2 with SMTP id fb25-20020a056a002d9900b006e0467478c2mr1191456pfb.13.1707187704625;
        Mon, 05 Feb 2024 18:48:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH6LEs4cSQQ7pPO6vnlICrTTJ6trV490iUuP593kPzMaV8ONfvf21ILMwECc8CTSanrUqlGbuOmZAhk8gIZeqc=
X-Received: by 2002:a05:6a00:2d99:b0:6e0:4674:78c2 with SMTP id
 fb25-20020a056a002d9900b006e0467478c2mr1191444pfb.13.1707187704363; Mon, 05
 Feb 2024 18:48:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240204-bus_cleanup-virtio-v1-1-3bcb2212aaa0@marliere.net>
In-Reply-To: <20240204-bus_cleanup-virtio-v1-1-3bcb2212aaa0@marliere.net>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 6 Feb 2024 10:48:13 +0800
Message-ID: <CACGkMEvoRN13c9Do=HsNzxMaXd0=-cLdNKuU8P_Vdj-89fwJuA@mail.gmail.com>
Subject: Re: [PATCH] virtio: make virtio_bus const
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 5, 2024 at 4:52=E2=80=AFAM Ricardo B. Marliere <ricardo@marlier=
e.net> wrote:
>
> Now that the driver core can properly handle constant struct bus_type,
> move the virtio_bus variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

