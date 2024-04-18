Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E671615E80B
	for <virtualization@lists.linux.dev>; Thu, 18 Apr 2024 12:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713441725; cv=none; b=GmeWR8G/5oTklhMozQLkFuPy0x1WcB+Jm5kX67xmso7qrgW7vXo57qYHGQeXXTYToeRi9vwwNHiLb6HsVnhlQprFIP+pMxmUXmWPMczhrQANwfQOvav2YPyZT4usJI9aoVDpkGJ4Pkg6Ii83xkCfDB8JbVMPkHJWHIJi0JXs0Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713441725; c=relaxed/simple;
	bh=WDTS0GooOj5OV5uzWzScXA+6NBbMaCXQC76UKuCef2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dbS3xufbzg+FmksMshNSfRJZjPRrUE6/3fyZ+gQlEljf8EUoyIlGt4WFMresvL8By/uQli52xglnyZTQNVRKCm9g0gMGPl3En1FdZpgdS60PQ3H6dglRS33PU4QflPYhIuSiIoCYknEnksRvEthB1Pl12tWYRO38XOOdd4Ang6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=f9c63AjN; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="f9c63AjN"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a51beae2f13so82951366b.1
        for <virtualization@lists.linux.dev>; Thu, 18 Apr 2024 05:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713441720; x=1714046520; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WDTS0GooOj5OV5uzWzScXA+6NBbMaCXQC76UKuCef2c=;
        b=f9c63AjNwQVRaU9BsO58CjGKWp7yI+z/mwZBJ9u79ML1mJqH85DqSm/nQsJ9v+B2kn
         vfJ/SjVhqrlsNEJDpWkXNiPkoxf3/OZBEMmhjm9JGJ0sNWg0CLYKXxpfMxzyJjvLXFGi
         Y0vAFBLOAmigQDFNeimgukE1353Ypo7khKHZSGPzdnp7l0F1OiUVgbHCiwtPc7Yw5GqX
         85+lrDMtzpJEoSLvs5IM0Zs5Rhwgwpr8TghydURHWKuePJrxsopfzWNkv6bDjPaePSxT
         L+flQdV7CLAYaYxP/ZVtqn2VPa9ErDC4WCeVvIdByST8hL2OqeCM7iIK5q6ynTxyZGzF
         nQQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713441720; x=1714046520;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WDTS0GooOj5OV5uzWzScXA+6NBbMaCXQC76UKuCef2c=;
        b=MFdZ60V0Z8SLP7aS/zSD42C0ODXm4Kay5EzZTIMpB50VYHIgvLrxmE5eq5LPIt64uN
         olqAvh4ipkvabULiyIIoYB6N6Ta91Yl7amJoQjJPHWy+SZbMca7gD4P4brb0T4Q40Jvr
         M0ZgbnUSRN4+4sbImLBS9cFlDLzj5y8BPCBBxGTqpZZkN1XaIAk4yUyYrD1s5eSV3nyi
         xuJDypmfYzs/3qRP38MpmG5mJ6ZJcsDnXtjyNqmzxJmdrlMo2laibKNdOPOlP8VzIrmL
         NvpWl+jYfc35VWQ84cvLi5Uluqc23IAI9A01t1A+mDNMfNIlTgljyFtZ2blsWyIJcb0Y
         haLg==
X-Forwarded-Encrypted: i=1; AJvYcCXN9uFSfP5zzZdgRL9eEtM2S0N89uIURFRaPdNxp5L+fViufj5PMhTY+IGTkCFKHfiNRSY4ONWJA8UHK1vsUQFf95MmcCEJW3GO3gmuxDc=
X-Gm-Message-State: AOJu0Ywlu6eVLQsvgMG7IEsGg7lU1rJpbFVi2euOdFm/cKSMMo0/kMow
	/IeTs4xIxVKIr+mb+ExXv0vb1nqLoo1EM3X/E9R4gw2qo7qUi4NOthM3xk2zuTU=
X-Google-Smtp-Source: AGHT+IFlNDz44BkHg1rOH/EgiI1G+yXTSCX8l4K31Xu5gDP2OpWVLm1QB8kJOtGgdAyvQ6WRH+fr4g==
X-Received: by 2002:a17:906:f0c8:b0:a4e:3fad:b973 with SMTP id dk8-20020a170906f0c800b00a4e3fadb973mr1493115ejb.65.1713441720189;
        Thu, 18 Apr 2024 05:02:00 -0700 (PDT)
Received: from localhost (78-80-105-131.customers.tmcz.cz. [78.80.105.131])
        by smtp.gmail.com with ESMTPSA id i21-20020a170906a29500b00a526a992d82sm795799ejz.4.2024.04.18.05.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 05:01:59 -0700 (PDT)
Date: Thu, 18 Apr 2024 14:01:58 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Petr Machata <petrm@nvidia.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
	davem@davemloft.net, edumazet@google.com, parav@nvidia.com,
	mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	shuah@kernel.org, liuhangbin@gmail.com, vladimir.oltean@nxp.com,
	bpoirier@nvidia.com, idosch@nvidia.com,
	virtualization@lists.linux.dev
Subject: Re: [patch net-next v3 3/6] selftests: forwarding: add ability to
 assemble NETIFS array by driver name
Message-ID: <ZiELtgonxSFIfX5H@nanopsycho>
References: <20240417164554.3651321-1-jiri@resnulli.us>
 <20240417164554.3651321-4-jiri@resnulli.us>
 <87bk67cbuc.fsf@nvidia.com>
 <87y19bawl2.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y19bawl2.fsf@nvidia.com>

Thu, Apr 18, 2024 at 10:43:44AM CEST, petrm@nvidia.com wrote:
>
>Petr Machata <petrm@nvidia.com> writes:
>
>> Jiri Pirko <jiri@resnulli.us> writes:
>>
>>> +# Whether to find netdevice according to the specified driver.
>>> +: "${NETIF_FIND_DRIVER:=}"
>>
>> This would be better placed up there in the Topology description
>> section. Together with NETIFS and NETIF_NO_CABLE, as it concerns
>> specification of which interfaces to use.
>
>Oh never mind, it's not something a user should configure, but rather a
>test API.

Yep.

