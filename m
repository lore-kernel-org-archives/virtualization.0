Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B241A3165
	for <virtualization@lists.linux.dev>; Thu, 23 Oct 2025 02:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761186874; cv=none; b=OuPiRu4YJ0ixTDRapwdQxSe46strpTdCw+1NgL8lV/NpkcVqGb9vFsr2gmobwX1ZNmz2zAeB2xkDBmggSgRicThlmTJaq924/7fcJjI+5rFB5kssGrBkgC8TeUKqSvtcZdGvy9rMt18cEegxRvkOxh5S6eI90pAOx5/vopFSaN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761186874; c=relaxed/simple;
	bh=UPgMT5fUwOmL4sgXDbAdAVMYFSfqHSRIuxPtgMjpYXM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XALw50ZUzpfOxTTyLWt9NDaiqEOaeTEgsVMClfF8J811cnhjCl/YgNi16u6Yn/sQLrKyNJterp+F7A/RKKhBjInYJJnUpClX0PQppgpqCgHH5i6fxKYYuad8+dVqMOuXl4o4ezKFDXPyYwt8aLGdn1RZbvG+lieMI99IUVRhZxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=bpHgWN0z; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="bpHgWN0z"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-292322d10feso2503915ad.0
        for <virtualization@lists.linux.dev>; Wed, 22 Oct 2025 19:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1761186872; x=1761791672; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UPgMT5fUwOmL4sgXDbAdAVMYFSfqHSRIuxPtgMjpYXM=;
        b=bpHgWN0zw/NhTOHnyujBz+TgOSWI6X6yBVEZsK1TDbQnHTqCKGdum/9HsbkumnLLEI
         sxyga/ShqU/L1NbkI9AMpX5rupdE8KvaRXicGzbBvEJZaUFJMXXDDmz/IEUamaBBOM/4
         jBX+P4gEH9dlLHQQMXrEBb3jGoynjxKv3DUrAujlYQOiNkOeKgBMt7rzfGV9v7+Gjnnj
         SuNoDd0J1BzNpDo4d9Wg/cMXL5p/d8GeCxSXvmEnRTJj8YL8EvOkls9QkfofCWATj0Pl
         XV4fFkta4UAX5ggV+d4wp8ZqrcsmumZjBYmupgu1f+m3nZOPtoaQtF+acyp33ZFiMI3j
         q3Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761186872; x=1761791672;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UPgMT5fUwOmL4sgXDbAdAVMYFSfqHSRIuxPtgMjpYXM=;
        b=abiAadJWxMflzJ+qtSxzrXqrbmvgZr81d/3DjJdln0UYyOLKGPo4dL5ySIFqZPtFE6
         SHYMtkioPNpwC3VdOogg1rCFhnWnrqYLmf9KU/5fqP8HE/ytfnIuQA54b/edWNZrfDQC
         vK+GU/WWLyoIZVPpNsxlk30+hcfXg4z3zi4i5qs3oV+P6ZBnGru4y6l6NytRlWQG2RsO
         GuyBEAgLhIiUhm1TcRTp84q13hxoCN+MRI4eZL/I5Y04yNd4qPm1Z5BsyAWRaEkyOi4/
         l2lq7iAVKJ4ZKnXUDEf/q9GMOYYpffDzwMUxT5MtQqQak9wKGJ2rdpYL9JM7Lo4KyDs7
         Yp4w==
X-Forwarded-Encrypted: i=1; AJvYcCWnPF0sp1UgeeObV2TEbEavKoILhn3o+jov5+ETo0YS2NuWmbYweE1piD5CuEy7XnsaPoKc01A2h2wkObWg5A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxpos4V8Ubugq2FI8/BbToLIZZ9jgLabaaPNEKOa831pBk11JvQ
	OREi8yg7QLuH6DBsF1+SbRc7P0Dlt0bjVuiG3XEXvBWuQV/UwpsMUeqFZV16j+WdcKdT75h/pv1
	EGeNFE14W2yz7EsrLHH2g0w3Up40E2kAeROBAPGoIQA==
X-Gm-Gg: ASbGnctMb26/Ffs1vcTRviI6RDimiVh3QiqFogUGsi3DzEGmZkuckozHqIn8MBzr5ha
	8bb13MPuGaj2AHMK+QghKE0jbJz6kddE95TaUdzIrJLhKLCBFfAs/GSJ1aplAnWdrMflNe7u5XU
	xGiMXQJHp8rqvZQgvf2Cson82nu8gustpQyBd4Jt6XQRBeTPxFM5JKSiLLQI95hetz4OHffNzB/
	+I3RPQscOuAy6aaXzw56F8OOqVoReIXtq4nFWjS8TueWiH2QgqsCA9wbFKwtXKLH9ED+5as5x88
	2w==
X-Google-Smtp-Source: AGHT+IHGpQifOUabQY8FejQjy8n/4nAg/aduFF+Sh7nUDVl0gOlgObgBO6vnO+raGR+BtZBHJIFRQGpSM43TyEU8Zk8=
X-Received: by 2002:a17:902:e78c:b0:265:f460:ab26 with SMTP id
 d9443c01a7336-2935dff6505mr45358265ad.3.1761186872055; Wed, 22 Oct 2025
 19:34:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAP4dvsfZEo+1+O8tpLFFh=s-fEFaMRu2+mQ3F=LJmjoEHyZXMw@mail.gmail.com>
 <20251022073015-mutt-send-email-mst@kernel.org>
In-Reply-To: <20251022073015-mutt-send-email-mst@kernel.org>
From: Zhang Tianci <zhangtianci.1997@bytedance.com>
Date: Thu, 23 Oct 2025 10:34:20 +0800
X-Gm-Features: AS18NWB6WD4OS8XXZ-GHq97r6as6tdIAmOiC0-ZTqAO2YoRLqkcTHye0-K0I5dw
Message-ID: <CAP4dvsfXs7Do=9d_05tzU5FUuqfLnsFSpodSMDhv=FR2KYWh=w@mail.gmail.com>
Subject: Re: [External] Re: virtio_pci: Question about virtio_pci kernel
 module refcnt
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, xieyongji@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, thank you for your reply, but I still have a few questions:

On Wed, Oct 22, 2025 at 7:31=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Wed, Oct 22, 2025 at 07:21:45PM +0800, Zhang Tianci wrote:
> > Hi,
> > I noticed that the reference count of the virtio_pci kernel module
> > in the VM is always 0, even though there are at least two
> > virtio block devices and one virtiofs device in the VM.
> >
> > Using rmmod virtio_pci can unload the virtio_pci module,
> > but this renders the virtio block devices unusable.
>
> it removes them. you can put it back in and you will
> get devices again.

But I can't do it anymore because the rootfs is no longer available,
or rather, the OS is no longer available.

>
> > I wonder if this result is expected? Why don't the virtio block devices
> > and virtiofs device hold a reference count to the virtio_pci kernel mod=
ule?
>
> because they don't have to.

Is it due to design reasons or implementation reasons?
Is it because the semantics of kernel module refcnt does not include such
logical dependency?

Thanks,
Tianci
