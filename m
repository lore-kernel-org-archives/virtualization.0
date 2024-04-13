Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128F81C2A5
	for <virtualization@lists.linux.dev>; Sat, 13 Apr 2024 13:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713014882; cv=none; b=KxKZrDW/1NT5VUs6DkbGvtyP0cTcExOpq9m+VXFmyrzq1oc8DRbn07Ade/GnrkWOpxj58j3tbe3pjRPqnpV+TKXHId1fpNVHnV1z2WOAj+FSbUpHsPxZXQKlyLmfp+biE4ANYXflq/JirMwPNWeh3oca5i905uASZl4PrEKneNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713014882; c=relaxed/simple;
	bh=LwGLc3+IrgJjbQnLV1TC69YW8KHGYXfCXdLWqOnivX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r+fFpdgNEObE6UvFzZ5L6Pb7QVkJyS7xLw5CHz84s8hFt1w5AQf183jPfT+vni0o9PL/2vSJYHFXBu9sj88LY9/kEp0X/+3tUXSFIKQCytyy7O7NtVqBsmetP3DiHViMx+yTSXKDw5chot+mMQmSZ5tabwyAECZW9C2VvoBPFdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=TTNqDIFH; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="TTNqDIFH"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-516d727074eso2297495e87.0
        for <virtualization@lists.linux.dev>; Sat, 13 Apr 2024 06:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713014879; x=1713619679; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mdk3BCrsCTJnu5xf2tOmLWcHPXa5Tve1jVTCet9Q7JM=;
        b=TTNqDIFHFzICAIpSTkxVbucawMfi5qD7XlDmv4keGLTJQ/jADAtwZ7rNd2RAVkKT0t
         vsjZ1TBPITZTsf8dJU3aw9Y9bvtE5bS9vIAo01cp6XZev2D3RnmGjQCBPfUvbVUG3Iru
         dKYrw2oriA1nCkkb0q5UZpC5vdS8gpov1dNU1gHP6Dfzb5oVEQwGppQYGqcv3OF/GnO0
         vOHlb1bxZKfjdT/76Hn/0a9UbyAWwqW55WhWHfP9Xtd7/ejY7L9HfN0jmrZhxtfmGxoq
         z9G4Sn/8lTEkwnCI2UF+uLymd4Lt+D/7i6G/+Vh/89HX3z9wREJrFojXV+wBVs7bX7VU
         xwyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713014879; x=1713619679;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mdk3BCrsCTJnu5xf2tOmLWcHPXa5Tve1jVTCet9Q7JM=;
        b=LE1Uv12aoOsyAijfwLkvIqGrIpRfEqIKLEkbqAX1ZZAaGxJrslXqEjDACbpowYfxKV
         c761PSVAmaXFa1KqoGXt3UdnvJeaimQZI5R9pG6oFXSpe9HYzusX7Y94rrdf3dqSqgBk
         SYCQ1L72Ffu1m3d6DL4oUGKRGi9G+H5l/8FrCOgP3mfalfMrRRR9u9rbs1gAQTmBccX0
         q7HZnkQsTTz9GCHQ1SXZm0+1G7zhY5fg0OBS0Kvikd9wp8O6PlGqub93Air2Eh2V2EuJ
         DR4jj5pUxMSpymyEr1C8lhGZgF3ck4KxA4GNwwsyOkLf60MFfblQF7PxJBhfEyhRs5Vd
         6X0w==
X-Forwarded-Encrypted: i=1; AJvYcCXIqrb2nIk1osADX/sUP5Bpeqs5v7Ef+2KWuC8R1WCN36Gw+j8FdCaHLaNwSUcIFIq9+k+lb170tXYgTlwp63ee5JLy2ZZ49c0MezBmq4I=
X-Gm-Message-State: AOJu0Yz4GWkdr+3TqtYdx0O7DU0BstlHD0svPd1Lzn0pn+6+2G/0EzLI
	OLlrdsoFO6gqqt0dqdrKzMWUFxHIoMBX6H8QPg2HaiWiXirR7BW/37vN0166X2Q=
X-Google-Smtp-Source: AGHT+IHuuYRVy65MZ8rYdAOA7GSedvsAl/kLZcW/Y4B0ECtDIK457OVH4T7sHnxelpZv0xl1aRVvqA==
X-Received: by 2002:a05:6512:33c8:b0:518:b069:3b7d with SMTP id d8-20020a05651233c800b00518b0693b7dmr878248lfg.6.1713014879122;
        Sat, 13 Apr 2024 06:27:59 -0700 (PDT)
Received: from localhost (37-48-0-252.nat.epc.tmcz.cz. [37.48.0.252])
        by smtp.gmail.com with ESMTPSA id hd7-20020a170907968700b00a524dda47c0sm691236ejc.143.2024.04.13.06.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Apr 2024 06:27:58 -0700 (PDT)
Date: Sat, 13 Apr 2024 15:27:57 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Benjamin Poirier <benjamin.poirier@gmail.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
	davem@davemloft.net, edumazet@google.com, parav@nvidia.com,
	mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	shuah@kernel.org, petrm@nvidia.com, liuhangbin@gmail.com,
	vladimir.oltean@nxp.com, idosch@nvidia.com,
	virtualization@lists.linux.dev
Subject: Re: [patch net-next 3/6] selftests: forwarding: add ability to
 assemble NETIFS array by driver name
Message-ID: <ZhqIXZYnHA0MZT3L@nanopsycho>
References: <20240412151314.3365034-1-jiri@resnulli.us>
 <20240412151314.3365034-4-jiri@resnulli.us>
 <ZhmbxntSvXrsnEG1@f4>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZhmbxntSvXrsnEG1@f4>

Fri, Apr 12, 2024 at 10:38:30PM CEST, benjamin.poirier@gmail.com wrote:
>On 2024-04-12 17:13 +0200, Jiri Pirko wrote:
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
>>  tools/testing/selftests/net/forwarding/lib.sh | 39 +++++++++++++++++++
>>  1 file changed, 39 insertions(+)
>> 
>> diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
>> index 6f6a0f13465f..06633518b3aa 100644
>> --- a/tools/testing/selftests/net/forwarding/lib.sh
>> +++ b/tools/testing/selftests/net/forwarding/lib.sh
>> @@ -55,6 +55,9 @@ declare -A NETIFS=(
>>  : "${NETIF_CREATE:=yes}"
>>  : "${NETIF_TYPE:=veth}"
>>  
>> +# Whether to find netdevice according to the specified driver.
>> +: "${NETIF_FIND_DRIVER:=}"
>> +
>
>This section of the file sets default values for variables that can be
>set by users in forwarding.config. NETIF_FIND_DRIVER is more like
>NUM_NETIFS, it is set by tests, so I don't think it should be listed
>there.

Well, currently there is a mixture of config variables and test
definitions/requirements. For example REQUIRE_JQ, REQUIRE_MZ, REQUIRE_MTOOLS
are not forwarding.config configurable (they are, they should not be ;))

Where do you suggest to move NETIF_FIND_DRIVER?


>
>>  # Constants for ping tests:
>>  # How many packets should be sent.
>>  : "${PING_COUNT:=10}"
>> @@ -94,6 +97,42 @@ if [[ ! -v NUM_NETIFS ]]; then
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
>> +}
>> +
>> +find_netif()
>> +{
>> +	local ifnames=`ip -j -p link show | jq -e -r ".[].ifname"`
>
>-p and -e can be omitted

True. Will remove them.
