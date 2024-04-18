Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB5B8C11
	for <virtualization@lists.linux.dev>; Thu, 18 Apr 2024 06:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713420981; cv=none; b=TVT6xBNVyqe2NXNWhvJZHUO+nuekbpN15Uci94z+t5ohM06A18E+z5A5OQbHmb4Y7kJTnYwiW9F2RLYs2lxdFXtFrY+rM2e7FVT/rVo8XR1GOs3MAM0+2/vcj0V4Q+HCEVu5HqeSsWpzEhTHXvNNQqczw6FXamCS/rra1SigrVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713420981; c=relaxed/simple;
	bh=HH0x58aeITczEaoOTmgbXQZRHs2VvH12CDc1gcImzfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jkZdukv2LrtWmx/KZnByHxKjtiMmJgrKfyhN8WNz5j3c50CWWyEjXU4haotwh42JWaTqWha1Bo90gpOoc2EGZ6QWQD1wHIDer8VY59A2P7KFirwFSpfEADyx4G8ExeASXURXt01GrL9ocXkgOCF+l3Fd/ohC7NwhCB6/kJueLws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=Koj1J13x; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="Koj1J13x"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a526d0b2349so42789866b.3
        for <virtualization@lists.linux.dev>; Wed, 17 Apr 2024 23:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713420977; x=1714025777; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zM+AwiIA7FKrgS/Ytacnt1rsdmjxxW5sRnLCAiG5Ajk=;
        b=Koj1J13xnXJQCu/hPeUX2AF6dMqd48t1FTcfoZnD717Rmvt0JUqXd3vfhM8slHSJcK
         YTyBWJnGwT1R84LBuJwFJINOtnbC/H0zMb4swAl2plyJFWfzQrbW5DS0tmm2E2fX+x7N
         HiY+1IR6X0guiSAZ4C/I+KYfXO6xszTW+3vEZq27oE4RNqKl7LURxOD7f0UUsXGm/qMP
         ECgFGb5/zg0UuCArohIo87d9iV6JX15mT7V+LMgkp4x+iSjSgtqJfERWknEzYPqmTvyd
         qYA7lA29eqI+VxpdJj2F5oGZZCB2Cr04U93F9AFUibWNwcePo2GWeBynhVCuBD9KYG/j
         FMdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713420977; x=1714025777;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zM+AwiIA7FKrgS/Ytacnt1rsdmjxxW5sRnLCAiG5Ajk=;
        b=j3iySEAVHab/3RzPqq7fNtuoWcnWC0k4JLxdaMnCrBAhMv0H0z/m3UHSO6BmdLQ0/M
         J6Ot5GTz/dvwefGSRfyLDEhj7F+QcE1/ZhuSt25kIrvMj895X4TDvnlTS99XvqVLdJIk
         Lu/n/YGfltcwKYe/vuIWZdQygrIgmVpvy4xMh2MCKV+T2C+iUbXgYs1Z/tFTF9bEkpfB
         jkp/OFw/doWsiL20/j+8xabaqXmJqIorvBlWxKqwt2thpPBFYgbdh+0IOWXAMjgU618F
         60cvYmw+UTvOA+54UjNrl+MdbUl9wWpocjNIzdIDklyW3ti4Wcayzy3z1Ix4ULHaa9s4
         7Tzg==
X-Forwarded-Encrypted: i=1; AJvYcCVseac3wvMaDL585CImp4aY3G/SdwtLMFMS98jSMmkLVhTFLLviPwRqG9Y9zBnqnAEu+OydPQxY6mThwwr9eMl5epJkNSVjMenZt53idns=
X-Gm-Message-State: AOJu0YyGJaXnzyQXss/wVlBbzZcLybbZNo6YnE+yAhBgAhyRcmqvVkOW
	o/OkH2zKamXJZRZQgJ2Ja0iPujXeGO7J903T1cQuRvuZXCaQ0GwOF5gXKj7w48w=
X-Google-Smtp-Source: AGHT+IGizIdXTx/CsZk8PbZxvqVwV8yCfAEfxtPRXxseAeb1ekCj2GMLjSLWgN3RIojVrXMq1Sz58A==
X-Received: by 2002:a17:906:c0d1:b0:a52:6535:d15f with SMTP id bn17-20020a170906c0d100b00a526535d15fmr887865ejb.61.1713420976631;
        Wed, 17 Apr 2024 23:16:16 -0700 (PDT)
Received: from localhost (78-80-105-131.customers.tmcz.cz. [78.80.105.131])
        by smtp.gmail.com with ESMTPSA id t7-20020a1709066bc700b00a5556cd0fd5sm436991ejs.183.2024.04.17.23.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 23:16:16 -0700 (PDT)
Date: Thu, 18 Apr 2024 08:16:14 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Benjamin Poirier <benjamin.poirier@gmail.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
	davem@davemloft.net, edumazet@google.com, parav@nvidia.com,
	mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	shuah@kernel.org, petrm@nvidia.com, liuhangbin@gmail.com,
	vladimir.oltean@nxp.com, idosch@nvidia.com,
	virtualization@lists.linux.dev
Subject: Re: [patch net-next v3 2/6] selftests: forwarding: move couple of
 initial check to the beginning
Message-ID: <ZiC6rpgScGzYyJZb@nanopsycho>
References: <20240417164554.3651321-1-jiri@resnulli.us>
 <20240417164554.3651321-3-jiri@resnulli.us>
 <ZiAb0wZcWDSozCoq@f4>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZiAb0wZcWDSozCoq@f4>

Wed, Apr 17, 2024 at 08:58:27PM CEST, benjamin.poirier@gmail.com wrote:
>On 2024-04-17 18:45 +0200, Jiri Pirko wrote:
>> From: Jiri Pirko <jiri@nvidia.com>
>> 
>> These two check can be done at he very beginning of the script.
>> As the follow up patch needs to add early code that needs to be executed
>> after the checks, move them.
>> 
>> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>> ---
>>  tools/testing/selftests/net/forwarding/lib.sh | 15 ++++++++++-----
>>  1 file changed, 10 insertions(+), 5 deletions(-)
>> 
>> diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
>> index 7913c6ee418d..2e7695b94b6b 100644
>> --- a/tools/testing/selftests/net/forwarding/lib.sh
>> +++ b/tools/testing/selftests/net/forwarding/lib.sh
>> @@ -84,6 +84,16 @@ declare -A NETIFS=(
>>  # e.g. a low-power board.
>>  : "${KSFT_MACHINE_SLOW:=no}"
>>  
>> +if [[ "$(id -u)" -ne 0 ]]; then
>> +	echo "SKIP: need root privileges"
>> +	exit $ksft_skip
>> +fi
>> +
>> +if [[ ! -v NUM_NETIFS ]]; then
>> +	echo "SKIP: importer does not define \"NUM_NETIFS\""
>> +	exit $ksft_skip
>> +fi
>> +
>
>I noticed that this part conflicts with the recently merged commit
>2291752fae3d ("selftests: forwarding: lib.sh: Validate NETIFS"). Can you
>please verify that the conflict was fixed correctly? The above check is
>now duplicated in the file.

Right, will remove the duplicate. Thanks!
