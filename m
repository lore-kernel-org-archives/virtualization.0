Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975922DF154
	for <virtualization@lists.linux.dev>; Wed, 26 Nov 2025 11:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764155827; cv=none; b=YJajcXTCdYww9VJ580N8DnfAAkEb+9VTIah/9jIJrYESQFMcn82t8oTJdlm382BO02Mzai+/AXNU1RgSeDXZlk0I4JUW3acfD1WBx2ZeAGi5t29VCFPGmwHwqX69tE0IM3uHIU4NF8wvst0NikCK5r1yWuwQp4Gj1EjUvsCb5fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764155827; c=relaxed/simple;
	bh=FXLxuWpTeNt/gfc34ZFouSRfw/ZzH7LBsVSlB2UyowU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BaSeDKdBPHGzX8/lsfkPLLUNBbn1A56E5JmzeucaT63zjQDe/FbpZ9YPVyvY8X9LFIrXtmr6YpzZt43NVzjxzy2mLHE+T+BnFoCGSiEnPsTNhNy2NXmazz3LB1c8DDliyCI6v4GuWIZ+sA0K6A7PxN2ETmNpCr1NL1zWvN1yxyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LaA4B6LF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LaA4B6LF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764155823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sXUwg2yPl9Js7/5lQiVXWW6sjL6SYU5SIFbfaH9Um10=;
	b=LaA4B6LFFUTB/Eh59LEYMbwKPwUThcZRgiJt66AprS7s+SJvORdvVS1pSnR2u4A4KfLtZw
	hfKS4CP+o26L+Pd9yXnoSGToe5mr+XHrt8JT5C4SBTfptCNiISRxxHY0hxmMte9zY9wkeR
	H79XQ0DirLD2U4q6OaCW83YY7OsT7xY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-alCkN98NN_2-3pkUfg3Rtg-1; Wed, 26 Nov 2025 06:16:59 -0500
X-MC-Unique: alCkN98NN_2-3pkUfg3Rtg-1
X-Mimecast-MFC-AGG-ID: alCkN98NN_2-3pkUfg3Rtg_1764155818
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-477b8a667bcso66116755e9.2
        for <virtualization@lists.linux.dev>; Wed, 26 Nov 2025 03:16:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764155818; x=1764760618;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sXUwg2yPl9Js7/5lQiVXWW6sjL6SYU5SIFbfaH9Um10=;
        b=hYTuHTDIZGLQ/E/4ZF8/RfelI5DxA0va1jfhR+P3k16QfOZcypCEA1kNV/JlL3qf2t
         wbONEkmxngToJVRybMjv37RrBMTKJIYi2vws5b3s0bXfSWB5LkmX491xqehdKLKOF1DH
         4f3EWbof1Aw3Vk4E/Ls8ttAF/z9rfJAXuUHDC6sj09xDJO4D7tRmyfkuYiCyXZzn3JY7
         Z9n48C/q7/uiOUcA68zq2cnnXiN5Bt9bdzxjglGVohEQGuyItCTjhaZ7fLfzdb3Shr2g
         KSQnB6BNxSt36QP8Uj5ulhaSWc3IXTT5YfQHtAkl4mbZyeWaKaYCNAI5g4KTkUba5lyt
         G0Cw==
X-Forwarded-Encrypted: i=1; AJvYcCWgmRJOsKkJjH5B2Dz0ShIXy2KCIWDPGF19c39mfVsyd5qpcSx8Goquwu86w70hCZ9vZqZJMTjbO5q1fl+Sqw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx390l7YeWaStHVxlZvNey6dYFEssZcJUxe2FAkLPbHpayZEDFU
	5lOtWHEl2adW7+Vjabt9WiJA4m18plWHpO/Ii6JslB8/LaZ2oLe9/5+kiNC4Zg0Funmxo+IQzm6
	VcAny+31ZDzItQnI99HxIZz5sqOLp9in9BjO0REN6wRCfTs1HO2UUsH+PESxd7VgcSwcT
X-Gm-Gg: ASbGncse/iPNTQMieSf0UlZ3gyawxXAoRmtjzoIVho81bzIFyHSG3g/bHc3IBURBfI6
	neQM/aR06dJybQLb+NVIOPtxlb93fhA9PGCH6SpFJqcaGE1cmmWcLN1DP/zS3nLA0IvcXyP9TKU
	z7jXIMosnyAbpgBj8ceCJ/Swm9cHL2wSZQ+cC0wFUsE9AgKWLGnFDAMKx6R7SWk1zs3piJ8S8AC
	4VLvEcxAaYdJd5FyXDnlKOwpyADL84JqWoLnXusRxjGBkGYQQcjDoussoRiPGRQG7XcbeL9T5b7
	hudnW0Yru7r2dEceEzbdkP5HRZ8142EZrMbgkYwu8IOIowdZFFv6ieSeu+L2cTC8CCdhUKQw9Qh
	kYwJ4xjNEr1Zd0A==
X-Received: by 2002:a05:600c:1c8a:b0:477:6d96:b3e5 with SMTP id 5b1f17b1804b1-47904acadd7mr67184735e9.7.1764155818323;
        Wed, 26 Nov 2025 03:16:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHLz7TMJoiEY5ntWwLrjinKIkPuhGf7MTOYlP3j+7T2Z5i2/y+3piCR9uvk60DK9W3uKWuN6Q==
X-Received: by 2002:a05:600c:1c8a:b0:477:6d96:b3e5 with SMTP id 5b1f17b1804b1-47904acadd7mr67184455e9.7.1764155817906;
        Wed, 26 Nov 2025 03:16:57 -0800 (PST)
Received: from [192.168.88.32] ([212.105.153.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4790ab8b21fsm39688885e9.0.2025.11.26.03.16.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Nov 2025 03:16:57 -0800 (PST)
Message-ID: <abb04d29-1cd8-4bff-879d-116798487263@redhat.com>
Date: Wed, 26 Nov 2025 12:16:56 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] virtio-net: avoid unnecessary checksum
 calculation on guest RX
To: Jon Kohler <jon@nutanix.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>,
 "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <20251125175117.995179-1-jon@nutanix.com>
 <276828c5-72cb-4f5c-bc6f-7937aa6b6303@redhat.com>
 <3ED1B031-7C20-45F9-AB47-8FCDB68B448E@nutanix.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <3ED1B031-7C20-45F9-AB47-8FCDB68B448E@nutanix.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6vv-L9ZKPrJ2kagjkTpuBIEFkDgIHJjn-MQLsrsp_7c_1764155818
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/25/25 9:00 PM, Jon Kohler wrote:
>> On Nov 25, 2025, at 12:57 PM, Paolo Abeni <pabeni@redhat.com> wrote:
>>
>> CC netdev
> 
> Thats odd, I used git send-email --to-cmd='./scripts/get_maintainer.pl,
> but it looks like in MAINTAINERS, that only would have hit
> VIRTIO CORE AND NET DRIVERS, 

?!? not here:

./scripts/get_maintainer.pl drivers/net/virtio_net.c
"Michael S. Tsirkin" <mst@redhat.com> (maintainer:VIRTIO CORE AND NET
DRIVERS)
Jason Wang <jasowang@redhat.com> (maintainer:VIRTIO CORE AND NET DRIVERS)
Xuan Zhuo <xuanzhuo@linux.alibaba.com> (reviewer:VIRTIO CORE AND NET
DRIVERS)
"Eugenio Pérez" <eperezma@redhat.com> (reviewer:VIRTIO CORE AND NET DRIVERS)
Andrew Lunn <andrew+netdev@lunn.ch> (maintainer:NETWORKING DRIVERS)
"David S. Miller" <davem@davemloft.net> (maintainer:NETWORKING DRIVERS)
Eric Dumazet <edumazet@google.com> (maintainer:NETWORKING DRIVERS)
Jakub Kicinski <kuba@kernel.org> (maintainer:NETWORKING DRIVERS)
Paolo Abeni <pabeni@redhat.com> (maintainer:NETWORKING DRIVERS)
virtualization@lists.linux.dev (open list:VIRTIO CORE AND NET DRIVERS)
netdev@vger.kernel.org (open list:NETWORKING DRIVERS)
linux-kernel@vger.kernel.org (open list)

The "NETWORKING DRIVER" entry should catch even virtio_net. Something
odd in your setup?!?

BTW, this is a bit too late, but you should wait at least 24h before
reposting on netdev:

https://elixir.bootlin.com/linux/v6.17.9/source/Documentation/process/maintainer-netdev.rst#L422

/P

