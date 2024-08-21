Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81471531F3
	for <virtualization@lists.linux.dev>; Wed, 21 Aug 2024 08:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724228101; cv=none; b=j5nmYNlNEW7wGHtTafJN3iZFJjk3vTqDTTGIy16vvNPO79AUu9DDDZ0ihZ9AmHTQnlK0SFt4ydPuBDbJszHVEtDWweTeybRuCOBGoOlIbryXIckA85PmkJ9NHb203QVQK2V37yldNau5270jwrY1zw1IHqSJZx145vKIH4XkBxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724228101; c=relaxed/simple;
	bh=kMSf+iw07WfE6MO+gcL/KBxzg692lQ/LMRuhXYnUPvI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jgXCERYVKkoUFcqD+IlmR+babFqBfNszsxeYMjsr411GByrFlQpRSt+2gGHdc087ePkHWM1lhy+J8xVqSocMgYGOo+vTe2o9lkvJLjZ+1KOiSB6VRvjmqKfQLAhnApgphGM1xCdmRJ/7kx78qsCXPYzYg7x5kIUNC72Ph2JTNNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z5zeyFJ9; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z5zeyFJ9"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a7a94478a4eso93314866b.1
        for <virtualization@lists.linux.dev>; Wed, 21 Aug 2024 01:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724228098; x=1724832898; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4/bwSEYo5Qt1Y4vdeeF4jF0uVtsiIk4nNlCmcuIeMvU=;
        b=Z5zeyFJ9QFWgoB87koVW2mrf4FgS5XstZk3A66pzlRO/usD9VooyYHt7SS8bgzxfWC
         NHQa2MuYA39ksxnlfouVMNn4UJ9v1z6uhbPNeJ51snWoFwNQYSXKOTlinH+sYY2FzG0B
         FmWQ5yfLLw7UUswm2KwbC2uq3cf813LNHmzr9UU93suI82Y2BFI5CiQJxTppgaddzl1o
         l+1NSQPCfQHPrtoDG/CaPdZ7s6p9m7lATews2qzw0qkzegvRZ/PsjIAU+7TZdZMuVdJ+
         jVToQ79shNcYA2sPkUPNIBYJxuQl9exFWjlrBJIKdF3i0UVKVQkuT/Pd1mAKEYBK2tcz
         uObA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724228098; x=1724832898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4/bwSEYo5Qt1Y4vdeeF4jF0uVtsiIk4nNlCmcuIeMvU=;
        b=V0Ex/pggL9OzYBMK/Rk7ZxTBBBJSfb9CgOO1eU5k/IEu0s2I7Fy29NmkPWyzmr6TRR
         +rEI5xTdEqcbdLrCrPCNxAn+jNB6Sz2+AZQ5v+hl+WU5rFS0uT3iSvFzk8JWK5E3PWZN
         kJuQDclvzLTm264qx37FztYZr3dxRuHvzE1bmCk08PTYrW7+haPRzhAyJIcMe7EsXweb
         gls769YQ+q7MSmy3/oGovFD1Z97HJrn5RR8zslB7jM0XJqOloIUOBbfwWxQG73fBFqaB
         HJLPXpFNeE62S/THF6vJbYuFfdyjXnOgiaU4sR7Xj6C/KaFCk5p0+EHpsY/vo9TUNWwQ
         iyYA==
X-Forwarded-Encrypted: i=1; AJvYcCXj6y2xqgxXZVZSbL/UX/F9iAgVbBtbHhMuAWlqt+bVmyMsIvKocisF2bcLQUpwcvvJBC8BFowa9PazKtafaw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxd8lxsUVPh7E1qvjm7b+kf7FzhRv56VSEBOrXNt7c+KOUOFHJJ
	nPqZEmaYHScHOaVjbpp3oAxOKKO0jigLmx6D1t1b7BmXqLtd+CotUzmN5+LSnuORPaqYfgB7nqg
	L4n7hKkiVRy8bQvVgcNAOsbgH2co=
X-Google-Smtp-Source: AGHT+IHXeDFRnTQE0pLZlEZNONDmr3JlN5sqQBHhtFZ2nKA4GnNGhGlYKiud1j1pywVXDIqvTC/jKaVR2p6DxNez5+c=
X-Received: by 2002:a17:907:1b1e:b0:a80:f616:5cf9 with SMTP id
 a640c23a62f3a-a866fbfda68mr155136066b.0.1724228097818; Wed, 21 Aug 2024
 01:14:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240821071842.8591-2-pstanner@redhat.com> <20240821071842.8591-8-pstanner@redhat.com>
In-Reply-To: <20240821071842.8591-8-pstanner@redhat.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 21 Aug 2024 11:14:21 +0300
Message-ID: <CAHp75VduuT=VLtXS+zha4ZNe3ZvBV-jgZpn2oP4WkzDdt6Pnog@mail.gmail.com>
Subject: Re: [PATCH v2 6/9] ethernet: stmicro: Simplify PCI devres usage
To: Philipp Stanner <pstanner@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>, Wu Hao <hao.wu@intel.com>, 
	Tom Rix <trix@redhat.com>, Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>, 
	Andy Shevchenko <andy@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
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
	Damien Le Moal <dlemoal@kernel.org>, Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-fpga@vger.kernel.org, 
	linux-gpio@vger.kernel.org, netdev@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2024 at 10:19=E2=80=AFAM Philipp Stanner <pstanner@redhat.c=
om> wrote:
>
> stmicro uses PCI devres in the wrong way. Resources requested
> through pcim_* functions don't need to be cleaned up manually in the
> remove() callback or in the error unwind path of a probe() function.

> Moreover, there is an unnecessary loop which only requests and ioremaps
> BAR 0, but iterates over all BARs nevertheless.

Seems like loongson was cargo-culted a lot without a clear
understanding of this code in the main driver...

> Furthermore, pcim_iomap_regions() and pcim_iomap_table() have been
> deprecated by the PCI subsystem in commit e354bb84a4c1 ("PCI: Deprecate
> pcim_iomap_table(), pcim_iomap_regions_request_all()").
>
> Replace these functions with pcim_iomap_region().
>
> Remove the unnecessary manual pcim_* cleanup calls.
>
> Remove the unnecessary loop over all BARs.

...

> -       for (i =3D 0; i < PCI_STD_NUM_BARS; i++) {
> -               if (pci_resource_len(pdev, i) =3D=3D 0)
> -                       continue;
> -               pcim_iounmap_regions(pdev, BIT(i));

Here is the BARx, which contradicts the probe :-)

> -               break;
> -       }

--=20
With Best Regards,
Andy Shevchenko
