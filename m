Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B797842A82
	for <virtualization@lists.linux.dev>; Fri, 18 Jul 2025 08:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752828859; cv=none; b=N6lT6PMCIbRAuxr+vBBm32ED86tEWkW0uQPCodOWRSfeHEvnUjgiywH3f9P5MItj56EajWLYf2oYQd3mm+jI3SfrgcpaffqQz+bfiLQf2mCsncnwiK7apA8RFDf1z5AIYrqgBC8bNxY03KZYig4lpORcWL15VP8E9ilB0Hz/19I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752828859; c=relaxed/simple;
	bh=bj7mhCQVuJ185XdA9bUAEZIDIu0u60fDwm8/23Hzgyw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PtbkChpOuQRqswMIuhbQMUoOkHaTuq+LtY4W4Q4+HzQ/zT0pKjqdBHacL+yLZSXIMxZ9oYy/Huwq2Z0rTFW9yTZ+HEALzG1eOGDvSp0cZbWVRQJTTufYXSknjnC1a9v/mLQZLpvGz4Tp0bugevv0Z606Ity/McPvfY8JaGFDEHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ErMJ0s2L; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ErMJ0s2L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752828856;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bj7mhCQVuJ185XdA9bUAEZIDIu0u60fDwm8/23Hzgyw=;
	b=ErMJ0s2LkJFE7fupYALZ2+CNuhK74ugyOu73CwZh0FYtkB8PZQ3Sc2mMcCF+SuTRkBsGl9
	P7x+nW+xPyAgANTbs6/YDyjpjAKHc3vPZbkPsx0CYghbqVwN2hc1y8FpmeVLo3k4eSViKW
	7QpoTjnVgY58IrlN5x2BQzveO2IQEwI=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-32-QM2Wg-kCP-qkLP-rWJCafA-1; Fri, 18 Jul 2025 04:54:15 -0400
X-MC-Unique: QM2Wg-kCP-qkLP-rWJCafA-1
X-Mimecast-MFC-AGG-ID: QM2Wg-kCP-qkLP-rWJCafA_1752828854
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-31cb5cc3edcso1319572a91.0
        for <virtualization@lists.linux.dev>; Fri, 18 Jul 2025 01:54:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752828854; x=1753433654;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bj7mhCQVuJ185XdA9bUAEZIDIu0u60fDwm8/23Hzgyw=;
        b=sfHHkqIBnf/O26YG1ukzf89mrM3EUgATO+hzxNw5flkTqsL854F30MGzaXV+48fvJF
         rbUCOpqsrKzgFinQYEsaX1JOhDry5bTmWe3jQR/EZRgACJ8m37yow06JYCkAnfc4f/np
         eipIVEZ5ACpAjY1xNvjywRxKPL5OW8HXpz9cyYsARMYLSMU5ROGQA4ovbQA7lIVNKAXD
         C8ZNerKVncJ8LyN7PH9HxFncRRociQWhXMyR9tQVzDKMqC+S4VAocDvv/RPGqildzHCZ
         FshRIC/bRq8sQKPqiGUU/Sb5UUaKIBl0mhvYb259IsQESIdS1kYDer49ioytqjVEUynS
         BsXA==
X-Forwarded-Encrypted: i=1; AJvYcCU2PZwnH3/1GBLnF6LO4jLr6Vy0jlaDrPQPpvpLcfyJfwY502iWDdwEOpJgkK9EQqincrrRLhw23DjX6dPkNw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw16zov2V/Bf49PdsdhS+b1MZrJPY9V+ijMxu0rscQAHIRnuC2m
	DzLzWLQ5mAT4VNAuepB29ZD4ER+/PmnywcfUrwe3S48mdKll+3QlTxbGd6w/ECRVdka9f/My642
	kc4tEHPiVWzB2ir7rSbVv028NXv/0CuCpZQwIjWfSsbjKm212tB306VwwbKeZPcNSWWWENniOaW
	hL7Mm9Od/p0M9XRGgz4TeCsv9ELF55Zc7PNDVRheYdSX4=
X-Gm-Gg: ASbGncuFFWlPMJN+fjS4By/yDiypWayybC8q48bSlvNJszC6CvP4tD1j89vEU5GHwT7
	xB1Ugu8htBETA+eIjPo2wjMUpndaEFJ9P/3KiDRCa4mOOXvsdLSbo/lsZexI3CFBHatYbXlgghp
	Gc5yxaHfZcsLWutitIQcsq6A==
X-Received: by 2002:a17:90b:1652:b0:313:15fe:4c13 with SMTP id 98e67ed59e1d1-31c9f44782bmr14021423a91.27.1752828854286;
        Fri, 18 Jul 2025 01:54:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFj/s4ceeQLzmg7ceGYcbAXQbz4AgoZUrjYTkOmnnd8D1asIpvNFh92Ec33a1Wq5wF74xMv0jBGuemuD7Y49oA=
X-Received: by 2002:a17:90b:1652:b0:313:15fe:4c13 with SMTP id
 98e67ed59e1d1-31c9f44782bmr14021395a91.27.1752828853915; Fri, 18 Jul 2025
 01:54:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250718023758.36866-1-jasowang@redhat.com> <CACGkMEsPPxVB5mgcT4=6xL5trBHn33_P1pqxgti-4FSqdYZ5vQ@mail.gmail.com>
 <20250718044839-mutt-send-email-mst@kernel.org> <CACGkMEsggdeW3rVTS5Z7Zi3yMC9GCQBGAjQKEDG_aaissap7YA@mail.gmail.com>
In-Reply-To: <CACGkMEsggdeW3rVTS5Z7Zi3yMC9GCQBGAjQKEDG_aaissap7YA@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 18 Jul 2025 16:54:01 +0800
X-Gm-Features: Ac12FXzLzXStqQPOGshWiItDedCU5jWdVtUTwJg3zbrPtIIoUzvT8tnWfv6ftiM
Message-ID: <CACGkMEv1EPCs0tp5mAxtnS=UtfMNMZdj2xKMuBe+o_jR0-8Bgg@mail.gmail.com>
Subject: Re: [PATCH V3 0/9] Refine virtio mapping API
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, hch@infradead.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ev8KTScaAmShWnA4l5tTo2ZmRTF4r7oeDs6WG1p9r4k_1752828854
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 18, 2025 at 4:53=E2=80=AFPM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Fri, Jul 18, 2025 at 4:49=E2=80=AFPM Michael S. Tsirkin <mst@redhat.co=
m> wrote:
> >
> > On Fri, Jul 18, 2025 at 12:23:49PM +0800, Jason Wang wrote:
> > > On Fri, Jul 18, 2025 at 10:38=E2=80=AFAM Jason Wang <jasowang@redhat.=
com> wrote:
> > > >
> > > > Hi all:
> > > >
> > > > Virtio used to be coupled with DMA API. This works fine for the dev=
ice
> > > > that do real DMA but not the others. For example, VDUSE nees to cra=
ft
> > > > with DMA API in order to let the virtio-vdpa driver to work.
> > > >
> > > > This series tries to solve this issue by introducing the mapping AP=
I
> > > > in the virtio core. So transport like vDPA can implement their own
> > > > mapping logic without the need to hack with DMA API. The mapping AP=
I
> > > > are abstracted with a new map operations in order to be re-used by
> > > > transprot or device. So device like VDUSE can implement its own
> > > > mapping loigc.
> > > >
> > > > For device that uses DMA (for example PCI device), the virtio core
> > > > will still call DMA API directly without the need of implementing m=
ap
> > > > ops per device/transport.
> > > >
> > > > Please review.
> > > >
> > > > Changes since V2:
> > > >
> > > > - Drop VDUSE dependenct for HAS_DMA and ARCH_HAS_DMA_OPS
> > >
> > > I just realized V2 has been merged. So I will post an independent
> > > patch to do this on top.
> > >
> > > Thanks
> >
> > Dropped for now. Posted a comment though. does v3 fix the build failure
> > in linux-next?
> >
>
> I didn't find the report, maybe you can give me a pointer?
>
> Thanks

Just saw that. Let me fix it.

Thanks

