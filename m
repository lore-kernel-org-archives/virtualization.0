Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521ED149DF6
	for <virtualization@lists.linux.dev>; Tue, 27 Feb 2024 15:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709046440; cv=none; b=KjD0Nmr/2glUkHtwDmF9QPhGd5IIgAYzt4yr+0o5hwbXIknGTn/Q5c+fqsNd9Mm3POj/NtNNJI8d5nxTCPCCB762MwjJgM3OYyQ4LWTdgm+S6zK8Pva88SgNnpXkYRWJCrTcgQ9tOAsQRnusuBLi7tjl0n9xZdN2dGmIlYf0vvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709046440; c=relaxed/simple;
	bh=Us/6713pf16zhZV4QzPkLFnfNT4fVJdkuAUvvs1MWmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p5CuhEGGTbin4qm4E279FImnxbFu+zWjHW42BHF9TtZDkTXhvAjZeW+iAsZk9pVmGAc0aIUy4jh/Q+lE6buTo4nMQgM7QukgiB45r23NRoNTcDj8s4G7FUOj+bpNkogbepQc8xu4FddCEvMtOmn89DiEUAHNTsowIL4m5+WY2Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=PRFC8Scq; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="PRFC8Scq"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d28e465655so27915971fa.0
        for <virtualization@lists.linux.dev>; Tue, 27 Feb 2024 07:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1709046436; x=1709651236; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vulhCN66cUevk5GIGTwNe/HX6DPTkr4nao/EUtWTWuU=;
        b=PRFC8ScqGWh3jslUI/T93hew8N/LF00dJreYKzK+4+OMYDslSya+jYM+SXfqkkyLGA
         iQLF9Y3zjZaszzvR8N9MR10ygZH/XxAVEzKBQVABVf3Pdfk3f64e/bkYM+ae5lSaAJX+
         mzIGlACU2tIsXgZXPe3qBKgXtNLzzfWOsUZhz/R+C1Nu8omA5Vz9yob4RglEUGb8zWah
         HAVD+ud0mmfGsTLU3x5+9R23XlGJOp68urK6ygJM358krBCyDjpqm+LFIyyVT+0Omo+O
         4N1/p016eG7AnawLeJe79HWyRFGQbC4X+C1i1vZAc1Qiho9Fz/L1m4BR7Ea/eo5oZPJi
         dtCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709046436; x=1709651236;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vulhCN66cUevk5GIGTwNe/HX6DPTkr4nao/EUtWTWuU=;
        b=P+SWx/sJAzms/71YKU8lniV6XK2mxk4XTsWxlnk5sgqhk3iHUvnsopQim73xN/GOM9
         o0XXnOFGpiyb2mW2mEC+V93IzLSlBqFKdIqVHRvK4M2zT7F7CO3gk9NagqeCBTElKF0q
         1fy5QsTSyvwA5lUkgKqwRSBVMpvZ6Yf18718q2lVZrbD1o8RHabYMdy6n86qzXOPRfqN
         pDOsDBaq3mCFJ1fP2ulVdsiRpdTG+2MYSRiixWNc9fz/MP17MLRVmyCs1fd6roQhc+5/
         OXdt2tqFnZ8G0AXkde6ZGHPnnk0a/K2rJms8OvNfJO8Wev5VqMQnLKj7xeVysFYCUHyV
         AeGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWeNFeekEGnC2kggXzQbGxaCUr+BMeFrxvvodynSRzraR6Os1zseAKqaTAjxKDM7rAwqTyAUfHkdY21NbG8aai2SyQ8jpDBEioc80MRd8k=
X-Gm-Message-State: AOJu0YyqSXGWuX28trvkU1A2yvl6qTpsXB1paQXWoWsg6SJ6oE6mnkDH
	lARYbKDS7GtCeL4YncZxXMOp3BDG9USafO8nDHkv8/xPTeM1H+o0bQi/GcRsQZQ=
X-Google-Smtp-Source: AGHT+IFnDvQHsuJdoXosr32631j+ALSCHrOiQqDmyqkWzGENLMhHb/ghivWR+AmQzLLdV629cF3S2g==
X-Received: by 2002:a2e:91d4:0:b0:2d2:4450:92 with SMTP id u20-20020a2e91d4000000b002d244500092mr6113926ljg.20.1709046436426;
        Tue, 27 Feb 2024 07:07:16 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id jl20-20020a05600c6a9400b004126101915esm15277513wmb.4.2024.02.27.07.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 07:07:15 -0800 (PST)
Date: Tue, 27 Feb 2024 16:07:13 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev
Subject: Re: [PATCH net-next v3 5/6] virtio_net: add the total stats field
Message-ID: <Zd36oZMvIvqtNSzr@nanopsycho>
References: <20240227080303.63894-1-xuanzhuo@linux.alibaba.com>
 <20240227080303.63894-6-xuanzhuo@linux.alibaba.com>
 <20240227065424.2548eccd@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227065424.2548eccd@kernel.org>

Tue, Feb 27, 2024 at 03:54:24PM CET, kuba@kernel.org wrote:
>On Tue, 27 Feb 2024 16:03:02 +0800 Xuan Zhuo wrote:
>> Now, we just show the stats of every queue.
>> 
>> But for the user, the total values of every stat may are valuable.
>
>Please wait for this API to get merged:
>https://lore.kernel.org/all/20240226211015.1244807-1-kuba@kernel.org/
>A lot of the stats you're adding here can go into the new API.

Can. But does that mean that ethtool additions of things like this
will be rejected after that?


>More drivers can report things like number of LSO / GRO packets.
>
