Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7627914293
	for <virtualization@lists.linux.dev>; Thu, 12 Sep 2024 14:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726152640; cv=none; b=EJI5PcVXvAfgxBoycj50v6IMSx8cpRSENgTJlfURM5alc+opM3WBVve/Dk5muklmBfpKytO/kG2VAj14632PyYJyVXzcToMZwZqTWxDWPAhWmCEC2m3P1a2Qt2cGKFW0gIeN3I6TQxEONKzvtEH10t7MtUZTY/VO0eynPtwim6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726152640; c=relaxed/simple;
	bh=TBxosJnxKNSR0MGeo9H9cM/4TfnfF1GV0MUVsO/FJXg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qe/oR6vU9mdhbnsuVfCT+EI1Ye3cs2861UPnNy/zrGIRHddHhBWGe2vvPeCjQQyZaE+fT32H/4dIuef+gKshyN5sewYI3MywX02Hq0hqMyZANoBEa2VW0DoenRGlmMYG/GOGy+ld6eJiVe7yR1xug1xJ11tIUMXUwZLHvuGsMR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IvYS1NB+; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IvYS1NB+"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2059204f448so9896925ad.0
        for <virtualization@lists.linux.dev>; Thu, 12 Sep 2024 07:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726152639; x=1726757439; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8riDeJfpKTiIIgIK66ZvC0JkQHqkw/ZkvYMdWGm4eVU=;
        b=IvYS1NB+92TfC7ybnaWvs1IliniautXG1ibudslfCoVYA5zuhSDO/vPN7TizIElc5j
         VdrVkj4ZXcEbyW12kfnucvtmqMgM3Nwx2PF/Quv9Wy9UBAm4HMYXA29s2gUdUcCyImdn
         3YNk6CQyx4XpOrLBVS243s0kZ1ualk8NImgIS05OPAQ+5KlPR1g5C3ezT4djx2Y2HI5E
         lEDYKFaPwSqHjQbKaK8sfj9dt7qKtBJkBOW2xS3g9o6mpB4Gnr6qi3fge91nC/HE0WEJ
         oVM1IYPTRMM3NC/DweN1H7zFgx7Fd24WyJTh/DpWSrSxydfYzPJiXgukFJBybSSf6HOZ
         olgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726152639; x=1726757439;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8riDeJfpKTiIIgIK66ZvC0JkQHqkw/ZkvYMdWGm4eVU=;
        b=FvaQCDVU1uI0nLUODCpz6zypRy42v33I4TT/JI3AueE0RG+C69HcELai94m6B0TGFv
         ZTl+RGa5X6Gb9BEJb/K0fvXBLJSIm8GN50INGQqd80q2bkje/uF5j4IlT0xGzANRFUow
         emH2lf+8ShQKz6nA9xBIMRQ9+wpffEmNTWFoMQ/DTAADEkfm1bUQshrhiczKgZTUAixU
         Ymhyyhe29hWDAyhHF6aJRAS3tsx9Bd5jdBTKikarGtCzTxdvF4clm5ybiqgSVRgXc7Me
         f29hjbmNM4bDnpDY1PgeU9ANUpKeh0FRprL62Zpv7+nsLpUM+/g7Uw9SUsJJ2VkPiS0M
         ZA4w==
X-Forwarded-Encrypted: i=1; AJvYcCU+Ei7629zDIIG16RyXx+aRKnRAeShpT6PkejidAIjsipcflsOdndzPR3DlCfuTkqyXhyOJw9U22jkA2fB/fw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzcNa6WLwn7facyhO3U3In2DHeOso4wDWCZGR2c6NSKIy4Yz2d1
	GLP3nWraFz+AB1Nz9JNwKpLuN4GqXlF7QIJX8OBd7OJ8RFBoyTpTDFQ4Gm5R0CeVfTduZmpJNlH
	UL92mfDWO9bKwwYRepzFhqyCUiQhQrQJrD7h5
X-Google-Smtp-Source: AGHT+IH+oOivsgfrBeKHuHozhtz6eiw/QOezGUkUUw4eyVeYY7NMSvWWqexcWfthAnr/CXOkRdF8YxLmOcYdvlqrug4=
X-Received: by 2002:a17:903:32c2:b0:207:894:6e58 with SMTP id
 d9443c01a7336-2076e45e311mr42095165ad.56.1726152638371; Thu, 12 Sep 2024
 07:50:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <39fbceb9a794b7c412b17c4ac6c2dd285d1bd3e5.1726152335.git.mst@redhat.com>
In-Reply-To: <39fbceb9a794b7c412b17c4ac6c2dd285d1bd3e5.1726152335.git.mst@redhat.com>
From: Marco Elver <elver@google.com>
Date: Thu, 12 Sep 2024 16:50:02 +0200
Message-ID: <CANpmjNMNgvg+NKtzxy06AB4QFQKzFsmp-chB1G_+XueiKNA-bA@mail.gmail.com>
Subject: Re: [PATCH] virtio_ring: tag event_triggered as racy for KCSAN
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, 
	syzbot+8a02104389c2e0ef5049@syzkaller.appspotmail.com, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Thu, 12 Sept 2024 at 16:45, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> event_triggered is fundamentally racy. There are races of 2 types:
> 1. vq processing can read false value while interrupt
>    triggered and set it to true.
>    result will be a bit of extra work when disabling cbs, no big deal.
>
> 1. vq processing can set false value then interrupt
>    immediately sets true value
>    since interrupt then triggers a callback which will
>    process buffers, this is also not an issue.
>
> However, looks like KCSAN isn't smart enough to figure this out.
> Tag the field __data_racy for now.
> We should probably look at ways to make this more straight-forwardly
> correct.
>
> Cc: Marco Elver <elver@google.com>
> Reported-by: syzbot+8a02104389c2e0ef5049@syzkaller.appspotmail.com
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  drivers/virtio/virtio_ring.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index be7309b1e860..724aa9c27c6b 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -194,7 +194,7 @@ struct vring_virtqueue {
>         u16 last_used_idx;
>
>         /* Hint for event idx: already triggered no need to disable. */
> -       bool event_triggered;
> +       bool __data_racy event_triggered;

I guess if you don't care about any data races on this variable, this
is reasonable. Although note that data race is more subtle than just a
"race": https://lwn.net/Articles/816850/

Acked-by: Marco Elver <elver@google.com>
