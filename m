Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AABF48032D
	for <virtualization@lists.linux.dev>; Wed, 21 Jan 2026 09:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768988893; cv=none; b=p4bSjZrExZA/M+JA/Htyj/SJ/dFp8oZ8ChoZ/i9csC9Qg+gMV4qch/DYwwvbOUbmIwFXPDFEdt1Ce0GaZTYE1IfiV3D+0Y79cgTJ/ZlLCcl1Upmv1H38UzwGyHLHlJeJx/oi4amAqDgPBuBkldkwgTOU8p2tIU4+LK14Ak3TY6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768988893; c=relaxed/simple;
	bh=hepF0A2LSGlCyRDBXglqMBeLZzFYJb45MCxfhvn7i1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ncvcZ0mMgS6Ydndx3k3M9iXsQ1EqJPb+pIfb+q/K9sdqyLz/cI753Hw0EseDjiTW8B6HaLR/7soUFatd8Z413UbPx098I6L3VhG304/hY20XwSeKxIPdijPi+ogSYG1Svoi8Ua9XzVSHEONxE20vd56aptOW1VOwdQn88eBYH+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fIoVYjaW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fIoVYjaW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768988889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hepF0A2LSGlCyRDBXglqMBeLZzFYJb45MCxfhvn7i1s=;
	b=fIoVYjaW9NDxX2C9etPe+QYGTiYKIjW3AQlDN9QRm2p+ziIiH1gD38PUO0Y5Gbfjsfxzhh
	27CHujhAchMM6Z6v8RXLT8iFc8Lh/KAgkj3np5Zpkx2lNsJaMJiPfcgnTjZ/58MPw5m7Qr
	RY5L8Vb2aeiVGfq3LLr/5SumkfTd9I4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-531-CRQX8BeuPbOW4HjiqDG2UA-1; Wed, 21 Jan 2026 04:48:08 -0500
X-MC-Unique: CRQX8BeuPbOW4HjiqDG2UA-1
X-Mimecast-MFC-AGG-ID: CRQX8BeuPbOW4HjiqDG2UA_1768988887
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-430fc83f58dso4338451f8f.2
        for <virtualization@lists.linux.dev>; Wed, 21 Jan 2026 01:48:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768988887; x=1769593687;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hepF0A2LSGlCyRDBXglqMBeLZzFYJb45MCxfhvn7i1s=;
        b=NzEgjY4BF4MiQMxC/MqpAGaWBGifA102w8iCJqTJ0RMoWzIKZwgGqpdqEwHGgrWJyX
         4WSDQV1w4RTVvGnpc1/vnnHSImIAQIwBtVkeT4MI0OpTtZ3wwdL8Mfs47TVNihuWCKCM
         Y+72feyjS33LzoNpw0S42AsN7RcTOifs5V1TBtZIr4Vr8TJa74i9Ea06ysJKobAZ8YRT
         kbae7H1OjJkl9mrH+qBzN17AFjgCp3ABAPYOvngu5lsNc09B3vJhluP5IJ6CIcoeAqq9
         qr4RYx5e5TH3MLNSRASFqwY4UBeR2R8U3ZGKAJQH6rtJQVxBxd/4EdE/uq3+uGQiQ3lB
         4Cag==
X-Forwarded-Encrypted: i=1; AJvYcCVZSmTFTjc6TonOBGOwwvgegkTirSrS2sTKZ8S6/EXWbJaDivV3qAsHLu2W5OhR4EXA2q0BP9OfCxA1bGD2Tg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwpJKSt0w/PI3xRYU6sGTUTVIO0h3RHNQjhD5yP1kyKCFdPse14
	l3V2liIhX+JelDwfhsu4PjxJaUzF5MxlCUXHrhpgRz6JFaqTEScTrm6KHXOWkI+r2SiwCaLqk2s
	JPWRc8u/Yjm9TwMccrfeULEM3qAMVg3oiIyv/7xZvEFQ7bV4hEREtc2LUBJOwnIt5zOJ4
X-Gm-Gg: AZuq6aKn2T9aQXJiNG7az0cCHR+JQ3b+6GiIs+iiPgqVCryb8RDA8mB4ne3ZkXDr95x
	1AFbLljU8esy5NfA73+kWWGdRDLJ2UUNO/TDHKAfJbGOx9fgq/3wreb6ZBD1+WvkMS4JDFfNVph
	VST/fRyPV7FnTbzzJwX074kTbaYqy1d9SuMuqV9dMSPTwSCCBgvqaUBPN40gbg6vsCBmikF40Wa
	rXhkS/Ts6NVbYtA4v2RUftxxs7V961fFL3GNqaSWGqlho5votIMfe0eJZ3hbKFsqsrcAGCjr+qT
	JJbIWS4GIZIzDmSjhF85atr7OHWIPN+r8hJAwExXrvcBuExRxa3hiC5+SnMmWUDMFQ8Z3DTaY/W
	he3H5W+sDkucYpdWQesaJJ8U9sJL3CLiazsNmV5H/oZ943qJIEkGGijr6h2M=
X-Received: by 2002:a05:600c:8b78:b0:47e:e8c2:905f with SMTP id 5b1f17b1804b1-4801e30a790mr252559195e9.8.1768988887164;
        Wed, 21 Jan 2026 01:48:07 -0800 (PST)
X-Received: by 2002:a05:600c:8b78:b0:47e:e8c2:905f with SMTP id 5b1f17b1804b1-4801e30a790mr252558715e9.8.1768988886678;
        Wed, 21 Jan 2026 01:48:06 -0800 (PST)
Received: from sgarzare-redhat (host-82-53-134-58.retail.telecomitalia.it. [82.53.134.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47f429071besm351751895e9.10.2026.01.21.01.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 01:48:05 -0800 (PST)
Date: Wed, 21 Jan 2026 10:45:50 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	"Michael S. Tsirkin" <mst@redhat.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Paolo Abeni <pabeni@redhat.com>, kvm@vger.kernel.org, 
	Eric Dumazet <edumazet@google.com>, linux-kernel@vger.kernel.org, Jason Wang <jasowang@redhat.com>, 
	Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>, Simon Horman <horms@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Arseniy Krasnov <AVKrasnov@sberdevices.ru>, 
	Asias He <asias@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH RESEND net v5 0/4] vsock/virtio: fix TX credit handling
Message-ID: <aXCfnIFT6_HqC8v9@sgarzare-redhat>
References: <20260116201517.273302-1-sgarzare@redhat.com>
 <20260119101734.01cbe934@kernel.org>
 <aW9L0xiwotBnRMw2@sgarzare-redhat>
 <20260120151848.3b145279@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260120151848.3b145279@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: K5B66J4e3vOZmfUwTC8ta5jECWta-fOt-JdjOUAh1IY_1768988887
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, Jan 20, 2026 at 03:18:48PM -0800, Jakub Kicinski wrote:
>On Tue, 20 Jan 2026 10:37:12 +0100 Stefano Garzarella wrote:
>> If you prefer I can send a v6.
>
>We'll need a v6, patchwork can't do its thing if the series doesn't
>apply and last time I applied something without patchwork checks it
>broke selftest build:
>https://lore.kernel.org/all/20260120180319.1673271-1-kuba@kernel.org/
>:(
>

Sure, not a problem at all, v6 is out now:
https://lore.kernel.org/netdev/20260121093628.9941-1-sgarzare@redhat.com/

Thanks for the help!
Stefano

