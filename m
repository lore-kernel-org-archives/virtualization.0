Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D4E143866
	for <virtualization@lists.linux.dev>; Thu, 16 May 2024 10:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715856908; cv=none; b=Ze6JOxWDZuXCVZ0ha3bi9k6C70Q3s97HGv4kMlPzQElUYLNSYpIwzixwSIBsngEvvO59G5C51BuO9ytZXp3sBBbadwxVaP6bsJWHs7ao412NzQ0t0pjdcWnOYLSggOP1Q6ck48gjNOTmGVfrJYR4xII7jITmUOK+7FPs/q5CbYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715856908; c=relaxed/simple;
	bh=5TnSM+LWP5s3qTntfFdJesDBdSw4kLbabX601vj8+2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u2kW/rN9CvoCNMUVXZ6UY2XfhMoJtxi1XhHbXoWz+Xdmiu6R+JwqJcWbzcwiCE/65BwIVFT5cZVmri0ur3jjzSm8YtduVTpcKzs52cwcKIPl5JSU6jYO/S/LRffMTwYB0GuTIJnL8qEzrxsCsr/obkveqF39ZulAWwXfA19z7JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=EyKR+fGZ; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="EyKR+fGZ"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a59a0168c75so328659066b.1
        for <virtualization@lists.linux.dev>; Thu, 16 May 2024 03:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1715856904; x=1716461704; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7X46XyBGn7YI/BzWmEXgP19rZIcDWdKduEjY2/PLLYA=;
        b=EyKR+fGZGqVCkDes8cqCFYknYjbxbVWpSUUKbFwfHE80CfD7S1zwwp1DbgnOvfyYgJ
         WxkFVB8DOsKdlNDrOjL10b61ISFtQ/wikEWjjx/N7GZYw6qh2WhlLqatQP4SWVoTegST
         lpqOzxVIVm9+YJj4gvaf4ymU7HodlyEf5Qzd2LFjAwidyNDZ/0++U3CkuaYtZsEUdXUc
         57BBnCdEl7AHDR66FUwezrgHoODWmngi99X1pewVd9GqodHE1H2Gx0wrGhFoM6DWmEFz
         A1ASKoiD8pzc4JGFtZ54+L+BnAhqpHgdFhhtpKoflfeur26m0YAbu5FzapsjdDBR/XQr
         helw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715856904; x=1716461704;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7X46XyBGn7YI/BzWmEXgP19rZIcDWdKduEjY2/PLLYA=;
        b=xCfRYOTD73XohMwVVnlmjhqMFu7jOJVwCoH93sK+GsjvuyrjXt7VknfYhXgqk1O0k2
         FZuxPP22qySAwQBI1tLEVvwPaAPXZv5mAyJjobgE9D4+Kr3Ue0tXS0aC4yaVlUPrnzLZ
         A5XuAf4CtGDB+YepWPPdvYmdgdS4EKnmJgw/BWjt71Dq3CQ80Iy/IZuuGvsY9I47+pYD
         ohQFo3s5zBuzHGpQ0+DKWt9nV5DW5DT1/1E9TW1KH4tn3qg60iWTzf9G0+RMgc8n5HFl
         vfAhrIx6iBpgTOiKaLE63VZ/EGzeEFKQCdK4rgbZZwYWQ61ldNUyaQLHfosLqGhY9XAm
         sN1g==
X-Forwarded-Encrypted: i=1; AJvYcCVOHKxltvrgizQwhNTMiTYr9O6kQexMVPKPbL3WqW7/6HDacyXzSWZYxzXp+I/3VyrP7FKNhJwJZJtimYuBqPGq588IdrhuNXxvXF55Nck=
X-Gm-Message-State: AOJu0YyC3BSU2UAl+Crjxc68FsbGi9mmdkJXY83PIRjbc0IYWpHX4z0T
	jjrqq2Am31A5WBQdBNz6mdbXRm/cciqC6CNIc9/kZ7WBmeKeRDJdSoGHAhbAZA8=
X-Google-Smtp-Source: AGHT+IHgsVJM0AOUDBKv17oOvX5pJUDHqBdgDGUos1raZMomhZpyV6l+jo1rL5I6arawRvoNKMzthg==
X-Received: by 2002:a17:906:3a8d:b0:a59:be8a:bd6f with SMTP id a640c23a62f3a-a5a2d65f272mr1144732066b.61.1715856903985;
        Thu, 16 May 2024 03:55:03 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17b0125bsm981316366b.143.2024.05.16.03.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 03:55:02 -0700 (PDT)
Date: Thu, 16 May 2024 12:54:58 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, xuanzhuo@linux.alibaba.com,
	virtualization@lists.linux.dev, ast@kernel.org,
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com
Subject: Re: [patch net-next] virtio_net: add support for Byte Queue Limits
Message-ID: <ZkXmAjlm-A50m4dx@nanopsycho.orion>
References: <20240509102643-mutt-send-email-mst@kernel.org>
 <Zj3425_gSqHByw-R@nanopsycho.orion>
 <20240510065121-mutt-send-email-mst@kernel.org>
 <Zj4A9XY7z-TzEpdz@nanopsycho.orion>
 <20240510072431-mutt-send-email-mst@kernel.org>
 <ZkRlcBU0Nb3O-Kg1@nanopsycho.orion>
 <20240515041909-mutt-send-email-mst@kernel.org>
 <ZkSKo1npMxCVuLfT@nanopsycho.orion>
 <ZkSwbaA74z1QwwJz@nanopsycho.orion>
 <CACGkMEsLfLLwjfHu5MT8Ug0_tS_LASvw-raiXiYx_WHJzMcWbg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEsLfLLwjfHu5MT8Ug0_tS_LASvw-raiXiYx_WHJzMcWbg@mail.gmail.com>

Thu, May 16, 2024 at 06:48:38AM CEST, jasowang@redhat.com wrote:
>On Wed, May 15, 2024 at 8:54 PM Jiri Pirko <jiri@resnulli.us> wrote:
>>
>> Wed, May 15, 2024 at 12:12:51PM CEST, jiri@resnulli.us wrote:
>> >Wed, May 15, 2024 at 10:20:04AM CEST, mst@redhat.com wrote:
>> >>On Wed, May 15, 2024 at 09:34:08AM +0200, Jiri Pirko wrote:
>> >>> Fri, May 10, 2024 at 01:27:08PM CEST, mst@redhat.com wrote:
>> >>> >On Fri, May 10, 2024 at 01:11:49PM +0200, Jiri Pirko wrote:
>> >>> >> Fri, May 10, 2024 at 12:52:52PM CEST, mst@redhat.com wrote:
>> >>> >> >On Fri, May 10, 2024 at 12:37:15PM +0200, Jiri Pirko wrote:
>> >>> >> >> Thu, May 09, 2024 at 04:28:12PM CEST, mst@redhat.com wrote:
>> >>> >> >> >On Thu, May 09, 2024 at 03:31:56PM +0200, Jiri Pirko wrote:
>> >>> >> >> >> Thu, May 09, 2024 at 02:41:39PM CEST, mst@redhat.com wrote:
>> >>> >> >> >> >On Thu, May 09, 2024 at 01:46:15PM +0200, Jiri Pirko wrote:
>> >>> >> >> >> >> From: Jiri Pirko <jiri@nvidia.com>
>> >>> >> >> >> >>
>> >>> >> >> >> >> Add support for Byte Queue Limits (BQL).
>> >>> >> >> >> >>
>> >>> >> >> >> >> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>> >>> >> >> >> >
>> >>> >> >> >> >Can we get more detail on the benefits you observe etc?
>> >>> >> >> >> >Thanks!
>> >>> >> >> >>
>> >>> >> >> >> More info about the BQL in general is here:
>> >>> >> >> >> https://lwn.net/Articles/469652/
>> >>> >> >> >
>> >>> >> >> >I know about BQL in general. We discussed BQL for virtio in the past
>> >>> >> >> >mostly I got the feedback from net core maintainers that it likely won't
>> >>> >> >> >benefit virtio.
>> >>> >> >>
>> >>> >> >> Do you have some link to that, or is it this thread:
>> >>> >> >> https://lore.kernel.org/netdev/21384cb5-99a6-7431-1039-b356521e1bc3@redhat.com/
>> >>> >> >
>> >>> >> >
>> >>> >> >A quick search on lore turned up this, for example:
>> >>> >> >https://lore.kernel.org/all/a11eee78-b2a1-3dbc-4821-b5f4bfaae819@gmail.com/
>> >>> >>
>> >>> >> Says:
>> >>> >> "Note that NIC with many TX queues make BQL almost useless, only adding extra
>> >>> >>  overhead."
>> >>> >>
>> >>> >> But virtio can have one tx queue, I guess that could be quite common
>> >>> >> configuration in lot of deployments.
>> >>> >
>> >>> >Not sure we should worry about performance for these though.
>> >>> >What I am saying is this should come with some benchmarking
>> >>> >results.
>> >>>
>> >>> I did some measurements with VDPA, backed by ConnectX6dx NIC, single
>> >>> queue pair:
>> >>>
>> >>> super_netperf 200 -H $ip -l 45 -t TCP_STREAM &
>> >>> nice -n 20 netperf -H $ip -l 10 -t TCP_RR
>> >>>
>> >>> RR result with no bql:
>> >>> 29.95
>> >>> 32.74
>> >>> 28.77
>> >>>
>> >>> RR result with bql:
>> >>> 222.98
>> >>> 159.81
>> >>> 197.88
>> >>>
>> >>
>> >>Okay. And on the other hand, any measureable degradation with
>> >>multiqueue and when testing throughput?
>> >
>> >With multiqueue it depends if the flows hits the same queue or not. If
>> >they do, the same results will likely be shown.
>>
>> RR 1q, w/o bql:
>> 29.95
>> 32.74
>> 28.77
>>
>> RR 1q, with bql:
>> 222.98
>> 159.81
>> 197.88
>>
>> RR 4q, w/o bql:
>> 355.82
>> 364.58
>> 233.47
>>
>> RR 4q, with bql:
>> 371.19
>> 255.93
>> 337.77
>>
>> So answer to your question is: "no measurable degradation with 4
>> queues".
>
>Thanks but I think we also need benchmarks in cases other than vDPA.
>For example, a simple virtualization setup.

For virtualization setup, I get this:

VIRT RR 1q, w/0 bql:
49.18
49.75
50.07

VIRT RR 1q, with bql:
51.33
47.88
40.40

No measurable/significant difference.

>
