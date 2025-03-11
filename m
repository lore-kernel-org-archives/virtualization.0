Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5FE1D5CFB;
	Tue, 11 Mar 2025 05:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741669380; cv=none; b=mScJjDVgf1qMpQukVShhdEQicHBdak9CxsdNzwWJnhsHK9FdlGZz8+iOwIqnLwsYtH8yALZ0f7Iom5ZIWyMeeV4wW77L65gUGicooZjg/WwJFvl9VgJl5BTPppNrhi0hDikV5/SWWQyOdcOAFjzmZBwtLmdQQFHlGc1dDKNRbOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741669380; c=relaxed/simple;
	bh=3ECEa2t9d5y92Pz32OnF3QpiFge1TDTBvaI3574/zjY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yvt89uwbLkCogIpB1VcJHpp2IMOrlMPfR/3xqP4LMNgP/FAyE/nYqTzPsIn3b8+1pgS2sfEOru6fQT0C3haUVUVqoTrFa7bsdVgNVoXQiEigTOM+MuMpGStg9mHlDPq/XlDYqzmdX63MD/nIV+VOL+i3QiMOf9/x2AWSjYf6nJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K5LyfFdg; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K5LyfFdg"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5e5c9662131so7628016a12.3;
        Mon, 10 Mar 2025 22:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741669376; x=1742274176; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nU3DsZ1XAulR9Bt1UcDHguhYwisbNbjiLIOTrtdFyTk=;
        b=K5LyfFdgbbwMAwHvVWAaKdt4fRHbUXJIgIp1VGYvBSMHguekb8neBxvuumf+WCaU6p
         hVwVWYah9gsjHQCCh92wIHRudkYVV5VM4qjJFgazSdBbhaEE0KsRWAUViCT99ZLK+M91
         EjFox0ohPSJpJFSpyuK/nEu6M6LPkLNRRr49foLOzImnKvwGL2YLVWYRyTc16d4cQ5sC
         1w/TNH+JiL8+mMbY3daxRcqxfSug+mUPOyopRQ6Gm0Yu35Altzrpsvy/q5AbKAtrBMBV
         0JUSF/uiMI8Bh1y4AwhO08sZ1RbHp6u8X0/JfXwHp5g1S4XFOY/uG05Ka6dOOaS7z9J5
         8BiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741669376; x=1742274176;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nU3DsZ1XAulR9Bt1UcDHguhYwisbNbjiLIOTrtdFyTk=;
        b=Jfq6xSvDkNrKJbWnDyI30lMaavt1OdRpJVBNFBB+9gysuWvaeNEFrnqHh1jQDvxJHr
         SthOcd1VP6nbgmwkAM8voy6jlMGwjF5T9O5VU1y9Junt8riOZZz8eLtp0XaIGEewMVrQ
         sLZC3zw74rD2M9upxkimc1MnQcECK5GpbTeQ+m9/O7uCQlri/Bra47HbV/hjFvYX6wPF
         3UkCcCHSNTQ21TH7wG7QQbNyBXxOSfOD4RjyV6e1J4nm8PkFiJ/pWiSdmAlDm0tK9wk0
         AkRRHwsf3AK/vhhR9ehGe6T5gdgtLW9AVPFvDbH2HkBRricbmODmZxPew7NHhj6irLVz
         sEag==
X-Forwarded-Encrypted: i=1; AJvYcCW7Y7H+AdEQ9gsfh871n5VLICaYGivuJy/bUhQmdEkA5XYaxpX0e43jfcyW/sQVp9+PQDHEpnu2y0eWSo6fD0g=@lists.linux.dev, AJvYcCWtRCFzNQzDFs4GbXHTp8KidsVU5EcdH4c/l3TDPPK9hOAevCT3M8lLXCHtYZEVEgqrtvwGZw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy0jKFyJnw9zfo0690v2jJJwy4NFGNO8nWBTz0D+hA+7SbtApU5
	6fxrDI80fKEGflrH2T9i58UmXQUbJB7d9FzbvqLtP2Z+pyw6FF51oNIgYNpmGbEj8jBalPLni4W
	W0Ve2Z6y1qBHIkVDH4nX6VDftr8g=
X-Gm-Gg: ASbGncug2YG5ICKijq6+gT8VzcTQWvqlFCbX4oDWvmZqXRnIIqoevElbT+g6qBgo0+g
	IY7JNtbHKnH1aEG6HZ5J28sv2EIPuycKk1r+GjJI/AaGLxzXlyeuE3L0bSndSGQ9XUFWsYa6oed
	boK2JkICgwAQzx1ateeAQ29PSrQA==
X-Google-Smtp-Source: AGHT+IE7p9ESJhaRtmTdHGCk8dKC1MDYNTTHcp542UMCynAJicglEY62j02PsiPON63nvymsVjYo1GJqTYgydaJ1MSA=
X-Received: by 2002:a05:6402:13d0:b0:5e5:c5f5:f5b with SMTP id
 4fb4d7f45d1cf-5e5e249af7bmr18994497a12.26.1741669376163; Mon, 10 Mar 2025
 22:02:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250311024144.1762333-1-shinichiro.kawasaki@wdc.com> <20250311024144.1762333-3-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20250311024144.1762333-3-shinichiro.kawasaki@wdc.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 11 Mar 2025 13:02:44 +0800
X-Gm-Features: AQ5f1JqbCkxhn7T9fgxWWXH1RylAmKuYJRnbUWmBaNKkk8A2xfV5IxO-QOVV2tg
Message-ID: <CAJSP0QXZQWSVV60SWDey7i55VqAw7H+W9mQZ1uQyeOLK4TounA@mail.gmail.com>
Subject: Re: [PATCH 2/2] block: change blk_mq_add_to_batch() third argument
 type to blk_status_t
To: "Shin'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
	Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, 
	Christoph Hellwig <hch@infradead.org>, Sagi Grimberg <sagi@grimberg.me>, 
	Alan Adamson <alan.adamson@oracle.com>, virtualization@lists.linux.dev, 
	asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	"Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Sven Peter <sven@svenpeter.dev>, Janne Grunau <j@jannau.net>, 
	Alyssa Rosenzweig <alyssa@rosenzweig.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2025 at 10:42=E2=80=AFAM Shin'ichiro Kawasaki
<shinichiro.kawasaki@wdc.com> wrote:
>
> Commit 1f47ed294a2b ("block: cleanup and fix batch completion adding
> conditions") modified the evaluation criteria for the third argument,
> 'ioerror', in the blk_mq_add_to_batch() function. Initially, the
> function had checked if 'ioerror' equals zero. Following the commit, it
> started checking for negative error values, with the presumption that
> such values, for instance -EIO, would be passed in.
>
> However, blk_mq_add_to_batch() callers do not pass negative error
> values. Instead, they pass status codes defined in various ways:
>
> - NVMe PCI and Apple drivers pass NVMe status code
> - virtio_blk driver passes the virtblk request header status byte
> - null_blk driver passes blk_status_t
>
> These codes are either zero or positive, therefore the revised check
> fails to function as intended. Specifically, with the NVMe PCI driver,
> this modification led to the failure of the blktests test case nvme/039.
> In this test scenario, errors are artificially injected to the NVMe
> driver, resulting in positive NVMe status codes passed to
> blk_mq_add_to_batch(), which unexpectedly processes the failed I/O in a
> batch. Hence the failure.
>
> To correct the ioerror check within blk_mq_add_to_batch(), make all
> callers to uniformly pass the argument as blk_status_t. Modify the
> callers to translate their specific status codes into blk_status_t. For
> this translation, export the helper function nvme_error_status(). Adjust
> blk_mq_add_to_batch() to translate blk_status_t back into the error
> number for the appropriate check.
>
> Fixes: 1f47ed294a2b ("block: cleanup and fix batch completion adding cond=
itions")
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> ---
>  drivers/block/null_blk/main.c | 2 +-
>  drivers/block/virtio_blk.c    | 5 +++--

For virtio_blk:
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
