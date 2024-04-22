Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F518155305
	for <virtualization@lists.linux.dev>; Mon, 22 Apr 2024 18:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713811662; cv=none; b=qOdcQujo4GwkrmpvZ0p3x2JGfcBBBi/q94uwkh1VjWVGdhvu6Iph2PBIqm+cucAC7oDOV2abryWoQstRC3aAXBbYAmGuBVmHrLpOujumBgcPkRbphuAv/ZUCWPgRaqb97YzklxKdpBMUIeKUO4kdIRwERbtxbI/8fZmlDkosR3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713811662; c=relaxed/simple;
	bh=RjC+01ZDFE6MNxd2eykgAq+nbbFDAvXeRdNuyVLRIsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jGSFW6ZHd7Xm5jSePnUfhH2hBqnWnLzSGUi6/CNhm4paQ/ruzDtW99u2qi59Nq3G0lSm9qN8zd/TUMzBKsHlhnQe4oxglX8+NSoz+IKUB+NXmPlNbM9QLVQz3KEHGAuNlAIb2SwzmyyAPemxoGER4qUc9Y3Z51dblWo1sAnAixE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nqtCyCvT; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nqtCyCvT"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5ad2da2196bso1205574eaf.3
        for <virtualization@lists.linux.dev>; Mon, 22 Apr 2024 11:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713811660; x=1714416460; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=owEYz5PcX2V/77HEBhhtfv3jinwHJK/SDFDfp/Sqt3w=;
        b=nqtCyCvThg52w3KrndNX9wA44XwaytUEfeMhWaalZre1BTsHJnYHepMy10s4jIKLPu
         CAxr4MibPimEQW6YKyoapuLPw0tlo6BDGFrgAqoQNCcmxO0hLoWv1hYUHeKEWqjc8ORD
         TK0kzjmrwIUORxSne6ED9gamBUcpWS5xUmfMF4DQnJCmDYd+hk91p5w5dLMULEPT9e10
         ovHz3aqeoN8SoYNLjljI2lVSEfbpA9kqPsnSIIKuuF7bbFylL4cfAYm1gpQBRC0HwRtb
         QG5+TysbPlSmqsMzb+BcZDCO0cdS5p4IQTpg0nVXJAH5PQdC4lNPkB8zvphm/qc1s4dW
         Cx4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713811660; x=1714416460;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=owEYz5PcX2V/77HEBhhtfv3jinwHJK/SDFDfp/Sqt3w=;
        b=GJDIpq8QeNuQlc1pOxzFg72NGS3FmyA5ruKed8hOTAVan+17hO9SWrDVRHCsrr8ORw
         /DVuSbS0LsZiG34Ce6mlFol8IWShNMTa4yqMvWDEKJZDE+KfhTpYEVhJu5wgTYmwTjQr
         09aR0CQsXdAKfYa1wIKnbDyczyH1SusqGLUUC+o6ZA2nokQCx3bNx151k5z3Av+GquCn
         SMlXXhwb2520pfWL+/jLsQfeIJfPHqfiXjVN0qk4rn5YfXoUsaoqbCTkRJ8JvjSx/2Yj
         6z1b+qD8LogQSCpsgWBUy36XLV69YemJdSzZwuY24jZc2ZjmNdX6eam9OOS10aebfTJA
         XIqA==
X-Forwarded-Encrypted: i=1; AJvYcCXzLS9jubb0R84vG0mhP1M0UMHEev+YseP/51EexsjDpddt5wwVt3DR6ZYsoWMctLV7yXWCrVmNWQ9eEIa9UUXTb6E8dEi4xH+SjtNHzjw=
X-Gm-Message-State: AOJu0YzKY/Mrrn1YIsIjjSZarxk1UnbUeFTlx3suSiHZrgOAQE+GekYx
	zWPxUItUt4m6pcNLR6ROT31umCvVbf8hmp9ovReU5rnMlzCUpzu5
X-Google-Smtp-Source: AGHT+IEjbIqLnAxfDcJjgknmPb5GWL+5HQ/C36pYtthEjpOFT0Ql7t5dq/2XIjAVrzgHR4C5YbOq5g==
X-Received: by 2002:a05:6359:760d:b0:18a:9bba:972a with SMTP id wg13-20020a056359760d00b0018a9bba972amr5822611rwc.32.1713811660340;
        Mon, 22 Apr 2024 11:47:40 -0700 (PDT)
Received: from localhost (24-122-67-147.resi.cgocable.ca. [24.122.67.147])
        by smtp.gmail.com with ESMTPSA id j18-20020ac86652000000b00437392f1c20sm4467829qtp.76.2024.04.22.11.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 11:47:40 -0700 (PDT)
Date: Mon, 22 Apr 2024 14:47:39 -0400
From: Benjamin Poirier <benjamin.poirier@gmail.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
	davem@davemloft.net, edumazet@google.com, parav@nvidia.com,
	mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	shuah@kernel.org, petrm@nvidia.com, liuhangbin@gmail.com,
	vladimir.oltean@nxp.com, idosch@nvidia.com,
	virtualization@lists.linux.dev
Subject: Re: [patch net-next v5 3/5] selftests: forwarding: add
 check_driver() helper
Message-ID: <ZiawyyOY-6radvXV@f4>
References: <20240418160830.3751846-1-jiri@resnulli.us>
 <20240422153303.3860947-3-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240422153303.3860947-3-jiri@resnulli.us>

On 2024-04-22 17:32 +0200, Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> Add a helper to be used to check if the netdevice is backed by specified
> driver.
> 
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> ---
>  tools/testing/selftests/net/forwarding/lib.sh | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
> index 9d6802c6c023..00e089dd951d 100644
> --- a/tools/testing/selftests/net/forwarding/lib.sh
> +++ b/tools/testing/selftests/net/forwarding/lib.sh
> @@ -278,10 +278,17 @@ check_port_mab_support()
>  	fi
>  }
>  
> -if [[ "$(id -u)" -ne 0 ]]; then
> -	echo "SKIP: need root privileges"
> -	exit $ksft_skip
> -fi

Why is the check being removed entirely? This change was not in v4 of
this patch. Did it happen unintentionally when removing "selftests:
forwarding: move initial root check to the beginning"?

> +check_driver()
> +{
> +	local dev=$1; shift
> +	local expected=$1; shift
> +	local driver_name=`driver_name_get $dev`
> +
> +	if [[ $driver_name != $expected ]]; then
> +		echo "SKIP: expected driver $expected for $dev, got $driver_name instead"
> +		exit $ksft_skip
> +	fi
> +}
>  
>  if [[ "$CHECK_TC" = "yes" ]]; then
>  	check_tc_version
> -- 
> 2.44.0
> 
> 
