Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0E31AED4C
	for <virtualization@lists.linux.dev>; Thu, 29 Aug 2024 14:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724941640; cv=none; b=nNvrI/eYj731vflD8hdrku0RZygdThRkRDKsDF5WnKSVKYT25RAzJ7GSHX4BaldGzjR8uAIDCqK8vYTF07LCNo3aC8DC9+g4XyG8iF1joGxk/JCGz53t5qYINu/nuvfi8sLugBJSZzlFj2o5QnEQA6ITTjvNiK/zRAGhC6SmFJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724941640; c=relaxed/simple;
	bh=8RoE+cdozJ3A+shrfrungz4qyxcoLBGnk/z+3xmrit0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FS9GwS/QF3bOKo06kcQhaC936PL3bIsHSD8LJE1jP9/luUj2FRdnjOlpP5CnOPw0s0B+fr4uW4EpsSMwKslPmGsO37vWzNNCEYNy5RApwNPt5XYBXGcUl1uhnAwsw/VQVpVz2vZa8NPutOuHmEBA0EV7Kp4GKpaT6wqpjzdzXKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wn4Fh2da; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wn4Fh2da"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5c09fd20eddso819074a12.3
        for <virtualization@lists.linux.dev>; Thu, 29 Aug 2024 07:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724941637; x=1725546437; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xZpI4afRL2FMKQeKNliFKLWSQBi1pIyubvpJPETxetg=;
        b=Wn4Fh2daBtS88rNHCBsRQXwn01VIYJUMxEP4U+KB5BgkWVhJ/J6d0mZsRC0knFcgyj
         2FIVAa4Qf6T7h8OqewXQ/LLnN42ifzsPrJ8rtgc2D9G8n+CzJgCjVN+SvbjZrJoRhSBo
         QIup/HZmtyhP/tkDphZhCkK/GL7wrEpEZRbuOTf5kYu9RBHJq4ppcsujRotfy4Fa6UWc
         O4f/w52v92G2pkbtmeqfkjfwOE52ugzTeSLFCxAk5MoGxj6bhtkZgmBQVEcuDjzk5LHV
         LUI0E+qd1qGwyqWeZiJ2jgtYOmhp+os8NzjcBQVNDPpg1Nai0Hxobcw+3uFAvWnssDuN
         BGpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724941637; x=1725546437;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xZpI4afRL2FMKQeKNliFKLWSQBi1pIyubvpJPETxetg=;
        b=xO0nIwSJRmrhkz4b1dTY38B5KJW0HC2mio1p2EmoUo8zD06vZcVU2ZlpYKIbtb5rzL
         ENUG5JDOBQ2Bb9AdgNN+wLxRtWBIel6vt8OnA+rkC1XMGIWmx/4IlsBgTCWmUtnwB1A6
         JdJsKg7nYGi5v+B+BUKr7q5osjxGAab2KlmzVMuS6KAb3qCMKdWysy9xeoNlG8BFQSek
         b04lC9QS+wpSrHBz7d8GnlZ8AnVmDCC6pek4XiuHMlj3gZCcGTJ9V/0eJ0cWQaaA764a
         eWTapr0gpoYqVPYzOVksrN6fNICaCu25VeDDqeJz1pYA625B8kWGqmaxah/5Fzie1ryI
         z3Og==
X-Forwarded-Encrypted: i=1; AJvYcCVtxUO03uI9E0+edbh5aXWgRSa//hiD0jeZlk/4hp0t1I9kBZrFa0vhIFmIGsr/lELIRiX/4RLTv28RSPz3Kg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyebZEuWOHgNLvNRrjNPnj2zu4kwEbULEtjn4shHh3usle5JyFa
	sinNt9wL2KXNVGOFtuwDKmiHtmxXgRWu/aVw3OpV54962abfGiLGK4S01O08Ux4Ofg99Jm6EaDI
	K1j+L64ajmHSWRl2S1VFi9m1pDm4=
X-Google-Smtp-Source: AGHT+IFclKvq9CgocI4k5e6wl7aLHjazA02xjCsgy2N/rN/swL8vf/cOS87Uaf0R50FfdZ9+2VNUItD5IA3I6PEkM58=
X-Received: by 2002:a05:6402:348f:b0:5be:ed8c:de7 with SMTP id
 4fb4d7f45d1cf-5c21ed3e14bmr2812108a12.11.1724941636724; Thu, 29 Aug 2024
 07:27:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240829141844.39064-1-pstanner@redhat.com> <20240829141844.39064-7-pstanner@redhat.com>
 <20240829102320-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240829102320-mutt-send-email-mst@kernel.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 29 Aug 2024 17:26:39 +0300
Message-ID: <CAHp75Ve7O6eAiNx0+v_SNR2vuYgnkeWrPD1Umb1afS3pf7m8MQ@mail.gmail.com>
Subject: Re: [PATCH v5 6/7] vdpa: solidrun: Fix UB bug with devres
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Philipp Stanner <pstanner@redhat.com>, Jens Axboe <axboe@kernel.dk>, Wu Hao <hao.wu@intel.com>, 
	Tom Rix <trix@redhat.com>, Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>, 
	Andy Shevchenko <andy@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Alvaro Karsz <alvaro.karsz@solid-run.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Richard Cochran <richardcochran@gmail.com>, Damien Le Moal <dlemoal@kernel.org>, 
	Hannes Reinecke <hare@suse.de>, John Garry <john.g.garry@oracle.com>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org, 
	linux-gpio@vger.kernel.org, netdev@vger.kernel.org, linux-pci@vger.kernel.org, 
	virtualization@lists.linux.dev, stable@vger.kernel.org, 
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 5:23=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Thu, Aug 29, 2024 at 04:16:25PM +0200, Philipp Stanner wrote:
> > In psnet_open_pf_bar() and snet_open_vf_bar() a string later passed to
> > pcim_iomap_regions() is placed on the stack. Neither
> > pcim_iomap_regions() nor the functions it calls copy that string.
> >
> > Should the string later ever be used, this, consequently, causes
> > undefined behavior since the stack frame will by then have disappeared.
> >
> > Fix the bug by allocating the strings on the heap through
> > devm_kasprintf().
> >
> > Cc: stable@vger.kernel.org    # v6.3
> > Fixes: 51a8f9d7f587 ("virtio: vdpa: new SolidNET DPU driver.")
> > Reported-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > Closes: https://lore.kernel.org/all/74e9109a-ac59-49e2-9b1d-d825c9c9f89=
1@wanadoo.fr/
> > Suggested-by: Andy Shevchenko <andy@kernel.org>
> > Signed-off-by: Philipp Stanner <pstanner@redhat.com>
>
> Post this separately, so I can apply?

Don't you use `b4`? With it it as simple as

  b4 am -P 6 $MSG_ID_OF_THIS_SERIES

--=20
With Best Regards,
Andy Shevchenko
