Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0851EB27
	for <virtualization@lists.linux.dev>; Thu,  6 Jun 2024 07:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717659010; cv=none; b=by6AifCTicrL0v+0VjIqSIXmw+jQQOmUisH7Me+VadfMQBPAJIafxcTuB1iGk2zBAxDK1k2iunXW0P6eOLnWYlt7gcMJcp7eNL+5PbyRncLyoA80Gxbg42sW+NGSJvdo6xJzU/EJlz28NPIzrN3++hMj9emMsjfj7d6BSe5UhTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717659010; c=relaxed/simple;
	bh=354xLDXyXFY0m2uPYIP1Kud2kgE0QA5eAoiCRwxw3kQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qUO/VW0BylNMSf6hyCE32Rgde/kEHERjWmqcYejJca6SN6SRwG8IGrQG6EMb5thQ+hG0fQ53IpcUayeDj1DJFTiKEJbTWNgHRco+2m4519bOWwBEH6xcJzJwadDi8XBtcHuszgI/YFe/41uu/AP+B5XwJ9r5r+9aD8Oo5xpXyrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=g3oQYYdx; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="g3oQYYdx"
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-42139c66027so7383395e9.3
        for <virtualization@lists.linux.dev>; Thu, 06 Jun 2024 00:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1717659005; x=1718263805; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yfipsjVfQPfXPB6o4x6k5krpbbSASYu2k6RWVLV/C88=;
        b=g3oQYYdxaaMhmvfvctYvk1BRRfwhIlNnHpvRcYcs9KHtv9Zv39HTUn+oXfYagIdlHx
         VoPvWMJouQ9ifgGCgbXguYK2vxo5vQowVHhL7rVJJq8EnM+Dv4vncG42xSSGm2RME+I6
         SoWlaZbH6mb6+6rilVaCwWjrkT+THahzSFAxObeCxcL0ywv5Gi+wlz+fiINOlyB11uNr
         vzHhddnSgQecmU6Tw0MFU4GgD9zHwxR00JM+lxxsxavpcVoGxZyIBntrJAhtTnN41YlJ
         voRRfe3+shlYHqqPd2DTaKD4d8cr25GCGs7MVXLqxhS0HBuxU82ze2BKDwknPtdln3rR
         jT0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717659005; x=1718263805;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yfipsjVfQPfXPB6o4x6k5krpbbSASYu2k6RWVLV/C88=;
        b=H4mLVQZqUXvsqxNkfTlfgKiWlQkTDI5pr+tmnoivCYBZzm/5aPaotr0fvO9LCqy+gW
         bSk97I2QdVdfNvkbCjjhLnFeEcXZuYM30h+RgY+7xEz3dI5k8arVBdPm8Z4RIdnMJCV5
         0e2lfmdQska34mVEQya07PsvoZ1USJR8prQLGy5esbSNBW5/AQH2C2lWLU1W+Ia4bdK0
         /Wvfh6XBy8lgONeBqT2glsR97Ydf5CkdXHGLyqM7LMOy4gjJ0DGQIP2s+i/XuElAx/6j
         BgoshqFLwOUV4RPiYGCfNWw25Hju13608YaJQrHPG4oJgjU8+DB191zHPAfcWXYzzgac
         sXPQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3F9gy1K1lkOgHS0i/4Ve0i9aY83IQCKIHqMvmklFrVBmai0GL0NsSQwUkjhJUZE+X7yXqJ9aUZ4Ky4B5o978ktwQeQINmFOBVCGMt2EU=
X-Gm-Message-State: AOJu0YwhqFp3bxfRcdQaGYC5/Hna+LZoKqFl53lSWxSQl1iyNK+YT4NO
	6DnDKenGGwW0lGf9d8mveIwog0T9v9a9tdtbzJSLZ5+1fmm+SE9PaiZMCc1c5bk=
X-Google-Smtp-Source: AGHT+IGE15F3AQxu8QAb/xG2jRKD11YQY86wpTtSob9rNljYBoHl4Jk0N73HDE9kOM+sV9EzM94y7A==
X-Received: by 2002:a05:600c:4986:b0:421:542b:b9f2 with SMTP id 5b1f17b1804b1-42156338124mr37582245e9.26.1717659005060;
        Thu, 06 Jun 2024 00:30:05 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35ef5fca950sm780520f8f.111.2024.06.06.00.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 00:30:04 -0700 (PDT)
Date: Thu, 6 Jun 2024 09:30:00 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Dave Taht <dave.taht@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	virtualization@lists.linux.dev, ast@kernel.org,
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com
Subject: Re: [patch net-next] virtio_net: add support for Byte Queue Limits
Message-ID: <ZmFleHJxHkDz5D3Z@nanopsycho.orion>
References: <20240509114615.317450-1-jiri@resnulli.us>
 <20240509084050-mutt-send-email-mst@kernel.org>
 <ZjzQTFq5lJIoeSqM@nanopsycho.orion>
 <20240509102643-mutt-send-email-mst@kernel.org>
 <Zj3425_gSqHByw-R@nanopsycho.orion>
 <20240510065121-mutt-send-email-mst@kernel.org>
 <Zj4A9XY7z-TzEpdz@nanopsycho.orion>
 <20240510072431-mutt-send-email-mst@kernel.org>
 <ZkRlcBU0Nb3O-Kg1@nanopsycho.orion>
 <CAA93jw6WanAQrPAFZ1hYVTXuWDwP+4J70LnmPOD2ugNwYK6HMA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAA93jw6WanAQrPAFZ1hYVTXuWDwP+4J70LnmPOD2ugNwYK6HMA@mail.gmail.com>

Thu, Jun 06, 2024 at 04:20:48AM CEST, dave.taht@gmail.com wrote:
>On Wed, May 15, 2024 at 12:37 AM Jiri Pirko <jiri@resnulli.us> wrote:
>
>> Fri, May 10, 2024 at 01:27:08PM CEST, mst@redhat.com wrote:
>> >On Fri, May 10, 2024 at 01:11:49PM +0200, Jiri Pirko wrote:
>> >> Fri, May 10, 2024 at 12:52:52PM CEST, mst@redhat.com wrote:
>> >> >On Fri, May 10, 2024 at 12:37:15PM +0200, Jiri Pirko wrote:
>> >> >> Thu, May 09, 2024 at 04:28:12PM CEST, mst@redhat.com wrote:
>> >> >> >On Thu, May 09, 2024 at 03:31:56PM +0200, Jiri Pirko wrote:
>> >> >> >> Thu, May 09, 2024 at 02:41:39PM CEST, mst@redhat.com wrote:
>> >> >> >> >On Thu, May 09, 2024 at 01:46:15PM +0200, Jiri Pirko wrote:
>> >> >> >> >> From: Jiri Pirko <jiri@nvidia.com>
>> >> >> >> >>
>> >> >> >> >> Add support for Byte Queue Limits (BQL).
>> >> >> >> >>
>> >> >> >> >> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>> >> >> >> >
>> >> >> >> >Can we get more detail on the benefits you observe etc?
>> >> >> >> >Thanks!
>> >> >> >>
>> >> >> >> More info about the BQL in general is here:
>> >> >> >> https://lwn.net/Articles/469652/
>> >> >> >
>> >> >> >I know about BQL in general. We discussed BQL for virtio in the past
>> >> >> >mostly I got the feedback from net core maintainers that it likely
>> won't
>> >> >> >benefit virtio.
>> >> >>
>> >> >> Do you have some link to that, or is it this thread:
>> >> >>
>> https://lore.kernel.org/netdev/21384cb5-99a6-7431-1039-b356521e1bc3@redhat.com/
>> >> >
>> >> >
>> >> >A quick search on lore turned up this, for example:
>> >> >
>> https://lore.kernel.org/all/a11eee78-b2a1-3dbc-4821-b5f4bfaae819@gmail.com/
>> >>
>> >> Says:
>> >> "Note that NIC with many TX queues make BQL almost useless, only adding
>> extra
>> >>  overhead."
>> >>
>> >> But virtio can have one tx queue, I guess that could be quite common
>> >> configuration in lot of deployments.
>> >
>> >Not sure we should worry about performance for these though.
>> >What I am saying is this should come with some benchmarking
>> >results.
>>
>> I did some measurements with VDPA, backed by ConnectX6dx NIC, single
>> queue pair:
>>
>> super_netperf 200 -H $ip -l 45 -t TCP_STREAM &
>> nice -n 20 netperf -H $ip -l 10 -t TCP_RR
>>
>> RR result with no bql:
>> 29.95
>> 32.74
>> 28.77
>>
>> RR result with bql:
>> 222.98
>> 159.81
>> 197.88
>>
>>
>>
>Yay! is that with pfifo_fast or fq_codel as the underlying qdisc?

pfifo_fast


>
>fq_codel, please?
>
>
>>
>> >
>> >
>> >>
>> >> >
>> >> >
>> >> >
>> >> >
>> >> >> I don't see why virtio should be any different from other
>> >> >> drivers/devices that benefit from bql. HOL blocking is the same here
>> are
>> >> >> everywhere.
>> >> >>
>> >> >> >
>> >> >> >So I'm asking, what kind of benefit do you observe?
>> >> >>
>> >> >> I don't have measurements at hand, will attach them to v2.
>> >> >>
>> >> >> Thanks!
>> >> >>
>> >> >> >
>> >> >> >--
>> >> >> >MST
>> >> >> >
>> >> >
>> >
>>
>>
>
>-- 
>https://www.youtube.com/watch?v=BVFWSyMp3xg&t=1098s Waves Podcast
>Dave Täht CSO, LibreQos
