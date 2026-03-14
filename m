Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE467260D
	for <virtualization@lists.linux.dev>; Sun, 15 Mar 2026 01:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773538169; cv=pass; b=bm16VGOb9ub7pq06E59l/m6taVywbhfcfXz+wA+3W+/Vxu7gUeHRG6cH1BcRwZveQvV3IIm+AEq6fj9oOlsSQ7DessoX8SBn9PMlVTvQ7DF8zbUp54TDEqoIn+P7EfUXTpnDNr0//CUyn58pgo2BlenfoaUm50k3F1nE5WOIzpI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773538169; c=relaxed/simple;
	bh=+9DjsqKn2tw/eLc6Maj+fVaa2roLgkbOUSwE8+V3Y00=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V5vndhfMF6l67x85Sq8OotWddqGX8Yt1MoPbDT/ZN0xMBw3Iu7av1Sf9dzHyF0ti3B8pYazSW3gBoVGw8+mmJy54QhF6/ovF6SDnPORyrru+p/qZUf+eQKEIoWh0qJkvltPcKundYSDNxcBmrwMRHFqXCkfDcakMYtZMvlfEMGk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f7i9hATY; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f7i9hATY"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6611d20c026so4940252a12.1
        for <virtualization@lists.linux.dev>; Sat, 14 Mar 2026 18:29:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773538167; cv=none;
        d=google.com; s=arc-20240605;
        b=kk+ITFQQstPhstgwnC1fOh6yaCQR2rByEvmVAAQxEAZukB7FWUE9STVNI2sWDQVOV4
         eOn0PWwMFej4uJZBxo3MejCbyNjg3ZSW6glIcJuW/dIXTcyGGhQKbEo2EUVsT1H8/1Uu
         DIrK1H28mK2PvUC++SsT7jzDKHe88/fZ0el3MuklFp+LoA8PhxZBG1+VXf7kdrmMR4ar
         a56yPj8zBWWNsLdXxlAhyh4BWDQlvx3P1tBjFnLh4g+++12YXznMIEsTHOGM36jLGO4k
         Rm82ZjvEePA/x+rVsi8fT6S/CNfj8YLwYPFjfQ/b6PJpljM4wk1Pj2D+rnR2TmBSjyeQ
         xhvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=+9DjsqKn2tw/eLc6Maj+fVaa2roLgkbOUSwE8+V3Y00=;
        fh=RNz80IajjlLcsBb8OtBv9JFWQfQvrHHa/Z9mv0+GAqE=;
        b=UfrGuzYsUZLcA9beWx3QTLtiiqgAXFedoVcM31T8ueg1JDxVZHjoCZ0vwB9kmjg1jk
         3s1mwXBqDQwyZQAv7xPs7AfADRdh1MxjgOq1xPw2jZIzde6m7LxxMv41tz5OkHb1XRIn
         e/uzKwofP64KJMHP+z/gw4wY+SBazF+BoKYDFhHl3WzUP6uP8XmPBuKqkZbgrq92sjPg
         uGSiih2N7iz3APon6c8+0ez4Q8MCHcQwLkyAUFiS7enRTAYxGwviprjDhn1EfIollM6n
         6d6iuVxSuFcxofscmySvCfVFRNre7yiA8gpEw2TOV/HV1KZsXU0NtaWpZxpiIeIr5mm5
         Dv7A==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773538167; x=1774142967; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+9DjsqKn2tw/eLc6Maj+fVaa2roLgkbOUSwE8+V3Y00=;
        b=f7i9hATY6m/j5jC81sMfNlrwgVxiV2uIshAsoqWie5C8542hjh5CUoKnMPQuH60COh
         29XO0xAED9wm92I9opzFPqJ+4DKLYLbEUsu4Z+pLx4en3fg5XbidXkMlQzV6wrJWRjKu
         W9D3I+XQp/rSpIUX7d9MxIxPghonSx5ZKPXToyr91+snmLRQZ2P1CL5/ef4vdc67rdri
         S0A0r2KlooCallUlizxsNbRoqPIHPCEoQ/+EbvUsK6LnyBjGLNPEdYhpy5bdUxDNzV+V
         jBpcc1NqrApH5MZgqQLq0qBeH/EvhOh97mKWx+JtxQX5DSS2cmOdK0QVReGKspk4aTnT
         qiHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773538167; x=1774142967;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+9DjsqKn2tw/eLc6Maj+fVaa2roLgkbOUSwE8+V3Y00=;
        b=ESpxC8ztCg2BLDWLBP9D5Z/E/nAd9lYJfPoTXRn3D84WeP/oM7QGwK0RXOoaZnrKkL
         ZcRti+e8Dl5fJO89+UPZvqIyV4rfi6bJR9dapoITpgXaKrskWlJzu5C+ndX5I97Fdjtq
         LSLWKlg/eEVao14eCPsGrAgWnWOKgIWVebWS/SJNE/1eRbhdlGuj6Y2ddDbUOaznD4ys
         LatXrvsZlX5hkf8MQjuwxQBsNryMu+jK75BmCYANZjVOQRWOpRokLfaWz5KHxHecbyn9
         o2gMdauUpcTOzJK0udAvxsBmU8pqH9O8bCq4sxTrBrIRgem3c9Jq3g/RMevr5sP/sNO3
         VJ5w==
X-Forwarded-Encrypted: i=1; AJvYcCUWvF3CJqKmqTN4fpk4kxYOxP1jDOdRdghq6/bCSC5AXFOjC2UiRKOAzLFJYVtkkzx4HqTd8sAiF6n6drRyfg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxv0u+ZENlWEsL5vM2zI7rsiRXPooOa3ZC6Ok7TlE8PKexsP0Zq
	3jgJYpaVDx+tI/GqxaVm+yTjtL1okv52Va3gHsUavLbwK6dFBDZWhE35XTue82XxJDti8ZtNuZf
	aY7iJhfJl9INcIMGvCjaAAA5YZ0s2FbY=
X-Gm-Gg: ATEYQzw6YTCsKpMWx4BDM4ubdLtGLjtQ5r3ToKlET+LnHLo1jXxGsY+lyzylqPQoVKN
	ticw0W5vLYwS04OhvSd1PNSdcDYlXzilYBXdYM0jYn5mwBUeWka6/alyybtV+m1oyh34DJwfDvX
	L4WxxBfbejHUfbZium34qg77a1bVnVSA4YqZynbu+Mick727lYiODEfTwPk2qXW166D+0ucsn8a
	BB6qKF1vyJTxSAtkTqIn4MoUNvbt/93uI2GrTzm97REZCK6aQwEKPKHLv4fpXRXPS7puYo5+1Gt
	DCy/49SazTd+4VzSD1+1YNSr9lBGzA6euJXP5xKbV4JG2xZnN/pICdBTzZ1egPf+n5Nhja06xw=
	=
X-Received: by 2002:a05:6402:2110:b0:663:a321:6f98 with SMTP id
 4fb4d7f45d1cf-663babbee24mr5371944a12.19.1773538166565; Sat, 14 Mar 2026
 18:29:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260314182809.362808-1-viswanathiyyappan@gmail.com> <20260314130601.0ec7a534@kernel.org>
In-Reply-To: <20260314130601.0ec7a534@kernel.org>
From: I Viswanath <viswanathiyyappan@gmail.com>
Date: Sun, 15 Mar 2026 01:29:14 +0530
X-Gm-Features: AaiRm50zmYxyM6Qp4TsIFq_HWR2boNHuFSZpLkcLZjdTo2q7GFDvDFoktscwJvw
Message-ID: <CAPrAcgMBQsVAG3utAD=7dp5tU1jjEBPO5QQGpMUrDu+rMrDJaA@mail.gmail.com>
Subject: Re: [PATCH net-next v9 0/7] Introduce async callback ndo_set_rx_mode_async
To: Jakub Kicinski <kuba@kernel.org>
Cc: stfomichev@gmail.com, horms@kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	eperezma@redhat.com, xuanzhuo@linux.alibaba.com, jasowang@redhat.com, 
	mst@redhat.com, przemyslaw.kitszel@intel.com, anthony.l.nguyen@intel.com, 
	jacob.e.keller@intel.com, ronak.doshi@broadcom.com, pcnet32@frontier.com, 
	bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, intel-wired-lan@lists.osuosl.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 15 Mar 2026 at 01:36, Jakub Kicinski <kuba@kernel.org> wrote:
>
> Stan is actively working on this:
> https://lore.kernel.org/20260313145113.1424442-1-sdf@fomichev.me
> I feel like I spent enough time reviewing your attempts and Stan
> will not need as much maintainer attention to bring this to
> a closure so let him cook. Sorry.

Honestly, I should be thanking you for not throwing it out sooner. I
don't think I was skilled/experienced to actually make it work and
someone more qualified should handle this. On the bright side, That
means I am now much better at solving regular boring bugs and I think
that's what matters. Cheers

Thanks
I Viswanath
