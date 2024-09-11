Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D74313D539
	for <virtualization@lists.linux.dev>; Wed, 11 Sep 2024 08:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726041765; cv=none; b=HUGd8exAElPZBpixT3EHkGteocmMiYhYayKMm973fTUyNLpY2fZg2o3jqlKfLQM+OfkzRmE6CI7JBk2x75t5BpnsAQCk196YcQaHwRdBl65CbdFje+7mAvHD1tnT3CIMsuGNrWzFtA7ciX7HFR1U9uQ2ANintmEE2ytknV4iX7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726041765; c=relaxed/simple;
	bh=SBqvxjgwuKxYi5tRyD56jhxnOgIIsD/rrS+45v5OEvk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kyApEzQK6sHLYfKv8RzmRj6XG3CORzS/yyh29xl1BMoDJkwxaZ4A7CSN1SitlRMO5gAgvrRo7G6puLDr0R5hOnSh99MxJ33d4+NpqgskhqhOCK6YrzhzoRhWsBIUZ6GjXGDw6QlnZM3AOFKnwfexXbtMapXDa23nUSXFINTJkB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B2QSaCYX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B2QSaCYX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726041762;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gMv5A1puR1PVSNKI7BtOx9/tBwsThWDT9tdVtzSjjWI=;
	b=B2QSaCYXHavkaGNlns/pXSpCs5/g4Q/U6Mf4Rr6a1k8sTcbBk6dvN0LwzUpb+CgmqWfPj9
	B/TCGyvCXzjia7t9CLOr278dD+0ulSXpUxd7XM7bkkYKA0yOgpG42V/9BVCi0zjN/FsTsU
	PyklhCzPDMMRUrl53SL0jBe8PEir9vk=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-4qnWMjLQOeuPSVOnXKxdng-1; Wed, 11 Sep 2024 04:02:39 -0400
X-MC-Unique: 4qnWMjLQOeuPSVOnXKxdng-1
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-6b41e02c255so209503647b3.3
        for <virtualization@lists.linux.dev>; Wed, 11 Sep 2024 01:02:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726041758; x=1726646558;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gMv5A1puR1PVSNKI7BtOx9/tBwsThWDT9tdVtzSjjWI=;
        b=rv69JvTzi05xdYxT+6GA16OK7EHIuYrDQS+Yxe5mjVsOnkvHYHyqnBWUagsHlYzesN
         ac9h76mubukrHF2tSRh/iwh6FgjtEH2oN1kYRoBIbMNxoGroeIgcN82JQYFWtIL3U8Lq
         Lmpj+1l3Kl8d+O+xfghXAg6+bONzFWgqKWAaoyCK73yZvOKl4uNYk7p/84oTTVwwGrkf
         OUjMQu8BDPBfqMlt/2FcJuYm1TQBkjk8AsSx+lOtDTyCvketX2Xq2j82DoGoQ8HPnaYu
         tuVgEe6BaZy37f2X/blr/AhHu/4doJfHWdKZ1z1Sy/Zf5CZnPsnAJw9gzux5VLrvRO+S
         7c3A==
X-Forwarded-Encrypted: i=1; AJvYcCXW/q7aTprFnDtrRYdA/0Gf6fmZqE57IHFCWPQzNPU+0xS49FNvboXsbcPHpUxJn0wzLQubRYHvByZNzGPLMA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw5CNzg+WTyskA/G8pzqnN3qih77IMel+w6N0SSSdfdqhjm1565
	5ZG6grDNd75RbVQj+CdDy+I0d6eYz1Rk7s2fpaAc2Y+PBbdIpyeAxbNubBqKYbodJsZ4Gfex6Up
	PEL7/oTAlER2aXKYvRHtSX5DAqeJ6oo5snfVnpBMuxMLI/2WvrP/peXQKWswsjSRG9WiOiqbDm/
	IL4DHPIDhyoED/hW1m/qBx5E2v3HHPgklpuRHAnUE=
X-Received: by 2002:a05:690c:4801:b0:6be:523:af4d with SMTP id 00721157ae682-6db44da271bmr185115177b3.11.1726041758673;
        Wed, 11 Sep 2024 01:02:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJeejzNHOmqV77bv+PMzikwQtB8ZyHDG4/ZhkqhGXqCY1isJM+xkRb3k3F3/Fagm+Jpye9YalAIDnoFocfBjw=
X-Received: by 2002:a05:690c:4801:b0:6be:523:af4d with SMTP id
 00721157ae682-6db44da271bmr185115007b3.11.1726041758352; Wed, 11 Sep 2024
 01:02:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240830105838.2666587-2-dtatulea@nvidia.com> <fb6b1d3d-c200-479a-941e-1b994757b049@nvidia.com>
In-Reply-To: <fb6b1d3d-c200-479a-941e-1b994757b049@nvidia.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 11 Sep 2024 10:02:02 +0200
Message-ID: <CAJaqyWfVfOe7X-2Ku3VhuzPMdF6TGM63D5squ6Naw=6iUQdgDg@mail.gmail.com>
Subject: Re: [PATCH vhost v2 0/7] vdpa/mlx5: Optimze MKEY operations
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Si-Wei Liu <si-wei.liu@oracle.com>, virtualization@lists.linux.dev, 
	Gal Pressman <gal@nvidia.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Parav Pandit <parav@nvidia.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 9, 2024 at 11:30=E2=80=AFAM Dragos Tatulea <dtatulea@nvidia.com=
> wrote:
>
>
>
> On 30.08.24 12:58, Dragos Tatulea wrote:
> > This series improves the time of .set_map() operations by parallelizing
> > the MKEY creation and deletion for direct MKEYs. Looking at the top
> > level MKEY creation/deletion functions, the following improvement can b=
e
> > seen:
> >
> > |-------------------+-------------|
> > | operation         | improvement |
> > |-------------------+-------------|
> > | create_user_mr()  | 3-5x        |
> > | destroy_user_mr() | 8x          |
> > |-------------------+-------------|
> >
> > The last part of the series introduces lazy MKEY deletion which
> > postpones the MKEY deletion to a later point in a workqueue.
> >
> > As this series and the previous ones were targeting live migration,
> > we can also observe improvements on this front:
> >
> > |-------------------+------------------+------------------|
> > | Stage             | Downtime #1 (ms) | Downtime #2 (ms) |
> > |-------------------+------------------+------------------|
> > | Baseline          | 3140             | 3630             |
> > | Parallel MKEY ops | 1200             | 2000             |
> > | Deferred deletion | 1014             | 1253             |
> > |-------------------+------------------+------------------|
> >
> > Test configuration: 256 GB VM, 32 CPUs x 2 threads per core, 4 x mlx5
> > vDPA devices x 32 VQs (16 VQPs)
> >
> > This series must be applied on top of the parallel VQ suspend/resume
> > series [0].
> >
> > [0] https://lore.kernel.org/all/20240816090159.1967650-1-dtatulea@nvidi=
a.com/
> >
> > ---
> > v2:
> > - Swapped flex array usage for plain zero length array in first patch.
> > - Updated code to use Scope-Based Cleanup Helpers where appropriate
> >   (only second patch).
> > - Added macro define for MTT alignment in first patch.
> > - Improved commit messages/comments based on review comments.
> > - Removed extra newlines.
> Gentle ping for the remaining patches in v2.
>

Same here, this series is already in MST's branch:
https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git/commit/?h=3Dv=
host&id=3Dd424b079e243128383e88bee79f143ff30b4ec62

