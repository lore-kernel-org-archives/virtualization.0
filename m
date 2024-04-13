Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5A03D579
	for <virtualization@lists.linux.dev>; Sat, 13 Apr 2024 13:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713014995; cv=none; b=lQpIYqZ+U6Hr0J1IOerAK+ay669sbiXmpeWrEJmJeXujABjj9lU7Q0qTOkBBoU0EVYeeKm8PZ5FSTKYHPUDdiKhm72zrI5EHzZa1WFTqDjx3lXoE8Z5Ps3rvpwiJ8k7XEVgcNK2km+953ALaRYvku6UnRAdPG+y/vuNxnCe9l6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713014995; c=relaxed/simple;
	bh=Fb2/EjgZ2BeForpcKridmm4Z4TIHSrSo2dU0u2mMtF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GqYDXiUUdl1vv0wpR2OGqi0C49eOgSovMpKeOY3lgQ4PhrEmLbnASrLPRqPDs/fgqTDsZkCyoZ6SUbbYGkKQ7zb0X4zNdJG1L/386wqCo3I17RbwabEV6VMOIPKzN1uUzQG0UgkyjpLWDHG6fRpAgSNdEx/7VISb4I4Gye4fPtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=MR9R8OJ8; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="MR9R8OJ8"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-56e1f3462caso2050445a12.3
        for <virtualization@lists.linux.dev>; Sat, 13 Apr 2024 06:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713014993; x=1713619793; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hruTETA4PxCbHzLcp0spOlwZR1dHn4JdxXhkp8dJj3Q=;
        b=MR9R8OJ84R3kwBqC+1qRbYhDev5KUvdu8NVuNMJjP6/uFJ37OEW0RxTqQBPV2w5Xvr
         zibvw27CtCmp3IFQQwcSE2mFnPs0nUl8PvPQsdoTDb09IpXF9RES0iMd1BnN7gHcnBrf
         whxDT7Gepu0J/B1lf2M7GIzcLYRkhUXxvZnM9bnVP824Uz5bF1UzW193X3DBMEAtF3C8
         czpnxTvEInBwBaC+MHVQHLOMRAR1CU49dYeDtugyKmkJemzrbpZgT+ZKTIitk/B/+YsU
         siChw8KjUQEgfLMfwCanCHSQ8+9jTzq+kPFc2HR5QchwvgtKDwC6xrm6TfUCXDUMBTx6
         P6Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713014993; x=1713619793;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hruTETA4PxCbHzLcp0spOlwZR1dHn4JdxXhkp8dJj3Q=;
        b=AIi/NHxzG34oDOoUH/qmK6DuFknKUz48EJ+A2bCwQniceCLk0m144V6+gQRSnZ/5Ng
         48IMSNXqBRi1Fjsudrem1/5fhqILR1ngUPpauuQZL1gAYLtsnq04xEVLldTcS2GR8U1D
         iBz/s8wSGBLTkxRbGeY/DDZQ2VFolqfTVH97/4wDN3JTsIWSwfGGCIyJ6maJ9RZaOAH6
         tzP7MVUre9G0QT+2fnoXJQbmkUgIB46Wi27hU8nYvEYq/UUMKSUM9ctF/ePuffOFDSPy
         g5x0e7+XtalFrTwdQR+1DbIy41C42h+AqzqHBytwUUvrJ8JAnQtp7W21UeZwR9PtW24K
         ZKyA==
X-Forwarded-Encrypted: i=1; AJvYcCVEOFRp8plCd2WXf2y36miP77EELj3YTRtYOx6q8yFlgt7doqBTQ/i0vXuVqB8sdW9yyLvvhL8Qgb56IX6Rul7MHffuODEHXcmvONRFRGU=
X-Gm-Message-State: AOJu0Yx4Y7FRyyfNHPwS4aE4HE278RIjkMMl9Wc+ejJ+9319Vgqobi6e
	z/tEFJMdgDHmRPQ9sVpuGpBQ+utSUYvAWamIs1eQwKGPgFVALzS0GyZAkWJ981Y=
X-Google-Smtp-Source: AGHT+IFTj5mSgb2nSAJT/asQHCK/cz3QOVk3fD7qcAI2noH4Ve85gCoJ6VoayEz0/qvCpPfvyV+GQA==
X-Received: by 2002:a50:8717:0:b0:56e:3078:74 with SMTP id i23-20020a508717000000b0056e30780074mr4979093edb.31.1713014992626;
        Sat, 13 Apr 2024 06:29:52 -0700 (PDT)
Received: from localhost (37-48-0-252.nat.epc.tmcz.cz. [37.48.0.252])
        by smtp.gmail.com with ESMTPSA id g37-20020a056402322500b005700e153647sm740219eda.38.2024.04.13.06.29.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Apr 2024 06:29:52 -0700 (PDT)
Date: Sat, 13 Apr 2024 15:29:50 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Benjamin Poirier <benjamin.poirier@gmail.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
	davem@davemloft.net, edumazet@google.com, parav@nvidia.com,
	mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	shuah@kernel.org, petrm@nvidia.com, liuhangbin@gmail.com,
	vladimir.oltean@nxp.com, idosch@nvidia.com,
	virtualization@lists.linux.dev
Subject: Re: [patch net-next 6/6] selftests: virtio_net: add initial tests
Message-ID: <ZhqIznimYxnC5YVS@nanopsycho>
References: <20240412151314.3365034-1-jiri@resnulli.us>
 <20240412151314.3365034-7-jiri@resnulli.us>
 <ZhmdwiGi-r6eDyB-@f4>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZhmdwiGi-r6eDyB-@f4>

Fri, Apr 12, 2024 at 10:46:58PM CEST, benjamin.poirier@gmail.com wrote:
>On 2024-04-12 17:13 +0200, Jiri Pirko wrote:
>> From: Jiri Pirko <jiri@nvidia.com>
>> 
>> Introduce initial tests for virtio_net driver. Focus on feature testing
>> leveraging previously introduced debugfs feature filtering
>> infrastructure. Add very basic ping and F_MAC feature tests.
>> 
>> To run this, do:
>> $ make -C tools/testing/selftests/ TARGETS=drivers/net/virtio_net/ run_tests
>> 
>> Run it on a system with 2 virtio_net devices connected back-to-back
>> on the hypervisor.
>> 
>> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>> ---
>>  tools/testing/selftests/Makefile              |   1 +
>>  .../selftests/drivers/net/virtio_net/Makefile |   5 +
>>  .../drivers/net/virtio_net/basic_features.sh  | 127 ++++++++++++++++++
>>  .../net/virtio_net/virtio_net_common.sh       |  99 ++++++++++++++
>>  4 files changed, 232 insertions(+)
>>  create mode 100644 tools/testing/selftests/drivers/net/virtio_net/Makefile
>>  create mode 100755 tools/testing/selftests/drivers/net/virtio_net/basic_features.sh
>>  create mode 100644 tools/testing/selftests/drivers/net/virtio_net/virtio_net_common.sh
>> 
>> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
>> index 6dab886d6f7a..a8e40599c65f 100644
>> --- a/tools/testing/selftests/Makefile
>> +++ b/tools/testing/selftests/Makefile
>> @@ -20,6 +20,7 @@ TARGETS += drivers/s390x/uvdevice
>>  TARGETS += drivers/net
>>  TARGETS += drivers/net/bonding
>>  TARGETS += drivers/net/team
>> +TARGETS += drivers/net/virtio
>>  TARGETS += dt
>>  TARGETS += efivarfs
>>  TARGETS += exec
>> diff --git a/tools/testing/selftests/drivers/net/virtio_net/Makefile b/tools/testing/selftests/drivers/net/virtio_net/Makefile
>> new file mode 100644
>> index 000000000000..c6edf5ddb0e4
>> --- /dev/null
>> +++ b/tools/testing/selftests/drivers/net/virtio_net/Makefile
>> @@ -0,0 +1,5 @@
>> +# SPDX-License-Identifier: GPL-2.0+ OR MIT
>> +
>> +TEST_PROGS = basic_features.sh
>> +
>> +include ../../../lib.mk
>
>Makefile is missing something like
>
>TEST_FILES = \
>	virtio_net_common.sh \
>	#
>
>TEST_INCLUDES = \
>	../../../net/forwarding/lib.sh \
>	../../../net/lib.sh \
>	#
>
>Without those, these files are missing when exporting the tests, such as
>with:
>
>cd tools/testing/selftests/
>make install TARGETS=drivers/net/virtio_net/
>./kselftest_install/run_kselftest.sh

Ah, will try and fix. Thanks!

