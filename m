Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1083BBE3
	for <virtualization@lists.linux.dev>; Mon, 16 Sep 2024 17:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726508652; cv=none; b=VAmhOg2dPgdpAVAaIxbVQk3aeUi8eDO55Ym45K6EL247Xyuk+9RzzQnnVTq2VQTYgTpoo8OikYENSq9BBKnkyxl0prCN/Y6Eka79aaeM+0ROFciBhW38ybD0cfseIrRFoMWngxQ9Ic+gUBtHmSmqRfGwRDrwFtwXFOgJqomb/Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726508652; c=relaxed/simple;
	bh=hWVOzdn20bOErgLKy6y6UlAiUrwBbYaQbpg0yn7iHdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=DyFO13Ubh0gBfKakbjz9NRZACWEwLsXG+jogVlCgqQzPwxifhGsHBnvAKLEJUY7ycnc/YHDld4z8goRQjVzXUKuobbf/FVuKU2O/dmoDbZEKQF9u6RqrXdRPbZCB+Htd8dbRqaFFaS+fJXo9FiVNKjKVWstumIi3L5m9ch5IPTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hJS0Gaeu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hJS0Gaeu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726508650;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=INg4khr8dRtHH1CaEXLHhPaEVOhD4Be3fkguZjyG2IM=;
	b=hJS0Gaeu2R1pzKI4qL+txvT4FNTG5vxMJi+O5pvVf6RVKp6K5LJk+ssYICxtITdmIpxxvt
	q0H3YqTBDqCgrwQ39rzxYhqQzbxcKfPgcw/uSJK/TUGUFfFY/MCwg7SBsDKphCzP9GbOzB
	Ni78LhO8G/20lWoAQvz2AhN7cpDO24s=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-378-hlAd4gcbNACRqivTJA6ywg-1; Mon, 16 Sep 2024 13:44:06 -0400
X-MC-Unique: hlAd4gcbNACRqivTJA6ywg-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-378929f1a4eso2580234f8f.1
        for <virtualization@lists.linux.dev>; Mon, 16 Sep 2024 10:44:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726508645; x=1727113445;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=INg4khr8dRtHH1CaEXLHhPaEVOhD4Be3fkguZjyG2IM=;
        b=KBwZbRpb5XsasinfBd177NjshvqUTXPmvGXXhnJDcdOElEJNQE2ILXzgdy1srtfzeU
         ZJqLoEiBGbmn/MzNXmwUTNfuJB+oVW1KQ0joCE2QlVJ8YtZuNko9PhQ97CxAbdnS2Ez9
         0EsyLQpyhGxvw3VpgDyKMPJXipZebvhZoOJqfxUG1PinPcAeCUGTU8EedYYaWujDxCE4
         CLP3MuuP3Xrgy+7rWrZ3Lyr77niYoAk995d09mPQK11+U+iCOFhghUNDDxMOIvJTW7Hy
         rwFvhXlqruBf6zvvklYzLgIt/ChxvqaXjORla+pNDNiFdg41v57EsuTJw/Ez62sTMD1N
         k5fA==
X-Gm-Message-State: AOJu0YyBsUNgLaYaeabLCfrK1P10oiyUacbEirpMR5OaweBE4BxeVRrD
	9siJQv4WR38EIUFQZjOFYDQKZc6gIepbpujHt5zV4erj9yOswsqqyd3uXIQulXcWGu1nGr3y9oA
	+cMHIUYYUobSLf4nMpQho3tiRnOh1p6rzOmaqjtgbbL4zZqznpBVPrPYJTKMJ6dun
X-Received: by 2002:a05:6000:18a9:b0:374:c6af:165f with SMTP id ffacd0b85a97d-378c2cfec9fmr12437584f8f.12.1726508645426;
        Mon, 16 Sep 2024 10:44:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZkxTT98YRe8cAh3uhFq3bu1pJ2E0ExuFG09Fyr24EB5dzylkfypctBPCGvxQ2zTyX4ff8Dw==
X-Received: by 2002:a05:6000:18a9:b0:374:c6af:165f with SMTP id ffacd0b85a97d-378c2cfec9fmr12437546f8f.12.1726508644392;
        Mon, 16 Sep 2024 10:44:04 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1ec:9b4:46f5:ba16:343e:7485])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e6f2486esm7872015f8f.0.2024.09.16.10.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 10:44:03 -0700 (PDT)
Date: Mon, 16 Sep 2024 13:43:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Srujana Challa <schalla@marvell.com>
Cc: virtualization@lists.linux.dev, jasowang@redhat.com,
	dan.carpenter@linaro.org, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, ndabilpuram@marvell.com, vattunuru@marvell.com,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] vdpa/octeon_ep: Fix format specifier for pointers in
 debug messages
Message-ID: <20240916134340-mutt-send-email-mst@kernel.org>
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

don't add empty lines, all tags in one block.

> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes:https://urldefense.proofpoint.com/v2/url?u=https-3A__lore.kernel.org_r_202409160431.bRhZWhiU-2Dlkp-40intel.com_&d=DwIBAg&c=nKjWec2b6R0mOyPaz7xtfQ&r=Fj4OoD5hcKFpANhTWdwQzjT1Jpf7veC5263T47JVpnc&m=qyhlWh2lFE3SPFpB_eJ0K1RFMa5f-kcNChFHkCARDCXIkzMk__3sqspP_K7KGxaj&s=fMvS62XMmi5HESJuL9v7FX3c8RSzKCq7JM6Khcof4vM&e=
> Signed-off-by: Srujana Challa <schalla@marvell.com>
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

