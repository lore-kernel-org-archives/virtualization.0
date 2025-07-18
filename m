Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9371F8AC5
	for <virtualization@lists.linux.dev>; Fri, 18 Jul 2025 08:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752826546; cv=none; b=WqjgsFfhyqSSsxRvp0MUO1JTomBVST7y+a8+2WN4Y1BYOg9vets57FU+mR9LYsmElwQ85cbiM/SItJa0HdKCqpb7gOgF5Xq/Rhh7HLVwSeY0vGEfBk53sAIdyNs6tco2JHyK6X87htNBDvnZXckbYJI/Ts8RfMFqmBLCpcVn9OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752826546; c=relaxed/simple;
	bh=LYG6dBi27owiZdJNQoV91+OmRsH3MroMWQm8w7WQq0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VSygJXmThKzzBmCySC3lMIleQm2LGao+hJyn9GF3PY+nXF+wl5eLf7ZT2oACFCaNGlJeFsIBZF62r2dFuMV7AfCVyvTbdx4ZGgsovxpC53lmAosuTp65SmbxUTHOlbHn483lr5EII+bpok/dEBQLRqcxckE1WDPPS+5aW4iGkis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dchomnIt; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dchomnIt"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2350fc2591dso19161635ad.1
        for <virtualization@lists.linux.dev>; Fri, 18 Jul 2025 01:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752826544; x=1753431344; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZRoi/KdssEcNygdK/MFmLI3EXaQwQgEFjNwDzaC/Nps=;
        b=dchomnIt/MtutaBjcFi2IvfD/v7RzgrfDws8XXG6CrgUjj8f885CiYCNcDUYXV+kn7
         FZLNFrA4Ky1Iphwlp5VR1TZ9IE/m8YPWiHeEvHQ/2MToMi7b5EbGJlh3PteWsR724C8U
         0LRMO99spPMs1ePzPmOqq05aYQ9E8z3egADZ2SbTvJQUPw6sKOQECy8/cPFD/dey9+GJ
         3iZFveGAPY0ROY7ByDxZU9VsaSmKWkufY6fl/to201IenESRNRXEYBsDZDEzH4FIu9xl
         HKHwkTJ3CxeKnI9uT3zu/eiw5L1t8Q3aPwpYX7/0/dKnPkXBda27lBh7MRmpHZysswS2
         o3oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752826544; x=1753431344;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZRoi/KdssEcNygdK/MFmLI3EXaQwQgEFjNwDzaC/Nps=;
        b=V81afGiX22h1nlFh6YzGKwhmOi+5GSRVXAfUJ2z9CD5R9W//LYGonNMBT6VUNRhjp2
         lR3c/y/5oiuvBy/Vp6e4nSg9Ezl3HB98Z4m7dKBYofijWfM0JsDpeoH5B5YF3IYsS7MA
         qh2O5N2CoZeeGoPLG0w1IwQU+iVsVyHMc6JXtIlUg+d2Ewq/GWavp+mmlfRHWZayGpxA
         JD9Ji/mluVwpYU30/390ipi3E53ydZvXqrjq5ijj/sma8FrvJdVFbEgbCuVro4f6SAIo
         p4MsF/oNq8iWxILepr6dp9U6T/C2zrP5yDlC0oEBkAFzZ5uQIUb8uarVUHy3drgFJ52I
         vnZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpFRvzm4KE93q8v3woXrO4VwWdoDWg71A/iSP18LphvD6ajh1A3M+Tunomq4ZGqJddaSL8mX39SGr6FEy+Iw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz37JTmWsemA4/Dehu5IYEw+rMinqa1QHHz6Pr2I1Znt9+ybSJX
	5nxkiMlDlYdrmGQuVDEFwSeN7MpLlrjCDRXWG9MB8dvwQ8qknvrpwW1y4Tq5cU+B/ps=
X-Gm-Gg: ASbGncs+OQNpWQ92W8yGHAGxOVXG6R8SiCDlmgruey77OrMDe8R95Z5K3bjDwKhvRIl
	+6lLKvSuFgOgei7YFftrQkOu2rmj2S9LWoQ8mTgtXGQlnv11UocVJ0++GFanJjScw/Eogpsb0z8
	YnNTkSDu9mdrexqQnuTGBS8X5rhpmHcYYX/77XscM3WIxj8jZyYKrGjOxndOdwKHFiwvl5VnQ6b
	XI8saETuAho8Z3eqSiXelHCT2BWs+o2/oo90sRn3OgpmBzW1RIX19Lnhjiys79E6UFWd7dg6YGr
	zCXfniXv5R8fpABUi8hTnzhHnyiLoMhM+y5HSECuPOqJu32jXbeEftJXzUxnrruzHrGYxWdpiW/
	M9Ri+BsaWuGgzQ0SaEFNwPZA=
X-Google-Smtp-Source: AGHT+IEqHN85qJhRQ1PINudkBYmazt3d1yDiVwXAcZxkuOjtrSEpN31hW0gEWbObrF16B/ALKaw6eQ==
X-Received: by 2002:a17:903:94e:b0:234:2d80:36 with SMTP id d9443c01a7336-23e38f7f902mr45233195ad.14.1752826543694;
        Fri, 18 Jul 2025 01:15:43 -0700 (PDT)
Received: from localhost ([122.172.81.72])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c9153803esm3465900a91.0.2025.07.18.01.15.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 01:15:42 -0700 (PDT)
Date: Fri, 18 Jul 2025 13:45:40 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Harald Mommer <harald.mommer@oss.qualcomm.com>
Cc: Enrico Weigelt <info@metux.net>, Viresh Kumar <vireshk@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] gpio: virtio: Fix config space reading.
Message-ID: <20250718081540.7n7wtl2sas4o7jz7@vireshk-i7>
References: <20250717141000.41740-1-harald.mommer@oss.qualcomm.com>
 <20250717141000.41740-2-harald.mommer@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717141000.41740-2-harald.mommer@oss.qualcomm.com>

On 17-07-25, 16:09, Harald Mommer wrote:
> Quote from the virtio specification chapter 4.2.2.2:
> 
> "For the device-specific configuration space, the driver MUST use 8 bit
> wide accesses for 8 bit wide fields, 16 bit wide and aligned accesses
> for 16 bit wide fields and 32 bit wide and aligned accesses for 32 and
> 64 bit wide fields."
> 
> Signed-off-by: Harald Mommer <harald.mommer@oss.qualcomm.com>
> ---
>  drivers/gpio/gpio-virtio.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
