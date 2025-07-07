Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D21B194124
	for <virtualization@lists.linux.dev>; Mon,  7 Jul 2025 13:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751895374; cv=none; b=iQhwX6Jp+JHimoXJn4xZmLkA/+M+s9ieKYfUyDwoZtwas2GCtaZSx1i+HAF6rAhWEgkhkiUCqwYNNqs7iZXyvkiDO8xdvpv2qBlOxdF7eF0OikTMNxacavck3DcUTUKE28KIb4epkOAR4UnZcxsHcvxH3YhD577NNTcAa7uW88E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751895374; c=relaxed/simple;
	bh=O377eaO+Jlj86ZSB2RpCzQcB8R9z4Xe0q5jCGof+Qtk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rR6TrOD5QMBG62B5+w0TVDPhVdiakKBs3YgR+xwbQ6RUkMi32dkTOJhYdNWMXE+jg9BL6F/cY+lW67tFcYNDnf7R4VUaZstpOskNzFjmrXVcIiODv9IR7J3FNZUyzH6YX2sNlePwdVg3IKP3y1unKf630tDNF1IF10yQyw8o188=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ceRzMAHM; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ceRzMAHM"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-60c9d8a16e5so5730446a12.0
        for <virtualization@lists.linux.dev>; Mon, 07 Jul 2025 06:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751895371; x=1752500171; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B67QLvyHZDkG3dCW4xDkICWa2oqhwCHUYXHYCu0rbCU=;
        b=ceRzMAHMobf6aDsoulKQ4oPvh/aM1Izq1HluhfXSnnVS5ApwW6rJa/TC8RNELfxcNc
         +13oyAgRN/GOHaAbcqFsP+8BEc5XpvBsHF960Mg7rz+MXbrVdRUCdHY1eWfb8NxVnhlZ
         PgJHaW6l20GGXragUMz7oxmE0DCbCah4XFWETvw/us02KTa9mQ735SyFJ9u+JDoW0KHr
         LgJW/DvC3GvyHgkxeekF0tsK3fq3taHzZ1JiI5T+rSXRJB17RjkHBkCXTATHyMwyb1KF
         IAQOerPb+cv6hxq6XeUxcLEug02XJaAfOgV4Nlf2q7bvNgstAufN70bwaM41j17wBVW2
         hQtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751895371; x=1752500171;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B67QLvyHZDkG3dCW4xDkICWa2oqhwCHUYXHYCu0rbCU=;
        b=PNB3z5tLsfcdvXgqSPUhSP6EWPqf0tWatwQcjvTteGoKfib0orQ95wZrvRfyvtM47A
         EQ4jG5Iq8alubYLBug2P+I8FtjV/sybbwVdFQpCrvU1vPTFgx1NXCOYDNLkOc8GfHCMA
         kd/sEgDwlUPtoO5HjCMO6rrTSPjMtGu+S2yZtVcebW2eJvpO2Ax4ilT4dqPgscoGVtcV
         2ORQ4MmGyFz5BRYkSs7dmf/1UIXNqgYl3lpx8sZQOlsg/lmIq0NxvwzjAyBmffx6F+aI
         aGKjPGBJ5zAE3IkWC3R8A+UvQfvnkWVayx9bsggcvjS4ayuCWROzAX4rsWxxdmMEEwJN
         MCoQ==
X-Forwarded-Encrypted: i=1; AJvYcCUeZz1jajsQxtNpyqCEYNlt7g35ymHmxH+0yYpzcJam4UcH8lT3L0rMQbDMyEzIycgWa7nVuZ83NjCJnDJxbA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyHwCSP6yDNdNeY2nm770A4Z8yyAkcEYYqazIIrD6i4Rd4KeaJP
	gdIRn2bQOab4vQlgS4+9W7VkYsl4j5NrHorp/wHyAwFJZPVmxGyXnIJA5GlyLCEBsxc8quUGUAg
	oliXCkYZIRNfpDfalOcN19WgJCt7ZM6U=
X-Gm-Gg: ASbGncsTUOQdbPYmazy5zuBoD519Ng4EO2D6Q+hYDj+tm6lycZDhbXog/ub2dZoxv5Y
	I675XzSNl4OvFoY/Bwf800cNS1mfHx9H7FYfJNln0NIznUY8w3KoRZA9ka7BID9MPBuKd1eIwA4
	uVT+T/OSL/iKjwj2XvdQAuegzAMkzXgUxOTKS0ArBCovYX7KjJ/XuklNVzPfIV88cYHPio/8OWK
	RziKspiYdkV
X-Google-Smtp-Source: AGHT+IE3xKDRxiceWfgDhOqdfWXtjxPAUKmvoHmxd7No4ahz6Uels53hHP1g6tE+28lVM037geC6nzs3mFbTA+YYN6U=
X-Received: by 2002:a05:6402:280d:b0:607:19a6:9f1d with SMTP id
 4fb4d7f45d1cf-60ff388d517mr7405843a12.14.1751895371254; Mon, 07 Jul 2025
 06:36:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250703064738.2631-1-lirongqing@baidu.com>
In-Reply-To: <20250703064738.2631-1-lirongqing@baidu.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 7 Jul 2025 09:35:58 -0400
X-Gm-Features: Ac12FXwqf0z-MDIQB81h2vm6zchf-sItAwZG0CkAA6vlslCY0d5FQLuB129JRRE
Message-ID: <CAJSP0QUcOr=1SZiMSaFXP=kh5RpAYjduy6D73QEQu9JnV1ua+Q@mail.gmail.com>
Subject: Re: [PATCH] virtio_fs: fix the hash table using in virtio_fs_enqueue_req()
To: lirongqing <lirongqing@baidu.com>
Cc: vgoyal@redhat.com, stefanha@redhat.com, miklos@szeredi.hu, 
	eperezma@redhat.com, virtualization@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Fushuai Wang <wangfushuai@baidu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 3, 2025 at 2:48=E2=80=AFAM lirongqing <lirongqing@baidu.com> wr=
ote:
>
> From: Li RongQing <lirongqing@baidu.com>
>
> The original commit be2ff42c5d6e ("fuse: Use hash table to link
> processing request") converted fuse_pqueue->processing to a hash table,
> but virtio_fs_enqueue_req() was not updated to use it correctly.
> So use fuse_pqueue->processing as a hash table, this make the code
> more coherent
>
> Co-developed-by: Fushuai Wang <wangfushuai@baidu.com>
> Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
>  fs/fuse/dev.c       | 1 +
>  fs/fuse/virtio_fs.c | 6 ++++--
>  2 files changed, 5 insertions(+), 2 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

>
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index e80cd8f..4659bc8 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -322,6 +322,7 @@ unsigned int fuse_req_hash(u64 unique)
>  {
>         return hash_long(unique & ~FUSE_INT_REQ_BIT, FUSE_PQ_HASH_BITS);
>  }
> +EXPORT_SYMBOL_GPL(fuse_req_hash);
>
>  /*
>   * A new request is available, wake fiq->waitq
> diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> index b8a99d3..d050470 100644
> --- a/fs/fuse/virtio_fs.c
> +++ b/fs/fuse/virtio_fs.c
> @@ -21,6 +21,7 @@
>  #include <linux/cleanup.h>
>  #include <linux/uio.h>
>  #include "fuse_i.h"
> +#include "fuse_dev_i.h"
>
>  /* Used to help calculate the FUSE connection's max_pages limit for a re=
quest's
>   * size. Parts of the struct fuse_req are sliced into scattergather list=
s in
> @@ -1382,7 +1383,7 @@ static int virtio_fs_enqueue_req(struct virtio_fs_v=
q *fsvq,
>         unsigned int out_sgs =3D 0;
>         unsigned int in_sgs =3D 0;
>         unsigned int total_sgs;
> -       unsigned int i;
> +       unsigned int i, hash;
>         int ret;
>         bool notify;
>         struct fuse_pqueue *fpq;
> @@ -1442,8 +1443,9 @@ static int virtio_fs_enqueue_req(struct virtio_fs_v=
q *fsvq,
>
>         /* Request successfully sent. */
>         fpq =3D &fsvq->fud->pq;
> +       hash =3D fuse_req_hash(req->in.h.unique);
>         spin_lock(&fpq->lock);
> -       list_add_tail(&req->list, fpq->processing);
> +       list_add_tail(&req->list, &fpq->processing[hash]);
>         spin_unlock(&fpq->lock);
>         set_bit(FR_SENT, &req->flags);
>         /* matches barrier in request_wait_answer() */
> --
> 2.9.4
>
>
