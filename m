Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400E916F0E8
	for <virtualization@lists.linux.dev>; Wed, 18 Sep 2024 09:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726652098; cv=none; b=mHUbO/fDyF7ifrJgAanENazTRy1iv+gWNbR2tBjGSBf1NLVWOMLtfMM17AQQCZ9pd17b+m3vYgvVp8NMJXdOnupCSZlvgspCuuBxNv6Oshwa8QnRntW64ySaS3iAp2i/apGDP8fdHc5eNnmKkTcEE1NGAUIzmnLAHZf3XGM1OIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726652098; c=relaxed/simple;
	bh=LL8poDNZGBVv09fNBvgWhZeU01ZJ4C33Y9UROTpgz0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q40uiUJk7Pzry0yz6jZhrKI72OjVSzCXI96vFZxFCA/o0NA5oNy4KSce2YS7g1kc0SAjnXv+tpEWcS//Wa9+1KILAhYTy9n43m8yEmx7v7h3XOqy7D6FbDDRsf5OGzpZOKW1qoAOSMl4PccQx0w3064ltuJC2Rexlw/ePVgWRvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dw8uUeaJ; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dw8uUeaJ"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a8d6ac24a3bso115113966b.1
        for <virtualization@lists.linux.dev>; Wed, 18 Sep 2024 02:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726652094; x=1727256894; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=18NSgznQ6OGp6EV+g3aQPaasWgMNfRn1TvD7aeTp2CE=;
        b=dw8uUeaJ8+Z0ezBWyK84RFOsPcYStNox86RB8DhhHiARjFfI/U9951uuhEwgZw0IW0
         Wv4coqTPSyw+wqlSSmypCRnxSqbBwt5UBrEJmRPsZAL60hKS5OYeAbnfkuw2IGZJ0/N5
         +//zV2muGhN26YfgzhsznYy9J7jK9iW7EMm7NDMCQ/pXkjrIPwnwlCw7f5g2uJUirMTY
         7X7O3dGPRITk7kHcu3Dw83wyUBNhtDzzuPH8wV95yRGcDKkzeH+ygNB7EyHSZ2rH3EqV
         zA2VEM+F5lqGvo9JDt9SjcNqMfli7M5IZXEKS00Ga60sLu3o62Iic3b+bc/MmRdhduF+
         3opA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726652094; x=1727256894;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=18NSgznQ6OGp6EV+g3aQPaasWgMNfRn1TvD7aeTp2CE=;
        b=kaZaIo6PyCsrCiQ7iTw6EPBAmRCQ6pOA82MdwMQ691c4pIGcpNKlF50Z7pgc+ftn8I
         BTMM75vFk7uTy5ozjOvu9IvRKxqnJCjWyLlpLVkslIwZYD61E9aHou7Tc5abzRZcNaLL
         1S0/5IFmBt43v2IUa87josOKPlM9xhBVwWDaSkCc+uW14CXRdVZkBE18vG9v8lxn0z7R
         lNVH44P1JOJ7zG/lMuJwNyN00Fp5/fMpkFSdNbdxvsaYSGqCtl3gTynrrEx9XYsbx+oC
         +xvlxjk35oqC6nbcy5pvghMTnhkUpel/hbBq0h6TaQNmV6Y2KgX+hfLlNBj4NLlMVLsI
         zjKw==
X-Gm-Message-State: AOJu0YyZzu1gturzRvjlRsVmwIhIwKaXzMp41hSD7lPmJr4MT9PUu5pv
	3ra22XOVNUaW6o2R1hjVVpfOKF2pvmJJw+U3wscsWKY4W/pLKUtWA/X9NY2u3ik=
X-Google-Smtp-Source: AGHT+IEDQ58bRKsMCKnds0GeC+Gi8R3nRgYAlOZezEuPpHhT/OD+8zvxWMTlEbwatSlskfuiVjvwnQ==
X-Received: by 2002:a17:906:6a1a:b0:a72:7b17:5d68 with SMTP id a640c23a62f3a-a902a3d11e9mr2215519466b.3.1726652094350;
        Wed, 18 Sep 2024 02:34:54 -0700 (PDT)
Received: from localhost ([83.68.141.146])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90612e1a49sm560767166b.166.2024.09.18.02.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 02:34:53 -0700 (PDT)
Date: Wed, 18 Sep 2024 12:34:52 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Srujana Challa <schalla@marvell.com>
Cc: virtualization@lists.linux.dev, mst@redhat.com, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	ndabilpuram@marvell.com, vattunuru@marvell.com,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] vdpa/octeon_ep: Fix format specifier for pointers in
 debug messages
Message-ID: <9d5b7a34-2db7-43e2-95d1-a42047bf176a@suswa.mountain>
References: <20240916162255.677774-1-schalla@marvell.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240916162255.677774-1-schalla@marvell.com>

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

I thought my script had failed when I saw this.  :P

Life hack: I Joe Shamblin's has a python program and procmail to
remove these.

regards,
dan carpenter

