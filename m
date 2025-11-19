Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3159120FAB2
	for <virtualization@lists.linux.dev>; Wed, 19 Nov 2025 01:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763517267; cv=none; b=s5D9LBWKYZgLFeQqL+N35dCA4h5gHNKbkYwn+MZ39/c33ktrNMQdFa59C+YebCUp8oeINxwLM/UvezyVPTl72S12L2EjK5Cu2wevZ0ko3VTMk84DTOzmKkTtL4XYAAasOVG03Kyc7qaOoFmAiVeC5Btn2zH6k22wV2EONulezjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763517267; c=relaxed/simple;
	bh=Ti4if+e0vZ3+Heb4vsKFgYIQ8JY3byZZQGyu2jg9Z6A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JwvnQ30x0uA+VuPNyqc6CyrXTsQveAivitHAhpvwMf5G9XLnrPZQ9EDDWwNRxXECRKEYFq27+ZQJkimQZSsbcfMLA/9Q2JIK7g0w/EoS07k6jgaSGynWxchaxR5bUSuVD6NrOIn+x41aBAGv2/SDICpvP6vrUjHpePixnvBPUS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gvg0Y4go; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gvg0Y4go"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763517265;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ti4if+e0vZ3+Heb4vsKFgYIQ8JY3byZZQGyu2jg9Z6A=;
	b=Gvg0Y4gogN1qneOKSTpkaNmmRA96NBEPrCAhOZQ00dzwD994T2fSGyCdAQHq80GXjk3StZ
	jx7GVPkZi6ZK23GsvhC36zkYVt/CdWbRiG8UipDdTjGp0cDVnTk8qf4dw4wUDSpSBypsuv
	G8Bk4C7cmlaJd42iTJjNkzsamB2cM+U=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-Y06fEKxbN_y9lgTjHoNAYA-1; Tue, 18 Nov 2025 20:54:23 -0500
X-MC-Unique: Y06fEKxbN_y9lgTjHoNAYA-1
X-Mimecast-MFC-AGG-ID: Y06fEKxbN_y9lgTjHoNAYA_1763517263
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-343d73e159aso13460843a91.3
        for <virtualization@lists.linux.dev>; Tue, 18 Nov 2025 17:54:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763517263; x=1764122063;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ti4if+e0vZ3+Heb4vsKFgYIQ8JY3byZZQGyu2jg9Z6A=;
        b=UJPKDFQdysnpnIMdjbdjo1+UidmObZcQIAF5tmzbg5mkezWHvTZAdjuKaw6ec7UfqT
         GZcF3eVedVIi8LaYMN5tu+dzlzqAh7QuUs5nNQ33aThr0BFaxMX/21oh019LCXr0y+LU
         44UPi0V7kxKnmmooXsnn5RKJ7Y+OvihAUvww6JJxyd+y16vKFQ0LIpKsiCqDUk/zefyh
         gKqir6OKjGK1cxK2HkPNLfhDFLFqreFCO9dS83lA6JxMsJXoiA+vczUaWIaM5Lxu5z9v
         TL9s8vtEeP+12t/nS9hFBk55+HRoJWTBFC4DAlDGZBpYW6UWTzYScsSuMZ/t0WZaE738
         MzPA==
X-Forwarded-Encrypted: i=1; AJvYcCXkFjwrE3BUPq9Eqm0NDjCmYftZ4/n8oYjquY8DSas2+kOH3q7v/CAZ58UKGcxyiL5sI4tsQUrisgPLOevTMQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzfOfZPgCzhNBRsSqbpYKkUuCW8wx3J8l/cPV0zoNFjx//JRtng
	ORa3QBpMg5wrUs1n2m/pkEU5qHh6TzxrYwzC8q9pKyMqiPMYj4kXoPVIX1mu4xkbrfFV/rYIdn4
	SBgYND+vqVYtqCK7DOoWq03bDMsrK1N6F3Si110QQ1nOOr17IQaHjPAnHWeyVyCeFTlCVZYVVXU
	uUvCducJhNP5mRz/73dEVv99iBmQsnZ4FpuLyZyn4VMaA=
X-Gm-Gg: ASbGncu8qYDVLN4ZmsL5TGfuG9Kjada/uC8PcWYkFS6Fvex66Piidn2Bv+Sd5lVE70e
	dCHp6xhf5hk0mG9+SG+mXXvtZdbCfSrV0BtcUeHgQ+Kklbf6Uhktly7nZ5eohvX62nXT//ieSjB
	mGNmTt6QM6Ka+Y3TXXUzAMDMrVyWPAvEdnWC4OsSJJ8PV43sR6ilTx9BRiBtSynfs=
X-Received: by 2002:a17:90b:3847:b0:340:e103:bfdd with SMTP id 98e67ed59e1d1-343fa73278cmr18556659a91.25.1763517262751;
        Tue, 18 Nov 2025 17:54:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF5GXGkEHQ50wOVjXeybBNs1hI+lnVX7iORT/ZASpo0ztu6fbH4EioPP1/R57VRfBgN1e8GgzjV0oQvyiZ1tT0=
X-Received: by 2002:a17:90b:3847:b0:340:e103:bfdd with SMTP id
 98e67ed59e1d1-343fa73278cmr18556631a91.25.1763517262213; Tue, 18 Nov 2025
 17:54:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1763278904.git.mst@redhat.com> <dde7267a688904e4304bebfdbc420877cca70891.1763278904.git.mst@redhat.com>
In-Reply-To: <dde7267a688904e4304bebfdbc420877cca70891.1763278904.git.mst@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 19 Nov 2025 09:54:10 +0800
X-Gm-Features: AWmQ_bmKidj7jFUERWFCVnMYooo3WyTNjYb-AYGW49thc84xS2-48DV1m8Bt6Ms
Message-ID: <CACGkMEsnS9GCYCq-QVqv7W0Em76KKyFeWXOhkHNJmUWh4bsG=g@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] virtio: clean up features qword/dword terms
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, 
	Paolo Abeni <pabeni@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Jonathan Corbet <corbet@lwn.net>, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-doc@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qqCnUoZEoKq1Xx4ZOzzwQoVc5yYPIMwJ9CIj8W6hTBw_1763517263
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 16, 2025 at 3:45=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> virtio pci uses word to mean "16 bits". mmio uses it to mean
> "32 bits".
>
> To avoid confusion, let's avoid the term in core virtio
> altogether. Just say U64 to mean "64 bit".
>
> Fixes: e7d4c1c5a546 ("virtio: introduce extended features")
> Cc: "Paolo Abeni" <pabeni@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Message-Id: <492ef5aaa196d155d0535b5b6f4ad5b3fba70a1b.1761058528.git.mst@=
redhat.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

