Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FAAA322C9C;
	Wed, 20 Aug 2025 16:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755708667; cv=none; b=pyOY7UUdTcGXz8aD1gFG7xtpNk9jcgX4u3CGhphsIOohJKUYTgKZ7IKWQyXTdBsML+epMvhcnn/fzAjskF1uGwiGIq7EfzcxEV7+4YdGP2MJTwguHXl+ApoEpyq5UFkIEklDVCsKoH5Q+VuTAQcUDVPGcQT6HVNYIz7qEUAFFxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755708667; c=relaxed/simple;
	bh=ov9NNcH3lK4jHG94Q9fLyQzwt8vjlm7dLd0hHCJM4w4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O3vrtz0imIJPsAyooJsTL/ZuyTZcDRJnT2zfAyF/zWw7V4mfZ2Qhqd8zNxB3JwyEi0gr6lhpbb1A0vEsWzLuaJ0Brx9OEUrff2kBTCmUrMeROjGzA0fkarRKcr3sVU6OfSrWXYPGwmjF5sgUw8wU5e7esFR1onC6y3FLDxm8Bws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aEblOHqV; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aEblOHqV"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-324e3a0482dso106387a91.2;
        Wed, 20 Aug 2025 09:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755708666; x=1756313466; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hJZ5yF6MT93cQ2eY07VpZtdRSNWFWGaCLBXg7mgNuIg=;
        b=aEblOHqV9MnzdZ/jFB1Z5zKUNp4M6VKN7Edc2kT7Ciy+MeaZr54iGQaVzzpK8eKkUw
         qm6Mn2LsWiQ557TmNN77R/xpjDF3O2X81hukQHfwBwdQ69nZPxKkuZwHDcEkQ6lO7GLV
         bakT4aP1Xjp+V0/3RgzyRHeNV9ONLz62il3MLqxUUxaXWIuISQiwENcjs7HWnmPO4S5x
         r21A/D2s6Yzv5UpedJSx8lKCTInabNTNahhg8c3ccPyWYRf+1p7wX+0Gb/35SBL9d1JW
         WkiPYqm13DElNtgB2CK/iFVcN1LVuXXS2hNFAUHFYa8EkXUVlM1QoGdTmau7vGv1L68B
         /7mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755708666; x=1756313466;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hJZ5yF6MT93cQ2eY07VpZtdRSNWFWGaCLBXg7mgNuIg=;
        b=JAXzjsmsxdyc1jIPhYDZqWl894Mr5WgNeV1wte+f7HPMixF1M0jZE5uCgvweKGFN/L
         JyYN3QbGf6RC9h/I+lZNjJQkn5XHp7QJVDlWLVAw/Dpd+RgKyvomNDK8ghjv8qkyFclx
         OZbMMY4Y98gmFrjSxSnU4lkSTzWblORN30CTmMcGDqOPU72tMfAd5GsQmBSLadVNnpiZ
         ++571o/PvlZyB85DuZlUcSpi2mvyFePDIWM5AsMIonG1q3otp6s49neWdWGZojoBmW/B
         2msE/ALvFwrWlQeWxWjGGy0iWB9gSpMzhRM/nXcp59urzlvzLteoFMC2FgsGJrldSROG
         W8Ug==
X-Forwarded-Encrypted: i=1; AJvYcCWkHhfmnTimSyu1OPpYHwegG5eS2QkUgv01HGhqXNQzsGlQRNPg9Wdnx7CU7Dvuk1kVg4H9cfvnhCYQ6sN45rvHg/4kPQ==@lists.linux.dev, AJvYcCWtdQEle/EoYi5WCh0n6021X38Ut3UN6sHkK3lJeLN8n6QltGTjBUdki1IDpMU27uufjalK80a14ikZIpSp0G0=@lists.linux.dev
X-Gm-Message-State: AOJu0YytgjQ4T55EaaXjiLb+FRDgKnq2tAxOApgHs/+XTOC5GMgqljhz
	l+PoOAD0meuwHFfX3FG1B9TnXUjSIhBy/W/FrwLCk4XatvdBpHAavTxW
X-Gm-Gg: ASbGncvCgZDvQx0iCcSp040Mcwo6KbnYCFjRIWHb5rPNmIsNXKlhdd3YSyB+g6owN7J
	+PA1gzuW11hyqxE+peo60oQGvNrastxgFthpRlcumDZTGpBp8Z+rJlX09JjGtmxKk3qaYo208ym
	dPpd3/KmxfRsKCeUfVu1s+IDSitoChsRRXS614XAkC6viqEdYzUalCs5fS3IvMhOpUlfaA1Mtdw
	ek6v/TmJn2J1Y43TsRZ/GJWs7uHwiO8E1I+gSrRNP/yikMC48mW5+NW4zpVUUQnFzhLFEQg9478
	E+CAXkDQHfaNKel1Uuo9uvYZHN5Y22b2SuRGfL/AY8Eb7C47tnb+Wkg+3S51H41WCMEW80x8E+F
	5BFC4dTVKWtILGhT1jw==
X-Google-Smtp-Source: AGHT+IGoxAmu4xxfpyv6iOKZvfO5x7LR/lkwmDmB5TsfrMBGncsh2UHwKp/rA7M4iaeIKiv0reOGwg==
X-Received: by 2002:a17:90a:e7cf:b0:321:c81b:29cd with SMTP id 98e67ed59e1d1-324e12e819dmr4255157a91.1.1755708665593;
        Wed, 20 Aug 2025 09:51:05 -0700 (PDT)
Received: from Terra ([2001:df0:b240:b5e:abe3:8cfd:3fd8:5d8e])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-324d335c4f1sm2602720a91.11.2025.08.20.09.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 09:51:05 -0700 (PDT)
Date: Wed, 20 Aug 2025 22:20:59 +0530
From: Athul Raj Kollareth <krathul3152@gmail.com>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: airlied@redhat.com, kraxel@redhat.com, gurchetansingh@chromium.org,
	dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/virtio: clean up minor codestyle issues
Message-ID: <aKX8835xMtatEHcy@Terra>
References: <20250813062109.5326-1-krathul3152@gmail.com>
 <39b17698-a1ce-452d-ada5-5c3741e888b2@collabora.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39b17698-a1ce-452d-ada5-5c3741e888b2@collabora.com>

Thank you for applying the changes.

Best regards,
Athul

On Wed, Aug 20, 2025 at 01:41:01PM +0300, Dmitry Osipenko wrote:
> On 8/13/25 09:21, Athul Raj Kollareth wrote:
> > Fix codestyle warnings and errors generated by CHECKPATCH in virtio
> > source files.
> > 
> > Signed-off-by: Athul Raj Kollareth <krathul3152@gmail.com>
> > ---
> >  drivers/gpu/drm/virtio/virtgpu_display.c |  3 +--
> >  drivers/gpu/drm/virtio/virtgpu_kms.c     | 20 ++++++++++----------
> >  drivers/gpu/drm/virtio/virtgpu_object.c  |  4 ++--
> >  drivers/gpu/drm/virtio/virtgpu_plane.c   |  2 +-
> >  drivers/gpu/drm/virtio/virtgpu_vq.c      |  2 ++
> >  5 files changed, 16 insertions(+), 15 deletions(-)
> 
> Applied to misc-next, thanks.
> 
> -- 
> Best regards,
> Dmitry
