Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A221BBBD6
	for <virtualization@lists.linux.dev>; Wed, 18 Sep 2024 14:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726670638; cv=none; b=ajYRx+HpJEWeUZ8I+7GM+C2NzHdJ6KLcULWx2PHk5/DikPKgvdknImkcBmwxFQYeQvzJu7Kx/TCiTVhoySh2sxcyVjAif9enp4Haj2JatGfgxtC0AXbZpgv8zcoYZcZp2rs6M1i+3ii0z8dmlyeRXMb+kgGX5I2RT9M/nCQ1GVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726670638; c=relaxed/simple;
	bh=dLQd5Kj0B7OtIKmYCO/gzJmlDPJbo4TW4dOOzqrJOUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=A7jUGYVIqeNx+F5frJcwKRiJzCTKGGO8yCQMBDH1A9mg9NHH2YQCWfO7mB/CPf1LYqV1I8EfnfPNC7IoXIfUoqiDrKGlAYfazr35b+ACFfVx2SlRY9W035wbB8quKeBLJjZrKCZCXyBrlC0G5kzUUzv9xkJyKrTB0AMjYN925lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aGNbfpEA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aGNbfpEA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726670635;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Aq0uEu2KxtWIO7tuEdV3Gqc4yebp7AZYS/mu/Vzp99M=;
	b=aGNbfpEAFQmoHH5YXmwxzB501Haez7TYrNkshU2Iyg7ugvQaqLSUNcZBpvMB7hvJT5Rlo4
	/BOEinjXxZpe5BmbKUcJTg853sK0MKxY6Fnt7t/Wt51tVdFUkeYSOuGm2+1cu0pdFPeV13
	L03Un5D4+DN9bwsxUDzVRK1vEnTKZgY=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-249-tGjJ07QpPuCxYx9q9PBLDg-1; Wed, 18 Sep 2024 10:43:54 -0400
X-MC-Unique: tGjJ07QpPuCxYx9q9PBLDg-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2f760cbd9deso47537671fa.0
        for <virtualization@lists.linux.dev>; Wed, 18 Sep 2024 07:43:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726670632; x=1727275432;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Aq0uEu2KxtWIO7tuEdV3Gqc4yebp7AZYS/mu/Vzp99M=;
        b=P4MWGxkiDsXjwOJ72EeEaJgeqbnWme8CnVJb+MmhfW+UD33YB0tyzJxhsZQWoJyIAD
         k53aLC/KRGWzIAdQ2J3+FLBFvTafM6ogP/bynCWo4TNfXvvxIXj5uuoPANzCJhGdhN64
         DdTGBXlZA/czeXz50WN1E5Sr9yG4ZK+N1nwwIQsJLGcpJEC1TrZEUOJAcFLKPYdFh/1f
         aOMSuMZaMyjchOCNrESQythTEaBpogr0pa+9emdpP2fc6G8OFrherPJJWRFf96WAuAnN
         TyTVhtdL/OcWKU6JWMjhftzuduqEgYEqc5v9WFQpnA5tFGnT1rrWBMU+M1w24Ywhn0dG
         1IrA==
X-Gm-Message-State: AOJu0YzREHpyXAb/5hMln+h50iaHOZihBhMl1RDICv/43IRgJmaE5eWX
	RRpMgY0WrCd6LH3ZfgNMHQpBeHJdixCIyyAzoLlknY6nxz6+vCBzVr5OthKZwRgAuF4sUCBdEq9
	/tDo6CgTyqX2h5yRSZnTK/guk2wGworPIqzZH/S9TLBeQ/ix8WPELaOYzmnu88HiO
X-Received: by 2002:a05:651c:541:b0:2ef:22ed:3824 with SMTP id 38308e7fff4ca-2f787da4e65mr124037251fa.5.1726670632471;
        Wed, 18 Sep 2024 07:43:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPzdgGFyEoAipp4NzA82tNt1x6auA0XkThzgjkHvJp+Bxs0QvcYLLgllM00lZGc2GbkgdYLg==
X-Received: by 2002:a05:651c:541:b0:2ef:22ed:3824 with SMTP id 38308e7fff4ca-2f787da4e65mr124036921fa.5.1726670631724;
        Wed, 18 Sep 2024 07:43:51 -0700 (PDT)
Received: from redhat.com ([83.68.141.146])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c42bb539dasm5052194a12.34.2024.09.18.07.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 07:43:50 -0700 (PDT)
Date: Wed, 18 Sep 2024 10:43:47 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Srujana Challa <schalla@marvell.com>
Cc: "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"dan.carpenter@linaro.org" <dan.carpenter@linaro.org>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"eperezma@redhat.com" <eperezma@redhat.com>,
	Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>,
	Vamsi Krishna Attunuru <vattunuru@marvell.com>,
	kernel test robot <lkp@intel.com>
Subject: Re: [EXTERNAL] Re: [PATCH] vdpa/octeon_ep: Fix format specifier for
 pointers in debug messages
Message-ID: <20240918104325-mutt-send-email-mst@kernel.org>
References: <20240916162255.677774-1-schalla@marvell.com>
 <20240916134226-mutt-send-email-mst@kernel.org>
 <DS0PR18MB5368A29EFA2094A2253CD6B2A0612@DS0PR18MB5368.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <DS0PR18MB5368A29EFA2094A2253CD6B2A0612@DS0PR18MB5368.namprd18.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Tue, Sep 17, 2024 at 05:59:20AM +0000, Srujana Challa wrote:
> > Subject: [EXTERNAL] Re: [PATCH] vdpa/octeon_ep: Fix format specifier for
> > pointers in debug messages
> > 
> > On Mon, Sep 16, 2024 at 09: 52: 55PM +0530, Srujana Challa wrote: >
> > Updates the debug messages in octep_vdpa_hw. c to use the %p format >
> > specifier for pointers instead of casting them to u64. > > Fixes smatch warning:
> > > octep_hw_caps_read() 
> > On Mon, Sep 16, 2024 at 09:52:55PM +0530, Srujana Challa wrote:
> > > Updates the debug messages in octep_vdpa_hw.c to use the %p format
> > > specifier for pointers instead of casting them to u64.
> > >
> > > Fixes smatch warning:
> > > octep_hw_caps_read() warn: argument 3 to %016llx specifier is cast
> > > from pointer
> > >
> > > Fixes: 8b6c724cdab8 ("virtio: vdpa: vDPA driver for Marvell OCTEON DPU
> > > devices")
> > >
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> > > Closes:https://urldefense.proofpoint.com/v2/url?u=https-3A__lore.kerne
> > > l.org_r_202409160431.bRhZWhiU-2Dlkp-
> > 40intel.com_&d=DwIBAg&c=nKjWec2b6R
> > >
> > 0mOyPaz7xtfQ&r=Fj4OoD5hcKFpANhTWdwQzjT1Jpf7veC5263T47JVpnc&m
> > =qyhlWh2lF
> > > E3SPFpB_eJ0K1RFMa5f-
> > kcNChFHkCARDCXIkzMk__3sqspP_K7KGxaj&s=fMvS62XMmi5H
> > > ESJuL9v7FX3c8RSzKCq7JM6Khcof4vM&e=
> > > <https://urldefense.proofpoint.com/v2/url?u=https-3A__lore.kernel.org_
> > > r_202409160431.bRhZWhiU-2Dlkp-
> > 40intel.com_&d=DwIBAg&c=nKjWec2b6R0mOyPa
> > >
> > z7xtfQ&r=Fj4OoD5hcKFpANhTWdwQzjT1Jpf7veC5263T47JVpnc&m=qyhlWh
> > 2lFE3SPFp
> > > B_eJ0K1RFMa5f-
> > kcNChFHkCARDCXIkzMk__3sqspP_K7KGxaj&s=fMvS62XMmi5HESJuL9
> > > v7FX3c8RSzKCq7JM6Khcof4vM&e=  >> Signed-off-by: Srujana Challa
> > > <schalla@marvell.com>
> > 
> > 
> > 
> > This does not fix it completely.
> > ret is still 0 here:
> > 
> > 8b6c724cdab85d Srujana Challa 2024-06-14  140  	val =
> > octep_read_sig(mbox);
> > 8b6c724cdab85d Srujana Challa 2024-06-14  141  	if ((val & 0xFFFF) !=
> > MBOX_RSP_SIG) {
> > 8b6c724cdab85d Srujana Challa 2024-06-14  142
> > 	dev_warn(&pdev->dev, "Invalid Signature from mbox : %d
> > response\n", id);
> > 8b6c724cdab85d Srujana Challa 2024-06-14 @143  		return ret;
> > 8b6c724cdab85d Srujana Challa 2024-06-14  144  	}
> > 
> > 
> > which is wrong.
> The fix for the error code is already included in the linux-next and mainline Linux repositories.

I guess it missed it ... where is it exactly? which tree/hash?

> Therefore, I did not include that change in this patch.
> Thanks.
> > 
> > 
> > > ---
> > >  drivers/vdpa/octeon_ep/octep_vdpa_hw.c | 12 ++++++------
> > >  1 file changed, 6 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/drivers/vdpa/octeon_ep/octep_vdpa_hw.c
> > > b/drivers/vdpa/octeon_ep/octep_vdpa_hw.c
> > > index 11bd76ae18cf..1d4767b33315 100644
> > > --- a/drivers/vdpa/octeon_ep/octep_vdpa_hw.c
> > > +++ b/drivers/vdpa/octeon_ep/octep_vdpa_hw.c
> > > @@ -475,11 +475,11 @@ int octep_hw_caps_read(struct octep_hw
> > *oct_hw, struct pci_dev *pdev)
> > >  		dev_err(dev, "Incomplete PCI capabilities");
> > >  		return -EIO;
> > >  	}
> > > -	dev_info(dev, "common cfg mapped at: 0x%016llx\n",
> > (u64)(uintptr_t)oct_hw->common_cfg);
> > > -	dev_info(dev, "device cfg mapped at: 0x%016llx\n",
> > (u64)(uintptr_t)oct_hw->dev_cfg);
> > > -	dev_info(dev, "isr cfg mapped at: 0x%016llx\n",
> > (u64)(uintptr_t)oct_hw->isr);
> > > -	dev_info(dev, "notify base: 0x%016llx, notify off multiplier: %u\n",
> > > -		 (u64)(uintptr_t)oct_hw->notify_base, oct_hw-
> > >notify_off_multiplier);
> > > +	dev_info(dev, "common cfg mapped at: %p\n", oct_hw-
> > >common_cfg);
> > > +	dev_info(dev, "device cfg mapped at: %p\n", oct_hw->dev_cfg);
> > > +	dev_info(dev, "isr cfg mapped at: %p\n", oct_hw->isr);
> > > +	dev_info(dev, "notify base: %p, notify off multiplier: %u\n",
> > > +		 oct_hw->notify_base, oct_hw->notify_off_multiplier);
> > >
> > >  	oct_hw->config_size = octep_get_config_size(oct_hw);
> > >  	oct_hw->features = octep_hw_get_dev_features(oct_hw);
> > > @@ -511,7 +511,7 @@ int octep_hw_caps_read(struct octep_hw *oct_hw,
> > struct pci_dev *pdev)
> > >  	}
> > >  	mbox = octep_get_mbox(oct_hw);
> > >  	octep_mbox_init(mbox);
> > > -	dev_info(dev, "mbox mapped at: 0x%016llx\n",
> > (u64)(uintptr_t)mbox);
> > > +	dev_info(dev, "mbox mapped at: %p\n", mbox);
> > >
> > >  	return 0;
> > >  }
> > > --
> > > 2.25.1

