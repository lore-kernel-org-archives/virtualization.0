Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1700F19067E
	for <virtualization@lists.linux.dev>; Fri,  7 Jun 2024 11:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717759842; cv=none; b=FiW52CYKjiu8IGZjejM+C5o32WnCpwnOLsyAJp8YQEQgpRFJ+BLzSaU9HlxHkOiSzXlIZMPHQSyqrK3Hf9a303yCsxlmwzV7A0GhbPibvy1RMXTzZk4FIiquFHQ9OVK5PW+QQbWsCT5Mc5/tVqSTd5csmJ65EGeo+SOerLxRyEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717759842; c=relaxed/simple;
	bh=/GkQzN0Yw4pM8zJN92jqJL3nkLY2pjxmco0QKYcFhLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LpCzXzTnUDNDFz7aavFqlydZ2KwSjWGswcohQlD8DyQAyxYchWtQxfsDbPTHFsuJdmY8TD5c7cWqrE5yxS4IaZbppE5qruNLnd7BtBpU4uN4Qwgf6WGE09YKeqUedotKPiK8bUhHIS1v7diXko52P4+hCl22p5czkztshjzeixg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=Q66ahV3C; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="Q66ahV3C"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-421396e3918so24282585e9.0
        for <virtualization@lists.linux.dev>; Fri, 07 Jun 2024 04:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1717759838; x=1718364638; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wOXwqQ83h5Kg+N5Bh2pU7Ruq3Lq9iEdcIxS2DbZLb2E=;
        b=Q66ahV3C9gUstViJ4yEIK1UhjRNpJt9EEiFiXdAojldWzLGtVP7Nd1kcSBDFlKg6F8
         nJ/xknUmDozXhurA+6lUcyO7KaKZbKPyPXV5tq+yLJNReXls2ecob0eKL30gilI8xvIv
         mHtDxmyh2KxJtqoxWcSTpR4Nlz2h8S9n/ttfLnfT1xzYdiwusKM4OdsTX6A0uA9d58Ac
         XDhPxbiNzjXXaYHKoSsthVP7oe3BY/H0SbkEWc0C5mLJg7XC5KdNG81P752hU1UUWtnB
         Nf2YRGMNpAssz/aAETDPvOK3WGXrr2AjN+JPUvDmlvsZN+6PyFO4IdZm4pJgALNpA3o7
         A4IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717759838; x=1718364638;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wOXwqQ83h5Kg+N5Bh2pU7Ruq3Lq9iEdcIxS2DbZLb2E=;
        b=GASerMxH/orFEpNXU6FN7UdClGW7vxa0W5cCMv0BOqBtJ85JS0KXj7Kmfj+kxH+aPE
         H8Y9xgTQJSJ9B6KYApjfYu0ryknPbnC39QigoU9XyuimT1Aphq16XfjK2WQOkfzVJqot
         HGhYlxMbsAcFNl3xePyf5zjPf1D0RucNF+AchnOJEaz90buC3cF2+WfqgVBmEReQhoA9
         eV0/wn2e0kZRg+wNXH/9LYNoYxproqzo5SNx9Jo+iXvDNtq5fa03BmCiRBJse6L8WQgT
         l/Z6rVriTYcvub2ArSW3hbzKnE4gaYWnQGzsUysw+um5lvaw+O/uJzggCohBvJ/LyAHb
         0GcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKQ954L+XGVW2dPyKnf77HThzJ0VZMQLpWpCLWeX6ihvuvLmrdhbL13b8+mpBR3+FL0Dc7VEPthzFvEjxmMswnnUIO5FdNea4KZ9ig1Nk=
X-Gm-Message-State: AOJu0YwYs9iAijbfF5rJa/o3GgNdEHw42AGPjzQYm2nZWlGZ2YVOe1f+
	MQA0gkA6zkbI5YvuuknKYskxxH8TGZMmKfU9tna9m2PRjXvaMwPfKgSlitklnGY=
X-Google-Smtp-Source: AGHT+IE8lHafUaMDrYxlZG0COcQKoeOCBgEik35FcvgH6ReHvmbxC5vBjEJQu48X0kNcnKp7Om5Chw==
X-Received: by 2002:a05:6000:180d:b0:354:e0f0:2943 with SMTP id ffacd0b85a97d-35efed617f0mr2186873f8f.37.1717759837884;
        Fri, 07 Jun 2024 04:30:37 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35ef5fc0f29sm3833277f8f.105.2024.06.07.04.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 04:30:37 -0700 (PDT)
Date: Fri, 7 Jun 2024 13:30:34 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Heng Qi <hengqi@linux.alibaba.com>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev,
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
	john.fastabend@gmail.com, netdev@vger.kernel.org
Subject: Re: [patch net-next] virtio_net: add support for Byte Queue Limits
Message-ID: <ZmLvWnzUBwgpbyeh@nanopsycho.orion>
References: <CAL+tcoB8y6ctDO4Ph8WM-19qAoNMcYTVWLKRqsJYYrmW9q41=w@mail.gmail.com>
 <CACGkMEvh6nKfFMp5fb6tbijrs88vgSofCNkwN1UzKHnf6RqURg@mail.gmail.com>
 <20240606020248-mutt-send-email-mst@kernel.org>
 <CACGkMEsy37mg-GwRXJNBBkvhEuaEYw-g3wthv_XS7+t5=ALhiA@mail.gmail.com>
 <ZmG9YWUcaW4S94Eq@nanopsycho.orion>
 <CACGkMEug18UTJ4HDB+E4-U84UnhyrY-P5kW4et5tnS9E7Pq2Gw@mail.gmail.com>
 <ZmKrGBLiNvDVKL2Z@nanopsycho.orion>
 <CACGkMEvQ04NBUBwrc9AyvLqskSbQ_4OBUK=B9a+iktLcPLeyrg@mail.gmail.com>
 <ZmLZkVML2a3mT2Hh@nanopsycho.orion>
 <20240607062231-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607062231-mutt-send-email-mst@kernel.org>

Fri, Jun 07, 2024 at 12:23:37PM CEST, mst@redhat.com wrote:
>On Fri, Jun 07, 2024 at 11:57:37AM +0200, Jiri Pirko wrote:
>> >True. Personally, I would like to just drop orphan mode. But I'm not
>> >sure others are happy with this.
>> 
>> How about to do it other way around. I will take a stab at sending patch
>> removing it. If anyone is against and has solid data to prove orphan
>> mode is needed, let them provide those.
>
>Break it with no warning and see if anyone complains?

This is now what I suggested at all.

>No, this is not how we handle userspace compatibility, normally.

Sure.

Again:

I would send orphan removal patch containing:
1) no module options removal. Warn if someone sets it up
2) module option to disable napi is ignored
3) orphan mode is removed from code

There is no breakage. Only, hypotetically performance downgrade in some
hypotetical usecase nobody knows of. My point was, if someone presents
solid data to prove orphan is needed during the patch review, let's toss
out the patch.

Makes sense?


>
>-- 
>MST
>
