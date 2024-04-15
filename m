Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF22339FE0
	for <virtualization@lists.linux.dev>; Mon, 15 Apr 2024 08:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713170449; cv=none; b=BTfqpsAMkIF7vj5ODR0ObAJn5A/p5eixbGMQaeWp1S7YAb7Q4rqSCJHq/05z4rrrMApfjiuZxXHRk9rGut7qL3zNqmGC3wPJGDPP4wSRUJVv7XeSLVLd28Pv9riYuKuZqbhDmZO9PPG1SLQqv9vv4KljaDxMR5jyub1AY6gnP+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713170449; c=relaxed/simple;
	bh=7Qg+Cc85pc+w+f2K+Ou2xfL1RJ9qFFxcGgIDOESjcoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BjvYvQwG2b80qvPQZgKEZbFswsG/YHEyIXEwxpWmfooZLj+rwA/l8BlaRIepSK9x5SB1O4YiZmXpQKI96AnvsN8uJgxd7D0IfZh0gIoTHR27JJWHrIi05It3Yz0kZw6k8PO/0jBbLVVG5RcJ1RVA5TNBz6DJWN9+j5Sc+dF4O9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=pX0zDg9p; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="pX0zDg9p"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2da01cb187cso52566501fa.0
        for <virtualization@lists.linux.dev>; Mon, 15 Apr 2024 01:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713170444; x=1713775244; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=giKkTelfq3BYsAFGZhixira6GIq9vSuoB3MA1iZ83Kk=;
        b=pX0zDg9pMwyB32LMnuyIcuz6ZJ86n4osbFtuDi/S1o8WZnuwDaUp3PTWHokXadadBK
         13QYLnQE5XF3ALPLHQ+Wp6u1c+TW1kabMJLEJHlPsLZQZMj7tUPQykJ7XAibK/Cb7w8K
         y1cy7rsUsGqWIbEZWkAZ+GeRosneHQLcHtHrzRtfC7gILzSKBPzufORcDRuz6IjE7niI
         i9y+DUNr3jC25BPSQRuMBZiI3JKfqv8ji0TS4wf66PAgL+sKzbF8VgLuV49+74x2RBnf
         3RgyylU0j5kIhB8U3IRUH17IBlLFK7KZ7k3GWSvGmFGwkn2YGLyEjtKlt+iv2pp62b65
         cpvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713170444; x=1713775244;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=giKkTelfq3BYsAFGZhixira6GIq9vSuoB3MA1iZ83Kk=;
        b=bLix2bovxHjEGN8GFf2MsPVpE4qm5dAWe+gUCxKuSt6luccIYeI8VmsSluDfXhF5Nl
         dGUZUlhiuMbJmvCxCmaWSiIOqGjU7lKFhGeMKVAVANlu2XkdGgbQl1K5DksYoAiS29G7
         os6M7KwEe20XzaqVtnnz8rROq/DABFL2x2ZV58O37VtOic9ldlWpzaEx1nECcwuiksFE
         fh2rxCH2QztGAPLCVhkOFJHHyjVUkCYP7D1UriXZEIcYQ32GKlzrlBPmJGfogEM6PVwc
         0m0eA/4A+WIXbtunmzJVjWQMutCZGAHHXk5zAzcr8T8UTNkhea+N12XoS8FGjdraievQ
         sqKw==
X-Forwarded-Encrypted: i=1; AJvYcCUO1QI0gdDxhAHlfo1Vh2u216JV1lD8iALXwEvCObEs6SesjcEjoSsd9OSv7zuxhZh/K9kqMjpT1awTms+Rt0nu+zJYCTdQMw55IoxAYD4=
X-Gm-Message-State: AOJu0YwIFdJ2Us/aEAf5pNAiAn8ksgWipGsXN9BMkNo22nOeu98H6pK2
	PV5rZmFepM8gSWG+xOTFyzAb+pnl5FK+QVKHpM/nGNwiBc9+dy52v+xQ8Qx/usM=
X-Google-Smtp-Source: AGHT+IEouBsRvNsGw2BBII7zCSX4R6hyekzhRCRfz+XWQvsollf7R1Urp0JmU2pLaPzlOmGbrP8bKg==
X-Received: by 2002:a05:6512:4014:b0:518:7df6:d9e1 with SMTP id br20-20020a056512401400b005187df6d9e1mr8528376lfb.10.1713170443564;
        Mon, 15 Apr 2024 01:40:43 -0700 (PDT)
Received: from localhost (37-48-2-146.nat.epc.tmcz.cz. [37.48.2.146])
        by smtp.gmail.com with ESMTPSA id jw24-20020a170906e95800b00a51adace6ebsm5216634ejb.79.2024.04.15.01.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 01:40:43 -0700 (PDT)
Date: Mon, 15 Apr 2024 10:40:39 +0200
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
Message-ID: <ZhzoB3x3cEAEyIXD@nanopsycho>
References: <20240412151314.3365034-1-jiri@resnulli.us>
 <20240412151314.3365034-4-jiri@resnulli.us>
 <ZhmbxntSvXrsnEG1@f4>
 <ZhqIXZYnHA0MZT3L@nanopsycho>
 <ZhwvXgxEnHN8oJ5f@f4>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZhwvXgxEnHN8oJ5f@f4>

Sun, Apr 14, 2024 at 09:32:46PM CEST, benjamin.poirier@gmail.com wrote:
>On 2024-04-13 15:27 +0200, Jiri Pirko wrote:
>> Fri, Apr 12, 2024 at 10:38:30PM CEST, benjamin.poirier@gmail.com wrote:
>> >On 2024-04-12 17:13 +0200, Jiri Pirko wrote:
>> >> From: Jiri Pirko <jiri@nvidia.com>
>> >> 
>> >> Allow driver tests to work without specifying the netdevice names.
>> >> Introduce a possibility to search for available netdevices according to
>> >> set driver name. Allow test to specify the name by setting
>> >> NETIF_FIND_DRIVER variable.
>> >> 
>> >> Note that user overrides this either by passing netdevice names on the
>> >> command line or by declaring NETIFS array in custom forwarding.config
>> >> configuration file.
>> >> 
>> >> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>> >> ---
>> >>  tools/testing/selftests/net/forwarding/lib.sh | 39 +++++++++++++++++++
>> >>  1 file changed, 39 insertions(+)
>> >> 
>> >> diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
>> >> index 6f6a0f13465f..06633518b3aa 100644
>> >> --- a/tools/testing/selftests/net/forwarding/lib.sh
>> >> +++ b/tools/testing/selftests/net/forwarding/lib.sh
>> >> @@ -55,6 +55,9 @@ declare -A NETIFS=(
>> >>  : "${NETIF_CREATE:=yes}"
>> >>  : "${NETIF_TYPE:=veth}"
>> >>  
>> >> +# Whether to find netdevice according to the specified driver.
>> >> +: "${NETIF_FIND_DRIVER:=}"
>> >> +
>> >
>> >This section of the file sets default values for variables that can be
>> >set by users in forwarding.config. NETIF_FIND_DRIVER is more like
>> >NUM_NETIFS, it is set by tests, so I don't think it should be listed
>> >there.
>> 
>> Well, currently there is a mixture of config variables and test
>> definitions/requirements. For example REQUIRE_JQ, REQUIRE_MZ, REQUIRE_MTOOLS
>> are not forwarding.config configurable (they are, they should not be ;))
>
>Yes, that's true. If you prefer to leave that statement there, go ahead.
>
>> Where do you suggest to move NETIF_FIND_DRIVER?
>
>I would make NETIF_FIND_DRIVER like NUM_NETIFS, ie. there's no statement
>setting a default value for it. And I would move the comment describing
>its purpose above this new part:

Ok.

>
>> +
>> +if [[ ! -z $NETIF_FIND_DRIVER ]]; then
>> +	unset NETIFS
>> +	declare -A NETIFS
>> +	find_netif
>> +fi
>> +
>
>BTW, '! -z' can be removed from that test. It's equivalent to:
>if [[ $NETIF_FIND_DRIVER ]]; then

Ok.

