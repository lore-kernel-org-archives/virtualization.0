Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2D12F5336
	for <virtualization@lists.linux.dev>; Fri, 11 Jul 2025 18:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752259071; cv=none; b=W4keOlkqR4CZ/FEZbsdUuw+aQhteNCCt1HFe8W+lpbWRQUE1rYUB/PDyDPG7jI5s00uBaee8P1IUDLwtuXbU1NO/N1nS4hYOdDN/bZZ/gKfZcJy+DHai5pUQBktUlbyeH6rIeVrj7JISHkAzJSW2h+p+MUd6xU8CkDzYO1G4T90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752259071; c=relaxed/simple;
	bh=1oZqt7Jt8DVHY7XC40bNBzIIs2bubRZA3mDsVT5lwEM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I4QhqE8nbChxyrYOesh8K7xpDZJcF97oKQvQipbODsrTTWhj6dVa61/OJygHAuh0CvTRzAHU4wZsj7TgLpoBGzKfOTQ4N/JvrMtHTqnIs3xBmSieoOabyo92HYP2M2thwlRxTvEUBZO3RioxMdkNcEFoWPPUkt1pqtqhd0XJBP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Y+1fkS50; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Y+1fkS50"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ae0dad3a179so395900366b.1
        for <virtualization@lists.linux.dev>; Fri, 11 Jul 2025 11:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1752259067; x=1752863867; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NqSyi099qnjScevbzt/A0T/7PehrNF3qhUlbAV32+2s=;
        b=Y+1fkS50WshGY4GbW6duGjo8RxM1HfbOorb9xnffg7qs/e38MN07yqjIb3yGRLc5D8
         K0epIpBN8mbCV1M9v0n4My4sSA/8CbGmGRo/XEuLGN0w6EI1QpGG/fiKrQ8z8rNHlv85
         nZXxatbaTYSl8mNq6LTw9t2iXz/GTrv/FGvoM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752259067; x=1752863867;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NqSyi099qnjScevbzt/A0T/7PehrNF3qhUlbAV32+2s=;
        b=bYA0gm6vGIZWtV7LXhOi065e+LmxLEdllr+rIhWdgZoi++mc4JSeO20B9FXkRjQ+km
         RVhjBLNak9I1NJ57LUSTaHPpRiylB5DOcbHIzm2+BKAi2z8UXi4g2jvPexedoeYtRrfb
         Vy12+gj0y8I8eXu6WR9hcdyYDGEY8Hgp/4d0haSQAm3cM5kLJyjySS6FqiMSXN+6vdBA
         t68YHhbvB3weai+rq8HGg4RptPxwZA6nMJjD7TjKpm7tSGbNETXwYaSpdD2A0fJBN35e
         Z+iCspDQELepc7MKS9lSq6XeMu/6dZ3ab1CiS9sfUH3w7BxIfXM6oqxuOAQhnwTEEEF8
         HzcA==
X-Forwarded-Encrypted: i=1; AJvYcCWkFLDz8gDKvWY3KOQn1wzycna17vrwr/N5gh6GfgDgvUmsBPnUevC/fuvbJhbpv5zPtAUbMEbkDOPMIKVnPg==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywq/ppwzwbHDEKDgxq91wGdYWw84FDKnjUReIDns41RK0k4o2AA
	rtrlGv/O65nIcj0Eixo2LeIBPl76J6ksuYnMatCRHNAeT1H8xjerZb4Ao++BAdiafL9ZnqQMJvN
	jlVoXq5zSNA==
X-Gm-Gg: ASbGnctUctkK9S7SqEI6FnGObBr1O+M4I2cDL2Br7CnGkJDneXSsJV6csiSG1YQoyT+
	yKoCIO1zqfJEzghgwBwYVc/LqxUoFnSgOPFsyW43PTQu1mv4Jyf6cKsPa0HJU5Pbp5YLedjeYug
	8wum9ixd4IpRPm4kvGD28hHsQCcAGMBBKfY8szHauRqbCkiNXdJ+Bn6Ldz3PNgY+RdLh0OCVX91
	7JZPtpDnqnl+tWnVXYJAyfwUxTg8LIkTSOAKLqvlvpIM+NlIj1PhgmiJXVgXfA94YKpiPzsl20t
	yNUANm+oFdr09vwzf2AArOhtlF1c21BdLwW1Ov8eQ79IKQghpVXAjIgMmDLEszPP8jy7DExWnAG
	kJB4Jh4wQLQI0dP3zTpF/vvZyBj+P9chpDVZR+k1MOryi/1ut6WvPgp0ZOkvWmerZRkgi/JXe
X-Google-Smtp-Source: AGHT+IHCAgIacW/WHoxCMDMklBmgOAJkUMzx/bqeuUVhWZr6T1fT8VVJezJJBVaLlGaEdj8xCjfGiw==
X-Received: by 2002:a17:906:6a1c:b0:ad8:9e80:6bc3 with SMTP id a640c23a62f3a-ae6fbc1187bmr441874666b.1.1752259067189;
        Fri, 11 Jul 2025 11:37:47 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e8291bb2sm332616066b.113.2025.07.11.11.37.46
        for <virtualization@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 11:37:47 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-607ec30df2bso4733085a12.1
        for <virtualization@lists.linux.dev>; Fri, 11 Jul 2025 11:37:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUnIJaLnBrmbBuGacinhI1Dj2gnBAamJEUZYzh6wGyKov74oVjHcpo62qXBg0rEubJdc1+p+0tI0rQfwdoC4w==@lists.linux.dev
X-Received: by 2002:a05:6402:1d4e:b0:607:5af9:19b6 with SMTP id
 4fb4d7f45d1cf-611e7c107efmr3549154a12.15.1752259066540; Fri, 11 Jul 2025
 11:37:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250711093744.120962-1-tzimmermann@suse.de> <CAHk-=whnUp7M-RZ6yzOyF6bzA4cmbckaH4ii_+6nBm0PqKOaQg@mail.gmail.com>
 <CAHk-=wif6u3C4gk7BtR1M+0SvHruXZ7xycP5oDdg-SF1D=ELqQ@mail.gmail.com>
In-Reply-To: <CAHk-=wif6u3C4gk7BtR1M+0SvHruXZ7xycP5oDdg-SF1D=ELqQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 11 Jul 2025 11:37:30 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi3Fbiii2K9fgmoAgoJYoLuRyWfOZhh57FmREE15RbiUg@mail.gmail.com>
X-Gm-Features: Ac12FXz4IEMNfmtixe8DP0mDcYY7Ge-_C9kKvhQh3DPD6bVXdbf7Bxr8kqE2eLE
Message-ID: <CAHk-=wi3Fbiii2K9fgmoAgoJYoLuRyWfOZhh57FmREE15RbiUg@mail.gmail.com>
Subject: Re: [PATCH 0/9] drm: Revert general use of struct drm_gem_object.dma_buf
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: simona@ffwll.ch, airlied@gmail.com, christian.koenig@amd.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, l.stach@pengutronix.de, 
	linux+etnaviv@armlinux.org.uk, kraxel@redhat.com, christian.gmeiner@gmail.com, 
	dmitry.osipenko@collabora.com, gurchetansingh@chromium.org, olvaffe@gmail.com, 
	zack.rusin@broadcom.com, bcm-kernel-feedback-list@broadcom.com, 
	dri-devel@lists.freedesktop.org, etnaviv@lists.freedesktop.org, 
	virtualization@lists.linux.dev, intel-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 11 Jul 2025 at 10:35, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I'm hoping the login time timeout / hang ends up being due to a known
> netlink regression, and it just happened to look like a drm issue
> because it exposes itself as a hang at the first graphical login
>
> A netlink regression *might* fit the pattern, in that it might just
> cause first login dependency issues and resulting timeouts.

Well, considering the random timing behavior of this bug, it's hard to
be really sure, but two boots with the alleged "fix" for the netlink
issue made the behavior worse, so it does look like my problems on
this machine were a combination of the drm refcounting issue and the
netlink thing.

I guess I'll have to do a lot more rebooting to be sure, since the
hangs and timeouts have been so random. But the netlink "fixes" did
give me a hang that was very different from the previous ones I've
seen, so I think the drm code is off the hook on this one.

                 Linus
