Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CCDA329C5D
	for <virtualization@lists.linux.dev>; Fri, 28 Nov 2025 12:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764334660; cv=none; b=j3W7xYFs1zX6FS9sL6W0QQ5QUYh1bkvH2zmAKvFqcxi4usSHfPabONORwOvO/H3WHJ8cLtosTZeV67FXB2mWE6Y4fUBB07vtB5e3cjaraeUKoiW9GKWcuFNU5oGw+UqJ3WaWL0TQaQnSUIQ/bc6hW/DT2IEevzT2OUiE38Wij3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764334660; c=relaxed/simple;
	bh=77RRIbnmoJwy1cEKeO1cRn3JJgXHE29OKRRM9cIvMcc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W163E26jyDyc9cM9DD3Er6Lc/VcAnWS29XcGrLbeyuAtGSRAPNGfKff7wUh/TjFAOdNSZheBP1hRHkYIM80l4RNk7shx35zFut/+uuxxyXk0XtWL8XtKQv/mvb0QZcdVk8FEDbUnvtN6AzgY9nuWaVPaP8iKaeEsEexXTDp4OqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eqGtPdEJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eqGtPdEJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764334655;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k2NUtFfF9SbHj+pN5h7ZLsSymt83AD97eoXiZYz42dA=;
	b=eqGtPdEJ27UP49AIWSoGhqx3ahsyvnrQiOQhYP1ZdyQwTXcEviCdg6ZNVKwpUbnqreNB9f
	qZ3RdIPMgWU5nzNRfCaCAksCgGIhROBnVFjWZZ58I2kb0DhIlAIDIFfZXIMaZJL89uO9PP
	sRmQBWHdY3mROQAuySMyzMetrhn7IY8=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-258-r0EsTXUkOSmwJ7-mi4Z8ww-1; Fri, 28 Nov 2025 07:57:34 -0500
X-MC-Unique: r0EsTXUkOSmwJ7-mi4Z8ww-1
X-Mimecast-MFC-AGG-ID: r0EsTXUkOSmwJ7-mi4Z8ww_1764334654
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-78ab0ef3673so24315187b3.2
        for <virtualization@lists.linux.dev>; Fri, 28 Nov 2025 04:57:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764334654; x=1764939454;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k2NUtFfF9SbHj+pN5h7ZLsSymt83AD97eoXiZYz42dA=;
        b=YPKFMzHl+uGtfsJV5ijqqnCn67ntcgbEUaEYWKb+DP82fQFHZwDDoOSBltv4hG6a1h
         SNX4wNBGyG/vFGNTxtPKm18GePhe+BK0IFnV58B5SxOSs6PpZ1+wwZV4CsVxCGS+CfrE
         ZeEfQvPBRt8epi/RijyO1PKGoQKGM4ogZd9dgibCbokvFJG9RDYuj21A3zDQgJIo1UvB
         4e9v9sLNbV12VA7r5uSSJJ5bDEL3MlGpX1M6Q1fKSHO1FFKwZihiHgtU3bGT+krOkdW5
         /piRQlD6V0T096GJF9OtRkCPgdQ+gadJnlQxi6ZZjcfpupoL0QC8rCmMU2uxdHowUkOt
         U6Tw==
X-Forwarded-Encrypted: i=1; AJvYcCUdplmN/ihq12O2dHKjRWlVC4G5NVxWQrzhD8t1zAfHUq1buid/57kMpwjS205qolgrEG0IqRcxgDPoztsamg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwXV5+5wNDMQqIRHIyoPsw7STlwnKfetMaTETW2beFHO27ZGUf5
	ADygzDhGShv+uYSxmZySGtxBqtR/W0ey6tMfPb+O2mBfXazIUw15+Mod0orc29uMfy0ZiYyV85Q
	12O8p8/Ykz+Jj8duApZY2qOpw3FfRWgZPrK6Un2WhWBvzOyuMofMvEUaDNdxRrWPEc1BBoTAmhp
	w2WxxjTVuuU3UpUQD156PgpKcRvhETgOuwsJNkpF1WoWk=
X-Gm-Gg: ASbGncuUgSm4/K1N8P3LCvOmTsD4xSZ5q/Nbta/3W1j+KoIA4RFsw7QNLuEDFVmw37z
	X8owx3cgfzpDVD8bhErHu6y3bwzxj/o/4FveITDrde80Ms3LHw/y/DtgtR8+w8ieGfWgVmc3oIj
	mTC8eHJzXZWYcjB48zzpX5fxrAW8dhdhu9pIvG0yX17wCS3kfMJb4D7QquqrLrdfzz
X-Received: by 2002:a05:690c:3348:b0:786:a967:5a8a with SMTP id 00721157ae682-78a8b521351mr209364497b3.51.1764334653925;
        Fri, 28 Nov 2025 04:57:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFYKB1oLuPGJAVoxdwBsDfFu85nnaWrR7frU4rGijoJHAkyVO4VlXEEBnQXgKFqXNy1QVvTkGpWt9+fdpViZKM=
X-Received: by 2002:a05:690c:3348:b0:786:a967:5a8a with SMTP id
 00721157ae682-78a8b521351mr209364247b3.51.1764334653580; Fri, 28 Nov 2025
 04:57:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251128083219.2332407-1-zhangshida@kylinos.cn> <20251128083219.2332407-3-zhangshida@kylinos.cn>
In-Reply-To: <20251128083219.2332407-3-zhangshida@kylinos.cn>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Fri, 28 Nov 2025 13:57:22 +0100
X-Gm-Features: AWmQ_bncrRsjrklAzt9B3bsSktqMzFJHIbAcDYZydnWE535duaAjUcuyPEWTG9Q
Message-ID: <CAHc6FU53GR-FTPzWSuxQumJXX7z6HrzFGo5=kfA1VHt3KxwNOA@mail.gmail.com>
Subject: Re: [PATCH v2 02/12] block: prevent race condition on bi_status in __bio_chain_endio
To: zhangshida <starzhangzsd@gmail.com>
Cc: Johannes.Thumshirn@wdc.com, hch@infradead.org, gruenba@redhat.com, 
	ming.lei@redhat.com, siangkao@linux.alibaba.com, linux-block@vger.kernel.org, 
	linux-bcache@vger.kernel.org, nvdimm@lists.linux.dev, 
	virtualization@lists.linux.dev, linux-nvme@lists.infradead.org, 
	gfs2@lists.linux.dev, ntfs3@lists.linux.dev, linux-xfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zhangshida@kylinos.cn
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _7gJxHadVl3Ou9YlVWa9bv5OoUJtqCTXbD9gVbRGpaY_1764334654
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

