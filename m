Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B033030E837
	for <virtualization@lists.linux.dev>; Fri, 20 Jun 2025 06:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750400793; cv=none; b=OAlSbsKBb5/2M+qQFN9DtBSD9lv/8/oWNs+lUchKFVU5e2neeoCROBC15rBxO4ExntSdYDiWb3IQSsMkmmMGXR9fo2CaLFaCngvgM5S3NmmIWM0unqvgEDQeL04nUuodRbSTrdd1AOntRtraCwDY/kbEfZ3pyw4GPPxlof/6mGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750400793; c=relaxed/simple;
	bh=nfv7fyyMGgpGBArq4sCElYAOSU/nRvtwEU+IIzRH2N0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LEOpf5EAlKzQObU7jb+Y0eOPSJeZ/PEuBdvowgf/f2SfZ1NnL81RkxMpmdx1+sdTQBnVYKLx2TtoKdMzPzYLhyBPbzIYnJb5PXJIj0jBpVKZVa8CU0ZKlagW1ejc+1oecJd1MMqbFyScbeMPkMCZ6JB9nAfS6fRnBPr4G/ltIxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OaL9E03r; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OaL9E03r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750400790;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YBfXFz4P2bTTX7NrGjRC7/OUsN+WdybtXffQ8S+mwq8=;
	b=OaL9E03rvsBrqackbgqdye/wbendLyd45u8Ptfhf5gAqww5no7SnlqAA1P7K+c5y6Xlgcz
	1eXWTTQLGPQSihoPS3M7RppRQqRYFBB/HepHrbYundgj78eQhP/uLKqdFvdLxYqmxbEzmk
	iaacBeF9Vfaat5g7iNeE/zuyx5hv6V4=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-D0ovTIMLPsuV6ZOZg8qYLQ-1; Fri, 20 Jun 2025 02:26:29 -0400
X-MC-Unique: D0ovTIMLPsuV6ZOZg8qYLQ-1
X-Mimecast-MFC-AGG-ID: D0ovTIMLPsuV6ZOZg8qYLQ_1750400788
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-31218e2d5b0so2433734a91.2
        for <virtualization@lists.linux.dev>; Thu, 19 Jun 2025 23:26:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750400788; x=1751005588;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YBfXFz4P2bTTX7NrGjRC7/OUsN+WdybtXffQ8S+mwq8=;
        b=L9yC++JWcVnRj7bF3VJOBeFxOtroysbapU+GnhxzZAfep1cVqiMX+PdQFjJiZGEqY6
         gTKYEXjlIh/K+Qyrzr4ZaZ3h6KXsOIqOHDNOXnk4SW+cDUrCM1fhtA9U4hzLi7K9OB49
         Ynl81Q6UlQmn8ebVkDNxrtoteRdxjN6uwUkTYapRAJXzx4VB2+EeKSzFG6+jDyPfU0O8
         dle/P4ZdNycHV9A/OQj+eSnZ+vmHPEppXlMMJ57Jm+0lNN520l/w5jgPbKhjI3NHp5EB
         pkoA9sdvsRUKyWYGUu/5o9ZLEK1Cpg5JhiOLAE+mVUwgX5g8rjeEwPqLRLu6C24M9IwZ
         aXvg==
X-Forwarded-Encrypted: i=1; AJvYcCX46XejDdjDVO7DUlLoZRvgHiEL4H0e9GSbYHQ6M0SsPXjEUrUWnhKm2EkhmDF+/iR6muzucIugPZbiWAw18g==@lists.linux.dev
X-Gm-Message-State: AOJu0YySM+hCOw+x4TyQiRrYhpHY2nuajKr7PTvLx3+1UBMCTDjPryf9
	Wy1zyTE0mkIH7dGEJbLA00PweczKjP+tI6CJ6F1mjujMDvuiwHe3vglbFfqew0Yr5P3wTTssTtJ
	zvPsgJyziA2dLtUjEHqB3dQ3siBm3igcOMP4X01JjlqmLOPee5ulnZWu+J/E6/g9mTDVU5G9SOx
	LuLvpkcIwZlhFL/05KQjDYiC14QdS8b6G4DxVRr/BYtG4=
X-Gm-Gg: ASbGncswhTUDOtp/qbgRe2k+j2DIE9bAMws4o9vnCBoIbRvVS/MOKQwtSsKtQ1KWwdg
	FwwXj6jICALm6ymqhDJv+zrX+vXe8MFV8pQYZSRKk/kgVRDy5RrxnlwNxlx36zLxPa0CXO+Mpae
	XHAw==
X-Received: by 2002:a17:90b:5685:b0:311:da03:3437 with SMTP id 98e67ed59e1d1-3159d8d8913mr2634786a91.27.1750400787915;
        Thu, 19 Jun 2025 23:26:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFrfSt05c3qwaOpwK1EXvMYLkUyiY2ouZ/WY58fueqk/Z4N/CP07OyfnNOzZ6tOetmvre0TZnYjmVeJdD3H3Ao=
X-Received: by 2002:a17:90b:5685:b0:311:da03:3437 with SMTP id
 98e67ed59e1d1-3159d8d8913mr2634757a91.27.1750400787571; Thu, 19 Jun 2025
 23:26:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250606115012.1331551-1-eperezma@redhat.com> <aEZ2SYAXdqffWoqk@infradead.org>
In-Reply-To: <aEZ2SYAXdqffWoqk@infradead.org>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 20 Jun 2025 08:25:50 +0200
X-Gm-Features: AX0GCFtY271naYjEH-Rfnmg4mrMPUjzaTJaGTs06KwU10BRf_Xo7vYV5K9mdIpc
Message-ID: <CAJaqyWek+ckdXFZdhpcXwDB7a5X=PMSktEADVpR5Nbi-n+MR0w@mail.gmail.com>
Subject: Re: [RFC 0/6] Add multiple address spaces support to VDUSE
To: Christoph Hellwig <hch@infradead.org>
Cc: jasowang@redhat.com, Yongji Xie <xieyongji@bytedance.com>, 
	Cindy Lu <lulu@redhat.com>, linux-kernel@vger.kernel.org, 
	Stefano Garzarella <sgarzare@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Maxime Coquelin <mcoqueli@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Laurent Vivier <lvivier@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: D8fhcnXaMoEpdrELpWHtcPhyCOL7DT5mkJ9H9LlR0I0_1750400788
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 9, 2025 at 7:51=E2=80=AFAM Christoph Hellwig <hch@infradead.org=
> wrote:
>
> Before you add new features to vduse, please remove the broken abuse of
> the DMA API first.  Without that no new feature work should go into
> this code.
>

Hi Christoph,

This code does not touch the DMA API at all. Actually, we could even
remove all the DMA code and these changes would work the same. Can't
we just continue with this series and remove the abuse of the DMA API
in parallel?

If you detect broken uses of the DMA API I've missed please let me
know and I'll be happy to remove or change them.

Thanks!

