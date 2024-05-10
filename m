Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F53816D332
	for <virtualization@lists.linux.dev>; Fri, 10 May 2024 11:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715339517; cv=none; b=Ole3eUaA9/BaOGZhJMkGZtthOQX48gFrXJYxFAAFQiNokXOaqONQUxGoFPVOmzib439url2H2qpXJAXWhu+R/KgtkOqzis9YiMuYdvH9pPqxQITRatJ7QnqMXbO1esJfjT1ROqUOH4M4l4oea4LLrDBND8gbOvAbvvmzlZttGto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715339517; c=relaxed/simple;
	bh=yeo8sd8RFZdJ862z4TQug4Oieue2ymTOsLQYxEAdY08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rw7ljsT04RLQa22ODpzFQmo1+jhQf6J2uz3floC42V54tIPNzLiZyY4Tp2OR3ACZUaseG5CznpyU92nNos6ENvqHDjbJAu2Emoy9mWsS/yKKqqAeCe9y/S8AzCX+1GmQZuQYj16r2YwT1O0sSOYQ4acVOUccxAuTWnAlw+DIrY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=gmqyewjb; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="gmqyewjb"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-78f049ddd7dso128354285a.1
        for <virtualization@lists.linux.dev>; Fri, 10 May 2024 04:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1715339515; x=1715944315; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fzDowZL4O8ZaZ5oGwMtdLpyR1SKzWoUyd2n/48q61cY=;
        b=gmqyewjbjDCJbBVzrhTVpCBnHN60Xy9KGFjQxpuRKN30G2M4XTxoI6ZDedAFtP9o8d
         DU9W4nsYdTlFtCjm6S4nX+6zRG1cy+m/GMm1GJdtmjF6GRBWxFl9C2lCDHPdiUfZm9Pc
         Ky5Lly5966k+E9FrpdtzkSg3GDTCkHNI/WUlbQK9BabJIPEp03mX6jF9fdcdXp01iXyQ
         Pj2uMtZ6YBY0OgkWKD0KNF7bUR6Qk+sA8MgpCrkjhR0Cas/Aj4A5JQz+KsvFHpQvWSSd
         zQuwlU001CtNR/tgiPuJ4pku5Ha9zY/AxPiPB7A/SysmH1pBBNpqY4UxKfeM5TXbSD+F
         ALIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715339515; x=1715944315;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fzDowZL4O8ZaZ5oGwMtdLpyR1SKzWoUyd2n/48q61cY=;
        b=Fr6sbz6xgAQW95X9sxKAp/D8yh98SylQIwKCy9PSdVrJEmDw3Hxo0zHPnnFgq0ef3e
         4XpQ8oK+EKAPFZgbl1IhuJfwmtVQSOAAG8Phsu7kYQj4qf+N+fzhQS6OxLYLp9mZQq2d
         1pk1JmXpxepgAsirrrStavvS+/sE1jrbA0sMuQW+Kmvdo/v9roeuQSxhc0gMKD23w9CK
         RCeCp7Dd3Hy8snctKCUuL+iMsyYb7GPPSA5u4WthLOw3L8jj3VmoVAa/J8ehPbNg861b
         un8iLgwc8iCjWqeZloD7TrCWme3gQwdU08WA86CRk5ClSHm7WnKqGBcB/QawJ8qpau/y
         sQRg==
X-Forwarded-Encrypted: i=1; AJvYcCWFhghnmfgyb1zTA1A8GWJjZd11OoiMnr+BEp8mT6QL7afLwGOhsXkn5D+tJeyhwxi8kb5qC49e6RWsdZdMWfAKc4Rs5ujNEAojJE76ctg=
X-Gm-Message-State: AOJu0YxQHXT0SvK4okIPIx72qgA69NNQmjbBqFpPl0QFPWJFqI5HkuJR
	7tmCQ5zXi1OwHZqbROLFTnoi42Fh2QSo+1q5gAs1lJnfo/a6CymLs+O61PUOrVg=
X-Google-Smtp-Source: AGHT+IHnhjG58jX47vVHtIqP3sRxriUOfdxV+WZjAFYtYRcjCXfosuwppdjvkX6oUiw2FmBIAynX9g==
X-Received: by 2002:a05:620a:1003:b0:792:91ce:9b07 with SMTP id af79cd13be357-792c760083cmr219679285a.71.1715339514921;
        Fri, 10 May 2024 04:11:54 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-792bf310713sm168643085a.109.2024.05.10.04.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 04:11:53 -0700 (PDT)
Date: Fri, 10 May 2024 13:11:49 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev,
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
	john.fastabend@gmail.com
Subject: Re: [patch net-next] virtio_net: add support for Byte Queue Limits
Message-ID: <Zj4A9XY7z-TzEpdz@nanopsycho.orion>
References: <20240509114615.317450-1-jiri@resnulli.us>
 <20240509084050-mutt-send-email-mst@kernel.org>
 <ZjzQTFq5lJIoeSqM@nanopsycho.orion>
 <20240509102643-mutt-send-email-mst@kernel.org>
 <Zj3425_gSqHByw-R@nanopsycho.orion>
 <20240510065121-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510065121-mutt-send-email-mst@kernel.org>

Fri, May 10, 2024 at 12:52:52PM CEST, mst@redhat.com wrote:
>On Fri, May 10, 2024 at 12:37:15PM +0200, Jiri Pirko wrote:
>> Thu, May 09, 2024 at 04:28:12PM CEST, mst@redhat.com wrote:
>> >On Thu, May 09, 2024 at 03:31:56PM +0200, Jiri Pirko wrote:
>> >> Thu, May 09, 2024 at 02:41:39PM CEST, mst@redhat.com wrote:
>> >> >On Thu, May 09, 2024 at 01:46:15PM +0200, Jiri Pirko wrote:
>> >> >> From: Jiri Pirko <jiri@nvidia.com>
>> >> >> 
>> >> >> Add support for Byte Queue Limits (BQL).
>> >> >> 
>> >> >> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>> >> >
>> >> >Can we get more detail on the benefits you observe etc?
>> >> >Thanks!
>> >> 
>> >> More info about the BQL in general is here:
>> >> https://lwn.net/Articles/469652/
>> >
>> >I know about BQL in general. We discussed BQL for virtio in the past
>> >mostly I got the feedback from net core maintainers that it likely won't
>> >benefit virtio.
>> 
>> Do you have some link to that, or is it this thread:
>> https://lore.kernel.org/netdev/21384cb5-99a6-7431-1039-b356521e1bc3@redhat.com/
>
>
>A quick search on lore turned up this, for example:
>https://lore.kernel.org/all/a11eee78-b2a1-3dbc-4821-b5f4bfaae819@gmail.com/

Says:
"Note that NIC with many TX queues make BQL almost useless, only adding extra
 overhead."

But virtio can have one tx queue, I guess that could be quite common
configuration in lot of deployments.


>
>
>
>
>> I don't see why virtio should be any different from other
>> drivers/devices that benefit from bql. HOL blocking is the same here are
>> everywhere.
>> 
>> >
>> >So I'm asking, what kind of benefit do you observe?
>> 
>> I don't have measurements at hand, will attach them to v2.
>> 
>> Thanks!
>> 
>> >
>> >-- 
>> >MST
>> >
>
