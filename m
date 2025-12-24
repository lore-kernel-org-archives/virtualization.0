Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F282323ED6A
	for <virtualization@lists.linux.dev>; Wed, 24 Dec 2025 01:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766540880; cv=none; b=lFWZZBJvrebhg2guNKsNXdiPz2TjQrbVN6deiqz5YdZAa98nqoPtTdaVpSz24yMX5khmAmqJkmFn9dcLMpSwB7y5Vlu9YIgS8hcOAYE2Eke+TLJBfpG8o5XyS1XYJJZt/sPOEugl/eQNCM2c/hYZhA8AU17cuEIbkrTfQoELjiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766540880; c=relaxed/simple;
	bh=rlBORRVqCuCCDKKTRMpReJJ+tKBroym5f9pOqNZrTI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=O9YjM3c2/NSY8aiCZOMvKHOhF6b7jWQsnHG9Q7gOi4LpMxxuImanuxembRrSdTsD41UXykG8udbbWxQy1OnSOhVMSCb/Z43TfWqqjGwOMNrRr7FALaP3XZY9lAt+gmWJrX9erDuyG4KqickIgZJ6O1C+dKBS+C3N5RLq19FB/KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D2MY99Sz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D2MY99Sz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766540878;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EfLuOi85d1FraY7+0q787i/gVvs6BEvd92Xlu3j3K0Q=;
	b=D2MY99SzKCXazxcjf8a9zG2fq5bSLZ8veo5lQu3wUDfONcRp3uzL52glLairIlaI8ZAUMP
	QGUovddPw3XI329hjgZZeef6RbXQ9LviL0vvw9oXtB4zsX0rL5gFkQlTb0nMDMFo0jL1IX
	Lw6sxtx8FjUVj72QRVPvGqvmIc9PvoU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-300-_m6BjwG9MLSnfGBTQo-FEA-1; Tue, 23 Dec 2025 20:47:56 -0500
X-MC-Unique: _m6BjwG9MLSnfGBTQo-FEA-1
X-Mimecast-MFC-AGG-ID: _m6BjwG9MLSnfGBTQo-FEA_1766540875
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-430fc153d50so4638853f8f.1
        for <virtualization@lists.linux.dev>; Tue, 23 Dec 2025 17:47:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766540875; x=1767145675;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EfLuOi85d1FraY7+0q787i/gVvs6BEvd92Xlu3j3K0Q=;
        b=tVaQ/yb/ZxveGwHIq3cBLiBMf7T0FROZoo+ZFsuL79DQ7aUEvTWSJjXXwUIIW7nUIl
         V0qykhQ0xSTkGZ6TFID1BlaOXHAIyaw4DKPHE4MdQ2NfASAcjyq569Kd1A+TUUaV9X0T
         dBNiaNH96hz73TksjABjJ244bbFiD79UBs2kuXVVgFTY/qnJa9g+KA5OXwAv3x8GhW1P
         yzmy0+JZUCzwKqbB7PC+2mHMJbUTyCumtT2m5RW3o10wS1+UT/oc3Z3yk651hwVqp2jL
         rOR2ATibvD85ohnpFGatLLLODeWG7Bg508bitDO2UaLCfX408RfM4eOoWe+yTXkVD2L2
         tD+w==
X-Forwarded-Encrypted: i=1; AJvYcCWiD0+DMwRc8fU63YQvpcWchmvvXY5Q59Oq+S8UW4bU8JQq5vTIqUfmiDhK8LaBAu2BKeX0DpoOLINJC1xmag==@lists.linux.dev
X-Gm-Message-State: AOJu0YyFmCQurEngwDcdwFjhitP/3OzihX9E6YzvB86JNlsnDPeP3o5m
	pXDzgRZRkm3S5t6UdbuSpZCRosMtJdxk4QT4DgpB8F8QCDHGQbqxGtwPrq+CCtji5M5gU/IK9mc
	kMwalS/Gh1/7UthOqlLEWBi5UTIXt1HYNqBIUIAFbym3lOU0w8t0DZP4eLtbLcfQ/Idro
X-Gm-Gg: AY/fxX4po8MTAmF+gE15ziDH+c+XBM7kEPrhhfDfdfN8fJat9WeT28tDxTB5yhpGWpD
	5YZ2HHIDdSOL3vbEY06ArCJZUAIUPp2a2jDLkexe+5WTxHnEQMpomQ/4OBKhsd+gIuljkj4x1IK
	TN8V3RJpiH0NOepmcvbWjNW9b0j6oQrLPQsXHFyU0LlVD02SsIvGLjPllKvp11C18agnwiL9zzy
	spMB+SYwuFZ0+0+6ehrbHFPdpujjdogwYo9gISKjGpayb58aOC4oX7wiGGGN+VEcgnVB7w6NOs6
	n5Zg8f2fJr3ZrKXfA1qr8TCH0xaJ/UPRfzWlu27CI1rF0UtZeSQoMiPaRpKJKfQ4FmZLj0UMsrn
	A
X-Received: by 2002:a05:6000:26c3:b0:42f:b581:c69a with SMTP id ffacd0b85a97d-4324e4c3e13mr17469855f8f.5.1766540875199;
        Tue, 23 Dec 2025 17:47:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFxAidHJN/0HxTdnoimsgwBvjgcKtPCXXltUV2xjreKTHHI6FxPbiJNRx2xvom7ebYh/UDBIw==
X-Received: by 2002:a05:6000:26c3:b0:42f:b581:c69a with SMTP id ffacd0b85a97d-4324e4c3e13mr17469842f8f.5.1766540874789;
        Tue, 23 Dec 2025 17:47:54 -0800 (PST)
Received: from redhat.com ([31.187.78.137])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea8311fsm31060662f8f.28.2025.12.23.17.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 17:47:54 -0800 (PST)
Date: Tue, 23 Dec 2025 20:47:50 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Jason Wang <jasowang@redhat.com>, netdev@vger.kernel.org,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, Bui Quang Minh <minhquangbui99@gmail.com>
Subject: Re: [PATCH net 1/3] virtio-net: make refill work a per receive queue
 work
Message-ID: <20251223204555-mutt-send-email-mst@kernel.org>
References: <20251223152533.24364-1-minhquangbui99@gmail.com>
 <20251223152533.24364-2-minhquangbui99@gmail.com>
 <CACGkMEvXkPiTGxZ6nuC72-VGdLHVXzrGa9bAF=TcP8nqPjeZ_w@mail.gmail.com>
 <1766540234.3618076-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <1766540234.3618076-1-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6WF9acpjloM5NxC9kr_E1NMhNZH9FTLNeQym0TqabdI_1766540875
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 24, 2025 at 09:37:14AM +0800, Xuan Zhuo wrote:
> 
> Hi Jason,
> 
> I'm wondering why we even need this refill work. Why not simply let NAPI retry
> the refill on its next run if the refill fails? That would seem much simpler.
> This refill work complicates maintenance and often introduces a lot of
> concurrency issues and races.
> 
> Thanks.

refill work can refill from GFP_KERNEL, napi only from ATOMIC.

And if GFP_ATOMIC failed, aggressively retrying might not be a great idea.

Not saying refill work is a great hack, but that is the reason for it.
-- 
MST

