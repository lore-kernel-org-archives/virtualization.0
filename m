Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDC62040A7
	for <virtualization@lists.linux.dev>; Thu, 12 Jun 2025 08:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749717889; cv=none; b=FrdVMlpujkg8A0P1p/3YPTAn+TI8kPsGt7Z+soge3w918+4OiC1FupG9YCklfilg61KAN6Q9PhDXjuti3Aimy73t+4pdkJd+QYHWKzrTZx7V9edXXb5EL8238odV+YPyTSs9KEupmKCig73YnAZskdzm8VeyjgiICpI2c8jeGF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749717889; c=relaxed/simple;
	bh=rNTbSvQjmtm36dJjYb+8KYjVtBDjiIzJsQLY4I9jU7k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eS/0+SbFOCNpPe68iIXuVMsQdeCHih4tcPHDEyTDTl0PwKTGbBXc/4wfweqSmIqc2OGff/tUeUxLEBw8YueBW8AnUnyZAx9CDBM4JFTre5FdYZn8IwRO2oUlFPvdoNwAph1+rKkztcxbGDpdBaRDOa3VGmGp6qIFq0AUzIERmWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SAMufGDU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SAMufGDU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749717886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rNTbSvQjmtm36dJjYb+8KYjVtBDjiIzJsQLY4I9jU7k=;
	b=SAMufGDUkN5n3dfdltCIXWjY6HN2iSlp75gjnHQq3cxzex23nVV6kFo1kJxtG02i2Rykrg
	9O/jNbeYZZOXeqShTlfDmLpf5/Q8Ro4QyKtaK4zUJBbcUA1vrqHDTpqB+qKuTT0G1ApKc4
	UyfHcKlPJStl7oB0HXY2dRqf0oYctq4=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-114-xrHaF6njNdS_nTJZeOMIpA-1; Thu, 12 Jun 2025 04:44:45 -0400
X-MC-Unique: xrHaF6njNdS_nTJZeOMIpA-1
X-Mimecast-MFC-AGG-ID: xrHaF6njNdS_nTJZeOMIpA_1749717885
Received: by mail-yb1-f197.google.com with SMTP id 3f1490d57ef6-e812e1573ecso763473276.2
        for <virtualization@lists.linux.dev>; Thu, 12 Jun 2025 01:44:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749717885; x=1750322685;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rNTbSvQjmtm36dJjYb+8KYjVtBDjiIzJsQLY4I9jU7k=;
        b=oSp2lQPRzYihz8adY2EXV0UdqewFfhuTaOW+wWXeX34RymEAWHRlmbMUOSzHzVqYvj
         lZGoGAsXgaM9lqpy+lvpJiD6PZnmB7i+TkATXK98RPQsoZr2p/Ss+tbrbOu7XEw1ByjM
         7B2VJXGKzYeMCn2ecl66C4hIV+xopZoEhf0yfphrZm4qCmRc25AitwApq2yHSCzbmGuG
         Ht1UYpyb1xkssX1pUoHk7B7GSCs72qU6QP+LYcFKFupalbdsqbXp0CIUe7nL17qBruI2
         BmLdp7F24mfYzbyAmHsCtjjHpd0AmbpivkAWO9aTvhhgMPcyUxyfiJc+uV566/on/9N2
         uqdw==
X-Forwarded-Encrypted: i=1; AJvYcCXCNg5hjyH76wU/RRjE2HWy0rDz/T1HtCqg6BhzVXSu80IRfoXmN1zKIxFQymobhUud9rzYDPPtZfpUumNByQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzUB3twurIW+CVe/dxaM4fR/rM0huU9zoad48hutXPhE3rPINia
	Aaubrx18RNBKqPzOLHstkiP7j68klvAKlYbVIIPYv0pCJqHeV5CF5gUFhbFM5vhnU789XY1PmaX
	Smpkj6UviQcz0ugNkctF4B1zeQpWdR8+13M3KnDUmcgUffhAmBR+mGcilYdE9HfEqkVz5co5UyF
	hRPMU+cvaB2cKuFtmGqfDbuRloG50z34hm9gKfLVIiUxc=
X-Gm-Gg: ASbGncuZNSvHoK55GHfRNOWpu7fmmfPpgkHKCCG7tm1S84Sn4z1shKe3pvBwVoKD74B
	35RVhKjMO0ZwQ/uD61RymfGAsh8t+ZVDPXIy8yt30zm+glkDWZY9ffY9B+towEqkG+s9Pw+/Ao7
	S2dNGc
X-Received: by 2002:a05:6902:2611:b0:e81:4e9d:9e79 with SMTP id 3f1490d57ef6-e81fe6b8b7amr9216277276.40.1749717885015;
        Thu, 12 Jun 2025 01:44:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHpO7imw7/y6hUBA3+X+9+644bvWl/2xN24NgD0/xASJ+Z1iQt0UZZ7qIi1/vJ8aGKQCfn0PwMZVX01PvmLRPE=
X-Received: by 2002:a05:6902:2611:b0:e81:4e9d:9e79 with SMTP id
 3f1490d57ef6-e81fe6b8b7amr9216251276.40.1749717884673; Thu, 12 Jun 2025
 01:44:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAGxU2F6c7=M-jbBRXkU-iUfzNbUYAr9QApDvRVOAU6Q0zDsFGQ@mail.gmail.com>
 <20250612082102.995225-1-niuxuewei.nxw@antgroup.com>
In-Reply-To: <20250612082102.995225-1-niuxuewei.nxw@antgroup.com>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Thu, 12 Jun 2025 10:44:33 +0200
X-Gm-Features: AX0GCFs5PNoVhHhHZsKNXS6ADWJpjexmyZKqj4oyHShXjy9f_WC9YKjQLjFGOUk
Message-ID: <CAGxU2F4JkO8zxDZg8nTYmCsg9DaaH58o5L+TBzZxo+3TnXbA9Q@mail.gmail.com>
Subject: Re: [PATCH net] vsock/virtio: fix `rx_bytes` accounting for stream sockets
To: Xuewei Niu <niuxuewei97@gmail.com>
Cc: Oxffffaa@gmail.com, avkrasnov@salutedevices.com, davem@davemloft.net, 
	edumazet@google.com, eperezma@redhat.com, horms@kernel.org, 
	jasowang@redhat.com, kuba@kernel.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, 
	niuxuewei.nxw@antgroup.com, pabeni@redhat.com, stefanha@redhat.com, 
	virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: IGasCwoVfjufrk27utmqBlId6nTuMDLbkYGZQ3_7UbQ_1749717885
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 12 Jun 2025 at 10:21, Xuewei Niu <niuxuewei97@gmail.com> wrote:
>
> > On Thu, 12 Jun 2025 at 08:50, Xuewei Niu <niuxuewei97@gmail.com> wrote:
> > >
> > > > On Thu, Jun 12, 2025 at 01:32:01PM +0800, Xuewei Niu wrote:
> > > > > No comments since last month.
> > > > >
> > > > > The patch [1], which adds SIOCINQ ioctl support for vsock, depends on this
> > > > > patch. Could I get more eyes on this one?
> > > > >
> > > > > [1]: https://lore.kernel.org/lkml/bbn4lvdwh42m2zvi3rdyws66y5ulew32rchtz3kxirqlllkr63@7toa4tcepax3/#t
> > > > >
> > > > > Thanks,
> > > > > Xuewei
> > > >
> > > > it's been in net for two weeks now, no?
> > >
> > > Umm sorry, I didn't check the date carefully, because there are several
> > > ongoing patches. Next time I'll check it carefully. Sorry again.
> > >
> > > It looks like no one is paying attention to this patch. I am requesting
> > > someone interested in vsock to review this. I'd appreciate that!
> >
> > Which patch do you mean?
> >
> > Thanks,
> > Stefano
>
> I am saying your patch, "vsock/virtio: fix `rx_bytes` accounting for stream
> sockets".
>
> Once this gets merged, I will send a new version of my patch to support
> SIOCINQ ioctl. Thus, I can reuse `rx_bytes` to count unread bytes, as we
> discussed.

As Michael pointed out, it was merged several weeks ago in net tree,
see https://lore.kernel.org/netdev/174827942876.985160.7017354014266756923.git-patchwork-notify@kernel.org/
And it also landed in Linus tree:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=45ca7e9f0730ae36fc610e675b990e9cc9ca0714

So, I think you can go head with your patch, right?

Please remember to target net-next, since it will be a new feature IIRC.

Thanks,
Stefano

