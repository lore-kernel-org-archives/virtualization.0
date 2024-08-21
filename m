Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980CC1531D3
	for <virtualization@lists.linux.dev>; Wed, 21 Aug 2024 12:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724242390; cv=none; b=gpDAmStqCJPswKT7oGgaVVr8yisogU6MUlIocAcbC09jaCfM7Bver80P2v1zspSFie2xXS4ae8tKsnlH3XBYzuTRUgmG2qJvffb+okSk6RFAmAn/2kC3EDcpW+7O251P6qqqs8FVjpQwRHMbayJllw/Ps/2lQOwzA6np0MQSUbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724242390; c=relaxed/simple;
	bh=DDWu1HqNHaS6DMEZKuJATbXl4MjOmQ8bHx+zMGTvh/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=HPTgqxgcYkpuZNBHJTjo6NqQ//C/cQGzpAp+GRENjw1Y8NO9i2XkM3Paw3qt0K58BYOeDpbHafN4XVTtEKnVxdczhWziRt2JKFzF6qRi4vrGNq7v8wK/gZB6NH5Qdc4aoMVW4ZyuCk+VtxGaVvXbty+ignUZwzTGxBDd5oAmtOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UubX1HUw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UubX1HUw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724242387;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TSBk3tiwYk5OG97kBGDXG+0Y8CDnp1Ut323qDsoZ2kI=;
	b=UubX1HUwYa45/kCYyMuP4bMoTnXAxmkfvv9ke/B2KIaWGjgjUIHdFR6c4ur2eiUcEc0zsD
	YaxBHptZpNQ7R9us+priZQ1xU2IInkNS1T5cvFWU+s2O1HzpLzZvkZQcb9iqEo8flOxjlt
	UU+Rry0hGSs5VhDMgF5xSd/CzfeN6WQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-nVPnIz6hNAeOxTQQyHMGQw-1; Wed, 21 Aug 2024 08:13:06 -0400
X-MC-Unique: nVPnIz6hNAeOxTQQyHMGQw-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3719cee43abso2771105f8f.0
        for <virtualization@lists.linux.dev>; Wed, 21 Aug 2024 05:13:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724242385; x=1724847185;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TSBk3tiwYk5OG97kBGDXG+0Y8CDnp1Ut323qDsoZ2kI=;
        b=nMCKgzjq2+qzEOrWUAkqQVe7YG6m9lOpG4sLzABQ0BE6sFhUpg3gk/FXy5Po05EyaT
         XSSQD/++LmG2ZkHnu/1ETEHy+ixUX2TUOM5iyfyfrrxyt3JVC2xyYGxmG/drZLrbofxi
         wOJ3Rph3vKPbWWz9AK1nb6QOTXSTh8c6WBmQXvrqAfxk8NATmEbWGvmcNzSXgLe+wAsN
         m32g4ly6JQPFD0UIttc+JB0g0FZ9FcWCcBy2hQqmCKb/SSp5Nnjm9CYCaLQBcC3PszBx
         rHCq1MK5NNRX4FOjOcImg/FMRUdFUVZldbI1kmUbZOReON5phEc6HZ6MeoSDnHXZ1SqT
         u4Xw==
X-Forwarded-Encrypted: i=1; AJvYcCW0kro2RPFgo2/CzN+mcgsHw4oGjDwhnuAkvqOlYi/hG9esJWogAMPSj/HaFU+SuAJxVWPmbLgS+yc+ESqhOg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyr4wulE49flUcAu11P98+cet3xO6d35fRueKU5s2uhHzPGtLF0
	M6Nsigqx30MqvF0A+tjxB7JJ6YvqkSSl6Uqnr875vBJV91jwNl66+BmuI1d7hyNfCwupEgqmwn1
	ImMH606OWMTw1sUQ5zU+HCUqnfxDPAiwT+qlyRN2N27mUlK8z0Di7PZGDKJdjT4hF
X-Received: by 2002:adf:f005:0:b0:371:8a8e:bf34 with SMTP id ffacd0b85a97d-372fd92b361mr1353647f8f.62.1724242385052;
        Wed, 21 Aug 2024 05:13:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMB/ggUo/vRUxhw5fu4gZQwLE961KLd/t4ur3YDaHKN+uT6R+5KIUihWYpnfVR7FqX1I8YOw==
X-Received: by 2002:adf:f005:0:b0:371:8a8e:bf34 with SMTP id ffacd0b85a97d-372fd92b361mr1353594f8f.62.1724242384136;
        Wed, 21 Aug 2024 05:13:04 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:443:61f9:60b2:d178:7b81:4387])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42abefa20b9sm23302285e9.30.2024.08.21.05.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 05:13:03 -0700 (PDT)
Date: Wed, 21 Aug 2024 08:12:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Philipp Stanner <pstanner@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>,
	Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
	Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
	Andy Shevchenko <andy@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Alvaro Karsz <alvaro.karsz@solid-run.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Damien Le Moal <dlemoal@kernel.org>, Hannes Reinecke <hare@suse.de>,
	Keith Busch <kbusch@kernel.org>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-fpga@vger.kernel.org, linux-gpio@vger.kernel.org,
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	virtualization@lists.linux.dev, stable@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH v2 7/9] vdpa: solidrun: Fix potential UB bug with devres
Message-ID: <20240821081213-mutt-send-email-mst@kernel.org>
References: <20240821071842.8591-2-pstanner@redhat.com>
 <20240821071842.8591-9-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240821071842.8591-9-pstanner@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 21, 2024 at 09:18:40AM +0200, Philipp Stanner wrote:
> In psnet_open_pf_bar() a string later passed to pcim_iomap_regions() is
> placed on the stack. Neither pcim_iomap_regions() nor the functions it
> calls copy that string.
> 
> Should the string later ever be used, this, consequently, causes
> undefined behavior since the stack frame will by then have disappeared.
> 
> Fix the bug by allocating the string on the heap through
> devm_kasprintf().
> 
> Cc: stable@vger.kernel.org	# v6.3
> Fixes: 51a8f9d7f587 ("virtio: vdpa: new SolidNET DPU driver.")
> Reported-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Closes: https://lore.kernel.org/all/74e9109a-ac59-49e2-9b1d-d825c9c9f891@wanadoo.fr/
> Suggested-by: Andy Shevchenko <andy@kernel.org>
> Signed-off-by: Philipp Stanner <pstanner@redhat.com>

I don't get why is this a part of a cleanup series -
looks like an unrelated bugfix?


> ---
>  drivers/vdpa/solidrun/snet_main.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/vdpa/solidrun/snet_main.c b/drivers/vdpa/solidrun/snet_main.c
> index 99428a04068d..4d42a05d70fc 100644
> --- a/drivers/vdpa/solidrun/snet_main.c
> +++ b/drivers/vdpa/solidrun/snet_main.c
> @@ -555,7 +555,7 @@ static const struct vdpa_config_ops snet_config_ops = {
>  
>  static int psnet_open_pf_bar(struct pci_dev *pdev, struct psnet *psnet)
>  {
> -	char name[50];
> +	char *name;
>  	int ret, i, mask = 0;
>  	/* We don't know which BAR will be used to communicate..
>  	 * We will map every bar with len > 0.
> @@ -573,7 +573,10 @@ static int psnet_open_pf_bar(struct pci_dev *pdev, struct psnet *psnet)
>  		return -ENODEV;
>  	}
>  
> -	snprintf(name, sizeof(name), "psnet[%s]-bars", pci_name(pdev));
> +	name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "psnet[%s]-bars", pci_name(pdev));
> +	if (!name)
> +		return -ENOMEM;
> +
>  	ret = pcim_iomap_regions(pdev, mask, name);
>  	if (ret) {
>  		SNET_ERR(pdev, "Failed to request and map PCI BARs\n");
> -- 
> 2.46.0

