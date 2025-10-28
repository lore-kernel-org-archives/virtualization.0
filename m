Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9267E3346A5
	for <virtualization@lists.linux.dev>; Tue, 28 Oct 2025 14:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761662275; cv=none; b=Dy90dMRmXLBWDo3d4hCxg4VrWNaCBO9z3N7tRMg6ZLAkKveZZ08O1tkGtJpkiXqukrOpK/fnimpx5LTqwmtUA4BRRr2CQIa5Ek3ylDEoqBZp5RpPhynz1ToIO+7lqAT4hymLL/lhaF5TwACT9O/eU1Ol+Tzyl48fZKTJyaFWkD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761662275; c=relaxed/simple;
	bh=09NZc1BAr3Ka76OtTpIJwkZSeHbrbtpTLxSEWNV/iwI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pQPHMvN31e5uYij+1nenHHgu4cZusuk7qX//a9xeVEjGPUyMChwNRY6YQpUKBoHnUkxfDReabEcH4OQ78wVXumNcytYWhWbb/afubJoRw1ayzZZVJ2YQhXSlr45Ej2FZNFM5su311CWwWJKSWbhuyCLezi5aGR0hf8LeuhxLxpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FpYSAbFL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FpYSAbFL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761662272;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=09NZc1BAr3Ka76OtTpIJwkZSeHbrbtpTLxSEWNV/iwI=;
	b=FpYSAbFLjd24ib93Rnjhj+HVUCNFw5NHADKSgJIeaQqrK32lltTL3Zpx8szQRZKPVMFvwX
	o5RKh+KgdSD0WGfHQzWT8sxw1Ao0PPZCmfxv9owsAMEHqo3nGVXV78yiJ3/1zh0Qnm/KuK
	4zEgg4V+yVtsbEqH12Br1834gy8Eeo0=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-z5b2rmF6MJat-z8oXAJv9A-1; Tue, 28 Oct 2025 10:37:49 -0400
X-MC-Unique: z5b2rmF6MJat-z8oXAJv9A-1
X-Mimecast-MFC-AGG-ID: z5b2rmF6MJat-z8oXAJv9A_1761662268
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-378e3e1c7c0so41232511fa.1
        for <virtualization@lists.linux.dev>; Tue, 28 Oct 2025 07:37:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761662268; x=1762267068;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=09NZc1BAr3Ka76OtTpIJwkZSeHbrbtpTLxSEWNV/iwI=;
        b=WdREUrLqdNShW2XSm/a6AWA9h+8C2UDjMJ00SOT9bIaJjhg1g6hZrm1ym87ej0lumZ
         WaLBfymcLsUOvFB1+zP6SWAeLwkAPhM7QxmoN+M4hYfmbqoSdxRdXSq0LMsxgugLRgAY
         V8mF7mZk+Qb/E8/WpaNmta2GAZZ4vGhd7ZmCfbLFZjwFa90ksu4TZFnt/KJR1Qia56P0
         S9EtmO3rY0d4jPVCixaa2ZPlsnB5vsQjLDulmSZmcr4IDHCqIodVke/JBZPLaQqmG+3Z
         MmW3ccmqMlZ6vf159ndX7vT6cBcXAg0MqiRxfI4b9IZxHl02vxJNPE3qOO2I3+GXpO6+
         jJaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZiLO/oSTSXLOPu2Y9L5YtxhHu0tXCQCkLKSOCTUUV2E7qqhdblY02vGoeFRitqztwH+/COSaGsj2d9XhRDA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxH+8OdqDRCmEMkuDEMTdTz2+yfe5H75gmj69MpbKfG9S69mrqI
	lVVZkXLCp4GV1AE/OzOfd+S2TVUJ69pl5cfFFHE3BADDmMOP5sznH6wDAuX2DStkCSSsbMGUgdb
	0kXmqHmoz9nreuyM5+/qdTZmi2sFGDb8yXLf2RUA7F8HMoqQu5lluXqtN4q4oFpHMTIEbyXP+Yu
	hsb3o11j5RFlP5QOx+ciwVAxZjiVk88HIS+5zK6NLoT50=
X-Gm-Gg: ASbGnct2mz/YX3fUsMSFWUeH++Jc3VJwr6MzvYia9ocJ19UH09eCyv4/Cb7KVed3y01
	yoPakB0puppE3FKyisAC0b4QEL35IEPWPSGG2CzmHbwCjAOi034CXpNoiC/WrQ8a2t/PCbZPxWm
	aWKb1TwNZgiYK3Ah0PZHqhnS8qEgUtg5UoXVTPccNg0D6OGhpsRyYNxSRBlDaRe0+XnwvBGxXRx
	dfnpL2y7vLp+BNxIpMs+as0BToktSdKdOFbM28AMtA=
X-Received: by 2002:a2e:a917:0:b0:377:c556:68b7 with SMTP id 38308e7fff4ca-37907c99b06mr10803901fa.17.1761662267626;
        Tue, 28 Oct 2025 07:37:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFH1qUNPl6ooa8Bsdv4mhpa8rES8RuOgArfXGQ7Zb+j6PUDeLzIiljeXqTefrnG6lrqdMn5JWzo4puaSyJ4lPM=
X-Received: by 2002:a2e:a917:0:b0:377:c556:68b7 with SMTP id
 38308e7fff4ca-37907c99b06mr10803841fa.17.1761662267194; Tue, 28 Oct 2025
 07:37:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAJaqyWeiX1Tc77NcYoBbeVfKTeuKHK6hw=n_9Mk4y52k7Djr-g@mail.gmail.com>
 <20251015030313-mutt-send-email-mst@kernel.org> <CAJaqyWfRmhXM8eV+=wMVKgrc8SJ98OTtBCtNDJj8ZRUM5Y9Nmg@mail.gmail.com>
 <CAO55csx2rbjxEZk5K3aKcZ501KY3Zfs8ThEQHFqQ1ZB9RSXECA@mail.gmail.com>
 <20251015040722-mutt-send-email-mst@kernel.org> <CAJaqyWcf3tz17q6G=123Xb+warf8Ckg=PLaPkzLU9hYHiUy9Zg@mail.gmail.com>
 <20251022060748-mutt-send-email-mst@kernel.org> <CAJaqyWdRN3C1nOHQjWroBPWKjc5efNfVbecpruL=Cgsk6i1FXg@mail.gmail.com>
 <20251022073231-mutt-send-email-mst@kernel.org> <CAJaqyWeDcyKKOvVdqUkpTuH3d-Tb9rBHG3ym+LC0fcmhrN_FJA@mail.gmail.com>
 <20251028100923-mutt-send-email-mst@kernel.org>
In-Reply-To: <20251028100923-mutt-send-email-mst@kernel.org>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 28 Oct 2025 15:37:09 +0100
X-Gm-Features: AWmQ_bm_ikxtcCHfifEP3X9--_zb9nwAd7fq5zkuRGqhN1hAtFMAFJR9kqLgpas
Message-ID: <CAJaqyWePMtM8vtgm8UnGAv+_XNTnVNFSNuoqzt_Cn-CpZg46mA@mail.gmail.com>
Subject: Re: [RFC 1/2] virtio_net: timeout control virtqueue commands
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Maxime Coquelin <mcoqueli@redhat.com>, Yongji Xie <xieyongji@bytedance.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Dragos Tatulea DE <dtatulea@nvidia.com>, jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Twq2adsdYJ78-9-0m15o6cNgq4oiKn5HgH6prrT-OuU_1761662268
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 3:10=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Wed, Oct 22, 2025 at 02:55:18PM +0200, Eugenio Perez Martin wrote:
> > On Wed, Oct 22, 2025 at 1:43=E2=80=AFPM Michael S. Tsirkin <mst@redhat.=
com> wrote:
> > >
> > > On Wed, Oct 22, 2025 at 12:50:53PM +0200, Eugenio Perez Martin wrote:
> > > > Let me switch to MQ as I think it illustrates the point better.
> > > >
> > > > IIUC the workflow:
> > > > a) virtio-net sends MQ_VQ_PAIRS_SET 2 to the device
> > > > b) VDUSE CVQ sends ok to the virtio-net driver
> > > > c) VDUSE CVQ sends the command to the VDUSE device
> > > > d) Now the virtio-net driver sends virtio-net sends MQ_VQ_PAIRS_SET=
 1
> > > > e) VDUSE CVQ sends ok to the virtio-net driver
> > > >
> > > > The device didn't process the MQ_VQ_PAIRS_SET 1 command at this poi=
nt,
> > > > so it potentially uses the second rx queue. But, by the standard:
> > > >
> > > > The device MUST NOT queue packets on receive queues greater than
> > > > virtqueue_pairs once it has placed the VIRTIO_NET_CTRL_MQ_VQ_PAIRS_=
SET
> > > > command in a used buffer.
> > > >
> > > > So the driver does not expect rx buffers on that queue at all. From
> > > > the driver's POV, the device is invalid, and it could mark it as
> > > > broken.
> > >
> > > ok intresting. Note that if userspace processes vqs it should process
> > > cvq too. I don't know what to do in this case yet, I'm going on
> > > vacation, let me ponder this a bit.
> > >
> >
> > Sure.
>
> So let me ask you this, how are you going to handle device reset?
> Same issue, it seems to me.
>

Well my proposal is to mark it as broken so it needs to be reset
manually. For example, unbinding and binding the driver in Linux. The
point is that the driver cannot trust the device anymore as it is in
an invalid state. Maybe suspend and reset all the vqs is also a valid
solution to un-broke it if the device supports it but I think a race
is unavoidable there, and I'm not sure how to communicate it to
userspace for all kinds of devices. Incrementing rx errors could be a
first proposal.

If we want to track it in VDUSE we should implement NEEDS_RESET and
leave all the old drivers without solution. That's why I think it is
better to solve all the problems at once in the driver.

