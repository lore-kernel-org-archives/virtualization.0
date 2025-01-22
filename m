Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC022153F3
	for <virtualization@lists.linux.dev>; Wed, 22 Jan 2025 18:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737572307; cv=none; b=PacbvOeri24xuVx5h8dIHYoHl4L3ooFqKwTV484N1qC/4w10s6r5MkN8KNtA6xd/7b7aGh1R7ujv/jR+ohDvXfEKjAZayLriVXVY7fxO55IXimlKcHl6GeRCMhDtNgKDStx9YyxusA20COCBc3fR8kbCBFnJwL1cXVLhOurunEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737572307; c=relaxed/simple;
	bh=GcQqx9dXco8qzlSmEuT5GmTtIqoMmo2XVI/wiS2IHvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dBN+vC8Ll1e5BtEAj/4IffSqoTNT6NPkAXqOnIlEgFheZCvXcpRwyNhdFQH5YuES9CrkLAe1BewlDF5hk6WQbVGQRZB0/6gMunjHTxvgC7CckfLxTFMRUWA1SaJ0+E0welwbI1QK1/dWaU4FPlPRcL+1cq/MwT4mdba2VJ6KRu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tMdgpS2R; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tMdgpS2R"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-3076262bfc6so270091fa.3
        for <virtualization@lists.linux.dev>; Wed, 22 Jan 2025 10:58:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737572303; x=1738177103; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GSoJDpvIW5B8ojaONnLtMOlBTJD8hhUGZBtBrFXKmJQ=;
        b=tMdgpS2R9GKm7gH9RQOje9vomG1aUidn2fe89BjylTYy0F5u1IVe7eEEQYL7cOStOv
         80D7bed4kSStdhNeOLftSH63EIudmd6VzKlrHTQlcQ+K4QrfSHaitYl37QEJPLFM9TUM
         vnMkIRho6o1HnDbD1PUvJBABtZfh977S1P+x/0lzOc9QwR69pUmr2X7h0sG8jR5seALg
         gPh0Qkm7by42j4toDCe0N/AhbOaNv59sPSgqMZIF/ksftQ/HoFlie47qlqX4VjWWkIJ2
         Gr0HSoDoD5Lzlw/ISguJ0FKk0GT6Rzcq1wU000hp7yBcLe0bL7DjLhZlWg4XF3a51WrR
         M8UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737572303; x=1738177103;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GSoJDpvIW5B8ojaONnLtMOlBTJD8hhUGZBtBrFXKmJQ=;
        b=aQ7JHHQVWO8uEL/TqFkQPiHyaJqcEYSK/qSlQnXLfPdUBd294FQrW2Hx1VjjM3lzQf
         GqClnMkbbziVAgxYlLTgoHhD6pFbYRYg2vX+uUVH9bHafL2Pd0hedFWiFcubEJjy7ymD
         0gstYj+Yd1zbeqau+JyL6UVRssGEisVZn12lH4VpO+BJLdFvB4CMmAp55fX95OhkphGO
         9djxe5YJIjRcVZZcsTym+Rvzi1sGlwUWY6VSqaF34LaQQHZktqfjbwUf1siIxPgbkYAX
         UkZQzcbCl5CAdH0YvhpkDE8VJkyP1tCu9cf/vM79HCpSevBD8kdaezIN90KxnXixlvkF
         9Z3g==
X-Forwarded-Encrypted: i=1; AJvYcCWwIsb/VSAfmurz/mEDvsH5opm0bbicvdD+/8LG0KfOixalsfMX0PqMlRLrkAU2CAntXjW4KHVnOTNgcvWDdw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxPFxkry/1u6cf5CzFWaTvEZO83qto0dM5nyXouhaEasWoyB9Lw
	Y47ycGsFP1LE2OEeUEHqaqlgh2Gas7IkA+7tEH9d14c+VMfRIJoNiR9xO706Z/A=
X-Gm-Gg: ASbGncu0bvUwRn3zUTS4nfVCZDM+ligYyX1e7kUGaDcTw37Fx3VdG2hyMaojHfYMVqQ
	qDnL5/rJe7cOaMN0ow7wBHJ4I+C/1htUdo0vK3bMnaAFTkXYyjm903bTbgFquwRQv39nbQNK4oa
	pHQJbzDhRVQXzV+SyoMTAZqCgBzMNETjzuvbeC824HQSzJw23OpOGRlNLoRCq2z2awW1LpkKPkn
	XCxO9gm03dL/cTna8u1/S0uGszGd3eD1+STarx3VcCvUn8HqBLmhuWPD7ROPFmj9QTKU7/pkx72
	HQtpXMxFuiJ5Ny3Bqlq9/bzZ41HzZ7eNm3iEvhMNnEIHGdIqPw==
X-Google-Smtp-Source: AGHT+IFrtpqRxJkgLUrkX3L9FcaQMult/UuvBM6wVVKrgeZ4I6/MZ9iXcVuJARwLa4wkXsRApaUMLg==
X-Received: by 2002:a05:6512:3409:b0:540:fb1a:af1f with SMTP id 2adb3069b0e04-5439c282970mr9780886e87.39.1737572303319;
        Wed, 22 Jan 2025 10:58:23 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5439af60986sm2376322e87.119.2025.01.22.10.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 10:58:22 -0800 (PST)
Date: Wed, 22 Jan 2025 20:58:20 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: kraxel@redhat.com, dave@treblig.org, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, airlied@gmail.com, simona@ffwll.ch, 
	dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev
Subject: Re: [PATCH] drm/bochs: Do not put DRM device in PCI remove callback
Message-ID: <4gl3nngcvfuf6hd5egpqhsltoq2uxvtgel52tapk6j65hpch6b@2l6em2dnvfai>
References: <20250103095615.231162-1-tzimmermann@suse.de>
 <9dadd98a-7c3c-4e2c-8332-fd0f5a96b670@suse.de>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9dadd98a-7c3c-4e2c-8332-fd0f5a96b670@suse.de>

On Wed, Jan 22, 2025 at 08:37:51AM +0100, Thomas Zimmermann wrote:
> another friendly ping for a review of this patch
> 
> 
> Am 03.01.25 um 10:55 schrieb Thomas Zimmermann:
> > Removing the bochs PCI device should mark the DRM device as unplugged
> > without removing it. Hence clear the respective call to drm_dev_put()
> > from bochs_pci_remove().
> > 
> > Fixes a double unref in devm_drm_dev_init_release(). An example error
> > message is shown below:
> > 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry
