Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E107166F03
	for <virtualization@lists.linux-foundation.org>; Wed, 28 Aug 2024 09:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724838476; cv=none; b=A0uTgSBwawwrR/Qf213REAsmyklSEjzD8ipUvtvBOysZRYCTmdAuL4MQcqp4yPalvlibyiA4Xg8jAzUe9kvH7vVaQLNfRLooqxb+lM2oQzuCd30/IwhwlHtdStO8eyQfZ3643b+cMZ1u7tg7Qb0wSQDc/5TLk9FomlmSgMMSTeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724838476; c=relaxed/simple;
	bh=WSTh+zu0TJIXe1FY/vQjpVJQQl5HhtJegSsKhpz2Guk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PTFtE6FKoSQ58hqCroSp9PJsKStIYUC9AXABJAqsqlFms321Y9KHcwfP7VRelryTdyjot5uzC2CU7o/jDxZkSQO9gGtwbFTsg76XsqK2cXq7juzPpiLN8q8a8RLz00b6OL71JAsiXjrCjjMhkclZZLZUn3qX0r0FwMgs+YAJo+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O22BtjIp; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O22BtjIp"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2B34180E5D
	for <virtualization@lists.linux-foundation.org>; Wed, 28 Aug 2024 09:47:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SVDb21y3NXzj for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Aug 2024 09:47:54 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 4FAE980E54
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4FAE980E54
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=O22BtjIp
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4FAE980E54
	for <virtualization@lists.linux-foundation.org>; Wed, 28 Aug 2024 09:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724838472;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L20WswXzsoqqavVlvJi0Y93AkFoGYOXnB8BArl5SMxg=;
	b=O22BtjIpbAjTLi9Y/dJ7K9aiG0B/KTQUBWs5XrgNJwMOq3RTHKqBUxx/GwXVtk46ylRo+z
	5omRNsrozS9fYEyJvPsQqXFzl7ClCSgjLZ6d0lnckyiQ4+kG044lXQtGjN9Y8TrKCMqScN
	fbJBU4/v/o2ZQH0VWkqypOCIokch6tE=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-iW8bHGxAPGq9wieMWzl7Sw-1; Wed, 28 Aug 2024 05:47:51 -0400
X-MC-Unique: iW8bHGxAPGq9wieMWzl7Sw-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a867ed4c129so546645466b.0
        for <virtualization@lists.linux-foundation.org>; Wed, 28 Aug 2024 02:47:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724838469; x=1725443269;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L20WswXzsoqqavVlvJi0Y93AkFoGYOXnB8BArl5SMxg=;
        b=F+HDaAdg+zOKQHavrj1fshfvK+f5CeuWmRb4m/YXcsQ63r47RHOKOcILRYs36tKr0A
         FSUl35J1huaWG1PqznXEHdcW6qwD8xiV8ODYtyD4BDV1MCnRoetp4ZszXMK+dhgcy2JX
         xJMqWjoO0+QYogW4ZEMDb1YBTL95gONcbKl4m8VyuDgn9zGwROvapPVsxvCXiYORONtg
         /ZA8cheQWgk67kFsozVSKVmASXJyynIXCIS7rTAhDyDAu8NwQZ5Exgk7g6Fj0Qn7nZWa
         yECP64BVlkbeCVp4VKlK8+ZN4vuOQRKE3CFvgP4268KZGOooY2AZPR5LSMUGndRQz5Mq
         +7wQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWTM0Yize8/HjoDBjihhkf7yJ00uylY1nVzU/iMhJ4gzb4WCm1omp+p2P7PkbJ7bIyK8diNN5B9OAYnKdLfQ==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YwZqYBNGoLt/ZNj6OmUviB0w4zAVtFpUOHQvh9onqMz8plxr39f
	7i2kvBC62TjLf5hC/YOO31ilggG9lyN34vekAFnWjddxahXLaBmQA0LhEC1V72EREFcTxKYgXe8
	zfp4IDAd0oSm+6bbXSpx9j8Hjd9Fl/eSi9FtI+L9QOW4STfyHWZAgLwU8XzmJ7xChXb08NdDmXX
	+yP1qblsZc31Uwg3eFueKsGcUdqc+zuNk4DAI1/QPxD7qmQbsNVgqaXTMV/ZzgPg==
X-Received: by 2002:a05:6402:3709:b0:5be:fc44:d159 with SMTP id 4fb4d7f45d1cf-5c214c2bdbdmr1080608a12.22.1724838469602;
        Wed, 28 Aug 2024 02:47:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGARCAiUO0ACG/lOR6SUELzwUh4s+3RcakuKgtH/kGxLckkd6Kcn8CcSKr46OrOkcpwrz3n+Rma//SmX/+ECUo=
X-Received: by 2002:a05:6402:3709:b0:5be:fc44:d159 with SMTP id
 4fb4d7f45d1cf-5c214c2bdbdmr1080599a12.22.1724838469216; Wed, 28 Aug 2024
 02:47:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240819092851.441670-1-lulu@redhat.com> <CACGkMEsgAhYePqNCNVQyGx7fFAVRrYiCtk=13Y3szzjyxKHtYw@mail.gmail.com>
In-Reply-To: <CACGkMEsgAhYePqNCNVQyGx7fFAVRrYiCtk=13Y3szzjyxKHtYw@mail.gmail.com>
From: Cindy Lu <lulu@redhat.com>
Date: Wed, 28 Aug 2024 17:47:12 +0800
Message-ID: <CACLfguXn2xDaowNYVxOg=L2ch=UudQAD-atxkW1J1XyWLL+AaA@mail.gmail.com>
Subject: Re: [RFC 0/7] vhost: Add support of kthread API
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux-foundation.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 27 Aug 2024 at 10:35, Jason Wang <jasowang@redhat.com> wrote:
>
> On Mon, Aug 19, 2024 at 5:29=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
> >
> > In commit 6e890c5d5021 ("vhost: use vhost_tasks for worker threads"),
> > vhost removed the support for the kthread API. However, there are
> > still situations where there is a request to use kthread.
>
> I think we need some tweak here. For example, we need to mention that
> the introduction of the vhost_taks introduce userspace noticeable
> changes as the worker inherit attributes from the owner instead of the
> kthreadd etc.
>
> > In this RFC, the support of kthread is added back. Additionally,
> > a module_param is added to identify which mode we are using,
>
> It's probably not identified, it's more about if we need to "enforce"
> the old behaviour.
>
sure, will fix this
Thanks
cindy
> > and
> > a new UAPI is introduced to allow the userspace app to set the
> > mode they want to use.
> >
> > Cindy Lu (7):
> >   vhost: Add a new module_param for enable kthread
> >   vhost: Add kthread support in function vhost_worker_queue()
> >   vhost: Add kthread support in function vhost_workers_free()
> >   vhost: Add the vhost_worker to support kthread
> >   vhost: Add the cgroup related function
> >   vhost: Add kthread support in function vhost_worker_create
> >   vhost: Add new UAPI to support changing Kthread mode
> >
> >  drivers/vhost/vhost.c      | 241 +++++++++++++++++++++++++++++++++++--
> >  drivers/vhost/vhost.h      |   1 +
> >  include/uapi/linux/vhost.h |   2 +
> >  3 files changed, 235 insertions(+), 9 deletions(-)
> >
> > --
> > 2.45.0
> >
>

