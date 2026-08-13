Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1B8390CB5
	for <virtualization@lists.linux.dev>; Thu, 13 Aug 2026 17:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786642431; cv=pass; b=SNV9MRQ3vQlLxZixXRdpIFsdzjX003YCZXPLx0+W2oheZK3BKw4ZZmeLEt2sHG/uF1o0DqvEVJavN4QFoMym9XeIihpaiWwqG/DG6JxuO8AuyflwMj91l/Gtn+OjhMUH60bsI7Y//vobyE/Nf2y3bX2Ylj9AJsQWDcfd0npV+MM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786642431; c=relaxed/simple;
	bh=f0QTPF6PHLF05RDbZdSQp/xiTjyiavs1MEL0B/a/ynY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cUJ4/O82Ls6H2VGff8qdrR3FlJZDGxcmC6BhyuaXrRkf3XCEvA3RnUNVvEBwoQXMkkEB8Shl22CJCRoBhTVeGV5SOA7mC1GNPlVu0m2GBfPbfoi5+r9xuYcjjRIaIwkQAqRFDe+VJcl0u3kRKdtWsCod02Enbuhy31AEz8fSfs4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JtobyG5y; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JtobyG5y"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6a0a4a18180so96257a12.0
        for <virtualization@lists.linux.dev>; Thu, 13 Aug 2026 10:33:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786642428; cv=none;
        d=google.com; s=arc-20260327;
        b=TBu50Kki2FhBctg+TvVN1PX0J0/q08PiUOjz8oiyqev62XEu1w35jOzTYLEkQ9OeJs
         iDR2YDcLhLr7bqrnGUNsSB1ovoygE83dM/ZubK42eZO+DKqIChtdH/ob62sFHcfM8rC5
         v22wXqhHgFquKx4CveoSebBXFHnDFCze5Yr3NSACpBd/sXtmqLz8NjwEWk5HYc9EOPMU
         UPmBqmVmI4ACbCKHzmXoOTjTK40h/A4GgiMxgdZsZcscuyD2oLmSX3ohsjjg/LvGKx8B
         2qVaKC1tF3ERc+7pwTRigFfH/dRnByU+qBHzi8Dypcq5mIqDsrdt7HZR+vD4o9p4JsNh
         07Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2SD9tGatxRoeulnEKbLh7noWfKSB5zRkdjmqp0VjZ64=;
        fh=dZFvwj9XAShdAMaQW/YPiQY+HFFJOltCGWpLrx/Rmsk=;
        b=pXhvFZsNgKl57gv7xxD+kPUt9MC6NL2eToFk7XZF8HQE3+6+CqYmQhdtnjCKUpT4hV
         djuSbrpT4I462CwVm/UYr2EXOqhhpBZv6FCAPPBCB1K9/Q9vm33v+/ac4tA53q6XHJpu
         1j4oIAaqDlHpp/2PsgOX1cG7huGnT5SkoG6wdthS8Aj+h7IQdGI5lElRW5DYc7jxyHix
         xqYZVuWzKgAjZqCSUOgR5dSaoYMPqb2zuI1CFVS95OcHz+zyrR584AUyzK6HO02Jg4W4
         aCxqNjV8EgCyOR0UtflwW0eUZAZmLVinWgIgGiO2nMQoRvYdtGuH4/vatsDwO+b+YoNR
         6txQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786642428; x=1787247228; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2SD9tGatxRoeulnEKbLh7noWfKSB5zRkdjmqp0VjZ64=;
        b=JtobyG5yI9S/PVpXX4Sz4q5/wBPqy5s+ZwhWE7dah7rawvCcDQWTxeTzERYtB24nbC
         5nQ8bq5ihDtK8tYPpcx0DJffVlMJIsGa8GUIAougK3nmFAuJtUzlCoW+mnsevT5sseE1
         dMjg3uKDb5qYEBQt3KZAc49mnp5ZrNGtkud/jklCIdSW9UUQyeFbsopK9iy6Cu42p5rd
         EWkK6d2jihzuZ9Z2M2J4LWt/jOYh4+d5tIrK/Fi3fthYAHtbyLxRQRsgyVspHVVex9If
         rdoA0ycLsFJvaEktz5w+TzryubNKxnaeUr23gTIKtbvNNAxfQh/Mm5UpL4tWE7t2C6Ec
         +WYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786642428; x=1787247228;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2SD9tGatxRoeulnEKbLh7noWfKSB5zRkdjmqp0VjZ64=;
        b=rObmrRXx0LOkBSvzePhvQVqwQI4Fk5suwP50B2nSKDlRG3vbUnmRazpVft3oDMTOC7
         AuQ9Bgz8J9VPO2qX9WwWBzKBJkZW6ay6PZ4tuM6nEzI7RM23+lR+cr0dKrcvcYRh6ZNh
         jfMNKPjiH4VXJ5l5bRVWHIrjKtkwz/QZEvp3AFlHdg8QM3AOup5sM0aZ9LbIBqmQrBQt
         DTYbmUk4uBMKMfHh+OwChbVasm+Jj7JFx8gBxLJDTXu9VIAu1lbRDq7EaCeqaWOBX0+9
         OsNZBkRSI1RhzQymOg+nZnU48Tzbyf32YvyAnB+6amGRpCWYqpNtTtswri59tFNjclye
         XTfg==
X-Forwarded-Encrypted: i=1; AHgh+RqCJfJLznBxoikU8gqcOKlS9fQsclZ5qKyADIy0MFw7YC645Sph+iWQeixX3h3+QOQhUfnCW+XtPpgHHA4Org==@lists.linux.dev
X-Gm-Message-State: AOJu0YysWxZqthIFYqwZw1jVo4JVLaA20rD6Lj8BzpTFx0asae7/s3QW
	2uFxPogC4i0JfKYEoRpC4UTiCnszSk2sZC22AzFI/J+6q1W9Yje4jEta4eN7BCXtYQ6bRIWVJ3T
	iRRMIP1pV1QPArVVp1lYLhKCN417Byp0=
X-Gm-Gg: AR+sD1041w2cMJIm51uAIpFaRvDo+LMpwqgolEx+OhZ8oI+gfyAp/lHOpylZdHien15
	cuDyGcXjNefuhob5hvONfDkmj9UXTmBf4KuLTj6F3XjFK6tNK57eI8DmzVJal45h2wM8QB3s4el
	RWN1shlPSIgdR/e8FRxyID5EsHSZqs+q6rdLSDEl3zAlY292HTPKuFsLwvmjOWJVFyHzwnupdeb
	i5V1+KwTz6YCU1XimOwwKbCsKKkil2WFDsNOZDZG+sZRCNld7V1m8EZTH+XdM9SNUahhI3NgX4l
	i9DZm/8DUHnegoUUEvwyTnfku+NUQaMbdQg3U9Tzjl3b9OgGkS5fV9MKtJDAsdlNEyJJzdmMbkh
	KNmhd83F2nVoW
X-Received: by 2002:a05:6402:5307:b0:699:12e8:1c54 with SMTP id
 4fb4d7f45d1cf-6a38a8f46abmr79181a12.5.1786642427980; Thu, 13 Aug 2026
 10:33:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <am2QeS/lS+Cova+I@yokbvdiprd370.nvidia.com> <CAJSP0QVSBsg0_pCaxy8Sar3=G+sdj5Z8R5yNmUomGy+C5YrHJQ@mail.gmail.com>
 <anP0FimfttCpDMKW@yokbvdiprd370.nvidia.com> <CAJSP0QV1=SUYFy3XKe8tWeore3EVQEjN7EWfLZ8QLm8qY4rEtg@mail.gmail.com>
 <anvZfVak5FVjuJSZ@yokbvdiprd370.nvidia.com>
In-Reply-To: <anvZfVak5FVjuJSZ@yokbvdiprd370.nvidia.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 13 Aug 2026 13:33:35 -0400
X-Gm-Features: AUfX_mxmoX4cfVzXFEtc4deBuzEHP7_6wcL5dzV3vWmRKSdr_-a38wdsvFj86bg
Message-ID: <CAJSP0QU0Ys6Kb+hbftW1CaWT9pyZ31VzUJfTYmVZGqHGubgsXw@mail.gmail.com>
Subject: Re: [PATCH] virtio_blk: add use_irq_affinity module parameter
To: "Liu, Changcheng" <jerrliu@nvidia.com>
Cc: pbonzini@redhat.com, virtualization@lists.linux.dev, 
	changcheng.liu@aliyun.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2026 at 10:25=E2=80=AFPM Liu, Changcheng <jerrliu@nvidia.co=
m> wrote:
>
> On Tue, Aug 11, 2026 at 10:37:28AM -0400, Stefan Hajnoczi wrote:
> > External email: Use caution opening links or attachments
> >
> >
> > On Wed, Aug 5, 2026 at 10:40=E2=80=AFPM Liu, Changcheng <jerrliu@nvidia=
.com> wrote:
> > >
> > > On Wed, Aug 05, 2026 at 01:45:58PM -0400, Stefan Hajnoczi wrote:
> > > >
> > > > On Sat, Aug 1, 2026 at 2:21=E2=80=AFAM Liu, Changcheng <jerrliu@nvi=
dia.com> wrote:
> > > > >
> > > > > When creating many virtio-blk devices, probe starts failing with
> > > > > -ENOSPC (-28) because the system runs out of interrupt vectors:
> > > > >
> > > > >   virtio_blk virtioNNN: probe with driver virtio_blk failed with =
error -28
> > > > >
> > > > > By default virtio-blk uses managed IRQ affinity, which reserves a=
n
> > > > > interrupt vector on every CPU for each device (about nr_cpus vect=
ors per
> > > > > device). On a host with many CPUs and many devices this exhausts =
the
> > > > > vectors long before all devices are probed.
> > > > >
> > > > > Add use_irq_affinity (default true, no behaviour change). Set it =
to 0 to
> > > > > use unmanaged interrupts, so each device only uses a couple of ve=
ctors
> > > > > instead of one per CPU, allowing far more devices to probe.
> > > > >
> > > > > Signed-off-by: Liu, Changcheng <jerrliu@nvidia.com>
> > > >
> > > > There is already a num_request_queues module parameter for cases wh=
ere
> > > > the user wishes to reduce the number of virtqueues. Did you benchma=
rk
> > > > that and decide the performance of many queues sharing a single irq
> > > > makes it worth adding another module parameter?
> > > >
> > > > Stefan
> > >
> > > num_request_queues does not address this case because each virtio-blk=
 device
> > > already has only one request virtqueue when the failure occurs, so th=
e queue
> > > count cannot be reduced further.
> >
> > Okay.
> >
> > > The issue is reproduced after probing approximately 800 virtio-blk de=
vices on
> > > a 64-core bare-metal host. With managed IRQ affinity, the IRQ-vector =
reservations
> > > are eventually exhausted and probing additional devices fails with -E=
NOSPC.
> > > Disabling managed IRQ affinity avoids these per-CPU vector reservatio=
ns and
> > > allows more devices to be probed successfully.
> >
> > I don't follow. My understanding was that non-managed IRQ vectors are
> > allocated by request_irq(), which is called during virtio_find_vqs().
> > Probing 800 devices would still require 800 * (1 virtqueue irq + 1
> > config change irq) =3D 1,600 vectors. How come non-managed IRQs do not
> > hit the limit here?
> >
> > Thanks,
> > Stefan
> >
>
> With one request queue, virtio-blk allocates two MSI-X interrupts: an
> unmanaged configuration interrupt and a managed request-queue interrupt.
>
> The request-queue interrupt's managed affinity mask covers all possible
> CPUs. On x86, irq_matrix_reserve_managed() reserves one vector slot on
> every CPU in that mask so the interrupt can migrate safely during CPU
> hotplug. Consequently, every virtio-blk device consumes one managed
> vector slot on every CPU for its lifetime.
>
> Once any CPU exhausts its roughly 200 usable vector slots, managed vector
> allocation fails even if other CPUs still have capacity. virtio-pci then
> falls back to its shared-vector MSI-X allocation, for which the affinity
> descriptor is discarded and the interrupts are unmanaged. Allocation can
> continue using capacity on the other CPUs, explaining the observed limit
> of approximately 800 devices.
>
> When managed affinity is disabled, both interrupts are activated on
> individual CPUs and distributed by the vector allocator. APIC vector
> numbers are per-CPU, so the same vector number can be reused on different
> CPUs. On a 64-CPU system, 800 devices therefore consume approximately
> 800 * 2 / 64 =3D 25 vector slots per CPU.

Hi Changcheng,
Thanks for the explanation. Can you update the commit message to
mention that non-managed irqs stay below the limit (800 * 2 / 64 =3D 25
vector slots per CPU) because they are allocated to the CPU with the
lowest number by the vector allocator?

Other than that:
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
