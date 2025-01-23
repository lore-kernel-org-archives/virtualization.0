Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558F6179A7
	for <virtualization@lists.linux.dev>; Thu, 23 Jan 2025 07:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737617553; cv=none; b=WMQGmOqj3dwYy2H4uE47UgoDtULLkvUxL+nsNw/OiaMagAZOuDQZd8CD7d7xD+id+XTWqtiRJSozPL8D697JvZYhjktOYRdL0dLRpNU5gK5PwT1zJ8Y87KpV+Mz18riFT2CEpUsMFACd//Y5gao/sqwR/+1GHPZdufThOPIcwMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737617553; c=relaxed/simple;
	bh=3AhFYwClJJLVUWVPtLzKmynsdK8yZIIqAdrxNjIAAW0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N4Rmosd8wOkUU8SVKfaX9UyOm2rYd6/7Lk9JYD5C/pofBusANgOuA8iBVVckdC+YCo/0pexEvggpZTEmVdTH/fBjYRl6CETnSfpzQ3abCuBropEfnxT21a+ZE/eeDWcgNncQTJaf+6Lxo6G9hSMAW8Sc20R8MNC1deJw9S7WCD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JIVpIsQL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JIVpIsQL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737617550;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3AhFYwClJJLVUWVPtLzKmynsdK8yZIIqAdrxNjIAAW0=;
	b=JIVpIsQLIAEfKgqvniUjsrn12ZxV7umDP2axWe1GbbzjLj7X52iLQINS3sYXxFK5vMKSUm
	lKrOvpK5dpmEhacVL7KI0tEaYfIg5FQgOKe2fAM9jWoBeOd2sef8yn1jiagajK2/S+cQ1Q
	dj+L+MX9LaZ6E8YuGLWkbR5dfJl47D8=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543-hW1bqjFmN9-vsZkouTlVrw-1; Thu, 23 Jan 2025 02:32:28 -0500
X-MC-Unique: hW1bqjFmN9-vsZkouTlVrw-1
X-Mimecast-MFC-AGG-ID: hW1bqjFmN9-vsZkouTlVrw
Received: by mail-yb1-f200.google.com with SMTP id 3f1490d57ef6-e579a939ec3so1324305276.1
        for <virtualization@lists.linux.dev>; Wed, 22 Jan 2025 23:32:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737617548; x=1738222348;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3AhFYwClJJLVUWVPtLzKmynsdK8yZIIqAdrxNjIAAW0=;
        b=MceHw5mXa231ra8Kba8u2ODonOY1bMYqeWNEuE1fAtWHy7cmUsuMM8u+poNWVSFBk5
         e4W8JsNzJbbm4emcgcc2p6qCkgPfEqTpnnXND2xc1vG89ryw2n/DKSpHaiYiWmQxSDxI
         sOhlqtj1j8XaxVGif+J/xcQj5vJZuFljiAdGIRoChc1t20O7mNrvZ8ujZUQRlpM2tsEy
         wdzr1N6AQ+2a7RQ30yS6FgLIYqakcVYkJqAs113emU372RCkh9YAgfbLscEEeJYSitQA
         Ivc75w2TB8AmDdykHiMAPmtCHG/SzSnB9SoAkyXA6gq0Yg9FDNkswFYWciM20i48GHog
         jh7g==
X-Forwarded-Encrypted: i=1; AJvYcCXb7UU02tswvjZijvaNbYEWbu/JrT70WTjGT2m4Em10kzpU/icAeBjvOyuA3RRg2OSvfvPfJmuQpYBiUJIJNg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwzZEzS/sUUjUN8v+LROZG7NNS6vayxJZGnAH+tOKgoV+dSQsUO
	mtf640RXqyupp9/2DBXtK8OlTAnAu3uAhlsBEhWqqjUtDsB8UoJUZlLBNiCx1+q2uYEvq/8LDMy
	CrX/jIp6n9fTiyAl3JLqe29mhhao4RLcEVSm6+e2ev6zqs8UfsLIeAY+L11/r3Zc2aHY13uA2FV
	aFqoNVGBx9KLvtlqUuip3r34YVtaXxfBAYQj2g+Ug=
X-Gm-Gg: ASbGncvjEdMOKiylY0PwfQ+WcfSSZo0UxIFUxDQrqf9W/d8UQCGAm7HZHYtfT2qYfuf
	DrQ9gELLjwEXQcb3gIgO9O5TOkCdEaOEn+0Qr/XNkNAvpXWdSpw==
X-Received: by 2002:a05:6902:10cb:b0:e57:37d5:e275 with SMTP id 3f1490d57ef6-e57b105434amr15929010276.18.1737617548197;
        Wed, 22 Jan 2025 23:32:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IESiZEIBZVnuv9O3d5ET7vTZeWBuZF165rAzXos0iRujimhkWpa6LSjaN7KvnvbcAYzufNx2V+a5BkeMT1KPjg=
X-Received: by 2002:a05:6902:10cb:b0:e57:37d5:e275 with SMTP id
 3f1490d57ef6-e57b105434amr15929002276.18.1737617547949; Wed, 22 Jan 2025
 23:32:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250122163154.1225353-1-eperezma@redhat.com> <20250122163154.1225353-3-eperezma@redhat.com>
 <CACGkMEt8djYRdSvwBK7QGoNV1iG-8nafOox0=pt6ix1m0NOZtA@mail.gmail.com>
In-Reply-To: <CACGkMEt8djYRdSvwBK7QGoNV1iG-8nafOox0=pt6ix1m0NOZtA@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 23 Jan 2025 08:31:52 +0100
X-Gm-Features: AbW1kvZmJZLZChXDs5ea9mvEr8Y7c6MT0ffo6AiyUv0Ek0_1dQav577Y5xxCR4w
Message-ID: <CAJaqyWfpVfm6JgSanRBKrsprpKR6Nc+YsyFmsYzoNwBb+uZW-Q@mail.gmail.com>
Subject: Re: [RFC 2/5] virtio_ring: introduce virtqueue_map/unmap_sgs()
To: Jason Wang <jasowang@redhat.com>
Cc: linux-kernel@vger.kernel.org, mst@redhat.com, 
	Hanna Reitz <hreitz@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Vivek Goyal <vgoyal@redhat.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, German Maglione <gmaglione@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 71gNCmdmOujVR6gTeYfHmxo1BjZ0rF8LJYAqHFPRoPc_1737617548
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 23, 2025 at 2:51=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Thu, Jan 23, 2025 at 12:32=E2=80=AFAM Eugenio P=C3=A9rez <eperezma@red=
hat.com> wrote:
> >
> > From: Jason Wang <jasowang@redhat.com>
> >
> > Introduce new virtqueue DMA operations which allows the drivers that
> > want to make use of the premapping API but operate at the sg level.
> >
> > Note that we still follow the assumtions if virtqueue_add() so
> > dma_map_sg() is not used. This could be optimized in the future.
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > --
> > Eugenio's changes: Remove blank
> > TODO: Should we call directly dma_map instead of this? XDP do the direc=
t
> > call.
>
> Note that we should have an indirection layer as the device is not
> necessarily DMA capable.
>

Can you expand on this? virtqueue_map_sgs calls directly to
dma_map_page for each entry in the sg. This indirection layer should
be in the device's callback for DMA, isn't it?

> And we probably need to rename the virtqueue_dma_map_XXX() to
> virtqueue_map_XXX()
>

Ok so maybe these functions are already enough without using
dma_map_sgs. I"m ok with renaming these, but that should be done in a
separate series, isn't it?

Thanks!

