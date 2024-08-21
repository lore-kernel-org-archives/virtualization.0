Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BEFD170A22
	for <virtualization@lists.linux.dev>; Wed, 21 Aug 2024 21:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724275873; cv=none; b=Ok49qxedAFLNaLdMp/VJxTK4yjv0NT5FfBhNuSobI2QQgtE1OlHX6czS9+ad8UFbgpfr/DF2jTPHT08wJnDbclQIf6gjdwJRJKXATH5KNlJyyPAwQfAJUtsmjz/XjgjB0IVLcjrSix7zr1UFOZzgex2pCF+siIYkfPAngfzXl8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724275873; c=relaxed/simple;
	bh=1HPbXZu26ylIr+VTL5kVcyFAqWx6XVIzYfT9vJGT7f0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iPXybKbb24EaSd3CoVwjBc6Es6piiWJM/bxEH5wkGpWc9B0iR9FAqzFydDyv3sbKkEUPfhCOXAHxKAZEySjUdGJjuarTF7OT9pVhSpm1w5015srSHB/LXNZjb8qGsl1P4gzRKWJtsnUroilRh2rnNiKRYcrLTZMMe2Dh9pBD0/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=P0ngnKqb; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="P0ngnKqb"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7a1df0a9281so11330185a.1
        for <virtualization@lists.linux.dev>; Wed, 21 Aug 2024 14:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724275871; x=1724880671; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uwfXYtq5H/Bwl31FSzM7tg0skZKB1oDTQ8t4Qt6Xu7Q=;
        b=P0ngnKqbREzeqF5f5dPDTfNILfVCCTOrjX2A+r9pF66dsXm2vUJ8lbhp0qKwSMVH26
         ziAE4ZokqEOJn3AFn2DuJCRB9N7frMansjbSVhSQ4xkw4a/RBk1ApP1x8SEFGDLP8RZJ
         M1brEI0C/5KXQkxHykEQNozNR6Tz0wnMsatM0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724275871; x=1724880671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uwfXYtq5H/Bwl31FSzM7tg0skZKB1oDTQ8t4Qt6Xu7Q=;
        b=Z0+AisL22AMWXAzwAwQFG01HiKS8tKxWsIkuJGe3pEB55xHI9irP0qi7EwICnWCIks
         yjAPZ/wkKNlLW/B7iHBseRtpwebRWTvex+uhfEhZGPAmzRw3YADe1KyjacVGWdCCwEt9
         QfTV3VfA+ANxz1kxiyd+PDljl4EoJnyblGDn2kT1rCgKG2fmU8zWCZSMZzcBXjTrubxJ
         aLdJPyCivvQEeng6GOn0At3R7cilwipgEvWJRqGCuxmbD5S35AZgPaQxLhuT6kQWyHjp
         8g7fVDA8rW9bz25ag29f40JzL1Pe2ttPJSAREX3qhnEPOiv9cuve0Tirr5f1qP1cIA4Z
         sxPg==
X-Forwarded-Encrypted: i=1; AJvYcCWj4Qvz3v4WHAIQYWJCJxRgIUZ46gvsX5zUMxIICRtOLxSKsG8bIetS4d3i1ESIC1ilbdJSHX2THr5puQmkSA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxbBGlJfauH4hR6P0w7Xn09/kSwtn/uD9i3FIV9UTR1q16UBwzP
	Ebh2Kn3gNIw+B0T1IvO5SbsicnY4qNigvGWOmHaBb1+Wxy22DODyzlqYjLCxkIQx1r2hcnzlSr6
	N+DCy9+L79byV6+/jNpqFrZuoWugp3j5cudUP
X-Google-Smtp-Source: AGHT+IF/2t26ymLl1453TNbuqayvZbqevzagzBm58wCHeO+njmSvYDXpCN0QjxbJ2OFbF/nJXJO4NU7h/01hnI5dBhI=
X-Received: by 2002:a05:6214:4185:b0:6b7:ab98:b8b4 with SMTP id
 6a1803df08f44-6c15688e06fmr41700066d6.48.1724275870748; Wed, 21 Aug 2024
 14:31:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240820172256.903251-1-philipchen@chromium.org>
 <46eacc01-7b23-4f83-af3c-8c5897e44c90@intel.com> <CA+cxXhnrg8vipY37siXRudRiwLKFuyJXizH9EUczFFnB6iwQAg@mail.gmail.com>
 <66c6501536e2e_1719d294b1@iweiny-mobl.notmuch>
In-Reply-To: <66c6501536e2e_1719d294b1@iweiny-mobl.notmuch>
From: Philip Chen <philipchen@chromium.org>
Date: Wed, 21 Aug 2024 14:30:59 -0700
Message-ID: <CA+cxXhnb2i5O7_BiOfKLth5Zwp5T62d6F6c39vnuT53cUkU_uw@mail.gmail.com>
Subject: Re: [PATCH v2] virtio_pmem: Check device status before requesting flush
To: Ira Weiny <ira.weiny@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>, 
	Dan Williams <dan.j.williams@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	virtualization@lists.linux.dev, nvdimm@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Wed, Aug 21, 2024 at 1:37=E2=80=AFPM Ira Weiny <ira.weiny@intel.com> wro=
te:
>
> Philip Chen wrote:
> > Hi,
> >
> > On Tue, Aug 20, 2024 at 1:01=E2=80=AFPM Dave Jiang <dave.jiang@intel.co=
m> wrote:
> > >
> > >
> > >
> > > On 8/20/24 10:22 AM, Philip Chen wrote:
> > > > If a pmem device is in a bad status, the driver side could wait for
> > > > host ack forever in virtio_pmem_flush(), causing the system to hang=
.
> > > >
> > > > So add a status check in the beginning of virtio_pmem_flush() to re=
turn
> > > > early if the device is not activated.
> > > >
> > > > Signed-off-by: Philip Chen <philipchen@chromium.org>
> > > > ---
> > > >
> > > > v2:
> > > > - Remove change id from the patch description
> > > > - Add more details to the patch description
> > > >
> > > >  drivers/nvdimm/nd_virtio.c | 9 +++++++++
> > > >  1 file changed, 9 insertions(+)
> > > >
> > > > diff --git a/drivers/nvdimm/nd_virtio.c b/drivers/nvdimm/nd_virtio.=
c
> > > > index 35c8fbbba10e..97addba06539 100644
> > > > --- a/drivers/nvdimm/nd_virtio.c
> > > > +++ b/drivers/nvdimm/nd_virtio.c
> > > > @@ -44,6 +44,15 @@ static int virtio_pmem_flush(struct nd_region *n=
d_region)
> > > >       unsigned long flags;
> > > >       int err, err1;
> > > >
> > > > +     /*
> > > > +      * Don't bother to submit the request to the device if the de=
vice is
> > > > +      * not acticated.
> > >
> > > s/acticated/activated/
> >
> > Thanks for the review.
> > I'll fix this typo in v3.
> >
> > In addition to this typo, does anyone have any other concerns?
>
> I'm not super familiar with the virtio-pmem workings and the needs reset
> flag is barely used.
>
> Did you actually experience this hang?  How was this found?  What is the
> user visible issue and how critical is it?

Yes, I experienced the problem when trying to enable hibernation for a VM.

In the typical hibernation flow, the kernel would try to:
(1) freeze the processes
(2) freeze the devices
(3) take a snapshot of the memory
(4) thaw the devices
(5) write the snapshot to the storage
(6) power off the system (or perform platform-specific action)

In my case, I see VMM fail to re-activate the virtio_pmem device in (4).
(And therefore the virtio_pmem device side sets VIRTIO_CONFIG_S_NEEDS_RESET=
.)
As a result, when the kernel tries to power off the virtio_pmem device
in (6), the system would hang in virtio_pmem_flush() if this patch is
not added.

To fix the root cause of this issue, I sent another patch to add
freeze/restore PM callbacks to the virtio_pmem driver:
https://lore.kernel.org/lkml/20240815004617.2325269-1-philipchen@chromium.o=
rg/
(Please also help review that patch.)

However, I think this patch is still helpful since the system
shouldn't hang in virtio_pmem_flush() regardless of the device state.

>
> Thanks,
> Ira
>
> >
> > >
> > > > +      */
> > > > +     if (vdev->config->get_status(vdev) & VIRTIO_CONFIG_S_NEEDS_RE=
SET) {
> > > > +             dev_info(&vdev->dev, "virtio pmem device needs a rese=
t\n");
> > > > +             return -EIO;
> > > > +     }
> > > > +
> > > >       might_sleep();
> > > >       req_data =3D kmalloc(sizeof(*req_data), GFP_KERNEL);
> > > >       if (!req_data)
>
>
