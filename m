Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBED13AA5D
	for <virtualization@lists.linux.dev>; Tue, 27 Feb 2024 13:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709039669; cv=none; b=RHpd+CHJS0vw0foPZXbax501PK+83z4Y6gH36M5xuaDhO+ja42uVVjMAa3p/5eEv7hySka6iohhQGeutBW488bq/NxqQX9VtzkzL0KvugfqAaYykmLLQzSOYZ7ZAcK9iHuMUdPyajnn1tDNtUbeoLNNt++lpoSk7jL9uIZz2Z5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709039669; c=relaxed/simple;
	bh=ptRFBXO9Jpg8128ah9oHQMEu8XEuCDUQRkxKmyhlxas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IlWNCwWfrf85QiJf43ASjB2mbwHcc/N9V+9QM9J0U8eWbYdqX9BHhchq4/r8gQLBZ/Ed8zZQ1NJgit0gGnXS0GMR/vDU27vNNLdQjqNmw7v9h4WzA993rI8++wl6aDHUGzyEFNES6127jgn1koCaO9CRqAn0p0n3sd4V9dIzLxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=RLCtMThW; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="RLCtMThW"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d21cdbc85bso66558991fa.2
        for <virtualization@lists.linux.dev>; Tue, 27 Feb 2024 05:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1709039666; x=1709644466; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HaqJXVS/o9ZLjDcC3LExNS8YspO5mJ2Ato/Q0hLHtpM=;
        b=RLCtMThWHC6eJCTl3h7X5DUonOrAED1PLrimRp1Sh68NfMWk5n1Z/sP581BAoiXssP
         kHvjlpU3yDetILWH4sB3B5/qtCDn5iYr2zdhAzmUT7uptDXBYhFT7FVlIk9HTMNFPrRp
         lPWHDWyD9hGSQjCZRM4V3TDU11wKG7VsMEsaswKD0W+OQwbW5faE2KGRcjy2CsrVCRGQ
         4fXN6XOaIascwp1EULVY/wnfSM9lxGx3yBCumXlULiBmCr37Y+qXo3Ew+TiM1Yb3oHld
         +Kq+3KjfDVxlmYNPRuXxE/CcRqKy+w+6qPGSW/z9/+VdsdD+ytyXWwg9uUIjUeq8vp8G
         qu/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709039666; x=1709644466;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HaqJXVS/o9ZLjDcC3LExNS8YspO5mJ2Ato/Q0hLHtpM=;
        b=i1Adntuj+ur0G68hFlu1hUKL6jEnfahcap9XGY70Cp/yexQDgtpV3U0eNdMv8OflIN
         JJQcFx9zMywrar/EyO6YqV8SpmbFEyOFG8/Sx2E7QYzuj8R6N3qf5dESH1pzk2LCjJzp
         z8cPZeRlVtGqzJ7el3lhf5GFrtRcv/EzHZyInJd5AHOoiJKFlm0CmWQY2odaiKf+dnMB
         dSgCBS6eIP4pBbv+eO4UxCemqAivi5vYmt7VZo1WToMPrES0NG42FEQGFjPBT7hoqqir
         luhgWiOwyEmwOpLaAvbbbGE6q3hCyBGb+1d9VFHmyTV3Cb0SNHvs6a+F4SpE+KGMxTVC
         Wmnw==
X-Forwarded-Encrypted: i=1; AJvYcCWMBwn47Bk4aIEs+HuqTlbOSjGIEgk5w6Z072xkbnqOZiEY0CfoNoF7CEaY1UocdS1b4JBG4+YMz0hS3SUuW3ppbq4WDOylHgE+azFOnlE=
X-Gm-Message-State: AOJu0Yxmt/sTbK1IsKnfJf6w+tlLUI2/pVzp53k2kbi3464yiMyLpJRz
	l9hXGqWejLjbxf4rFcKk26q76oLXcc3AnMOd7HsLaBaUWoF0eaxvFMRxIeNBU40=
X-Google-Smtp-Source: AGHT+IHpjC36J3Q+WJOGBOAur6xPab0p/dNZi1zN9BC2HwfKmlYBwHXsetNgRWncF7WsZpwUw5Ak4Q==
X-Received: by 2002:a2e:9999:0:b0:2d2:65ff:3b78 with SMTP id w25-20020a2e9999000000b002d265ff3b78mr6030020lji.35.1709039666300;
        Tue, 27 Feb 2024 05:14:26 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id v5-20020a05600c470500b00412b0ef22basm52304wmo.10.2024.02.27.05.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 05:14:25 -0800 (PST)
Date: Tue, 27 Feb 2024 14:14:22 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev
Subject: Re: [PATCH net-next v3 0/6] virtio-net: support device stats
Message-ID: <Zd3gLsIfhMlvm_0T@nanopsycho>
References: <20240227080303.63894-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227080303.63894-1-xuanzhuo@linux.alibaba.com>

Tue, Feb 27, 2024 at 09:02:57AM CET, xuanzhuo@linux.alibaba.com wrote:
>As the spec:
>
>https://github.com/oasis-tcs/virtio-spec/commit/42f389989823039724f95bbbd243291ab0064f82
>
>The virtio net supports to get device stats.

Okay, you state what hw supports. It would be nice to throw in a
sentence or two about this patchset (as the cover letter should do)
what it actually does. Some details would be also nice, like example
commands and their outputs to show what is the actual benefit
for the user.

pw-bot: cr


>
>Please review.
>
>Thanks.
>
>v3:
>    1. rebase net-next
>
>v2:
>    1. fix the usage of the leXX_to_cpu()
>    2. add comment to the structure virtnet_stats_map
>
>v1:
>    1. fix some definitions of the marco and the struct
>
>
>
>
>Xuan Zhuo (6):
>  virtio_net: introduce device stats feature and structures
>  virtio_net: virtnet_send_command supports command-specific-result
>  virtio_net: support device stats
>  virtio_net: stats map include driver stats
>  virtio_net: add the total stats field
>  virtio_net: rename stat tx_timeout to timeout
>
> drivers/net/virtio_net.c        | 536 ++++++++++++++++++++++++++++----
> include/uapi/linux/virtio_net.h | 137 ++++++++
> 2 files changed, 613 insertions(+), 60 deletions(-)
>
>--
>2.32.0.3.g01195cf9f
>
>
