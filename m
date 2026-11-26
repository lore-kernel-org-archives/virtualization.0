Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795688079;
	b=ERoKh78LZU49ahWtMqiAfJ1GG1Xym7ZTd2btmb8j9PZwdXgUnQBBKFCMGj6SiVJ2wXG5
	 etBm4lWhWOEvU1usOWGQ22hsOoay6rsp4V4OrdhxFbAlHZlRRRsVdiJ/BWKiS61nYNhfL
	 +bZ+znYQPmoLfxHgH001e+PGo+t+A/kc7bHwNmZtWZ47COMqFYQnw4PyAZHPY94qu6byV
	 P4xDK8LyoXYzoecFmPQGsTBPlwg6oLR4oCwgIgDMTK4Q7dapC6vIhRpeDoJ+fky84mEOS
	 4yfRyhvXls6RRLsuaTVNnc4J/8rzBa3PYFciiP1o2Bq0VkhU1Mg+W/GAIKwaEjP8j5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795688079;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=BnEINIidcy7TeGrgKBkYjEF8byD48m59WTwJN6efYCU=;
	b=o9UZDJ9wMOt418QZkriGldanKMbY5fSzlBuaaAWOtZn4J1n3bj9SKfy6kxxc3uCIEZjx
	 jzps6nbETq668c21vBNlDblIeo5A0ak/DXm2PdA8FT6NlyWXXysYDyBWEGrslH0oO7Iu8
	 ZuYNQcr8LsYK+1hJq+M0ry1EEXP89zy//j0dmoiF4Ni0XP2hz8ANuqbo7+z1x4lYoSwuM
	 mmPpLPp6HwRVybm2aVPMZjde/DZbrAkQj89qSZOMRcDveyvbkmWIi0YsKuiigYRXjmDoM
	 mrVrNIq1FZGW7+u3LaaqGDw8aJVmeiIIBgG01R9BKOCwdqU508QTsIs7tNbqebjQ+Gg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hHxQTlrs;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BA7606A6A6
	for <virtualization@lists.linux.dev>; Thu, 26 Nov 2026 10:14:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 01BA7606A6A6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hHxQTlrs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795688078;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BnEINIidcy7TeGrgKBkYjEF8byD48m59WTwJN6efYCU=;
	b=hHxQTlrselbTJyUuztDOgzRIZkg4AQXTk6FqObM3MD5OXsNDAyTrnqudYgEN9h9k7791ht
	TaZl2I3DLhA8h+vgAgR+/4nYBGzqGHGRYQ98VtSpT3lsToDJEa5f3QLsfRudajtXIWsSKR
	k9oAjDWrgokHeOs9N5pxNAW6Kc6txP4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-Z3LIbYh_O7CSJ3blAOMhvQ-1; Thu, 26 Nov 2026 10:14:35 +0000
X-MC-Unique: Z3LIbYh_O7CSJ3blAOMhvQ-1
X-Mimecast-MFC-AGG-ID: Z3LIbYh_O7CSJ3blAOMhvQ_1795688075
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48e29c25101so3014741f8f.3
        for <virtualization@lists.linux.dev>; Thu, 26 Nov 2026 02:14:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795688074; x=1796292874;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BnEINIidcy7TeGrgKBkYjEF8byD48m59WTwJN6efYCU=;
        b=aZOLRioBKB9Pak9brQcVFtyl4xvp3Y5kMn5czwNRDmt5LmQ7KcV57YwCO6GxFAXzJs
         5Ijx9ZQ/Edy0bYRhi9QulFD3ofWUXc29F6oivQfrZXSSLoJ+QyLxGGf4PiwJ9FPGmb6G
         H01GnG62yM97eupxz1cXfakCX3Qa0W6kt3RVkQ2q7zppWkstYQExV0/Nx/s6DiMdd1ad
         RKYj0YlPU6xU68ZY0WOwmJogJ+cab60cfrmAhJGZb8AzaEqd9lgke7tsTMpjciQrWYda
         PXt6Tk0xYHgX1Ce8ROHecedIu/15gIXLJNX5yXl4emIE/58rl0J92KEfphgIfCw1CEWE
         lwoQ==
X-Forwarded-Encrypted: i=1; AL+hErGBYCrD/fwehBcq9SuIzwf+hXghjWpGGK0j7ouqJgh+Dhbt1CEygjw6m9rwvAppSI51kku8XeSo9KP7b/f6eg==@lists.linux.dev
X-Gm-Message-State: APuU4Z9Pru+W+0Mog6m8Fs3KX4x9IlTtjdZKwThyc87X1PoWYyOeWeui
	FEbc2jWodUioP+SZes9byrRYasYMedqDN5UtR5avZ+zcHAUqCmpNQBO8DoyBlOsvS0mMGNeMe2a
	5VBLhd0o+bKqdD4uVGGod2LsE3fT5gFyXmfohsIm6c1xN6g7+s8byIm0b0OPjwJFmNien
X-Gm-Gg: AZFdTZdsoE3E47dqMz6GXiKGC1vzyUzaIPwvdW1NoOxgdTcl00CKNVVFnMMvd9rCROi
	/7oNePGcq5tUx29sPpZcPdsMxcrrQBTE3YLPZ2b0/5HEj9FFxJ74OypH500Fy67NGx/wOHUvknj
	82DAsrGTh4E+3E/Q4nhkgY6/xoU5Ue6633pND9rY3JluPGiVSuUBDppynnDYznfrc463r2ZYwU6
	c4S/ce7EXXQXXIsz8hvdjBmtpWoRmdzzsSQRJNQUbKPUvpGknUZ/4E31lNtXUv/DCg+is1UqO8l
	g6k8AVBu/LkfZBF5EOJKzOpTn0nhzOS30Dz77NpS+hpF07NbAw0Z5QWdJCWdAduWX3/dD7tplcv
	AQCIY4Eh3+GGqq/Dr7SNSfLjKfTVIa80YJE8a2linUAFJBqJ8978uWQ==
X-Received: by 2002:a05:600c:1d04:b0:4bb:685e:cc42 with SMTP id 5b1f17b1804b1-4bb88817e4emr429734005e9.18.1795688074521;
        Thu, 26 Nov 2026 02:14:34 -0800 (PST)
X-Received: by 2002:a05:600c:1d04:b0:4bb:685e:cc42 with SMTP id 5b1f17b1804b1-4bb88817e4emr429733645e9.18.1795688074082;
        Thu, 26 Nov 2026 02:14:34 -0800 (PST)
Received: from sgarzare-redhat ([80.116.143.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab69bf680fsm45686158f8f.14.2026.11.26.02.14.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 02:14:32 -0800 (PST)
Date: Thu, 26 Nov 2026 11:14:26 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jia Jia <physicalmtea@gmail.com>
Cc: netdev@vger.kernel.org, stefanha@redhat.com, bobbyeshleman@gmail.com, 
	mst@redhat.com, jasowangio@gmail.com, eperezma@redhat.com, 
	xuanzhuo@linux.alibaba.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 4/5] vsock/virtio: coalesce native RX
 write-space notifications
Message-ID: <awgGJECGxVi-40Tq@sgarzare-redhat>
References: <20261103041134.33310-1-physicalmtea@gmail.com>
 <20261103041134.33310-5-physicalmtea@gmail.com>
 <auxHe77Kv3tS4hjJ@sgarzare-redhat>
 <CAJwVaMK6UpxOmCbuzGK15h+DhN5H6cj6cy-=gCHtSxoVbLfzwA@mail.gmail.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <CAJwVaMK6UpxOmCbuzGK15h+DhN5H6cj6cy-=gCHtSxoVbLfzwA@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: In_cHmIQbAexWuDvgJyShY6CZ5hbKcJWnftDY2csQLA_1795688075
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 06, 2026 at 08:49:17PM +0800, Jia Jia wrote:
> >
> > On Tue, Nov 03, 2026 at 12:11:33PM +0800, Jia Jia wrote:
> > >Each received packet can update peer credit and call sk_write_space(). A
> > >writer cannot consume that credit while the virtio RX worker retains the
> > >socket lock, so repeated native write-space notifications in one RX batch
> > >are unnecessary.
> > >
> > >This patch coalesces write-space notifications on the native AF_VSOCK path;
> > >data-ready remains per-packet here.
> > >
> > >The batching patch establishes batch ownership before its first packet.
> > >This lets this patch record a pending notification for that packet and
> > >flush it even if the packet immediately ends the batch. Deliver it while
> > >holding the socket lock to preserve the callback context of the existing
> > >receive path. A following patch changes that timing together with
> > >data-ready handling.
> >
> > Can you report performance data related to this patch also here?
> >
> > IIUC this is not giving a lot of advantage, so my question is if this
> > more complexity really add a value for us.
> >
> 
> Sure. The performance tests currently cover patches 4 and 5 together,
> so I will include those results here.
> 
> They do not add another broad throughput improvement. I kept the
> combined notification change because of the cycles/byte results.
> 
> With P1-P3 only, against baseline:
> 
>   Buffer size  baseline cycles/B  PATCH cycles/B  cycles change (95% CI)
>   64B        66.728    61.220  -8.25% [-18.99%, +3.91%]
>   256B       14.363    14.515  +1.06% [ -4.22%, +6.64%]
>   512B        7.792     7.578  -2.74% [ -6.55%, +1.23%]
>   1K          3.988     4.032  +1.09% [ -1.64%, +3.88%]
>   4K          2.063     1.973  -4.38% [ -8.23%, -0.37%]
>   8K          1.702     1.667  -2.06% [ -7.99%, +4.25%]
>   16K         1.473     1.475  +0.17% [ -5.06%, +5.68%]
>   64K         1.385     1.358  -1.96% [-10.61%, +7.53%]
> 
> Only the 4K interval excluded zero. With the full series, against
> baseline:
> 
>   Buffer size  baseline cycles/B  PATCH cycles/B  cycles change (95% CI)
>   64B        65.282    57.843  -11.40% [-13.77%, -8.95%]
>   256B       14.710    13.813   -6.10% [ -7.89%, -4.28%]
>   512B        7.709     7.188   -6.75% [ -8.79%, -4.66%]
>   1K          4.075     3.862   -5.23% [ -6.80%, -3.63%]
>   4K          2.034     1.887   -7.21% [ -8.67%, -5.72%]
>   8K          1.664     1.568   -5.78% [ -7.83%, -3.69%]
>   16K         1.450     1.385   -4.48% [ -6.08%, -2.86%]
>   64K         1.338     1.317   -1.51% [ -3.21%, +0.22%]
> 
> From 64B through 16K those intervals stay below zero. 64B through 1K
> did not show that in the P1-P3 run.
> 
> This is also why I spent the time making this work with sockmap.
> 
> The value I see is lower RX CPU cost, not another large throughput
> gain. I am still unsure the extra code is worth it, and I would like
> your opinion.

Thanks for the numbers!

Both tables are against baseline, but the two baselines are a bit
different (e.g. 66.728 vs 65.282 for 64B), so it's not easy to see the
real contribution of P4/P5. Can you compare the full series directly
against P1-P3?

Anyway, IMO the big win of this series is P1-P3 (throughput), while
P4/P5 add a lot of complexity (saved native callbacks, new af_vsock
helpers, sk_callback_lock, sockmap corner cases) for a ~5% of CPU
cost, without throughput improvement.

So my suggestion is to split the series: send P1-P3 first, so we can
focus the review on them and merge them, and then send P4/P5 (squashed)
as a separate series. That way we can also evaluate the direction
suggested by Bobby (batching in read_skb() + coalesced sk_data_ready(),
like TCP), that may allow us to avoid saving the native callbacks at
all.

WDYT?

Thanks,
Stefano

