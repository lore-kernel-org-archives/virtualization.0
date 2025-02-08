Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3B926ACB
	for <virtualization@lists.linux.dev>; Sat,  8 Feb 2025 08:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739002275; cv=none; b=A9JF0Bf7Ms4FBlPUHEtemaVERqFcRkJER9AFpSneXyiA42yB0XxlTaG3zVLKHEPiZtHm/q/dD+xk8xc3pqzzfgE+GKarB5u+9m9oDY8dkCAYcnSx6y5N85Z/IbdmwvXA0Q3YKPs7ZPyhVFDYasVG9a5x9RFhe6fOBO2M25BM9RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739002275; c=relaxed/simple;
	bh=bxm0Gq1x5fkAqjzhK6hgWVUbEn5Ef6NT3MJ8Fh7seZU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a7MWk71GyhJXTKbaIMGLtyPBLFcfy+0Ssope1V8GogSjn+vqIWzVdRNOLfGsZfTSTI0nVneI24KW/qjpTB9HuBrve8Id/fNaK20gFmtuLIRyLtspjhvoN/GXvqqggNiEQnwRloZqIQWCZNgG35W9LuReW3JwVhl14xlhdwG3SIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F7Qc2mnZ; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F7Qc2mnZ"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-53e384d00f4so428963e87.1
        for <virtualization@lists.linux.dev>; Sat, 08 Feb 2025 00:11:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739002272; x=1739607072; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WiIFqqJMdXJ23ljTdQnHZqAYZ1y/yPvmLVewrsPJ3/Q=;
        b=F7Qc2mnZnOc+s5rxwzIgXKu893vpzCtETlZB7E1HTiKMQx6VEsSR4dCCFfOb+eA5A7
         Mx6dc2jeZDSXlQ0MezV/wRKUP8HTE57Ngba1CaebgXpk2hPYc2h5y16AxUdZIlrrgiKm
         DVSLa2eAYBkDWlCMFMroePOuZ/08h82HKZmCQIt+OtzDv28dfS3veGCWs5xDhptXQLTx
         qYu5Qvbi5qu5GXrzzWiK39R2muoRXYNcsDnRq3gTEoiKT7dIuoKHAoHucKHiJOEF7fGy
         P9gxr0Nx7DebfmT7VemSeGRVazxoDQysFQErLJ35p/o/QgtZHiVB2XnV3R1TwRM3DL6Q
         /t0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739002272; x=1739607072;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WiIFqqJMdXJ23ljTdQnHZqAYZ1y/yPvmLVewrsPJ3/Q=;
        b=ojGUENi+PgVGk5B0VdlCBdxM0TufMrMTdlqf+JF0SMWn3q0pSr3Ht9NqDGf3puY2TK
         PhnZcgS9ZYWvT4arMKQ3qYLyAFXWeBqbjZw61L0OCVLvQs9Je9YSWAm+Ael4plNh77cU
         U9+5u8wxNwqinMjaEoYDFlNzOZnMUiBd2UpeHOCN37hRlEwLdm9bGl6NB0YZE78P0M17
         NYdJj4Sc8raWRqv+FMdap7CauHyCSOa5kce5KP1bMqIuVy30031rtNKojrZ3w8klYMID
         /UnC17bQurjlvYNGIDKeD3H5R0wSnAFt96F9PKZQtWrSMGGCxgjV+cI59HcszWLnwLsp
         dm7w==
X-Forwarded-Encrypted: i=1; AJvYcCVfsnSR4/tOoXxqP1UVyAHh/KeDOXe/6JqM+Q7y2DW6VWiIWBjVSrEQO25a4JRLz6RRApskgnyO9AyKBHqOZA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzPP9fpJ7GR+CJccf8NVbooLkaTsHcQXirEdaDIkg7GLwI26uzo
	LxnPDbo/+7X+IeEFu9qqoap8drCqc76/swZal9O9rYqnpYf9q5gGheZhkxrxKnmy7wXwEge3W3m
	o73TOIADPTd2FFGXMOc8YqiQd8DU=
X-Gm-Gg: ASbGncvWw6yf/7eJtKFi+bF6RT7F4FY9fZXYsVaovzOwHzZ3j7YD7Yh35bwpFKm9usY
	1G60To3CCkgMB/tKrDub1D+pLD5pBLiYzMb3qmf2YRtkDcv/dif6NmAQUv84jD/jHVnn4B5k=
X-Google-Smtp-Source: AGHT+IE4hfU9dp0bqeXZ7WIU0MXocNLEpy5CFnS6vFLxZfiGCPVQJUWZz7OVPcMxYC9NahuiTEz0FM74j/j+kBak/g0=
X-Received: by 2002:a05:6512:468:b0:545:23a:d9b5 with SMTP id
 2adb3069b0e04-545023add7amr280210e87.9.1739002271595; Sat, 08 Feb 2025
 00:11:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250103083520.1764441-1-a909204013@gmail.com>
 <20250106043508.x3pwt3jzh37t265f@vireshk-i7> <20250107060044.hteiw6dgycz5rr7x@vireshk-i7>
In-Reply-To: <20250107060044.hteiw6dgycz5rr7x@vireshk-i7>
From: Leng Cold <a909204013@gmail.com>
Date: Sat, 8 Feb 2025 16:10:35 +0800
X-Gm-Features: AWEUYZl2v0ZB2StNgGA7NbBp4txnrsS-dgvem0L6IQvr-ttXub1s2F9gwMWSd0E
Message-ID: <CAHqiF6B4pQZYVmsfVM8bRaS1Zt3TX5Sw0_bmLZM6WBx7t7d+Pw@mail.gmail.com>
Subject: Re: [PATCH] drivers:gpio: support multiple virtio-gpio controller instances
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: info@metux.net, vireshk@kernel.org, linux-gpio@vger.kernel.org, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

ping

Viresh Kumar <viresh.kumar@linaro.org> =E4=BA=8E2025=E5=B9=B41=E6=9C=887=E6=
=97=A5=E5=91=A8=E4=BA=8C 14:00=E5=86=99=E9=81=93=EF=BC=9A
>
> On 06-01-25, 10:05, Viresh Kumar wrote:


> On 03-01-25, 16:35, hlleng wrote:
> > Modify the virtio-gpio driver to support multiple virtual GPIO controll=
er
> > instances. The previous static global irq_chip structure caused conflic=
ts
> > between multiple virtio-gpio device instances as they shared the same
> > interrupt controller configuration.
>
> What is the conflict you are getting since all it has is callbacks only, =
I
> wonder why do we need to duplicate it.

Ahh, so irq chip should be shared actually..

static void gpiochip_set_irq_hooks(struct gpio_chip *gc)
{
        ...

        /* Check if the irqchip already has this hook... */
        if (irqchip->irq_enable =3D=3D gpiochip_irq_enable ||
                irqchip->irq_mask =3D=3D gpiochip_irq_mask) {
                /*
                 * ...and if so, give a gentle warning that this is bad
                 * practice.
                 */
                chip_info(gc,
                          "detected irqchip that is shared with
multiple gpiochips: please fix the driver.\n");
                return;
        }

        ...
}

For your patch:

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

--
viresh
