Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78001BF53
	for <virtualization@lists.linux.dev>; Wed, 17 Apr 2024 18:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713380311; cv=none; b=TUruwBewx8YP0XJE+egaEM0Dom67G5MPLqtgGe9Z1dozyEGqs7jy/F/3YKgibfXE/Luerz6n84UaZ3bTNdlCIg5gIttdoc0Fq2L2Dthtm2k6OZrg7HAi5h2wB7HNp7mMhORD5W/oSQui5DLGAX2ikIqZkbzvYb/XN7jGRfH+e90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713380311; c=relaxed/simple;
	bh=/jnFAtk5JrhCZKzNlE0FZi4DnJAjgqAmYsYCDTMivik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hn/Mdl2y8FSMyRqwZwEPgInME/djwS5RyG6AOJdolXDvkrkuZx09lQ9qPnQl3PG4wjdl7ZoHPjnzhSuoGHM+jHzvVDrhnoDPex6pZocmUy14ZMg+eo+FQ45BbKgUPSJTfKryaK6p95bMemqIcj0QAXWVE7+mJTbFgqSNV/pl8dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wt+3we4f; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wt+3we4f"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4349685c845so50761cf.0
        for <virtualization@lists.linux.dev>; Wed, 17 Apr 2024 11:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713380308; x=1713985108; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fAbbCnyx7krUH4X1bdxFgDOmkasKsIov7yr+n3NIJH0=;
        b=Wt+3we4fPJ3YkzpiDF74cXpcjWwiAs1wdXeKodkLwPTaKRQZ9ukF/dot+SInTov2O9
         f5+87py9e+fZez4XsFvX5Xd0lsClLLgyT7/NbUTpUsmP/DYAW2H3fBAaQH3Zc/rjJygt
         KJHdahDYEWZWsQGjSmQHoh62lG5VybkSn0laERAYWswm0wRcAKstrR7KkBgbVEXOljj1
         9GxfpSPnhij+FXiMLzyiJ0RPpouJ3Fai8vJSFUz8bs/KzDGkN/h96eQjAyfmyssAnV7O
         HRKxpsJ+T/hPDYekVr850f4eQbQAzopbku0Pbu88Qed0njQhrZk7qf4LWCUH21QOBri8
         /07Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713380308; x=1713985108;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fAbbCnyx7krUH4X1bdxFgDOmkasKsIov7yr+n3NIJH0=;
        b=ZqWXJyIz98mulVMdgtu6vrf4fTxopolpen7/xY9BmHX+stBx74ge6ULCKBNgOLYfhJ
         etSBkrVrBdpyZvH3CnCsLmdTIYj7tyxNekOGC9/wPsZjb2dWMV4lJ9Y6HsSS/222C3g4
         5DMg2Z2rVCc4g/nZw8ZIKf6CAuiH9AHdV9jDZN0xZOvV+Ft7gh/jTa+UC9IUEXfVPEQi
         WKWWK3n3YhzyTBCdvVkUK5X4L7FuxDGYKq48TraSkZ/CSbXKTlYQLLmIrnT2pVaVPWLW
         QKvF75RnqKln26DCEVKnfmz60H54tO54Q6L4fiKbScfhY3sadBgedzYEOGn07008mj/+
         3uyw==
X-Forwarded-Encrypted: i=1; AJvYcCVXREzvhmyMAOB6NTqo1s0hMF99BC8rhfCQjVHpMcW0CUrE6bdmKeRZSORGQ+MrWRfF27LPuiroO4KdIK0EFk+MGdG6J9p8HjBArfXpruI=
X-Gm-Message-State: AOJu0YyGl1WiGzSTB5kW92ZD/yxeWuscNDevvdZP8dmKdCnzdrLHvIco
	q0ivM5IdJSFnqStsahJyX/G/F01cOsOz2ldy0ENqdw8YOARaGRkM
X-Google-Smtp-Source: AGHT+IFbqlGvvzByv8jR2ziRuPLaB/yqLU/1wtab9WpmRhUSYTXy/ttB2aaZU4Y+QHqkOgRWl7qnkQ==
X-Received: by 2002:a05:622a:1787:b0:436:888f:80d0 with SMTP id s7-20020a05622a178700b00436888f80d0mr501009qtk.28.1713380308527;
        Wed, 17 Apr 2024 11:58:28 -0700 (PDT)
Received: from localhost (24-122-67-147.resi.cgocable.ca. [24.122.67.147])
        by smtp.gmail.com with ESMTPSA id e15-20020ac8490f000000b00434d86fb403sm8327092qtq.86.2024.04.17.11.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 11:58:28 -0700 (PDT)
Date: Wed, 17 Apr 2024 14:58:27 -0400
From: Benjamin Poirier <benjamin.poirier@gmail.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
	davem@davemloft.net, edumazet@google.com, parav@nvidia.com,
	mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	shuah@kernel.org, petrm@nvidia.com, liuhangbin@gmail.com,
	vladimir.oltean@nxp.com, idosch@nvidia.com,
	virtualization@lists.linux.dev
Subject: Re: [patch net-next v3 2/6] selftests: forwarding: move couple of
 initial check to the beginning
Message-ID: <ZiAb0wZcWDSozCoq@f4>
References: <20240417164554.3651321-1-jiri@resnulli.us>
 <20240417164554.3651321-3-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240417164554.3651321-3-jiri@resnulli.us>

On 2024-04-17 18:45 +0200, Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> These two check can be done at he very beginning of the script.
> As the follow up patch needs to add early code that needs to be executed
> after the checks, move them.
> 
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> ---
>  tools/testing/selftests/net/forwarding/lib.sh | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
> index 7913c6ee418d..2e7695b94b6b 100644
> --- a/tools/testing/selftests/net/forwarding/lib.sh
> +++ b/tools/testing/selftests/net/forwarding/lib.sh
> @@ -84,6 +84,16 @@ declare -A NETIFS=(
>  # e.g. a low-power board.
>  : "${KSFT_MACHINE_SLOW:=no}"
>  
> +if [[ "$(id -u)" -ne 0 ]]; then
> +	echo "SKIP: need root privileges"
> +	exit $ksft_skip
> +fi
> +
> +if [[ ! -v NUM_NETIFS ]]; then
> +	echo "SKIP: importer does not define \"NUM_NETIFS\""
> +	exit $ksft_skip
> +fi
> +

I noticed that this part conflicts with the recently merged commit
2291752fae3d ("selftests: forwarding: lib.sh: Validate NETIFS"). Can you
please verify that the conflict was fixed correctly? The above check is
now duplicated in the file.
