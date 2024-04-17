Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC006A8BA
	for <virtualization@lists.linux.dev>; Wed, 17 Apr 2024 07:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713338579; cv=none; b=Js+dWWYAVdMPDMU3lFpeqr0o4KiSZVEiMQCHIwy3Lk4mU7zOqP+AhbjYGz7cYY/gr1BnrfQvarpMbJSCR6DQyyf4pLs7BwmQ7gomVPIcK5klcmt/YXR22kDIX3sWT2nLiMKJyuC+k4cRGzYVOsEiTcWHqjxrhZsgnoXk6SwqNKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713338579; c=relaxed/simple;
	bh=A9w0TNw8xOwwO7aK3Yc6awMgv37h3KiP86rdJZ3sluo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pt83ONzpAglhU92CGfeIyh1ISSsbaYF3ypb86WNhpzAz+ZtnnrqO72GwmjNoJo5A1VFurda1YryAK/7lBuHVQ5VegFWKd7MWNdQYK5t97K6d1hFtqvTExbbVa81joNPKrjgK843pWyTfPws4PqSZMLjH+gtAD4PdvAeVBiSm9/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=YsSOfdqK; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="YsSOfdqK"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-418bbc68f7cso1933325e9.0
        for <virtualization@lists.linux.dev>; Wed, 17 Apr 2024 00:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713338575; x=1713943375; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=x1fZRmtUCzpag8fleysfaO/F+gV8nCRc5HsAwDzsIyo=;
        b=YsSOfdqKFrxisnIP27hhdEDwH02AosFKccV2rcWFtOBBJA7kq1lfvgo2B2zRCtiPfa
         pzKZDoPzLmH3/LVyAbzLhv9OshonNaXCWk8Fc/aJbL7pgwVnH4oPf/gBTh1M2uSkp6Ec
         +Hy1XfrN3i+JwUBlK9ZOLLruhw0whmv5uYHFYZvOXhQa+hnxDntkQOfLmovjrzjiQa0H
         glepSAmhuk7U3IC6URQMsqE4ZrmJ4R2cLnr8CphARHUN1y3oHzrRAX9BLs2Tg+H2f8xM
         lDbzGcYgDm9AcQHwWJwciWZoytOILZly2AfyT4pDk2+TEAcQl9zEpr0okhF2KMFqiZYO
         GuMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713338575; x=1713943375;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x1fZRmtUCzpag8fleysfaO/F+gV8nCRc5HsAwDzsIyo=;
        b=ssc5asn51B4e1qX0Cp9LtwEk1/A8Oak5PrO0mSxHWqL0iQFq72C8+Ns+7eBLypL+8W
         ujrSFe8vbTyko8rnmBYYi9HkxT6Ar2GEmBrPPqXbBqO257qtPYrI5ad4D1Vpk51OeoDe
         /FJC/CbTM5cchKwERu1kqXzqIXMyurnUvjew0OneBrnUUwtR+rim0GGOVSAHigW9UJS3
         nz/Hsm88HmTmRRUR+wB/GqNQWV9Le2+MQ6YPljBeBMKquMn5YBoi1a5XAOIZS80iPqil
         KAyYvnIhqOjzKcbTqBkq01YYBLo1BkZyznQ5sfcCZzO782YhI2Mh3FsReTV4O4MX/+0B
         xTFA==
X-Forwarded-Encrypted: i=1; AJvYcCXwsDaBheSEh7yBjznL9IH+XMp5L28CCFjcSpOyOL4uyCVSml2RDWSvOw2clTKcFXFrqa0TDpQqn6gqKC0zxz6TlxpYOX512Ru7prYLsgE=
X-Gm-Message-State: AOJu0YxVkiv/14MzmXFil+S9bUCHALDrx6gvTH1KfpYdzQITBQqMzRIf
	7MhRIvjVmsDnsUvo2xXIB25egH3TAt7bJ6zgXNjdJqLPvp+a2RU808zel+Ps2o4=
X-Google-Smtp-Source: AGHT+IHOMJ6tvg51q7LMCwZaW8Psh5Qlr9UINCBTzEN2w/aV4BJkd1soo+fKHO3Uwy83GP++CdPA3w==
X-Received: by 2002:a05:600c:4f07:b0:414:726:87d9 with SMTP id l7-20020a05600c4f0700b00414072687d9mr13509829wmq.12.1713338575493;
        Wed, 17 Apr 2024 00:22:55 -0700 (PDT)
Received: from localhost (78-80-105-131.customers.tmcz.cz. [78.80.105.131])
        by smtp.gmail.com with ESMTPSA id s4-20020a5d5104000000b00346f9071405sm14418312wrt.21.2024.04.17.00.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 00:22:55 -0700 (PDT)
Date: Wed, 17 Apr 2024 09:22:53 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
	davem@davemloft.net, edumazet@google.com, parav@nvidia.com,
	mst@redhat.com, xuanzhuo@linux.alibaba.com, shuah@kernel.org,
	petrm@nvidia.com, liuhangbin@gmail.com, vladimir.oltean@nxp.com,
	bpoirier@nvidia.com, idosch@nvidia.com,
	virtualization@lists.linux.dev
Subject: Re: [patch net-next v2 1/6] virtio: add debugfs infrastructure to
 allow to debug virtio features
Message-ID: <Zh94zX-oQs96tuKk@nanopsycho>
References: <20240415162530.3594670-1-jiri@resnulli.us>
 <20240415162530.3594670-2-jiri@resnulli.us>
 <CACGkMEtpSPFSpikcrsZZBtXOgpAukjCwFRcF79xfzDG-s8_SyQ@mail.gmail.com>
 <Zh5G0sh62hZtOM0J@nanopsycho>
 <CACGkMEvRMGvx0jTqFK2WH1iuPMUZJ0LfW1jDLgt-iQd2+AT=+g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEvRMGvx0jTqFK2WH1iuPMUZJ0LfW1jDLgt-iQd2+AT=+g@mail.gmail.com>

Wed, Apr 17, 2024 at 06:37:30AM CEST, jasowang@redhat.com wrote:
>On Tue, Apr 16, 2024 at 5:37 PM Jiri Pirko <jiri@resnulli.us> wrote:
>>
>> Tue, Apr 16, 2024 at 05:52:41AM CEST, jasowang@redhat.com wrote:
>> >On Tue, Apr 16, 2024 at 12:25 AM Jiri Pirko <jiri@resnulli.us> wrote:
>> >>
>> >> From: Jiri Pirko <jiri@nvidia.com>
>> >>
>> >> Currently there is no way for user to set what features the driver
>> >> should obey or not, it is hard wired in the code.
>> >>
>> >> In order to be able to debug the device behavior in case some feature is
>> >> disabled, introduce a debugfs infrastructure with couple of files
>> >> allowing user to see what features the device advertises and
>> >> to set filter for features used by driver.
>> >>
>> >> Example:
>> >> $cat /sys/bus/virtio/devices/virtio0/features
>> >> 1110010111111111111101010000110010000000100000000000000000000000
>> >> $ echo "5" >/sys/kernel/debug/virtio/virtio0/filter_feature_add
>> >> $ cat /sys/kernel/debug/virtio/virtio0/filter_features
>> >> 5
>> >> $ echo "virtio0" > /sys/bus/virtio/drivers/virtio_net/unbind
>> >> $ echo "virtio0" > /sys/bus/virtio/drivers/virtio_net/bind
>> >> $ cat /sys/bus/virtio/devices/virtio0/features
>> >> 1110000111111111111101010000110010000000100000000000000000000000
>> >>
>> >> Note that sysfs "features" know already exists, this patch does not
>> >> touch it.
>> >>
>> >> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>> >> ---
>> >
>> >Note that this can be done already with vp_vdpa feature provisioning:
>> >
>> >commit c1ca352d371f724f7fb40f016abdb563aa85fe55
>> >Author: Jason Wang <jasowang@redhat.com>
>> >Date:   Tue Sep 27 15:48:10 2022 +0800
>> >
>> >    vp_vdpa: support feature provisioning
>> >
>> >For example:
>> >
>> >vdpa dev add name dev1 mgmtdev pci/0000:02:00.0 device_features 0x300020000
>>
>> Sure. My intension was to make the testing possible on any virtio
>> device.
>
>It did that actually, vp_vdpa bridge virtio-pci device into vDPA bus
>with mediation layer (like feature filtering etc). So it can only run
>on top of standard virtio-pci device.
>
>> Narrowing the testing for vpda would be limitting.
>
>Unless you want to use other transport like virtio-mmio.

Also, the goal is to test virtio_net emulated devices. There are couple
of implementation. Non-vdpa.


>
>Thanks
>
>>
>>
>> >
>> >Thanks
>> >
>>
>
