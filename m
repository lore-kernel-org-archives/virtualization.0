Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922D432AAAC
	for <virtualization@lists.linux.dev>; Tue, 28 Oct 2025 14:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761663487; cv=none; b=Z2ZXdS0Szq7blhezmzV2PqAPbOgWSObNPVp12YI/+723YZ1qh01K35jAKTStrXLdzoWzuC+rCEt+HA2UP+a0SVIfNgOT0LHwd2YydZSlBZSO3YFz3qo9p4NourY1n+JBA+1kMgWaLhG8tnIXPIACUtyCkG9xJ4vIVa4pLwC2H54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761663487; c=relaxed/simple;
	bh=8N/CyB3BhR9BzfFuw9y8Z5rJf3YG4p6pIZG96vMy1go=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pow2cfnl2mwXcxrNSZiTYdNKKS59GMXwaFXcDgjLRDsaN9gFFbnvsz25UGNe3hy/UgYeuZHocyyunGf4suReSXzeYKVuIN04IgNYyamYgBlRKJ+mMrAvbq7UoPVJJn/FW7bEPiAJRfHqvUt8PzEddNYzn2Om2HAhhzvLPm/za20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=adcagzGH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="adcagzGH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761663484;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8N/CyB3BhR9BzfFuw9y8Z5rJf3YG4p6pIZG96vMy1go=;
	b=adcagzGHnW+ZOvuDCisA1ZIJFWEf0F9ErtKWkqJtTtKllAH35TKQeDeKCODVU/GUNaG7Ya
	UANRbe8sEx3HMsISm0RkJHaN69wVUO3nQFa/2PgLsSEqzjGM/gNymQKKkZdVfzDCdmINxY
	Gls9v4QEqRN8z5507i6wx1FFC1Qq8fE=
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-176-Od9tb2lQOYqHw6ZgqTzJ1g-1; Tue, 28 Oct 2025 10:58:03 -0400
X-MC-Unique: Od9tb2lQOYqHw6ZgqTzJ1g-1
X-Mimecast-MFC-AGG-ID: Od9tb2lQOYqHw6ZgqTzJ1g_1761663483
Received: by mail-yx1-f69.google.com with SMTP id 956f58d0204a3-63e29ad5503so7153221d50.2
        for <virtualization@lists.linux.dev>; Tue, 28 Oct 2025 07:58:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761663483; x=1762268283;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8N/CyB3BhR9BzfFuw9y8Z5rJf3YG4p6pIZG96vMy1go=;
        b=Doz/UW0jOzS0Mc4kYvjFmIb2JtFRNdy4CYeHGYlHCgeUNJuOPQH/qUdXRbnCqEU034
         Q6bcr8mDrcEfEQprzRZtuaBg98mCoNgk84eSX20lyKqUjYXNoONBTKSGi0qO3SmGsqQH
         mCNnm6Egz7qptE4h9YD52CMnlkCyRzGgf92MTMsUQP60lTxzeOWaFVdUPskrQh6151vG
         QVjOC951aFRrcU5RRh3ugjtpHNYJwSPHmDX/XCkhGErVBc1PRiDqpD8tCqOS/74aH0Gq
         fw53ekynTI5D9Rde2AAyy5uCIS7rbyO8h8amvKYMUXd3dascftHM4G2EPdgrraW2XdM6
         apZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqBzO602TUJbOhX37EgpXF0DP0/hzcQR0aycHNW6mohIqrGbKF4jdgUXFe6ZYdGA1Mn9SUuVczGOYB/U3YHA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxx1FPYRf66t0ogsbPnCWHwMteu3aGPeH1Cdh3Hi3COWSGAs/+S
	SsXEvlTym0WWChAnU8ykVFKjCTHMx97pXCHB6I3xEN6iMaOcmgN5wdEhSADRRRxmEJMvoj/e1Wh
	ugzusekUtQmIvAPa5uW2BoQdtkOQ8BGms1zrrd1VHXjEU/VJfQNH5ddcsGdJW6K9MTWes0NlHKh
	WJkHlT4oNLyz6Q6e/qqHXV+GGzrz/4ERT8+Yko5XqcEYo=
X-Gm-Gg: ASbGncvkRb60kqgmGg4DtzGID1qfP6nwQmu634FyCvh4dBdOOh/jrzIsYhLL/1+7Zc2
	zBbjIPqln/xbWhfeCwokiBO55XuEOqDd7T+nQ94QSlP6Iu9yFNNNrXKq9nfk4BDTtnMsyHqLmrz
	qKmDKee94U3i6igPWNNocKTDvGwN42Jib6YZQY5mr1bdG9W+hMUpepUZKtRG4UHw9ZgFbPLDZyW
	aGSpVvVbtwYe4tk7sCWeC0KbcEq7K0gma7U47IxVY8=
X-Received: by 2002:a53:acd4:0:20b0:63c:f5a6:f2ea with SMTP id 956f58d0204a3-63f6bab5397mr2747730d50.60.1761663482892;
        Tue, 28 Oct 2025 07:58:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/WTYIQ7xXhGVCT8HcoFOlFNGW08q+9o43hTP9kcxsycKYCEMDq54qPBeanzA+lWFpmCWYMaATbs7BaCevFQk=
X-Received: by 2002:a53:acd4:0:20b0:63c:f5a6:f2ea with SMTP id
 956f58d0204a3-63f6bab5397mr2747678d50.60.1761663481676; Tue, 28 Oct 2025
 07:58:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAJaqyWfRmhXM8eV+=wMVKgrc8SJ98OTtBCtNDJj8ZRUM5Y9Nmg@mail.gmail.com>
 <CAO55csx2rbjxEZk5K3aKcZ501KY3Zfs8ThEQHFqQ1ZB9RSXECA@mail.gmail.com>
 <20251015040722-mutt-send-email-mst@kernel.org> <CAJaqyWcf3tz17q6G=123Xb+warf8Ckg=PLaPkzLU9hYHiUy9Zg@mail.gmail.com>
 <20251022060748-mutt-send-email-mst@kernel.org> <CAJaqyWdRN3C1nOHQjWroBPWKjc5efNfVbecpruL=Cgsk6i1FXg@mail.gmail.com>
 <20251022073231-mutt-send-email-mst@kernel.org> <CAJaqyWeDcyKKOvVdqUkpTuH3d-Tb9rBHG3ym+LC0fcmhrN_FJA@mail.gmail.com>
 <20251028100923-mutt-send-email-mst@kernel.org> <CAJaqyWePMtM8vtgm8UnGAv+_XNTnVNFSNuoqzt_Cn-CpZg46mA@mail.gmail.com>
 <20251028104154-mutt-send-email-mst@kernel.org>
In-Reply-To: <20251028104154-mutt-send-email-mst@kernel.org>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 28 Oct 2025 15:57:25 +0100
X-Gm-Features: AWmQ_blFtkQy1FAJaebTbyFFQKUNvmY_l68PG6mENUqg3UT3GDXoN0f29IuNmmk
Message-ID: <CAJaqyWc=Fhp2+m8P6cctkqG+oeXUgiGhKAsR5Ns20JMun=wvbQ@mail.gmail.com>
Subject: Re: [RFC 1/2] virtio_net: timeout control virtqueue commands
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Maxime Coquelin <mcoqueli@redhat.com>, Yongji Xie <xieyongji@bytedance.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Dragos Tatulea DE <dtatulea@nvidia.com>, jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: JfomGnYWeyftzMM8YCUTIiF9FBA6KWX3IuyoCFgYk5Q_1761663483
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 3:42=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Tue, Oct 28, 2025 at 03:37:09PM +0100, Eugenio Perez Martin wrote:
> > On Tue, Oct 28, 2025 at 3:10=E2=80=AFPM Michael S. Tsirkin <mst@redhat.=
com> wrote:
> > >
> > > On Wed, Oct 22, 2025 at 02:55:18PM +0200, Eugenio Perez Martin wrote:
> > > > On Wed, Oct 22, 2025 at 1:43=E2=80=AFPM Michael S. Tsirkin <mst@red=
hat.com> wrote:
> > > > >
> > > > > On Wed, Oct 22, 2025 at 12:50:53PM +0200, Eugenio Perez Martin wr=
ote:
> > > > > > Let me switch to MQ as I think it illustrates the point better.
> > > > > >
> > > > > > IIUC the workflow:
> > > > > > a) virtio-net sends MQ_VQ_PAIRS_SET 2 to the device
> > > > > > b) VDUSE CVQ sends ok to the virtio-net driver
> > > > > > c) VDUSE CVQ sends the command to the VDUSE device
> > > > > > d) Now the virtio-net driver sends virtio-net sends MQ_VQ_PAIRS=
_SET 1
> > > > > > e) VDUSE CVQ sends ok to the virtio-net driver
> > > > > >
> > > > > > The device didn't process the MQ_VQ_PAIRS_SET 1 command at this=
 point,
> > > > > > so it potentially uses the second rx queue. But, by the standar=
d:
> > > > > >
> > > > > > The device MUST NOT queue packets on receive queues greater tha=
n
> > > > > > virtqueue_pairs once it has placed the VIRTIO_NET_CTRL_MQ_VQ_PA=
IRS_SET
> > > > > > command in a used buffer.
> > > > > >
> > > > > > So the driver does not expect rx buffers on that queue at all. =
From
> > > > > > the driver's POV, the device is invalid, and it could mark it a=
s
> > > > > > broken.
> > > > >
> > > > > ok intresting. Note that if userspace processes vqs it should pro=
cess
> > > > > cvq too. I don't know what to do in this case yet, I'm going on
> > > > > vacation, let me ponder this a bit.
> > > > >
> > > >
> > > > Sure.
> > >
> > > So let me ask you this, how are you going to handle device reset?
> > > Same issue, it seems to me.
> > >
> >
> > Well my proposal is to mark it as broken so it needs to be reset
> > manually.
>
>
> Heh but guest assumes after reset device does not poke at guest
> memory, and will free up and reuse that memory.
> If userspace still pokes at it -> plus plus ungood.
>

I don't get this part. Once the device is reset, the device should not
poke at guest memory (unless it is malicious or similar). Why would it
do it?

