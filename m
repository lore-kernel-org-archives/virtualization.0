Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB1815A865
	for <virtualization@lists.linux.dev>; Mon, 16 Sep 2024 17:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726508524; cv=none; b=giOG8FVQJKl0mx33nzXBugWJFGg0Fpk0kmLLCEUGn8lCY/CMH/vlUSSuM5r7qRavnHpFOF0QufZ9ADBxGygKTaaife7jERTtvRcSUTU8KvvbPMMYYbfPjM7UlvWnn65A38VDwhcXU+kx2JN6jZbxn+MZWiRVjdEJtv72iDe1st8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726508524; c=relaxed/simple;
	bh=0IWGYBdaJcrM88wQ6tZuuUj4MjeepiwQNWtrh83RZqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=JlK6VWAMQRTmYp/91UOyXDqyhsBOhgKrQYtmoVdfRScUn7D0rJr74Sa7PWHHGzZMYQ6RonDnM54mcjsCjqai337wQcmoNfKA4vXJBaVX9kMFWxCM82VOlrOMHMbV2UsSOA234/zF1+qjXorp8y2aCAV0j6j981NcBOgsbRVChWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KETpjSF7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KETpjSF7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726508521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fEnLhKuSly8OjO0t2suSU66yiA4lBxbkca09zGcN+wQ=;
	b=KETpjSF7aWCV939b5/M89WYUdDwy5hSulT018/hIxx42DW+Adsx96gp1TmzGKDQbzJhTiI
	jqBmdqf5mwTZVRs3jXAbFad2X2uSuwgT4BNQAIYf6ep9SqAe3cI0sXrBK0oK3Tj90+8VVU
	vF6AEZ9Lapp5fj8WdQz0350TX17mZkM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-477-7W41syerN5GdHkmdXi0ikA-1; Mon, 16 Sep 2024 13:42:00 -0400
X-MC-Unique: 7W41syerN5GdHkmdXi0ikA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3787ea79dceso1320134f8f.2
        for <virtualization@lists.linux.dev>; Mon, 16 Sep 2024 10:42:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726508519; x=1727113319;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fEnLhKuSly8OjO0t2suSU66yiA4lBxbkca09zGcN+wQ=;
        b=CZaB4ob+Qts7xi4vthz/LYWGn/Psn1mXFIZD2jdMAYf6iBtDL1zo3Q0TVesjiVh8WI
         x47xa2t2JIXhimClT+hgHAONa5z9xBQg25Eh6J1K9CEPhNZwtO7sRweXtRw7Ptw3MMY0
         7BmoMw7/Bq4bboUnQJQpXo5b4k4NclUHM7FBZSCo6ZaGauJ2cOLUApB5LOxcLoTvWHH0
         ePkhHvjlDLHmXEu2ms1krlul+Rs/3FdfUs1iRCwX/SpmeuUa8LHZrlxuzYSk8Vkny/0A
         DgdZ2IV0T2OwxVe4NA+X6dp7j9QOeJanu/KnSvQan+T3amDmRMw5Q7x/wQhbTcF6vnBG
         iCsA==
X-Gm-Message-State: AOJu0YxsrIES+TA6N2Pfa1xp8U8rzYekgWFzSHSrhVaF8X1gjzIzD87R
	SBu2bVhWGt4PZf4Yiw/RNPjDd5oHWrO7LEAuPik3M9/GHOjSpSA2vAaWIs/hiGifxK63XTImsx8
	eOev9DrPd1aG22LefbLjtK7Q1bdagSxjkMCpLoYvMpsjkw3rdLzgPVqEqDAImZdok
X-Received: by 2002:adf:fa47:0:b0:374:ccb0:66c2 with SMTP id ffacd0b85a97d-378d61f091bmr6500473f8f.25.1726508519179;
        Mon, 16 Sep 2024 10:41:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPosKL61vxoSRJNK9wOmBrcqd1qHRJWomMGybH7pQ2NGcZFiSrCrZszBxvnP3XTUhxsoDLxA==
X-Received: by 2002:adf:fa47:0:b0:374:ccb0:66c2 with SMTP id ffacd0b85a97d-378d61f091bmr6500451f8f.25.1726508518519;
        Mon, 16 Sep 2024 10:41:58 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1ec:9b4:46f5:ba16:343e:7485])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e780e14fsm7700318f8f.117.2024.09.16.10.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 10:41:57 -0700 (PDT)
Date: Mon, 16 Sep 2024 13:41:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Srujana Challa <schalla@marvell.com>
Cc: virtualization@lists.linux.dev, jasowang@redhat.com,
	dan.carpenter@linaro.org, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, ndabilpuram@marvell.com, vattunuru@marvell.com,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] vdpa/octeon_ep: Fix format specifier for pointers in
 debug messages
Message-ID: <20240916134107-mutt-send-email-mst@kernel.org>
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

Don't do this please, just normal URLs.
https://lore.kernel.org/all/202409160431.bRhZWhiU-lkp@intel.com/

in this case.

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

