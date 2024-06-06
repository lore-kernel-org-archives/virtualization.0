Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B735D29CE7
	for <virtualization@lists.linux.dev>; Thu,  6 Jun 2024 07:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717660631; cv=none; b=IWsqo9VkvowdXTxFri7D3J7geZMjjdaKck0e8iR3grTVPBGd+A5pLg9Ezzl+4NEwk86ZGFBrThqoN3cKkY13vYVBwVJHAnuAbChLGtngxnLnG2y7sKdr9n6FFGGEefjs3xufnkScjSWO11kfyaimU5fPq2WX0Q/MZhhCBj+eyd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717660631; c=relaxed/simple;
	bh=fEctaKe23/K7WPGYjFfGzC2gcpDNq3frPQpRj0MtfrM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lL70ifOBWw3BsiGF1MgPSWzFkgvm1EuqLr/oSYjVoSdxFy2mf9SUQLk/4vofbZI/6sbJd+8/GTru6JhuQrcfnQ6ykcBGYMukGYm9OGZmB0WNPx7wZJzFH0KQQtsBz5CTXRsL4mh+ugIQpFjwCRgorz3PVyicWb17rI6jonl+vSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JVb4F8cI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JVb4F8cI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717660628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GaFEJRL2VRwXC7VyjrS58e/68QUO+dkEzJQeXtx2VPU=;
	b=JVb4F8cIcUIMDpaL6kyCwghGdxuz3jPWF76J8W8zE1ZvveDT4W40IZSAaBC2v8wCGG3lJh
	VUUvGL/PdRqDosfRFWlUZEEWkHdOWz7J8kwO3Hshuw6zKfPHXzHX3SM2J//OQkxawWpquK
	T+kSPaY56uvZvR9YDNIu+YcF5QRflCo=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-9LcKgdV9Nj2KlfMSiVT2iQ-1; Thu, 06 Jun 2024 03:57:07 -0400
X-MC-Unique: 9LcKgdV9Nj2KlfMSiVT2iQ-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2c1b17995e5so247009a91.1
        for <virtualization@lists.linux.dev>; Thu, 06 Jun 2024 00:57:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717660623; x=1718265423;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GaFEJRL2VRwXC7VyjrS58e/68QUO+dkEzJQeXtx2VPU=;
        b=hN7knCgRc49z4y7vjWQs+C6Q4zvZMGzY4JqOcaJhLmphy7eil4FF9kp+p7kuP6iwkM
         a7SxdcGcSypEb/WKuwBoaidSVrosTq8z9QvIIVAKu3HKxaunxGfHwA1oTn59ooZHheDa
         5356tThqzMgwZx1NFpsBXzNiSfgB2NDZO26q7exwIjdwoWGX7q2gV41ExwT/FU2/YtAW
         la3A+rvAYakeiqttCloiOLE4pIXrL1JHp0/K1GuCXlMdu3oGC54Z7uUUkyXRdQwpMfAw
         IcDlcmTc/B7zNzPSP3D8GsfXgffZH0mNEDA1DLnlVPvl2CsxWfo34AEG11Jj+GQfwIjO
         IhfA==
X-Forwarded-Encrypted: i=1; AJvYcCWDuXdxQj2ZAu2gHTLULgo7VmEC1SCkHpteFjl5LrJ4HzT5ViQ8q7C6U2EOroNOf8R4TFXRvY5XWD87Ie3NGRwYhfcyP9CNTo4AyxbIjpY=
X-Gm-Message-State: AOJu0YzBMNKZX3MmtkMDl2E/7436SW8p2X/yqfz+PxUqSX7uCmyMtPL3
	fwnsjLf9z9vfLZIfWF5tXtrFHy0/FkqsoG1S7E88WAvhf5H5bkqaYkZ9GniVXO/BCYGpgg0d5pu
	f4rKgAkylEWXhbVX8j/pOE6HdIHjZQux6WfDaN2Svvb2Zr/tmcSlme8aksm5YBUV/MtZ8xOMLlh
	dx3co/OV+MosiRkQXfyrHS2zB1mrvoy35M/5ga8kA=
X-Received: by 2002:a17:90b:19d5:b0:2c2:29a2:9b08 with SMTP id 98e67ed59e1d1-2c27db68d96mr4631198a91.40.1717660623022;
        Thu, 06 Jun 2024 00:57:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHx5FHfbmCVrZnzP5RH2OsZ/UgbANNHRFGgh64ntvVLDLJiWa5M5s21+OcBXx3ux62OTfutvdG9UWDZQFe7x5g=
X-Received: by 2002:a17:90b:19d5:b0:2c2:29a2:9b08 with SMTP id
 98e67ed59e1d1-2c27db68d96mr4631184a91.40.1717660622618; Thu, 06 Jun 2024
 00:57:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240509114615.317450-1-jiri@resnulli.us> <1715325076.4219763-2-hengqi@linux.alibaba.com>
 <ZktGj4nDU4X0Lxtx@nanopsycho.orion> <ZmBMa7Am3LIYQw1x@nanopsycho.orion>
 <1717587768.1588957-5-hengqi@linux.alibaba.com> <CACGkMEsiosWxNCS=Jpb-H14b=-26UzPjw+sD3H21FwVh2ZTF5g@mail.gmail.com>
 <CAL+tcoB8y6ctDO4Ph8WM-19qAoNMcYTVWLKRqsJYYrmW9q41=w@mail.gmail.com>
 <CACGkMEvh6nKfFMp5fb6tbijrs88vgSofCNkwN1UzKHnf6RqURg@mail.gmail.com> <20240606020248-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240606020248-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 6 Jun 2024 15:56:50 +0800
Message-ID: <CACGkMEsy37mg-GwRXJNBBkvhEuaEYw-g3wthv_XS7+t5=ALhiA@mail.gmail.com>
Subject: Re: [patch net-next] virtio_net: add support for Byte Queue Limits
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Xing <kerneljasonxing@gmail.com>, Heng Qi <hengqi@linux.alibaba.com>, 
	Jiri Pirko <jiri@resnulli.us>, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, xuanzhuo@linux.alibaba.com, 
	virtualization@lists.linux.dev, ast@kernel.org, daniel@iogearbox.net, 
	hawk@kernel.org, john.fastabend@gmail.com, netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 6, 2024 at 2:05=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Thu, Jun 06, 2024 at 12:25:15PM +0800, Jason Wang wrote:
> > > If the codes of orphan mode don't have an impact when you enable
> > > napi_tx mode, please keep it if you can.
> >
> > For example, it complicates BQL implementation.
> >
> > Thanks
>
> I very much doubt sending interrupts to a VM can
> *on all benchmarks* compete with not sending interrupts.

It should not differ too much from the physical NIC. We can have one
more round of benchmarks to see the difference.

But if NAPI mode needs to win all of the benchmarks in order to get
rid of orphan, that would be very difficult. Considering various bugs
will be fixed by dropping skb_orphan(), it would be sufficient if most
of the benchmark doesn't show obvious differences.

Looking at git history, there're commits that removes skb_orphan(), for exa=
mple:

commit 8112ec3b8722680251aecdcc23dfd81aa7af6340
Author: Eric Dumazet <edumazet@google.com>
Date:   Fri Sep 28 07:53:26 2012 +0000

    mlx4: dont orphan skbs in mlx4_en_xmit()

    After commit e22979d96a55d (mlx4_en: Moving to Interrupts for TX
    completions) we no longer need to orphan skbs in mlx4_en_xmit()
    since skb wont stay a long time in TX ring before their release.

    Orphaning skbs in ndo_start_xmit() should be avoided as much as
    possible, since it breaks TCP Small Queue or other flow control
    mechanisms (per socket limits)

    Signed-off-by: Eric Dumazet <edumazet@google.com>
    Acked-by: Yevgeny Petrilin <yevgenyp@mellanox.com>
    Cc: Or Gerlitz <ogerlitz@mellanox.com>
    Signed-off-by: David S. Miller <davem@davemloft.net>

>
> So yea, it's great if napi and hardware are advanced enough
> that the default can be changed, since this way virtio
> is closer to a regular nic and more or standard
> infrastructure can be used.
>
> But dropping it will go against *no breaking userspace* rule.
> Complicated? Tough.

I don't know what kind of userspace is broken by this. Or why it is
not broken since the day we enable NAPI mode by default.

Thanks

>
> --
> MST
>

