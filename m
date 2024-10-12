Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D6C1552FD
	for <virtualization@lists.linux-foundation.org>; Sat, 12 Oct 2024 10:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728730651; cv=none; b=I79EnshCDBZOTlsjG85NYdqt9IqZxVHruhQFcDQSZyDyB+pVcOrF8RDXh3byQlMQV6gwCHKoVklD5npqk3+7REgjgH/T/drddzWTdVNhiYdpNEEQFeVE0e/WjTj5oFw9xGvPT9vdI6jwe1cStIl1y8VF+GoGQnVmASQAbPZ0qMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728730651; c=relaxed/simple;
	bh=yzj48cWj4L8LiQC5ox1BGXI/Tjjq1Nx6uec3CrMVcKI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=XQFmUo11UsJjDNbPfMTOSrx9jrVg8Yom+8ovicXsBp2so0gi0HWnhwnnyZTmsm9hlae8+X6Q9KOdx/z5sik4kSUStlAJYdZDUCEo41ESFT4zThxzbjB/ggiTT5waTjVJN1yYzvKBJ5UYI+vjqPhGPuVzBXEKPu8tUQVpOSGfsNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=K/k1sfXt; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="K/k1sfXt"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0475E8205E
	for <virtualization@lists.linux-foundation.org>; Sat, 12 Oct 2024 10:57:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.898
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OxvVdFkjJ3mg for <virtualization@lists.linux-foundation.org>;
 Sat, 12 Oct 2024 10:57:29 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::533; helo=mail-pg1-x533.google.com; envelope-from=akihiko.odaki@daynix.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 3D5AD8204E
Authentication-Results: smtp1.osuosl.org; dmarc=none (p=none dis=none) header.from=daynix.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3D5AD8204E
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=K/k1sfXt
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3D5AD8204E
	for <virtualization@lists.linux-foundation.org>; Sat, 12 Oct 2024 10:57:29 +0000 (UTC)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-7ea06275ef2so1938782a12.0
        for <virtualization@lists.linux-foundation.org>; Sat, 12 Oct 2024 03:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1728730648; x=1729335448; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RQHS9P9S9IhAfq2pHjdIrMEoP4ui2SXVS05dgp3eWDo=;
        b=K/k1sfXtuxya0H1nCP/3SyhLVP7vSjpHuOs1zHm73u26ZAo/P7tn6tqfiq/XPDKNPs
         FZEuxIIpyFXuMdtoBWpHjNVm8w3QoJm2GkRbfJrv5ImR1nBwSROiXrO7vG16D2jrdhx9
         PWUo0nT6DqPMdjxEg8lP+BiuJGgF3fhsxOKrZZYEgX4Ei0sjv2zjqVRNJXBq/xNYXf2r
         YgS9YhOh9emnnzyLSVMAEROgah61cFU0WC9qLeIPS/G+iJflJ86e4w4ucRFNbjuA0Wrs
         nTRLAxTUDwxDs05LC9eJImVpYf4CT4aCrUP2F0Ousb9gwr0DY8NcYLJDmJmDgZq30E1H
         DWOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728730648; x=1729335448;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RQHS9P9S9IhAfq2pHjdIrMEoP4ui2SXVS05dgp3eWDo=;
        b=hetPjyXe33aUDWb/Z/sNIUJ9N7i0c1E3tQq5aVx+ynofl06Sk25A207LDbM3QPQVUG
         /5PWncCUgM8CC+z6SkD/AcJIdMh/Xln4wsk4yDhKv4odEfqSLdD2iI3HUF31bcHcG1+F
         PtiIFUJdM39F9rZdiSpATTKa7DecQpLGHX/oeDOHQ8ysa9bBaALy276RnrUgu/gokHyP
         YO9Xf+GRazvD2/cMk9oXf0ih+XEXCDHU7bv/a6Ckcc0p+V31JGB+uc9Hp+I4jvNtHzNr
         FIXGrXyftu5i7eNwpw4tPxMYbDPADOrDt7XSKUNMP8tI8l+0DnTzcf+8jCHQFqUHzd2b
         CDKQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0pkPBwyOWmiv95d8UL6PWIW/OMchabl2JCHigauQ90u8T2iCApxKYuk9RtTfZfGCSh/eOFqlzrtZ0Fhu3zw==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YzOOCulZpd169whXjLrZEbNDyV+FLFwfbPdSNqQYFoVentbeVqN
	58wCyXkxxd/HqBKuinG3xBnXLeyo7iCH1qIQ1jq5TnTP7gmcNkk30vgWz/vv1xQ=
X-Google-Smtp-Source: AGHT+IFekv1Jof5V0rzE74khJL3aujdAI4lCz36fIxAEe87tyEoPh3HrVVeYVj30VhB4bKJv7WvZZQ==
X-Received: by 2002:a05:6a20:e617:b0:1d8:aade:dae8 with SMTP id adf61e73a8af0-1d8c96c477bmr3811262637.49.1728730648461;
        Sat, 12 Oct 2024 03:57:28 -0700 (PDT)
Received: from [157.82.207.107] ([157.82.207.107])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ea6ed5f6d0sm676332a12.53.2024.10.12.03.57.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Oct 2024 03:57:28 -0700 (PDT)
Message-ID: <f4501f54-875a-4c46-9e77-802bd81f4230@daynix.com>
Date: Sat, 12 Oct 2024 19:57:22 +0900
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v5 04/10] tun: Unify vnet implementation
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>, Jason Wang <jasowang@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, Shuah Khan <shuah@kernel.org>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com
References: <20241008-rss-v5-0-f3cf68df005d@daynix.com>
 <20241008-rss-v5-4-f3cf68df005d@daynix.com>
 <67068b632d2d2_1cca3129484@willemb.c.googlers.com.notmuch>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <67068b632d2d2_1cca3129484@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/10/09 22:55, Willem de Bruijn wrote:
> Akihiko Odaki wrote:
>> Both tun and tap exposes the same set of virtio-net-related features.
>> Unify their implementations to ease future changes.
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> ---
>>   MAINTAINERS            |   1 +
>>   drivers/net/tap.c      | 172 ++++++----------------------------------
>>   drivers/net/tun.c      | 208 ++++++++-----------------------------------------
>>   drivers/net/tun_vnet.h | 181 ++++++++++++++++++++++++++++++++++++++++++
> 
> Same point: should not be in a header.
> 
> Also: I've looked into deduplicating code between the various tun, tap
> and packet socket code as well.
> 
> In general it's a good idea. The main counter arguments is that such a
> break in continuity also breaks backporting fixes to stable. So the
> benefit must outweight that cost.
> 
> In this case, the benefits in terms of LoC are rather modest. Not sure
> it's worth it.
> 
> Even more importantly: are the two code paths that you deduplicate
> exactly identical? Often in the past the two subtly diverged over
> time, e.g., due to new features added only to one of the two.

I find extracting the virtio_net-related code into functions is 
beneficial. For example, tun_get_user() is a big function and extracting 
the virtio_net-related code into tun_vnet_hdr_get() will ease 
understanding tun_get_user() when you are not interested in virtio_net. 
If virtio_net is your interest, you can look at this group of functions 
to figure out how they interact with each other.

Currently, the extracted code is almost identical for tun and tap so 
they can share it. We can copy the code back (but keep functions as 
semantic units) if they diverge in the future.

> 
> If so, call out any behavioral changes to either as a result of
> deduplicating explicitly.

This adds an error message for GSO failure, which was missing for tap. I 
will note that in the next version.
