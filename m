Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8051571EB3
	for <virtualization@lists.linux.dev>; Wed, 28 Feb 2024 19:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709147990; cv=none; b=ujlsfVKPV/pidjXjzSxeGKc0kx7d8fPJRCSF6V23wshTFbZXjg4LbruKUZa5ppq8iXEle566gT9GqcNJSadiavTFCaImVack48gsgyl+Kr3ltby5+Pb8NauHBj6MMqpiNHJiJ25Tc6Ydm4SYunFTEFBCRhscfQEB9HPmcnAy7fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709147990; c=relaxed/simple;
	bh=Tt6dSM09C60ngZskWhxqghZ9GcZWzW94KOavNzMs1RM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hH42VBgHhTRu0MXzMiBot9zXpVBLRy5CgxVRvMisxI7lxlzoh9cKNvBXtOEW4GL6wpRs4tu1pcs8hlcKlqSj1dyalLNfG+2zmbgSpL2rA5c5VGqMrAYJHSh9Hb3fX2nWFseonetgBmuIyRDB6We5UdJj9Hbm47fqAfkc3HNaNL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OkQ4MwoN; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OkQ4MwoN"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-59fdcf8ebbcso50525eaf.3
        for <virtualization@lists.linux.dev>; Wed, 28 Feb 2024 11:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709147988; x=1709752788; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=phvTuz6PNOiEIMAaVEz5O2kseqWR4cE3nLmyIyGPTqU=;
        b=OkQ4MwoNwBmaxr4nlp7tj1iJwuxmV+kAmbkzvBuHgs2E0blR9G0YASDNvQobkznkDv
         oiSHdFKMw9PavXTEZUc5iZqox+sX59n/1ZvhZlJoA37K2iRmi4FdyIBRIQIeyBYj9PnU
         tijk7epWUT2+K/VnKE3xAKfuAi35dQe8wJLb9bVhAE1jQcOwwM+aLlmi3WQPWJs+01s9
         +JB6I17wYZ9gviLXs6f4Cn0LiUnvTjpPRD//QhIIU2MWAq7l+v5kdpuVdADXNK+GIZ2E
         iS6YcjL5deuV8CziPgNgIm+wSJzcIRWWq+NTugKklAR+r/Mi0H7/ors9tXbaYF6M+5Eb
         i87Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709147988; x=1709752788;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=phvTuz6PNOiEIMAaVEz5O2kseqWR4cE3nLmyIyGPTqU=;
        b=ZBg6XI731TAnypQ57g9JDWEZ6zTC/9YPa+Bp1EAFkW5RcHK/kzd0aSr38PeuqVckzq
         XxZHL+13MqcPH7i5a1Qb8SwAkLJDUDcTQv5n5HUmJwiyTzRqlKqHQZaafq3wnPO3z+tj
         tv8IazZXbJ1t/0TLsxTTw8yo5+U1gGKIFYm3ymSw9VXM3fNBMQ4jMX9cX/I3kyHFEZSp
         ucfGf13ioFF31aXfDCMcpyeVecWPzC/PsiMmcyqvXLLnXfMiU5hsT1eueXzeuB6yy4C8
         lsF/uA3Y1ngfNW78sB9z++vxCNulZJHZwxvnf6eCWoUPGFg0LLJXLn6Nd51aa/MLkhLd
         2R/A==
X-Forwarded-Encrypted: i=1; AJvYcCViIySnfNwdGbxUVayNnY7Xybm8cnjoxRci5uGxA2zQ7/koomB2szfbcnQZ8i+I5J6JifWkVO9CLPN+Abu6aFYR+EyDioTQcVU4lQ2HgaU=
X-Gm-Message-State: AOJu0YyiS/UP2x9cRhkr2kFia9DVsZTWLgYMa4+AnDFum22+00R8wu4E
	qzPkpG+idfoCZeLL+9MmpjbOBHuEcf1D0171vGXH01AOJwCO6YiuVsrIdZ7Q2+f3CG9lOiphJgH
	wUZEhy7OsocoWVYt7RhPGcjAN85U=
X-Google-Smtp-Source: AGHT+IH/EIolfDA4zKZNCvS17yEvKi+CDTbOpEYfpEr3bP+kiR7I5G9Me13eUg8HC7hX1ig2yHn1UaJ20jH2Yr8I814=
X-Received: by 2002:a4a:351c:0:b0:5a0:daf5:a5d0 with SMTP id
 l28-20020a4a351c000000b005a0daf5a5d0mr523851ooa.9.1709147988479; Wed, 28 Feb
 2024 11:19:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <98298b2f-7288-4b0b-8974-3d5111b589cb@moroto.mountain>
In-Reply-To: <98298b2f-7288-4b0b-8974-3d5111b589cb@moroto.mountain>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 28 Feb 2024 14:19:34 -0500
Message-ID: <CAJSP0QWW2QvibpcrZbcLzVp8ngnooiTqP8i2emd+0sdCj_7Yww@mail.gmail.com>
Subject: Re: [PATCH v3] vduse: Fix off by one in vduse_dev_mmap()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Cindy Lu <lulu@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Xie Yongji <xieyongji@bytedance.com>, 
	Maxime Coquelin <maxime.coquelin@redhat.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Christian Brauner <brauner@kernel.org>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 28 Feb 2024 at 13:24, Dan Carpenter <dan.carpenter@linaro.org> wrote:
>
> The dev->vqs[] array has "dev->vq_num" elements.  It's allocated in
> vduse_dev_init_vqs().  Thus, this > comparison needs to be >= to avoid
> reading one element beyond the end of the array.
>
> Add an array_index_nospec() as well to prevent speculation issues.
>
> Fixes: 316ecd1346b0 ("vduse: Add file operation for mmap")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
> v2: add array_index_nospec()
> v3: I accidentally corrupted v2.  Try again.
>
>  drivers/vdpa/vdpa_user/vduse_dev.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> index b7a1fb88c506..eb914084c650 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -1532,9 +1532,10 @@ static int vduse_dev_mmap(struct file *file, struct vm_area_struct *vma)
>         if ((vma->vm_flags & VM_SHARED) == 0)
>                 return -EINVAL;
>
> -       if (index > dev->vq_num)
> +       if (index >= dev->vq_num)
>                 return -EINVAL;
>
> +       index = array_index_nospec(index, dev->vq_num);
>         vq = dev->vqs[index];
>         vaddr = vq->vdpa_reconnect_vaddr;
>         if (vaddr == 0)
> --
> 2.43.0
>
>
