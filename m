Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FAF52D3EDF
	for <virtualization@lists.linux.dev>; Fri, 28 Nov 2025 19:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764359100; cv=none; b=Ockl1iaijEwBocHW8QTb81WoW21qAWeMefN/p/3z+3h6O3vYL6RbzXRg9vlapRrRoYOfb0Hg8w6WWvf3noAaVSYJdt3puIikYDxvOAf+N0G2IauJUPCrcd9fAFLw5D1eFdp3K9JlL3aPy6+HSzG6V4QSMwP08wHvTXhHx3XnrzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764359100; c=relaxed/simple;
	bh=Bj3AP+5QeibKDhdHKJOIKyIGtMszqSOZbOkDUOZlHKs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PzcXXWqNBH8NFuf+l90yXT/ez6GKnlIudgFGiCs1hH0s+2kpGebWxeE3zIzNjL3969bp4fofqTElRMMuaRbobZ4e5we6QffF7cPhYREgtV5I9CWKR98hqf1KtxvS369CWJzdaJCjPpFUhE1OhVpBzP4eyGrOwTFS7eezG8vY7c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=V+3+9VKo; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="V+3+9VKo"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7ae1c96ece1so160257b3a.0
        for <virtualization@lists.linux.dev>; Fri, 28 Nov 2025 11:44:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1764359098; x=1764963898; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EL5lnQB6ArvqmktVf7HK0TGQSj04Cghit8sLG5wYDU0=;
        b=V+3+9VKo6f6+Ecy/6ad0lvY61x8VsCXil1NpGLHm5ITHSLnYK9zWWBBqio+Q743NsI
         NUZSCXBrboEOeTl4STegFWTZ+Gbr23WRSIYyOLMYyhM6EcGxQnnJNCjjfpxLNm2Ziw+6
         QaKYP4yuetjCHb1zFT47EI8rdPpZmXqYZnQr2FoCuKLj2QSsbdgTT2QxmbpWgYduiMFy
         7tECGCuEiKvrgsOrc2sFtJzZ697wd8qlHLrp7c79jdToj7FyExbFaAdBqiHkg4pmmJsE
         pDk2iyHgRQdGV68KtT4uz6tKKc7VRHNAqDZ7eNgF6j1Y9nyAzDOH2W7gffg9i4UD0IHH
         cUjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764359098; x=1764963898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EL5lnQB6ArvqmktVf7HK0TGQSj04Cghit8sLG5wYDU0=;
        b=U+yYgnSRHzxrBvD6rV0b4NbJsHtk2xKtpKyUNMKoHntrBOxisJVusjDxVzvXXs5DuT
         jfoPTklhbnlOrdPQ2cYMTbsNTk1RUk5w7c2DAaANCDj2Sl4MK4ZfUefApk9ZCfti9y6P
         6dkhgAxMvzPl3MismlBhFfyetsed5oOxMgE94U+eNeNGSZTcpfBVRoplqKbSm9plB6Ng
         0wg2y9COLKfTDzBX62W+LmJ6jEZmzBZmlNgGdti0uGWUyDZZHCQftYFSs9tz16uwowmt
         3nQwJQfiGqX8bV2KkomqW8W0qh79XS6EkFIfEGCcpEqcszQ2t95oRhnhS1s+WHISjQ/N
         bDzw==
X-Forwarded-Encrypted: i=1; AJvYcCWHCJqEUpzvZ+Uh9rMWv+l0qcOO7ujLUztr9q7dXd9m95HQEEFFE6M+SYQx9hfPiUEJ1tXPOOWhf5L70kKdIQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyvjIaV54pYNVWP5xyaQ+HN3PamntGZAlBmVg/sX9Id6NnCrriD
	56wPpB7XW4uyWjiDZjcB6Ijb2hcn5ShOSW9MnIDWjShDU/69sHJIxRitxy07zpLgMPi4rZMWsxo
	Gkwce1CPV3+GeT9kHZxoW1OZvObEm+Sk38P6rPBU9nQ==
X-Gm-Gg: ASbGnctRXictNXRyzhKq9j/zSEZXXr7bzv0hofkoR/Ty1xvA9PGzmduibOMj5h7W5vU
	A0wQIfAhQB8uOLBT8+i03YpaLDl8k7pJafsQE0G6xrnU1zGU3BYZueVC4qdc8keD2qvJQvlpwkh
	cUkez7RIsZg/5LXOfNsqkf+kJ4+SuJJA85U5O2ToVAlxEcsHEbFwTVmn/PRvNjCXzk7yCZuiqnp
	/FeLRTJYbJzi9I1a1ur2nNzcl9jF35m5p53pkcPiedVAbZdvqwp4MXOjmzR2qyHz129YylIAAx/
	FEiSlx4=
X-Google-Smtp-Source: AGHT+IGrCksmBbxz9v6OODWXw3jg5JUAuqr2uXfNM+p+AOqeGW6UtPYXkYo+cITOMsNqpMT81gOSwHim2ngfe4fkcew=
X-Received: by 2002:a05:7022:69a9:b0:119:e56a:4ffb with SMTP id
 a92af1059eb24-11c9d5538e8mr18207898c88.0.1764359097859; Fri, 28 Nov 2025
 11:44:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251128083219.2332407-1-zhangshida@kylinos.cn> <20251128083219.2332407-3-zhangshida@kylinos.cn>
In-Reply-To: <20251128083219.2332407-3-zhangshida@kylinos.cn>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Fri, 28 Nov 2025 11:44:46 -0800
X-Gm-Features: AWmQ_bnZzeizOKu2WLPi5AEBKsrxZhyOw3plwI8tIQrc3qIRhB_hMon5zXQE3Nw
Message-ID: <CADUfDZqBYdygou9BSgpC+Mg+6+vaE2q-K=i1WJB1+KAeBkS1dg@mail.gmail.com>
Subject: Re: [PATCH v2 02/12] block: prevent race condition on bi_status in __bio_chain_endio
To: zhangshida <starzhangzsd@gmail.com>
Cc: Johannes.Thumshirn@wdc.com, hch@infradead.org, gruenba@redhat.com, 
	ming.lei@redhat.com, siangkao@linux.alibaba.com, linux-block@vger.kernel.org, 
	linux-bcache@vger.kernel.org, nvdimm@lists.linux.dev, 
	virtualization@lists.linux.dev, linux-nvme@lists.infradead.org, 
	gfs2@lists.linux.dev, ntfs3@lists.linux.dev, linux-xfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zhangshida@kylinos.cn, 
	Andreas Gruenbacher <agruenba@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 28, 2025 at 12:34=E2=80=AFAM zhangshida <starzhangzsd@gmail.com=
> wrote:
>
> From: Shida Zhang <zhangshida@kylinos.cn>
>
> Andreas point out that multiple completions can race setting
> bi_status.
>
> The check (parent->bi_status) and the subsequent write are not an
> atomic operation. The value of parent->bi_status could have changed
> between the time you read it for the if check and the time you write
> to it. So we use cmpxchg to fix the race, as suggested by Christoph.
>
> Suggested-by: Andreas Gruenbacher <agruenba@redhat.com>
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
> ---
>  block/bio.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/block/bio.c b/block/bio.c
> index 55c2c1a0020..aa43435c15f 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -313,9 +313,12 @@ EXPORT_SYMBOL(bio_reset);
>  static struct bio *__bio_chain_endio(struct bio *bio)
>  {
>         struct bio *parent =3D bio->bi_private;
> +       blk_status_t *status =3D &parent->bi_status;

nit: this variable seems unnecessary, just use &parent->bi_status
directly in the one place it's needed?

Best,
Caleb

> +       blk_status_t new_status =3D bio->bi_status;
> +
> +       if (new_status !=3D BLK_STS_OK)
> +               cmpxchg(status, BLK_STS_OK, new_status);
>
> -       if (bio->bi_status && !parent->bi_status)
> -               parent->bi_status =3D bio->bi_status;
>         bio_put(bio);
>         return parent;
>  }
> --
> 2.34.1
>
>
