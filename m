Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5397733CE86
	for <virtualization@lists.linux.dev>; Fri,  8 May 2026 10:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778235113; cv=none; b=fGcZto1Npc/okGxymyKjuYhkYnWPHJ9rFhfJ378ka+goVG5Vv7Qc0xaMpo8ScrHMqZpSidV7g2DgAim2E8Lvgq8RxDw+EHcO6esxtQ2+YQnV7p95w4XZGUJ9bb/twHZqZElIoWrTiwwmh76TrF8Tjzopb+aOhneozwFE2ItFhB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778235113; c=relaxed/simple;
	bh=5elEoYj/5z4XlNxRebDQfE/NWKivBbNLq4gq+S9kA1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=mDebWZN4rf64I+CEuLy0vPNRE0WM1EW8+0poFVeDMvMzexXf7gD/5Sw+HUaNmafK7rNw9Gqq4lDXsi9CDcuqv/OVPC5t/lsSZ+KlDgyzOta9PL1HQCD+KtoW3oxeOhK5qY+6YOUJXjguToe3JHFPVoE3K8FCsNqTPvDowtn8rTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gWJpfyht; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gWJpfyht"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778235111;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fa/C2+f55nR6HMXUZTO/HqGU3IIvZs20T/G6LNckFSc=;
	b=gWJpfyhtTQFeZzNIpL4eqbEsrsbK957PfSj5S4zoaxWlN5OTeYnAS2HPdVszzzilTkWNw5
	8cmT1/6pG7PSVej4lmCNtHYC0bI+wfm0P4YDmBCPSFBmCuW9FSvdIaTY2LD3MbtE7RqPRQ
	XMFzhjwNDVGqU5zFb2zTbjhDKnYdXGg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-411-b7eidqjQOciy-KSjcqQiSg-1; Fri, 08 May 2026 06:11:50 -0400
X-MC-Unique: b7eidqjQOciy-KSjcqQiSg-1
X-Mimecast-MFC-AGG-ID: b7eidqjQOciy-KSjcqQiSg_1778235109
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-48d035e8593so10820195e9.0
        for <virtualization@lists.linux.dev>; Fri, 08 May 2026 03:11:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778235109; x=1778839909;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fa/C2+f55nR6HMXUZTO/HqGU3IIvZs20T/G6LNckFSc=;
        b=cKITTXOY17G4Iy1G0XU6TkaJz1+nB1vegXs7cTuzegiBXekKZO7lA8e29JxUl85iTO
         qUXjqy7tIQ/FgtfQCF1YY1ipXdLcBdzHoNtlyB6rGMbqyzW6Ak9zF/ZV7CMG3xkD/HTp
         z4dnDd5O3SYAKhAV8f+1yh/nSp29pjbg5MMFyXMB6rwx7dBL/U16y2m/TFXmSy5AhIFE
         ykGKPConi/CPWYuOgvCknMsdF8Ax/c/kig404ohWbSnfpxQR+h9WEF/rJlIwyipu3cl0
         WnBKn0pybTPruGX4GttS2d7qhT67QJsSbi9tkM2YuD5BQHq9sBmahfz641fajsJhKc3l
         CWEw==
X-Forwarded-Encrypted: i=1; AFNElJ9VjM1AuIr6Qickyowb8557mnANCjZ5NRuOANzmtXJd0bWcXzzz4hB5C1ahUIBk4/nXaUpC8gAnyraAGhOfZQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw02Ds9aSK07nrn45xYT5DHoCCP0HKkX2hvQixWcnfHZziDZb+X
	InYewb44aF61V8qZisPLpJukM1SO8H9RS/WilVXeNN4hdZK2cmX5oFBQ7+l2NpS4kjEf/CT8dBQ
	CrDLyOmu3Pe8MlPuOemcj/04KHofUMN38NIWCzqhc3psjC4kyUGhiuaVnWNT6k8N9KDWI
X-Gm-Gg: AeBDievw0D+IxxWQ1oIDoSU+ycKg0R5g8OuDj8orr7tbfGkn+hLxgXUxoh5VGw4sd5e
	yjiDdl6KidUNKC4DhRfd4rmyETfUnqf4nnvi52wOz1RTu7UG3PyVBd6ZKSUlWilipd17Wdaw67G
	EsApgxc03hYm9YYikQzx8v1y5Aby9xbr/WEWLE9NjcxcBTXn/+EJciJvD7JbhY1+jJuaxHYg8qV
	yLeowCMCnLih4++oXTGB8OLZEcL/9MHzgqL/6KjCbKHDwwSgYZ9pDmOStOAq1hFtboh9ES4sa0F
	i4ZM9R4ucYl/raaKxbUga9Sm3Lue6zjSaki0MDiF5R9pGRIR/2+HV8cSNPsQ61wjjfGdTKE65m/
	Al/dBno5q9Xccnc+6oCKc3YB1VWnMyEWnrx5DofTtJFqtJnmtHfRqJnTYF4xXKO8=
X-Received: by 2002:a05:600d:8:b0:48a:58ae:993b with SMTP id 5b1f17b1804b1-48e676a4e03mr30602905e9.16.1778235108728;
        Fri, 08 May 2026 03:11:48 -0700 (PDT)
X-Received: by 2002:a05:600d:8:b0:48a:58ae:993b with SMTP id 5b1f17b1804b1-48e676a4e03mr30602315e9.16.1778235108187;
        Fri, 08 May 2026 03:11:48 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-2.retail.telecomitalia.it. [87.11.6.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4548e6a6470sm2848938f8f.7.2026.05.08.03.11.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 03:11:47 -0700 (PDT)
Date: Fri, 8 May 2026 12:11:42 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Eric Dumazet <edumazet@google.com>, 
	Arseniy Krasnov <avkrasnov@salutedevices.com>, Bobby Eshleman <bobbyeshleman@meta.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Arseniy Krasnov <AVKrasnov@sberdevices.ru>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH net] vsock/virtio: fix potential unbounded skb queue
Message-ID: <af21ZGlANY6UUCKx@sgarzare-redhat>
References: <afn0ZdvZWswBuDMm@sgarzare-redhat>
 <CANn89iLs8DOWJwDpf_ARoMrV+6b2tbhEJ=VVzeC8gCm5dRGaig@mail.gmail.com>
 <afoF_cHfl6ygcupM@sgarzare-redhat>
 <20260506113554-mutt-send-email-mst@kernel.org>
 <afxVH2So9BbZ3Gta@sgarzare-redhat>
 <20260507074113-mutt-send-email-mst@kernel.org>
 <afyMCyBvZpzWrLtO@sgarzare-redhat>
 <20260507163710-mutt-send-email-mst@kernel.org>
 <af2sXvVCBT05XF0D@sgarzare-redhat>
 <20260508055343-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260508055343-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: z3cwkzxOryCHAdTsB7fbsh3xQNJdmyrFvKTaVjqyiWg_1778235109
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Fri, May 08, 2026 at 05:58:06AM -0400, Michael S. Tsirkin wrote:
>On Fri, May 08, 2026 at 11:41:21AM +0200, Stefano Garzarella wrote:
>> On Thu, May 07, 2026 at 06:48:47PM -0400, Michael S. Tsirkin wrote:
>> > On Thu, May 07, 2026 at 02:59:13PM +0200, Stefano Garzarella wrote:
>> > > On Thu, May 07, 2026 at 07:45:10AM -0400, Michael S. Tsirkin wrote:
>> > > > On Thu, May 07, 2026 at 11:09:47AM +0200, Stefano Garzarella wrote:
>>
>> [...]
>>
>> > > > > For now, we're already doing something:
>> > > > > merging the skuffs if they don't have EOM set.
>> > > >
>> > > >
>> > > > Right that's good. You could go further and merge with EOM too
>> > > > if you stick the info about message boundaries somewhere else.
>> > >
>> > > This adds a lot of complexity IMO, but we can try.
>> > >
>> > > Do you have something in mind?
>> >
>> > BER is clearly overkill but here's a POC that claude made for me,
>> > just to give u an idea. It's clearly has a ton of issues,
>> > for example I dislike how GFP_ATOMIC is handled.
>>
>> Okay, I somewhat understand, but clearly this isn't net material
>
>I doubt we have many other options given reverting the regression was
>ruled out.

As Eric pointed out, we can't revert it.

>
>
>> so for now
>> I think the best thing to do is to merge the fixup I sent (or something
>> similar):
>> https://lore.kernel.org/netdev/20260508092330.69690-1-sgarzare@redhat.com/
>
>I reviewed that one, problem is it's a spec violation/change that we'll
>have to support forever.

I have a few points to make on this, but let's discuss them there.

>
>> This is a major change that should be merged with more caution.
>> Could this have too much of an impact on performance?
>>
>> Thanks,
>> Stefano
>
>It's really a POC, real patch is left as an excersise for the reader 
>:).

eheh, I see, but honestly, this overcomplication scares me. I'll try to 
think it over.

>The correct approach IMHO is to only start using this
>when we wasted a lot of memory on small packets.
>
>For example, if sum(truesize) >= buf size.
>
>then we'll not see a perf impact unless it's already pathological.

Agree on this, which is similar to what I'm doing in that patch.  
Reducing the advertised buf_alloc only in pathological cases (e.g.  
overhead > buf_alloc).

Stefano

