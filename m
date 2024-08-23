Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC4A13D2A4
	for <virtualization@lists.linux.dev>; Fri, 23 Aug 2024 09:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724405359; cv=none; b=oerv7xmfG63m9kkX8BTWCGIWjz7+Z7Gt+HJvh65s2ghD0BijnBR2fsSKbcm4dUmvFGh9BHgOQysRq4sGQE5WP+/AB/RHguI3RFlA3c5BSgzR3d6mKk9wyDHy8+P4kdQpOmdiBHQxsNrPQl2A2tcOAc4p46Hc2G51bEOSS5Advn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724405359; c=relaxed/simple;
	bh=2Yb/HipWs9Hwj3qIpBvkIqiRNPZPBVsVKcsw8IFvcmc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j9YIkjdxp1SShJAwSOn58PPTEZuemQiRcXiHBbnF98xrp9BPrtqi1FeBm08jBFcmCjdk9CrPVgraN6mb2dkUjWibgUAnRVDlMWBsvXQAShKO/lXKlvdrxXcpnsZVmQjOJcplRqe0tAEsNm7GLCfXj+kMVVhTktSgBwVisOk/zJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S1r4BDYt; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S1r4BDYt"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-533488ffaf7so2337640e87.0
        for <virtualization@lists.linux.dev>; Fri, 23 Aug 2024 02:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724405354; x=1725010154; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HJZgnLkJ3O5ij2lr4uMh4xPM1CMCZfKHy3jKVr/xmOI=;
        b=S1r4BDYtxZbjgsSDeS6ItItUV+pfjoOex0ztucBFo1qz/d++LjQTBuQq4qkmVReL/8
         Xj8sOoDk7CCKZO4Yu+/imx+aTjEQbdGciw6SWMVG5SjLyFOn4etSXYPTZManExo9UkWU
         yDQkDiw32L4Ppa+RkkBvVoiw7u8IovpJwVBpRRBqt59JgKUb9m/GssJ6SZIh1yYPlnCo
         Y6hM6/1CurLaRwKQj9exXVXwJOOShenJYjM1wISFwetVF7ZrT2/MHSMzkYwFR/0o52Q5
         nVrGvss8Lef4Xs10+om6ZzzKjLCIf5bjVs/nlJa0UNHdgeCKh3Qx/50Ae8BkU7HqGFz4
         GzNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724405354; x=1725010154;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HJZgnLkJ3O5ij2lr4uMh4xPM1CMCZfKHy3jKVr/xmOI=;
        b=qlmnhija1zTfRsao/rdccGneJjDl/Ghf3HzvtJirpjBB12eQoxfi6l5+PxRmDomHEr
         bEkaOdcCqxK6f89vdG5YsQCrJVOy9pElFMuETjqcfm81rW3XuYHkdJfaGaoikcUzIvSd
         w6sxipPWwu3WHu1QYdHk4/OrsoyjvO4+zGMsM0MGl5g6aAJakv8DA7EieUP/uyq9zotg
         38bXDgJFdFljdknx9/mcJVdpmWXhwwffzyYUC+GpHMa3RoFXidmSZ1/zDvLMzZWpwq+1
         yKNIDIFJwQFP2gJ8QJZ143TKRDqTD0itzUCQvKSP/cvK6rEqQxqQpiK/GrhOherZFVIM
         cwpw==
X-Forwarded-Encrypted: i=1; AJvYcCXWnu6ZxT29MQgjM1G9JpIHqkp0w2aoOSBQRU4j04E+FOSGel11P6zw2AkrnyLsEUqdG7GGIqTKOi9qPm/ZJA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxuCJYhq27KLPB+KR7vRDKXDw2dLH+NS44SwajVQUAb1gBlxFJq
	kpFJfNK89l0CGQdlegsurR/vdamINJHhQSGpbz9YtGFh0Db2eLGK
X-Google-Smtp-Source: AGHT+IHqOXJOWHb79RTihzE3on1iV74tjWvNfm3tTmK51dxtJorj4SeUP8Xl+KghIyqpPSU2ZAidYw==
X-Received: by 2002:a05:6512:ba2:b0:533:3223:df91 with SMTP id 2adb3069b0e04-53438773a9emr1245520e87.24.1724405353307;
        Fri, 23 Aug 2024 02:29:13 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5334ea5d9e6sm494618e87.226.2024.08.23.02.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 02:29:12 -0700 (PDT)
Date: Fri, 23 Aug 2024 12:29:09 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Philipp Stanner <pstanner@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>, 
	Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>, Moritz Fischer <mdf@kernel.org>, 
	Xu Yilun <yilun.xu@intel.com>, Andy Shevchenko <andy@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Alvaro Karsz <alvaro.karsz@solid-run.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Richard Cochran <richardcochran@gmail.com>, 
	Mark Brown <broonie@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Damien Le Moal <dlemoal@kernel.org>, 
	Hannes Reinecke <hare@suse.de>, Chaitanya Kulkarni <kch@nvidia.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, linux-fpga@vger.kernel.org, 
	linux-gpio@vger.kernel.org, netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH v3 6/9] ethernet: stmicro: Simplify PCI devres usage
Message-ID: <6q4pcpyqqt6mhj422pfkgggvwu7jhweu5446y6prcjgjql6xeq@jztt7z4fr6rg>
References: <20240822134744.44919-1-pstanner@redhat.com>
 <20240822134744.44919-7-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822134744.44919-7-pstanner@redhat.com>

Hi Philipp

On Thu, Aug 22, 2024 at 03:47:38PM +0200, Philipp Stanner wrote:
> stmicro uses PCI devres in the wrong way. Resources requested
> through pcim_* functions don't need to be cleaned up manually in the
> remove() callback or in the error unwind path of a probe() function.
> 
> Moreover, there is an unnecessary loop which only requests and ioremaps
> BAR 0, but iterates over all BARs nevertheless.
> 
> Furthermore, pcim_iomap_regions() and pcim_iomap_table() have been
> deprecated by the PCI subsystem in commit e354bb84a4c1 ("PCI: Deprecate
> pcim_iomap_table(), pcim_iomap_regions_request_all()").
> 
> Replace these functions with pcim_iomap_region().
> 
> Remove the unnecessary manual pcim_* cleanup calls.
> 
> Remove the unnecessary loop over all BARs.
> 
> Signed-off-by: Philipp Stanner <pstanner@redhat.com>

Thanks for the series. But please note the network subsystem
dev-process requires to submit the cleanup/feature changes on top of
the net-next tree:
https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/

Just recently a Yanteng' (+cc) series
https://lore.kernel.org/netdev/cover.1723014611.git.siyanteng@loongson.cn/
was merged in which significantly refactored the Loongson MAC driver.
Seeing your patch isn't based on these changes, there is a high
probability that the patch won't get cleanly applied onto the
net-next tree. So please either rebase your patch onto the net-next
tree, or at least merge in the Yanteng' series in your tree and
rebase the patch onto it and let's hope there have been no other
conflicting patches merged in into the net-next tree.

-Serge(y)


> ---
>  .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 25 +++++--------------
>  .../net/ethernet/stmicro/stmmac/stmmac_pci.c  | 18 +++++--------
>  2 files changed, 12 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> index 9e40c28d453a..5d42a9fad672 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> @@ -50,7 +50,7 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
>  	struct plat_stmmacenet_data *plat;
>  	struct stmmac_resources res;
>  	struct device_node *np;
> -	int ret, i, phy_mode;
> +	int ret, phy_mode;
>  
>  	np = dev_of_node(&pdev->dev);
>  
> @@ -88,14 +88,11 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
>  		goto err_put_node;
>  	}
>  
> -	/* Get the base address of device */
> -	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
> -		if (pci_resource_len(pdev, i) == 0)
> -			continue;
> -		ret = pcim_iomap_regions(pdev, BIT(0), pci_name(pdev));
> -		if (ret)
> -			goto err_disable_device;
> -		break;
> +	memset(&res, 0, sizeof(res));
> +	res.addr = pcim_iomap_region(pdev, 0, pci_name(pdev));
> +	if (IS_ERR(res.addr)) {
> +		ret = PTR_ERR(res.addr);
> +		goto err_disable_device;
>  	}
>  
>  	plat->bus_id = of_alias_get_id(np, "ethernet");
> @@ -116,8 +113,6 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
>  
>  	loongson_default_data(plat);
>  	pci_enable_msi(pdev);
> -	memset(&res, 0, sizeof(res));
> -	res.addr = pcim_iomap_table(pdev)[0];
>  
>  	res.irq = of_irq_get_byname(np, "macirq");
>  	if (res.irq < 0) {
> @@ -158,18 +153,10 @@ static void loongson_dwmac_remove(struct pci_dev *pdev)
>  {
>  	struct net_device *ndev = dev_get_drvdata(&pdev->dev);
>  	struct stmmac_priv *priv = netdev_priv(ndev);
> -	int i;
>  
>  	of_node_put(priv->plat->mdio_node);
>  	stmmac_dvr_remove(&pdev->dev);
>  
> -	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
> -		if (pci_resource_len(pdev, i) == 0)
> -			continue;
> -		pcim_iounmap_regions(pdev, BIT(i));
> -		break;
> -	}
> -
>  	pci_disable_msi(pdev);
>  	pci_disable_device(pdev);
>  }
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
> index 352b01678c22..f89a8a54c4e8 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
> @@ -188,11 +188,11 @@ static int stmmac_pci_probe(struct pci_dev *pdev,
>  		return ret;
>  	}
>  
> -	/* Get the base address of device */
> +	/* Request the base address BAR of device */
>  	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
>  		if (pci_resource_len(pdev, i) == 0)
>  			continue;
> -		ret = pcim_iomap_regions(pdev, BIT(i), pci_name(pdev));
> +		ret = pcim_request_region(pdev, i, pci_name(pdev));
>  		if (ret)
>  			return ret;
>  		break;
> @@ -205,7 +205,10 @@ static int stmmac_pci_probe(struct pci_dev *pdev,
>  		return ret;
>  
>  	memset(&res, 0, sizeof(res));
> -	res.addr = pcim_iomap_table(pdev)[i];
> +	/* Get the base address of device */
> +	res.addr = pcim_iomap(pdev, i, 0);
> +	if (!res.addr)
> +		return -ENOMEM;
>  	res.wol_irq = pdev->irq;
>  	res.irq = pdev->irq;
>  
> @@ -231,16 +234,7 @@ static int stmmac_pci_probe(struct pci_dev *pdev,
>   */
>  static void stmmac_pci_remove(struct pci_dev *pdev)
>  {
> -	int i;
> -
>  	stmmac_dvr_remove(&pdev->dev);
> -
> -	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
> -		if (pci_resource_len(pdev, i) == 0)
> -			continue;
> -		pcim_iounmap_regions(pdev, BIT(i));
> -		break;
> -	}
>  }
>  
>  static int __maybe_unused stmmac_pci_suspend(struct device *dev)
> -- 
> 2.46.0
> 
> 
