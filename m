Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92782AF00
	for <virtualization@lists.linux.dev>; Sat, 25 Jan 2025 16:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737821350; cv=none; b=oBXWHt8wC9HGrR4F5IBF4QlBfuPXQ4FvqydxHDdrYFn2CjMX+82/N/GIlWpGYU7ukxlDxyCxcab/URMfTFgghRfdYAxEOUkoJiYmgKKNRVSUYAwTyd6/pvkzj71GE2TZtTyXbETJhi5vNdm3/2fOr+zuBQqXYov+7fduOevnJhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737821350; c=relaxed/simple;
	bh=4aHdVhjE3dT45JPRlogeFgKSzcW8drpdwHdO3UEY7Tg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CLgqnwWEkTgvYPPo1OQFwZvE1Hr0MQIv2T4hFWAWJupxj+rclxb8w7rOgaPlGRCygdVCWL5oU3Y/oWblkXisDfnkqzBNkP70xoOZv2cRZJ/93DQWKu3qzlgB454lKZGRSynF/U3H7Ek35qpA0G0PjWgZb02+SCgF5WRTaautP8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=virtualopensystems.com; spf=none smtp.mailfrom=virtualopensystems.com; dkim=pass (2048-bit key) header.d=virtualopensystems-com.20230601.gappssmtp.com header.i=@virtualopensystems-com.20230601.gappssmtp.com header.b=0NUx/bXw; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=virtualopensystems.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=virtualopensystems.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtualopensystems-com.20230601.gappssmtp.com header.i=@virtualopensystems-com.20230601.gappssmtp.com header.b="0NUx/bXw"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5d90a5581fcso5290054a12.1
        for <virtualization@lists.linux.dev>; Sat, 25 Jan 2025 08:09:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=virtualopensystems-com.20230601.gappssmtp.com; s=20230601; t=1737821347; x=1738426147; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0yoXR3EBM0aj3oATIKb4zwFVhzdhN8vCY5JN0F8vdrM=;
        b=0NUx/bXwu5mDOGx4zH2AGZUMrzYOI+dc5CYMSOZxRAU+EOIhtPvz/8NNtixNJxUtQI
         ADBwkq9aoJDFQ0crd3UqmBa+OIFZmKVtirMJ1MbMhObdIf7SwzV5mo0W5KTONo1/gp2V
         v2TQecYoaKoFn/AhHMmEyDTB7AS4Vet1qp1tl5ObfM9ago48KSFuNf6Ts/xJo3S52QZJ
         cDVBcHp6fk87/Hsd0ihhfx2bx5b/G/GDy1KtOu4qH+s3v43P7yvt6gWfQQpiIljPvdzw
         ug4BO7/lkxDzz6NRZORdJOkoMQCM6Hdx9O+Xj6zw/+N5qAz+f0VIfk7UjjbF5hNePITw
         G00g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737821347; x=1738426147;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0yoXR3EBM0aj3oATIKb4zwFVhzdhN8vCY5JN0F8vdrM=;
        b=BptnClLfFCQYMhMMSIYU3tzn3L8kEkXxKN0bKdf5IicbeG1/bbNrGjb/YSh368Weuh
         fLtbBKad3yCbVX7YkvXcUkN/jFHvoiDi1qPi1iCgMagK20VzOWtK206V1lljhKgmBI0a
         o1As7hunkTNotb6u/Naf29myMXA1RvZ950xtaNIlLDUobZyfKcqG1FFZ56aNuw1MrKZh
         qLnksxv+ato1QflcRzcgNTTItTi6pcz7erqCvLWK29MdEnGR8Cot+4gVaUPIy+qkpmc5
         2mK5oR7uT+jkX9ARUnETdSw5/l7ZxKJxU0Xht3GE2Ur0sSmGuUUb24+XbmkHIKprzKkL
         Mkfg==
X-Forwarded-Encrypted: i=1; AJvYcCVS0i0R2ooWmyrCDOW5dQ4RZpfrpvEQY2489sXgkHz4zaqxBuSFRJnOOZp0bdHfnprgtwD4GcCwxIsMLQ6O8Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YzBKjjPaJW7wxSTRAXMnCqwfxUyYHacrMcsThkq3CSbXo0dDFH0
	yGHyshnbt+x1gC/T2D6L2iQHZEmjPvlLPx/wpGjPZSrvaIXOs+TtaWgEpnx6mA4=
X-Gm-Gg: ASbGncsWaSydtn194HNNUFhmW8vqJ7/vDS+REYXTOfuKT3zMzmV1znI0GB5xcXoecnc
	IfjEXQ8zg59qTIA/Dt8svsqQ4R+VHK6s0UWTaG8D5vs6mVZTSUSLf11sClhDk1td0JC6RNw351b
	MdTGXLVJwEbMzEbeyJS5g3g7qRFIKVoO3GG+qXsfwVqSA8riUCK9bD/tF2Uo40K+nPaLdWgKPe7
	CbQAwOvJnXu/TZJ+ElSS5mQVo6/pEqYblE4TcGA7jbngiS96yW2Ohmuz6pPfQdxKr02FS3Tfcee
	jxmZNJoIUDu/3eo0LNQyQeGrR+XC8a8=
X-Google-Smtp-Source: AGHT+IG8iN2g+ooJvMiuB5UvslsGPh0LXpOq16Tznm1w5mZS6AWfYeqTCtzeujJ8TaTHWs2a3SrLNA==
X-Received: by 2002:a17:907:7eaa:b0:ab3:398c:c989 with SMTP id a640c23a62f3a-ab38ada1546mr3685302566b.0.1737821346753;
        Sat, 25 Jan 2025 08:09:06 -0800 (PST)
Received: from ritos-ThinkPad.. ([45.66.41.93])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dc186191f6sm2790134a12.13.2025.01.25.08.09.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jan 2025 08:09:05 -0800 (PST)
From: t.ampelikiotis@virtualopensystems.com
To: jasowang@redhat.com
Cc: stefanha@gmail.com,
	virtio-dev@lists.oasis-open.org,
	anna@virtualopensystems.com,
	a.rigo@virtualopensystems.com,
	m.paolino@virtualopensystems.com,
	s.raho@virtualopensystems.com,
	chou.kensou@jp.panasonic.com,
	wminer@linuxfoundation.org,
	jsmoeller@linuxfoundation.org,
	virtualization@lists.linux.dev,
	stefanha@redhat.com,
	xuanzhuo@linux.alibaba.com,
	sgarzare@redhat.com
Subject: Re: [virtio-dev] [RFC PATCH 1/1] Virtio-loopback: a virtio based HAL for non-virtualized environments
Date: Sat, 25 Jan 2025 18:09:01 +0200
Message-Id: <20250125160901.120419-1-t.ampelikiotis@virtualopensystems.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CACGkMEt6hF+ZiWurKFAz3_uHLb66rXkVQ1io_C3ZdnLRkTMkNA@mail.gmail.com>
References: <CACGkMEt6hF+ZiWurKFAz3_uHLb66rXkVQ1io_C3ZdnLRkTMkNA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, Dec 23, 2024 at 6:03 AM Jason Wang <jasowang@redhat.com> wrote:
>
> On Sat, Dec 21, 2024 at 9:44 PM Stefan Hajnoczi <stefanha@gmail.com> wrote:
> >
> > On Fri, 20 Dec 2024 at 10:56, Timos Ampelikiotis
> > <t.ampelikiotis@virtualopensystems.com> wrote:
> > >
> > >
> > >
> > > On Wed, Dec 4, 2024 at 7:18 PM Stefan Hajnoczi <stefanha@gmail.com> wrote:
> > >>
> > >> On Wed, 4 Dec 2024 at 10:38, <t.ampelikiotis@virtualopensystems.com> wrote:
> > >> >
> > >> > From: Timos Ampelikiotis <t.ampelikiotis@virtualopensystems.com>
> > >> >
> > >> > This commit, is based on virtio MMIO driver, adds support
> > >> > for dynamic allocated (platform) virtio devices. This
> > >> > allows applications running in native environments to use
> > >> > virtio drivers as a HAL and eventually communicate with
> > >> > user-space drivers (implementing the vhost-user protocol).
> > >> >

[...]

> > > Security wise this approach has to fulfill the following two
> > > requirements:
> > >
> > > a) The first one is that we need to check efficiently if
> > > the calling process (vhost-user device) can have access to
> > > the requested pages. For example, assuming that we run a virtio
> > > blk on top of virtio-loopback transport the vhost-user blk
> > > should be able to access only pages which are related with
> > > virtio-blk virtqueues and vrings. That challenge is solvable
> > > and we can add those checks without changing the architecture.
> >
> > Once pages have been faulted in, how does the kernel revoke access
> > when the request is complete? I'm thinking of the scenario where a
> > page is used for virtio DMA but then later reused for other purposes.
> > Userspace must not retain access once the page is reused for non-DMA
> > purposes.
>
> I guess it requires madvise(MADV_DONTNEED) or something similar.
>

Yes indeed, maybe "zap_vma_ptes" could be used when
"vduse_domain_unmap_bounce_page" is called (for zero-copy cases).

In this way, the driver itself would remove pages from the
application to be reused for non-DMA purposes and since the
application has a page_fault handler, it can obtain access
on that page again if it is needed.

> > >
> > > b) The second one is the fact that the current memory mapping
> > > approach cannot guarantee safety for the remaining data on a page
> > > when the virtio buffers do not cover the whole size of it.
> > > In order to address that security issue, we should implement
> > > an approach such the one proposed by Jason Wang below:
> > > https://github.com/jasowang/net/tree/vduse-zerocopy
> > >
> > > In this way we utilize the bouncing buffer idea and we can
> > > guarantee to not expose the remaining data when buffer_size <
> > > PAGE_SIZE and insert the page into the process otherwise.
> > >
> > > Overall, we are aware of those two security points, the first
> > > one will require the implementation of additional checks and
> > > the second the modification of data sharing model to avoid
> > > exposing kernel data.
> > >
> > > If you think that the overall approach is interesting we
> > > continue the discussion and target any future work to address
> > > the above described challenges.
> >
> > With regards to the overall approach, please work with Jason since
> > there is an overlap with VDUSE. If you guys agree on how VDUSE and
> > loopback fit together, then I'm happy.
>
>
> Right, I think it would be better if we can find a way in VDUSE first
> as a lot of works/codes could be reused.

While investigating your newest zero-copy PoC on vDUSE with bouncing buffer
I integrated the very same mechanism (iova_domain.c) in virtio-loopback
and tested it with vhost-user-blk and vhost-user-can devices.

In my opinion this combination has the following benefits:
a) This implementation addresses the majority of security
   concerns related to sharing page which might contain other
   kernel data with the user-space.
b) The new implementation of virtio-loopback adapter can leverage
   the bouncing buffer and support vhost-user-blk and CAN. Support
   for devices like vhost-user-sound, gpio, rng, input, console
   should be in place with no effort but there are not tested yet.
c) By making loopback work with bouncing buffer and not
   introducing changes to iova_domain.c we can consider
   that virtio-loopback is a shorter path to support
   the above referenced vhost-user devs.

Links to the new virtio-loopback implementation:
- https://gerrit.automotivelinux.org/gerrit/gitweb?p=src/virtio/virtio-loopback-adapter.git;a=commit;h=269f019fde391bffdfbd42dee45c0cc8721e8f4f
- https://gerrit.automotivelinux.org/gerrit/gitweb?p=src/virtio/virtio-loopback-driver.git;a=commit;h=26138fa91896b50748b3c17429d707ababf41cad

Last point related to the vDUSE zc PoC, to fix the "madvice"
issue and improve performance, I think it is worth to consider:
1) utilizing "zap_vma_ptes" in order to avoid madvice and be
   able to remove pages from user-space when are not used
   anymore by the corresponding virtio-driver.
2) extending the zero-copy mechanism for more than
   "DMA_TO_DEVICE" cases

Thanks,
Timos
