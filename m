Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8D41272A8
	for <virtualization@lists.linux.dev>; Thu,  9 May 2024 13:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715261391; cv=none; b=Hb7ZBZ/+usYS6Y65eq3WxNM+Q5pk/Zhr+AqPtasCopLpWIgc9tXHJlHTv5vZJ3hqZFG9km7MaZX2PrI7qkRV+TloafQiZ3Z/Kyt10BMN7QmWcY1vH0LwUe6gdjPMQa1I5gu5s3qGxWUqr0Jrko/ZwblK86OfvRkCRu6qJOIVjQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715261391; c=relaxed/simple;
	bh=Rs+MI2YOn7qz+ZLMCIyysXivtIEzA86602Hnpd6e0os=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tux6LrSktgdaK70mKIfqA8CF1OE2OY+zIMf5yJBVjQQs2HCdPakJ/wvdqLFOM8J5VX13Dh5z3Vf3ojg2h7YBOi6qR5F9pruyPFggZrYmAmNsscnE74Wiw1ePvtZgdO9mdFRXmRNnYK8XzFwTAKfEPhbL+SDBFODcOg8J4CpKhJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=wZgp47c9; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="wZgp47c9"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2e2c70f0c97so10951221fa.0
        for <virtualization@lists.linux.dev>; Thu, 09 May 2024 06:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1715261387; x=1715866187; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2R8l8gsfeq38yGjr1zzV9LsEGCL4uUZ6VPlT1A+m6Oo=;
        b=wZgp47c9+GUDk45rYo09Towwx99iXIJOLw9WIY3TvmuB6whNt76eZFxcuD0OnqQj90
         JNzLXV0TxhjUat2/Mf/zkq5oiHJ2g1lspITjL1CBIL2YHJ3sRiu+QnXTBGNqGJRwi27S
         80brpAaj4UhmTG8iCkIH1RFVrBi6vGoTqqya1nZKU9bmiyd6QcwjXLeNWhZg3Vt/OvEM
         U9zCqleQgF7v7RuDEJOTNrcY6PqsZhPvP638lWHwU2m9zZ5Gv0UNHP2TsvCm+Y6FZGE7
         AKJ+rLtma90K+u3LgPApqasr39p0mjl+f794nMJiwLPfL7evk3ur6sloejDFkv1SUkwo
         lKaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715261387; x=1715866187;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2R8l8gsfeq38yGjr1zzV9LsEGCL4uUZ6VPlT1A+m6Oo=;
        b=fPkkG3nl6OEGC0JR0goDpqajWvBRysn5CdHJPnuHx4T+ccy/QVBxGJeHHjphCJw3GA
         mJAXgeUpphR2hMAuMuhh3Vl5UUKKq9cRf4t0SELvRb3fFnvRY+DQu3m979Od6Y6FcajC
         oiXDJRcBUyArd/SQViKMJF6Scq3Gf5p2e1098H119MRls2zQF4hMHd8dj+uDoCg/C3sw
         m9PPnaohkr9I1LHvge1po7qTsBwTwMYx6KQD5znR6soU+PmFh6bba77Q53iiTkWYwlAm
         o0EtXohW/hgxMUHanSzw9fZYlI8rjxGcR9fHopR86O3NeZoFM6uj59jUaTvGM5mrv7Fp
         4+6Q==
X-Gm-Message-State: AOJu0YxRv/g11QZCTm4K8J3wd7g6aguSQIzDNeDUz7vdnTTGTZrcJMX5
	nC08bFQ8aYyPIYv8O6tyjzc0aQKjbLPy7otpkNXs9CeccJDzZ1YlfU3cQGvbF6g=
X-Google-Smtp-Source: AGHT+IH6+UAh9fY+PbpzBwix2xo0TEjRhTh+f7EQI6DSpdeTh84mYOFaMdADyTgeP9ObmXpEoHJLFQ==
X-Received: by 2002:a2e:908d:0:b0:2df:8ce6:96ae with SMTP id 38308e7fff4ca-2e447381e0bmr32887411fa.7.1715261386473;
        Thu, 09 May 2024 06:29:46 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41f87c2544esm60974235e9.16.2024.05.09.06.29.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 06:29:45 -0700 (PDT)
Date: Thu, 9 May 2024 15:29:41 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux.dev, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com
Subject: Re: [patch virtio] virtio: delete vq in vp_find_vqs_msix() when
 request_irq() fails
Message-ID: <ZjzPxYrZNfsV6tTI@nanopsycho.orion>
References: <20240426150845.3999481-1-jiri@resnulli.us>
 <Zjy7g0diPulvEnae@nanopsycho.orion>
 <20240509083909-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240509083909-mutt-send-email-mst@kernel.org>

Thu, May 09, 2024 at 02:40:19PM CEST, mst@redhat.com wrote:
>On Thu, May 09, 2024 at 02:03:15PM +0200, Jiri Pirko wrote:
>> Hi, I'm new in sending patches to virtio tree directly. Do I need to do
>> anything more in order to get this fix applied?
>> 
>> Thanks!
>
>I never had patches with "patch" in lowercase so missed it ;)

Ha, interesting. Will do it next time.

>Queued now and I'd prefer [PATCH virtio] in the future.
>Thanks!

Thanks!

>
