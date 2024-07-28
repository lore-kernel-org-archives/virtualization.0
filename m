Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CA574418
	for <virtualization@lists.linux-foundation.org>; Sun, 28 Jul 2024 21:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722203648; cv=none; b=XD7T58ORFHKwrvXQL4KOMDTw+R8gxMQ5aTTDukH2sSXzWShMJNY867dIeXhi/YEcZvVJUr3mfQwgn+4rppI2HzJ4fZ59h1TBrCSIL5WRY6uww2iVpzymvWFaztBo34tGmbbV+Zw2CR49Fy4ud1Vcg58VM3Jzl7ZXeiBRUzCb8e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722203648; c=relaxed/simple;
	bh=+C/PIPaD6421joj/GWXpDjtLOsgHcGGcKsxopH953Uc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=abqppLTk767QeHvXXG7rVCgC/5Ntpf+3y/9Trcbyvq2ngIR4OAn5yRDL1zaAY9TPnW244QIpWR5553VOxZUNYTQ78nORxej5JCUHJgjD36Fe38fn1tAu41YAjI8fw1S+nGrirwiLntn4Os0XYDCMafqcv/iOz759SxH7toJit+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Evrt8zj0; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Evrt8zj0"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D6A758118E
	for <virtualization@lists.linux-foundation.org>; Sun, 28 Jul 2024 21:54:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IinuMOY9_-JT for <virtualization@lists.linux-foundation.org>;
 Sun, 28 Jul 2024 21:54:06 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::c34; helo=mail-oo1-xc34.google.com; envelope-from=ameryhung@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 21FC681189
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 21FC681189
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Evrt8zj0
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 21FC681189
	for <virtualization@lists.linux-foundation.org>; Sun, 28 Jul 2024 21:54:05 +0000 (UTC)
Received: by mail-oo1-xc34.google.com with SMTP id 006d021491bc7-5d5bb2ac2ddso1286777eaf.0
        for <virtualization@lists.linux-foundation.org>; Sun, 28 Jul 2024 14:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722203645; x=1722808445; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yp5X1TEr87hrQcZlApkbTdXfq9FpLIGhmw7b0AOp0ew=;
        b=Evrt8zj06SMVFDHAXU3OVyRvZp3j2tNOUZdx6+g7Q4l/mo69t3STR6JF/CWpGHOTyw
         stloZduwAP57BU7T1pfEnWzzEyAjgjH7j0UYp1EhXbzbLfkMH+JnneEn8wKh46N2fvWb
         KHNbf1DUQOjiAYz4AGdHH6IQuGU83/6IRaFvAwuDPMvDsYfx9pqrWuNH3oIqQUidsfgv
         A9XPbB6od95vzb3wkmfoaiyPnUHwczOTnB8J9wmG811EePl+4XSGeFwX9VD2t/w4wZT2
         tyaLjW7u2NvA5l0kP5PdXdobtZku7dvnElLTRMH5htItuFnkYo8zIkOYzUVNGhASgGQ3
         OtdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722203645; x=1722808445;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yp5X1TEr87hrQcZlApkbTdXfq9FpLIGhmw7b0AOp0ew=;
        b=kU1F/2B1VvYkvc70gWRk2eJa/6ErrVO5DQDbNQZa3G2+Fbei2dOo8ID1ehAN/tXBrJ
         a901TrmnlI1lNpoz/2n7y7Amn5ovKRdh0L6IqDfNjWlxy0eZSqmXTSW6lgAzytFN9ps/
         L+0CdzPijOIjsMdMxVk0rgF856/3WXXntJLoXBQdFGHE+YImfBz7tlkkdbh/oqhcEbcs
         KMLB+P4nNc7iT6yQjl9Hw24wrknMxa48K95eDlaRgaZ10qWVQS4dubzOAfCiB1KhgPkQ
         7cCWph/tgBYYwkjhD4/6PkS8167MUaLEtx99CidlUTY7E4Xq3nIwbz4xQIKkKUyGNMen
         jRiQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVVtPkA9LBMeLDTqTZ/0P4R8/GORYZdPstnElB8y6Lxfr/RBAdfU9OIWIWpHdqtQkPj5P/+V3Sx9vfWvmhAGgw4pHj6vMkBXw0vnQW6b2SuoePto6IIABRaA==
X-Gm-Message-State: AOJu0Yw8RurQpXS7AvzGtl/dZnlGR93Hcblsz014z+wobgvpjQeJiZFM
	f9Vhs+ocFLPpC1Slmp/lV3yrEeOZaDs+7MPfCDVerJys5L6wpj6oQqcNw9Z7mGPiJvBeX12LF+M
	qbh4UOfM9L8UxL96nsdKOQEsLae8=
X-Google-Smtp-Source: AGHT+IExiqE8SwBoar+SBdGvUoKTQ8aTZKE7dvIbMpV+Hz/pPT7kpLZKZhHhpV3bwaQ9cRA95CjTvrUaUpXJvozawmQ=
X-Received: by 2002:a05:6870:8092:b0:254:ef42:f6f7 with SMTP id
 586e51a60fabf-267d64e7210mr2447775fac.15.1722203644655; Sun, 28 Jul 2024
 14:54:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240710212555.1617795-4-amery.hung@bytedance.com> <ce580c81-36a1-8b3b-b73f-1d88c5ec72b6@salutedevices.com>
In-Reply-To: <ce580c81-36a1-8b3b-b73f-1d88c5ec72b6@salutedevices.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Sun, 28 Jul 2024 14:53:53 -0700
Message-ID: <CAMB2axNUbWD9=Xg8TkB8XBmjuNw9f==Njzvh4-OP8kNw40O0Lw@mail.gmail.com>
Subject: Re: [RFC PATCH net-next v6 03/14] af_vsock: support multi-transport datagrams
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: stefanha@redhat.com, sgarzare@redhat.com, mst@redhat.com, 
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, kys@microsoft.com, 
	haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com, 
	bryantan@vmware.com, vdasa@vmware.com, pv-drivers@vmware.com, 
	dan.carpenter@linaro.org, simon.horman@corigine.com, oxffffaa@gmail.com, 
	kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, bpf@vger.kernel.org, 
	bobby.eshleman@bytedance.com, jiang.wang@bytedance.com, 
	amery.hung@bytedance.com, xiyou.wangcong@gmail.com, kernel@sberdevices.ru
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 28, 2024 at 1:40=E2=80=AFPM Arseniy Krasnov
<avkrasnov@salutedevices.com> wrote:
>
> Hi Amery
>
> >  /* Transport features flags */
> >  /* Transport provides host->guest communication */
> > -#define VSOCK_TRANSPORT_F_H2G                0x00000001
> > +#define VSOCK_TRANSPORT_F_H2G                        0x00000001
> >  /* Transport provides guest->host communication */
> > -#define VSOCK_TRANSPORT_F_G2H                0x00000002
> > -/* Transport provides DGRAM communication */
> > -#define VSOCK_TRANSPORT_F_DGRAM              0x00000004
> > +#define VSOCK_TRANSPORT_F_G2H                        0x00000002
> > +/* Transport provides fallback for DGRAM communication */
> > +#define VSOCK_TRANSPORT_F_DGRAM_FALLBACK     0x00000004
> >  /* Transport provides local (loopback) communication */
> > -#define VSOCK_TRANSPORT_F_LOCAL              0x00000008
> > +#define VSOCK_TRANSPORT_F_LOCAL                      0x00000008
>
> ^^^ This is refactoring ?
>

This part contains no functional change.

Since virtio dgram uses transport_h2g/g2h instead of transport_dgram
(renamed totransport_dgam_fallback to in this patch) of VMCI, we
rename the flags here to describe the transport in a more accurate
way.

For a datagram vsock, during socket creation, if VMCI is present,
transport_dgram will be registered as a fallback.

During vsock_dgram_sendmsg(), we will always try to resolve the
transport to transport_h2g/g2h/local first and then fallback on
transport_dgram.

Let me know if there is anything that is confusing here.

>
> > +             /* During vsock_create(), the transport cannot be decided=
 yet if
> > +              * using virtio. While for VMCI, it is transport_dgram_fa=
llback.
>
>
> I'm not English speaker, but 'decided' -> 'detected'/'resolved' ?
>

Not a native English speaker either, but I think resolve is also
pretty accurate.

Thanks,
Amery

>
>
> Thanks, Arseniy
