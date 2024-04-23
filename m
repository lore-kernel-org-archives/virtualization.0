Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCEED65E20
	for <virtualization@lists.linux.dev>; Tue, 23 Apr 2024 10:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713869950; cv=none; b=FxP+N+EGr0DjzN1KeQBHBjFH32gUVaGjKuACMUFdYWZ5Jc9doXH552gmcrw4I+A/cxwIeoumo1MFZOQssk2S36et2RBm+Lgfdlx0kTVCbEld1bcW08EU5oqsSdQGeJpz2L+73RAmoM5kQkDp52krFyMSskdq7sgkwvZA/m44Yqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713869950; c=relaxed/simple;
	bh=VCIM8fphpg2wx5wS1Ev8Yru7L2gGj5YRS2RiKLz4gO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R73eLtntVeWG6TxOu0Mj8uT2PFLi6GBpqmKA68Jm2W2er8qdDRzebcZ40kvdtsHu0y/usKZFVOu3DdWxuMrwAg4wrn0OUolSP33DCZeZO5B2l933yRre3HIcL/sr1sQtujeyjmYxaMCZ32OJj1vUaRq4VeskbGor8/HZDs793lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=j0sgoxZL; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="j0sgoxZL"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-41a4f291f60so15784525e9.3
        for <virtualization@lists.linux.dev>; Tue, 23 Apr 2024 03:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713869947; x=1714474747; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v9eYSffLutyekkUg16FuXfR9J3J44OlThKKHWZXllQ8=;
        b=j0sgoxZLJEEp6MLaKBxfTYT4HwnFSD7FoOGuDO2+SoJ65mqdwIzpwkhVWMeNp6EKui
         UXBd+a/LG+G3XvO4LHVh0BhWHVPho005Acg3seao6/uH3fTevrlSP+xIoVVPjCWPKnNl
         3EoQF0KwcWuD2I85sYAcmoZmPY7Y4I6uJyq6sHBXrjuPLlh3RjL0BnSkCvAeOxr2Q2yO
         1yndr2frxOmAwr8D+8HjEu1r//34XaHFAjr+dbHl++PWTp/EFwoyOD0PGRf2EUCs7WxH
         hP470wo7KyaHNGCEbrkZjoqibKFCAwBGQnZBoCByQAaHbgcaOUHnns7d0GM57Q6ia3Ya
         7pTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713869947; x=1714474747;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v9eYSffLutyekkUg16FuXfR9J3J44OlThKKHWZXllQ8=;
        b=MVaifFRYKKFO55tvjuq0OsT11TmmDxz9JmsIo7NiLZSk7+IeKt4o/5If6o71DzK9L0
         hPegCpQpFsum14FUZrKScPOMA/2pmYYkZ3KHFmpAV73FyOmQCFzjxiXbNhaFFM3Gznv7
         dmMO/1nwBY2u2PYzwEl1UZh/EWvH6FrpYS1W99pOB2pUn7mcXo4KtlUOOa81sUjUp/3A
         WvIHmZ/X9iXoGY1TUbIAiSsh1bOjQuyWDytu8a3bvYzJX32XvMW5K7RoVbECpNC3dvtQ
         xnpzGIQdMTTnJpF/TPGEoau/dSJvm4HqkWVsoqYcADONhpt43pRlEQY4o5l3fsDKsE+M
         IDWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWitsD6/ltwjTrACyBJjz8TcxEuIe6zv8FswudF5exX0iHsLWkIoItyBBEYcYRYHVVSGiWRT7zVV7bPWlHeaO9gqkdn59M6MyzrCul9ks0=
X-Gm-Message-State: AOJu0YwZ6XaYyhDfWGj5y2Mrs2asP28pc8i5fKncVMaRlcLlBZsxg2qO
	cOQX1O2RVbEttOc/qzCMZ3hGLPluTnnywVHhZtOVQsr+Is3gfpfxRCT99eSrRIQ=
X-Google-Smtp-Source: AGHT+IGOlfmMGQYqlQ7v0Cu9gVXAoL7wHOkkoQIclnh6f8TpYdXA81OomiP0mJ8qvvgvGacWsTBnKA==
X-Received: by 2002:a05:600c:4508:b0:418:95a1:1975 with SMTP id t8-20020a05600c450800b0041895a11975mr9197041wmo.20.1713869946943;
        Tue, 23 Apr 2024 03:59:06 -0700 (PDT)
Received: from localhost (78-80-105-131.customers.tmcz.cz. [78.80.105.131])
        by smtp.gmail.com with ESMTPSA id w9-20020a05600c474900b0041a81ece2a7sm4800735wmo.19.2024.04.23.03.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 03:59:06 -0700 (PDT)
Date: Tue, 23 Apr 2024 12:59:05 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Benjamin Poirier <benjamin.poirier@gmail.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
	davem@davemloft.net, edumazet@google.com, parav@nvidia.com,
	mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	shuah@kernel.org, petrm@nvidia.com, liuhangbin@gmail.com,
	vladimir.oltean@nxp.com, idosch@nvidia.com,
	virtualization@lists.linux.dev
Subject: Re: [patch net-next v5 3/5] selftests: forwarding: add
 check_driver() helper
Message-ID: <ZieUeciv-0dmmPLQ@nanopsycho>
References: <20240418160830.3751846-1-jiri@resnulli.us>
 <20240422153303.3860947-3-jiri@resnulli.us>
 <ZiawyyOY-6radvXV@f4>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZiawyyOY-6radvXV@f4>

Mon, Apr 22, 2024 at 08:47:39PM CEST, benjamin.poirier@gmail.com wrote:
>On 2024-04-22 17:32 +0200, Jiri Pirko wrote:
>> From: Jiri Pirko <jiri@nvidia.com>
>> 
>> Add a helper to be used to check if the netdevice is backed by specified
>> driver.
>> 
>> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>> Reviewed-by: Petr Machata <petrm@nvidia.com>
>> ---
>>  tools/testing/selftests/net/forwarding/lib.sh | 15 +++++++++++----
>>  1 file changed, 11 insertions(+), 4 deletions(-)
>> 
>> diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
>> index 9d6802c6c023..00e089dd951d 100644
>> --- a/tools/testing/selftests/net/forwarding/lib.sh
>> +++ b/tools/testing/selftests/net/forwarding/lib.sh
>> @@ -278,10 +278,17 @@ check_port_mab_support()
>>  	fi
>>  }
>>  
>> -if [[ "$(id -u)" -ne 0 ]]; then
>> -	echo "SKIP: need root privileges"
>> -	exit $ksft_skip
>> -fi
>
>Why is the check being removed entirely? This change was not in v4 of
>this patch. Did it happen unintentionally when removing "selftests:
>forwarding: move initial root check to the beginning"?

Oh, a mistake.

I messed up the v5 submission, repost couple minutes ago but I missed
this comment. I will send v6 tomorrow.

Sorry!

>
>> +check_driver()
>> +{
>> +	local dev=$1; shift
>> +	local expected=$1; shift
>> +	local driver_name=`driver_name_get $dev`
>> +
>> +	if [[ $driver_name != $expected ]]; then
>> +		echo "SKIP: expected driver $expected for $dev, got $driver_name instead"
>> +		exit $ksft_skip
>> +	fi
>> +}
>>  
>>  if [[ "$CHECK_TC" = "yes" ]]; then
>>  	check_tc_version
>> -- 
>> 2.44.0
>> 
>> 
