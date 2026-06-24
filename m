Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A269E378803
	for <virtualization@lists.linux.dev>; Wed, 24 Jun 2026 17:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782321748; cv=pass; b=ZzwqxheBAHn4sqXtWLap/Kyf1luYmTgiHatbEn+cBi+U5TNru3N8osMhVgvqKPvipf0yXEPbk+eA6KF+rcIJ8qXptJ+jgHqcrM48TU7Ec0h/SpDV7eNDsRCROqCH5GxdfK9bkDRcE4jM/6ZrH9e/fF25xleDzPseG+AJNxaDRdg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782321748; c=relaxed/simple;
	bh=Oc/eY5jh1sixVZt7TvGpIpQcD6r6ROfPjIuguTla2ts=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l3iSdKVNWLPo1XyhMMHno6FrGM75++lzwhGOWE6xPE7xDuQRLVlwg2UWNDXSTsyiMgdNEKh2wj00cITRCFpMFHt4o03n6HGmNQpnOEMRF4u9T4GCnp30vFb8oBmjnIeTWPHI9bJk27Tz8Y7tumpyoCobL4OGJuZQRERK5ZWWf0E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=am2p5v/o; arc=pass smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="am2p5v/o"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-44192448b56so563620fac.2
        for <virtualization@lists.linux.dev>; Wed, 24 Jun 2026 10:22:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782321745; cv=none;
        d=google.com; s=arc-20240605;
        b=QULhQUvFg5TJzs56SBE2XHe+WxLnbIkIu2Lo8GVf3BO7JZB0FQWR4vI5gPfr1vF/bH
         89YLvucsL6TIoJ6xi09aG8KMT8yAQEePtA9FcR6lLD4h22rqDPCbfpfSnyKQ2MRYY+gE
         tTrUyVYagYOdnaLdkVROBeDLPb66vBRxzFvGZNObmpBdJydNc7D0jyl3pOpwoSaVePWs
         nesMdlJMVOTRlQ7bzUMu1vYgmiRZUw8aZBjucI67SHxu7GG+HpmdZ3K+reR/47UtdHwn
         DowEaXG0KVe8FDNjHOIS5JZnqRaHEAha6VhZtaYw6rPOITmhgyUlmLnInw0VlsS3s6Hl
         3jvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=2RrZQKRnOe4vqE7AGHYXjMuRZiw2LXHf5wiJxvLR544=;
        fh=IYGU1Ma07G1hbdzcMpbMiheGJ8oiQwVbBTQ+2DCliaY=;
        b=XVSyv2tXxCkXeG0cubQwLqecRfCSok0qeOjLLkT8qw9dJxyJiLk1l4Rw84itCNi5HF
         oCRqV06VxXoeJ7eFFAAYntQetcb/6f8IaebVjWZKVVfmHGV9pqONKwtemflEcrWfoXzX
         ecWxCjQGipMvuVRHMb+uNC2wsN3hUpWD9gilSdQMox05djujvNRUAmMRKwQukAD1Xl9I
         KsYCThoj0D5ujXQN92DnJCqRKCnYjoN1wktYDB07TRn0ZsMbFn/htVTiORebANhTLdfg
         rP1o9Fn/x9sYpCmWCb5VmiEgr0iQfLnoRtLn/J95ynJfWIlWpAClUjCr+SX+TdqrIQ7q
         3kIQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782321745; x=1782926545; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2RrZQKRnOe4vqE7AGHYXjMuRZiw2LXHf5wiJxvLR544=;
        b=am2p5v/oedK5/vTFkzAqZ9xCxaO0FnxxuDGHbPO1HEiu/F3BDb24KIGueq9dWwgntT
         nNidVFnjkswA6smV0l5Sed1BLLn7yqrGA8VQyyzxshSJy6Bgu0FAD0ZkQma7dxOdrhT+
         rXdEizxzPB6vpBf7eMMpwTMyl6fjTlyiYbqSBsccabk/gsxIt7FgoRSAK+FFJYHoIr5T
         WcNpKFtCNK2xD2HQkUaNQtxoI+16NAUFGG8KN3zPuL4WWFcrTf1vP00bwQipppz9YwJv
         AnYVt2TUo6XKnHaJ+S7DHHyV22I79HZ7AF1UjWtpcPEHssY9GJ+YQrFFJFYkVHjn7XeV
         0SiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782321745; x=1782926545;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2RrZQKRnOe4vqE7AGHYXjMuRZiw2LXHf5wiJxvLR544=;
        b=ON0qQej6hfHTMhv486Y+b9lx0BBNTyGzymZoQCbTckeWnM5v9AocQEVIPowOM8NNRv
         Fr7AkNBjyP5fBa1hYDIRoHBbFGiGJmfu+Xynazz/Vpw+ycyMyaBJjUJ6ZnyQdMgMIWnD
         dZspaUNOxE54yZkTcsk2Lhnwo7T1hZUopuPJ4lOpI07JR78M+k2Y7IAl1wXpA1G69ld3
         lNSC5VNt70xB7Zb2i/bkrdvJtw41x23+OlDFTJR4MP5AAfDLeZ1XT9Wrl4L6275VS8eA
         wyy9BLQWocbDTI4CkuUz1RxYbHY6/YXoZrnCLC9CPthYbn5Ij3Xl/K73re2/qZJukkmg
         UhNA==
X-Forwarded-Encrypted: i=1; AFNElJ+yocRdNi+slzq9ZEICz2kYDSsHamY5TwhTkIwE/7Giik/aAvcEwSSrNcFoNBLLCFlWNRemCNY8jfJQLJBnUQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwZINPtOGCYdc/KsCsK+W9D08qfDhvW6wxAYpGugQRaksMyjOvY
	aX5fwfDORRIh67+hdeMUqjENSvgPUAvqyMCxQdtv//y8KBVtrOUhE5IjrsHuvl2LwJ4C736P3tU
	EouAGjcnxgKAbksVs00BevnDK3cDi9kE=
X-Gm-Gg: AfdE7ckZmjMZ/OhV2Sdw0Y9wl1ucNrR8TEKWlr1WjDslwKlOWCMtNskC+t0gkHz+b1k
	Tq6lDRVMKsxvhBCrr23upW21g29DFo92TnsjegdIoaGWLIzvjU6eeeGYe8+PoqTNcS+GYomV4nr
	Pf+IHwUilI12Rl0zyaI+CndUtqNga9PuOPiuMQwPIO/5eF77nLMf8tSYiRv3p6R/aOVkLpBcMCR
	bFGUgfXdKPjxbOSvqIfZD2jNeHvXLUth1ci4Whun3WAL5gy1F8qhRHZbCfPLsXxVfd/WyJPqxQC
	LWT2F3fVuA==
X-Received: by 2002:a05:6820:1525:b0:69e:89dd:175a with SMTP id
 006d021491bc7-6a114b61692mr6128235eaf.20.1782321745533; Wed, 24 Jun 2026
 10:22:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260621130246.2973254-1-me@linux.beauty> <20260621130246.2973254-5-me@linux.beauty>
In-Reply-To: <20260621130246.2973254-5-me@linux.beauty>
From: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date: Wed, 24 Jun 2026 19:22:14 +0200
X-Gm-Features: AVVi8Cf9CFjt8XRurzmaliLJiEImYmVwDzh1HgALE4ORiap4zi56uRvfI8NkH6Q
Message-ID: <CAM9Jb+gzSrobPgH_nMPs+RsbhVP8jovpAQsC5syQKoLrtqnX=A@mail.gmail.com>
Subject: Re: [PATCH v6 04/12] nvdimm: virtio_pmem: stop allocating child flush bio
To: Li Chen <me@linux.beauty>
Cc: Dan Williams <dan.j.williams@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
	Alison Schofield <alison.schofield@intel.com>, virtualization@lists.linux.dev, 
	nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> pmem_submit_bio() passes the parent bio to nvdimm_flush() for
> REQ_FUA. For virtio-pmem this makes async_pmem_flush() allocate
> and submit a child PREFLUSH bio chained to the parent.
>
> That child allocation is in the block submit path. Making it
> blocking with GFP_NOIO can consume the same global bio mempool that
> submit_bio() uses, while making it GFP_ATOMIC can fail under
> pressure. A forced failure of the child allocation produced:
>
> virtio_pmem: forcing child bio allocation failure for test
> Buffer I/O error on dev pmem0, logical block 0, lost sync page write
> EXT4-fs (pmem0): I/O error while writing superblock
> EXT4-fs (pmem0): mount failed
>
> Avoid the child bio completely. Flush FUA synchronously, like
> REQ_PREFLUSH, then complete the parent after the flush. Since no
> child bio can be created, async_pmem_flush() now only issues the
> virtio flush and preserves negative errno values.

Child flush is asynchronous (performs async flush to host side and returns).
Till child bio completes guest userspace waits in pending IO state.
It seems the current change will affect the behavior?

Prior RFC [1] attempted to coalesce the async FLUSH request between guest &host.
If there is interest, that approach could be revisited or integrated here?

[1] https://lore.kernel.org/all/20220111161937.56272-1-pankaj.gupta.linux@gmail.com/#t

Thanks,
Pankaj

>
> Signed-off-by: Li Chen <me@linux.beauty>
> ---
> Changes in v6:
> - Replace the child bio allocation fix with synchronous FUA flushing.
>
>  drivers/nvdimm/nd_virtio.c | 22 ++++------------------
>  drivers/nvdimm/pmem.c      |  2 +-
>  2 files changed, 5 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/nvdimm/nd_virtio.c b/drivers/nvdimm/nd_virtio.c
> index 4176046627beb..4b2e9c47af0f5 100644
> --- a/drivers/nvdimm/nd_virtio.c
> +++ b/drivers/nvdimm/nd_virtio.c
> @@ -110,27 +110,13 @@ static int virtio_pmem_flush(struct nd_region *nd_region)
>  /* The asynchronous flush callback function */
>  int async_pmem_flush(struct nd_region *nd_region, struct bio *bio)
>  {
> -       /*
> -        * Create child bio for asynchronous flush and chain with
> -        * parent bio. Otherwise directly call nd_region flush.
> -        */
> -       if (bio && bio->bi_iter.bi_sector != -1) {
> -               struct bio *child = bio_alloc(bio->bi_bdev, 0,
> -                                             REQ_OP_WRITE | REQ_PREFLUSH,
> -                                             GFP_ATOMIC);
> +       int err;
>
> -               if (!child)
> -                       return -ENOMEM;
> -               bio_clone_blkg_association(child, bio);
> -               child->bi_iter.bi_sector = -1;
> -               bio_chain(child, bio);
> -               submit_bio(child);
> -               return 0;
> -       }
> -       if (virtio_pmem_flush(nd_region))
> +       err = virtio_pmem_flush(nd_region);
> +       if (err > 0)
>                 return -EIO;
>
> -       return 0;
> +       return err;
>  };
>  EXPORT_SYMBOL_GPL(async_pmem_flush);
>  MODULE_DESCRIPTION("Virtio Persistent Memory Driver");
> diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
> index 82ee1ddb3a445..058d2739c95a1 100644
> --- a/drivers/nvdimm/pmem.c
> +++ b/drivers/nvdimm/pmem.c
> @@ -242,7 +242,7 @@ static void pmem_submit_bio(struct bio *bio)
>         }
>
>         if ((bio->bi_opf & REQ_FUA) && !bio->bi_status)
> -               ret = nvdimm_flush(nd_region, bio);
> +               ret = nvdimm_flush(nd_region, NULL);
>
>         if (ret)
>                 bio->bi_status = errno_to_blk_status(ret);
> --
> 2.52.0
