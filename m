Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F6B11182
	for <virtualization@lists.linux.dev>; Wed, 20 Mar 2024 03:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710905473; cv=none; b=Z9Mds7mrrYVJDFab6vIqSwbPFDRqEUeQT/FX7e2DI49nmxYATxrYeYeVM4qOLnpHkc2x5CiyHGk0E6bVV8YL8wQxIwilvgpF7t8aPfAsJgptKy1+tahniXJ4uBRVv5n7I3kyncEs1bZUOr6+8EQlMpMkhxMhmg/oUNQStvQn3as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710905473; c=relaxed/simple;
	bh=cJbRBJU/rWQUYiWkeNe1/wgCgexpKks2BaJuo3hgNig=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VYROaHTOZqGRDgFYw7k71BqA760LHoMcZEcixTqWN1MTar1iSlPOkae6YkEFywFZFkjbGh0r5DsnBmx0XF1mVsqEEWf2YiDzRYGsjD76EEi6cZ3Qj6WiRjYadB8k5P6ylPAbcCjob5AFu7HU30smUg4SFymhQXeyf5aPOaUf5n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HD/IziJj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HD/IziJj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710905471;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=evNRGK/G29C98iYVY9eVfU4KqDPrewVerPnMCY05k/Q=;
	b=HD/IziJjmcKKcVqQm8AmJimy8QfUhgs6KVKm5XbYoDufVzchEQxuFoSb/V9arY4cLdPbz7
	r6tRqFhd7b6qHvzhlRLmbVVzx/Buj58FZ2GrejBaRsd3LQsysQeARqAVfid3+i+rVqHos2
	49Wuar+Iilt//Uc5Rkc3Lgd1iwHPCWo=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-427-VIfY97F0Na-uYjWIjndmOA-1; Tue, 19 Mar 2024 23:31:09 -0400
X-MC-Unique: VIfY97F0Na-uYjWIjndmOA-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-29dd9bfd4fdso4811334a91.0
        for <virtualization@lists.linux.dev>; Tue, 19 Mar 2024 20:31:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710905468; x=1711510268;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=evNRGK/G29C98iYVY9eVfU4KqDPrewVerPnMCY05k/Q=;
        b=iyS5xiZqMo6R3qaBYexKmc/xvPUprB+D7MN2hbnDdl2TrW0WkvvA+K6Gk0+5oy+wTC
         0z3xwxHezEqJqGdzM+Dn/4Tn+immnBW9xU+/UyeCGQBCAXgeoYwM9Qfj6ms1oW46ivp6
         zMa2e+mDNtt3dMdbdW7XJ+j8kw5PjLoWs1L3Xc0WcPkqqiVov2Dob0Zzbn1XE3kImBFE
         r+bF6dK7jlEJ7VrhOVuiHIKQHVuFv7KQtSQtfpSLMljcWxdMH+IPotFVblVPdHUTm2oJ
         py71oG4Z4tt5wAhkg07cCoOKdqP78vFZ9y8Q4h1oV1YJewtCQ+Knfql5DeA9d1k4jdEj
         mNGg==
X-Forwarded-Encrypted: i=1; AJvYcCXW0vyLeyIRqxdzGNgSeh70zFD1aM3ilGvIqMT9NYhCiP9zVUspFNlfPJNkT1I42aWEDAXScRXwskl6scWiGNK5UYfag2/c4sgdmjOr1+E=
X-Gm-Message-State: AOJu0YzaBwtDCmFo7NpMmUuR8TS9L29ly6ZxYk+fpFr7mwvC6h9cXTM7
	XyJY2QrS/ddOUS62WVP6dgShMcm7yeuWq2YarD84IafqEhDcD77E3AGcvY4GlEP6ABLMUsAHR2b
	l9YzpxWurm137elDX2vJ0IR0Bvt/83zCTg70JELSc3DWtXUkfqcj7ovZdX7kNg3klUWIpVjva62
	MODck/tp83A0WTNQxdWff6sSRyJG4rU/jjnJVY4po=
X-Received: by 2002:a17:90a:ad46:b0:29d:f554:4509 with SMTP id w6-20020a17090aad4600b0029df5544509mr1157442pjv.0.1710905468600;
        Tue, 19 Mar 2024 20:31:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHa5Rthw+WLr41g4C8wV+6thHnL3xmYeLVbogCO4594t2bt4M37sweyYNquQuEE8Xnri5Tchk13asEbYAxG8w=
X-Received: by 2002:a17:90a:ad46:b0:29d:f554:4509 with SMTP id
 w6-20020a17090aad4600b0029df5544509mr1157428pjv.0.1710905468228; Tue, 19 Mar
 2024 20:31:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240218185606.13509-1-lingshan.zhu@intel.com> <20240319023840-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240319023840-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 20 Mar 2024 11:30:57 +0800
Message-ID: <CACGkMEundY+cxPPvRLS06b1CK94jGL4poCd0tcj2wfSAzTVGFg@mail.gmail.com>
Subject: Re: [PATCH 00/10] vDPA: allow userspace query virito-block device
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Zhu Lingshan <lingshan.zhu@intel.com>, virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2024 at 2:40=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Mon, Feb 19, 2024 at 02:55:56AM +0800, Zhu Lingshan wrote:
> > This series allows the user space applications query vDPA virtio-block
> > device inforamtion.
> >
> > testing on vdpa_sim_blk, iproute2 output:
> > sudo ./vdpa/vdpa dev config show -jp vdpa_blk0
> > {
> >     "config": {
> >         "vdpa_blk0": {
> >             "capacity": 262144,
> >             "segment size": 4096,
> >             "block size": 512,
> >             "max segments in a request": 32,
> >             "num of queues": 1,
> >             "logical blocks per physical block (log2)": 0,
> >             "offset of first aligned logical block": 0,
> >             "minimum io size": 1,
> >             "optimal io size": 1,
> >             "maximum discard sectors for a segment": 4294967295,
> >             "max discard segments in a command": 1,
> >             "discard sector alignment": 512,
> >             "max write zeros sectors in a segment": 4294967295,
> >             "max write zero segments": 1,
> >             "read only": false,
> >             "flush command support": true
> >         }
> >     }
> > }
> >
> > Please help review
> >
> > Thanks
> > Zhu Lingshan
>
> It's been in my tree for a while so it will be in the next pull,
> but going forward Jason I'd like to know what kind of
> timeline do you have in mind for reviewing vdpa patches?

I think there are some misunderstandings here.

I usually try my best to offer a review.

This series was posted during my vacation, and when I came back after
the vacation it was merged into your tree. I'd expect you are fine
with the patches.

If that doesn't work, maybe we can start to do something like:

vDPA patches needs my ack before it can be merged

Does it work?

Thanks

>
> > Zhu Lingshan (10):
> >   vDPA: report virtio-block capacity to user space
> >   vDPA: report virtio-block max segment size to user space
> >   vDPA: report virtio-block block-size to user space
> >   vDPA: report virtio-block max segments in a request to user space
> >   vDPA: report virtio-block MQ info to user space
> >   vDPA: report virtio-block topology info to user space
> >   vDPA: report virtio-block discarding configuration to user space
> >   vDPA: report virtio-block write zeroes configuration to user space
> >   vDPA: report virtio-block read-only info to user space
> >   vDPA: report virtio-blk flush info to user space
> >
> >  drivers/vdpa/vdpa.c       | 212 ++++++++++++++++++++++++++++++++++++++
> >  include/linux/vdpa.h      |   1 +
> >  include/uapi/linux/vdpa.h |  17 +++
> >  3 files changed, 230 insertions(+)
> >
> > --
> > 2.39.3
>

