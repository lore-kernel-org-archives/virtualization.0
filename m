Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBB122F3BF
	for <virtualization@lists.linux-foundation.org>; Wed, 15 Jan 2025 05:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736917664; cv=none; b=rA4uecN3oXmmJx6RQKR8htjAAcKRANebcQqrx7FoJxC7nap9d+qQu3Sy5pK9X6GOR0S0NinjiIJFEMd2y9DH/Nf88qGjP0B8Oq2vWWqhtvhEA+Yrfz7Hek5hDRe0AN2IUdrwa8bDKE0o+R44S6O3joGA5XNfZas+C0HYaZpQFZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736917664; c=relaxed/simple;
	bh=t4dXpTZmsRI2k2NZ4xiQUhN5dBPeJttIl5lhtigwHU8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zh+Sh4SNGYcxCI9P5U5MZk+DT64dcjKTyHEG9VTH+9UC3mysCeZNxQnJKeSsxJQPbRhMqe/xB5Wa2gOCsDmncXtFlMj0JG7eT+E/gyBSkzME6WXuYvkjgzNlRSzVy3GzVCujkKquoGfjrU3V1WKdl4rRdrw1z0OZ/sq6oTpZeX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=LXX1ul/E; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="LXX1ul/E"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 99CC161088
	for <virtualization@lists.linux-foundation.org>; Wed, 15 Jan 2025 05:07:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hE-el_sFH3ow for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Jan 2025 05:07:41 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::631; helo=mail-pl1-x631.google.com; envelope-from=akihiko.odaki@daynix.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 75AA9606F1
Authentication-Results: smtp3.osuosl.org; dmarc=none (p=none dis=none) header.from=daynix.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 75AA9606F1
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=LXX1ul/E
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 75AA9606F1
	for <virtualization@lists.linux-foundation.org>; Wed, 15 Jan 2025 05:07:41 +0000 (UTC)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-2163bd70069so114563155ad.0
        for <virtualization@lists.linux-foundation.org>; Tue, 14 Jan 2025 21:07:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736917660; x=1737522460; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tJj2ax30G5cYMMuz85Qw6SCJDIZ/bbwOrDlSPLFGRgM=;
        b=LXX1ul/EZcqjpZsFh+nyvwiGkjpvMOZobySvuFGgOOBeVxZuajbRkCb51Z9bnpX/pM
         FaUGbLZt4jhIQKDiBr1DLRlZh7+R0Ghcm3L+j8y5IA8jAxeMGC4dYr72k7JlQI49BXpm
         305juRAXvzDjxJ5kaX9G4/y4CpkwOdm5augGuZ5d6EVVTIqIHhzRg0YE9Mm4AdEivAN8
         4q+dDPrxkAD8wOO6b0IZlOei8bkJkLSbxJfN+SBNbCwPYqfxpnjwiHghnidb/dUuGjfk
         3DaxOKE2pMXtEPBD+9Z8B+hJmovxhGGVDBCrlONqDmuT2to6eqOkI94NVAwceeKVRa9/
         eb4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736917660; x=1737522460;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tJj2ax30G5cYMMuz85Qw6SCJDIZ/bbwOrDlSPLFGRgM=;
        b=fnuuxLII7wxxEqK2e2X3QmuYlrD6KcbLtEACOQkYsV6k+WbkarPxfiODmK4oRnpZlF
         FaO+ZvUKTrNnu4ZgwQPkH4pT/I8c/q2PFhV3gvONoCygyqO/4mx4tFYV8kNo6++wQr6c
         6gFFnik8prmetXS7llaLQPAemmW50lpMXRt2ziFJD3HWTN6bAZm7SXF4YHu+FAvsPZwj
         3AbrG/s7nn8i5yeSRIOhYtAtdj1BX/ti757R0d8VxEdvRkI1Wyp6pYi1Cpuu4gXE6cXn
         j5d3I/D0NF8ntjPehCC0DrYUaj0n6zqhNhxwZlt6vkCjRdcYvmF0VwJn9EbcStWs0ceo
         BRig==
X-Forwarded-Encrypted: i=1; AJvYcCWvDPdpBui+ZrW0yEfiQktB35YbUaFl7ifwkZtvz+sQWDCb/xPU6EOKsIFYmKeJkK3auJH8JAb2gVYvewtJUQ==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yw6MPaRJLkZhcoeAxDO+jdicgqa6Tj2WTis1q9669UsVXVTc+fo
	k8tIdMBzRSDfWxBQUsVCv+6plKp6pZlf2XSZ/RNd5gSUupISDVnVIvXKnH8K6IQ=
X-Gm-Gg: ASbGnctyn/GUKP55r8l1DBwBgW6IHMoAunyEIivq0GDfk29/uFlf1MplN2SkH36beve
	d5phuV04HoelRUwEH+PGgo+0A4TsVIg/W23xVSOy3Hb27SO40LBB9yTXlKiCzaGbdKf2y/34ZxH
	JPHfqxMt1KEI+e8/e2seL1C3p1xjclPtVL/iIsIR2zQXxKd6J+TmloZcPYhIzAC1OrG4kipDcUF
	wFR+I/tMEr5aNAQneTrW54ZiCcTw8XyUZi/eJELPpxgiCwbybyMg1y9IRwqthns4dY=
X-Google-Smtp-Source: AGHT+IH85/A6RLxL+2rEhiloGI8TMEvrvGtTvROtv7Pjqakmsz8YgZ7ly7fq+kIggy8KHNzrf4rkjg==
X-Received: by 2002:a17:902:ea0a:b0:216:3083:d03d with SMTP id d9443c01a7336-21a83ffc447mr470885135ad.44.1736917659024;
        Tue, 14 Jan 2025 21:07:39 -0800 (PST)
Received: from [157.82.203.37] ([157.82.203.37])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f10e41csm73994625ad.11.2025.01.14.21.07.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jan 2025 21:07:38 -0800 (PST)
Message-ID: <fcb301e8-c808-4e20-92dd-2e3b83998d18@daynix.com>
Date: Wed, 15 Jan 2025 14:07:32 +0900
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] tun: Set num_buffers for virtio 1.0
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Shuah Khan <shuah@kernel.org>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com,
 devel@daynix.com
References: <20250109-tun-v2-0-388d7d5a287a@daynix.com>
 <20250109-tun-v2-3-388d7d5a287a@daynix.com>
 <CACGkMEsm5DCb+n3NYeRjmq3rAANztZz5QmV8rbPNo+cH-=VzDQ@mail.gmail.com>
 <20250110052246-mutt-send-email-mst@kernel.org>
 <2e015ee6-8a3b-43fb-b119-e1921139c74b@daynix.com>
 <CACGkMEuiyfH-QitiiKJ__-8NiTjoOfc8Nx5BwLM-GOfPpVEitA@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CACGkMEuiyfH-QitiiKJ__-8NiTjoOfc8Nx5BwLM-GOfPpVEitA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025/01/13 12:04, Jason Wang wrote:
> On Fri, Jan 10, 2025 at 7:12 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> On 2025/01/10 19:23, Michael S. Tsirkin wrote:
>>> On Fri, Jan 10, 2025 at 11:27:13AM +0800, Jason Wang wrote:
>>>> On Thu, Jan 9, 2025 at 2:59 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>>>
>>>>> The specification says the device MUST set num_buffers to 1 if
>>>>> VIRTIO_NET_F_MRG_RXBUF has not been negotiated.
>>>>
>>>> Have we agreed on how to fix the spec or not?
>>>>
>>>> As I replied in the spec patch, if we just remove this "MUST", it
>>>> looks like we are all fine?
>>>>
>>>> Thanks
>>>
>>> We should replace MUST with SHOULD but it is not all fine,
>>> ignoring SHOULD is a quality of implementation issue.
>>>
> 
> So is this something that the driver should notice?
> 
>>
>> Should we really replace it? It would mean that a driver conformant with
>> the current specification may not be compatible with a device conformant
>> with the future specification.
> 
> I don't get this. We are talking about devices and we want to relax so
> it should compatibile.


The problem is:
1) On the device side, the num_buffers can be left uninitialized due to bugs
2) On the driver side, the specification allows assuming the num_buffers 
is set to one.

Relaxing the device requirement will replace "due to bugs" with 
"according to the specification" in 1). It still contradicts with 2) so 
does not fix compatibility.

Instead, we should make the driver requirement stricter to change 2). 
That is what "[PATCH v3] virtio-net: Ignore num_buffers when unused" does:
https://lore.kernel.org/r/20250110-reserved-v3-1-2ade0a5d2090@daynix.com

> 
>>
>> We are going to fix all implementations known to buggy (QEMU and Linux)
>> anyway so I think it's just fine to leave that part of specification as is.
> 
> I don't think we can fix it all.

It essentially only requires storing 16 bits. There are details we need 
to work out, but it should be possible to fix.

Regards,
Akihiko Odaki
