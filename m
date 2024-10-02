Received: from bout3.ijzerbout.nl (bout3.ijzerbout.nl [136.144.140.114])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97ED1216A27
	for <virtualization@lists.linux.dev>; Wed,  2 Oct 2024 20:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.144.140.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727899214; cv=none; b=bCTzKQYFNcFYm5IRViRlOOrnBQCuxUGMhtpy0LLK3HjTgK6ZleZfR4f1yzicJbuNtT+AobRHXPoxQX1PeCsBf4W/M4mKWarXFJ0xaQ2wPsThEOdEbUo5ZtbSlipOeePuajPTzW/p96GATiOMpp1OYLmaVhcKYSU1pksJ1dUw7mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727899214; c=relaxed/simple;
	bh=6jXGqPA9icQON+2qUMEIWGFMY1G1Nce2lQUI+V7Tc68=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M+t4E1RAoqC9LPzg9cn9hzU2g9PofBgY1RoPc8OKh1ayz20w2PQJr9nXM7APKXxuDfsbIM1DKPAEuGMyhtDk3Ju3nSrV/Z9aIGRnyeZ6xDw4LrX1Il1Q+Du5eHi9iVHfyyNq80Cs5OBNPyV9xLMMOfnDSNafvuNeckXybW4VJ/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ijzerbout.nl; spf=pass smtp.mailfrom=ijzerbout.nl; dkim=pass (4096-bit key) header.d=ijzerbout.nl header.i=@ijzerbout.nl header.b=cti754Bi; arc=none smtp.client-ip=136.144.140.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ijzerbout.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ijzerbout.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=ijzerbout.nl header.i=@ijzerbout.nl header.b="cti754Bi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ijzerbout.nl; s=key;
	t=1727899210; bh=6jXGqPA9icQON+2qUMEIWGFMY1G1Nce2lQUI+V7Tc68=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cti754BiNGiqPmmDLcm859T4xFOaF/geEYlROxC+xmyZdrXOzgOv5aCphQqn6KKnD
	 5nY2VNvHQon7P/zDCZyp5He4U0U7iUd2h9mf82wp+OenhqudI2QcHKwDJVg3veNW4z
	 TiEIrMjlmfjrtOzk8VdD3Jg88/12sPqkbgb3YMTcrcV3ZLH4J6C3q0HrEwb3yDgXZi
	 0BswYasw6Dh2/szYUORkMbGqKj4KiagtFbu+xAoPrsVf4Nkzq3g60/dqW5wp1f4eVG
	 pYFxtOpzNbQmZduxqQlrtXKTNkAgD2EfoXcx03wHh9GTsC0/qFPlH+mUU/d8bJRT+l
	 Ln8dPpCoFA9c342cJfrzcJTlR6jhOGFj3eJ/Jya0BMhASrp998ksLZdGXwZQZjJVlY
	 IEaE75b83EJV/kth2Q/djn9mvSg30iNebnMJQZpzZOM/AYMlNT9yz20jid7l4V6wL6
	 39sw/ygQcm+3iHr9qF1bctrcSW+punIKK2rLVVX9myN9uiKyMRqkOKUGidc69fBXoJ
	 Bw7eZKac7/uMHmtUsLpY5Rtb/tHmq456Gx36FPTXMCjheavgDOtml6xez8nCRCiXvQ
	 KRpSHIyHwp81zVKIPp6wxah1UHKWP+p+cNaYABqeD0pDKFm9JLe1na0ftpCl8wlEWm
	 WyDhrzLxx5jhlIRjQgIizmMg=
Received: from [IPV6:2a10:3781:99:1:1ac0:4dff:fea7:ec3a] (racer.ijzerbout.nl [IPv6:2a10:3781:99:1:1ac0:4dff:fea7:ec3a])
	by bout3.ijzerbout.nl (Postfix) with ESMTPSA id 8146918D877;
	Wed,  2 Oct 2024 22:00:10 +0200 (CEST)
Message-ID: <8c5bfc12-cbcc-4102-9826-494060df4179@ijzerbout.nl>
Date: Wed, 2 Oct 2024 22:00:07 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v2,06/10] drm/bochs: Allocate DRM device in struct bochs_device
To: Thomas Zimmermann <tzimmermann@suse.de>, kraxel@redhat.com,
 daniel@ffwll.ch, airlied@gmail.com, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com
Cc: dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev
References: <20240902105546.792625-7-tzimmermann@suse.de>
Content-Language: en-US
From: Kees Bakker <kees@ijzerbout.nl>
In-Reply-To: <20240902105546.792625-7-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Op 02-09-2024 om 12:53 schreef Thomas Zimmermann:
> Allocate an instance of struct drm_device in struct bochs_device. Also
> remove all uses of dev_private from bochs and upcast from the embedded
> instance if necessary.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Acked-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>   drivers/gpu/drm/tiny/bochs.c | 52 +++++++++++++++++-------------------
>   1 file changed, 25 insertions(+), 27 deletions(-)
>
> [...]
> @@ -606,6 +602,7 @@ static const struct dev_pm_ops bochs_pm_ops = {
>   
>   static int bochs_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>   {
> +	struct bochs_device *bochs;
>   	struct drm_device *dev;
>   	unsigned long fbsize;
>   	int ret;
> @@ -620,9 +617,10 @@ static int bochs_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent
>   	if (ret)
>   		return ret;
>   
> -	dev = drm_dev_alloc(&bochs_driver, &pdev->dev);
> -	if (IS_ERR(dev))
> +	bochs = devm_drm_dev_alloc(&pdev->dev, &bochs_driver, struct bochs_device, dev);
> +	if (IS_ERR(bochs))
>   		return PTR_ERR(dev);
> +	dev = &bochs->dev;
The assignment of dev comes after potential use of dev in PTR_ERR(dev).
Did you perhaps meant to have PTR_ERR(&pdev->dev) ?
>   
>   	ret = pcim_enable_device(pdev);
>   	if (ret)
> @@ -630,7 +628,7 @@ static int bochs_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent
>   
>   	pci_set_drvdata(pdev, dev);
>   
> -	ret = bochs_load(dev);
> +	ret = bochs_load(bochs);
>   	if (ret)
>   		goto err_free_dev;
>   

