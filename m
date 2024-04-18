Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A9015FA61
	for <virtualization@lists.linux.dev>; Thu, 18 Apr 2024 12:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713441622; cv=none; b=Hbh+RYCilC7FKte6siRcdu/sx0jrk45w1eN0X921VO/cMvzKt8Y5Nb5RP5Vu4wuzdlU+llhNsa+/JUTYlOJmssXqd35FoVPhy6VLWtFqKx+CEG3O4nKAw+n5oKl5n/cyC9OoXNZQ+KT4qfKkYT+EERV4h2bjXByse6rLemQ7RsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713441622; c=relaxed/simple;
	bh=a7rhft9+f6E6CZaHtNcPSvmrUhAZnSV0d1mIll7g2Y4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kssg80XoW6uI2ZYACchtHHNKHFMpsrX3E6dNo5RN4KPi1MSh4bdvLCsuyODf5iCexXwrm2nrKVVFOfbm0sGDo8yGRf8AxkWbcw983ub4NCfJV/r1UR+PKQBjk5sLfjwN9lQty6engU5MWJUQwcJOffEI1HPF00SPukGUPhHEmL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=JS94/vU6; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="JS94/vU6"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-571c25a329eso289166a12.0
        for <virtualization@lists.linux.dev>; Thu, 18 Apr 2024 05:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713441612; x=1714046412; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lwUqdIuY+eDu/EcFyYGUaTkLl+Kne1AA8UMhkE5/9Sw=;
        b=JS94/vU63hLBePiRuGV6dDRVOSTgKsZtT+TvU81o4mJNsLPCXnCrzBZRemV+yi4s2b
         CPLXRTaKxg2bEeJsNg5sTm7t+NzC+VgLWVWeDfwfn3UgnoPW7u6+pN+TYGvqEBNlj0PM
         EST237ZS0dZC7K9i0V952KXuoLGaZJvoG+F4MKlDIfGVLiaMnQ0MQp/VD0pyBA5KIwQ+
         +nWVtx1ppo20BLonBNL+er7fhajlmAA6njpWYEH7BmLA+mwXFQpgi4V8qlqQ8HYb+7Q4
         SBT/s9Zgne8x877eRily1Dfke4NjllAiqOoXu1clIVdeAyDD0EFseZfPGBFJx+0B+jJz
         j9ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713441612; x=1714046412;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lwUqdIuY+eDu/EcFyYGUaTkLl+Kne1AA8UMhkE5/9Sw=;
        b=UMcV23jHR3EPYsiMWAF6UfQEX7y5tDQwMQsyfo1bFWIPNS6R+UBdUNaA7H4e8nEICe
         Rg+XqsSRQJsJx1uklz+oPAOO/KCOvfAaXAE1zSQG+iIClXnkrwssSJyttTBdDQQCFl63
         Eve+J+UUl47+dcRQkQNumJwoPtJJFAW3nz8XHw//O+8kAHkoWFNbX9Of4/e0ZCAqJ908
         eWsLtA2ZIuINAyMAFPCSHG/cHZ5ZLrsss2z8kmluVCPvNUjucrqoQNi+OqoxwmK6jV+f
         RRQDi+LdmzQHir0RhdIpDfzB5SIsO+yfrbNWT4ARrso57NYSo3HU6/YzMUCqbWJIISiv
         u2dw==
X-Forwarded-Encrypted: i=1; AJvYcCWtK7TFmqNUqQE9q+Z4YksQzTnaq00RFo9CBGPDyYK4VySNljcx+ZP3Ty7Syguz2L075RCMnsE9CPqjuYw2jsRfRh9K+KOmTg6KlMRyKb0=
X-Gm-Message-State: AOJu0YyrInt1e4J2htvTurmV56KtqWYuZ1q+xBawkqBEWRhpzu4p1eLx
	/DHAvapIIq82eaE0+VhScCk5IM/UhuXBLfjxStco8eu5wTy+uhrPSfXomEb6JYY=
X-Google-Smtp-Source: AGHT+IGthP8iEGCeNaOf9TDh2tPZaTJPryMHFc//F72pGlW0keYCltfl498SG97CDYoIpJt8o9hsjQ==
X-Received: by 2002:a50:fa85:0:b0:571:b9c7:2541 with SMTP id w5-20020a50fa85000000b00571b9c72541mr1532066edr.11.1713441611778;
        Thu, 18 Apr 2024 05:00:11 -0700 (PDT)
Received: from localhost (78-80-105-131.customers.tmcz.cz. [78.80.105.131])
        by smtp.gmail.com with ESMTPSA id q29-20020a50cc9d000000b0056ff4faa0b9sm821264edi.6.2024.04.18.05.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 05:00:11 -0700 (PDT)
Date: Thu, 18 Apr 2024 14:00:09 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Petr Machata <petrm@nvidia.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
	davem@davemloft.net, edumazet@google.com, parav@nvidia.com,
	mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	shuah@kernel.org, liuhangbin@gmail.com, vladimir.oltean@nxp.com,
	bpoirier@nvidia.com, idosch@nvidia.com,
	virtualization@lists.linux.dev
Subject: Re: [patch net-next v3 6/6] selftests: virtio_net: add initial tests
Message-ID: <ZiELSaMVEuYJmeaB@nanopsycho>
References: <20240417164554.3651321-1-jiri@resnulli.us>
 <20240417164554.3651321-7-jiri@resnulli.us>
 <87ttjzawhd.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ttjzawhd.fsf@nvidia.com>

Thu, Apr 18, 2024 at 10:39:49AM CEST, petrm@nvidia.com wrote:
>
>Jiri Pirko <jiri@resnulli.us> writes:
>
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
>
>> +h2_destroy()
>> +{
>> +	simple_if_fini $h2 $H2_IPV4/24 $H2_IPV6/64
>> +}
>> +
>> +initial_ping_test()
>> +{
>> +	cleanup
>
>All these cleanup() calls will end up possibly triggering
>PAUSE_ON_CLEANUP. Not sure that's intended.

Okay, will change that.

Thanks!

>
>> +	setup_prepare
>> +	ping_test $h1 $H2_IPV4 " simple"
>> +}
>
>Other than this nit, LGTM.
>
>Reviewed-by: Petr Machata <petrm@nvidia.com>
