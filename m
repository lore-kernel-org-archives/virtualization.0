Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC739224FD
	for <virtualization@lists.linux.dev>; Fri, 12 Apr 2024 20:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712954316; cv=none; b=l82SNAe8se1OenhQLesVpaDUajVTT/up1LrnROLUHpKZjgkh2LhyerfZ0FXjySDFWHSqair8Fe5Th9H5BDMINpBOnfrNgD07n8d68/J25wQ5jSH6x1L+/08PFx8ChRXpksIX5bBf1iqWls0SxhrwRVbQS47vB4P5px7EM3xzo6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712954316; c=relaxed/simple;
	bh=AgzgRk74KXDZId4KH0xeAJixKr/X5xQZUc3HsNPvF4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E1WX/+xyIkJpY/6+IpEtzYZrGmqI3Zu6Z+MaZ/xTD1wWhtpnsR9Z9eHiAXW5F6l3SGjNH1vsSmKbNyokcCqmEnQf9NzNWSsRIIz38Fa9E1A4g2WlcoZ+7p8M0hHfWwUVc70iH0DAfLcUmk03GR05zHzqHaCvq5JML5Y/C+3hcpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CrPp978e; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CrPp978e"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-78d5f0440d3so78733485a.2
        for <virtualization@lists.linux.dev>; Fri, 12 Apr 2024 13:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712954314; x=1713559114; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CK01dkOENUUDTd8rBoVUEkiepABAWB4n11EFeo8kwxI=;
        b=CrPp978e4Xi2iS7NTzNZ2utb08ASF21vot00cZEPTO4rGOBE1T94Aj7kyyv80qzCM6
         u9R4acM/it7ZEUZYAIzuWMUqOUc1q4ACAlNMcVV0FFjzMKrbLnkfiPLHUL92m4b+s4UA
         TpbKnhH8grLToeGwr4B5ZN3aJhk1Ej1EeP2sGembWYVR2+U902bWiXpNUX1+0bHAPQpn
         O8H1yp6Se3ZNpWDlk5GatYNl91cj2KtBZsFXX/qbtc1r7n/F4Mz6nWaLCCvkJ64qBqd+
         jfS8FcrWzPpAZE4mctfMaBs3pQVMyD6ad69QYimSeScJey6VwlZ0i0Ro8gXfBssuwSmw
         vEyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712954314; x=1713559114;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CK01dkOENUUDTd8rBoVUEkiepABAWB4n11EFeo8kwxI=;
        b=qG7LiaYqmfNc0te90q/aM72INkWuizTLKeLdhm+hioszgseLwOY1DfN93dg+zj2d92
         AZBNWNlt24aENE/yvC1wFkRszfGoOiOoI0mANA0cjYZhfCnwmCyc8WkIEugkeEEpGszh
         Vjb0RrBzVe+K/anq6ltu3t/ZcjRmEk/Vq4tBVOsRqUVWPjnhOPbYORaHHf2nC+HZLL2a
         4qGZpvi8aGA6/MEBTq9UZ77aktXUeUTMYO3vL1/9rt/T2N6p36X+enpBAaqNcLbYvAj8
         dsSifhRmmj/zt/Hp4QsNjzp0m9BPxu8F3KqQWagHryvPUzkWGTqjjlSmGL2Y1Tk8KR4V
         Y7qQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSn+eLf1IZHMrsT6BQ/Gzi1s0inrLHlEALpJWNBjvYf54Hu0PkwO537GL4QC6GHi8m2ABRpoKefAiZMGUcPiQWBUs0tkc9G4heAcxCg6I=
X-Gm-Message-State: AOJu0Yzddv2eZUOtfFCv2tYuuH4DeKktuUreWyGrcXkUgouZHDLXpfD6
	GlJ1zzy3ut94LFgzsPFyGGSTFYjbOcvZpBXLS8h5TYLJWPRRCrgw
X-Google-Smtp-Source: AGHT+IE43atYWdaaL4eHT2oZ1gaBsE1wMKkNJhhxZU6jTFtCOJ6raFzpkE6zp8J76FjOhKhpTi3Hsw==
X-Received: by 2002:a05:620a:b47:b0:78e:bd36:6dbd with SMTP id x7-20020a05620a0b4700b0078ebd366dbdmr3764014qkg.34.1712954313667;
        Fri, 12 Apr 2024 13:38:33 -0700 (PDT)
Received: from localhost ([142.169.16.165])
        by smtp.gmail.com with ESMTPSA id xy2-20020a05620a5dc200b0078d6120fad0sm2837650qkn.108.2024.04.12.13.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 13:38:33 -0700 (PDT)
Date: Fri, 12 Apr 2024 16:38:30 -0400
From: Benjamin Poirier <benjamin.poirier@gmail.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
	davem@davemloft.net, edumazet@google.com, parav@nvidia.com,
	mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	shuah@kernel.org, petrm@nvidia.com, liuhangbin@gmail.com,
	vladimir.oltean@nxp.com, idosch@nvidia.com,
	virtualization@lists.linux.dev
Subject: Re: [patch net-next 3/6] selftests: forwarding: add ability to
 assemble NETIFS array by driver name
Message-ID: <ZhmbxntSvXrsnEG1@f4>
References: <20240412151314.3365034-1-jiri@resnulli.us>
 <20240412151314.3365034-4-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240412151314.3365034-4-jiri@resnulli.us>

On 2024-04-12 17:13 +0200, Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> Allow driver tests to work without specifying the netdevice names.
> Introduce a possibility to search for available netdevices according to
> set driver name. Allow test to specify the name by setting
> NETIF_FIND_DRIVER variable.
> 
> Note that user overrides this either by passing netdevice names on the
> command line or by declaring NETIFS array in custom forwarding.config
> configuration file.
> 
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> ---
>  tools/testing/selftests/net/forwarding/lib.sh | 39 +++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
> index 6f6a0f13465f..06633518b3aa 100644
> --- a/tools/testing/selftests/net/forwarding/lib.sh
> +++ b/tools/testing/selftests/net/forwarding/lib.sh
> @@ -55,6 +55,9 @@ declare -A NETIFS=(
>  : "${NETIF_CREATE:=yes}"
>  : "${NETIF_TYPE:=veth}"
>  
> +# Whether to find netdevice according to the specified driver.
> +: "${NETIF_FIND_DRIVER:=}"
> +

This section of the file sets default values for variables that can be
set by users in forwarding.config. NETIF_FIND_DRIVER is more like
NUM_NETIFS, it is set by tests, so I don't think it should be listed
there.

>  # Constants for ping tests:
>  # How many packets should be sent.
>  : "${PING_COUNT:=10}"
> @@ -94,6 +97,42 @@ if [[ ! -v NUM_NETIFS ]]; then
>  	exit $ksft_skip
>  fi
>  
> +##############################################################################
> +# Find netifs by test-specified driver name
> +
> +driver_name_get()
> +{
> +	local dev=$1; shift
> +	local driver_path="/sys/class/net/$dev/device/driver"
> +
> +	if [ ! -L $driver_path ]; then
> +		echo ""
> +	else
> +		basename `realpath $driver_path`
> +	fi
> +}
> +
> +find_netif()
> +{
> +	local ifnames=`ip -j -p link show | jq -e -r ".[].ifname"`

-p and -e can be omitted
