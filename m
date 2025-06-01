Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7AD43AA4
	for <virtualization@lists.linux.dev>; Sun,  1 Jun 2025 10:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748772105; cv=none; b=TsoaDUjO3kIAIrAjeL9b9DN8nMGDfcW0F/KCIRNyP4fSQ5dNB2p+OrewgNkkaz2x7fiuOEpF1+YZ0tkDJoTHvWwUqnq4MvRjodWaShPTC48yCKBl5LacUFmrBxR3O6oe8xP47Dj7X6A2oqRWiV/g6N3S3WVqTN7dslD0i9KXLYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748772105; c=relaxed/simple;
	bh=HAqqkQhnXVAKzdrtZyr3RRPBA83EYmLyR4lq7hAUb2g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aL1nEQemSREpCv7beBkv0msXpd8AWso0gYLanrOoAWvI1Kmyg5IZYzsBdHgBWK75mtAuTV7JFjFrLq5cu7nzmC37mdSZynmvluIEKUJCZoMT0YKTg7eHXizHx9Tzbs4sa7CdeStJhNpPHy1Y5quuS+q2F5OyvTpfYiFiMkjR4N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gjE/h2cV; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gjE/h2cV"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-54e816aeca6so4540651e87.2
        for <virtualization@lists.linux.dev>; Sun, 01 Jun 2025 03:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1748772102; x=1749376902; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6fPiywOSKETPbwSw1Rvi5wLhnJZFlc7Zk83IPpMxs9o=;
        b=gjE/h2cVrKBv1FwhUp4SS5FG+PBQxyfVL2PjQVfKm9CUQFn6FCxkq/HfUKyBPXew9Q
         mia6W+l6SLTs0TxV5KdMbCvfmWY9pGFVXkM+Ut69X7fWXBxRh/YnXlCTPutxMCgZcGeO
         u158O+jd230ywWl8Y93xwnNBUaAA9MkaqfDfk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748772102; x=1749376902;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6fPiywOSKETPbwSw1Rvi5wLhnJZFlc7Zk83IPpMxs9o=;
        b=Y/kZzwt1HLvzWLZV8htikEYuI/igAFkeh2LSlifzGdSBtDtam6FJFsDxZHsZtjYucH
         rwXuXHCdqYmJZxCyPW4Gh0jcelF1DftF7luKltsGfY9gtOd3TfNZ7CkTdD9epd3zy+yt
         T0rcy+y+0yRayFZmUHdte43m9zSRf7XpkIjZqPh+RAviYxQhEukda72m1c3eiq7QU1E8
         YwD10M1aZwJyN01cYBzC6J85Wc+EFAgHyi7WS0yELa2Op+11/iUswxe+RR4slEnB6bq2
         hHngSAVv0SUgqNPiBS8PsHRyjImxmwtXeM3/NFQ2+eHGZRCp07gaRiWU2X1fg0322YnQ
         Xcbw==
X-Forwarded-Encrypted: i=1; AJvYcCUmXUUVECvFmCPblj1r++CjyeVxRHkNWHLeTMdGfUk659mwTGOf1skehlqY+ahP+CI3K+oax5digh9W2NfSuw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzCY2h1qeN+ZQM4XPUWLAdvl/tclV6LSEQl4WjX0o/ql07Xjrha
	m/UATUS1vnDTgmZQ8JnafufcFBGWUWWthIR+pUGpwTvT5wlw/z6CFfP/fW3glPG6QXUOby8giLz
	SdRk=
X-Gm-Gg: ASbGncv9M+RXY99z+bxH8qQgqu1iQtnd69j3bjpQ0u2bo7Mvl7CqpVMO/CMaVurDKuB
	VvxY4UaC7bEQFlkJtOTlfCpTO2I6NfH7BQss+g3ZX7j47qqQwy2EiV78fWXgzUZZqIayOGiX0H8
	JdDZ4WYF7+K4iFYqpQdsO9mWF+oxxWIi4m4qgwAwZMQaKrJYTUSMcJ0PzAPMUvFgU3xyXjy7yw3
	DPFavL26W9DegNgnxIqK6EugLI5myfRwcXJmtM5cV56/qha50ZjzdzkUdbaTuQ2b8100rQgw0Ff
	7QNWO+hzlCiEEJfqyKDHvwb7/p5QAhaDexV10NZDjMW2ZyXnnlKGAL9gG9HjmajaLsHR0ScF5UY
	n4BejGzrj3UErr1grrE6Ji4rr
X-Google-Smtp-Source: AGHT+IHggKlKA54uT7Tm59AOvzqIjUCASJOEitw4lTzjRFFLyS/hu0l/44xao/N/F4jF9Id1Z1/lLQ==
X-Received: by 2002:a05:6512:b12:b0:553:29a9:64f5 with SMTP id 2adb3069b0e04-5533b8f3ed0mr2950024e87.22.1748772101817;
        Sun, 01 Jun 2025 03:01:41 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5533789ff36sm1240091e87.60.2025.06.01.03.01.36
        for <virtualization@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Jun 2025 03:01:36 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5532f9ac219so4031257e87.1
        for <virtualization@lists.linux.dev>; Sun, 01 Jun 2025 03:01:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUEujJgpzGxI0u+VPN8d9hBR515gI0+SB55Hxq3qhv3Boeq08DH8gEgsivolWx1UAKjsnrPeAdgujrFqPytLQ==@lists.linux.dev
X-Received: by 2002:ac2:4c4a:0:b0:553:2418:8c0c with SMTP id
 2adb3069b0e04-5533b93b8e2mr2836561e87.57.1748772095532; Sun, 01 Jun 2025
 03:01:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250412-virtio-media-v3-1-97dc94c18398@gmail.com>
 <CANiDSCsmbiveo4GHX54_q7-1CeKiDAVaGnb8+jsCybM+pyA7Fw@mail.gmail.com> <20250601113425.4d5a3d89@foz.lan>
In-Reply-To: <20250601113425.4d5a3d89@foz.lan>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Sun, 1 Jun 2025 12:01:22 +0200
X-Gmail-Original-Message-ID: <CANiDSCt9nGP=r8VxkZH76a1i+xEd+RCJ71=6qx0_iPYdrn+GoQ@mail.gmail.com>
X-Gm-Features: AX0GCFtIPDaP18bEvuALb1ut3l5M3rfFZRAycu45EQi_pjllJ8ZUhbJMMnQNECo
Message-ID: <CANiDSCt9nGP=r8VxkZH76a1i+xEd+RCJ71=6qx0_iPYdrn+GoQ@mail.gmail.com>
Subject: Re: [PATCH v3] media: add virtio-media driver
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Alexandre Courbot <gnurou@gmail.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Hans Verkuil <hverkuil@xs4all.nl>, Albert Esteve <aesteve@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	gurchetansingh@google.com, daniel.almeida@collabora.com, adelva@google.com, 
	changyeon@google.com, nicolas.dufresne@collabora.com, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	virtualization@lists.linux.dev, Alexandre Courbot <acourbot@google.com>
Content-Type: text/plain; charset="UTF-8"

Hi Mauro

On Sun, 1 Jun 2025 at 11:34, Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:
>
> Em Wed, 28 May 2025 18:23:02 +0200
> Ricardo Ribalda <ribalda@chromium.org> escreveu:
>
> > > +static int scatterlist_builder_add_userptr(struct scatterlist_builder *builder,
> > > +                                          unsigned long userptr,
> > > +                                          unsigned long length)
> > > +{
> > > +       int ret;
> > > +       int nents;
> > Could you initialize nents and sg_list?
> > old versions of gcc are a bit picky
> > https://gitlab.freedesktop.org/linux-media/users/ribalda/-/jobs/77042562#L4381
>
> Please don't. In this specific case, ret is always initialized:
>
> > +       struct virtio_media_sg_entry *sg_list;
> > +
> > +       ret = __scatterlist_builder_add_userptr(builder, userptr, length,
> > +                                               &sg_list, &nents);
>
> nents and sg_list may or may not be initialized at the function,
> but initializing it is wrong, as, when they are not initialized, the
> ret code shall catch it (and if not, we *do* want gcc to warn).
>
> So, if our CI is warning about that due to an old version, please upgrade
> the version at the CI runner.

The main version of gcc works fine. It is the minimal version (8.1) required by
https://www.kernel.org/doc/html/next/process/changes.html
that  complains.



>
> Regards,
> Mauro
>
>
> Thanks,
> Mauro



-- 
Ricardo Ribalda
