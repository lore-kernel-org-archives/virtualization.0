Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24591D3185
	for <virtualization@lists.linux.dev>; Tue, 27 Aug 2024 19:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724785550; cv=none; b=Huh5HbVqGc7YogLeMRZij/BQ/sbMj5lRMd0bTHUW8tjUi27LWyUkL4wWdf45Oe950BSaUAD2QCnXv1ZZIanVrlV+g8RJkoXrAoeVE2UJ8ZcOOj9q/ZGbgq5N3RhkTNreTvLpf17bmP7lwCjJbHN9S+nL3TETnmR+jvXb88VmHKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724785550; c=relaxed/simple;
	bh=g2qfOyzD7mj2ctfLhV+IRVqjYo+8o4pLyGoAVHj2xpA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aB0eVZVpM7hyzTNavK7Pz8M2goH24ARyhUrQOd0t68fnO9Ts4CAF/uDYQKGHYOshLfS8NOSh2T3o5mo7KmLicoKUgFKNg8ZwIGXO9t6xBMTMLsHsFVhrIXo4UIc9qh3JFlCkdYe1cEjgZckLIHHITub3QnjIa5hglAcent8bV2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=TemS4f/D; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="TemS4f/D"
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-824c85e414bso203763139f.2
        for <virtualization@lists.linux.dev>; Tue, 27 Aug 2024 12:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1724785547; x=1725390347; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QPgtDg58q+McBQLoCDhB6dvqAm4lTGOJk5NvB5IqS60=;
        b=TemS4f/DK9uLxL8YUn+fSTmuj1gC3VciA/OLwE1q764gfTeqSQ3P/Qd8DmWfRd1B3l
         z0fVuTaKTwvG+nUVe2XyTOTJ6W+tsUrGXTqO1Q/gmCNpFDkPKX2TZeQ0DlLzeRFP/v5s
         RwPeTZkMhoOzOl5igQOiQmSO4Yd3nSCTABw62KrNLhlGs06XX5Rkhgb6NKJr0z6HkNNq
         iXLa0r117jFOM4rj6OW+8StjDTPFxClTLKz/2XfimAutdE9a3y6NHc+SKuHyZzNtLtcy
         tbLj56nQKb253/kB/bJRpV3TYQHrBiVa32W3x9UgekxndBgbQBLbXccjw9eqhi40NszY
         P/fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724785547; x=1725390347;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QPgtDg58q+McBQLoCDhB6dvqAm4lTGOJk5NvB5IqS60=;
        b=QNCB57j0DTY2PSBW7N5oDviIV7SefJ7sVm8xg5Tk20J6/cT2d2tleOiizITQlBDP4t
         lWjqAYXbr0MqF1uhl2Qw1WxITO+/bZjcdb4tRlGgHSgXpoCEUDzmKj3QhFltoD8q+9pS
         Jb79LZ+l+hAD9Wy3EG0DURp753DInXuYVUHTXxvsfOpdtc24FNEweYlVH0ViodQV/kJH
         kh7O3ClLcQXDC2qAjUUfjs39jRkVKREJEFjBaXcfXSn+MJMwZQfBNuHZ0cpzI10MRApn
         9BMjtxR2j/t8UsfxiWyHSnCTPY3XIx95kgesjOVstA5Yl3Qf0IdODbn+0QLpkwIKmvlC
         wE5w==
X-Forwarded-Encrypted: i=1; AJvYcCVRbmzNfkpj+R6Ux8+2UnK08RsoGEg/KDWmbKbT9wqCF/cYrPlc0/4WncQuSK4TvL39qR4lH0zXlW7fs/m/TQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyIFr2Owfb9+lE292s67X6Cq3NsE/aH1nlVN8pDN9JILRDkROie
	KqlVf8sVVRGfJ0ZJ/wO+UMrZEQPs6qJjiInNJm7jWLEgnjVAwPK9MufcRz1asuw=
X-Google-Smtp-Source: AGHT+IEuujl/9dEsZ4FQ8JuKJxuoRbbHy6rNrvvhcf00pWo8FSAo3yeLetJirxmhnMEDUTEhU7xR4w==
X-Received: by 2002:a05:6602:13c8:b0:824:d752:986 with SMTP id ca18e2360f4ac-82787387f9amr1917557439f.16.1724785546835;
        Tue, 27 Aug 2024 12:05:46 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ce70f20255sm2724543173.3.2024.08.27.12.05.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Aug 2024 12:05:46 -0700 (PDT)
Message-ID: <c7acca0d-586f-41c0-a542-6b698305f17a@kernel.dk>
Date: Tue, 27 Aug 2024 13:05:43 -0600
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/7] block: mtip32xx: Replace deprecated PCI functions
To: Philipp Stanner <pstanner@redhat.com>, Wu Hao <hao.wu@intel.com>,
 Tom Rix <trix@redhat.com>, Moritz Fischer <mdf@kernel.org>,
 Xu Yilun <yilun.xu@intel.com>, Andy Shevchenko <andy@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski
 <brgl@bgdev.pl>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Alvaro Karsz <alvaro.karsz@solid-run.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Richard Cochran <richardcochran@gmail.com>,
 Damien Le Moal <dlemoal@kernel.org>, Hannes Reinecke <hare@suse.de>,
 Keith Busch <kbusch@kernel.org>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fpga@vger.kernel.org, linux-gpio@vger.kernel.org,
 netdev@vger.kernel.org, linux-pci@vger.kernel.org,
 virtualization@lists.linux.dev
References: <20240827185616.45094-1-pstanner@redhat.com>
 <20240827185616.45094-4-pstanner@redhat.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240827185616.45094-4-pstanner@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/27/24 12:56 PM, Philipp Stanner wrote:
> pcim_iomap_regions() and pcim_iomap_table() have been deprecated by the
> PCI subsystem in commit e354bb84a4c1 ("PCI: Deprecate
> pcim_iomap_table(), pcim_iomap_regions_request_all()").
> 
> In mtip32xx, these functions can easily be replaced by their respective
> successors, pcim_request_region() and pcim_iomap(). Moreover, the
> driver's calls to pcim_iounmap_regions() in probe()'s error path and in
> remove() are not necessary. Cleanup can be performed by PCI devres
> automatically.
> 
> Replace pcim_iomap_regions() and pcim_iomap_table().
> 
> Remove the calls to pcim_iounmap_regions().

Looks fine to me - since it depends on other trees, feel free to take it
through those:

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

