Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4251115FA61
	for <virtualization@lists.linux.dev>; Thu, 18 Apr 2024 12:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713442470; cv=none; b=AohoKJEM9/2ePugfvn8IyQa0zZglOQ2fn0DTbe9F/zGDYTa0jQKdr65gCwvqfgyTIij9d/j8G4XOeGWP8yq9MvYPYbFr6fz4FgmVj82lZmvLR14dhleQHIIblUtk/p2yG1mY/AbWgqrpWzKmyqhRVz+WhH7YoG2ScB1zB9PCfaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713442470; c=relaxed/simple;
	bh=ARDKhUMyorB3Kv9r/SkCvfmQXbsY+zsxPmXEiMW0iLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s7+ZhZCezBGy9VzCTGNhAma7d3levLveYr2q32Vkstdv4lodRMT2UjqvcjNFsnlDWwxMI+eroWz+kuoGDVv7/B3NZ+aUe29NSTkqSvIfC4wYE/J6H6pwLVj7YmKMfNHB9sHk0uKvK0nywtPKkTS7Y0pnyn5scnLEbR39F/gnf1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=xfxTw8v/; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="xfxTw8v/"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2da01cb187cso13986161fa.0
        for <virtualization@lists.linux.dev>; Thu, 18 Apr 2024 05:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713442466; x=1714047266; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C8I73lkdTXjzUlQb3r+JVz+alI3Ct3G5CCb+F55/1Q4=;
        b=xfxTw8v/KrvSiIys3s0qhdT0JewhdTstCJwf06JhFOzwB1bf/0zgGq77ebS5VcgOQ/
         ZmvV+QEema3/e3NyBfIwNWXHAerzcsfr9Jg2hY+dLx3CxRGLKgFCrQt5ntn+YtdOoxr2
         Er8oQ557BbasMiF7E7CJJQYK4bnrdSSyUUtDFlI8BvQpzW7qQ+P+oa00+fnBoJx4GsoR
         WiT+iNUOtwJsdDgkCqTk5hmpIf7whztAiNfghD+O9RCF8wkRU6Z2gS2HEJXQiEixrLLA
         w+cnbf8pgJpF8N6DdJaymtL5PkXAZ/9FlUf0d2AvzgklxzKNhrvi83mqfGimgYWST/QH
         MRug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713442466; x=1714047266;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C8I73lkdTXjzUlQb3r+JVz+alI3Ct3G5CCb+F55/1Q4=;
        b=W10OkkQkCPeVpsnuUiMGkeqPByMgZfk9axMpMvFb395Ixb1B1lRYLukNYzpUoHbsaZ
         zeSruQyaLgNFJgWrxi6I/d+1SXqmnWjGAP3jwcTsj9M3ctvJzLupZ51p+odJzfcmTuG5
         PWjkBi5pm6qD14aQTxr/H6/qPA1PwReIjhliVZY1v8aW376NTG6ScfpislL2Ki1rzQd5
         rFPwxQavDvvi6S0fVyCVSbW1y6i7DCJ/WNCSZjrn/QL80zma86fkAkMw3+XLJhPxIW3L
         Hu/N3sK/PkRmm+RfsLcrTWr3DOBpyw6NRYEvoa3zUXTACaTSh3qTha1nG/I+5NV3mn7d
         bsMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUF5tBYN+eQWkKTnLvIqVhtI4zYM3yk51kmp+kdXbkPS8bG+NpDp2y9SJgk5+8JiKHSCq77Xsz7nqyDnvxUQ4DXF6BvnL9uWB3/ii+1YyU=
X-Gm-Message-State: AOJu0YxDj3kXuMcjn3LiopEftIGkplH6xlKIwIaRaLaYUC7xmabcuW2g
	HnSqZVRYgF2+QzkFAiBrWPYI9bMFlH8IojPNufK2eGePhhmD79AVhuz6Z3OauPE=
X-Google-Smtp-Source: AGHT+IGpPgt4PAoJXQCAEuvUwqMXEOjcT4P3uK8NQz4SSFByhPpqHL3h7sY69rapnfoIi9Bl7b9ZCg==
X-Received: by 2002:a2e:a71f:0:b0:2dc:ae50:d890 with SMTP id s31-20020a2ea71f000000b002dcae50d890mr82985lje.26.1713442466022;
        Thu, 18 Apr 2024 05:14:26 -0700 (PDT)
Received: from localhost (78-80-105-131.customers.tmcz.cz. [78.80.105.131])
        by smtp.gmail.com with ESMTPSA id j18-20020a170906051200b00a51ba0be887sm806927eja.192.2024.04.18.05.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 05:14:25 -0700 (PDT)
Date: Thu, 18 Apr 2024 14:14:23 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Petr Machata <petrm@nvidia.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
	davem@davemloft.net, edumazet@google.com, parav@nvidia.com,
	mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	shuah@kernel.org, liuhangbin@gmail.com, vladimir.oltean@nxp.com,
	bpoirier@nvidia.com, idosch@nvidia.com,
	virtualization@lists.linux.dev
Subject: Re: [patch net-next v3 3/6] selftests: forwarding: add ability to
 assemble NETIFS array by driver name
Message-ID: <ZiEOn1GyZhyDfr25@nanopsycho>
References: <20240417164554.3651321-1-jiri@resnulli.us>
 <20240417164554.3651321-4-jiri@resnulli.us>
 <87bk67cbuc.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bk67cbuc.fsf@nvidia.com>

Thu, Apr 18, 2024 at 10:11:12AM CEST, petrm@nvidia.com wrote:
>
>Jiri Pirko <jiri@resnulli.us> writes:
>
>> From: Jiri Pirko <jiri@nvidia.com>
>>
>> Allow driver tests to work without specifying the netdevice names.
>> Introduce a possibility to search for available netdevices according to
>> set driver name. Allow test to specify the name by setting
>> NETIF_FIND_DRIVER variable.
>>
>> Note that user overrides this either by passing netdevice names on the
>> command line or by declaring NETIFS array in custom forwarding.config
>> configuration file.
>>
>> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>> ---
>> v1->v2:
>> - removed unnecessary "-p" and "-e" options
>> - removed unnecessary "! -z" from the check
>> - moved NETIF_FIND_DRIVER declaration from the config options
>> ---
>>  tools/testing/selftests/net/forwarding/lib.sh | 39 +++++++++++++++++++
>>  1 file changed, 39 insertions(+)
>>
>> diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
>> index 2e7695b94b6b..b3fd0f052d71 100644
>> --- a/tools/testing/selftests/net/forwarding/lib.sh
>> +++ b/tools/testing/selftests/net/forwarding/lib.sh
>> @@ -94,6 +94,45 @@ if [[ ! -v NUM_NETIFS ]]; then
>>  	exit $ksft_skip
>>  fi
>>  
>> +##############################################################################
>> +# Find netifs by test-specified driver name
>> +
>> +driver_name_get()
>> +{
>> +	local dev=$1; shift
>> +	local driver_path="/sys/class/net/$dev/device/driver"
>> +
>> +	if [ ! -L $driver_path ]; then
>> +		echo ""
>> +	else
>> +		basename `realpath $driver_path`
>> +	fi
>
>This is just:
>
>	if [[ -L $driver_path ]]; then
>		basename `realpath $driver_path`
>	fi

Ok.


>
>> +}
>> +
>> +find_netif()
>
>Maybe name it find_driver_netif? find_netif sounds super generic.

netif_find_driver() to be aligned with the variable name.


>
>Also consider having it take an argument instead of accessing
>environment NETIF_FIND_DRIVER directly.

Considered, don't see any benefit. Touching outside variable NETIFS
anyway.


>
>> +{
>> +	local ifnames=`ip -j link show | jq -r ".[].ifname"`
>> +	local count=0
>> +
>> +	for ifname in $ifnames
>> +	do
>> +		local driver_name=`driver_name_get $ifname`
>> +		if [[ ! -z $driver_name && $driver_name == $NETIF_FIND_DRIVER ]]; then
>> +			count=$((count + 1))
>> +			NETIFS[p$count]="$ifname"
>> +		fi
>> +	done
>> +}
>> +
>> +# Whether to find netdevice according to the specified driver.
>> +: "${NETIF_FIND_DRIVER:=}"
>
>This would be better placed up there in the Topology description
>section. Together with NETIFS and NETIF_NO_CABLE, as it concerns
>specification of which interfaces to use.


You replied yourself.



>
>> +
>> +if [[ $NETIF_FIND_DRIVER ]]; then
>> +	unset NETIFS
>> +	declare -A NETIFS
>> +	find_netif
>> +fi
>> +
>>  net_forwarding_dir=$(dirname "$(readlink -e "${BASH_SOURCE[0]}")")
>>  
>>  if [[ -f $net_forwarding_dir/forwarding.config ]]; then
>

Thanks!

