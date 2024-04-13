Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8C23F8F1
	for <virtualization@lists.linux.dev>; Sat, 13 Apr 2024 13:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713014955; cv=none; b=MHCVqtXL0lfzqNIv6XtGOPxo0Q1OefQxpmwbAaFhNTkBG79377n2kVerTDjtbyPeDKwaR1jp+P9tcdHptE3fJlJZHpYfbFmIJXiOjQGBsZWIFysXPojTPqmuK1EJh+HC5VqnFqxP9FsanS/uN+oV4AcNDoP4KZ4A6J1vYmQaSS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713014955; c=relaxed/simple;
	bh=MROLZPJUrsuLDWksM0DueQaZL91l9XmteS/PnFCdJ1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fTsYzAOwu9cbkOwNVo4vc6GYbZEtYn2YXJhDjU59PE6EbWHby2DEYAdv39SFSkkEVMx5O60e37dJPNXrnI9yfHn+nU6INfWaHM5KizTwauZRPnfA2TnRaE4Wf5ltTZAxAOFCQn1qMuSOlNDRo+PxtMp2r2V/QaIH8ykSFq1JQwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=FvNqsCTU; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="FvNqsCTU"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-516db2214e6so2149447e87.1
        for <virtualization@lists.linux.dev>; Sat, 13 Apr 2024 06:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713014951; x=1713619751; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/sWcSLhrZ2N7z+BD4safYiDtjAH5nTepb/6QB7CjCtY=;
        b=FvNqsCTUbYZemnLZQzpVZZKGTE3DRgZC8EdfvUd/PDyP+zHhS0ZzC1QZnLZXlwUzbF
         qfCYpzZz2X1ZclWi88DABt7B1Qc1gknYgfGKD0DXHjv1jUvYW+S97abaQwuBVjLRhYGk
         7+rtU7ZDi1DisOr1YJQyRo3I/YI+b0tBSzzRY4xfsctJDrYoBT14lIYvjgqpki3BQZtB
         hBQBtRYPvjxmrUUpqnmXbrecvg//hUElsKeM5FwijHX+eWlky8BgyFM+PfPBvVE79A8n
         FeLOG/XypT2Ci/gQkJXurfTScPJ2qqu8ub1OGIMzLhYgPfJWBl1i6BrRdVLCR6+2N94D
         cLrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713014951; x=1713619751;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/sWcSLhrZ2N7z+BD4safYiDtjAH5nTepb/6QB7CjCtY=;
        b=NDzBpf6b76GKDYQV8idd6n5ziqAzWcUEERHAie2WvX4A+AyHT1pIR2nTWhB5BkjFcb
         kMyrFLN6CP1WEEGvqLrEIiG9TDYJQFGZMyfwkRs/qy/O+n+NOi1KTzKK75dX0JaX0CvQ
         heOvkgfZRutV7EzHgHLaAulfWpr1uoLMj1sAAjm8Stke+5vgNkM5WvGfiYGSdC4pZrum
         wDdNY9OIWFZownQQ4wzqB5KxMzwTgsqmXvj5OpqZ+Fpah7My1XyXFqWePCUrl8ieo0WO
         RhQX9KvYSGI3ayz0Y9fujn8ws2P66TlDd65esCmD3wSm93syJKQs9zeGMkvA9dP5FkUV
         NwZA==
X-Forwarded-Encrypted: i=1; AJvYcCUYUfh3Ccsfj71xoSnHTLGbVhGs5vLhHOVl1/Dw8YygPZs9/5+mDyRanc4xSzBefnCVjCQQEAwt8UV1s5dBPUBTfSaKRouX12NehHakjVg=
X-Gm-Message-State: AOJu0YzaJyO3dKxdiLz79FZ3AThS0WVRJaJocUzA6rbarDH1zYrnufO6
	ACFRbWjcnaMjB0mGXbaRwm1KqGxDVgCU3uH88CKsPkWAmU9ndcuxqXG7QfF0kiE=
X-Google-Smtp-Source: AGHT+IGsnPRAi7TPtmzYtQAk/aBXjwsk4UzObITwkTK+3+FJ6lQdGsbZc1s1R0QpGxH7YsJDy0+ZJw==
X-Received: by 2002:ac2:5bc4:0:b0:517:88cb:ec02 with SMTP id u4-20020ac25bc4000000b0051788cbec02mr3234945lfn.42.1713014950602;
        Sat, 13 Apr 2024 06:29:10 -0700 (PDT)
Received: from localhost (37-48-0-252.nat.epc.tmcz.cz. [37.48.0.252])
        by smtp.gmail.com with ESMTPSA id h6-20020a0564020e0600b0056fed5286b5sm2317685edh.55.2024.04.13.06.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Apr 2024 06:29:10 -0700 (PDT)
Date: Sat, 13 Apr 2024 15:29:08 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Benjamin Poirier <benjamin.poirier@gmail.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
	davem@davemloft.net, edumazet@google.com, parav@nvidia.com,
	mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	shuah@kernel.org, petrm@nvidia.com, liuhangbin@gmail.com,
	vladimir.oltean@nxp.com, idosch@nvidia.com,
	virtualization@lists.linux.dev
Subject: Re: [patch net-next 5/6] selftests: forwarding: add wait_for_dev()
 helper
Message-ID: <ZhqIpIF5N1ESWgON@nanopsycho>
References: <20240412151314.3365034-1-jiri@resnulli.us>
 <20240412151314.3365034-6-jiri@resnulli.us>
 <Zhmc_KsL__7noHWZ@f4>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zhmc_KsL__7noHWZ@f4>

Fri, Apr 12, 2024 at 10:43:40PM CEST, benjamin.poirier@gmail.com wrote:
>On 2024-04-12 17:13 +0200, Jiri Pirko wrote:
>> From: Jiri Pirko <jiri@nvidia.com>
>> 
>> The existing setup_wait*() helper family check the status of the
>> interface to be up. Introduce wait_for_dev() to wait for the netdevice
>> to appear, for example after test script does manual device bind.
>> 
>> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>> ---
>>  tools/testing/selftests/net/forwarding/lib.sh | 19 +++++++++++++++++++
>>  1 file changed, 19 insertions(+)
>> 
>> diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
>> index 959183b516ce..74859f969997 100644
>> --- a/tools/testing/selftests/net/forwarding/lib.sh
>> +++ b/tools/testing/selftests/net/forwarding/lib.sh
>> @@ -746,6 +746,25 @@ setup_wait()
>>  	sleep $WAIT_TIME
>>  }
>>  
>> +wait_for_dev()
>> +{
>> +	local dev=$1; shift
>> +	local timeout=${1:-$WAIT_TIMEOUT}; shift
>> +	local max_iterations=$(($timeout * 10))
>> +
>> +	for ((i = 1; i <= $max_iterations; ++i)); do
>> +		ip link show dev $dev up &> /dev/null
>> +		if [[ $? -ne 0 ]]; then
>> +			sleep 0.1
>> +		else
>> +			return 0
>> +		fi
>> +	done
>> +
>> +	log_test wait_for_dev ": Interface $dev did not appear."
>> +	exit 1
>> +}
>
>How about rewriting the function to make use of the `slowwait` helper as
>follows:
>
>wait_for_dev()
>{
>	local dev=$1; shift
>	local timeout=${1:-$WAIT_TIMEOUT}; shift
>
>	slowwait $timeout ip link show dev $dev up &> /dev/null
>	if (( $? )); then
>		check_err 1
>		log_test wait_for_dev "Interface $dev did not appear."
>		exit $EXIT_STATUS
>	fi
>}

Sure, will redo this. Thanks!

