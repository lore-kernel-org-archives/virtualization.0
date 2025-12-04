Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894463321D0
	for <virtualization@lists.linux.dev>; Thu,  4 Dec 2025 09:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764838829; cv=none; b=Ra1beyrQC9ffyIo8qOPbimX7yBfeXSJZnNBTtxddaR9fKO0QKApUXR/rAIs339jP7jUAR7o5n1X1YwmLA+Q+0w3Qtn7CgT9Wu6eTmELc8O2tPJreQEGKgJg1oZOlzP29CNdylhMlQus8bkqcEEsQMbv/rv7X72aG/UXokKlJSn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764838829; c=relaxed/simple;
	bh=72GPm1ULAj1WA2GXdfhiS+jYjGnUAprwyZKKNmKV62I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KToNWI1/BHEhDOM5YoLDnmG221Q9yyGYfgSgaKjN9i4ty9+eK6ZhOdPl6uj6ONRVwiuW7eSEguhDdfXPcbCyRhXNGyxiaOUyj+MKVIbl2ttDo3iPiXaN9EhLe7ZYl03eIVO9i3IjlWSkvPZsWS+u4FZ5uWOuNokOcTpnhashOuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=igovSEmi; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="igovSEmi"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7ba49f92362so437782b3a.1
        for <virtualization@lists.linux.dev>; Thu, 04 Dec 2025 01:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1764838827; x=1765443627; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=72GPm1ULAj1WA2GXdfhiS+jYjGnUAprwyZKKNmKV62I=;
        b=igovSEmiM3VFjlr8Ft7y3d2JWffkwjyMa3Jk+5j8pZscG8okwuasY4R/D+k6VKMLuZ
         x4bz1fSQmxIAZIx/10j4mf4lCFL/tGYMk597ftImVxCORaPPEWpZJKpgq/cXxu68g0eu
         lNfkK8lThDxP85qkdjsVW8ve7KcGhZ1rKp2lc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764838827; x=1765443627;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=72GPm1ULAj1WA2GXdfhiS+jYjGnUAprwyZKKNmKV62I=;
        b=kE0jbycUk78XcL2LKMiRZCOCV1gsOYBeytNo4c6fMuZEoUsoGgsZjuCx9C6L8xD+lV
         UPKM2mfFZcN8qn2yOOXt1pQNCFCYdCb3UzVeu66sybtn4G5C9SxVGf0O7j1eda4chP5R
         72Qr4Z8+X+StEZE6NHiB1xBOui0Aluc89dQFRxLemMvtB4mScCSw2VbFJEQKHRqTt336
         XA+iCmbVwz4nR1iygbsQrb9gbJGPwV7buC8Dbqy+vMKpo69lp9F2q7Y5Lnhn1KVIxo0N
         9VS49UE3+mKQXjeHhLf7w4CoUxrPFY3lTX8ErXMYLmAb+K8H7CM12iiaAh4eFC2oKtHq
         KpVA==
X-Forwarded-Encrypted: i=1; AJvYcCUtVlMyQD+WZUCfNs3miFcM1gJWj+jSMl944rHOAKP0XnEQuhPWyTiHKJOCvNY8D/92rPVjTQJuKD4MWge8Qg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxLrAksgVjV+jmnLMup8xSlBTxOVK70r8ipJFNZPhtN/oYu7Ff9
	3sagxttQ9RMa8Jk+JI1JHv3DuRhtq65YskjtzS8QOqCUCNORTv7aT4dbYyxyiB0zfg==
X-Gm-Gg: ASbGncvZAnOCkHwQQuAXAs0wtERsCSw7blL9EEoMmuzMpYvGPpsYB5eQDO3GoN+YR9b
	4egMoeRqNsQGUE7V+LCGboO12XNk9P9NuRnTwUyJHOXIt4JLsZdO+KTZ5tXruaGBeKZkg6PMx5S
	TV7BLyVhl4BDlW96JIbLgufJch7hXWoY2FpOjyyP/jUf4ii6fWKKTMgnYNde9sHuAznWL4cdthk
	YBshV53mdFZk4oKIsWPVGwVQBipbh9qmirk0T1Ur+xV3ZAcsyyyxwW51z7dXil8GpVnOBw4mG3W
	sp4msUYA7iu1Og+O3HYC0MmQRxdRYmNCpeJ0J6vRNIW/7iJMoqWbcfFTPenxMs6XNGE0lOyVY5Q
	28ofawx5AI7V99xJQQFTEQTd2D6xOUcNJ2fseZrvKqlHPBVkIu8cVZrpqrjym6trV3d/poVKm5B
	3xouv2YaBx0NiKNA/qwRO4YlJd+eOwq89BzYMA8OKhC955+Wmicfc=
X-Google-Smtp-Source: AGHT+IGrCmJXKAQtdU3NALKnC/NLtRATjkDSaaivHemq5nPaEpusucmf2NZ3eoouqNk9cTRRShNDMA==
X-Received: by 2002:a05:6a00:6fcd:b0:77d:c625:f5d3 with SMTP id d2e1a72fcca58-7e2020650a4mr2076684b3a.1.1764838826661;
        Thu, 04 Dec 2025 01:00:26 -0800 (PST)
Received: from google.com ([2a00:79e0:2031:6:803c:ee65:39d6:745e])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7e29f2ece66sm1483482b3a.13.2025.12.04.01.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 01:00:26 -0800 (PST)
Date: Thu, 4 Dec 2025 18:00:21 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: zhangshida <starzhangzsd@gmail.com>
Cc: Johannes.Thumshirn@wdc.com, hch@infradead.org, agruenba@redhat.com, 
	ming.lei@redhat.com, hsiangkao@linux.alibaba.com, csander@purestorage.com, 
	linux-block@vger.kernel.org, linux-bcache@vger.kernel.org, nvdimm@lists.linux.dev, 
	virtualization@lists.linux.dev, ntfs3@lists.linux.dev, linux-xfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zhangshida@kylinos.cn
Subject: Re: [PATCH v3 8/9] zram: Replace the repetitive bio chaining code
 patterns
Message-ID: <d3du6mmazbygxo2zkxqjxamfg44ovrfiilbof6rnllfjzxnnby@becwubn7keqe>
References: <20251129090122.2457896-1-zhangshida@kylinos.cn>
 <20251129090122.2457896-9-zhangshida@kylinos.cn>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251129090122.2457896-9-zhangshida@kylinos.cn>

On (25/11/29 17:01), zhangshida wrote:
> Replace duplicate bio chaining logic with the common
> bio_chain_and_submit helper function.

A friendly hint: Cc-ing maintainers doesn't hurt, mostly.

Looks good to me, there is a slight chance of a conflict with
another pending zram patches, but it's quite trivial to resolve.

Acked-by: Sergey Senozhatsky <senozhatsky@chromium.org>
