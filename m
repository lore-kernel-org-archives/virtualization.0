Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A02CAD4B
	for <virtualization@lists.linux.dev>; Thu,  9 Oct 2025 05:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759988755; cv=none; b=mYj8fOuOibHhyAC72gK00bkR0yMJNn2Xv93JCXZLWXv3wW5VDDGVmSFG/xktHaoPtsL+94IZMZZSZee1kCFnotpwwlGvbW7qJ+FHitKy5Vej/Xwy6luLlImEAU+LhuEQjYSJgdB2AdqjextiPcCVSGhNPMiyr3phDVIWn6tmFJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759988755; c=relaxed/simple;
	bh=Cgs5/82pfRdFOfycNZ7ouFWHQSrCRVqg6S+KdryAJEE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tf3kAJLZaqN4Iw0EJ1qgyX5COrE1MIPm1WIiZEDozEqKkOMneYbUwsTqFpOmQv8wAfXdsJ0UX4oT/f5QoS6lPc94Cb2dXYGeLogtDzBqUSI9/wfR00y5pG4XDNbb9y4gFRvxg8iojMARkfew5kmP3xruHFC/JqBFBpXkVVlDRAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e/7uETVd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e/7uETVd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759988752;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=orcYfgdpG/ZGGYwoentBQb80+LYoN5XSkiV8KV8rfJo=;
	b=e/7uETVdDZldu/ANFh5vUWnDwdP0F1qfHx02FUynImBZVBzNS4LDkUr4TN0bd/TyYOBTas
	ODd8/mFhftR1FMri4A4+XHRoNVAXeZBnMd5wfDnfBAx6fQkv6RpVrllou8AKzaoB40RMf2
	B0diIo33dsRwrKMXajAANShZGTEsqsA=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-416-V04o1G8NMVSks5JqucsLsQ-1; Thu, 09 Oct 2025 01:45:49 -0400
X-MC-Unique: V04o1G8NMVSks5JqucsLsQ-1
X-Mimecast-MFC-AGG-ID: V04o1G8NMVSks5JqucsLsQ_1759988748
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-8f7f2a191ccso3580382241.0
        for <virtualization@lists.linux.dev>; Wed, 08 Oct 2025 22:45:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759988748; x=1760593548;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=orcYfgdpG/ZGGYwoentBQb80+LYoN5XSkiV8KV8rfJo=;
        b=Rj7nkS2ANn5MXAeVBRNQ2ImazFLnATgGVMGDgE0kGFI7UlguN+gdvyF624YSx3kNQK
         ElcaEZXhcdVsxT3olMMbGoQU33c9co9yPEklf4V4Iu1P9Om4BhXznrexDSgdh4ApTjT0
         HIe9JHeZoOf4xQVraYtjqfUh3jismn64JqNUMFymz+Hc2eBxtZHru+9kYhqpkSVcx3xt
         p/e/Qlx5ocDzmRiRRfV41FGUNZCrqp9TsumU0O0XoUUnnwB0LTklXcIw1335LoyNZGkk
         S8ycWSUcWkd8M7iWAokM1+TFFwzQIRcMmj2TWWcX3Vl6VpqEkA4TsEN0cM0MTYbw3lEX
         g39w==
X-Forwarded-Encrypted: i=1; AJvYcCXOpwElwJILrgydJYLFEunaVhnAFYEAAdrP1BUn/tokHYZYUa6+ungnBr6vP+DuQKfZbWzhR6nzm9xo5jQv5g==@lists.linux.dev
X-Gm-Message-State: AOJu0YyQ6w/2CgTxubiZyFvbiH5gDH1YqVUgvPQsRx3YZp8oB1jD0VPu
	bYWAn299mkRWUZ1C6I69qZfL1gDmRZMYMeH9Mgt6JijS5lvI2TX74qTJVsUGwFg9+2vS+g3Qjeq
	2iGIhwC0qgkAn1kKf2U2CgF7UoysAtTKSm+MJyupTRIKF9/PmO2iBt7jpG75BIoAA2+2/dHErlb
	iuja8mIuscRySRvBbWhoxL6yGXrFN71dlgT1vwhyU/2QQ=
X-Gm-Gg: ASbGncupwZ9eZKF5N/v2WzHF/f1eotp+bamrIFHNaMwfTzcLvQ3XCUXAWPSqyYybi3+
	Gcn6I9kDdIqcETp6PL994AQab3ywD2rD4C0A+DwW16wBe30U8JyW50Wn4DcayINSRNZv/6WOt1+
	vNTS05SnvSZJkknRSPGT9msIc5KUU=
X-Received: by 2002:a05:6102:1a06:10b0:584:7aa3:a329 with SMTP id ada2fe7eead31-5d5d4c81309mr3856074137.4.1759988748527;
        Wed, 08 Oct 2025 22:45:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3G8kAFYaXC6ufiRYos6wQXP8+qHlI6XHMSGOom3zuceYwL+hPPQed85kXtqvFgON80O528fdCfB3/9TPXj90=
X-Received: by 2002:a05:6102:1a06:10b0:584:7aa3:a329 with SMTP id
 ada2fe7eead31-5d5d4c81309mr3856068137.4.1759988748195; Wed, 08 Oct 2025
 22:45:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250929134258.80956-1-alok.a.tiwari@oracle.com>
In-Reply-To: <20250929134258.80956-1-alok.a.tiwari@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 9 Oct 2025 13:45:36 +0800
X-Gm-Features: AS18NWAJIasEWYyFtU2lfrqbz_3g5EECFeIzi1irlKeHZRF9-ZPVkvavqWabGu4
Message-ID: <CACGkMEvyh9CBHjQs6bYv8v-DVYGizjOrVMuFVsnnrJeN6kTrfQ@mail.gmail.com>
Subject: Re: [PATCH] vdpa/mlx5: Fix incorrect error code reporting in query_virtqueues
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: dtatulea@nvidia.com, mst@redhat.com, xuanzhuo@linux.alibaba.com, 
	eperezma@redhat.com, tariqt@nvidia.com, moshe@nvidia.com, kshk@linux.ibm.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: MQtSdWTimakH4DyAJWnpFZfvZObzLi2HtyIZOOkl564_1759988748
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2025 at 9:43=E2=80=AFPM Alok Tiwari <alok.a.tiwari@oracle.c=
om> wrote:
>
> When query_virtqueues() fails, the error log prints the variable err
> instead of cmd->err. Since err may still be zero at this point, the
> log message can misleadingly report a success value 0 even though the
> command actually failed.
>
> Even worse, once err is set to the first failure, subsequent logs
> print that same stale value. This makes the error reporting appear
> one step behind the actual failing queue index, which is confusing
> and misleading.
>
> Fix the log to report cmd->err, which reflects the real failure code
> returned by the firmware.
>
> Fixes: 1fcdf43ea69e ("vdpa/mlx5: Use async API for vq query command")
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/ml=
x5_vnet.c
> index 0ed2fc28e1ce..b2ebf56b2ea2 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -1258,7 +1258,7 @@ static int query_virtqueues(struct mlx5_vdpa_net *n=
dev,
>                 int vq_idx =3D start_vq + i;
>
>                 if (cmd->err) {
> -                       mlx5_vdpa_err(mvdev, "query vq %d failed, err: %d=
\n", vq_idx, err);
> +                       mlx5_vdpa_err(mvdev, "query vq %d failed, err: %d=
\n", vq_idx, cmd->err);
>                         if (!err)
>                                 err =3D cmd->err;
>                         continue;
> --
> 2.50.1
>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

