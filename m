Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5AF25BAC9
	for <virtualization@lists.linux.dev>; Fri, 28 Feb 2025 10:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740737076; cv=none; b=LAyLI7wLUE9hpD9BsVJjg+lbKXkcEw2ePqehFQtOO96E1/D+7S1QV40AQoG0+oS2FyVOuzEvYd8DdNqON8C1Z+1fgJjAsU/faZXXW/1MDI+uiEuwaUefK4Rxv4nTyJW/7ukHbo1SevlwpiKVJzDolyydmKXRSGZp9SwpMIu6mLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740737076; c=relaxed/simple;
	bh=UuKQE9PiNiWTjYawC0D2E2T+N47JBs6uLT6vnIJ4QQ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FnuuNyFBYtqJhiEowtY1wlfrFvRkdDi2PENfSCiBJfgrAmQEJmBGZZk4HnWCkEEHbJCvTp6tdbIs8cnUiqQh2eZt7OhLt800KQ2WAo4fSdKWwt+v6UhmSMQdAOxsryz93qdfxMULfpOL0jcLU79lsE3tWJkbhur42g6/iA4Eeek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BVJSBrlf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BVJSBrlf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740737074;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sFknwG0iNq5Q5kJsZueQ+sfyg2R708bSAk3Lf0iOtWg=;
	b=BVJSBrlfHGWgpzCaTankw/BLSmB/YBOlTPgPe5irykpHrvNQdW6ETUI60KzL6n5KPqt7t+
	tq+69CpjdJ6aTIjP4YztT4UsXtXYe54ZqyT6Lkn258+8xzOBKzP1nU6nCFKnDe3VwA4oSI
	DE8RvNSHZzPZLPUzwFaEDNn7HHsvAJ8=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-geW2vEs9N4igZmD1dZnPFA-1; Fri, 28 Feb 2025 05:04:32 -0500
X-MC-Unique: geW2vEs9N4igZmD1dZnPFA-1
X-Mimecast-MFC-AGG-ID: geW2vEs9N4igZmD1dZnPFA_1740737071
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-ab7f6f6cd96so213618166b.2
        for <virtualization@lists.linux.dev>; Fri, 28 Feb 2025 02:04:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740737071; x=1741341871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sFknwG0iNq5Q5kJsZueQ+sfyg2R708bSAk3Lf0iOtWg=;
        b=VFPv78VMhv4jOoCYJ+kzB+ioENNuiaETGLR+5hV9jHdFr1QJk8OgGzvIL+DOpnWqKE
         8rXpNaSpEVGXYEMV9f/WvMG5PWvWoNKtbpiU0gcvwhgcwVBgOTiC0y/MQbGWq0GHj7Q0
         KMSErjlcxp0Fz9IxwJPBQ0zVxCMJE1JunktlXmtk7n1ogPo2cKyVnv/EfcZ1d/6Wp60S
         njNbXqaKvjGSk8qDol5EPrElmO2U4x+cb5VJzhkqGKAj2ETBfysZLW9DVSxHP2HPTDhl
         ReW1qtimmwVQPWStgfSqzUdcXCmhz75BmgnOFqdbkNetgMgodKOS6zIH482GXPSbrHIN
         qU5A==
X-Forwarded-Encrypted: i=1; AJvYcCX1f/yYPDQcjb8kZZq8Ax20C2uf3suqNU0uMUzBmOLs2o8lLj3T8LdK0hUhOo+qZVTIiN6v5EuxrrFf9y/vSg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyU3E0r7nKFM75dD+4g8gsJzwENlHOu7SWAWBuMjVqjozQNNysm
	xQ4kC8KymXxoBjxUVR8IMnf+lIoRD7vU3lsMW8RoipLdaqh4FtlP1rdB8gAv2eti94Pr6tQExxQ
	6FCwU+93xBmeo6Mg44LCZftn93rXUJmXixMCe4Ik4ZFYJeta8uUnQ0UdVF4deBCXgPDKfrDHsZt
	DB7eJSV22l0D0qCuc2292/pWw++dQah2KReS453jo=
X-Gm-Gg: ASbGncvOl0RGace5TTDJfz9ZiYD3GCStN2MF4eEEmAiR40ZsftVJK6g8+CcboyMcQ7N
	PR0i22LZQAqj9KTrXqLN4xGHLjpDy3fLEr6O1xaoNe+tgRCCvcASDbpsT5gvgEF/xcgd5LSehvQ
	==
X-Received: by 2002:a17:907:3d88:b0:abc:919:a989 with SMTP id a640c23a62f3a-abf2682e053mr246635266b.48.1740737071089;
        Fri, 28 Feb 2025 02:04:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFlP3JKJrSRB/JTuQ4dTL5H95aY/z5Nm2RXbOFZIVZJxtaPYIfL4JwvtC2IWGfuLodoaul4Om5m1WS3z/d2xWM=
X-Received: by 2002:a17:907:3d88:b0:abc:919:a989 with SMTP id
 a640c23a62f3a-abf2682e053mr246631866b.48.1740737070662; Fri, 28 Feb 2025
 02:04:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250218023908.1755-1-jasowang@redhat.com> <174038523026.3048719.1870378720430783513.git-patchwork-notify@kernel.org>
In-Reply-To: <174038523026.3048719.1870378720430783513.git-patchwork-notify@kernel.org>
From: Lei Yang <leiyang@redhat.com>
Date: Fri, 28 Feb 2025 18:03:52 +0800
X-Gm-Features: AQ5f1JrhkprlWfBZR5KYsNgoMHpIaTrKPDWKrlUwM9FIxE_uaiyMqKH3Hp4X8Tg
Message-ID: <CAPpAL=zF3oFO3OSO793Hk0YQGh2PK7RsdjZ5bD19-EHFe_6CyA@mail.gmail.com>
Subject: Re: [PATCH net-next] virtio-net: tweak for better TX performance in
 NAPI mode
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, xuanzhuo@linux.alibaba.com, 
	patchwork-bot+netdevbpf@kernel.org, eperezma@redhat.com, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: C7XlUOMyMQ1vmdwUmJIdyxFGT443cnT0qRSj84HSxjc_1740737071
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I tested this patch with virtio-net regression tests, everything works fine=
.

Tested-by: Lei Yang <leiyang@redhat.com>

On Mon, Feb 24, 2025 at 4:20=E2=80=AFPM <patchwork-bot+netdevbpf@kernel.org=
> wrote:
>
> Hello:
>
> This patch was applied to netdev/net-next.git (main)
> by David S. Miller <davem@davemloft.net>:
>
> On Tue, 18 Feb 2025 10:39:08 +0800 you wrote:
> > There are several issues existed in start_xmit():
> >
> > - Transmitted packets need to be freed before sending a packet, this
> >   introduces delay and increases the average packets transmit
> >   time. This also increase the time that spent in holding the TX lock.
> > - Notification is enabled after free_old_xmit_skbs() which will
> >   introduce unnecessary interrupts if TX notification happens on the
> >   same CPU that is doing the transmission now (actually, virtio-net
> >   driver are optimized for this case).
> >
> > [...]
>
> Here is the summary with links:
>   - [net-next] virtio-net: tweak for better TX performance in NAPI mode
>     https://git.kernel.org/netdev/net-next/c/e13b6da7045f
>
> You are awesome, thank you!
> --
> Deet-doot-dot, I am a bot.
> https://korg.docs.kernel.org/patchwork/pwbot.html
>
>
>

