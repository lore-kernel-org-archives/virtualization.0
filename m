Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9AE27C84E
	for <virtualization@lists.linux.dev>; Sat, 22 Nov 2025 06:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763793802; cv=none; b=VxV6JasQBlM7IxoAZn8Jx+tDzsZ1BB5erOBXoYncdPgtqqR6xR5UTJ6YU5BgLEQc5RgPfG9nxeTKriwFFDVZ0VXogn2f9gd7EUADLglQPVY1Upw4Xp7kvPgSgCaSlhcErWoXmN9N+z22XE1Msty5sjV/y/e2HQIer0PyzbsmqYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763793802; c=relaxed/simple;
	bh=Y+DjqwAoCGZ7OJzLzIWqwIR/VPRlxdq59cBm2nqE3Jk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=By5UMPjgJEqVFZgAqrjH0WPpU7NN4Cma0hwe1yj9ll/lp+wVNeGbN/wYaoSk053GKI+H3hQ1SxLKI9vf+wlSMiGdvC+YuZcyEvBFKNmAuJty0Y/a25Hf4prXuEch/w/tyV4yTPiv2l+dv+DBQSbSXOhie2LoFbY1qREilQoIr8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G+slzDOh; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G+slzDOh"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4ee14ba3d9cso26485021cf.1
        for <virtualization@lists.linux.dev>; Fri, 21 Nov 2025 22:43:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763793799; x=1764398599; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n7QJI36T3DDFp93Xllsfs+3f9Tem0cMaXaPpBr1xsGU=;
        b=G+slzDOh1BvP23+OxTF1L/e5HLikMbIJLq2M5C4LdIA3w6Y9izCgHgKajG1PBXVRKj
         bxf9W1ywGugnrgY0oKms3lm8CNPEDUDry828EjlVkpxTsXy7Q1URDAyOmu2jO59tdpSx
         Ei3hralYrTCQlUx41/nPWc2qMKl63vZi7lT0tCSc7JpR7J9Rw4vv2ZCJt9Epc7Y//5KB
         /yXNvfLk98FlPJJPZ4b2dHXLOO/Cc6Ho4jt3ZbfSfHlUs6XdWvCx6vp9qUo8zZ7gy4RH
         ufNdp8hqkWg6clrUFVdaLNoBmTwlkAFiZ/QhPWw7A0OTaEGZlcginxKr9h1LcxUbSP8u
         sasg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763793799; x=1764398599;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n7QJI36T3DDFp93Xllsfs+3f9Tem0cMaXaPpBr1xsGU=;
        b=r3azn9xX2cJNPeygCWnLhXQO7GEhkU+Zr17HNtwRS5IYvLq2BdDxzB4RrIovOR6caE
         /mxXtgcmHBDJ3ZbvuOynty2pyDfKtRbp9g9l+VPhH2+yuEVdvCWKXGIHXWb6X5BtZbu1
         l8Z5i9efV2jTeCgs/Bmyf7tN2E837D8fhchWOPrJ/CE6McP2xc+O2oUnJ1AFei1wk8eE
         1PPu6PApwYN4UHVH9NvYXIPcgTiC+68nedRHSX2/VL4CYbyvJTQHiyBCNPO65LWrK82W
         CQ9scZdEF95Lqbfn3nj5eqrV+oCjpIP84lP5QQA2NdcdBdyrXJKrPQTA3JXixuITjGNi
         W7JA==
X-Forwarded-Encrypted: i=1; AJvYcCXpIQcT/7HuYVkUMIi10CgAnJYcEURX27GoKlY3XBeA6D4Gycx9kCmkBk2iFd09xuDf8TgDBtd6nzktFdR6pg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwmSUPsjVOMTYhISfrbgtAJQO7NDLmXNMQMH7fGnV8Qz0LAALSq
	uVyXc8uV7j7y1efX2cWjqS9nqDQpH0Q7leF/noKOqcRoSlMRwwd9nWER1hwpjR9vONtkw9/82ON
	E41qT3xdF88TAdgBhIRmDIEqOnYzH5dNAzXbkolg=
X-Gm-Gg: ASbGncuk4yLgh+oDoCwTP19eecmzi4QZmeCpWsrb5Qnw9bSzr0KJFBPPQALlQrd3MNJ
	1Do7TS2GRtYzdcRxsQVJZAGE4PkEMgD7W5dwAjCuzyzoVAg53AMaQ1AQH0yhGErqQI3YJLzL18v
	6XMdqTlH/Jkj/TaY2r93/8rvHRlFgk3mS1H+kjVHy2I3oon0SX/gjT3h/DNM2F2a2SBEJvE4/dX
	dDJFY+7J88xTETvXugrYg6MSZ9fe7D9ynQ52GyLvm+xWdPdVeYnY1t/bpb+mecXmNmpx6A=
X-Google-Smtp-Source: AGHT+IFYY0hB1AT6+W29RBnT+t78nVJtbCkr0AJ7fjgv+YE4gLfc5ZYb5TuO0P1olfjrCgZ/JHFnyc+OtjdZpbL7HYc=
X-Received: by 2002:a05:622a:653:b0:4ee:1301:ebaa with SMTP id
 d75a77b69052e-4ee5888fd9fmr61705651cf.54.1763793799235; Fri, 21 Nov 2025
 22:43:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251121081748.1443507-1-zhangshida@kylinos.cn> <aSEvg8z9qxSwJmZn@fedora>
In-Reply-To: <aSEvg8z9qxSwJmZn@fedora>
From: Stephen Zhang <starzhangzsd@gmail.com>
Date: Sat, 22 Nov 2025 14:42:43 +0800
X-Gm-Features: AWmQ_bntN_rMHyZMaZTesMCRvMp7VgMi9_ZfkRlzVtT_jBUQrddcI4xac8nvuc0
Message-ID: <CANubcdULTQo5jF7hGSWFqXw6v5DhEg=316iFNipMbsyz64aneg@mail.gmail.com>
Subject: Re: Fix potential data loss and corruption due to Incorrect BIO Chain Handling
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	nvdimm@lists.linux.dev, virtualization@lists.linux.dev, 
	linux-nvme@lists.infradead.org, gfs2@lists.linux.dev, ntfs3@lists.linux.dev, 
	linux-xfs@vger.kernel.org, zhangshida@kylinos.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ming Lei <ming.lei@redhat.com> =E4=BA=8E2025=E5=B9=B411=E6=9C=8822=E6=97=A5=
=E5=91=A8=E5=85=AD 11:35=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri, Nov 21, 2025 at 04:17:39PM +0800, zhangshida wrote:
> > From: Shida Zhang <zhangshida@kylinos.cn>
> >
> > Hello everyone,
> >
> > We have recently encountered a severe data loss issue on kernel version=
 4.19,
> > and we suspect the same underlying problem may exist in the latest kern=
el versions.
> >
> > Environment:
> > *   **Architecture:** arm64
> > *   **Page Size:** 64KB
> > *   **Filesystem:** XFS with a 4KB block size
> >
> > Scenario:
> > The issue occurs while running a MySQL instance where one thread append=
s data
> > to a log file, and a separate thread concurrently reads that file to pe=
rform
> > CRC checks on its contents.
> >
> > Problem Description:
> > Occasionally, the reading thread detects data corruption. Specifically,=
 it finds
> > that stale data has been exposed in the middle of the file.
> >
> > We have captured four instances of this corruption in our production en=
vironment.
> > In each case, we observed a distinct pattern:
> >     The corruption starts at an offset that aligns with the beginning o=
f an XFS extent.
> >     The corruption ends at an offset that is aligned to the system's `P=
AGE_SIZE` (64KB in our case).
> >
> > Corruption Instances:
> > 1.  Start:`0x73be000`, **End:** `0x73c0000` (Length: 8KB)
> > 2.  Start:`0x10791a000`, **End:** `0x107920000` (Length: 24KB)
> > 3.  Start:`0x14535a000`, **End:** `0x145b70000` (Length: 8280KB)
> > 4.  Start:`0x370d000`, **End:** `0x3710000` (Length: 12KB)
> >
> > After analysis, we believe the root cause is in the handling of chained=
 bios, specifically
> > related to out-of-order io completion.
> >
> > Consider a bio chain where `bi_remaining` is decremented as each bio in=
 the chain completes.
> > For example,
> > if a chain consists of three bios (bio1 -> bio2 -> bio3) with
> > bi_remaining count:
> > 1->2->2
>
> Right.
>
> > if the bio completes in the reverse order, there will be a problem.
> > if bio 3 completes first, it will become:
> > 1->2->1
>
> Yes.
>
> > then bio 2 completes:
> > 1->1->0
>
> No, it is supposed to be 1->1->1.
>
> When bio 1 completes, it will become 0->0->0
>
> bio3's `__bi_remaining` won't drop to zero until bio2's reaches
> zero, and bio2 won't be done until bio1 is ended.
>
> Please look at bio_endio():
>
> void bio_endio(struct bio *bio)
> {
> again:
>         if (!bio_remaining_done(bio))
>                 return;
>         ...
>         if (bio->bi_end_io =3D=3D bio_chain_endio) {
>                 bio =3D __bio_chain_endio(bio);
>         goto again;
>         }
>         ...
> }
>

Exactly, bio_endio handle the process perfectly, but it seems to forget
to check if the very first  `__bi_remaining` drops to zero and proceeds to
the next bio:
-----
static struct bio *__bio_chain_endio(struct bio *bio)
{
        struct bio *parent =3D bio->bi_private;

        if (bio->bi_status && !parent->bi_status)
                parent->bi_status =3D bio->bi_status;
        bio_put(bio);
        return parent;
}

static void bio_chain_endio(struct bio *bio)
{
        bio_endio(__bio_chain_endio(bio));
}
----


Thanks,
Shida

>
> Thanks,
> Ming
>
