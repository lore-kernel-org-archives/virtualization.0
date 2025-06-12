Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6296320371F
	for <virtualization@lists.linux.dev>; Thu, 12 Jun 2025 09:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749720625; cv=none; b=DZTJin1xK8DzcHZe5ZmQCdfbAh0hlfPXjrBq/kr2mhGOCbzpJ3s74uAjNAoBiyYcaR7nlJfLdljEZ1SD8sb1B7byqo6ZyJrEVQsDQgMeId9kQQNC72Dr30jn97xTRAaMwrqXxLaXHItUFr2y1iIe0YL1DzPOwq97CZBffy+7RKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749720625; c=relaxed/simple;
	bh=4ygq9Ksz0EzPSaZG9OKYAVE1YdwDPmeAsjiGh8gvFqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=XA1GNY1XY1tx7VtpAnxb8oRDrksyWu9Mk2yVeXx/NN+JvFnLlMUlH9bu5nPXYr8ap1BOPmWwXC7P1HcWym1ZRTtT2y4wDHWBG7YoSjvWIScXoJwOTn1ix4/AIFg6iGh/g0+dq21ClsCwXWdfJ9N2ua3mLmSmJrf71qEAmsoP+ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BtA1Y01P; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BtA1Y01P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749720622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4ygq9Ksz0EzPSaZG9OKYAVE1YdwDPmeAsjiGh8gvFqo=;
	b=BtA1Y01PE7MeB1UAU535WWh6fBVD13Ahwyi3/LS1WyNb/oV6F4wj/fNNTl6QDt21JDuSDn
	JcoXsFbPZLAHCcPAHbb//4iA1KZexgQ4BcDSzKkTCsJn5GcGrsXK0u2+VCDr7rqnFvT/lk
	eSEctaAdvOURFXisq3WzzJyz0xrZdmg=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-SSQZNUM0MsKtm4JWj_odwA-1; Thu, 12 Jun 2025 05:30:21 -0400
X-MC-Unique: SSQZNUM0MsKtm4JWj_odwA-1
X-Mimecast-MFC-AGG-ID: SSQZNUM0MsKtm4JWj_odwA_1749720620
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-ade6db50bb4so53978466b.2
        for <virtualization@lists.linux.dev>; Thu, 12 Jun 2025 02:30:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749720620; x=1750325420;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ygq9Ksz0EzPSaZG9OKYAVE1YdwDPmeAsjiGh8gvFqo=;
        b=JircAUHDLhFa/LnKMZ+PBHBlWBticQ2BvSHC0nI04qEYmeZtGuNre5UZccpCpDkGmC
         K1Y8qFd4bJkC/xlXhOjZv9zZHJcwTc1da7VX31XzqirGE4skCil4LH7+TO84E5E2+h75
         0CA3SaZQIVGnSV+WXpoEUHvnzPEqeejXdjsFXnHVwO2LOS/Wqh2lYwOpjVcFLH+D5taE
         5Ke+ncKJZwlo7g6sSKHSumMRGjvvuzpegbwLSeSDTK9cz06iGf1WSbiXJI9TKJh2+xzv
         NBcWOXvCidQBL/BTMThie5d4PfupqiXtTOuKdrTVdUEw5cOiRWuDuM4p3Kbk4RJQAcij
         ckyw==
X-Forwarded-Encrypted: i=1; AJvYcCXg6jovif6GbgrqOZtmP91kBjRJSYvUj3i1WKxKC1lRxen4jIkqAZfPGszWqxgwnC8teqBCjsY8AsFpuDKVww==@lists.linux.dev
X-Gm-Message-State: AOJu0YxKZG0gFZzV9XwE+GQ0B5u6aTIfynXG6HEPoPz2c2T0e8wqqn+z
	6IRWsPNJak+A1sdnFNn+ITFZ0ojgvYRtJOa6v8KwgKsVLi6w1UtJGwX8w36g5897xLN2BX8bvHl
	yQxqPPhECmtEpqE+TILnkQnLjo3NATBa4r2u89Onfft7hVAgS1kV3uAfUMQO7MCAUPKDm
X-Gm-Gg: ASbGncvjoBLuBRldNJ5ehN82YhvvFkELgxNliz5yuczwS640+MKz+drItsmEGbTUxSm
	sxgkRkDWxjSO4xtyVJdVoFdngby+oSytrku/83xV+i4nptT+hdgA2+LHT15Hwa+hcN4Zk2QHWw3
	v1Bmp0itKHFy9AhTXBwjjdgvSXJStT+xSErx46jkVo59EvuPuHig8jtOKZwHQszU4k+h9SA8ZUG
	Yh/i+/3FtiJaI7yorPlIDvayyiCHb5nXI9Vr1TAYokCjq444Lnbd+kYiU/BzdWFe9Eh+8+kp42u
	ob1pHlZAV+83spNEEiWB6HLAHOTM
X-Received: by 2002:a17:907:9404:b0:adb:14f3:234 with SMTP id a640c23a62f3a-adea8d2a7femr202986066b.8.1749720619718;
        Thu, 12 Jun 2025 02:30:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFW/Lug4eBXscrw4Su9HuFYOFwJuHPtuXS+7rbCJ7Q+kF4SSqVkab1vunsa/YWLwUrWOIkfLw==
X-Received: by 2002:a17:907:9404:b0:adb:14f3:234 with SMTP id a640c23a62f3a-adea8d2a7femr202981966b.8.1749720619118;
        Thu, 12 Jun 2025 02:30:19 -0700 (PDT)
Received: from sgarzare-redhat ([2001:67c:1220:8b4:edf4:d580:147e:ea8e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adead4cde8asm102655966b.7.2025.06.12.02.30.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 02:30:18 -0700 (PDT)
Date: Thu, 12 Jun 2025 11:30:16 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Xuewei Niu <niuxuewei97@gmail.com>
Cc: Oxffffaa@gmail.com, avkrasnov@salutedevices.com, davem@davemloft.net, 
	edumazet@google.com, eperezma@redhat.com, horms@kernel.org, jasowang@redhat.com, 
	kuba@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mst@redhat.com, netdev@vger.kernel.org, niuxuewei.nxw@antgroup.com, 
	pabeni@redhat.com, stefanha@redhat.com, virtualization@lists.linux.dev, 
	xuanzhuo@linux.alibaba.com
Subject: Re: [PATCH net] vsock/virtio: fix `rx_bytes` accounting for stream
 sockets
Message-ID: <gqwp3mkdx3uaedmxx4kqvhvbgfvp3dtabm5ciejitk4x573oww@ek4agftt56np>
References: <CAGxU2F4JkO8zxDZg8nTYmCsg9DaaH58o5L+TBzZxo+3TnXbA9Q@mail.gmail.com>
 <20250612085514.996837-1-niuxuewei.nxw@antgroup.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250612085514.996837-1-niuxuewei.nxw@antgroup.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _JriFYEoH0Tekq_t6FIJHy3eK0BvgejzsMWDb3Im9Io_1749720620
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Thu, Jun 12, 2025 at 04:55:14PM +0800, Xuewei Niu wrote:
>> On Thu, 12 Jun 2025 at 10:21, Xuewei Niu <niuxuewei97@gmail.com> wrote:
>> >
>> > > On Thu, 12 Jun 2025 at 08:50, Xuewei Niu <niuxuewei97@gmail.com> wrote:
>> > > >
>> > > > > On Thu, Jun 12, 2025 at 01:32:01PM +0800, Xuewei Niu wrote:
>> > > > > > No comments since last month.
>> > > > > >
>> > > > > > The patch [1], which adds SIOCINQ ioctl support for vsock, depends on this
>> > > > > > patch. Could I get more eyes on this one?
>> > > > > >
>> > > > > > [1]: https://lore.kernel.org/lkml/bbn4lvdwh42m2zvi3rdyws66y5ulew32rchtz3kxirqlllkr63@7toa4tcepax3/#t
>> > > > > >
>> > > > > > Thanks,
>> > > > > > Xuewei
>> > > > >
>> > > > > it's been in net for two weeks now, no?
>> > > >
>> > > > Umm sorry, I didn't check the date carefully, because there are several
>> > > > ongoing patches. Next time I'll check it carefully. Sorry again.
>> > > >
>> > > > It looks like no one is paying attention to this patch. I am requesting
>> > > > someone interested in vsock to review this. I'd appreciate that!
>> > >
>> > > Which patch do you mean?
>> > >
>> > > Thanks,
>> > > Stefano
>> >
>> > I am saying your patch, "vsock/virtio: fix `rx_bytes` accounting for stream
>> > sockets".
>> >
>> > Once this gets merged, I will send a new version of my patch to support
>> > SIOCINQ ioctl. Thus, I can reuse `rx_bytes` to count unread bytes, as we
>> > discussed.
>>
>> As Michael pointed out, it was merged several weeks ago in net tree,
>> see https://lore.kernel.org/netdev/174827942876.985160.7017354014266756923.git-patchwork-notify@kernel.org/
>> And it also landed in Linus tree:
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=45ca7e9f0730ae36fc610e675b990e9cc9ca0714
>
>I misunderstood Michael's point. I am new to this, and not familiar with
>the process. Sorry about that...

Don't worry ;-)

Hope now it's clear!

Thanks,
Stefano

