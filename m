Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8195B15E5DC
	for <virtualization@lists.linux.dev>; Wed, 20 Nov 2024 08:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732089910; cv=none; b=sgdv9lE0NsG9WSPjmHg34rJUgcbP0IaM6SD5Ge/tH4byTdgP23/pdvGMtlqa6aM5yjoUIBRbSahova4njB5Jnofkl/z/b1dkRdgIW2u4uAq4fPHYDG6VmMSOMzuW9fh9MQpoeXMNlkwcGIPXNtPC11Kgqr3Y0a0iCqjtHrPVRhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732089910; c=relaxed/simple;
	bh=8c4RY0owHoz5An/7xGsvontCEb/FG4VsXHaUAG4EBZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hgtjnY8FM+OMMm0l1DL0C1+i2PzQYz/LPwpssv7TYYBqwemUWz8/JcVCtyjwn+tN8TdCq7vMW6WmxXABQ7tq8dxeKGZDAuIPL318RlAqa845cKlTo2794I5wH6ANaXH8x5BYELONd5yTG1ZV2zHc3+hd6Pt4BjWbN1WBdBWMQUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eBwXd0gB; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eBwXd0gB"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4315eeb2601so55217725e9.2
        for <virtualization@lists.linux.dev>; Wed, 20 Nov 2024 00:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732089907; x=1732694707; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jRgDfoaQT9KNI5x6/6yzE+UnJrhXzmTHlyAUFtH2BlU=;
        b=eBwXd0gBM31cF1wwgS12LJ4kyRe21XIQDLhmYJl3tLeXHrNvSsPAf6yCnmB9rpQ3na
         Cpmdu7gwNZtXJB/1WWMMJkM29mdCe7TycDXLEGOFrg81gANb8u6xl4f3C+RUFlXC+82x
         QRl9vUQIwKjMANM5okWOItHwmV72Ow3e9Zfxlip275InDGGeOpMa2XnwkmVBMjbIYaiE
         PTwggOLu6rYzH3dxDxvWSshhuWHjBBGQHgHo6CIx1oUWvRJX2zQ7XbnEkjJyLu2PnM6j
         FER9WNrHOJoQs6wFlLSOKnhQw0WbHs2I0YjqJN2laxNXzuQM2braLV3u2Sxns9FUQr4Z
         Zadw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732089907; x=1732694707;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jRgDfoaQT9KNI5x6/6yzE+UnJrhXzmTHlyAUFtH2BlU=;
        b=qZ6BDNMGZ6wC6XvRdhmj4iTwwJl0rfVhqkQLLkFuHDzxg9E7Vq90lfC92mWHAnXe6k
         MldjwshBOQFldi7ahh/vZU+mBeKO9enBsSRohHi154k9D9JTMA73QHNXdqlP0AWw643g
         ovpIfnbSQE5M7nOKl9mjC8bSX4sSZJMq5Cik1UtkC2flnf2Wd+vspE7SXj6VFxGE77uj
         acOqIRVorzgQ4pkGAembbOMFD7Ks14ZcaFi/jjiCEvWZk9kKABkatD5vXFErcofdx8uM
         QHQL0kraWvHx7AhnMPF0D4YCTQsH97hb18zVTg4S2SFGK1yEdvlmb/aT97iG5ot+NcE8
         0nqw==
X-Gm-Message-State: AOJu0YwM0iW3xS1OK9BITQ//fkegVdPHDW3/15HsLYkJLr7vBuoLrBfb
	TzwR7CYFYCbF+bjD+EKvOW6GYsyPntT2v4uoH2kDS6oGgoqXCE8DG9RnUobuGmQ=
X-Google-Smtp-Source: AGHT+IEFny7M03Y934XV3HYBrb4ejakxQGcLpkJMphiZM1V77YWoi33QS9ejQpOi9Dvb73myIts4lQ==
X-Received: by 2002:a05:600c:1d93:b0:42b:ac3d:3abc with SMTP id 5b1f17b1804b1-4334f01548dmr15750715e9.24.1732089906850;
        Wed, 20 Nov 2024 00:05:06 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-433b4643100sm10021045e9.39.2024.11.20.00.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 00:05:06 -0800 (PST)
Date: Wed, 20 Nov 2024 11:05:02 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Shijith Thotton <sthotton@marvell.com>
Cc: virtualization@lists.linux.dev, mst@redhat.com, jasowang@redhat.com,
	schalla@marvell.com, vattunuru@marvell.com, ndabilpuram@marvell.com,
	jerinj@marvell.com, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Satha Rao <skoteshwar@marvell.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] vdpa/octeon_ep: enable support for multiple
 interrupts per device
Message-ID: <b799bf24-876a-41da-b297-d2323c314674@stanley.mountain>
References: <20241120070508.789508-1-sthotton@marvell.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241120070508.789508-1-sthotton@marvell.com>

On Wed, Nov 20, 2024 at 12:34:50PM +0530, Shijith Thotton wrote:
> @@ -63,44 +80,53 @@ static irqreturn_t octep_vdpa_intr_handler(int irq, void *data)
>  static void octep_free_irqs(struct octep_hw *oct_hw)
>  {
>  	struct pci_dev *pdev = oct_hw->pdev;
> +	int irq;
> +
> +	for (irq = 0; irq < oct_hw->nb_irqs && oct_hw->irqs; irq++) {
> +		if (oct_hw->irqs[irq] < 0)
> +			continue;
>  
> -	if (oct_hw->irq != -1) {
> -		devm_free_irq(&pdev->dev, oct_hw->irq, oct_hw);
> -		oct_hw->irq = -1;
> +		devm_free_irq(&pdev->dev, oct_hw->irqs[irq], oct_hw);
>  	}
> +
>  	pci_free_irq_vectors(pdev);
> +	kfree(oct_hw->irqs);

You should add:

	oct_hw->nb_irqs = 0;
	oct_hw->irqs = NULL;

Otherwise if reset is called twice in a row, before re-initializing the IRQs it
results in a use after free.

>  }
>  
>  static int octep_request_irqs(struct octep_hw *oct_hw)
>  {
>  	struct pci_dev *pdev = oct_hw->pdev;
> -	int ret, irq;
> +	int ret, irq, idx;
>  
> -	/* Currently HW device provisions one IRQ per VF, hence
> -	 * allocate one IRQ for all virtqueues call interface.
> -	 */
> -	ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_MSIX);
> +	ret = pci_alloc_irq_vectors(pdev, 1, oct_hw->nb_irqs, PCI_IRQ_MSIX);
>  	if (ret < 0) {
>  		dev_err(&pdev->dev, "Failed to alloc msix vector");
>  		return ret;
>  	}
>  
> -	snprintf(oct_hw->vqs->msix_name, sizeof(oct_hw->vqs->msix_name),
> -		 OCTEP_VDPA_DRIVER_NAME "-vf-%d", pci_iov_vf_id(pdev));
> +	oct_hw->irqs = kcalloc(oct_hw->nb_irqs, sizeof(int), GFP_KERNEL);

This isn't free on the ->release() path or whatever.  octep_free_irqs() is
called on reset() but we rely on devm_ to free the IRQs on ->release().  Use
devm_kcalloc() here as well, probably.

> +	if (!oct_hw->irqs) {
> +		ret = -ENOMEM;
> +		goto free_irqs;
> +	}
>  
> -	irq = pci_irq_vector(pdev, 0);
> -	ret = devm_request_irq(&pdev->dev, irq, octep_vdpa_intr_handler, 0,
> -			       oct_hw->vqs->msix_name, oct_hw);
> -	if (ret) {
> -		dev_err(&pdev->dev, "Failed to register interrupt handler\n");
> -		goto free_irq_vec;
> +	memset(oct_hw->irqs, -1, sizeof(oct_hw->irqs));

This works, but it would be more normal to just leave it zeroed and check for
zero instead of checking for negatives.  There is never a zero IRQ.  See my blog
for more details:
https://staticthinking.wordpress.com/2023/08/07/writing-a-check-for-zero-irq-error-codes/

regards,
dan carpenter

> +
> +	for (idx = 0; idx < oct_hw->nb_irqs; idx++) {
> +		irq = pci_irq_vector(pdev, idx);
> +		ret = devm_request_irq(&pdev->dev, irq, octep_vdpa_intr_handler, 0,
> +				       dev_name(&pdev->dev), oct_hw);
> +		if (ret) {
> +			dev_err(&pdev->dev, "Failed to register interrupt handler\n");
> +			goto free_irqs;
> +		}
> +		oct_hw->irqs[idx] = irq;
>  	}
> -	oct_hw->irq = irq;
>  
>  	return 0;
>  
> -free_irq_vec:
> -	pci_free_irq_vectors(pdev);
> +free_irqs:
> +	octep_free_irqs(oct_hw);
>  	return ret;
>  }
>  

regards,
dan carpenter
