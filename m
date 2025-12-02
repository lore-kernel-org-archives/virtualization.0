Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B949D2FF177
	for <virtualization@lists.linux.dev>; Tue,  2 Dec 2025 06:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764655440; cv=none; b=drSTf7ziY1kCuOkMf2VKbTehw7zw+jkMQ/3YsxyzvX9+6UUgnhLUHMv3BpF/UfAdRdvrhwqSy45qhfVKIrHMmtg3jCmvT+efGcx83ygNA91Nqy4ZI1dB4UWcCrAUmMjL1uXxkTzzESQ+YeGmDlsB+ZfoAH3yPc8++EMZJr+qz9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764655440; c=relaxed/simple;
	bh=9yZtKrMIr+oRDcDzNymlk5LC69nAsOOxWz1MSteFcvk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pNzTnYZpthbShtyiSt20PajJ6p5p2nQkTQfa/wyNV6WQzpucFmNEZ+TDcTGw9gPONZRnmiKh9Guz0HKS6/itnoeViaighw/POcqGHEyEB7/fNq0NCGt5P4+AWtryzdSoQJtWAFQ8QdOhGiY1nQAdCKcPmq0Vty1PviRopSRhUag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IsF8+MBR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IsF8+MBR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764655435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9yZtKrMIr+oRDcDzNymlk5LC69nAsOOxWz1MSteFcvk=;
	b=IsF8+MBRu6EcOt7q+OVy/lq6KhBVbbkFhGHDnWH77voz0aIvxCkJXHKYqgoV2CEXiT9J/q
	7VnMhWo9vovWWnYtYmJx3JZb6Tyo4IPQyxCB4SN9CIeUWbcrefvC6gBSUslDETGxMVbtVB
	jp0JH1crv796JuO1G3beepVyCHoyjmo=
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-soNkB28rMFCW5d9ltQ5yaA-1; Tue, 02 Dec 2025 01:03:51 -0500
X-MC-Unique: soNkB28rMFCW5d9ltQ5yaA-1
X-Mimecast-MFC-AGG-ID: soNkB28rMFCW5d9ltQ5yaA_1764655431
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-5dbcb1740ccso1514901137.1
        for <virtualization@lists.linux.dev>; Mon, 01 Dec 2025 22:03:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764655431; x=1765260231;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9yZtKrMIr+oRDcDzNymlk5LC69nAsOOxWz1MSteFcvk=;
        b=nUqS3+Ai8iJFyboLKIn3/YaE9NFAHKHNrLiXJU3WATSGUiXUp2TP1W5ethpP1RQU+1
         xikdj3Rjti82bCET8k//xKA4iQQqFLzjcMxtMwlq6B9Vcix3g6MJtM2Gf3kpDrBXERvT
         Mt2xmy29WwcEH9Lt+WhSuFduosdtXfwqg87KeOaEmh6xlR87K/PwOKd2CaNFZShatE41
         KwAADX/M5f7+Kg6wweiq1SR3rbPvPsmC7YBMnv0M4a39s4H1/LSJsLlVphMKIxcAVbSm
         Xn42UAQYoyZJpWMwXm7fp8YVuc54MJheKScwDBVDvycYT+H53szGvXqnyYMG6+QQ+Mqx
         RFOg==
X-Forwarded-Encrypted: i=1; AJvYcCVTPIjqeSTjjR6W7Jti/G9CNyP0e3KfxcZo9bvYaWa0/nwrD5Fkz/nB7WqtzkFHNiCYU4vnINeSa0xi9MLR/A==@lists.linux.dev
X-Gm-Message-State: AOJu0YzKfPyWP2Buwj4B6Hv3LTzHjeEZsPsvKrmUrmSdMiuNH6CVCMEH
	/Xgpy5CRkZMFzlb1TZbfvdADnyFXNzxyvxWMwr0nrD61m2nrHg2SRw8URzcs02dyKvg2qviUk0J
	RFhvV4p3g9JUZA38dRk2aL4m7XcpWZrPOIWsunS8in4iKEXLNdStJcKGp2I8ZDHLfNTFqp2mnoN
	rhPGwRoBf4wOzg49oUTTw4QHctnhUBEGRvhqx8ej1CeEA=
X-Gm-Gg: ASbGncu9g55mF5lPT08/JC+L4AiYVKWRiT4fMrK0ilZyrrMkbqM2DAp4/nPD0VSIrTF
	S7ycQurKpAnN8owsKJJ+Gp/5gFmOxpAaqIgV0RRFQqlXAlknX/zi1t9doPZejBDoLhAO6rvo6SW
	d0BKcPJzS43sR/C9kmA2XA0eTgoiaiP5zb9FBtqq6Q29NbcAMe1h8LCQMXR0QDA3DfaNk=
X-Received: by 2002:a05:6102:943:b0:5e1:ef48:271f with SMTP id ada2fe7eead31-5e2243b0ae6mr10533774137.24.1764655431110;
        Mon, 01 Dec 2025 22:03:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHwP5aHgNd3I5TiBLGyqEh9KU4ibLdE1nzCHwWBtB5W9yqrcXhSdXjvk1r3jTbN6h8btYD3Zn35q6xLUh9X/dc=
X-Received: by 2002:a05:6102:943:b0:5e1:ef48:271f with SMTP id
 ada2fe7eead31-5e2243b0ae6mr10533766137.24.1764655430705; Mon, 01 Dec 2025
 22:03:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <40af2b73239850e7bf1a81abb71ee99f1b563b9c.1764226734.git.mst@redhat.com>
 <a61dc7ee-d00b-41b4-b6fd-8a5152c3eae3@gmail.com> <CACGkMEuJFVUDQ7SKt93mCVkbDHxK+A74Bs9URpdGR+0mtjxmAg@mail.gmail.com>
 <a9718b11-76d5-4228-9256-6a4dee90c302@gmail.com>
In-Reply-To: <a9718b11-76d5-4228-9256-6a4dee90c302@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 2 Dec 2025 14:03:32 +0800
X-Gm-Features: AWmQ_blpD6OfG3aBJ7E21a-JAzhs-ua7-f4l8pJe0A5pP3XukKz4YUOSlliVbTY
Message-ID: <CACGkMEvFzYiRNxMdJ9xNPcZmotY-9pD+bfF4BD5z+HnaAt1zug@mail.gmail.com>
Subject: Re: [PATCH RFC] virtio_net: gate delayed refill scheduling
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, 
	Paolo Abeni <pabeni@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	bpf@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: EDzGOQ4V4VHgGjsCPBF0uSurRkl4zUlnT98piCOmjzg_1764655431
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 1, 2025 at 11:04=E2=80=AFPM Bui Quang Minh <minhquangbui99@gmai=
l.com> wrote:
>
> On 11/28/25 09:20, Jason Wang wrote:
> > On Fri, Nov 28, 2025 at 1:47=E2=80=AFAM Bui Quang Minh <minhquangbui99@=
gmail.com> wrote:
> >> I think the the requeue in refill_work is not the problem here. In
> >> virtnet_rx_pause[_all](), we use cancel_work_sync() which is safe to
> >> use "even if the work re-queues itself". AFAICS, cancel_work_sync()
> >> will disable work -> flush work -> enable again. So if the work requeu=
e
> >> itself in flush work, the requeue will fail because the work is alread=
y
> >> disabled.
> > Right.
> >
> >> I think what triggers the deadlock here is a bug in
> >> virtnet_rx_resume_all(). virtnet_rx_resume_all() calls to
> >> __virtnet_rx_resume() which calls napi_enable() and may schedule
> >> refill. It schedules the refill work right after napi_enable the first
> >> receive queue. The correct way must be napi_enable all receive queues
> >> before scheduling refill work.
> > So what you meant is that the napi_disable() is called for a queue
> > whose NAPI has been disabled?
> >
> > cpu0] enable_delayed_refill()
> > cpu0] napi_enable(queue0)
> > cpu0] schedule_delayed_work(&vi->refill)
> > cpu1] napi_disable(queue0)
> > cpu1] napi_enable(queue0)
> > cpu1] napi_disable(queue1)
> >
> > In this case cpu1 waits forever while holding the netdev lock. This
> > looks like a bug since the netdev_lock 413f0271f3966 ("net: protect
> > NAPI enablement with netdev_lock()")?
>
> Yes, I've tried to fix it in 4bc12818b363 ("virtio-net: disable delayed
> refill when pausing rx"), but it has flaws.

I wonder if a simplified version is just restoring the behaviour
before 413f0271f3966 by using napi_enable_locked() but maybe I miss
something.

Thanks

