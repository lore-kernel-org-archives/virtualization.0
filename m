Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE0917AD68
	for <virtualization@lists.linux.dev>; Thu, 18 Apr 2024 18:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713466105; cv=none; b=MrXs1+pErTaLkMlTCTT9+vQ6meI5dFypwur2MHj6Klep4XAzSIWcgseyoXCOfLTXcg5R29ZacGhhSTXzNSn1tMw/SkpDVCDw9hn4bZtuOlvcb5aXXybyov1C700nm1coAW4ThV66U6Si/EEGZ41sf9zV0CDP8lRFAL+3j80FkOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713466105; c=relaxed/simple;
	bh=XBzE4LuWccTnTw0r9CwnNxtwEK7las0u5c0J1TpM5mI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gMNd2l879YZP6WkGCXce93sHxsvQOVYI0bG6+b6bZ6e+skAaXzP2o77NrGXqQieZUzWO1WSunXJ9cnybvkp4mvnX/Km4b+xUcAaHABd+D+S/obc0VV2i5rlapeC9rgROLH/uKGteg3Vj6IgPV3Vo3BQHKJXOk4qfC8FMLro4FPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d2k7duA7; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d2k7duA7"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-78f02c96c52so71332285a.1
        for <virtualization@lists.linux.dev>; Thu, 18 Apr 2024 11:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713466101; x=1714070901; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wGqXvxMT176mzoL51bvY92OUP3ZIq2PqZ3NYN+MASaQ=;
        b=d2k7duA74vBZsATo5JxSPoPwKzBtixWeVtVOSFreGLmIo3/D7BisOrKyoGRbgiEGI9
         x16i1rXv1jOqCMPRRIHF/pFUwjdBETT5jOe0TlbObw9H1FFrkZl47fTDfibFlcBnHf8A
         IOHzuhR6WU2Dsol84OQu1hpYN2sCyyyQYq+3rbpIi3FinuEWzkwknN63MhTESEs2FupW
         p0zT+/Bo2nwDRzYes4Um8AVGGJ4wU7i8JEITMzhnc82QAEdQpICRY/3LSRAKmZNqqrCK
         j84+sY9MvIwB5Ot6Z8wnskcefzK9Cqkue+qlD3TZ8Tm9t7Ao/B1oShleg0Sz085zOCpm
         Ptpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713466101; x=1714070901;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wGqXvxMT176mzoL51bvY92OUP3ZIq2PqZ3NYN+MASaQ=;
        b=GgIEJc60JQE6c3bLTjuqAXBKN8tYpswDMh4VbSY7Lf1wywSAJFAmAtLASMg/5lkcKO
         e48zu4gbd3dvRoqTd9TgIitPgPUGjRlRyKUmeUV/VsJiUayMSuU+Rla5HNjfNOonJi2W
         wCKqTQndJ+kYGQDSemrwvEIM/cKEkdiw0s6nS4lwkYbqUTI5LZGVT/81UDTwVJIVh4d9
         kbm3LjXXkTFTBY2uovQkbgcf1HaiTyn9mPHPwXIo6AlPQl+Td0mIvm7Fp5XVNzr4eOpa
         vuNAJor8W/rLa2GasXMyAPftbCUZV53YXMr8TzApK5HNpjWvWZGCM0HtmyozQa4BSF3c
         Czag==
X-Forwarded-Encrypted: i=1; AJvYcCUjCcVYwG6SYVy+yH4Byl83aTv2UNboBaJ5e5YsII0M6XgW1bK8F71bBW2Kuww2RW7+Ysu1C/OrrKD9DZUDA+yL+1XloODdrY+jgc0sX6o=
X-Gm-Message-State: AOJu0YxKcoamVcUHe2zeKXVqFsVhTqy7F3BFIZ8xSZyWlLRa9mJzKoVq
	vjWNWW6du86gkAGExS8wyQxk+heSaSw1giaRBQ60+1gXIS0ivA1y
X-Google-Smtp-Source: AGHT+IH8Rc/y4Ihr2A346pTfATwDYMHDYG0p+qLnc9wkbwEVdKnVQuewL9jhIZiURjOP/SLnA9ri+w==
X-Received: by 2002:a05:620a:40cc:b0:78d:36e0:2b5b with SMTP id g12-20020a05620a40cc00b0078d36e02b5bmr4335137qko.68.1713466101519;
        Thu, 18 Apr 2024 11:48:21 -0700 (PDT)
Received: from localhost (24-122-67-147.resi.cgocable.ca. [24.122.67.147])
        by smtp.gmail.com with ESMTPSA id o20-20020a05620a22d400b0078d61f145desm881261qki.13.2024.04.18.11.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 11:48:21 -0700 (PDT)
Date: Thu, 18 Apr 2024 14:48:20 -0400
From: Benjamin Poirier <benjamin.poirier@gmail.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
	davem@davemloft.net, edumazet@google.com, parav@nvidia.com,
	mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	shuah@kernel.org, petrm@nvidia.com, liuhangbin@gmail.com,
	vladimir.oltean@nxp.com, idosch@nvidia.com,
	virtualization@lists.linux.dev
Subject: Re: [patch net-next v4 2/6] selftests: forwarding: move initial root
 check to the beginning
Message-ID: <ZiFq9EmbGZ3psdho@f4>
References: <20240418160830.3751846-1-jiri@resnulli.us>
 <20240418160830.3751846-3-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418160830.3751846-3-jiri@resnulli.us>

On 2024-04-18 18:08 +0200, Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> This check can be done at the very beginning of the script.
> As the follow up patch needs to add early code that needs to be executed
> after the check, move it.
> 
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> ---
> v3->v4:
> - removed NUM_NETIFS mode, rephrased the patch subject and description
>   accordingly
> ---
>  tools/testing/selftests/net/forwarding/lib.sh | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
> index 7913c6ee418d..b63a5866ce97 100644
> --- a/tools/testing/selftests/net/forwarding/lib.sh
> +++ b/tools/testing/selftests/net/forwarding/lib.sh
> @@ -84,6 +84,11 @@ declare -A NETIFS=(
>  # e.g. a low-power board.
>  : "${KSFT_MACHINE_SLOW:=no}"
>  
> +if [[ "$(id -u)" -ne 0 ]]; then
> +	echo "SKIP: need root privileges"
> +	exit $ksft_skip
> +fi
> +

There's a small problem here. ksft_skip is defined in net/lib.sh which
hasn't yet been imported at this point.

Also, on my system at least, the code in the next patch can run
successfully as an unprivileged user. So what is this patch needed for
exactly?
