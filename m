Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1F713C3C1
	for <virtualization@lists.linux.dev>; Fri, 10 May 2024 04:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715315167; cv=none; b=uNubF+kXmAhSFLi1wCDccQTz9ROYLAz6kZ3npcK8Sm86vb/5R4bP9m2RBzJGl0TPvhq1EbLx6NhnwWH91WTF5D/7hbe91VxT2CnTlPobMVDUcg4Q0vCDAY+rR6h5S55hYsvY3gbN6tWuWTWf3xWIbOehp+dxKYhjSSeQSNjQLgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715315167; c=relaxed/simple;
	bh=kEqqwukL9Q24UARv+N+sHgZpoaoS+D0fOox2cDR5hFM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BkM38yHPUztOw5gdLw5gjjLLhQTN8Pi0YVB8j1Xibd2w6WMWgdG6LFyIsKL+wtvlRjrvdVnm9eAEwPpyNjZhewzQsCik6N1kPYRSsS52czihlN0tkB5Uw4CTqFviagwLr6u7UaTbrwTek4Bu6n9MTZmYXH06vl26q8Puk0/ieiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XAWr7xeV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XAWr7xeV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715315164;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kEqqwukL9Q24UARv+N+sHgZpoaoS+D0fOox2cDR5hFM=;
	b=XAWr7xeVkNeQ6dxo7G0zv2F67ACvkd854Az89zehNxIOA2gdnjrvl/7+TeftcJeswWhk4Z
	RFO7nxFkmJeGFT1wCUG0NUJd9eqozCHln/B/Sm6UF8qRoY7N4VVbMXEWnW+wkbbKQYffJi
	wk69diDawK/91GhSBhirFGb+tHwbhZI=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-259-k87mHDOdPseONM89pNwRrw-1; Fri, 10 May 2024 00:26:03 -0400
X-MC-Unique: k87mHDOdPseONM89pNwRrw-1
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-47f449f0217so506663137.2
        for <virtualization@lists.linux.dev>; Thu, 09 May 2024 21:26:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715315162; x=1715919962;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kEqqwukL9Q24UARv+N+sHgZpoaoS+D0fOox2cDR5hFM=;
        b=aYshHXjNsCnQXG02drMOjHAxWbqz3Jazsy5R7bHUwbIDgxBe3mEaSmF2ubdWBAcw/N
         FpqlUcrVy8Q+V2wumVmN7KOXpPUPb601ladLxu9/xDneYajhdww6qxGWU6HRJL9/vR1r
         HN2djCl6yWw70uIrCP/VcbtkAqPY8MrHFqzKd1rzlgK7LrQ2RCuvuzj3H+aI3pYsrSft
         xVuY8uB4pkbAh0X3Caq9BJsaIkLDyKCnNlQRtLHoPY7rC5LRBgMtvrT5e9JI9MTpZzZq
         dJG0j1UMo/qULKQUkn7+xzhpKHBwZ40vJWY+ljCFjmXkU/mFVoyUjAgLc7Dy4MNGaL72
         LNlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHxpSqIHl6zfJGdZdJbTgnke/G66J8P03T+qnozfk3UgeP4YZ9Jl2USBEQZmfsd7OFNqJc7eLb7rstTXSEaUgquqqPYV2W2cfBZR89mWU=
X-Gm-Message-State: AOJu0Yw9T0NNAmD2lOkmvFM2ONCZEOrOznG4ovBKU+8tQSSm8znBbgNr
	gLMIPnrAxOH+EpTtl3VefJ/+qUwov/dPHsI2a61HCpg4IHW3wEoFbrhPxA/ahkZ3RgtpOGig163
	+Ar83QsgPcrt2176dEgZnOiyYJJTiAze47kQ9cKR08smzedIprz+ketDC6rf+UwbixXDgMQAR2O
	e52KGDYtgEUzxca34p4L6jCZMz8SSpwcFz73U1GNkpWSEDTk8=
X-Received: by 2002:a05:6102:3f48:b0:47a:40f0:d343 with SMTP id ada2fe7eead31-48077e5a533mr1780939137.32.1715315159947;
        Thu, 09 May 2024 21:25:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFEEEOdJZQ7i1dfa9row+zOLZLNzLwHZdkwYF+AIhApxX6Yn+s1XdqbC0eBGXhy/7vVcS1maFJSENv3OZfq9II=
X-Received: by 2002:a05:6102:3f48:b0:47a:40f0:d343 with SMTP id
 ada2fe7eead31-48077e5a533mr1780922137.32.1715315159615; Thu, 09 May 2024
 21:25:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240509114615.317450-1-jiri@resnulli.us> <20240509084050-mutt-send-email-mst@kernel.org>
 <ZjzQTFq5lJIoeSqM@nanopsycho.orion> <20240509102643-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240509102643-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 10 May 2024 12:25:45 +0800
Message-ID: <CACGkMEuniiViXuYZK9fvqGbeiayX8L2cYHBw66=qZtz2h=8VsA@mail.gmail.com>
Subject: Re: [patch net-next] virtio_net: add support for Byte Queue Limits
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 9, 2024 at 10:28=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Thu, May 09, 2024 at 03:31:56PM +0200, Jiri Pirko wrote:
> > Thu, May 09, 2024 at 02:41:39PM CEST, mst@redhat.com wrote:
> > >On Thu, May 09, 2024 at 01:46:15PM +0200, Jiri Pirko wrote:
> > >> From: Jiri Pirko <jiri@nvidia.com>
> > >>
> > >> Add support for Byte Queue Limits (BQL).
> > >>
> > >> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> > >
> > >Can we get more detail on the benefits you observe etc?
> > >Thanks!
> >
> > More info about the BQL in general is here:
> > https://lwn.net/Articles/469652/
>
> I know about BQL in general. We discussed BQL for virtio in the past
> mostly I got the feedback from net core maintainers that it likely won't
> benefit virtio.
>
> So I'm asking, what kind of benefit do you observe?

Yes, benmark is more than welcomed.

Thanks

>
> --
> MST
>

