Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F9175808
	for <virtualization@lists.linux.dev>; Tue, 16 Apr 2024 09:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713260085; cv=none; b=sqPfelZx/1hBBrja20iEvui1IauktUJteNeklWEQ9TvOmpjSYeJ4zkNDsKQNODMtjdhVephOCN/0dANrqCaXnjycYGt+k0OyNFsqnGOSJ/6kG9cNGkoN5wshvrcieBALC1rKdSAYF5qMOeMQbWMxaXiapRhz52tFF+d/yZcT6kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713260085; c=relaxed/simple;
	bh=0robNhg7B+9Zlp5j5e9aAu88aVVJ97HJME/FDcistg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E3jc1fyv10/QChrSx62MbHzWFMI89OWHfF97MQAigcwZKGKWvFNwlC/GEW7BOTQweVjwu2WUhmuDmwfnA49+Tqx3zPmBGWF91l8YnVpgNZUwsd8tKnBZgEV73PVWr29HF3MwxDiM3BMRpvGT2UCmdQ5wKBL0eV79rMlqUvaitzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=knS46YM5; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="knS46YM5"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-56e6acb39d4so5522173a12.1
        for <virtualization@lists.linux.dev>; Tue, 16 Apr 2024 02:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713260081; x=1713864881; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TXdJcj/+kkmPAAsoR7RNPh07NL/neM0chAFl9zi98KQ=;
        b=knS46YM58V51Qwx23pnbf95SNj4p3Kspw+3SEEoKCwqqzAjhQdaMXJrhK9SE7mqv/N
         +ddkkstXotkcij4AJ7kepmqVAB7eLRqf37pyo2PfDqHGDVkftYA0zohDaiHey9g+g6oz
         N7xjZXmN87xBum9i/2P0iDg2xNMrSnY5rKQBONxpjzkQ7t6czE1DH+JHMwb39sxcq8Z3
         CybNDd/hT6Pk+cHhD0h8YEAjYXEKYJd+GdBH46+YW6EueKF+kO9mAH5KKCc6xIATE6nX
         lgOVpkJCk044LrfawdhLxH1nnKptJAvvYl31xf8eGocH1edEqSFOeHg05iEAqYQr+13Q
         tXwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713260081; x=1713864881;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TXdJcj/+kkmPAAsoR7RNPh07NL/neM0chAFl9zi98KQ=;
        b=k3r87Cmu5aAww2Im0FZLpp5+PYE9V/3/dUpqmsM6sFHMaAy3lUygD531Z4cTk/6NSL
         m8vRChj45X24XAzOT7yisMcgLjf7uog9Bvh/vIDMVljJBurb5eFLiODBwfQIuP2UWQVD
         f7JtogtUVTFD6WVs+JWF7WvQGOxWt7rrvaNnIYUIfxTM8jmpirsk7BvDTAGs7f6isO95
         npxL6cUF/vObvsuAuZjuvyFklG7cTSymANKMz4MBWx5yxQp7cwbwqd9VJavkV9bCPMq8
         VfXl8eFovfHWhDI2oQ5ERUJ/Zd0u4H+PWdDVXb6mLSzgSjRlW5C5mfpp5x8HQOzFbETt
         AmfA==
X-Forwarded-Encrypted: i=1; AJvYcCX/XTT4dCeMC2aqqIgnKIqBH1yYiTkgRofu5kFLq8pAVhnjHEm82upyt4cpcoJIWG6IoL8pn1mLSMFT7c4qlVMIGAu4Efll6bc3y6aakpQ=
X-Gm-Message-State: AOJu0YyEmcqCJRpyQa2fnMjbXOC8bbPK3q8QbIAzeEG+IL8lOREybmin
	TQM3xW0EHcDpmFyukX+REnimq1ZX8EdRi43BUjFomaD/XRUViQWjCRHCjLQXfug=
X-Google-Smtp-Source: AGHT+IEcF71q+APVvmpSN2MuaXTLK4lkrhQWNOrBmoEma6xaeVUC0eN75AkjqcL8y4SJsprLmIdWIg==
X-Received: by 2002:a50:cdc2:0:b0:56e:bad:36b with SMTP id h2-20020a50cdc2000000b0056e0bad036bmr7845401edj.21.1713260080886;
        Tue, 16 Apr 2024 02:34:40 -0700 (PDT)
Received: from localhost ([37.48.42.173])
        by smtp.gmail.com with ESMTPSA id l3-20020a056402124300b00570229afc16sm2726329edw.7.2024.04.16.02.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 02:34:40 -0700 (PDT)
Date: Tue, 16 Apr 2024 11:34:37 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Benjamin Poirier <benjamin.poirier@gmail.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
	davem@davemloft.net, edumazet@google.com, parav@nvidia.com,
	mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	shuah@kernel.org, petrm@nvidia.com, liuhangbin@gmail.com,
	vladimir.oltean@nxp.com, idosch@nvidia.com,
	virtualization@lists.linux.dev
Subject: Re: [patch net-next v2 5/6] selftests: forwarding: add
 wait_for_dev() helper
Message-ID: <Zh5GLQZxfW7d4WBF@nanopsycho>
References: <20240415162530.3594670-1-jiri@resnulli.us>
 <20240415162530.3594670-6-jiri@resnulli.us>
 <Zh2enn9ArVKDrdIy@f4>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zh2enn9ArVKDrdIy@f4>

Mon, Apr 15, 2024 at 11:39:42PM CEST, benjamin.poirier@gmail.com wrote:
>On 2024-04-15 18:25 +0200, Jiri Pirko wrote:
>> From: Jiri Pirko <jiri@nvidia.com>
>> 
>> The existing setup_wait*() helper family check the status of the
>> interface to be up. Introduce wait_for_dev() to wait for the netdevice
>> to appear, for example after test script does manual device bind.
>> 
>> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>> ---
>> v1->v2:
>> - reworked wait_for_dev() helper to use slowwait() helper
>> ---
>>  tools/testing/selftests/net/forwarding/lib.sh | 13 +++++++++++++
>>  1 file changed, 13 insertions(+)
>> 
>> diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
>> index 254698c6ba56..e85b361dc85d 100644
>> --- a/tools/testing/selftests/net/forwarding/lib.sh
>> +++ b/tools/testing/selftests/net/forwarding/lib.sh
>> @@ -746,6 +746,19 @@ setup_wait()
>>  	sleep $WAIT_TIME
>>  }
>>  
>> +wait_for_dev()
>> +{
>> +        local dev=$1; shift
>> +        local timeout=${1:-$WAIT_TIMEOUT}; shift
>> +
>> +        slowwait $timeout ip link show dev $dev up &> /dev/null
>
>Sorry, I just noticed that this includes the "up" flag. I was confused
>for a while until I realized that `ip` returns success even if the
>interface is not up:
>
># ip link set dev eth1 down
># ip link show dev eth1 up
># echo $?
>0
>
>So wait_for_dev() really does just wait for the device to appear, not
>for it to be up. If you agree, please remove the 'up' keyword to avoid
>confusion.

That is the intension :) I don't care about it being up, I just need to
have it in the system.

