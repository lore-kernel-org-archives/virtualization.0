Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6E732B99A
	for <virtualization@lists.linux.dev>; Fri, 28 Nov 2025 13:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764335495; cv=none; b=cphm/SMkmmkcTfiaVEhuVIhfkHFbMg9054sqRh48NnWDsjDiX4rqDHXuxKvpwHWaZZhYzTY0mO4tooXw65O5XX2rBIC/vDr6kQPgLJ1PuHlsOcdOqjDH4H8WecHMfPq8cnj8A/6ctjn12x+VLXa1KEzAfqaSMH/RCS7UEZxe4yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764335495; c=relaxed/simple;
	bh=cT5VambQLzg4yYEkETS1DAEPp4cL0vkJ6BivaulYb7M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VWrt8U/6vgGChEGm20T4gprTzXe6qS39bhJvIyymaTdUfwjZMulYr8DHiZJ0ZY8xWUkvENdHlEUegPLOUIgML5wnvX3nRbc0e3mES0NwkzbLlQ15+UrifRZ60oz+eqchhxpRImjzxRJ7tnh3nqqGANoI5nEar5jzwfgjcOgO2zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NIygpMCj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NIygpMCj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764335492;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cDb8wvl+/S3cs8WDouA4IaIUDYl/lhw5kT6xFlbeDqo=;
	b=NIygpMCjROe06ApYalrjCwRGN6G2Tx+linFraEADItEpQw2KNmtseValASb2gjO06Aw76q
	n1FD02DdItSdCyNLrX400ubJ06v/7QuXk03zt3yYqPeTo2DW/sTEKRYaCG2V9XX/LqKz6H
	ia/Dj+q5XlYYmWUNeQDjF/EmM7g2jfs=
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com
 [74.125.224.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-231-BGNs39WRN-CETGholhQehg-1; Fri, 28 Nov 2025 08:11:31 -0500
X-MC-Unique: BGNs39WRN-CETGholhQehg-1
X-Mimecast-MFC-AGG-ID: BGNs39WRN-CETGholhQehg_1764335490
Received: by mail-yx1-f70.google.com with SMTP id 956f58d0204a3-64203610e3fso2397984d50.1
        for <virtualization@lists.linux.dev>; Fri, 28 Nov 2025 05:11:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764335490; x=1764940290;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cDb8wvl+/S3cs8WDouA4IaIUDYl/lhw5kT6xFlbeDqo=;
        b=KXx7Dyq78XTtx/pv3Q7sys0qa2i8g/CM7LEERR7ThgvIt2qBN46Tpjb/4JulljA6RQ
         JpkUseJuGmOOM1SS3b7ARZ907KvN1hzsTNJHjKGmsezC/JEM8uh8zd9019wg02ENecio
         HtIobvVHclBqeAhLVvHzMOi6wLlK3XDKG+fKeinfRuxHcxhoMTWs031/s92Kjz9x4wXL
         R9dOy19n9jTqP+k0rQFX/jDGpIfvLzfI2aYgF6Lzl6y+cQjY1f7t+blZtMugzXdsmpM2
         8RXZko7XX4R1iRdvHaUuHvEKXZ+bxPrjz67foXeL1IKeXGXLL+neB3vErtnpmlzf61b5
         8N7Q==
X-Forwarded-Encrypted: i=1; AJvYcCX5w7VwA6HiDCVJnICZrlwpZC54KTFsev2d+lX3LJdkr5qkVzkjTTIIqpEY0YRPbHKzvcnh4arUvREEYqR8Yg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzeEgZGY/XFTAVN7H5NTyb8qy3yRjwQyt8t5t7RAi2hR5ZYj/DD
	KMIrFVTbac/4P9Of20viIySJqPnLrZUykjtLF59XAVBsySGkalmEKBWsmO86UWwMbFFsDWwpRve
	7SZYA9Km5fX7uggoYuIz8GcIDLG3UPbJqrEwFEbaP7xE2LhsVjcQ45GNFVtI09Pwl8K4BqoHQp0
	ystoOXkmOtqlDoPEpCvBbqiohxzlLagA0GjxlPUxJcGSA=
X-Gm-Gg: ASbGncsdUH1p7SIjzcDnnd1J5ltU5bCXgLQz5F7wSFbPDu8v2eiV+yVAsqJPvbqlzb8
	rA9tfGCAlRw4cQhgZU5NEK+cvniOuVzWXGHootEUyQ9g2SGS+VnCpb6XbUNMu/gUI3HvFwZ3jhr
	tjC2yC8hhdrX97t41GnDMxf/QwPQaruezNwYts6A2ISQ3YoazJJpQbWPIfKmO/tF1n
X-Received: by 2002:a05:690e:8d2:b0:63f:bd67:7c52 with SMTP id 956f58d0204a3-64302a48446mr15103915d50.29.1764335490417;
        Fri, 28 Nov 2025 05:11:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFpYs6Bqkkw2QMj53nrShI4JIcUgw0aEZxMMPQ2h/FT8I7boFY7Ao7pNuY9j2sTWaBF/Hvop1CT06FKU/ZbYVo=
X-Received: by 2002:a05:690e:8d2:b0:63f:bd67:7c52 with SMTP id
 956f58d0204a3-64302a48446mr15103893d50.29.1764335490100; Fri, 28 Nov 2025
 05:11:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251128083219.2332407-1-zhangshida@kylinos.cn> <20251128083219.2332407-3-zhangshida@kylinos.cn>
In-Reply-To: <20251128083219.2332407-3-zhangshida@kylinos.cn>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Fri, 28 Nov 2025 14:11:19 +0100
X-Gm-Features: AWmQ_bmMbDxUx7xf6l9s72idOADcxGPBv_GTFewzDFs5Yo-0xMy2x8K16_Wfsjs
Message-ID: <CAHc6FU43FWMYm2y2b9EvrFzsJdOn55s2QOMxCfRiHKVMVRqQaQ@mail.gmail.com>
Subject: Re: [PATCH v2 02/12] block: prevent race condition on bi_status in __bio_chain_endio
To: zhangshida <starzhangzsd@gmail.com>
Cc: Johannes.Thumshirn@wdc.com, hch@infradead.org, gruenba@redhat.com, 
	ming.lei@redhat.com, siangkao@linux.alibaba.com, linux-block@vger.kernel.org, 
	linux-bcache@vger.kernel.org, nvdimm@lists.linux.dev, 
	virtualization@lists.linux.dev, linux-nvme@lists.infradead.org, 
	gfs2@lists.linux.dev, ntfs3@lists.linux.dev, linux-xfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zhangshida@kylinos.cn
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _IWOFO87rC9WgEyXn9PpkaagbpfxBg7K3UmfqeB_gO4_1764335490
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 28, 2025 at 9:32=E2=80=AFAM zhangshida <starzhangzsd@gmail.com>=
 wrote:
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

