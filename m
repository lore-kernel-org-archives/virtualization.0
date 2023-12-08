Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71B61A732
	for <virtualization@lists.linux.dev>; Fri,  8 Dec 2023 10:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cOexIkcr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702031486;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Tcu3WmbH0rDpAmwPqLlBrIXFmcIviRa8i1AFTtWd1Zs=;
	b=cOexIkcrsNZ589DDTxh3gqIixiNNnP8xZE8+B6motvcNQXDndK2I1SR5fFdBmJ6ybZ6CuJ
	i1akEtL/YYuLE4MhUbOys7qr1tjSk1fdFmV2cNwDkMMqG5O9ZhjLMv2HXP3FM5x4GZgb8W
	oLn11H78pl5gUO6HkzHXj45U0Qe+q7E=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-342-nsWh0d8fN2KZl--gnjnJlQ-1; Fri, 08 Dec 2023 05:31:25 -0500
X-MC-Unique: nsWh0d8fN2KZl--gnjnJlQ-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2ca0cf1b72aso13522481fa.2
        for <virtualization@lists.linux.dev>; Fri, 08 Dec 2023 02:31:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702031483; x=1702636283;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tcu3WmbH0rDpAmwPqLlBrIXFmcIviRa8i1AFTtWd1Zs=;
        b=v6C5qe0+ldrMlbi01537N7wd7ADhjiRDw24/lQJFZRp5lAUi/g0KJsAYhuuIkR/vhp
         Ngtv9wN/7URiYwF2dt9HaJ3m6L/YZT7iAyf4Fdwd2pvMJ8sZepIks/biQkbrCamLL9Nc
         i+uXtrqsRUPF4punOHSpyClunqaP7HVRPC9UzpoJTFP66QxeB634mcRel+wwPv5eZrMn
         zlzW6Ct6ezllrIH12OS5S4eGgvH5v+1B3fhhVMe+8POm8pGPV9qRXh9S97XM6X0MraRX
         1Mekt0GeB4oIad0eNfYMX5gU5b4IBh8TPD8nK838SKK2NEWDQvLlWfWDsfIdQ4jNsPcf
         1iEQ==
X-Gm-Message-State: AOJu0YzLHU5L3KdjCcWH4WpvV/ObR1YGTbDGbHgKnQOmtSqv2GnagNT3
	4+dZCVNsbNlQIqeWIb+bRClh/1hrizTNFQ+CfrgnHJHZSPZyHaNVDntZlbnEmMCQc6kYEJ2kdjY
	dCsobiwI3u/2Jv99nR0opgwWORzI=
X-Received: by 2002:a2e:8884:0:b0:2ca:56:778f with SMTP id k4-20020a2e8884000000b002ca0056778fmr1257130lji.48.1702031483564;
        Fri, 08 Dec 2023 02:31:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHKcY1LCS/VjPyEMeTLMNoGPvmPdJg2dsZtFpUis0zp6RJwZ5WMd0CWqzm2EoCROz7SrjQSKA==
X-Received: by 2002:a2e:8884:0:b0:2ca:56:778f with SMTP id k4-20020a2e8884000000b002ca0056778fmr1257123lji.48.1702031483207;
        Fri, 08 Dec 2023 02:31:23 -0800 (PST)
Received: from redhat.com ([2a02:14f:1f0:7466:b10d:58c8:869f:7e91])
        by smtp.gmail.com with ESMTPSA id cu12-20020a170906ba8c00b00a10f3030e11sm829135ejd.1.2023.12.08.02.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 02:31:22 -0800 (PST)
Date: Fri, 8 Dec 2023 05:31:18 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Tobias Huschle <huschle@linux.ibm.com>
Cc: Abel Wu <wuyun.abel@bytedance.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	jasowang@redhat.com
Subject: Re: Re: Re: EEVDF/vhost regression (bisected to 86bfbb7ce4f6
 sched/fair: Add lag based placement)
Message-ID: <20231208052150-mutt-send-email-mst@kernel.org>
References: <ZVdbdSXg4qefTNtg@DESKTOP-2CCOB1S.>
 <20231117123759.GP8262@noisy.programming.kicks-ass.net>
 <46a997c2-5a38-4b60-b589-6073b1fac677@bytedance.com>
 <ZVyt4UU9+XxunIP7@DESKTOP-2CCOB1S.>
 <20231122100016.GO8262@noisy.programming.kicks-ass.net>
 <6564a012.c80a0220.adb78.f0e4SMTPIN_ADDED_BROKEN@mx.google.com>
 <d4110c79-d64f-49bd-9f69-0a94369b5e86@bytedance.com>
 <07513.123120701265800278@us-mta-474.us.mimecast.lan>
 <20231207014626-mutt-send-email-mst@kernel.org>
 <56082.123120804242300177@us-mta-137.us.mimecast.lan>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <56082.123120804242300177@us-mta-137.us.mimecast.lan>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 08, 2023 at 10:24:16AM +0100, Tobias Huschle wrote:
> On Thu, Dec 07, 2023 at 01:48:40AM -0500, Michael S. Tsirkin wrote:
> > On Thu, Dec 07, 2023 at 07:22:12AM +0100, Tobias Huschle wrote:
> > > 3. vhost looping endlessly, waiting for kworker to be scheduled
> > > 
> > > I dug a little deeper on what the vhost is doing. I'm not an expert on
> > > virtio whatsoever, so these are just educated guesses that maybe
> > > someone can verify/correct. Please bear with me probably messing up 
> > > the terminology.
> > > 
> > > - vhost is looping through available queues.
> > > - vhost wants to wake up a kworker to process a found queue.
> > > - kworker does something with that queue and terminates quickly.
> > > 
> > > What I found by throwing in some very noisy trace statements was that,
> > > if the kworker is not woken up, the vhost just keeps looping accross
> > > all available queues (and seems to repeat itself). So it essentially
> > > relies on the scheduler to schedule the kworker fast enough. Otherwise
> > > it will just keep on looping until it is migrated off the CPU.
> > 
> > 
> > Normally it takes the buffers off the queue and is done with it.
> > I am guessing that at the same time guest is running on some other
> > CPU and keeps adding available buffers?
> > 
> 
> It seems to do just that, there are multiple other vhost instances
> involved which might keep filling up thoses queues. 
> 

No vhost is ever only draining queues. Guest is filling them.

> Unfortunately, this makes the problematic vhost instance to stay on
> the CPU and prevents said kworker to get scheduled. The kworker is
> explicitly woken up by vhost, so it wants it to do something.
> 
> At this point it seems that there is an assumption about the scheduler
> in place which is no longer fulfilled by EEVDF. From the discussion so
> far, it seems like EEVDF does what is intended to do.
> 
> Shouldn't there be a more explicit mechanism in use that allows the
> kworker to be scheduled in favor of the vhost?
> 
> It is also concerning that the vhost seems cannot be preempted by the
> scheduler while executing that loop.


Which loop is that, exactly?

-- 
MST

