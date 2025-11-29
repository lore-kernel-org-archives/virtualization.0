Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B0D18DF80
	for <virtualization@lists.linux.dev>; Sat, 29 Nov 2025 01:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764379208; cv=none; b=Ow3qr8orw4qYF7AqHV5m5A68zLmY11LLNuHsHBD9VaVOg4VgtP0JmFUDngeeLudutcP+GzrhwAf6bk9jM9V7oYGC1xCg0yEqoSHSXI53Ol+/fcqxhFlPz2FlpZbEqpg1g0dBNPpiNKigtWD6u3YwABSMaY40f8Y3z2KHvLGjyME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764379208; c=relaxed/simple;
	bh=CQ4gu5qwHISanFuymuvKH3qflMdaqJ/uuGBrjJ6tlTI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QXhN+4deOpUMRFa3FP4PoCDIJ2DQTwpVRvwK6fD5Wu1chdFlH/0QbDNyRRzKITV4x4G8/HADzUA9YLZ/qRwjI3wbEGhansyhKUMXuhMIioJ3DmjdRZht2xgbCe+IDX3ndjXOgrtkhixtnSe/5iQaSeT52DXm/PLplDnoHNMhglg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YXBIA5iV; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YXBIA5iV"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4ed7a7ddc27so21162731cf.2
        for <virtualization@lists.linux.dev>; Fri, 28 Nov 2025 17:20:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764379204; x=1764984004; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fs0ohHvC2dybiBLIXiSQxGJyUXrOOQGSRM7UOWCS5dA=;
        b=YXBIA5iVl1jJ5Lr3sJof78zHrpkQn1dv/8eluXaKvm32Rk8AuqcfQVRsVooNHK2otr
         aHoMIx7jrWK9uXoX/C93RHrOKC0iGW7fu5sisSxAeno2g4qXRBxArmLzjWFMvV3AX28g
         Rqx2GyRwTNAB1/dkvXERUptXB4ZdlaW1ySQuNITL6QKP7dxiJYIZsF/DaxQ8HNXkwehS
         E1Mdy66W+XkRZaosTdduZzG6lYC7a3GgdrEVXTeciPRUjPMuIEjUoQ/+qtA/VvRP6S0o
         CwLQJedoX3txhIqe3elS9Ja0QbOWGfC8HDWm5V4aqHZpaPYoS+9vD3/zvbabP2y3Md2k
         +u1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764379204; x=1764984004;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Fs0ohHvC2dybiBLIXiSQxGJyUXrOOQGSRM7UOWCS5dA=;
        b=h3tsYTgtizM0bubfyVOSSmtv4luOUu1XNydTgK1PSPpX0ZAErnfOKyEDOUJBtETANf
         slrKxVJtjqG/ryv1Bc/vYVFP41+JmYiG2hcaJeDlcgDqAPKRuaMRt1N6BrrBuA2/2Op+
         0sjqU2tI0y8FYIYNb+FqIXGsqV7mNhhSoCLN6utd1thbv57Fy5Xl6bdPxHTJTwT72pRL
         3qfhQEDYN9n08ZsrAWsgCdMA50OVl3tHBbdHqRGN7pN6RApgtQv8C382fuW0htWlHMUh
         aFL3qyrqpXD+KgnQeKNwCDYCWyB5xF/C6TZrUNja6/i55XHYCqI9mNr3ZFfmq8eSk3xt
         tr/w==
X-Forwarded-Encrypted: i=1; AJvYcCUD1T0TlGsPNn3w/lj27KLlJ8nBybfUYeiGfgDyWpyiYRdQDpoYSeIDYQCBJjKeyjH8LcUiCLH/IZ4bl6JhkQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzqYlh0bT2CD9eqrH7DWRg/3LIGhDluHe0LemS4+k7MjUPDpziE
	PlCK+KnWS4wjcIdLwOzPGCeTUcNN9cM3B7feDu1k4XHCFJ5xwH1A02XWA9f3Kpbw6HHpZU4zo8Q
	vJhjO0pfft60PXU2Dzfvcmct1mnbP6Hc=
X-Gm-Gg: ASbGncvqhxZF1qXT0i9pelvTNRA7f+YAw5+xWCPGIMxGy7eUzE0sNwbp3uxEYqtVFjY
	TIpUgfA64zSQ2oSUJjxI0r2aMQ3PFjubbvVwLqBROiwU7gCOSdpxbgw0A8szicUOyPdrjynkI92
	MGU3dfQq4Y4c88SUscBPnpziyLfP13b2tnyDYB8yx01uRH/m3it6UQHqZQUOm7XFh+J2I9Y88Tf
	MmA2DMyyyPFtXMPVENsDpo5MojHHFDdIb+jdIeovHBVzg+tBrry/GEdkU8ucMSAW6jEdA==
X-Google-Smtp-Source: AGHT+IGvVajIc41VyAxCuPyxqWUXb2OrVTIXZXouCyBBkNWEtauVL8pGUlccoVwLRAWDPyhKgINw+5nh517v8WUU60c=
X-Received: by 2002:ac8:7c43:0:b0:4ed:b1fe:f87f with SMTP id
 d75a77b69052e-4efbda3957amr254551091cf.20.1764379203672; Fri, 28 Nov 2025
 17:20:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251128083219.2332407-1-zhangshida@kylinos.cn> <20251128083219.2332407-13-zhangshida@kylinos.cn>
In-Reply-To: <20251128083219.2332407-13-zhangshida@kylinos.cn>
From: Stephen Zhang <starzhangzsd@gmail.com>
Date: Sat, 29 Nov 2025 09:19:27 +0800
X-Gm-Features: AWmQ_bn06KtcfeC8pChk4HEBjz19bArSXx8IRJxxttyX3p2OYoBSLr0JgGawFZU
Message-ID: <CANubcdXJyE6Y5J3C5Zgc1jA7qSXk+_Hb0pm8Q-8cTb3Z_eM4sA@mail.gmail.com>
Subject: Re: [PATCH v2 12/12] nvmet: use bio_chain_and_submit to simplify bio chaining
To: Johannes.Thumshirn@wdc.com, hch@infradead.org, gruenba@redhat.com, 
	ming.lei@redhat.com, Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: linux-block@vger.kernel.org, linux-bcache@vger.kernel.org, 
	nvdimm@lists.linux.dev, virtualization@lists.linux.dev, 
	linux-nvme@lists.infradead.org, gfs2@lists.linux.dev, ntfs3@lists.linux.dev, 
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	zhangshida@kylinos.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

zhangshida <starzhangzsd@gmail.com> =E4=BA=8E2025=E5=B9=B411=E6=9C=8828=E6=
=97=A5=E5=91=A8=E4=BA=94 16:33=E5=86=99=E9=81=93=EF=BC=9A
>
> From: Shida Zhang <zhangshida@kylinos.cn>
>
> Replace repetitive bio chaining patterns with bio_chain_and_submit.
> Note that while the parameter order (prev vs new) differs from the
> original code, the chaining order does not affect bio chain
> functionality.
>
> Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
> ---
>  drivers/nvme/target/io-cmd-bdev.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-c=
md-bdev.c
> index 8d246b8ca60..4af45659bd2 100644
> --- a/drivers/nvme/target/io-cmd-bdev.c
> +++ b/drivers/nvme/target/io-cmd-bdev.c
> @@ -312,8 +312,7 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *r=
eq)
>                                         opf, GFP_KERNEL);
>                         bio->bi_iter.bi_sector =3D sector;
>
> -                       bio_chain(bio, prev);
> -                       submit_bio(prev);
> +                       bio_chain_and_submit(prev, bio);
>                 }
>

My apologies.  I think the order really matters here, will drop this patch.

Thanks,
shida

>                 sector +=3D sg->length >> 9;
> --
> 2.34.1
>
