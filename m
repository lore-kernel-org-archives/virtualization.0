Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493043568F5
	for <virtualization@lists.linux.dev>; Tue,  2 Sep 2025 21:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756847602; cv=none; b=iEVAnH9QZGnfCLOHZKAiwXs0jVqA1PkcHW+6V0luY72ufuyLw9y+bNqnuDjeh2Ecab7Liv4CylZwWHlUYG2UYdsysIYVXxRHiHUD8Yecfy3OaXHkOChuDeMIZWNQXUa+KL7I6BozQGUTb6uhTF+qARV50qWn5Ynz8KDfqIYSv2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756847602; c=relaxed/simple;
	bh=pyDdBcVW0v9+xpIUz0AG9q7DuTI1Ozvq1geLOWJVPxI=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=R/qMqrlCgapeEV5rXkAVITqON3ThWxAUs/gMq8xoq/U0rf5EJxxUEuD9sYwzMIBkKi6GZRNPvDacIwEmoEN8G+jA6mDhUy1LwwKJ6WEI3zY+PB77mKPVPVHGuiJFshgrf7nFv5vUM6gnoubzlqXKm7F7Gt2eZBk46dSbAOnCINs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KbNMrh/t; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KbNMrh/t"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7f74b42ec59so325511785a.2
        for <virtualization@lists.linux.dev>; Tue, 02 Sep 2025 14:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756847598; x=1757452398; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CILSsYdSSQh7NUkrEKe1sZhsPfN00oaTeV/5x25EmIk=;
        b=KbNMrh/toFmKEKlQwZsG9WhwonUJ16dG9pAqG0/YnnSjInO6MJofTuh7yny6+Z2ofO
         GyXpJMHnXOeHgkp8mN4iVWJHQ+6/QdrguipyFK3sXKl71Xz6vu+F+XrzcOLUf13jB4QZ
         79lOwazkP2xA+lzgtbY3KVImF1lw/y2fdVtNQDAISMqVcEjOVurkHHTynpIjoWjZPUZm
         ZeAwx6ao/+WLm29Um80hkVohNnB9rye8hacMzwXrKWcy07O8/dTcFd0+8qbvN9JwJFVh
         dZaGhvxM8JD/ANlkdHL+UWWuUd+dD2qka42uvC41DWboJGKe5cW9V1S0Zf6p7kz7FQ2V
         EHYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756847598; x=1757452398;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CILSsYdSSQh7NUkrEKe1sZhsPfN00oaTeV/5x25EmIk=;
        b=oGnNuj+4Q3X17Ry4VvULFzBwhPNxVDJ+hC1LIGiIJcR+rVLOVgrJlnvyjor02sK/aE
         zedeMxwdU8/7Jem3xJIkR2IlhP5X4GCu8yTI4WOf2z6g5NKcTyA9/jB88etxBAc8AG3r
         PL5xgaxu8dECF0TMoQpizclNDetxOzvghDCXtE0uttkZ/NfDPcPug4vdgFujQ3K8kUTb
         Xj93A0hBwKxHCkD56NUnxzrBJr10jQjDaHwqCM2o4uuweiw1WonT64AZCeLV6UHCZ5L6
         QsW1NfGXlljfzasRp5UqBxc32j7VFhImi8qTzDcolLNq7LCjhepeDRKY30i31xC3kRVm
         0tPw==
X-Forwarded-Encrypted: i=1; AJvYcCWKqWEOk2Rb0ZYJl9itNhufx/+/rneEq5EQ/DsasPdW5ZH+YndgGF2jzpuJsE0Xo0Pdt1YPisV3vkTojIZyVg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzJVqz15T68or3H7MYXtYzxRZsXpvbm0n4CAuHoh+tKyXhAh0kx
	X8HWTppqoVligvldVsX1zVRL1uujMrjkmpXddPEN2bCHJvokSuJXWOoc
X-Gm-Gg: ASbGncuNWVAxfVcLNXgxdr2SLQ7FcT26k4m1CxR3yULbnR0IVlK+8gOOgcDQ8ophmm8
	gKBM4d4vtuIhu8lOr98cnsCwj/WcbBhIzp/vSWbQxV1hAicAoXqwhCQUfnTEyTEx+ijj2pnWgpM
	uJPTH0VLRQRyPGh9D3o033kGTewo4JZIYvLp0tB22VpgaAyVwI+UxRMtA3S8XBPlfabruBb6o9X
	j7Lu68Om5uS0LXSYghbGJn6TJru4WySENbTHbSvjLJlR87Kf4ZyYg06KjfPVC5z+mgkb+wqSH9G
	wuT0pB/FTWKGXxn54uumnd79EoAkVXREpyVVMgDbwX1t8bTqZInTTGb5W70uJDp6HnuBs4RW4tm
	qKywk7icTO4/l/mskiXl9gQ0EPPQSOoXsQKXFZiJn0vMzDDXtjo4nlAuhvLE0VJ+uYxrCuwCrJg
	EG6t/DKXVBl+lY
X-Google-Smtp-Source: AGHT+IGfwGyYEQSsZhuRIBBjRHJpONNrkZUKk6/vfwU6F4j3sS0Cahrn3/lz445Kl8YoSSsb3MXbyw==
X-Received: by 2002:a05:620a:6919:b0:7e8:902c:7f90 with SMTP id af79cd13be357-7ff26f9fdc9mr1389884185a.15.1756847597958;
        Tue, 02 Sep 2025 14:13:17 -0700 (PDT)
Received: from gmail.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4b48f652814sm1143791cf.12.2025.09.02.14.13.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 14:13:17 -0700 (PDT)
Date: Tue, 02 Sep 2025 17:13:17 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Simon Schippers <simon.schippers@tu-dortmund.de>, 
 willemdebruijn.kernel@gmail.com, 
 jasowang@redhat.com, 
 mst@redhat.com, 
 eperezma@redhat.com, 
 stephen@networkplumber.org, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 virtualization@lists.linux.dev, 
 kvm@vger.kernel.org
Cc: Simon Schippers <simon.schippers@tu-dortmund.de>, 
 Tim Gebauer <tim.gebauer@tu-dortmund.de>
Message-ID: <willemdebruijn.kernel.6b96c721c235@gmail.com>
In-Reply-To: <20250902080957.47265-2-simon.schippers@tu-dortmund.de>
References: <20250902080957.47265-1-simon.schippers@tu-dortmund.de>
 <20250902080957.47265-2-simon.schippers@tu-dortmund.de>
Subject: Re: [PATCH 1/4] ptr_ring_spare: Helper to check if spare capacity of
 size cnt is available
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Simon Schippers wrote:
> The implementation is inspired by ptr_ring_empty.
> 
> Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
> ---
>  include/linux/ptr_ring.h | 71 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 71 insertions(+)
> 
> diff --git a/include/linux/ptr_ring.h b/include/linux/ptr_ring.h
> index 551329220e4f..6b8cfaecf478 100644
> --- a/include/linux/ptr_ring.h
> +++ b/include/linux/ptr_ring.h
> @@ -243,6 +243,77 @@ static inline bool ptr_ring_empty_bh(struct ptr_ring *r)
>  	return ret;
>  }
>  
> +/*
> + * Check if a spare capacity of cnt is available without taking any locks.
> + *
> + * If cnt==0 or cnt > r->size it acts the same as __ptr_ring_empty.

cnt >= r->size?

> + *
> + * The same requirements apply as described for __ptr_ring_empty.
> + */
> +static inline bool __ptr_ring_spare(struct ptr_ring *r, int cnt)
> +{
> +	int size = r->size;
> +	int to_check;
> +
> +	if (unlikely(!size || cnt < 0))
> +		return true;

Does !size ever happen. Also no need for preconditions for trivial
errors that never happen, like passing negative values. Or prefer
an unsigned type.

> +
> +	if (cnt > size)
> +		cnt = 0;
> +
> +	to_check = READ_ONCE(r->consumer_head) - cnt;
> +
> +	if (to_check < 0)
> +		to_check += size;
> +
> +	return !r->queue[to_check];
> +}
> +
> +static inline bool ptr_ring_spare(struct ptr_ring *r, int cnt)
> +{
> +	bool ret;
> +
> +	spin_lock(&r->consumer_lock);
> +	ret = __ptr_ring_spare(r, cnt);
> +	spin_unlock(&r->consumer_lock);
> +
> +	return ret;
> +}
> +
> +static inline bool ptr_ring_spare_irq(struct ptr_ring *r, int cnt)
> +{
> +	bool ret;
> +
> +	spin_lock_irq(&r->consumer_lock);
> +	ret = __ptr_ring_spare(r, cnt);
> +	spin_unlock_irq(&r->consumer_lock);
> +
> +	return ret;
> +}
> +
> +static inline bool ptr_ring_spare_any(struct ptr_ring *r, int cnt)
> +{
> +	unsigned long flags;
> +	bool ret;
> +
> +	spin_lock_irqsave(&r->consumer_lock, flags);
> +	ret = __ptr_ring_spare(r, cnt);
> +	spin_unlock_irqrestore(&r->consumer_lock, flags);
> +
> +	return ret;
> +}
> +
> +static inline bool ptr_ring_spare_bh(struct ptr_ring *r, int cnt)
> +{
> +	bool ret;
> +
> +	spin_lock_bh(&r->consumer_lock);
> +	ret = __ptr_ring_spare(r, cnt);
> +	spin_unlock_bh(&r->consumer_lock);
> +
> +	return ret;
> +}

Please only introduce the variants actually used.


