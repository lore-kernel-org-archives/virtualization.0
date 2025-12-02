Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB01262FF6
	for <virtualization@lists.linux.dev>; Tue,  2 Dec 2025 15:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764689382; cv=none; b=o95KpBJi6+kyPhZC2nwPmJoKc4chXTCkRUV1YRkr00ok7MPpTzppqQ2048ecrQdPu39cjpnTxQP0xng9lMsBG9VemqzO+5NqaasGi7RYeTyJTSYpP5iQ2W6UGE3nnCPrV0YM9k2hcbFRODgg/l0s0SahGDGvZpmOTWDAwBmct9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764689382; c=relaxed/simple;
	bh=BZtIuSYzo4X0vi8zHGDRh1sL+AQ42TCB+JFZn40EQnk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qxON3fBchJ2XhYDTPWAefBAFtoCXJTirDYOGMMHnf6Zz01QQFUWDxAAIHD38wr1JPny0djS1uJHWIXlUAK3lFGgT2IHpBEoM7ojquGW7Ls4bPkS0s2ZKZLF48M3sVx0QriqofiAsnJVUwcnh+VpAqrTWEVzrT5fuprR+QsF4Ies=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HgduA6PS; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HgduA6PS"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-29558061c68so68275435ad.0
        for <virtualization@lists.linux.dev>; Tue, 02 Dec 2025 07:29:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764689381; x=1765294181; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Pm04M8J4HumgMBH0ZuXZAiRY8Gdv9LOi293f7C71dv8=;
        b=HgduA6PS+EGetypVX1eSbOtX3XvK+I0RZJBdUc2azvwYesqIzAXJGub1Cllin+bWEG
         8URYNnA+w8NUfdTzVEVSg3n7sbzbDvg7u14y6s4hn/h+TKDPzGlsvDOrFNSchNrwQzbK
         tZkQXotSUGUCJYLWghN9pFmk4rUNq00N+e9KyCdXeOxo0Z4q75/MCWGonlWCn0TiO9mC
         bhFPPVN5juY+FsOa99AaEG596P5So+U6BD9NN+/F/mPkypqiPPpJpqWxiz+9oyio/1V/
         m1nG6nTubc5sKU9bAOBDnpHPagVzrSF8SivKGGIJzp0hdcfS4Hln10d0ECGctA0AfSKL
         Xwzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764689381; x=1765294181;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pm04M8J4HumgMBH0ZuXZAiRY8Gdv9LOi293f7C71dv8=;
        b=WkW/NrN5/CcjCCANV5/KeBtnBmHj/XitjPS1WFPlBff0DSYCU5rqghcAfaiY5TerES
         OhN/gTS7HEHCNBxSWp1lt9iGgL8PnIEzZjFouNAINlYk6eg3IHli6ZoRkStLrDB+b3vF
         v8PmFzABRo8nq4xzj5I17JX2zBj9f3XK4UoUnz+wTvCXLpse1twaChkLsq63Y/n7kdlP
         UPDPqvKWewHcnHZAenRhFDWN0g8Ym11DVVUtya51vL85KCoejLdxLPsr95fLxxSg9pkK
         OUG379Chkf/0UkJtcHWeKIS0kD+cHAOou8V2tmgE29fw6BySGk1nBFQuwvA+o6S6ij0J
         wreg==
X-Forwarded-Encrypted: i=1; AJvYcCXpGqe1oPg1oqh09FnRIP82gRY7mP3nUHGtsar6T/sIb1z0YC2E5PygHWrjy9oaDLaQSdLFacZK6lUDF7W5cw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwlqdPGFMiB5B4fASH+K1qYtZqm19jG5x7TbMCfhdolxKOs/We8
	/9rSGqu42smuhitqbkni1RzZfDhBNc5cXRYTi02/awyH5/n6XaxPL4cK
X-Gm-Gg: ASbGnctOqrJGbUe6MdTbkXXpsQ9JeWDprApgP5xtr1I+vYAIFyW+CETeokgL0ZkI9i5
	9NsmzSGpo0Nq3MXiwY8hQuByE0/Ck+g7a7tZiDU+gy91sTd3aPQIC+fGHcbPagVjZMRISqEnpgc
	w6zIfZsQAaJ4r4cDC+gDoN3Jh/C8xsO1GNF3YkU//uadsvUXuRvlWXB8GwIOgXqAItpEcbHE8so
	9U6B+6uYCqvPGi+unTJWBjH+LRzAFTfqUDJd3EyVkftXERtPBd+b4tJLLFycuvWJERFBZkZ3f7X
	LF/N/rWvsh/fPBMAV32qhYF3PNnum0dNPD9v+QvwFCvzTkCx+l51LE6cmr8gP8O1ju68N1E6Ec4
	ionMQn0iGcIrDfgVKQvU7LKFb7Xh8ayDWEvz+yTTfh0m4Z5jfZpQvbljKDBp5JNr53MjatfycmF
	mUM67tr4W/0Vcy7Itbx8i9u5fWZ8uSJFInmyO/VJnp7ciuKeXYcecoZ25k78o=
X-Google-Smtp-Source: AGHT+IFXvcfWnNHx250mT23ggaMtDNXUs/Vb5yUhRUZMPaS6sYLlPPubZ17O0Xp1IrUFreHe7V613g==
X-Received: by 2002:a17:903:320a:b0:29a:5ce:b467 with SMTP id d9443c01a7336-29b6bf9e98amr470449935ad.54.1764689380670;
        Tue, 02 Dec 2025 07:29:40 -0800 (PST)
Received: from ?IPV6:2001:ee0:4f4c:210:48c5:4372:8d4:ac0b? ([2001:ee0:4f4c:210:48c5:4372:8d4:ac0b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29bce40ab6bsm157212555ad.21.2025.12.02.07.29.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Dec 2025 07:29:40 -0800 (PST)
Message-ID: <faad67c7-8b25-4516-ab37-3b154ee4d0cf@gmail.com>
Date: Tue, 2 Dec 2025 22:29:32 +0700
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] virtio_net: gate delayed refill scheduling
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, virtualization@lists.linux.dev,
 netdev@vger.kernel.org, bpf@vger.kernel.org
References: <40af2b73239850e7bf1a81abb71ee99f1b563b9c.1764226734.git.mst@redhat.com>
 <a61dc7ee-d00b-41b4-b6fd-8a5152c3eae3@gmail.com>
 <CACGkMEuJFVUDQ7SKt93mCVkbDHxK+A74Bs9URpdGR+0mtjxmAg@mail.gmail.com>
 <a9718b11-76d5-4228-9256-6a4dee90c302@gmail.com>
 <CACGkMEvFzYiRNxMdJ9xNPcZmotY-9pD+bfF4BD5z+HnaAt1zug@mail.gmail.com>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <CACGkMEvFzYiRNxMdJ9xNPcZmotY-9pD+bfF4BD5z+HnaAt1zug@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/2/25 13:03, Jason Wang wrote:
> On Mon, Dec 1, 2025 at 11:04 PM Bui Quang Minh <minhquangbui99@gmail.com> wrote:
>> On 11/28/25 09:20, Jason Wang wrote:
>>> On Fri, Nov 28, 2025 at 1:47 AM Bui Quang Minh <minhquangbui99@gmail.com> wrote:
>>>> I think the the requeue in refill_work is not the problem here. In
>>>> virtnet_rx_pause[_all](), we use cancel_work_sync() which is safe to
>>>> use "even if the work re-queues itself". AFAICS, cancel_work_sync()
>>>> will disable work -> flush work -> enable again. So if the work requeue
>>>> itself in flush work, the requeue will fail because the work is already
>>>> disabled.
>>> Right.
>>>
>>>> I think what triggers the deadlock here is a bug in
>>>> virtnet_rx_resume_all(). virtnet_rx_resume_all() calls to
>>>> __virtnet_rx_resume() which calls napi_enable() and may schedule
>>>> refill. It schedules the refill work right after napi_enable the first
>>>> receive queue. The correct way must be napi_enable all receive queues
>>>> before scheduling refill work.
>>> So what you meant is that the napi_disable() is called for a queue
>>> whose NAPI has been disabled?
>>>
>>> cpu0] enable_delayed_refill()
>>> cpu0] napi_enable(queue0)
>>> cpu0] schedule_delayed_work(&vi->refill)
>>> cpu1] napi_disable(queue0)
>>> cpu1] napi_enable(queue0)
>>> cpu1] napi_disable(queue1)
>>>
>>> In this case cpu1 waits forever while holding the netdev lock. This
>>> looks like a bug since the netdev_lock 413f0271f3966 ("net: protect
>>> NAPI enablement with netdev_lock()")?
>> Yes, I've tried to fix it in 4bc12818b363 ("virtio-net: disable delayed
>> refill when pausing rx"), but it has flaws.
> I wonder if a simplified version is just restoring the behaviour
> before 413f0271f3966 by using napi_enable_locked() but maybe I miss
> something.

As far as I understand, before 413f0271f3966 ("net: protect NAPI 
enablement with netdev_lock()"), the napi is protected by the 
rtnl_lock(). But in the refill_work, we don't acquire the rtnl_lock(), 
so it seems like we will have race condition before 413f0271f3966 ("net: 
protect NAPI enablement with netdev_lock()").

Thanks,
Quang Minh.
