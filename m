Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AADD63F6C50
	for <virtualization@lists.linux.dev>; Tue, 14 Jul 2026 08:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784016665; cv=none; b=e2DP9vwbSRl1S0ipVyHRRp7ixbeHQHFyNrEjx1emlUnHAZniHEuR2S60WAZBVmbxcbPO6ZBFC50O9XP6dmrVaMm05Am961waPO85f7olERCTCmZ1PbjPTSaWuhsjCwm+gNoAE+dpiNGNh3jcL5hjNZvoxlYCFwTkEtQdM6DUo9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784016665; c=relaxed/simple;
	bh=95yEhS2RY9tvQKYNJAneFxQrWu4TncTLuEUaUZafNCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QYiT2yeTl7WD+tM6CqlNQONibgUQDdLoxmnnrYKK5G/HPSSlWubeUfABXmv/wURi+UuCsEs/7W/fdlNN77IM8m2m94QONrShwgh2PL91ovJT85qqU7/dKg34ECGrvljZ/V7dZht7ernP29IwlpqdW6VjQcGldhYN4sKusmSywpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LiFGZYgr; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LiFGZYgr"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-381018b9375so4503945a91.0
        for <virtualization@lists.linux.dev>; Tue, 14 Jul 2026 01:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1784016663; x=1784621463; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nAS+vEtyAAAxc3NKkZi+AZEqveghGOCf+a2cUuueeZ0=;
        b=LiFGZYgrav7wG2vvlgrOJgJv4i/5FBXCJwgNx9L/yAnir8ASR0niwd+bYoKAgzIYJa
         thsYGIhg+SqluzDm5QeGD6i2DvfLVrWBVqnqjTxa/RWCg62eh7WimLIfc1pOC8Mxl2ua
         nvSesSB/gu0R+PzIHFOEP9s9x/sJW3BhtblCt2QyjnnYAIeXKL6DbVUuLH5wrGRYxsyh
         CrttG6IqDHFq8EEH8g+JRc+gRNg7cG06ggQc8es/p3/6+46svisUk8Zapy/6AdjRYnLB
         593O16+aAb6fj7Ks6yS3vairxLGr7Dvh7l+A/ddQmfjvNh+SxsqQuA2xla9zhKkNxFpW
         aNiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784016663; x=1784621463;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=nAS+vEtyAAAxc3NKkZi+AZEqveghGOCf+a2cUuueeZ0=;
        b=g08WrPeb1QZlbgWTbpqtPY0TJ6TcwKRsH6OBmbno5i7wY0qz+9IqtYey3+f7lLnDeG
         W9gnQnewsPmw++sxwK22k59f54c6vCdHAGlgTWiSwOlpzDTMeH9Q2jvmP5GOIwyNRjFL
         MrUFKaMYb+FPRWOoqCYolD7LzEyclj2R96qCsAzITK5/TOPlh52ah9rKM80N+3jashWw
         5JQBYxl/efQU4KQ47RkxQFTT1TvDzDe/d7nl8JBBpiVA9rSuT36N22QQcU0gsFTUnyzN
         PxHmEMynUD0yHAmo0qTnNGB7dN0Av+4xdaMv8ubOzZ9VkuQNJY5BSSfpxIXpK1ix2UPh
         f35g==
X-Forwarded-Encrypted: i=1; AHgh+RqolmlgPYWXN9ZmbyJRoBvqKNAay49M7G1jB2GzwRDwK8zVUkE5QYeLLi/dyMMCra8imf1O5bnZTUWMQj8QaA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwHNq4ogMivJLYY1Hzwhp5DKfnq3Bia7X8fmdGvrDHb1znjtyIw
	3mcM3Vna8jcHWo9+zb7toySBBYNmv9W2LYBW86rbUFS2V0r1LfUGL0zMInO0IEopCzw=
X-Gm-Gg: AfdE7cnFbHUfBnG6hHy5WmxI3+Sonv0hvw23R4cezxnHmvdYdiMfTWgL4JDMLcZRGRa
	L+u1d/t/a6+nj9G41jthDFVQA87cOShgKUwiHIPlsPSLiLfFdpMlNdvUuO05mye3Q7LRgyZf9kQ
	U+eVBcvbBsNv+nIxwQOgoIF7ImvBrRmF88dI/UPAeDAqrf8gWi8G+02f8/w9HnmvoSTupXbgNYa
	omZGVFSQWRpDCkww6T29p188iLUILlEiW5SqqQ0lRsG1QIfwB6VeaQEc/smtM16daUde0winGHO
	qakMv6PAAbP5LxePZVY/Ol3DKxfqPxgL9VcDqVzN/jVseZfpm0Y5P37A4+N4Pp+OFCgDCyl86kj
	JyPkmtEg7r6HJKueXldrTizpb/OUJBYzkRotOlRODNzkatS1WeXwZidP+uqJqnJiWXOzyVMvvrA
	eaRaGxkQYfWO/4
X-Received: by 2002:a05:6300:67c2:b0:3b4:75c0:3ec0 with SMTP id adf61e73a8af0-3c1103d29f2mr12378480637.30.1784016662505;
        Tue, 14 Jul 2026 01:11:02 -0700 (PDT)
Received: from localhost ([122.172.82.94])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b659d87a2sm70644994c88.13.2026.07.14.01.11.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 01:11:01 -0700 (PDT)
Date: Tue, 14 Jul 2026 13:40:59 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Linus Walleij <linusw@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Lixu Zhang <lixu.zhang@intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, "Enrico Weigelt, metux IT consult" <info@metux.net>, 
	Viresh Kumar <vireshk@kernel.org>, Mika Westerberg <westeri@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v1 20/20] gpio: Unify style of various *_device_id arrays
Message-ID: <apbfpx4qdqnertxomfums55iznn75xl4aqzjjmjuhpw2r5d4gn@xybd6vdeyz5g>
References: <cover.1784013063.git.u.kleine-koenig@baylibre.com>
 <1f2d39342995533857417eb890628f7643b9a159.1784013063.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1f2d39342995533857417eb890628f7643b9a159.1784013063.git.u.kleine-koenig@baylibre.com>

On 14-07-26, 09:24, Uwe Kleine-König (The Capable Hub) wrote:
> diff --git a/drivers/gpio/gpio-virtio.c b/drivers/gpio/gpio-virtio.c
> index 42871db05ec1..062c70fe4671 100644
> --- a/drivers/gpio/gpio-virtio.c
> +++ b/drivers/gpio/gpio-virtio.c
> @@ -647,7 +647,7 @@ static void virtio_gpio_remove(struct virtio_device *vdev)
>  
>  static const struct virtio_device_id id_table[] = {
>  	{ .device = VIRTIO_ID_GPIO, .vendor = VIRTIO_DEV_ANY_ID },
> -	{},
> +	{ }
>  };
>  MODULE_DEVICE_TABLE(virtio, id_table);

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
