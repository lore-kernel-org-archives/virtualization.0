Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED103D8901
	for <virtualization@lists.linux.dev>; Mon, 13 Apr 2026 14:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776089724; cv=none; b=I56J7Brij+XWzQOM8ogX7P7Sf59JWm0M+L4oCOndZPHlPpsDiiXjYOmebz4Q4mLachB1HOyF4Yim7wXNRUULBzrFjMQetPpfdAeCDXnlpi1EReaEHKV9c7o88eqFBTIrPcp0w56+e3hBe+6DiyUArbjb3IugpJYVK6q3CC+qKGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776089724; c=relaxed/simple;
	bh=b/NdrcCNb4YsZmbCPoUC5yQwdGmMs05oejo3/CyUl2I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r9o/qRMbgd9F7T+UQ8z91unmTGiw/Xy2QdQhWfQ4rDHMYYwL58VjnO4ebJae8S7UIpNLYFzv+sC/yKOetQhFdbxEZeBFNRXaAkhaPBcDMBkAUP90efd2SYt1pLO2o1wrYxLaqcFxc2XoKmIixviTXy+PQOOsB0b8Amft2IwdlQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PuOeLaCC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PuOeLaCC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776089722;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b/NdrcCNb4YsZmbCPoUC5yQwdGmMs05oejo3/CyUl2I=;
	b=PuOeLaCC4Esdfn7pEA+rLqGIdbKngNRWOAeOqUbD1KLa1IxZiS0L+YcqJEoKCeSKAtslpe
	slb4CEHxG5hsTYxc3lR/fqoL9MF4IIHQm3DwGSYjjsgMoR26XQxgdzexND5ZkDqC3m2mmV
	XYVE4qqvL/WOH8Z+WVp2krp4WHS5R5M=
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com
 [74.125.224.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-454-byMIUg8ZPpi36xnIor2sHA-1; Mon, 13 Apr 2026 10:15:21 -0400
X-MC-Unique: byMIUg8ZPpi36xnIor2sHA-1
X-Mimecast-MFC-AGG-ID: byMIUg8ZPpi36xnIor2sHA_1776089720
Received: by mail-yx1-f70.google.com with SMTP id 956f58d0204a3-651c8371fd1so2072041d50.1
        for <virtualization@lists.linux.dev>; Mon, 13 Apr 2026 07:15:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776089720; x=1776694520;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=b/NdrcCNb4YsZmbCPoUC5yQwdGmMs05oejo3/CyUl2I=;
        b=Pnn083mZPjDSttXF/FOoa8TDGR/lyxqlM1g35mT7RY69mwkgFGUWmFc5I0Boow2rDo
         tEM4th9P5VWqafNle9Ebp3sZzzEBmURq2IYNZs7rIwrHZ4iH4+62EulpGMI9JWqStjph
         gayfV7e82g1qpRAmBo7I+pc/+6pgu3/AfKYegzz5s2Kxd0xdXpj98BpwDnPDb1+snOmE
         jD0NXeLYUbozFS4/F2VJq0+DVNL9FCDqQCX/FD5Lv+7Se3suJAsn4hOz9QHKbZiyQtvp
         OwsXWD8Y90WVRcW9b8eCIrgUJY6iqJb75b17+z2jd9bd3/xv18S6d9TnbwgT5lbU+yaI
         lbzg==
X-Forwarded-Encrypted: i=1; AFNElJ8vBbeJ+mnQDBrt1QZFSrigYvdFOJvTjYhom+ohGW8CP2d1TwHI1AFXvpuQyNRPZ3LC6zaH2GM0l976MZtx9Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YzHaW7k39GwfwZUwOgPQJV7yXokQ8YyUh4JVFtNShIgBq6Od1Nz
	m+UcpDI9njLNuRN6gTThHMJxHzSIwKQtmGcPlsPA8LDzsRjCeub1R8j+p3e75Ton86wBxs6RRt6
	e/8zw2RzaGwpGowYdPePOb1UuiBYJIlMswWac7ofoaxUO09azwSJG48mOJioaJK9Vt6uoSX6Um1
	zwKygUjB1I2GIl6e8vanKf7MHivAuj9Rx6++0ejHqp0Cc=
X-Gm-Gg: AeBDiesQ8y+EeL0A12kQodbV21Jq7nsTHT6yVsd2DwoY9EpBBGYi12H777oEnKVkJjp
	M5N1idyeIho0R2ojZCgL1svzbLv9dB2tnxZzUzZ9qmjMLWTcZZr2kiqW2d1fHyzsbo75afyGA+x
	22f63IEfTD7kKgCSMn7spgZ0unW/36teh1s+Hgr24Ra7g75CEIj3f65vDRnjIwoWxXv+AUDovMV
	18=
X-Received: by 2002:a53:b166:0:b0:650:3e1f:907c with SMTP id 956f58d0204a3-6519885e270mr9949174d50.0.1776089720099;
        Mon, 13 Apr 2026 07:15:20 -0700 (PDT)
X-Received: by 2002:a53:b166:0:b0:650:3e1f:907c with SMTP id
 956f58d0204a3-6519885e270mr9949127d50.0.1776089719401; Mon, 13 Apr 2026
 07:15:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260413101759.6323fb68@pumpkin> <20260413122244.534-1-guojinhui.liam@bytedance.com>
In-Reply-To: <20260413122244.534-1-guojinhui.liam@bytedance.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 13 Apr 2026 16:14:42 +0200
X-Gm-Features: AQROBzD19qyh6NwsklNvT55RYRHBsoRhmI6anJ3YQzudDoo1ImWO2NiQf2WiVIc
Message-ID: <CAJaqyWeb3BuW-kK_+P=BK5darshhKn4fHuTJuRY+rvoX_4QUeA@mail.gmail.com>
Subject: Re: [PATCH] virtio_pci_modern: Use GFP_ATOMIC with spin_lock_irqsave
 held in virtqueue_exec_admin_cmd()
To: Jinhui Guo <guojinhui.liam@bytedance.com>
Cc: David Laight <david.laight.linux@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Jiri Pirko <jiri@resnulli.us>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: rLr8_NfwHzPMtnC6cA238TTXxeZvtxqMptSDNFoRu84_1776089720
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 13, 2026 at 2:23=E2=80=AFPM Jinhui Guo <guojinhui.liam@bytedanc=
e.com> wrote:
>
> On Mon, Apr 13, 2026 at 10:17:59 +0100, David Laight wrote:
> > Or do the allocate before acquiring the lock (and free it not used
> > in the error path).
>
> Hi David,
>
> Thanks for the suggestion.
>
> Pre-allocating the memory outside the lock is indeed a good practice,
> but unfortunately it doesn't work in this specific virtqueue context.
>
> The kmalloc() in question is not happening at the virtqueue_exec_admin_cm=
d()
> level. Instead, it is deeply embedded inside virtqueue_add_sgs()
> (specifically, in functions like alloc_indirect_split() or
> virtqueue_add_indirect_packed()) to allocate indirect descriptors when
> multiple SG elements are provided.
>
> As a caller, we have no mechanism to pre-allocate this indirect descripto=
r
> memory and pass it down to virtqueue_add_sgs(). Furthermore, virtqueue_ad=
d_sgs()
> needs to atomically check the queue's num_free status, allocate the indir=
ect
> table if necessary, and update the queue pointers. All these operations
> must be protected by admin_vq->lock to prevent concurrent admin command
> submissions from corrupting the virtqueue state.
>

Sounds like a big chunk of that is achieved with virtqueue_map_* and
virtqueue_add_{in,out}buf_premapped functions, isn't it? Or am I
missing something?

> Therefore, allocating before acquiring the lock isn't feasible here, and
> replacing GFP_KERNEL with GFP_ATOMIC (with a proper sleepable retry upon
> failure) seems to be the more viable fix.
>
> Does this make sense?
>
> Thanks,
> Jinhui
>

