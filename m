Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88C7207A38
	for <virtualization@lists.linux.dev>; Mon,  5 Jan 2026 09:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767606725; cv=none; b=sj8iFUnDtUjEGdmFdr9cH7g3UPn9FPWJQunhdm797Lg5cPxaD0uKJHPwXvAFcHhMtVIUWcm3YCpvUltMvn+eO8cKjJ2rNySmVwSxRpMpwTbSNT7KmFwRwEHhzK0wZttNALdaPa7DfiCV6YoTFJMLP+AVjaEdX0joPkuPU9LkOZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767606725; c=relaxed/simple;
	bh=5ejwvdViHGpZahmzeANBNrpoCx269JspGOeia0IssR8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fqe3G4rlfwOWccAJn/nSEP1A7opR67hTbV9q9nLiIbV1neMFVQAjh8cXN7mEsQiXSLaQap+h0kQKdLKsSzw8YLqBSo5CJmj/IvARtSK1czUcq66rf1FzvmFFy+AUUV+4mUFjtDX5OqtRohaSs5wMwdVGx1Z10uGNmcb5qoPwwY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=aV+pbrxL; arc=none smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="aV+pbrxL"
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-42fbb061a08so815127f8f.2
        for <virtualization@lists.linux.dev>; Mon, 05 Jan 2026 01:52:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1767606721; x=1768211521; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=txMxKLJCIQFzStXgaX6zCY9uCsyn60vWSct+HXcfqZM=;
        b=aV+pbrxLsU59nomiUoyHoMhTzgrzQcb4kYd4Ns0BW40XPkU+maHVDcUkxv43DfZQUt
         SGD4SjU6ieEnpW3QEKvmKgH/5b4mcvV0DtqzIFw5AVBZh1MsL0VZXIZcO7ofeexiwYoc
         ZAcdWngFFHTclnSVB048z68z1Axl0NsiXG0emFd0VFSg408K6X2rfcTKoUM1NHFdW003
         dXRUA74v9Slkcjd49LZtZRxKGtBVaJzNvWxIct8y5h4++fO19q8+WmWz57Fny792Yrw/
         R4ByhgWg5cyvbrqW5+m61OAQmFb2TIkgC1S3vpQG+yJT1XQMNEZOirSvag2Ngltp04Ey
         aijQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767606721; x=1768211521;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=txMxKLJCIQFzStXgaX6zCY9uCsyn60vWSct+HXcfqZM=;
        b=d56VldqHsc39+IsTdqM+1mby3nxCCj5HW37P5I8PGItMy0ENz4nik2PEFoWGwWp7hA
         O+i8m6wydoSRuozEsDjQy1FPl+movJkcBJyNxFKVIbhphFNq5X+6MGYDCc7OKKItU77d
         49f+JGC8GCzDuThZnzI3BTdDcyl5CgohKfwEiOJGXBrip166yqJiutL/roP0leFbgnNa
         b3VLiveICwPSRK6nakjLQZXLLEkg1Gcu6j+vCv/mqOk4g8HlMHKDxP/ujXh9qJU/JFau
         jUGtj3FIqSfbZV5FPEqWqL6E5jCc8RMVspNmT4Gc5pT1lgLyDkEXNM+UAQsJnhNXsQeG
         d7uw==
X-Forwarded-Encrypted: i=1; AJvYcCWn9ISZE35YgAqLEFuInbl0hX4qW6BVqpbmhPN1x7PPpWGTEqoXYhhyoIhXkHRsOTRDQPkrNQfmyVecSWA/Jg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwvWjvW615y7mbl/Vz+Oo1Pv5vinCGwER0xLfb1PZO+of2oFviT
	1NlPAp5UV9Td8ODBbyKPjSRJjIaJmCh0NbjMCo8VOJm2013zq/EoGnw7pCZ+zMLyxWY=
X-Gm-Gg: AY/fxX4kkcxXvc+RHxCkKVdaCzvFy9h/UeKAE+B1uyRhA9S0yOYxysKcZl06i5Bh7gx
	MbdSsuWWcumpsts/DQPYe0Yhhn3Q2dslGFsnkxxV7UZVzgfOgb96eZpkJYwYwS54ZC5NnYs9APb
	yVprCcH47S9WgP7kXl3jzASIU+0ZksJdrRJa/83E7EA5wf6eXDlmT+1Ilajs/lVWOHemFdGvrK3
	NiyIwrNSiH+TAsqlEZoR/VkiPYVEQ7ojW8kaGRXkkr+lLGCcR1hwnRMjtOwNuvxKJgA4VE/wGuI
	KA9RDjVs4jwDcwrKjWoEDF/tZAkM9wjiD/lyikLa8qvHFU0fbk2N1Jq4V02xdcoguWXDQJ/iz4H
	Gl/pU/W9mWNgkb5TtCmVJiHSvS4gtpG/Bmj/L81rCCww04+lB1+G4n3RZK8+j7B/G5UqJenB9OS
	dejMzYY08tk3RD4Vq/L64G5F1wuBBDdZZ4vl0fub5TT1BO4qp8BLZ2dioKrrIWO/5e/MLCuJS3c
	Ast
X-Google-Smtp-Source: AGHT+IG/wqgOkqwXrB1rsCOv37yZ5+KfBZKuhJz5pDuTeJ4oXS1iaQsQoWFexgrkxGoC7pycuuDd5g==
X-Received: by 2002:a05:6000:2305:b0:429:cf2b:cb0a with SMTP id ffacd0b85a97d-4324e4bf220mr35541794f8f.2.1767606721058;
        Mon, 05 Jan 2026 01:52:01 -0800 (PST)
Received: from mordecai (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4327778e27bsm66263511f8f.12.2026.01.05.01.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 01:52:00 -0800 (PST)
Date: Mon, 5 Jan 2026 10:51:58 +0100
From: Petr Tesarik <ptesarik@suse.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Cong Wang <xiyou.wangcong@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>, Olivia Mackall <olivia@selenic.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, Jason Wang <jasowang@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Eugenio =?UTF-8?B?UMOpcmV6?= <eperezma@redhat.com>, "James E.J. Bottomley"
 <James.Bottomley@hansenpartnership.com>, "Martin K. Petersen"
 <martin.petersen@oracle.com>, Gerd Hoffmann <kraxel@redhat.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>, Stefano Garzarella
 <sgarzare@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Leon Romanovsky
 <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, Bartosz Golaszewski
 <brgl@kernel.org>, linux-doc@vger.kernel.org, linux-crypto@vger.kernel.org,
 virtualization@lists.linux.dev, linux-scsi@vger.kernel.org,
 iommu@lists.linux.dev, kvm@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2 04/15] docs: dma-api: document
 DMA_ATTR_CPU_CACHE_CLEAN
Message-ID: <20260105105158.248b4dd2@mordecai>
In-Reply-To: <0720b4be31c1b7a38edca67fd0c97983d2a56936.1767601130.git.mst@redhat.com>
References: <cover.1767601130.git.mst@redhat.com>
	<0720b4be31c1b7a38edca67fd0c97983d2a56936.1767601130.git.mst@redhat.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 5 Jan 2026 03:23:05 -0500
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> Document DMA_ATTR_CPU_CACHE_CLEAN as implemented in the
> previous patch.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

LGTM. I'm not formally a reviewer, but FWIW:

Reviewed-by: Petr Tesarik <ptesarik@suse.com>

> ---
>  Documentation/core-api/dma-attributes.rst | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/Documentation/core-api/dma-attributes.rst b/Documentation/core-api/dma-attributes.rst
> index 0bdc2be65e57..1d7bfad73b1c 100644
> --- a/Documentation/core-api/dma-attributes.rst
> +++ b/Documentation/core-api/dma-attributes.rst
> @@ -148,3 +148,12 @@ DMA_ATTR_MMIO is appropriate.
>  For architectures that require cache flushing for DMA coherence
>  DMA_ATTR_MMIO will not perform any cache flushing. The address
>  provided must never be mapped cacheable into the CPU.
> +
> +DMA_ATTR_CPU_CACHE_CLEAN
> +------------------------
> +
> +This attribute indicates the CPU will not dirty any cacheline overlapping this
> +DMA_FROM_DEVICE/DMA_BIDIRECTIONAL buffer while it is mapped. This allows
> +multiple small buffers to safely share a cacheline without risk of data
> +corruption, suppressing DMA debug warnings about overlapping mappings.
> +All mappings sharing a cacheline should have this attribute.

