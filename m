Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D299F3FD1
	for <virtualization@lists.linux.dev>; Mon,  6 Jan 2025 04:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736138113; cv=none; b=JAbEghZhC3Or/pR0LDkUgOttBEVL99U+mKAbDraDOvrdGyu45zxxsbQVd5OdhViPl+IPRnQlap43/CEPQZWxx83NERg1yDMOolJAorbP0Y8dDySAoEOg8tPgAovK7FkwF5Z/AnGbfxrl0fD7FQ8uGkdvzfu31h32t8lkqEuVqF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736138113; c=relaxed/simple;
	bh=OM5GYYJQIEZs6lnx+JXgGkzgb/3ca7LSN7LOFvTaN04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FaNzasP9XDAvsu3qHTeKIIa0kx3te91E887lnwGbFc8swiQ5ucQDS07uJVbeeJs4oM36uhz+ODnSZ6nZXR5M+F6fpDmof4otSTugMwe+kLo7qrImKWGWv2OK+Aig1pc3hyFlWb7bOGSGDLCboeTtDEMEA7qb3hzgIYUBVxo8J4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Kp2D5qiC; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Kp2D5qiC"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-21644aca3a0so13780085ad.3
        for <virtualization@lists.linux.dev>; Sun, 05 Jan 2025 20:35:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736138111; x=1736742911; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LfuLaRSTSw7gy1jnNNGfbkOz3vWlnSzgGTrYOpHrTuE=;
        b=Kp2D5qiCXCxzuiHBW4iL0IDRZ4Ao6MLeGWZAi0/M2ANA9aOCPv2D0ytqJ2iGaqfcAW
         BVXQ5E7iQHWcw6sZWpQjEHOfNcZTFtRNFi3dZtKJjlcOSU2Q1SW75DESgan/bKEPNWO7
         wMPQ298emwV4LpCzFHKMyi+MgyWargF6Y8dlMtepAOOoaH5j2z/sKaUXPp32BR2YUFR3
         QIXVYal5Oj1lUeqoOOeCgropobGXOD/9P4fgALRSY/pv6aPWrOlh/2W9LBm5c3iGGMMp
         9ZrJQ0yiFi80LEAS+5uKnfFpHPoNHoAuc3viw1/4sMMjddSFbGENvzbq6ZJyI/sxPJ1k
         ZyHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736138111; x=1736742911;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LfuLaRSTSw7gy1jnNNGfbkOz3vWlnSzgGTrYOpHrTuE=;
        b=dldhfSxIHsZQG9Fxoj08Y0B7rM0wsVEjlTUWo28AYA9MLNj5PTr/P149b03MrVB01w
         JsKxrkJrUwSC8SBkkOeQQmWm+FcJmHSEHfxusf5gC/xo2J9CeCOYSz0z421yU7Z/y/KY
         Ze09b4w8mozlWBhcsrbI06LaDEuSkuZ+1/tYWneTsZqO1l1x9FdQT2+zhVSufBd6pcyS
         JpvZbaNr1IIXgT9S0V3+kCxoBpvswf8fk7psn8BNRDbfTrCBwnOEwDt3rJx+bFhL3rBw
         6YhSe2EtnXnJqaJJaTHVPIC3ZmqrtQ+hwnJzDj5af81S7XVk0ZmDrKOxaYNCF8Sn/lXI
         Afuw==
X-Forwarded-Encrypted: i=1; AJvYcCWn/SKQQknK69oIfKsfxpGwG7t85DxVb4Lsz/z4N9e9ISvhbAoYrcV+QBQwl/8KzdXW/I3h4/h0KME9SWHSOQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzXwMsi0XNz8VpGVbyx6hlJV114hcgTp4E7SJmQlblKsyj19iLR
	aUo0zVlgBAqr+mMDNm7gaFU1r1bovLxOHl5W+g+g1vT10/SnLbiuT0n1ayrcbks=
X-Gm-Gg: ASbGncvFtYPFN9UgFidgJarIyO8ggdsKKjrXx5lL7zT6sgIz69Feww7NUMgpoCG2B//
	UmdDnW1VZGoyafIzemPYOjF51aCA+jNkTceJDzvk55/FM/PCg7xzFXw0uzQPT1HszhbGBFh+3JD
	J+CKao0Svk2xzCoQV0XPdNJWnS24y31iImYHtLfjS55P7oUuoWeKgFuCtZCEl8CMWxSWxccWMHH
	jGY7mzLTFwpTMpjadFIkbQ5+mjnMA58IGaXovCOjoatLihRT36rDrKSt2s=
X-Google-Smtp-Source: AGHT+IH4OEI1Mvt9XR5zk2GUaRub3spOstatsKjyOJ/ychbjGr7H7IiUgtuZVsnqO2+cIEjfa/nh6A==
X-Received: by 2002:a17:902:d2ca:b0:216:1543:196c with SMTP id d9443c01a7336-219e6ebb776mr651256725ad.27.1736138111209;
        Sun, 05 Jan 2025 20:35:11 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9716b3sm284208805ad.90.2025.01.05.20.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jan 2025 20:35:10 -0800 (PST)
Date: Mon, 6 Jan 2025 10:05:08 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: hlleng <a909204013@gmail.com>
Cc: info@metux.net, vireshk@kernel.org, linux-gpio@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH] drivers:gpio: support multiple virtio-gpio controller
 instances
Message-ID: <20250106043508.x3pwt3jzh37t265f@vireshk-i7>
References: <20250103083520.1764441-1-a909204013@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250103083520.1764441-1-a909204013@gmail.com>

On 03-01-25, 16:35, hlleng wrote:
> Modify the virtio-gpio driver to support multiple virtual GPIO controller
> instances. The previous static global irq_chip structure caused conflicts
> between multiple virtio-gpio device instances as they shared the same
> interrupt controller configuration.

What is the conflict you are getting since all it has is callbacks only, I
wonder why do we need to duplicate it.

-- 
viresh
