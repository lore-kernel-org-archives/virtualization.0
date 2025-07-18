Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2822264D2
	for <virtualization@lists.linux.dev>; Fri, 18 Jul 2025 08:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752826305; cv=none; b=oJjHbRIKwT2U2PMX7r0xOZaywW3i4UiJ38NC5NbCyAEZMgC3IySFHxPmFbl/mVAFpizAgrYwrnxMlwd8Vcq5GRG+tPkYD/woRnHNY9IW+i+aKeebJOXPn953VP02bUHbrhhHrYkzqpL9N44xzq5fpofTtUG70oDgKOgZTg2p3ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752826305; c=relaxed/simple;
	bh=1jAhRd3FU2QWDV+irfVHSFtxSupHRhWFUek+YocDJXU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hfq7WGHrvYf8PvjB+a1P+rUat2+HcmJwqhR55DoRfIwUdckC9jmDUhcrNTC6oZj0xuHOyZbCJm/PUFy6/msPLuv+4MPDqFM0iVOuMrXJ/qcAPd3mTpXYFPs9UHkbNOM+c6mcikF0gDHfxqFs5YjfPmX5qXyD/pyqpIyyFHrWEhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=PX0Alme+; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="PX0Alme+"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-553e5df44f8so1598322e87.3
        for <virtualization@lists.linux.dev>; Fri, 18 Jul 2025 01:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1752826301; x=1753431101; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1jAhRd3FU2QWDV+irfVHSFtxSupHRhWFUek+YocDJXU=;
        b=PX0Alme+cRpmHi3Gap2ai7/b0ggpbY8KQ80Z0B31VQyS9zfFPc8sCov0hsMdowo6Zr
         TA47WerD8a3xFYRMCgn48+8iA+kd27nNg5SMhyjLZFgDcl1VPdfmMhOAil4gUS4kJn3g
         OUmF9MYdcbWU3mBpDKDyffX0LdBEaoXSutM8fr1Lw+feoRu5MG83CpzJvXUI2Ov13+sk
         ffshaQpJGXaBCAPzl4VbW+YA1N8SR83pT5++3IczSu/Sox8riKL8UJcCnZ7tCy4HLfbv
         EvMWZHlLdXpFl06NMn7HUZiOb7DM4l3sFFZV6TmCzM1gLvftO0grccBkdFAvogaxuEr2
         WpBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752826301; x=1753431101;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1jAhRd3FU2QWDV+irfVHSFtxSupHRhWFUek+YocDJXU=;
        b=OIXlFetg3NWMth+xfGeGyubHmezTqSXvPAX47l3B6UDFljUDEnGR5BdgxNIb76nEyt
         07eY0qOriJq0HRX1sZ4XbI8PEJLZPmOVXcane7ycSZtD5doBiLHBuzt/4gsKCE14p7G2
         S6ovJkx4xa6QO0b/eFtRFAHuPqTvmMMEouRlX1d/p6NGGtijaGdSnJGeiLPSQKR75SV/
         pA9JNjeg8XHC1rOTn2ECp3sx7uJyHV1Ychzs+/vlsKwyApeCgzsi7EUsMcc7VS+8Rikn
         A3MCk2prQu7XW8yhhrufaBpCAvMY591HueU3h13l61oCZRlbVuTd9xN0VKbFyrYWN8+U
         z/IQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5tPzX+MT5zWM9m5Q6PvJDxeJVDFg+GPkiMGMidajDUk2urW1goOI8S+7kta7JmkoGI4KvBd1YLxTS2gPWWw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwPR+MU21z2d4AN18spZvPf4sUY5HFfUjW8XupQqLAqVta4mn46
	sa0cSFYNMYqjFoLHabP1HDSZEndFUJH19CE1vCkhY/LB410riOUReScQpW+D8miValq8XSm4ws/
	HR9l96Vqh+L+qIdzKcA7Ixiicx1SaObm5WGNWUFvPBg==
X-Gm-Gg: ASbGnctLfcaOyOZyEaVTUJH0WQbWrdBoJWPyCIj1SPcrhFmZ57n5bl89teXyLGOJe9C
	oCXycShVgAs/x4ZrQO5EXQEI4n/QpSVOJkvxOws0EdiGNF0NzPN/Vy+mEoxUUD270Hh3RchjICJ
	76+V9lz0+5JvjLKek+Fxer90dN190nMldDMQ3Ofly3j7wobqDV8x0KnAP9VMobAe4u8VBcX0W/h
	j49pm2FDY4WKQMXyeFQDXNM4Kw217fm8sr7aS/sb1kcymcF
X-Google-Smtp-Source: AGHT+IFb1uJD4V9aouoJvlP1yjVac8eQbZ0nNrzuuL9tqojwVBFkpEZenb7Pr8T2XBBshIaYd4a1UVo6aAXBNqT0N6o=
X-Received: by 2002:ac2:5686:0:b0:54a:cc04:ea24 with SMTP id
 2adb3069b0e04-55a23facb73mr3023679e87.46.1752826300986; Fri, 18 Jul 2025
 01:11:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250717141000.41740-1-harald.mommer@oss.qualcomm.com> <20250717141000.41740-2-harald.mommer@oss.qualcomm.com>
In-Reply-To: <20250717141000.41740-2-harald.mommer@oss.qualcomm.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 18 Jul 2025 10:11:30 +0200
X-Gm-Features: Ac12FXxoZ75HfgStvYvOn-iPfwrSf7_9mNtIsTgIecfFZm93LScfE32n1cfLPdw
Message-ID: <CAMRc=Mcxb4SqH+XJeLkd8J==TNaja3iUep2dEm147HOETUfXEQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] gpio: virtio: Fix config space reading.
To: Harald Mommer <harald.mommer@oss.qualcomm.com>
Cc: Enrico Weigelt <info@metux.net>, Viresh Kumar <vireshk@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 17, 2025 at 4:10=E2=80=AFPM Harald Mommer
<harald.mommer@oss.qualcomm.com> wrote:
>
> Quote from the virtio specification chapter 4.2.2.2:
>
> "For the device-specific configuration space, the driver MUST use 8 bit
> wide accesses for 8 bit wide fields, 16 bit wide and aligned accesses
> for 16 bit wide fields and 32 bit wide and aligned accesses for 32 and
> 64 bit wide fields."
>
> Signed-off-by: Harald Mommer <harald.mommer@oss.qualcomm.com>
> ---

I guess this needs a Fixes tag? And possibly Cc: stable?

Viresh, does this look ok to you?

Bart
