Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A16632AACE
	for <virtualization@lists.linux.dev>; Fri, 28 Nov 2025 12:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764334790; cv=none; b=fNH5ML7j2LQeAZ8FpCqUhiu+nbrN7t3pzRJ4UjIxcsVkXuvYTlwULlLuX6cwjBvFFfhb13OuT2h7KZXJ0MeA8L2Kr4eJFD2e0SHf1tdXPC5jeyb0didHMhPzqxpdM6mAU0ONoV70fN4sXMC/6xKd/JL/UJW/8x7CJ8vkdwsxKYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764334790; c=relaxed/simple;
	bh=5QcOkFfFDyBXYDnDanyoo0Sx7zR4bMbvdaWPFSIL9Dk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t0/56F7sE1kbd3OpwFqm8QNDCCWec4PFoTxVyPGbeLBulG72g/3hLIBsWpPUDnVxTUBeeSG9on9AOnW7X1I2J1mSbjZhzjgeo6hIpUoIAtaXCVUSc+e+L/SIAzcP20hYEoD1F7QU1Bf93wFt25j8bSEJzayl8af7RxFzER3dfCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T8pS4d1f; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T8pS4d1f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764334788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UbnViGm0SST3AIOO/NDK6ivARfPGgq8UL5FPgRGsaTs=;
	b=T8pS4d1fsn7qpHmykIofedKAKHqMnz7z2Bf20HHr2qMmMEBdhtGyDn36ahbecBKsPT3SYW
	K8AUU8mP2p5h8n2vBsSBM58V28eqr5oe1oMWGzdfO0vFT5S0J74SCPE77ImZE/GFGnu+p6
	fiOcJvJLFu5he4MzFdDh+bNCBIvEqXw=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-lyRPLY-DNoWGFqRoUGOSmQ-1; Fri, 28 Nov 2025 07:59:47 -0500
X-MC-Unique: lyRPLY-DNoWGFqRoUGOSmQ-1
X-Mimecast-MFC-AGG-ID: lyRPLY-DNoWGFqRoUGOSmQ_1764334787
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-78aaf491ea9so21487247b3.2
        for <virtualization@lists.linux.dev>; Fri, 28 Nov 2025 04:59:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764334787; x=1764939587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UbnViGm0SST3AIOO/NDK6ivARfPGgq8UL5FPgRGsaTs=;
        b=uoEwMAsVDpGvtLaTeLlOKp73xAF+VK9p/Ysn1KLYT1KLhspnyT1yGQBAjBcvkxTY+b
         W2+3G6zIoylKj2RgeGS2uOhZ5MPUjHrRcPoLSz4Gsp3Ro2oPXhRJ9bK6kKade5GM4I4+
         tSCqJUI01mgbMqP1HV5Bb4SGeaJt1fWERRN2nGA6s4ED41RN0vSlrWEdMk84WbEXa3Q7
         +wOh/OfLa3RkPZFpRfGxFEqkVx0rNZsqWTVN4Z6/6YQXMDKrwc6lOGyi7mDhYc5gexuW
         RW9YV2SkIm8Obys+6ko492TNbecoWAWscIulAlw0qJAuvXJI6jFVABw5MFnG+HU/k7Ae
         l2DQ==
X-Forwarded-Encrypted: i=1; AJvYcCWN/oXxXl5TK1sLapsoqSlSuUZNw9t80oM5JbJYv85JryW+qkMx2Au+GUZx/OntYThkjn37Wlv39+TXlHvNIw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxQ//Xx+qb5DYKqa9VzldX5b4UO79qDchghusTyKAiELCu4BXrL
	st8sHh4VwuqT7I4YIISZyVEzSFeFakfNRQmCvBmCNu4XJNHbPVPkDV7KveiRThMqOc6iKnLYOSp
	KIrDtUNNg5bUoJgbcxAJoDFUoQp9pZVPnjaydq5HOe6CB6+FupvRDPAcKkmos1Z20AFa7ZpC4+6
	VgaLmZnrLJ2b/2QQ4ZWA1ZO3JP0cVS5doaIzrcBC3CDYQ=
X-Gm-Gg: ASbGncsqCWm5Q0naPlTrfeU79WdbV3f/otGViMDmzKYJQliFw8n2lCEp9+4pUaXQYw9
	iIBzpAm0VltcSFGCjq3rpFDD8tMtX0W25OwB6uJ4FwCT0pBNkfycS/4A6zjPmD9auWx9bGlZFBN
	w9zQAMES5GFZVHS1ZD3rNryPaZUPU7Qa5/xSFs+cw7uqd5xjcyJ/6IXeX+Qe5s9b6x
X-Received: by 2002:a05:690c:6f03:b0:786:78ab:72d0 with SMTP id 00721157ae682-78a8b47a179mr234771297b3.7.1764334786912;
        Fri, 28 Nov 2025 04:59:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGesqVOsUJELcTkEGN3hauFQ6kd2TkNnYcjHT4c1bgANcOfukNB8/4Sre15bHJPI3DpWDPFXhJhMME6PGLKN8M=
X-Received: by 2002:a05:690c:6f03:b0:786:78ab:72d0 with SMTP id
 00721157ae682-78a8b47a179mr234770957b3.7.1764334786528; Fri, 28 Nov 2025
 04:59:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251128083219.2332407-1-zhangshida@kylinos.cn> <20251128083219.2332407-3-zhangshida@kylinos.cn>
In-Reply-To: <20251128083219.2332407-3-zhangshida@kylinos.cn>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Fri, 28 Nov 2025 13:59:35 +0100
X-Gm-Features: AWmQ_bmJ3AOy1Ou64bzbzmfYJle8eXItasxBb4QbS7GrXBYKV503HxVqfGGmAks
Message-ID: <CAHc6FU6H22GEQTaOh4tm_=yL7CZ-Ck4EkXtmdsn_oyAW7OWB6g@mail.gmail.com>
Subject: Re: [PATCH v2 02/12] block: prevent race condition on bi_status in __bio_chain_endio
To: zhangshida <starzhangzsd@gmail.com>
Cc: Johannes.Thumshirn@wdc.com, hch@infradead.org, gruenba@redhat.com, 
	ming.lei@redhat.com, siangkao@linux.alibaba.com, linux-block@vger.kernel.org, 
	linux-bcache@vger.kernel.org, nvdimm@lists.linux.dev, 
	virtualization@lists.linux.dev, linux-nvme@lists.infradead.org, 
	gfs2@lists.linux.dev, ntfs3@lists.linux.dev, linux-xfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zhangshida@kylinos.cn
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: laC6-AQijQ6sQi-FVeu5BLddbktY04SPIKBUGEQOaB0_1764334787
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 28, 2025 at 9:32=E2=80=AFAM zhangshida <starzhangzsd@gmail.com>=
 wrote:>
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
> +       blk_status_t new_status =3D bio->bi_status;
> +
> +       if (new_status !=3D BLK_STS_OK)
> +               cmpxchg(status, BLK_STS_OK, new_status);

This isn't wrong, but bi_status is explicitly set to 0 and compared
with 0 all over the place, so putting in BLK_STS_OK here doesn't
really help IMHO.

>
> -       if (bio->bi_status && !parent->bi_status)
> -               parent->bi_status =3D bio->bi_status;
>         bio_put(bio);
>         return parent;
>  }
> --
> 2.34.1
>

Thanks,
Andreas

