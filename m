Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC8512A171
	for <virtualization@lists.linux.dev>; Thu, 18 Apr 2024 08:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713428927; cv=none; b=NRHwxwNlDegJLrq7EpOGSrX7H3n12TKOtVGcMhizgRwWeXxEB/Njyd9hWHFv2RQp2qi0dNJWvbwhY90/TNNaNN58GFufGd9WmNpcdeE2uBbjxOE/0GfkvvxFJyg5zxLjKPXqhAuX8I1peD+ONO/VEMdULaH7Nw4sd5EeDtl7Dew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713428927; c=relaxed/simple;
	bh=ZQlNvuxU1Ruuhia4AiY+CRXdS6bFMo/TL73YQJTuopc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F3uogvSXtvVTU3XBvVuqGzMr9HN4rCXTST/tGdQX0+rJ0A7QKOz7+AzQxo2h656EncZu0gK1ZqHZN0PDfw3rHI6adCb0mmvmr2sxspieGY192vTpeP6pkAO/6QEhxjWaprLd7TOdpKdGx5EnJGyPWarCmRlKKcqzYlWn2SZDkW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=OoxOBmrw; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="OoxOBmrw"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-56e6acb39d4so714075a12.1
        for <virtualization@lists.linux.dev>; Thu, 18 Apr 2024 01:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713428923; x=1714033723; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=00EHNLIhtTOTMUZiuikNl15VWRGSekrYgAUwPrFoFtQ=;
        b=OoxOBmrwYym69Ww7r3PIcp22BP4bOrbvbmDeHe5qODdPNHeWdCDsDVv+w8chv6pPqS
         qnU4LRGr1pZjyPg5THznS78gy6ovESAZUuwuv3lRyUrq65N9V/7bZD5QBK59efX2cOeZ
         NlzOXczfytz3pHanDND5vWLPXOGSvuO+HervqcokQmrPHeflp5t+n+EBe+BQGQQtn0Ke
         wkvqHn3RpOiCfcOBbnzkXbL8m/n2vWEQvMffE6vIftdgXtOu47A8ztrhHadxLRwAtC9O
         IY44ZmXF9tdMCxXVeAB4CW/MFjI1zderc3LEWK3m5IbhbIy0C2gsP8Q3Cb0NZlrctVSa
         mLTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713428923; x=1714033723;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=00EHNLIhtTOTMUZiuikNl15VWRGSekrYgAUwPrFoFtQ=;
        b=XYUNxUXTY7dYOrTtqyxQi7M7sKez+hEi9iEKxP+xLpASQI3EZm7bxVPJzyugAMUdiU
         OohRpvxcyYP3aslMqusehdjkB8bcK3Q61NpNigWhnIoth2jJKVfSVnt4Vhx/QSkn9CSv
         yXxt4HW0NFey1Kgz+CcOwyXfWYyySc+q0rtHtv6qnaclfrPaU5VgwbfcU99offRITs6X
         5SLImsLQEhkBHTF0qdfisLPKo99KLUh/os7fHpwyxrFRTuAp6nFw1h0LzyPwTYFbLu9s
         3SIsbcy0TN8RbZVXbZPsaQzEjYNoVLapsOk2iC/wi+z5tNw6q2R1MaBdKWy0a6yCUjwb
         MISA==
X-Forwarded-Encrypted: i=1; AJvYcCW+U8D6mSZbDiQYadz0romXICICAx1H7lvT2tuVRYJEEoKoGtlrZvBAV8SUTBvmjsjFArVPBHSEI5OvRH+I9iouldsY8+6v9ltWh7yNE1w=
X-Gm-Message-State: AOJu0YyxnkHjzytNkg3D9EpP2CaYdoxONL/+GvvDMZu0CKl4O4I6ZppH
	qrKg8tEiHSeZ6W/f2dVHhx/UxIAGb20V+fnHo2YKRzbL9jSOkiu9p/CL0dNI49A=
X-Google-Smtp-Source: AGHT+IELCQfsKbAJfRd6jWQR9/DGdQt4Kz33gV1dBsN0EjytMayF4FnnyYOWYDum+jCtoh41R8zKHg==
X-Received: by 2002:a17:906:cb95:b0:a52:3ff0:4a12 with SMTP id mf21-20020a170906cb9500b00a523ff04a12mr1295937ejb.18.1713428923382;
        Thu, 18 Apr 2024 01:28:43 -0700 (PDT)
Received: from localhost (78-80-105-131.customers.tmcz.cz. [78.80.105.131])
        by smtp.gmail.com with ESMTPSA id k14-20020a17090627ce00b00a525669000csm576040ejc.154.2024.04.18.01.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 01:28:42 -0700 (PDT)
Date: Thu, 18 Apr 2024 10:28:41 +0200
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
Message-ID: <ZiDZudK3PuSF_3sZ@nanopsycho>
References: <20240415162530.3594670-1-jiri@resnulli.us>
 <20240415162530.3594670-2-jiri@resnulli.us>
 <CACGkMEtpSPFSpikcrsZZBtXOgpAukjCwFRcF79xfzDG-s8_SyQ@mail.gmail.com>
 <Zh5G0sh62hZtOM0J@nanopsycho>
 <CACGkMEvRMGvx0jTqFK2WH1iuPMUZJ0LfW1jDLgt-iQd2+AT=+g@mail.gmail.com>
 <Zh94zX-oQs96tuKk@nanopsycho>
 <CACGkMEtqJL1+D9byRLSFdFmo0aqoWAeHqmqyq+KEzoC8xhnEFA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEtqJL1+D9byRLSFdFmo0aqoWAeHqmqyq+KEzoC8xhnEFA@mail.gmail.com>

Thu, Apr 18, 2024 at 02:59:41AM CEST, jasowang@redhat.com wrote:
>On Wed, Apr 17, 2024 at 3:23 PM Jiri Pirko <jiri@resnulli.us> wrote:
>>
>> Wed, Apr 17, 2024 at 06:37:30AM CEST, jasowang@redhat.com wrote:
>> >On Tue, Apr 16, 2024 at 5:37 PM Jiri Pirko <jiri@resnulli.us> wrote:
>> >>
>> >> Tue, Apr 16, 2024 at 05:52:41AM CEST, jasowang@redhat.com wrote:
>> >> >On Tue, Apr 16, 2024 at 12:25 AM Jiri Pirko <jiri@resnulli.us> wrote:
>> >> >>
>> >> >> From: Jiri Pirko <jiri@nvidia.com>
>> >> >>
>> >> >> Currently there is no way for user to set what features the driver
>> >> >> should obey or not, it is hard wired in the code.
>> >> >>
>> >> >> In order to be able to debug the device behavior in case some feature is
>> >> >> disabled, introduce a debugfs infrastructure with couple of files
>> >> >> allowing user to see what features the device advertises and
>> >> >> to set filter for features used by driver.
>> >> >>
>> >> >> Example:
>> >> >> $cat /sys/bus/virtio/devices/virtio0/features
>> >> >> 1110010111111111111101010000110010000000100000000000000000000000
>> >> >> $ echo "5" >/sys/kernel/debug/virtio/virtio0/filter_feature_add
>> >> >> $ cat /sys/kernel/debug/virtio/virtio0/filter_features
>> >> >> 5
>> >> >> $ echo "virtio0" > /sys/bus/virtio/drivers/virtio_net/unbind
>> >> >> $ echo "virtio0" > /sys/bus/virtio/drivers/virtio_net/bind
>> >> >> $ cat /sys/bus/virtio/devices/virtio0/features
>> >> >> 1110000111111111111101010000110010000000100000000000000000000000
>> >> >>
>> >> >> Note that sysfs "features" know already exists, this patch does not
>> >> >> touch it.
>> >> >>
>> >> >> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>> >> >> ---
>> >> >
>> >> >Note that this can be done already with vp_vdpa feature provisioning:
>> >> >
>> >> >commit c1ca352d371f724f7fb40f016abdb563aa85fe55
>> >> >Author: Jason Wang <jasowang@redhat.com>
>> >> >Date:   Tue Sep 27 15:48:10 2022 +0800
>> >> >
>> >> >    vp_vdpa: support feature provisioning
>> >> >
>> >> >For example:
>> >> >
>> >> >vdpa dev add name dev1 mgmtdev pci/0000:02:00.0 device_features 0x300020000
>> >>
>> >> Sure. My intension was to make the testing possible on any virtio
>> >> device.
>> >
>> >It did that actually, vp_vdpa bridge virtio-pci device into vDPA bus
>> >with mediation layer (like feature filtering etc). So it can only run
>> >on top of standard virtio-pci device.
>> >
>> >> Narrowing the testing for vpda would be limitting.
>> >
>> >Unless you want to use other transport like virtio-mmio.
>>
>> Also, the goal is to test virtio_net emulated devices.
>> There are couple
>> of implementation. Non-vdpa.
>
>So what I want to say is, vp_vdpa works for all types of virtio-pci
>devices no matter if it is emulated or hardware.

Sure, but I wanted to have a simple generic way, working on all virtio
devices, even the ones backed by a different transport, and without need
of extra vdpa layer.


>
>Thanks
>
>>
>>
>> >
>> >Thanks
>> >
>> >>
>> >>
>> >> >
>> >> >Thanks
>> >> >
>> >>
>> >
>>
>
