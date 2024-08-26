Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8645778C89
	for <virtualization@lists.linux.dev>; Mon, 26 Aug 2024 17:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724692381; cv=none; b=oJ03qPyBA1AMBLOoolq9/OzkhDm5Pn/GnTZ+qZ/qYGeCtfBF+w6HomErWfmrezYp7ZbB5wU8//o/pYnRIVZKi7MAGmpO+CwqLg7GgTSkuxAqhSJclNlKB210YMdLKa/q6rIA+ypTxfc7b5knn6icMP1QG3ol2RsnlbMsD26ceXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724692381; c=relaxed/simple;
	bh=C5FXLuFC4tgnhX12okZbEegr8EajQMblPAiafgd65pE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lvVW3EJh9AFVenujsjMaLT0iWubRsSPTACEQaWTKrNXaxlDqvIDol2Fgj+anLUb559lK18PQKXIw/D/lBCeD4bt57+Ix6JCAbNse7liH15B/wihdzwqsDxZcDPmNuhwMXLwkjDJX7Y8eNliKgjgtF9UDoHFO5tS0QruGerUMceY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B4fNVrlV; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B4fNVrlV"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a866cea40c4so522034566b.0
        for <virtualization@lists.linux.dev>; Mon, 26 Aug 2024 10:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724692378; x=1725297178; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C5FXLuFC4tgnhX12okZbEegr8EajQMblPAiafgd65pE=;
        b=B4fNVrlVHLEg6p8426Nt6cLRXRadC7bKgcch3lioKVcKwJZrkt+7V/JZimJ75PqwYZ
         SsWR7RQCArjJPnYq5Tg+XlVXXnPwSPsTYVRpdLUe8BzfAihbzC9hV8t/Cw+iL0ZfBENr
         RIlulJ7B0txeDHNG2FzjpIKhU0R2x8T2k2YwWUc3zA4GyK7kqW08lwcScJNEfwOJIJpX
         /c/G2D1bPnRcsPOge20QFl5TL+A6iRamkTUuMfn4KlSmOhIyWN4TUpzIJjIP9qleHcH4
         y+KEljF94OQJ4P2fGbs6Dvnox4o/fVCGmkaqzebwFlGdX5pIvoi7MBQV/bXLgkGvPah2
         wLkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724692378; x=1725297178;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C5FXLuFC4tgnhX12okZbEegr8EajQMblPAiafgd65pE=;
        b=IMS8o09T7hVlwWR3hB0DUpHk34/koul63HHzxJqdGGEftP/ZQRYAKI7kAdXQ6E4V73
         bviGKY731rJ3rRadf1JU+D5ZN8Vzp+2f82Z412pgdEFLlFr1z794t5WaHe+pRP7Ah7Dd
         REwLrd+so2BZlDgXAiqTI78nS+G3ThEG7L7xlgG/VxKfjeBdyKFaWviyImS83oo9bU9b
         EV9dpCR/8nDh6HfDt/SfTj0wrCC0e21TiJpWlj01UDB/qCO6OJ1Fbiphw4pNvl+FlwuD
         F8XenhrX7PbYDlco9ptxO26iN5ki/hTxq5PmUcS16cSOzP7JMsOJV1b2I5JTbjAHxO6v
         07kw==
X-Forwarded-Encrypted: i=1; AJvYcCXEi7klKdATg73FTFDhfA8y8IJ0JFALfh721n/WJelS1OcYlpfkM+9DL5gNAOYY0ETRZ5BKFqqI6GL2g0SmYw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxntJsbseyiki6AU9NNPaHrbjSrJtrK5Gd2OUbDZTs+b12XZM7i
	Et4NhhHNfyZhtE9L64BXUymjindIT3rSjxtsnW9QjiB6/ypBo/cWv9yZlnrcrQWWwsBMs1A+OZl
	u/LAMfhPEzpAO9ye+wrJ8E4Umea8=
X-Google-Smtp-Source: AGHT+IHOnow3s0g1qCPDF0qgfwkSpamrc3MZdI/hWzuSVu2jgy51rNUKPxKvH0/02EJM/ysKZeVBGzzN4FAWZd6sxPU=
X-Received: by 2002:a17:906:c105:b0:a86:9644:2a60 with SMTP id
 a640c23a62f3a-a86a5162f4fmr872581066b.6.1724692377440; Mon, 26 Aug 2024
 10:12:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240822134744.44919-1-pstanner@redhat.com> <20240822134744.44919-6-pstanner@redhat.com>
 <ZsdO2q8uD829hP-X@smile.fi.intel.com> <ad6af1c4194873e803df65dc4d595f8e4b26cb33.camel@redhat.com>
 <CAHp75VfKS_PWer2hEH8x0qgBUEPx05p8BA=c0UirAWjg0SaLeA@mail.gmail.com> <f2d6345a8a684f62035108d74938ec0b2e162019.camel@redhat.com>
In-Reply-To: <f2d6345a8a684f62035108d74938ec0b2e162019.camel@redhat.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 26 Aug 2024 20:12:20 +0300
Message-ID: <CAHp75VcgWdCOs0b51pqReLAMArno7FekYxiJmNnBTcdgGAyJMw@mail.gmail.com>
Subject: Re: [PATCH v3 5/9] ethernet: cavium: Replace deprecated PCI functions
To: Philipp Stanner <pstanner@redhat.com>
Cc: Andy Shevchenko <andy@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>, 
	Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>, Moritz Fischer <mdf@kernel.org>, 
	Xu Yilun <yilun.xu@intel.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Alvaro Karsz <alvaro.karsz@solid-run.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Richard Cochran <richardcochran@gmail.com>, Mark Brown <broonie@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	Damien Le Moal <dlemoal@kernel.org>, Hannes Reinecke <hare@suse.de>, Chaitanya Kulkarni <kch@nvidia.com>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-fpga@vger.kernel.org, 
	linux-gpio@vger.kernel.org, netdev@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 26, 2024 at 6:52=E2=80=AFPM Philipp Stanner <pstanner@redhat.co=
m> wrote:
> On Mon, 2024-08-26 at 18:41 +0300, Andy Shevchenko wrote:

...

> Though if it has 0 disadvantages I'd propose proposing to the git-devs
> to make it the default.

It's slower. so the people from https://occ.deadnet.se/about/ won't be happ=
y.
And more power consuming, so maybe not so environment friendly after all :-=
P

--=20
With Best Regards,
Andy Shevchenko
