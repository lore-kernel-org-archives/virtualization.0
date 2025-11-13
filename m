Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37611A9FAC
	for <virtualization@lists.linux.dev>; Thu, 13 Nov 2025 01:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762996212; cv=none; b=aKQmtkWkx5HeO/dRvSjZv+17CpBh1upxtTAvhiXGaghHpVRSNNEejL8eI8Pbix6adKLwbwb+QvfcwxMN02GrSZKrCg6nu7L+J6kyOsg7dVkd/4Y3ytRo3zwZoJXfoVekyjAccS/vMeoEvq2UZ4ykRjApeAmy/rS72X4GdwvJ6xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762996212; c=relaxed/simple;
	bh=WTHbBFat8WgTLz0VXEBvhYA3zWQoc05BaGIUCPm9GuY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h0/Ho76QjMDsi48gLqskik5oMY0j1sEk1c57N+AnePD/aCrha3AGQgXPaKEBx/JDZoaWy4T3Y7w4PF4MimEURucXr1ksY77o8RQkjFu2UnnFsyu83YP+RtnUsdUi3XOU0TAOv34EgU0ESNUDxZFf2p3JFj0adSwOiZ/Ff58HN9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HRTvazPw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HRTvazPw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762996209;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YB5iq4phMZJP8WFjyiHhxY03YBLuYzrX0nSkxLfKzHg=;
	b=HRTvazPwQ+NNh7M+2cKlA/0+odj6BX9/5SV3nXJc1dvH7bRgNAtaRNGmECYos9kUi3xAFd
	Dv0x3zQBN+sbFDKU0OeYSj2JKkg7PafMigvKoBHQ28yBdYH8AqxNLrRV8WjmSt4Hf9GFH7
	TGdtYQejucXR3oBIIZoHFcol99fRvwI=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-Ce7zj96BOVydFAYkqHK2WA-1; Wed, 12 Nov 2025 20:10:08 -0500
X-MC-Unique: Ce7zj96BOVydFAYkqHK2WA-1
X-Mimecast-MFC-AGG-ID: Ce7zj96BOVydFAYkqHK2WA_1762996207
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-341cd35b0f3so1505548a91.0
        for <virtualization@lists.linux.dev>; Wed, 12 Nov 2025 17:10:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762996207; x=1763601007;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YB5iq4phMZJP8WFjyiHhxY03YBLuYzrX0nSkxLfKzHg=;
        b=qtKB3cKNDxADxO4XZF8xsd07c+/BteGyV4j1KecTIx0rQC1yjC378Ue3Garnq7hvq1
         H41NWjm50FIiohLflRpZmHLWkwQGw7jiQiWN51JceS/5fIyti9PJP/wGwlyvA6gFo7rA
         5jc5a+NZ7WczafZZ92lvGMvLUTSnT/912em537RwKlUb1dd68Vq6mNRoFx0B3Cg6eqBy
         dTn5JN807VO6dBPvvwoe599zWqu0r8FC79n0Wn8sxcyOytrlCZF/N67B7FbGV5QDdr5h
         vOpHXY+eYYS3qjR5XuTh+w77n7ktVli9OSHAPYfybMvXyc2kDIQNgvv9CaYyjyCdruBc
         d8OA==
X-Forwarded-Encrypted: i=1; AJvYcCUkZH0ca9qiB/ZiUA3P05sp78tSjBi3A4ZG0DJBALxTbI+IzwS+wb6oWdZYbRu5S0GWnBzCS8Wtv8/Q1IiSOg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy54zbuPNHJJuE6opAIzr2dRq4Q8z9ysaXaXKH8zHjp1P8inIxu
	oysj5Phkn3o5U9QaN7uwhED1CLKrdvQ8zn28j7UMXu3cUisM6J297HffeL+AqaYvwo2cMkN0dbI
	XjzUfmFxoKv9O7KpWyRj17ZKLPUCi4Klabmz6UVDS4PF/JWMeNrbXK++1Il+17NQ+4jdCQ/fYXj
	0yyML8HvNJWTFYe8ADucZjmFYFTE2qytMKv0t30C9uTbY=
X-Gm-Gg: ASbGncuQj9hj3a0sRQNhmRHhbYLazjlikB7VmKtOiprBffo7LFl1GAqzhGpgDLxr7WD
	Bo+9IE+N23qClLMgmamCN2gpob9zMY+scFlzaiiCHzn0brQ+53fiZ7NpdDL+3YlDwBy9WRWosIE
	VK3xEm1O8F8fGd2Jy/ka0XF0KGEKFibmdl+WcaY8xzW/vX/Ug9gbKYTQ==
X-Received: by 2002:a17:90b:5643:b0:340:68ee:ae5e with SMTP id 98e67ed59e1d1-343eab2d6e8mr1479310a91.4.1762996206969;
        Wed, 12 Nov 2025 17:10:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG9ygtEnet5AzKgZkKuFsP7FTx9uhPWvwXy5utv/ipBEByquxKdhaAV2Jg/+1bKSY7kHGa3WYdxox8Xs01KAxg=
X-Received: by 2002:a17:90b:5643:b0:340:68ee:ae5e with SMTP id
 98e67ed59e1d1-343eab2d6e8mr1479275a91.4.1762996206546; Wed, 12 Nov 2025
 17:10:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251113005529.2494066-1-jon@nutanix.com>
In-Reply-To: <20251113005529.2494066-1-jon@nutanix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 13 Nov 2025 09:09:55 +0800
X-Gm-Features: AWmQ_bkNFI0Uak0BVc9mmMYVp98tX8j2dw19j09dCC_kLqXSmWRrmqmpo5b_MMY
Message-ID: <CACGkMEtQZ3M-sERT2P8WV=82BuXCbBHeJX+zgxx+9X7OUTqi4g@mail.gmail.com>
Subject: Re: [PATCH net-next] vhost: use "checked" versions of get_user() and put_user()
To: Jon Kohler <jon@nutanix.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, 
	Borislav Petkov <bp@alien8.de>, Sean Christopherson <seanjc@google.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: j7V5ODPo2mchtKgmzeejtF5sxkwu-M_Ctk0PI0-JzJ0_1762996207
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 8:14=E2=80=AFAM Jon Kohler <jon@nutanix.com> wrote:
>
> vhost_get_user and vhost_put_user leverage __get_user and __put_user,
> respectively, which were both added in 2016 by commit 6b1e6cc7855b
> ("vhost: new device IOTLB API").

It has been used even before this commit.

> In a heavy UDP transmit workload on a
> vhost-net backed tap device, these functions showed up as ~11.6% of
> samples in a flamegraph of the underlying vhost worker thread.
>
> Quoting Linus from [1]:
>     Anyway, every single __get_user() call I looked at looked like
>     historical garbage. [...] End result: I get the feeling that we
>     should just do a global search-and-replace of the __get_user/
>     __put_user users, replace them with plain get_user/put_user instead,
>     and then fix up any fallout (eg the coco code).
>
> Switch to plain get_user/put_user in vhost, which results in a slight
> throughput speedup. get_user now about ~8.4% of samples in flamegraph.
>
> Basic iperf3 test on a Intel 5416S CPU with Ubuntu 25.10 guest:
> TX: taskset -c 2 iperf3 -c <rx_ip> -t 60 -p 5200 -b 0 -u -i 5
> RX: taskset -c 2 iperf3 -s -p 5200 -D
> Before: 6.08 Gbits/sec
> After:  6.32 Gbits/sec

I wonder if we need to test on archs like ARM.

Thanks

