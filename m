Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E3E3932EE
	for <virtualization@lists.linux.dev>; Fri, 15 May 2026 08:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778834515; cv=pass; b=hwf/xNQw0MWqQ3C/9/GPnWrbVbN7uhQXXsTieCtswZJbtp7XROls1hHx+LM+doxfQYqmM/eOPGihsk8PofpxATl0tr/jzdWB4jbqNF6Geg3c1QumCoaAkL+A9/pjegqgXh8TsY+JbUqrVBHRo+FkRO34vCTx77iOHWGGgdUJdXY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778834515; c=relaxed/simple;
	bh=I877MRSe9H5vPYZq5yiCD/TiLGWBm9ufbCGIjpcsS6I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sZoJI7NyLkYA1iZujxdyZkpMRqVelIlvr96Ov1qaqLYHKfzSh434K9Fng57grCnrsusgTThY2d//5hxLwnsLoGRuBCkjsmd68PN5M9tvh8IgwH3HB6uBeIOD6RofWqJF6fWHayvfLW7S2WCtuBvGhi8cyY45OXaq+Luj1WjeqbU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FMY5VX7P; arc=pass smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FMY5VX7P"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-65d071aac6eso10214745d50.0
        for <virtualization@lists.linux.dev>; Fri, 15 May 2026 01:41:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778834513; cv=none;
        d=google.com; s=arc-20240605;
        b=h+0zlnrQaIFlOOMum8DzSiIa2+AvGdMXuBRjbkXaCLbW/oCkcxdjvUmNtmWJf9YI2j
         7fBX2dfDcqi5n570NuacxvRS5LbC32Xb5MGHWUmzo5yJsbPEfefQeYVtTLfREzFRR5DY
         LJ2pOjVG6CEUc20vfNu/ZSGqRzfmFOuPHc5lWYPiaO9dfKldSnJwIcelZG2MO5ziFu8g
         tlpQ46WwgWPRZBpluxQVJtfTZ6IrpQPlbSRl3V4BJjdEjOtM8RfWDLBh2vwISvvrCXPg
         SfmaXNTmyzE25t5vCioAk40DGLfKzyPBrM+b5ueKkdV5pxMnpg2mTXGarcilR20Eeqdg
         GyYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PBSjZR3vBTrgdu+SMltlDgYPuNOIji8ITlL8pViUrIo=;
        fh=CW3FbIa/rqhj8Dkz4pjy4DSOmKson7y5jRk6p1WAmKU=;
        b=KLKMvUtCkQjAbm6ZLNvwFWYqK+HYGMb+bA9gNxyeYxWhqL7bghqpYglwG5YDH/NyWC
         2DyBeoMjbITxmM7koxsTXlHDiuGt4/57C/QtYG7tVxdyrRzQEBy8OF5TMLx58CoyeC/r
         fk+ufuSOBHpcwybZweaLPHKSvYCbMAkoFPavXq2BSz0wPyqy8dhy1/Kz2hPWb1gUzKOc
         6g2IabWNwaNlAw+4TqNiW9Q1midzS/QmTbWAbs6yyOqr0odIcQ+6jzziPSNVJpOshwNy
         LiiYgKqF3s6iMjWTmM7RoY2oO/2PP9A/UQzrd5Fi3P/28f1EqolwdRfaxoLxEDIPrjsz
         TF6Q==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778834513; x=1779439313; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PBSjZR3vBTrgdu+SMltlDgYPuNOIji8ITlL8pViUrIo=;
        b=FMY5VX7PEwl7edo6mDOVhupVzlNo3PsARFAHH2Jlh6IXseXFenYdBecvQSGQqWe57L
         TMDyR1AzcpfL1TErEa+DiWVkMBAyh+xLdc+c0fNa1O5Tl4RZxY4ggJUefApT5nFZhL6j
         tU34S0817wsEcPAstT/uHBMMmGrnxt+Z6R/ZAkg2KB/NPs7eZZaYv371ke85JihpCkG4
         hNY1GIqwGkwG4ELjQHotE7ze/V4n+xeVDMcdrRfzvN7AFcGCtHDuEcGT9CbogkqA1fde
         PrNsVFpTcfVr1pM2P5V1bD3Y0HXt2oFq4IS/52EHU8qENsecGPILWEqMnoU11vsy2hiJ
         nnJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778834513; x=1779439313;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PBSjZR3vBTrgdu+SMltlDgYPuNOIji8ITlL8pViUrIo=;
        b=UNw9du3RG2M3CM9nHGP8Wg5KJwou6vaK+YTB0KXU7ODAZD28TmFE8Qjf7R4GDR32QL
         3sxAJ/1/0oGmqA0alD0bptoyIqOY/4X4STYjJGvW25DukSTDuW7D5N422f5Vc/riTs03
         PFk65j3+DEWAmD6Gz0jFiOCXJkVpvfTLrRlRp/ZNU5bdhDkMqmbfLYJMENeIq7M36A6U
         nxvTrnhJGbWOCiJnGPdZL5LNGLUEzCRGfqUsP2WXgwG7J5XLJ5qRCGIckvMyld7jn+7y
         D8b8Fnp4lqNEU/6AQyOnpiHry6LG6DaQGQRbLweq9p5iyaHRms5U0iFJHNLhG1TuFtsF
         q59w==
X-Forwarded-Encrypted: i=1; AFNElJ8rGn5lOEnHax030CpBV8mFPpayLzf3qpiPmic9JK3VoolPOAoAsH+238R7zjKeJVvOyQoFIZZfqaKyIaMhPQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YymUcXnZDQHYk8A9vyiKv8s9FsajiuCswD8k8m2xdQXErNK3ekU
	Un2GmvFPuDSqfXRgb5U5XK8sXAPEkpmf+9xY7tp9Q9hGKfOEpeWz4uPek6XuKM5I3UnrXUFX70u
	Qq2wcUrHh2QzpK6t4UVpqNjsi3muhVsI=
X-Gm-Gg: Acq92OG/TDtYpsRy0ZeJi9ePDiRwE3ICNReiDfcCjxzXcJCNmBbp/Z3lS3n0tQyz9wc
	zLF9YWReqixYonMglorvs6Z7HjAR5lY7Ugr4NhPEcz5lvlP0pHnbvymUnHAHF2o6tl6iCNvcGiL
	PbA+HuSOTZfAQlbXSnrII6T/4TBFegoSAQF5f9QCEiDy5fQGv9X7e87d8vwiNoPZgitGPm3XcYf
	VvQAGzmKA6aKp1V8GA73R5jtRG9rNV/Rf899aoogiJLrlq0IxBgSU8o8gTlyYGaFarWlMEIyo0H
	MI4ylnoc8Yir5ZebYQmSwpoyyqA6fLutfGUlTk41KJLEcKdPSZ297utChpkFYiQvwysF5rFu
X-Received: by 2002:a05:690c:4:b0:79f:d961:47bf with SMTP id
 00721157ae682-7c9594b0105mr32678827b3.8.1778834513472; Fri, 15 May 2026
 01:41:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260512020718.108044-1-kartikey406@gmail.com>
 <d1bc8d7d-3a4f-4ede-8266-81cc66bf11b5@collabora.com> <CADhLXY7N0eLpA30eV4Rb=F4vzCf9XYtDjMpxBSJtGeMWNi6Cwg@mail.gmail.com>
 <65da2ce9-a2ab-4800-a73e-1a26082d0605@collabora.com>
In-Reply-To: <65da2ce9-a2ab-4800-a73e-1a26082d0605@collabora.com>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Fri, 15 May 2026 14:11:42 +0530
X-Gm-Features: AVHnY4IGHTZnfpb9msWE08vJttVqhQ6G8dsaF1hRX2r-HcKGXn0VdlxicBL5ZuQ
Message-ID: <CADhLXY6L1RJvgfMGuogmw7bx5Sj-_6G2C7zR5q+xLQXu_M-Tjw@mail.gmail.com>
Subject: Re: [PATCH v2] drm/virtio: move cursor resv lock acquisition to prepare_fb
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: airlied@redhat.com, kraxel@redhat.com, gurchetansingh@chromium.org, 
	olvaffe@gmail.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
	tzimmermann@suse.de, simona@ffwll.ch, sumit.semwal@linaro.org, 
	christian.koenig@amd.com, dri-devel@lists.freedesktop.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org, 
	syzbot+72bd3dd3a5d5f39a0271@syzkaller.appspotmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 13, 2026 at 2:40=E2=80=AFPM Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
>
> > Does that match what you had in mind?
>
> Sounds good. The virtio_gpu_resource_flush() also should be updated to
> use uninterruptible() variant.
>
> --
> Best regards,
> Dmitry

I  have sent patch v3.

Thanks

Deepanshu
