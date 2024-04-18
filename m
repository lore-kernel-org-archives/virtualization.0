Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C7315F3EE
	for <virtualization@lists.linux.dev>; Thu, 18 Apr 2024 12:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713441692; cv=none; b=JyKvc1jb/hwK2n5VSHA60zsuROTPb98CkndPDiPQ4gpjUroVQPR0JGfFTTbfJV/l01dMN89TL3NHIWyI6PbOuGrHEcuj2gtVSyu/WVKdyItndzDOGwiB7zZKdrIkW17cy0JLOxAz2+Q82uEoYg0rhP1vwLqU8nXbfoq/HQkCxxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713441692; c=relaxed/simple;
	bh=fVrTKiOn5uwYp9pqQv/ZPb+GJYoq6Poa9VPpujFIX94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RuUTJS9Fm3Xu1asW3F95kNcNsBC3RCKO/+iQ0jc1dR32mgpFiyse7lviKh6VeIIz4dXFMh+AF2n94RFkf53ZGnHb3w2lZXBqF5GoevOL7YH8jXyu8PTC9ObUdbDzOVBxdPZVlWCBe+kZMV8DwTCm6jpKk1diFai3wAKoGFQWG9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=1CmT4UFL; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="1CmT4UFL"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-571c207d9a6so390747a12.2
        for <virtualization@lists.linux.dev>; Thu, 18 Apr 2024 05:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713441686; x=1714046486; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PMpzycIzCpjrOrH4WFcDDQP42P8HzuPiF7zvkcJLpsw=;
        b=1CmT4UFLUlCNXOxWKc7wHk19NJus7jPkQzyVRUGQ4fh3mLWm9WRQ71zRtNw33xhfst
         q9S3R/UwcLSF0aYoYFcco9hYxhRlGhNCXrTn1H1FyYjJdScpBsyAKYS7mcdAESsJCMoo
         4+RUtxQhZhNysQw46GHdz2OxHWWoKloAn73OQqVw15f+g0wJRE5lvjGALKeinTc2mrQI
         WWybE3XRPhoZkGfXQle7Ch4IxIM0zBEB4xEnW/wJfOWGJ9k+wQFmN6vqLfJaB1rYTumg
         I0WDHsZww8rqv/2hpRbW4OgXv4QfL31+6FtN9VNi1Curiwg+PsUl6FUF8FaQHDdLKvRV
         ULpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713441686; x=1714046486;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PMpzycIzCpjrOrH4WFcDDQP42P8HzuPiF7zvkcJLpsw=;
        b=wcG/Qj8kjQDX+WBhPXmgm0dMUBv0873CYQEe3JBzpIExeWZGNp9Zn1jJzK1k8MnXD+
         wlzQkXmK91wedUH1+MTJ6xtrud3t1kOa6JnYOO9EvdpYFLg7SzweEzU0oY66JLRW3354
         Sb8XH5av8+UfUrKNqq4lufC0GUiEbebhw+ofpZa3zxTNp3HGqpmrS9FXK/0z8gxRHfnc
         MOjEW7QY2Le73MJy/5pYedy1ndjEjvwhk4xsuerwc/Qf9X/l6hUMfsum2a/i80DFi/6O
         FE2DJ6gGLfVfAY71NLb1AwFGpfrHFD7gsyKYJGZoVrPeYRiO9esDyTwzBIM+kdLtVHoX
         8DoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCFKSsbuuq4Kn//M18in78K17we5HRV6O/bPF6lmWBLzAyPm1L2KnLqUZw0Km2ATkQG474CsyKVFlzUQvnmYo1rdeKUbB5DwLmZnoZer4=
X-Gm-Message-State: AOJu0YwzAmtj9JuSdFWJ+cUcJH1jkgN4zRn7Ms3ztg79IHxXWgSafD6L
	zUKUeVodq6aJ6KUSYkMMsJ8V3JgZx3+JgLtpCL0Rh4r6SbSGt3GrqEtj5Jen2sU=
X-Google-Smtp-Source: AGHT+IFbucxxkcsWN42LkuhAJt551MfeNbGoUIU2wWgxXl2gs2XDgp3EXFJ2FGetwBHsg9OG55KB7A==
X-Received: by 2002:a50:f68e:0:b0:570:5b72:164 with SMTP id d14-20020a50f68e000000b005705b720164mr1787321edn.37.1713441685468;
        Thu, 18 Apr 2024 05:01:25 -0700 (PDT)
Received: from localhost (78-80-105-131.customers.tmcz.cz. [78.80.105.131])
        by smtp.gmail.com with ESMTPSA id fj17-20020a0564022b9100b0056fe8f3eec6sm759931edb.62.2024.04.18.05.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 05:01:24 -0700 (PDT)
Date: Thu, 18 Apr 2024 14:01:23 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Petr Machata <petrm@nvidia.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
	davem@davemloft.net, edumazet@google.com, parav@nvidia.com,
	mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	shuah@kernel.org, liuhangbin@gmail.com, vladimir.oltean@nxp.com,
	bpoirier@nvidia.com, idosch@nvidia.com,
	virtualization@lists.linux.dev
Subject: Re: [patch net-next v3 5/6] selftests: forwarding: add
 wait_for_dev() helper
Message-ID: <ZiELkw051EsXrraM@nanopsycho>
References: <20240417164554.3651321-1-jiri@resnulli.us>
 <20240417164554.3651321-6-jiri@resnulli.us>
 <8734rjcbkq.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8734rjcbkq.fsf@nvidia.com>

Thu, Apr 18, 2024 at 10:33:13AM CEST, petrm@nvidia.com wrote:
>
>Jiri Pirko <jiri@resnulli.us> writes:
>
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
>> index edaec12c0575..41c0b0ed430b 100644
>> --- a/tools/testing/selftests/net/forwarding/lib.sh
>> +++ b/tools/testing/selftests/net/forwarding/lib.sh
>> @@ -745,6 +745,19 @@ setup_wait()
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
>I agree with Benjamin's feedback that this should lose the up flag. It
>looks as if it's waiting for the device to be up.

Ok.

>
>> +        if (( $? )); then
>> +                check_err 1
>> +                log_test wait_for_dev "Interface $dev did not appear."
>> +                exit $EXIT_STATUS
>> +        fi
>> +}
>> +
>>  cmd_jq()
>>  {
>>  	local cmd=$1
>
