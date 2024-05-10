Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E1D172BC7
	for <virtualization@lists.linux.dev>; Fri, 10 May 2024 11:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715339965; cv=none; b=ehXb+imSzDUd+bcRrNNq2iP6+xat/J9oqz7sDXM7XM5HK4Gs36JjQcKbiYfBxXL91Y2124jDLazONGTQc1kchd38eEliQte4Zg8F6AfKX8mtgSzne2sUaqNnt8awvN+R58sUNHUH4e06utBtRvW5se7YZvMbf6EucXEgJghet+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715339965; c=relaxed/simple;
	bh=Zy8QCTGPTpb3aG4PVo2SX/wAY2HiJVOT9XtEi8yTZs8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DkDhcguxZSvwBtHhBG6lFMfOPpcqVnrkXUpqwFY5sPjVihJfpcgTQGSjFGrraqmtuKu01GI7Uj3ZEbtqhbDiUY8rzGezlBHJ6PuiFaK/TjVuFFR4Scv2bM9rQYO/5eoWV0604ph/0hGI7rZALWse70SjhSxFtwCvHff8tOm7qLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=a74C2q8g; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="a74C2q8g"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a59a9d66a51so437290966b.2
        for <virtualization@lists.linux.dev>; Fri, 10 May 2024 04:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1715339962; x=1715944762; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Zy8QCTGPTpb3aG4PVo2SX/wAY2HiJVOT9XtEi8yTZs8=;
        b=a74C2q8gxg5CI1JQcsKareCB01dbhBtBvwyzc5SZ2MoN3foQrNXlgUHI0rEVMaiNVY
         /uK8iZGlbHSizeo4xIWLQHgfvUVG6Dy7DuIm07xPjJo8PzfPcfemQ3X2VUFmcYPWsla9
         h6zmWHFFO8IabaC3vaF09IZ4T5I+5akotuqNE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715339962; x=1715944762;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zy8QCTGPTpb3aG4PVo2SX/wAY2HiJVOT9XtEi8yTZs8=;
        b=w3pd81mS440GeO+qmhZD/6oUTS+bYN84JkYnNy80Oxj5VMY3uKIPFU9GwLd57oqpkC
         LiTKPDceRr4uQqcJbCedbMB9Wpu/gd1qLTDF6tY63o1UuBOx1Zjn1iLIriBa4PYLmjLK
         0kAUZ49clB8oYAdGw8TJ+H5b1P13ayRIoDUW9hjdxKfv37jdkjEqcujN+smJK9xXOk17
         azyuWa9YlFzoZMEL3RQt0qYCgfeTXln4pyDq5GwDdwyVtlTqIH4tqRulVKiJSWPIgtfS
         tK8X09ym47ZXf7JypEk+9VS0Ns5Cq+H2Yzyl9W3GynOWVI8gOCdC66SrQF6MJLcJnILM
         FA8A==
X-Forwarded-Encrypted: i=1; AJvYcCUlgctSiLlv19gFZ8Rgw1/VbJ+gcQpm30XBSPtC8lO1ntYO0VAOA9I5c5XXdAQTOfMyjLSa+UKkj79y2bWDpArXV/LV11TyAOEdWJM0RLs=
X-Gm-Message-State: AOJu0YyTs+izqQCKKkCYgZun+4OYiOno4lWnuRwvU0EkMLQp9+J1v1lb
	OxixDKkKcVSun5ihe86Iy3kBLnM7aJrvDmxxcbfzOsLcrzlYVXaU5cnb8beA5pA7JufNY3Gd0Bi
	iy10ib5GlgN6vTT2czYSPvMir+2/GKTGIz1foTw==
X-Google-Smtp-Source: AGHT+IGKsBIPJJ9WHMUW2Ol0JPt0EF7hmOG42JnEwNCGtO8DczTfZu1nx6w0sFbvbgFYUwaCCDAhH+FVcSNI+grzrFk=
X-Received: by 2002:a17:906:f592:b0:a5a:1562:518d with SMTP id
 a640c23a62f3a-a5a2d53b998mr199022566b.14.1715339961830; Fri, 10 May 2024
 04:19:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240426143903.1305919-1-houtao@huaweicloud.com> <20240426143903.1305919-3-houtao@huaweicloud.com>
In-Reply-To: <20240426143903.1305919-3-houtao@huaweicloud.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 10 May 2024 13:19:10 +0200
Message-ID: <CAJfpegv5GCiF6PDguR7FyCJ_9osytFuy1UDtJnqwu6WDUCU+jg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] virtiofs: use GFP_NOFS when enqueuing request
 through kworker
To: Hou Tao <houtao@huaweicloud.com>
Cc: linux-fsdevel@vger.kernel.org, Vivek Goyal <vgoyal@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Bernd Schubert <bernd.schubert@fastmail.fm>, 
	"Michael S . Tsirkin" <mst@redhat.com>, Matthew Wilcox <willy@infradead.org>, 
	Benjamin Coddington <bcodding@redhat.com>, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux.dev, houtao1@huawei.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 26 Apr 2024 at 16:38, Hou Tao <houtao@huaweicloud.com> wrote:
>
> From: Hou Tao <houtao1@huawei.com>
>
> When invoking virtio_fs_enqueue_req() through kworker, both the
> allocation of the sg array and the bounce buffer still use GFP_ATOMIC.
> Considering the size of the sg array may be greater than PAGE_SIZE, use
> GFP_NOFS instead of GFP_ATOMIC to lower the possibility of memory
> allocation failure and to avoid unnecessarily depleting the atomic
> reserves. GFP_NOFS is not passed to virtio_fs_enqueue_req() directly,
> GFP_KERNEL and memalloc_nofs_{save|restore} helpers are used instead.

Makes sense.

However, I don't understand why the GFP_NOFS behavior is optional. It
should work when queuing the request for the first time as well, no?

Thanks,
Miklos
