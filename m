Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CE939FD9
	for <virtualization@lists.linux.dev>; Wed, 20 Mar 2024 12:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710937438; cv=none; b=jFMk74e8DCjwvaT96OWYwnjezAMp+vKwHUJxu6u053crk79eznqNmQai6JSMRofYDx7S9e/n91K1Q9RZ9Nq1uUxYcawO8QETMj3YG4T9QMD7SSx4EJ3Jtz6f3V15wGvaJM7NkL7Db6znYlS9Dw/wOY9JS81LFnMJrQA3LghLWd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710937438; c=relaxed/simple;
	bh=256hIVOWqKGNs0clZdEecQjT2nDPiAh+uHQB0f0lp0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TmysAwBYLQslCncG6LUYr0zXHzP2hjAVMzPNhzO7hHq2Kxfn2Gbug4L/5djxfsbDvOSa8+eWsOiCLGlpjtZWd2edRBH4h1RcnRYXGvs+5xBr9rpYrlM/956IZmd7mV2M2CPRSZ33mleO+37nQVfGK/V1nsd1eIKnSHK/zNdv/sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=d4h3HlFX; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="d4h3HlFX"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4146d750dcdso2730595e9.1
        for <virtualization@lists.linux.dev>; Wed, 20 Mar 2024 05:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1710937433; x=1711542233; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=256hIVOWqKGNs0clZdEecQjT2nDPiAh+uHQB0f0lp0s=;
        b=d4h3HlFXdOVo0L2WE82OiiCriz2121FooNmGgrwnIDktuyvcn0cg8lZQ9Qs9mpUlIO
         Hrr+2crsD824NYTKD1BoHZZcfrfHI4yPxi1uSEz5zXNucQnnVs5jO1od0lKBMgm38MXN
         6rbCefl4GC2N0TKLFJfEBOapTjEFMP1F+Jg065kK9RweeBNx/UKvP5wSlc7IDWjKT71m
         2Yw24d7wfLEf0oy/B40IknlvoUgAgVEsSHQJjIhK5YVHs/a8ijCy78+EW6IsjNL4Xbrv
         sk3lhHPP35ptokwWztGj27y6D90VxiJ83B1zv+sz/5yuqeINxaR6xTjoC84ckbwzGF9S
         lESQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710937433; x=1711542233;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=256hIVOWqKGNs0clZdEecQjT2nDPiAh+uHQB0f0lp0s=;
        b=iJNrvTaY3p2V2+/O2E7MRWmOvVNzYOCO/iBGVSDSfzxDVFh3KTlCBRatnHvYmARVYt
         BtnEN3qKX2niOm4wwDteLlNUoeOM92Xya2aDUZWju21pHeCZnGGAIdxlk6hV9eeA8F61
         vXgRfusUYNkqPnYzoPZNPKnzfBViA7vVdC49t0Pdt4oJ8H739SgNFiw+HA2Yfb0v9+RN
         KTz0pku/ZwfkTCz5XG2fWqUWEzxnZNrUcj/J8GcOs/+fDDdoypzevmHxBBKpq2kPi3ao
         ZSCnPI67UrY/t3SXz9YIZcRClJPME40GVkt5ewk5ZlEEN9imQLkEmixEGz2ZHBSvFNx+
         5owg==
X-Forwarded-Encrypted: i=1; AJvYcCWSN+U/D2Sj/dpvYJr1y11uVP0Y8CFAOVE/w+r0BQj32ZVKwmeRtRJ1r5DGd/gUWayH3fkljhJkdr8ZbvomQnI9O30QV3p6R7TT/A5XtG8=
X-Gm-Message-State: AOJu0YxIWKwAHgrQ8jlBPIVVeFdqa/ym0OOtI+SJk49X0xi7nQtyF/1W
	gy94m1wG4pC96vHoeErWp3B+ouuVMpwnNaRMGOpxL0afaiHn4w9vtbafb4/PvBs=
X-Google-Smtp-Source: AGHT+IEeP+QulfChhn2oDlevD/cXp00IH9MWfPkU71hEwGa+tm6JDBn0nfQzXtMpTmqHCqJzlI6TMw==
X-Received: by 2002:a7b:cbd0:0:b0:414:6467:d8e9 with SMTP id n16-20020a7bcbd0000000b004146467d8e9mr2347163wmi.17.1710937433216;
        Wed, 20 Mar 2024 05:23:53 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id z20-20020a05600c0a1400b004146c80ade5sm1725802wmp.12.2024.03.20.05.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 05:23:52 -0700 (PDT)
Date: Wed, 20 Mar 2024 13:23:48 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"Michael  S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@google.com>,
	Amritha Nambiar <amritha.nambiar@intel.com>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	virtualization@lists.linux.dev, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v5 0/9] virtio-net: support device stats
Message-ID: <ZfrVVGUG5rGZxjRx@nanopsycho>
References: <20240318110602.37166-1-xuanzhuo@linux.alibaba.com>
 <Zfgq8k2Q-olYWiuw@nanopsycho>
 <1710762818.1520293-1-xuanzhuo@linux.alibaba.com>
 <ZfgxSug4sekWGyNd@nanopsycho>
 <316ea06417279a45d2d54bf4cc4afd2d775b419a.camel@redhat.com>
 <1710921861.9268863-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1710921861.9268863-1-xuanzhuo@linux.alibaba.com>

Wed, Mar 20, 2024 at 09:04:21AM CET, xuanzhuo@linux.alibaba.com wrote:
>On Tue, 19 Mar 2024 11:12:23 +0100, Paolo Abeni <pabeni@redhat.com> wrote:
>> On Mon, 2024-03-18 at 13:19 +0100, Jiri Pirko wrote:
>> > Mon, Mar 18, 2024 at 12:53:38PM CET, xuanzhuo@linux.alibaba.com wrote:
>> > > On Mon, 18 Mar 2024 12:52:18 +0100, Jiri Pirko <jiri@resnulli.us> wrote:
>> > > > Mon, Mar 18, 2024 at 12:05:53PM CET, xuanzhuo@linux.alibaba.com wrote:
>> > > > > As the spec:
>> > > > >
>> > > > > https://github.com/oasis-tcs/virtio-spec/commit/42f389989823039724f95bbbd243291ab0064f82
>> > > > >
>> > > > > The virtio net supports to get device stats.
>> > > > >
>> > > > > Please review.
>> > > >
>> > > > net-next is closed. Please resubmit next week.
>> > >
>> > >
>> > > For review.
>> >
>> > RFC, or wait.
>>
>> @Xuan, please note that you received exactly the same feedback on your
>> previous submission, a few days ago. While I do understand the legit
>> interest in reviews, ignoring explicit feedback tend to bring no
>> feedback at all.
>
>Sorry.
>
>I have a question regarding the workflow for feature discussions. If we
>consistently engage in discussions about a particular feature, this may result
>in the submission of multiple patch sets. In light of this, should we modify the
>usage of "PATCH" or "RFC" in our submissions depending on whether the merge

No, just wait 2 weeks, simple.


>window is open or closed? This causes the title of our patch sets to keep
>changing.
>
>Or I miss something.
>
>
>Thanks.
>
>
>>
>> Paolo
>>
