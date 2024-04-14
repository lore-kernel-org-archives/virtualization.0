Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ABC7136671
	for <virtualization@lists.linux.dev>; Sun, 14 Apr 2024 19:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713123172; cv=none; b=h1t0nNRPczp6RCvsI5+/jxXniCl8IBYKDYgC1f8XTfw+0FEwI5T6SLcb6B51fIg9gcS+TPm6mNii/LecR7lIgkHedLK/zK/zjC727p3eGZ0I7SeZenPFwI+umU29jj0mrRBl0FGxxzDISjTdjO+k74gN6XjN7t1ZGMnSo1Vt2fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713123172; c=relaxed/simple;
	bh=ZBDhr9CObo0gMu6LfQrcFEjO4OPJIORN3szFKgodQ+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NRK9SG4iKgLZrFUq8TGL1PnZThlKo8qYzAP2i6Qc53c/KuZpPSe0OnEgAD22cZF/kw8IJLux5rjQNEzZlsux0MmW3c5eEM6kvDdYfbZLOwd8YRLiHNlvWSlRHLGDOmsrezHwtNTqycksTeiwyrH5psHlsh0eki3DUGIMygC4m98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WIyHahEL; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WIyHahEL"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-78d683c469dso260418485a.1
        for <virtualization@lists.linux.dev>; Sun, 14 Apr 2024 12:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713123169; x=1713727969; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=shhtOSZZ/L6/ysJnfcz7x/2mu05qd++QoRUPCCEdCz0=;
        b=WIyHahELrEl2irrE5SsAvfn54PicR2zsQIrvjnEnNGu7LL8y+Lrf391FUwANvGJKgx
         30VnTdDTcIlzb7gYZXEBJURQi0U/0yjOy4fh54pUvYEP/Ke6bf4bzeQ6n+iY4SScjaC+
         VCakSumH1diuUg6FoSh7v5wyB9UM4MKZioYdtTlPPJNb6n6NVKZyu0hv6XElgs1EAyr5
         MycYDP/GScfTC4hVjOHD6s81OCZLoVq8K6QHuy3nFX/pPamAWlpDpk+H2BEChrLeSXXC
         hxkrv2cc6hn5J9UQov4w+ERj7PO/ILLKrjQybWWgkuRlpuKUvGavQibMKjFdPX1CSMVf
         UvFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713123169; x=1713727969;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=shhtOSZZ/L6/ysJnfcz7x/2mu05qd++QoRUPCCEdCz0=;
        b=G2GfSfEgTiirpRJDnTuUTswVlFLubE4pmHlkmxKmLARbZYO/ixNT9n+KAUReqyAm0q
         wvoT2C0v1Ld2xwuoyADd2zbUHI1DSf+JuEKBFsDTkEWzV7c3um/aK915A9C25Ipwu2An
         nj2JuHFSpWE6Ix3BQ0KnvYvUjzreBrkF7dtUPS6zt2SGYxbkKpM2kbZ7Fmx+X5IqIsH8
         3fDMi9/0FYVvmccLUDJClKYr26UwqNa+BHxHIcR5/+uUqxVQljRr5xyaNQPxr2qQNukr
         1sPP1mjiYLY00Q8e0nAMIXGIAeunHWwZo+sPIjNec9u59gaiaZllKYw0I82vTBNzBJDu
         SU7w==
X-Forwarded-Encrypted: i=1; AJvYcCWDyph9vVuMwR5d63tx7Hdub5OVR5AQWYx06QUJPHcHSeBryFb0SEH0nnc9yH/GCTr0dUiD+da8aeBqKlroEXayMxqKLwLHaFpNzyTR5uc=
X-Gm-Message-State: AOJu0YwaRtscLkZG3lC9WtBwJKLz/0b+739pQdJwbh9BONIj2Hw8jAlu
	e8kARWYopXe9NRyAfPOTAQpNG0xJV8ZHiXU9UUpaiQqAh20uxsI5
X-Google-Smtp-Source: AGHT+IE18qilwhT3qTku0Jo4p/dnCWrWErx3xvR9CEaq3Z9a6mLLdjMTQJeYdFl80JLzSa8uzEK/UQ==
X-Received: by 2002:a05:620a:88f:b0:78e:9136:1063 with SMTP id b15-20020a05620a088f00b0078e91361063mr9033701qka.59.1713123169241;
        Sun, 14 Apr 2024 12:32:49 -0700 (PDT)
Received: from localhost ([2001:18c0:22:6700:503f:95a9:a73f:4ee8])
        by smtp.gmail.com with ESMTPSA id z14-20020a05620a100e00b0078d60595ff8sm5313822qkj.59.2024.04.14.12.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Apr 2024 12:32:48 -0700 (PDT)
Date: Sun, 14 Apr 2024 15:32:46 -0400
From: Benjamin Poirier <benjamin.poirier@gmail.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
	davem@davemloft.net, edumazet@google.com, parav@nvidia.com,
	mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	shuah@kernel.org, petrm@nvidia.com, liuhangbin@gmail.com,
	vladimir.oltean@nxp.com, idosch@nvidia.com,
	virtualization@lists.linux.dev
Subject: Re: [patch net-next 3/6] selftests: forwarding: add ability to
 assemble NETIFS array by driver name
Message-ID: <ZhwvXgxEnHN8oJ5f@f4>
References: <20240412151314.3365034-1-jiri@resnulli.us>
 <20240412151314.3365034-4-jiri@resnulli.us>
 <ZhmbxntSvXrsnEG1@f4>
 <ZhqIXZYnHA0MZT3L@nanopsycho>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZhqIXZYnHA0MZT3L@nanopsycho>

On 2024-04-13 15:27 +0200, Jiri Pirko wrote:
> Fri, Apr 12, 2024 at 10:38:30PM CEST, benjamin.poirier@gmail.com wrote:
> >On 2024-04-12 17:13 +0200, Jiri Pirko wrote:
> >> From: Jiri Pirko <jiri@nvidia.com>
> >> 
> >> Allow driver tests to work without specifying the netdevice names.
> >> Introduce a possibility to search for available netdevices according to
> >> set driver name. Allow test to specify the name by setting
> >> NETIF_FIND_DRIVER variable.
> >> 
> >> Note that user overrides this either by passing netdevice names on the
> >> command line or by declaring NETIFS array in custom forwarding.config
> >> configuration file.
> >> 
> >> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> >> ---
> >>  tools/testing/selftests/net/forwarding/lib.sh | 39 +++++++++++++++++++
> >>  1 file changed, 39 insertions(+)
> >> 
> >> diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
> >> index 6f6a0f13465f..06633518b3aa 100644
> >> --- a/tools/testing/selftests/net/forwarding/lib.sh
> >> +++ b/tools/testing/selftests/net/forwarding/lib.sh
> >> @@ -55,6 +55,9 @@ declare -A NETIFS=(
> >>  : "${NETIF_CREATE:=yes}"
> >>  : "${NETIF_TYPE:=veth}"
> >>  
> >> +# Whether to find netdevice according to the specified driver.
> >> +: "${NETIF_FIND_DRIVER:=}"
> >> +
> >
> >This section of the file sets default values for variables that can be
> >set by users in forwarding.config. NETIF_FIND_DRIVER is more like
> >NUM_NETIFS, it is set by tests, so I don't think it should be listed
> >there.
> 
> Well, currently there is a mixture of config variables and test
> definitions/requirements. For example REQUIRE_JQ, REQUIRE_MZ, REQUIRE_MTOOLS
> are not forwarding.config configurable (they are, they should not be ;))

Yes, that's true. If you prefer to leave that statement there, go ahead.

> Where do you suggest to move NETIF_FIND_DRIVER?

I would make NETIF_FIND_DRIVER like NUM_NETIFS, ie. there's no statement
setting a default value for it. And I would move the comment describing
its purpose above this new part:

> +
> +if [[ ! -z $NETIF_FIND_DRIVER ]]; then
> +	unset NETIFS
> +	declare -A NETIFS
> +	find_netif
> +fi
> +

BTW, '! -z' can be removed from that test. It's equivalent to:
if [[ $NETIF_FIND_DRIVER ]]; then
