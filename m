Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261F218A6A9
	for <virtualization@lists.linux.dev>; Mon, 19 Aug 2024 18:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724092757; cv=none; b=BEtY4QGNSEgXPZh1zwJN455QgQhgaTgRAAsszKIh9Ui45WfKCiYhSuZxJYkpYr1/Xa0Igqm0XUa2fDtIOdC2j+H1qWfzyPShVp7DXkbf8LM/XW+6RTVaFmUXnxpuejIEvnfbLxyk8QWbaLa6YOxhge9saGcS6oVMlYRRrM+45xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724092757; c=relaxed/simple;
	bh=SWpGCGgfSTInA73Lkq9d3XSm6SVeqmrSlW6/NUDvBMM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a2LptPXik2s/a3djMc+zKfZ64rjT5B9tTCrgGahKLfBJNZNl+bsQ7RFnaJUFECOd/AOM+Vo1WfTg0t8cutI7RN/cjNYNGaut+jE86UvtUjJKS3w/dVVPFdGNe4bR9Z6TuopSBPZba9JcDqD5ExDjuFJMtxK9Dk1+2OrctjOvQTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=hMJmBHyf; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="hMJmBHyf"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-53310adb4c3so4973499e87.3
        for <virtualization@lists.linux.dev>; Mon, 19 Aug 2024 11:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1724092753; x=1724697553; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SWpGCGgfSTInA73Lkq9d3XSm6SVeqmrSlW6/NUDvBMM=;
        b=hMJmBHyf2wC9+3kBftyZlvKitsye+Dgw6Qw6IK8URbeb+IVbccIgws/qbWvMTYqdqq
         A1M92KBczZBaJoDyF7qRxb5hjSZlIIKyE3BO80cmHqqLZPcDwjY1mMiDOof53n9/Hp2K
         uezqcoHnQwvLTxw29tDXz3gXaMb5kGBKCu5/Gy1q2mplT+hOIXrx0DC0pz19gvEOSMMJ
         sQeP32QzrNRyzv80ksWTDntq3N5sl6gMInhrHG8GT4FGb3pns4aV31FKbuqUQisEnW+6
         3c4qPOzF64G4H9+u8rX0/8dQs8O+xmjy1hT/NMG6bOEoq720ep/jhSOS9alPrzyGhg86
         4RWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724092753; x=1724697553;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SWpGCGgfSTInA73Lkq9d3XSm6SVeqmrSlW6/NUDvBMM=;
        b=lK8Kuw53s1kjz1+Fc/68lkxp7x9IsgjixMWo5q3MrK5Dn+tKap2UbKfQowj0TvuNOJ
         YySIAzEX1FWPUKjrahpPfQV8H7EsdLhC9Z4FdnML7G3OFaN0GUQDH1Klw0+s3rHxW6XQ
         /zkROqzbR8ukKxV+q13dXl59JayCXfqnALhBkQc4bc/V3VPJzXrxD0h2dPg8s8ABAqal
         vqlDsX9Ykc64D4fbPOHz3WL+b0TWnRHHg8qzU44tjSWkT5JY/4Svm2TcrCFEDbPQDpG9
         ASiA4hjzfq7hvMN4BwFQzKRr+m5vtdX+jekEwBeweJbixo5NVlhHm5hWKsLJ2hoRow09
         cM+w==
X-Forwarded-Encrypted: i=1; AJvYcCXMJaqG/ms/47Tiho7yzPpTl5XOVIC9VCxBI049O1njxI3VBunE1slPGzftJ5kRuRrtopIBUCrQDzwtaiplmIR6hmy38uzweopQLUxhPYo=
X-Gm-Message-State: AOJu0YwoxJ8n830w6u1Xx3l0XW9kcLbfnNhut06yzhZcKCGDLmAgb8TR
	GoMJn21ms8jbC4W+bJrC/SDAbxkt6EnJkecVFi/+sQq5VtKTHIb8PrgUd9CBuyVt2U5tJLnVNe7
	d5XgyRwT5KQM2mdREhPLptRpMFmYuBScHYHxhiQ==
X-Google-Smtp-Source: AGHT+IHelUVu+3Ik9JdWKk+zeumpW2YAF7qu0Ohxq5buMaU2cv0DmlPnfzkmnuU6AUlGRzMu60+m9UNlwGENsdtWTIk=
X-Received: by 2002:a05:6512:3e22:b0:533:d3e:16e6 with SMTP id
 2adb3069b0e04-5331c6af14dmr8387737e87.25.1724092752397; Mon, 19 Aug 2024
 11:39:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240819165148.58201-2-pstanner@redhat.com> <20240819165148.58201-7-pstanner@redhat.com>
In-Reply-To: <20240819165148.58201-7-pstanner@redhat.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 19 Aug 2024 20:39:01 +0200
Message-ID: <CAMRc=MdLsLeXqm+40wb4O2PmNX9C-g0is13berDF6yDQ1EBh+w@mail.gmail.com>
Subject: Re: [PATCH 5/9] gpio: Replace deprecated PCI functions
To: Philipp Stanner <pstanner@redhat.com>
Cc: onathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>, Wu Hao <hao.wu@intel.com>, 
	Tom Rix <trix@redhat.com>, Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>, 
	Andy Shevchenko <andy@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Alvaro Karsz <alvaro.karsz@solid-run.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Richard Cochran <richardcochran@gmail.com>, Mark Brown <broonie@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Hannes Reinecke <hare@suse.de>, 
	Damien Le Moal <dlemoal@kernel.org>, Chaitanya Kulkarni <kch@nvidia.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-fpga@vger.kernel.org, linux-gpio@vger.kernel.org, 
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2024 at 6:53=E2=80=AFPM Philipp Stanner <pstanner@redhat.co=
m> wrote:
>
> pcim_iomap_regions() and pcim_iomap_table() have been deprecated by the
> PCI subsystem in commit e354bb84a4c1 ("PCI: Deprecate
> pcim_iomap_table(), pcim_iomap_regions_request_all()").
>
> Replace those functions with calls to pcim_iomap_region().
>
> Signed-off-by: Philipp Stanner <pstanner@redhat.com>
> ---

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
