Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1B81311A7
	for <virtualization@lists.linux.dev>; Mon, 16 Sep 2024 17:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726508602; cv=none; b=FJ6l7o1THKrmAvU4pKBRAgP/rx7WmoEUfNzw+uiAUb5ArSlQ7C0EYb1ykOKIkxcDZcMXCs8gcOKtofMToXeqPrwD7IVW5iJAivcQEwE7im+kL/LlHW8ZfMdN1m8u73NOkT70nDPD7g8+skZlTyYlOIthr6IS4OQBVlaEdT9XPto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726508602; c=relaxed/simple;
	bh=8OnwkAAtyLMbHX/d2AD7xQhnFfrkqpsPEUXl8KM0xYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=qs322KOKnfZJcV13Z7CCtaX6Tb999TaWYVNt77U0FWq41FYuiGFpbtNyvqhn6fsLHGTvr9pcddqCkqUu0oH9+80hxlqLDctI8kB2RF5CSeA3H/zXpq436CyAnglhmudzwCUPjEAWt3fsdLNz8uJVNX0khG8SpNknUAexMDbohBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I96YrfdW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I96YrfdW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726508599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uCk1XgL86unrcgVtQPhtWyTYVBI+613lvcC7IenWH/U=;
	b=I96YrfdWN+m204S1Pr/iSb7ysY9AKCzq73zFovAVVXZvOztsGkHTECuzoqdN2jp9vgiBsL
	jGORZBhzgATxYfnH1BGMr0GBEE6ihtbCfs49saVd3HOl4Wyz1Dn/wlss3BQpEFQxCtnHFM
	sAdkd675/XYfNOWXgkhqyK3c/T43a7I=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-43-yLogNum-PRaoSfg9-pF9rg-1; Mon, 16 Sep 2024 13:43:18 -0400
X-MC-Unique: yLogNum-PRaoSfg9-pF9rg-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42cb6f3c476so36546135e9.0
        for <virtualization@lists.linux.dev>; Mon, 16 Sep 2024 10:43:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726508597; x=1727113397;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uCk1XgL86unrcgVtQPhtWyTYVBI+613lvcC7IenWH/U=;
        b=DHs2b3O19m8d4jLWb87c5qA9FBYPKa9XlDYY+zVUtJ150XDthc49uMGfmBMC1OmQoL
         9qbzZjZUl3VwUd5/3xiLEY51GDaZcQu/H/PcLauY7nvcmIJ7+b/IGb0AUpUNXHuzj1m+
         CDv/1cTpNBq5713jpnlz9EngOmOEj7i1GqkvDNzslLiA5sa+gw/c/WjamIdSb24VweWx
         rLyAWnlxTnHmTAQ8ogVmkMElWVsE8gALzexf+Dh00exXECty0GdslII2yjYurD/0Vtbq
         NONOfajamUFazH4PS8W3cn/lwGMAYGYQ6KIWiNsS5E3zX3Nr5hSal6539EwC6ITXKgkR
         sGbg==
X-Gm-Message-State: AOJu0YzZbo4X9bA9kT6N3QbkB9xYvaCeytlVWtijCvKAvQNDDu+8cElL
	U+PIGxSDnPC3pxdIKkqgoSMYVCtHFeQ+4jMZNQURpwwAmf7AJpBprRhe14ZJcXjl2nHMq4vo+YB
	vwMcR2ft9TlIhrSyHLRkv66aOGkKR8Van39bZu2d7MGcproo1PRHerZWubUBHPosY
X-Received: by 2002:a05:600c:5127:b0:42c:a574:6360 with SMTP id 5b1f17b1804b1-42cdb5790c1mr127588795e9.29.1726508597343;
        Mon, 16 Sep 2024 10:43:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCZN3HM3JtX/OIv7ioZlvEd5G2Kw3kie9GelPLUbjU/bKj57de+xe8Gz7BaRKfwUa2FIC+tQ==
X-Received: by 2002:a05:600c:5127:b0:42c:a574:6360 with SMTP id 5b1f17b1804b1-42cdb5790c1mr127588585e9.29.1726508596729;
        Mon, 16 Sep 2024 10:43:16 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1ec:9b4:46f5:ba16:343e:7485])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42d9b189986sm115799925e9.29.2024.09.16.10.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 10:43:11 -0700 (PDT)
Date: Mon, 16 Sep 2024 13:43:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Srujana Challa <schalla@marvell.com>
Cc: virtualization@lists.linux.dev, jasowang@redhat.com,
	dan.carpenter@linaro.org, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, ndabilpuram@marvell.com, vattunuru@marvell.com,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] vdpa/octeon_ep: Fix format specifier for pointers in
 debug messages
Message-ID: <20240916134226-mutt-send-email-mst@kernel.org>
References: <20240916162255.677774-1-schalla@marvell.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240916162255.677774-1-schalla@marvell.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 16, 2024 at 09:52:55PM +0530, Srujana Challa wrote:
> Updates the debug messages in octep_vdpa_hw.c to use the %p format
> specifier for pointers instead of casting them to u64.
> 
> Fixes smatch warning:
> octep_hw_caps_read() warn: argument 3 to %016llx specifier is cast
> from pointer
> 
> Fixes: 8b6c724cdab8 ("virtio: vdpa: vDPA driver for Marvell OCTEON DPU devices")
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes:https://urldefense.proofpoint.com/v2/url?u=https-3A__lore.kernel.org_r_202409160431.bRhZWhiU-2Dlkp-40intel.com_&d=DwIBAg&c=nKjWec2b6R0mOyPaz7xtfQ&r=Fj4OoD5hcKFpANhTWdwQzjT1Jpf7veC5263T47JVpnc&m=qyhlWh2lFE3SPFpB_eJ0K1RFMa5f-kcNChFHkCARDCXIkzMk__3sqspP_K7KGxaj&s=fMvS62XMmi5HESJuL9v7FX3c8RSzKCq7JM6Khcof4vM&e=
> Signed-off-by: Srujana Challa <schalla@marvell.com>



This does not fix it completely.
ret is still 0 here:

8b6c724cdab85d Srujana Challa 2024-06-14  140  	val = octep_read_sig(mbox);
8b6c724cdab85d Srujana Challa 2024-06-14  141  	if ((val & 0xFFFF) != MBOX_RSP_SIG) {
8b6c724cdab85d Srujana Challa 2024-06-14  142  		dev_warn(&pdev->dev, "Invalid Signature from mbox : %d response\n", id);
8b6c724cdab85d Srujana Challa 2024-06-14 @143  		return ret;
8b6c724cdab85d Srujana Challa 2024-06-14  144  	}


which is wrong.


> ---
>  drivers/vdpa/octeon_ep/octep_vdpa_hw.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/vdpa/octeon_ep/octep_vdpa_hw.c b/drivers/vdpa/octeon_ep/octep_vdpa_hw.c
> index 11bd76ae18cf..1d4767b33315 100644
> --- a/drivers/vdpa/octeon_ep/octep_vdpa_hw.c
> +++ b/drivers/vdpa/octeon_ep/octep_vdpa_hw.c
> @@ -475,11 +475,11 @@ int octep_hw_caps_read(struct octep_hw *oct_hw, struct pci_dev *pdev)
>  		dev_err(dev, "Incomplete PCI capabilities");
>  		return -EIO;
>  	}
> -	dev_info(dev, "common cfg mapped at: 0x%016llx\n", (u64)(uintptr_t)oct_hw->common_cfg);
> -	dev_info(dev, "device cfg mapped at: 0x%016llx\n", (u64)(uintptr_t)oct_hw->dev_cfg);
> -	dev_info(dev, "isr cfg mapped at: 0x%016llx\n", (u64)(uintptr_t)oct_hw->isr);
> -	dev_info(dev, "notify base: 0x%016llx, notify off multiplier: %u\n",
> -		 (u64)(uintptr_t)oct_hw->notify_base, oct_hw->notify_off_multiplier);
> +	dev_info(dev, "common cfg mapped at: %p\n", oct_hw->common_cfg);
> +	dev_info(dev, "device cfg mapped at: %p\n", oct_hw->dev_cfg);
> +	dev_info(dev, "isr cfg mapped at: %p\n", oct_hw->isr);
> +	dev_info(dev, "notify base: %p, notify off multiplier: %u\n",
> +		 oct_hw->notify_base, oct_hw->notify_off_multiplier);
>  
>  	oct_hw->config_size = octep_get_config_size(oct_hw);
>  	oct_hw->features = octep_hw_get_dev_features(oct_hw);
> @@ -511,7 +511,7 @@ int octep_hw_caps_read(struct octep_hw *oct_hw, struct pci_dev *pdev)
>  	}
>  	mbox = octep_get_mbox(oct_hw);
>  	octep_mbox_init(mbox);
> -	dev_info(dev, "mbox mapped at: 0x%016llx\n", (u64)(uintptr_t)mbox);
> +	dev_info(dev, "mbox mapped at: %p\n", mbox);
>  
>  	return 0;
>  }
> -- 
> 2.25.1

