Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3BD12E1D0
	for <virtualization@lists.linux.dev>; Thu, 28 Mar 2024 14:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711634883; cv=none; b=nJ6vgIBTlCcOPNgFNZ8qkL0zm96U8GjX8aU6GadFnNgHM6pA4q28F1cpVNcdKdD0CLbzIi88WIzl5CnXXTXgBigalxGQMVp4u3lw74ccqRhQHUNUpy2W/cm2PlMDQ57TcbbJZesu8nRsXG+dEBySdmYsRLtMOur3ClgW+Q+fyYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711634883; c=relaxed/simple;
	bh=BDHeiy5x4l219ebTle1HBlwon+DJR86izkGnTQaTTqY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AMY///2XamHEttWFWEeB/f8reZj9xDADTb3YlUPcsv4NUZcts8Pc5ru7Exq9cgNsSmHWGxGSXl6AF5ilk2ys2bG9Wawtam3Zs56Jf3PaDz27pVkGfqDtFENmvfcTUklgSabsv8uPcdOhvY2SYih9QDm5tOHEZ47iSUdOuEKCVBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E6HWmF3v; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E6HWmF3v"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2a07b092c4fso842726a91.0
        for <virtualization@lists.linux.dev>; Thu, 28 Mar 2024 07:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711634881; x=1712239681; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BDHeiy5x4l219ebTle1HBlwon+DJR86izkGnTQaTTqY=;
        b=E6HWmF3vddczAxxn50LVO04QFC6s7EeW82svf8AXlpSeCuLjPFyoLh5pEM9GpnebeY
         GoE98rsGZrtgewqFGTAGnu5cTW8Z3NbcmXUPnwmepoymAc7EUud4QX87d5cL+SCe11QC
         j232/6+FTqHVo9HRhUieZHFEyvw91mfI8KMZekB6yW3Djjas01thOlmBBSdlYyonLQJI
         hXbUgfHTAgN3MbgFh5M+SlEd9N5U3tD8RxeYbVS+/yCGfg1077No5VVWSuY2KbprMs50
         YsEvI4O+oSvmUFY7gRKD254HD/90S/KESGNBYxG+4EQZEIbo/elZVeg1l2WE06LYLV8j
         sGGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711634881; x=1712239681;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BDHeiy5x4l219ebTle1HBlwon+DJR86izkGnTQaTTqY=;
        b=w+Lo8fGKQCWYGG3g9ISqKcTWqFKz1ehMDahctwiE9RWiBVKTcU3gCJYkV5Ia5xrJcv
         KfY687mN9TxGEE4kFqqre6S07fdyyf0qCoexPC4WpE3oJf27IqH8jZh35Thht4n2xejJ
         wDXZMtnrLuO46RayrLd2AJM+GWA7LJXMGDShMc41R7wvWIsQFy8mh6RkNUgvUlcUuzBZ
         AkZo7PB947kgCGaj7YvP+YB8mnrW8sRgoEIpyl6KQHWkhAj0SgWpTcgewOW76OisT+hg
         alsE1wC4zQJ0dXbCSp3xPadn3MakmM4uEdKFeIY708KizTQRyDFMtfnakaGlT0j5QNDB
         CsNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpf6D+tm+e8KKK3xysxTxHawD2e47RRi+629okYU/DQQadn6B+8UHmIo4qC4vXhf0r4nNeA6vhbWnRkCmipdBCdgT5OTYNVGa3javaLNY=
X-Gm-Message-State: AOJu0Yy0MoZMAzpyEXt99tqSwcEkd5+gSR8jYHk9cb7SmaJJfCtEG6bo
	fGuYEnlkTilw/uwEjIQlwthlXEiuJH+SNp1+0YYmnil5+uPsyqJYmFPfBusgQOdvCXVFm31GzkW
	v+bwjgOMgJQ/CUbkXrb5tl5nlaEs=
X-Google-Smtp-Source: AGHT+IFIWrhKeX7ce8KjxR2/tVtAq3kXc8zJr8TS91l7PXkMz9P3mtiS4Y6NCckBLcO3qKsiyOW+wSty0gx2JmJTJMA=
X-Received: by 2002:a17:90b:2d8b:b0:2a0:310b:2cac with SMTP id
 sj11-20020a17090b2d8b00b002a0310b2cacmr2519425pjb.25.1711634881431; Thu, 28
 Mar 2024 07:08:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240327175556.233126-1-ojeda@kernel.org> <CANiq72=kGWSQR7TgKDnAaef+FS3VGQeo3ri5vv1wxpW_88vdqA@mail.gmail.com>
 <20240328-quantum-bettong-of-contentment-7c7841@houat>
In-Reply-To: <20240328-quantum-bettong-of-contentment-7c7841@houat>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 28 Mar 2024 15:07:32 +0100
Message-ID: <CANiq72m65iv8VpwvuZvW-VOewZ2-Mf3knJf-tPAzfwY7F-ZBLQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/qxl: remove unused `count` variable from `qxl_surface_id_alloc()`
To: Maxime Ripard <mripard@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Dave Airlie <airlied@redhat.com>, 
	Gerd Hoffmann <kraxel@redhat.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Alon Levy <alevy@redhat.com>, Frediano Ziglio <fziglio@redhat.com>, virtualization@lists.linux.dev, 
	spice-devel@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>, Tom Rix <trix@redhat.com>, 
	Colin Ian King <colin.i.king@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 11:18=E2=80=AFAM Maxime Ripard <mripard@kernel.org>=
 wrote:
>
> "a while ago" here being 2 hours before your message :)

Ah, I meant the original reports that Nathan mentioned in his message.
Yeah, the message itself from Nathan happened right before :)

> I've added a Closes tag for that report too.
>
> I've applied both patches to drm-misc-fixes, thanks!

My pleasure!

Cheers,
Miguel
