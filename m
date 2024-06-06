Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B75195B10
	for <virtualization@lists.linux.dev>; Thu,  6 Jun 2024 13:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717681512; cv=none; b=kos+iiWkTgafKYJKbtQwhB0HzJAguq6JtzAbxazmJQL4zO9C3H/1+iA5J5ZCBNPh7yKM7BGHM4wunVEC/EyI/hxw9F37JIZyQhCk/3+4HIXklzhGkyzOHEf+ZqzhKJohqR57APOAVzxnRe5sq4Ie+qTfA5BdlNLM4pOGlAOyxL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717681512; c=relaxed/simple;
	bh=ETbwxjKeQNyzp3aJQuy3uxvhni5xHQLfJAuwpU+mDHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JO66S99Xzg1wKhY5BUKT6tcfQffgCpPRH1bi375nrtz6vHJjELv4y0Ip9bn/33esLjVjqNyimFU3psndKDy3YvY/XTVJKYTpECruEOCZY+wSQoop8r+Vw2xG7rNcSLoWruiOoadxbt2hSzZSPct4IqBMCtw8PBoN/hrW7UIBSc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=F2zyrtLP; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="F2zyrtLP"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42136faf3aeso6413935e9.2
        for <virtualization@lists.linux.dev>; Thu, 06 Jun 2024 06:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1717681509; x=1718286309; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/kEq/cSXLDF9g1VB9kvBV2CHVx+ge4bVlvK/b/5dgDA=;
        b=F2zyrtLP2vGK8rsHP7Vq5Ay2xlD5SMo99eHSG2JMQJ0HJE7gujE4QGNExuouDs8IKm
         QTtjPPmN9mJDX4OdrSQJSjx5YWXnPy010s7ItQ0mRei9PYntnrwr4AFwgKc5++HYv+lL
         CiFHxCglw98XLQPQBA9/Q+MntYsLx7ebooPQefBeHWfap+r1eLTTFJjWSJafFjf2P37v
         jLK5CxgNvFa0MJEEL91P3AQgO9UCokocg8wg2SaIjirtSaDEavhCW/NgZ60xKP4iYLj1
         gP/bU+x/alSv88H06MncsH7RbOm4jqpVEZGn2+VB0YcA49uedAEN4K8Rmh2hZC+XS7HH
         +Lgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717681509; x=1718286309;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/kEq/cSXLDF9g1VB9kvBV2CHVx+ge4bVlvK/b/5dgDA=;
        b=LVJNKfjeYctQsIEOX/HlEF4a5lEac/wk/+iNT6uUPPjwZTHH4wpl/p5ADMiX26vV6D
         EsV9mRXrqrOqIKJMJlzpzgfL9cI1rBNibuoG9g2alcNnOquk6fbR/b+d1vZwtin/hAWi
         kv+GUabucaS84SI3Z8CeNciNhDgBwEn6ZxYTS8LjT1bLjUFlSjxBLY+r+cfkd9nYlP8G
         g6SjHhrN6wV0BLoiEXPmkgYAkOqIpAJCKUrfol6vO85vj3SgUj/rBBx8KO5L3S1DqVui
         ykbSrh5PC4OoTKIXiDYK807zPRxUdzZCr93gMnxai8v72Z+elAhsrOE4atUlY4sJEj5m
         gzVg==
X-Forwarded-Encrypted: i=1; AJvYcCVbm750HkMUzvhKcwO6YZbhX25xWXf94TrmP06TV6axTnWsEkw2FH5Zu0uI3wnLcnBG/XKG/GJWl2Jaej4i4FQ8sjkHJWcFV2Gkvgo2+88=
X-Gm-Message-State: AOJu0Yw2vihwsg9VBxZ72O3uruzCPaNKecSrsu6/naC2V47uehLPwXKf
	Lq/jDjw0dPCtsyNr00qjCN4eXGWtq8BXdr/XdrQ9tExjonKXw/D9uUVhxH6W0XQ=
X-Google-Smtp-Source: AGHT+IGO4QJRyNU1dKUWadFZnIp3cwBRcYvJu0m0pBiLJcJ89bYxEqcWmfR91HnKvgLL+cxSDb/nYA==
X-Received: by 2002:a05:600c:19d2:b0:41a:8b39:8040 with SMTP id 5b1f17b1804b1-421562e751dmr41781605e9.20.1717681508824;
        Thu, 06 Jun 2024 06:45:08 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42160a19ae5sm9751525e9.18.2024.06.06.06.45.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 06:45:08 -0700 (PDT)
Date: Thu, 6 Jun 2024 15:45:05 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Heng Qi <hengqi@linux.alibaba.com>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev,
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
	john.fastabend@gmail.com, netdev@vger.kernel.org
Subject: Re: [patch net-next] virtio_net: add support for Byte Queue Limits
Message-ID: <ZmG9YWUcaW4S94Eq@nanopsycho.orion>
References: <20240509114615.317450-1-jiri@resnulli.us>
 <1715325076.4219763-2-hengqi@linux.alibaba.com>
 <ZktGj4nDU4X0Lxtx@nanopsycho.orion>
 <ZmBMa7Am3LIYQw1x@nanopsycho.orion>
 <1717587768.1588957-5-hengqi@linux.alibaba.com>
 <CACGkMEsiosWxNCS=Jpb-H14b=-26UzPjw+sD3H21FwVh2ZTF5g@mail.gmail.com>
 <CAL+tcoB8y6ctDO4Ph8WM-19qAoNMcYTVWLKRqsJYYrmW9q41=w@mail.gmail.com>
 <CACGkMEvh6nKfFMp5fb6tbijrs88vgSofCNkwN1UzKHnf6RqURg@mail.gmail.com>
 <20240606020248-mutt-send-email-mst@kernel.org>
 <CACGkMEsy37mg-GwRXJNBBkvhEuaEYw-g3wthv_XS7+t5=ALhiA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEsy37mg-GwRXJNBBkvhEuaEYw-g3wthv_XS7+t5=ALhiA@mail.gmail.com>

Thu, Jun 06, 2024 at 09:56:50AM CEST, jasowang@redhat.com wrote:
>On Thu, Jun 6, 2024 at 2:05 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>>
>> On Thu, Jun 06, 2024 at 12:25:15PM +0800, Jason Wang wrote:
>> > > If the codes of orphan mode don't have an impact when you enable
>> > > napi_tx mode, please keep it if you can.
>> >
>> > For example, it complicates BQL implementation.
>> >
>> > Thanks
>>
>> I very much doubt sending interrupts to a VM can
>> *on all benchmarks* compete with not sending interrupts.
>
>It should not differ too much from the physical NIC. We can have one
>more round of benchmarks to see the difference.
>
>But if NAPI mode needs to win all of the benchmarks in order to get
>rid of orphan, that would be very difficult. Considering various bugs
>will be fixed by dropping skb_orphan(), it would be sufficient if most
>of the benchmark doesn't show obvious differences.
>
>Looking at git history, there're commits that removes skb_orphan(), for example:
>
>commit 8112ec3b8722680251aecdcc23dfd81aa7af6340
>Author: Eric Dumazet <edumazet@google.com>
>Date:   Fri Sep 28 07:53:26 2012 +0000
>
>    mlx4: dont orphan skbs in mlx4_en_xmit()
>
>    After commit e22979d96a55d (mlx4_en: Moving to Interrupts for TX
>    completions) we no longer need to orphan skbs in mlx4_en_xmit()
>    since skb wont stay a long time in TX ring before their release.
>
>    Orphaning skbs in ndo_start_xmit() should be avoided as much as
>    possible, since it breaks TCP Small Queue or other flow control
>    mechanisms (per socket limits)
>
>    Signed-off-by: Eric Dumazet <edumazet@google.com>
>    Acked-by: Yevgeny Petrilin <yevgenyp@mellanox.com>
>    Cc: Or Gerlitz <ogerlitz@mellanox.com>
>    Signed-off-by: David S. Miller <davem@davemloft.net>
>
>>
>> So yea, it's great if napi and hardware are advanced enough
>> that the default can be changed, since this way virtio
>> is closer to a regular nic and more or standard
>> infrastructure can be used.
>>
>> But dropping it will go against *no breaking userspace* rule.
>> Complicated? Tough.
>
>I don't know what kind of userspace is broken by this. Or why it is
>not broken since the day we enable NAPI mode by default.

There is a module option that explicitly allows user to set
napi_tx=false
or
napi_weight=0

So if you remove this option or ignore it, both breaks the user
expectation. I personally would vote for this breakage. To carry ancient
things like this one forever does not make sense to me. While at it,
let's remove all virtio net module params. Thoughts?



>
>Thanks
>
>>
>> --
>> MST
>>
>
