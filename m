Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5587B1DE8A8
	for <virtualization@lists.linux.dev>; Wed,  9 Apr 2025 06:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744181057; cv=none; b=ICLy5OKTvE6s3XKCvQM8ExBDYteX6FZJSFBWWsl9Vr+fPF7FAV7VG2XEirRcrPATsj3awJFsJT4WgGDS7Df/H5IocsFPphPjURVkVRfiBl92047vg6FEmZOlsmIoV1PpOr/z7zcGIQ2F8rCwdwFvCc6QQcNDknMc0K+HeBLIm7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744181057; c=relaxed/simple;
	bh=EA2abmK970vc5VUSwknSZAbpfozmiJ2WLu2yC0Rm9Q8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G+iBxptMY39zla1sf2g0IDBWeQgpOFpQu2ZPZp07f7t30NzaZav4WfRL88zk5nIBod8Qrlh6nFtBq/K69rJcsriI7S1C0oAW67SPLKqz/lZT8Oi+C7hGzj/BhylPjUdJ8DixsP9Ry6DI77CuT8XzFprg1JRKTkwxgIoAe9bqrM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i+BMAEye; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i+BMAEye"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-af5139ad9a2so4329552a12.1
        for <virtualization@lists.linux.dev>; Tue, 08 Apr 2025 23:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744181055; x=1744785855; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zFnPHqAViJTArLLnMbNb1yqvVoshG4R2mnj5u2i0toE=;
        b=i+BMAEye/usBkYugtA8J7QHr/r2mVIlcnZnT2UyxU3F9s4U71JHhOuOfiJU5Zqj4MV
         6CaOpVeLAxA5scQaGCqU6ACxgTTgZKBYm6fX3rKf/9pKx4LaOzuQsMpDnBAumuLeuqsi
         IQmLNJLxQXhEmrlKIjTHUBgJHLLuANGyGJNhAQL4lFLbkIjrcKfi8NWhmd3kO9nxQq9Q
         uP1gXwyu7gpGrrPrJcVPcWLxobm8GbjeaSrZ0B7S/fBiRfOcljMGm19X61kK5RRILOqk
         TTGgDZeM58Pb6pCjVrJ/oDubSk2G01Eu2uQJsGnVHNqp8soMyDzYBBRHJuLmBVWrNs3C
         aI5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744181055; x=1744785855;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zFnPHqAViJTArLLnMbNb1yqvVoshG4R2mnj5u2i0toE=;
        b=AsqFaS85a4vm9zGgeA7IUvw7Y8B72kwDI+cvtQr5/Z3eTEDAhDADYQW250kJtyFqDT
         xXB/x81zLjBHT/EXpiwc5hgSBFmIb22ViNUrrK7DB6luvWgjfhpB7Zz5maatI8i2ZRwl
         rLLUIHtuX/esV8RO4WeQvZldpZBE6qnJN+YpG+rimFadQ96eHEDEW4hfIiGazKTOWhUp
         f/jtbShTxo4VL/0DIqMIh48bCxH72Kc8HsN8hP8eWVRsRdEt4uNwB1QT++PVcVMBOxCt
         rBFU4rmwDzi46DzR112DHlbEg4SRNXxNZKliGKVSYT5sXJwuc8eeRmg2344v3GKgy4Q9
         NpIA==
X-Forwarded-Encrypted: i=1; AJvYcCXmXstYFrJesW9Vx7ZNsXzCgJjQ6j3cpZGp4TkQY3YopwOUZJtmst3ch00XbqD7K6snaDkrcJXooImurHNc3w==@lists.linux.dev
X-Gm-Message-State: AOJu0YzDd++NQAJP8WL41DIjhN9NAXAWG4gT/cv/ZzNWQ6aZmJVeHH5O
	rb9TvSwtMewMjGsqnsAygfqGq6VmCYlstaQbdj9EU2GPCaawIewy
X-Gm-Gg: ASbGnctR3yh91BvFtGICTCTle/ZnFGBKFFRcKiMyVeDgih4pERD/zqdCSk3BGzBdmZc
	wv+xFjBe2V6+VC0fKeERznAIFKbKMn97PFprmHTHL5gB/89g6VvHoaeAIjs9mVsSLN8TXQGkp22
	Wd9xYONcC2GFBX9Zf1g29ANnVQVKYmpy3yIBJLbURVy4zbk5kipFbS5gh4bpDz/68eoePPE7MW5
	6QjkFD2GLnSGZ8BKKyODPXv5RB1UtkJHYaGN9rGO4Vg3jBBRnb2KX+oPEDK9rbVQAb8oB97tLeK
	k3Ad73t+4EYsjK/KOWT2slnegAPzqjLinpk0E+lDhA5qpxDUIA==
X-Google-Smtp-Source: AGHT+IFEFBrVdU4Z60J6u9c77Kly+wSwU0+rEdmF+faACzLEkBXEARmQGsGuz7F6mtlkCJR4WkAuvA==
X-Received: by 2002:a17:90a:d00b:b0:2fe:9783:afd3 with SMTP id 98e67ed59e1d1-306dbb8e8a5mr2762085a91.2.1744181055366;
        Tue, 08 Apr 2025 23:44:15 -0700 (PDT)
Received: from [192.168.0.118] ([14.169.40.45])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7b8c617sm4321055ad.67.2025.04.08.23.44.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Apr 2025 23:44:14 -0700 (PDT)
Message-ID: <4195db62-db43-4d61-88c3-7a7fbb164726@gmail.com>
Date: Wed, 9 Apr 2025 13:44:07 +0700
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio-net: disable delayed refill when pausing rx
To: Jason Wang <jasowang@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 virtualization@lists.linux.dev
References: <20250404093903.37416-1-minhquangbui99@gmail.com>
 <1743987836.9938157-1-xuanzhuo@linux.alibaba.com>
 <30419bd6-13b1-4426-9f93-b38b66ef7c3a@gmail.com>
 <CACGkMEs7O7D5sztwJVn45c+1pap20Oi5f=02Sy_qxFjbeHuYiQ@mail.gmail.com>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <CACGkMEs7O7D5sztwJVn45c+1pap20Oi5f=02Sy_qxFjbeHuYiQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/8/25 14:34, Jason Wang wrote:
> On Mon, Apr 7, 2025 at 10:27 AM Bui Quang Minh <minhquangbui99@gmail.com> wrote:
>> On 4/7/25 08:03, Xuan Zhuo wrote:
>>> On Fri,  4 Apr 2025 16:39:03 +0700, Bui Quang Minh <minhquangbui99@gmail.com> wrote:
>>>> When pausing rx (e.g. set up xdp, xsk pool, rx resize), we call
>>>> napi_disable() on the receive queue's napi. In delayed refill_work, it
>>>> also calls napi_disable() on the receive queue's napi. This can leads to
>>>> deadlock when napi_disable() is called on an already disabled napi. This
>>>> scenario can be reproducible by binding a XDP socket to virtio-net
>>>> interface without setting up the fill ring. As a result, try_fill_recv
>>>> will fail until the fill ring is set up and refill_work is scheduled.
>>> So, what is the problem? The refill_work is waiting? As I know, that thread
>>> will sleep some time, so the cpu can do other work.
>> When napi_disable is called on an already disabled napi, it will sleep
>> in napi_disable_locked while still holding the netdev_lock. As a result,
>> later napi_enable gets stuck too as it cannot acquire the netdev_lock.
>> This leads to refill_work and the pause-then-resume tx are stuck altogether.
> This needs to be added to the chagelog. And it looks like this is a fix for
>
> commit 413f0271f3966e0c73d4937963f19335af19e628
> Author: Jakub Kicinski <kuba@kernel.org>
> Date:   Tue Jan 14 19:53:14 2025 -0800
>
>      net: protect NAPI enablement with netdev_lock()
>
> ?

I'm not aware of this, will update the fix tags in the next patch.

> I wonder if it's simpler to just hold the netdev lock in resize or xsk
> binding instead of this.

That looks cleaner, let me try that approach.

Thanks,
Quang Minh
